Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A17C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B294F2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SHa+IiwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgETCRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETCRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:17:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843E4C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 19:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N7C43Aypkl4EuAArMN9J7yHFw5De5vjIxhJuuufeovY=; b=SHa+IiwXztgGsH7VEAQ0viqZge
        9VPm1sug2ZvRhSOglws8QaCocuXnMZg3uz5WQ6ephAnw+VfUf5lUOR7KxziTtmmLiqdhUhj7JMyxi
        jKAohwAngQgnj23Vg12wTw/zoukaNWtQhQ56Rk5E8TVVPyVAgnaHgVnv1n1CcNjLYIiLdmLxxTNdm
        11lZYQ+VWgrSerIddpCbdv0GNI2BjCYsBA36Q9AVCjY+KG/B4DsJndi7I+Fghujn7UEH0/U5p9hYi
        gZzi518dTeo/9Q4/JGPcJGnCbrVXyR2ttl7Aw6Ona4NFzWNJtxLgHN874ofPdqibSpjcfAXM4h9Ax
        VP3V43mw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbEIc-0004YP-8V; Wed, 20 May 2020 02:17:38 +0000
Date:   Tue, 19 May 2020 19:17:38 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/swap: Use local_lock for protection
Message-ID: <20200520021738.GC16070@bombadil.infradead.org>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-5-bigeasy@linutronix.de>
 <20200519165837.883035d3228c582b9bff1d77@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519165837.883035d3228c582b9bff1d77@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 04:58:37PM -0700, Andrew Morton wrote:
> On Tue, 19 May 2020 22:19:08 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > +				local_lock(swapvec_lock);
> 
> It's quite peculiar that these operations appear to be pass-by-value. 
> All other locking operations are pass-by-reference - spin_lock(&lock),
> not spin_lock(lock).  This is what the eye expects to see and it's
> simply more logical - calling code shouldn't have to "know" that the
> locking operations are implemented as cpp macros.  And we'd be in a
> mess if someone tried to convert these to real C functions.

The funny thing is that the documentation gets this right:

+The mapping of local_lock to spinlock_t on PREEMPT_RT kernels has a few
+implications. For example, on a non-PREEMPT_RT kernel the following code
+sequence works as expected::
+
+  local_lock_irq(&local_lock);
+  raw_spin_lock(&lock);

but apparently the implementation changed without the documentation matching.
