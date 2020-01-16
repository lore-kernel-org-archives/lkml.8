Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE4AC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DBD20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="THuV5dJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgAPPRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:17:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34698 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPPRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=borVowV1cTfT1Ds6iFHszucOgRgPJsUu96PbUDyKtzw=; b=THuV5dJnG+L84E0iB2cJDSRI0
        K/IzT69KLzN3lqfvhI3zS2KW8i/rTYkBS1gBdXzHBcUXcD/Fb2sAFx5uCNs/Bk16VbIQ90QPYzNN5
        Db0W+VI3xn8QnumXsPA7xLEtowY9EK7UZ7z7J3DoFGqiw1ZoNfUPk6I0eAgPbTiiJ6RdLB2Iif+lG
        EVF4f0Hyx2SaxbhExNNM7LTMHcSrYmeBBak6l64EQv2y9di/IMF2vHcunGIFkBj1GbD0miKOHJ3kq
        u4wua+wd7teUuxD/v2Dgdf6jUShuqtMU2688MSTMIWd7hQqRgUY8BYdsQ0MdlFB1pvi4Pdsyy4znc
        QhAe+O//g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1is6th-0003dB-Ua; Thu, 16 Jan 2020 15:17:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2B56302524;
        Thu, 16 Jan 2020 16:15:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A28EC2B6D1E15; Thu, 16 Jan 2020 16:17:24 +0100 (CET)
Date:   Thu, 16 Jan 2020 16:17:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v8 1/7] sched/pelt: Add support to track thermal pressure
Message-ID: <20200116151724.GR2827@hirez.programming.kicks-ass.net>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-2-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579031859-18692-2-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 02:57:33PM -0500, Thara Gopinath wrote:

> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index afff644..bf1e17b 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -7,6 +7,16 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>  
> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
static inline u64 thermal_load_avg(struct rq *rq)
{
	return READ_ONCE(rq->avg_thermal.load_avg);
}
> +#else
> +static inline int
> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +	return 0;
> +}

static inline u64 thermal_load_avg(struct rq *rq)
{
	return 0;
}
> +#endif

Would help with patch 4 and 5.
