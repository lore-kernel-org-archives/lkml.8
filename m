Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E712C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0A221835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y0PPMzgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgATM22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:28:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35008 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgATM21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jr9/irqC8ShIKukDwNJnAL4WQ23TMTPSdm6Vmh8GkUA=; b=Y0PPMzgMkMNwvHE1get2590/h
        bxldWzviwYqXtGrEbCR2BG91JkKWC0ZoenQfzbiBi4NwGioI7DU1Ng+zSfLSCgn4gnurhTZkLk/9F
        YlI2NDeyOY+tU22fm0btLLTow8SFTIn2tEcn80lPV6zNeXLyhrmf6OauI1JVBk+RVcNFxz7HnjZYN
        j+W/LphtaXTuQiQHIBQi8/h4gwrig9R7REF94tcmo89FHYGbkK8iUh0SgdSrGWoEgp/LDcXrPamfS
        jHeA6GXUbh/9R3RuV3dqhVbul8msVZgpa317mZq/aX9fsM/3WplHTU2zc5joi5RGKUd4Et33Ev4LG
        DlZhzXxpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itWAH-0005X8-Ej; Mon, 20 Jan 2020 12:28:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 961063035D4;
        Mon, 20 Jan 2020 13:26:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F23D2B6A0696; Mon, 20 Jan 2020 13:28:18 +0100 (CET)
Date:   Mon, 20 Jan 2020 13:28:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Track loadavg changes during full nohz
Message-ID: <20200120122818.GO14879@hirez.programming.kicks-ass.net>
References: <1578736419-14628-1-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578736419-14628-1-git-send-email-swood@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 04:53:37AM -0500, Scott Wood wrote:
> v2: drop the first couple patches that appear unnecessary
> 
> Peter Zijlstra (Intel) (1):
>   timers/nohz: Update nohz load in remote tick
> 
> Scott Wood (1):
>   sched/core: Don't skip remote tick for idle cpus
> 
>  include/linux/sched/nohz.h |  2 ++
>  kernel/sched/core.c        | 22 +++++++++++++---------
>  kernel/sched/loadavg.c     | 33 +++++++++++++++++++++++----------
>  3 files changed, 38 insertions(+), 19 deletions(-)

Thanks, I've queued them.
