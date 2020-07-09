Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13194C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30B22076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b8MC0vQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgGIMpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgGIMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:45:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EBCC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BzPKqvPHXp8bpGZtUpf7YswCvt5U9wvhw4emJBW+h0E=; b=b8MC0vQWoJzdUJRcLhOwHEN8kt
        LhWnmb2rMEAlRthStdTAxarJ2FBpCiC8ct60tNSo5jDPu7BryshmcXAMxXj5LBlxqwm4TKiWTjIF+
        ITp91nULugJU/M4E+TCSpVPoRFucLTbmtw2EN/k5ER1693/YMSj7ylY9RAfhUBdrx9niEJ2N8e+im
        1gmjcCyO9fQbLDZoV+P4iS80+1L0aCYSuSeczRGYMXKM/o/67+pAkgvZ3JqQaUI1wCTFtFW7yyBLh
        CakYrF8J8QkEBrDpvD/PUOL8xkSq+42VPMD11aPufab4dwrGfkt/J1S+FOt5gqCeSjBYbhumtjTwl
        Uh7TMi1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtVvI-0007NT-JW; Thu, 09 Jul 2020 12:45:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A4AA300739;
        Thu,  9 Jul 2020 14:45:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39147214ECE3F; Thu,  9 Jul 2020 14:45:05 +0200 (CEST)
Date:   Thu, 9 Jul 2020 14:45:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tip:sched/fifo 44/45] ERROR: modpost: "sched_setscheduler"
 undefined!
Message-ID: <20200709124505.GT597537@hirez.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006192249.AYnVBGCH%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:15:51PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/fifo
> head:   8b700983de82f79e05b2c1136d6513ea4c9b22c4
> commit: 616d91b68cd56bcb1954b6a5af7d542401fde772 [44/45] sched: Remove sched_setscheduler*() EXPORTs
> config: x86_64-rhel (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout 616d91b68cd56bcb1954b6a5af7d542401fde772
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "sched_setscheduler" [kernel/trace/ring_buffer_benchmark.ko] undefined!

Steve, do you have any preference on how to go about fixing this one?
