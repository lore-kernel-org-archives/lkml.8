Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD3CC433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B136E214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="guVPOcFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGPXJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgGPXJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF66C08C5F9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0OSy3aKO4OOG65syc1EwEzjCJ29c1m7vUVyorJSppu8=; b=guVPOcFpvQ2xV8lNDwKVvLmdNq
        fyu04xy9KOvs3dck3zo/QKW1PcOLKtTLPHV6woa2pSfsfMjCE1nv9f58HXYCqwMNQI9+0zjWtamxd
        4eOwLDnstoOWAgIXgVdVfVuw/GEz8DvvM+mSlqScG9P9VbLp20KgJsvMjIu3uGISRXGHp6FpVenAk
        qbdDT8+6y+J5qtHN7R7yM1QTsmFsqlR2gVOfP8v0ArSokxkp5AI/1WPVigAXPtBR3UnEt2D/dVUPn
        JMFeg3om8vp2dKss/WUmgYT/ZWOVUV0HUYWmaPemGzBb8gzPwoTD64t7g5ldLjk00PAO2F6yTI15P
        hY0rqQcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwCmK-00040K-Bc; Thu, 16 Jul 2020 22:55:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 83AE39817E0; Fri, 17 Jul 2020 00:54:58 +0200 (CEST)
Date:   Fri, 17 Jul 2020 00:54:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer
 timer handling to task_work
Message-ID: <20200716225458.GL5523@worktop.programming.kicks-ass.net>
References: <20200716201923.228696399@linutronix.de>
 <20200716202044.734067877@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716202044.734067877@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:19:26PM +0200, Thomas Gleixner wrote:
> +static void __run_posix_cpu_timers(struct task_struct *tsk)
> +{
> +	struct posix_cputimers *pct = &tsk->posix_cputimers;
> +
> +	if (!test_and_set_bit(CPUTIMERS_WORK_SCHEDULED, &pct->flags))
> +		task_work_add(tsk, &pct->task_work, true);

s/true/TWA_RESUME/g

see: e91b48162332 ("task_work: teach task_work_add() to do signal_wake_up()")

> +}
