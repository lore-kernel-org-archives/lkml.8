Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD81C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9768521D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnKYb6Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgATPbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:31:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36362 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xdW7ZbNaRNtAWdc9c+FrOhTuCFBDAo8UcLvABTlCBKA=; b=rnKYb6YgZ4XrYGPSSnSaltIuf
        1VVasubTGgWe0IJev0rDwg93xKDkJY1oimN3gTAWQtANYrjEVmgr2D5S2cLAcnOH56SXwRayhZETJ
        Rp4L831Bg8d2qNtB4xNv/SQNKm22TUSwZjWwV4kkrl8Kwn1CzXXn2vh6C7c6/iCvVMErLUiub1OKB
        fBFRCNjHqDEGC3A8b050geDwGeElRe1pEdxuB5xK4p5nICD8OusMl0K99Lq76hY9o4qMSc9XveLHu
        Nj5oKF1LlpxQfiTwoUErZsEI/3FXW2qdu/s/xWnjJ4Ufk+k7fjG3Ds5Fdqpi3nD7JINts3yOlgna7
        vzhFxkJtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itZ1V-0007Ym-2o; Mon, 20 Jan 2020 15:31:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15EB930067C;
        Mon, 20 Jan 2020 16:29:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA8C62020D909; Mon, 20 Jan 2020 16:31:25 +0100 (CET)
Date:   Mon, 20 Jan 2020 16:31:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Thiel <b.thiel@posteo.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/events: Add a missing prototype for
 arch_perf_update_userpage()
Message-ID: <20200120153125.GE14897@hirez.programming.kicks-ass.net>
References: <20200109131351.9468-1-b.thiel@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109131351.9468-1-b.thiel@posteo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:13:51PM +0100, Benjamin Thiel wrote:
> ... in order to fix a -Wmissing-prototype warning.
> 
> No functional changes.
> 
> Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
> ---
>  include/linux/perf_event.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 6d4c22aee384..de3874271814 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1544,4 +1544,7 @@ int perf_event_exit_cpu(unsigned int cpu);
>  #define perf_event_exit_cpu	NULL
>  #endif
>  
> +void __weak arch_perf_update_userpage(
> +	struct perf_event *event, struct perf_event_mmap_page *userpg, u64 now);
> +

Indeed so, I've slightly changed to:

+extern void __weak arch_perf_update_userpage(struct perf_event *event,
+                                            struct perf_event_mmap_page *userpg,
+                                            u64 now);

Thanks!
