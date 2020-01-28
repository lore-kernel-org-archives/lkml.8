Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC435C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB6E206A4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YoKREBJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgA1X5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:57:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1X5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1K5YUo43JKByDfvuvvxoDmLJgEnxvs90R6iuzNwcrW8=; b=YoKREBJdRsfkkCVsF3f741LL6
        UkIDzYilhdUUx5F2ny9ZD1Cv9yfHUWHmxlYvYkXskIv6Az6nRsvCfSOkvp8An/Iw6NDEZ1GY3bH17
        iw6DNxDWTJk73Ixd9v7RZ+gVfpNkbX2r6Ut/UPDI36J2x2PmpiCl/xleCa9FrFKJyZHKjbrwh+pPw
        AB/TiCYLn4XmCmf8TEX+NIq0r+j5y6vO5SKH0IQHwU8DybUDprMZFjjAHpOBN5vS0QnI/PI0l+Ty7
        y568Sxlf8m9bcOYa1Q2IIPaKX4ZHUpnt4YDpa68nHYf048/FWUza3TgTZe+/juwxmGWmqGOgkXJwn
        uY0kZ4oVg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwaj4-0006u0-Sj; Tue, 28 Jan 2020 23:56:58 +0000
Subject: Re: [Patch v9 7/8] sched/fair: Enable tuning of decay period
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-8-git-send-email-thara.gopinath@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4eb10687-1a62-cee3-7285-3f50cc023071@infradead.org>
Date:   Tue, 28 Jan 2020 15:56:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580250967-4386-8-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/28/20 2:36 PM, Thara Gopinath wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e35b28e..be4147b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4376,6 +4376,11 @@
>  			incurs a small amount of overhead in the scheduler
>  			but is useful for debugging and performance tuning.
>  
> +	sched_thermal_decay_shift=
> +			[KNL, SMP] Set decay shift for thermal pressure signal.
> +			Format: integer between 0 and 10
> +			Default is 0.
> +

That tells an admin [or any reader] almost nothing about this kernel parameter
or what it does.  And nothing about what unit the value is in.
Does the value 0 disable this feature?

>  	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
>  			xtime_lock contention on larger systems, and/or RCU lock
>  			contention on all systems with CONFIG_MAXSMP set.


thanks.
-- 
~Randy

