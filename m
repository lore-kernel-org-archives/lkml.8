Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3615EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99CF2071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BT0T0lbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIBJNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIBJNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:13:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C9BC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R+Dz6+yPeRJshWdLjlrkwrAzjAyFiHGgu5x76jfQzpw=; b=BT0T0lbWlsVoGNWFA+qVTj+sMy
        NKgB0jtxxZg/Iv9G8/u+lGT/D1H0ox+UKsg1BPqz5lXGm3pNZQJGCJ3r/lk7S3iPdMQilYBlOcH5u
        WUgRYswZUUuuzPnDg3E59Axflvv/lKD0zm3KOg+IspKVjeg0bgfxILX5ZAHfzt3q8OAR8dRduD9UH
        X6n3GCWbJU2idutlAJkXUCNTlJAq4LGdTA+kPNiN855SUEOeVUTKaAGoItp3e9+r61LC01E0d8PYn
        4+q30G8zxtiTd+VO0LKxXiQTMyWCh5u8NbL3BtIX2x/dIDNMtXIeGDh+WOvIUt2eflt36/GkhUQTi
        ocPsrxIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDOoz-0007Tm-5s; Wed, 02 Sep 2020 09:12:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95142304B92;
        Wed,  2 Sep 2020 11:12:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B877203C0A77; Wed,  2 Sep 2020 11:12:47 +0200 (CEST)
Date:   Wed, 2 Sep 2020 11:12:47 +0200
From:   peterz@infradead.org
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        davem@davemloft.net
Subject: Re: [PATCH v2 10/11] lockdep: Only trace IRQ edges
Message-ID: <20200902091247.GX35926@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.723775490@infradead.org>
 <20200902042137.GA163925@roeck-us.net>
 <20200902090935.GW1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902090935.GW1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:09:35AM +0200, peterz@infradead.org wrote:
> On Tue, Sep 01, 2020 at 09:21:37PM -0700, Guenter Roeck wrote:
> > [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4875 check_flags.part.39+0x280/0x2a0
> > [    0.000000] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> 
> > [    0.000000] [<00000000004cff18>] lock_acquire+0x218/0x4e0
> > [    0.000000] [<0000000000d740c8>] _raw_spin_lock+0x28/0x40
> > [    0.000000] [<00000000009870f4>] p1275_cmd_direct+0x14/0x60
> 
> Lol! yes, I can see that going side-ways... let me poke at that.

I suspect this will do.

diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index 889aa602f8d8..7cfe88e30b52 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -38,7 +38,7 @@ void p1275_cmd_direct(unsigned long *args)
 	unsigned long flags;

 	local_save_flags(flags);
-	local_irq_restore((unsigned long)PIL_NMI);
+	arch_local_irq_restore((unsigned long)PIL_NMI);
 	raw_spin_lock(&prom_entry_lock);

 	prom_world(1);

