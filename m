Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7496CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC3E2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IiAut47R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404503AbgFXPTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:19:11 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBC6C061573;
        Wed, 24 Jun 2020 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OzpoSzSO3ZwwkTaaz+DbzEmnMWM/twLb1Ew9uO9Omg4=; b=IiAut47R5a9gS07Hg7ZrLDUswa
        MPDOrqrb35FNW7KA4s0pUdZ+xW7oaaLhOoeJiu9J+UTLn/Qj+ir5baR9VA7kEydjQwVr4EB3fZcl1
        UDWmBsrI+TkqD4KDiZAQKns4WXZ8EvOchOT2GpbdTro1j6tZQa9K4MwEydqHn12TfL+dOAUZbtzk6
        knDrzkV/e9M9xycx+wIfsS57Dwf6vaVxcQkDVYa96lmKIONLDVeVIGvZLcKENzqqTC7rZJHYnTbf3
        aKNMRDwBPvihLQrDIWqXFNrvsBzZsruACWqWCs1VrhRRLtKG9pkW8T7/p0yi5CvGJhUvk1loFIU9p
        +Q/nmH+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7AG-0003Sa-Sx; Wed, 24 Jun 2020 15:18:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97715301A7A;
        Wed, 24 Jun 2020 17:18:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CDC9203CDC50; Wed, 24 Jun 2020 17:18:14 +0200 (CEST)
Date:   Wed, 24 Jun 2020 17:18:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>, mingo@kernel.org,
        will@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk,
        paulmck@kernel.org
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200624151814.GI4781@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
 <20200623175957.GA106514@elver.google.com>
 <20200623181232.GB4800@hirez.programming.kicks-ass.net>
 <20200623202404.GE2483@worktop.programming.kicks-ass.net>
 <20200624113246.GA170324@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624113246.GA170324@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 01:32:46PM +0200, Marco Elver wrote:
> From: Marco Elver <elver@google.com>
> Date: Wed, 24 Jun 2020 11:23:22 +0200
> Subject: [PATCH] kcsan: Make KCSAN compatible with new IRQ state tracking
> 
> The new IRQ state tracking code does not honor lockdep_off(), and as
> such we should again permit tracing by using non-raw functions in
> core.c. Update the lockdep_off() comment in report.c, to reflect the
> fact there is still a potential risk of deadlock due to using printk()
> from scheduler code.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks!

I've put this in front of the series at hand. I'll wait a little while
longer for arch people to give feedback on their header patches before I
stuff the lot into tip/locking/core.
