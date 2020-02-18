Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF1DC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8489E207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XnrUfAJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBRPMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:12:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgBRPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aeEUpXSl8bZw39UsiswcpF9Du8gqq2lQNBid1Qos2wo=; b=XnrUfAJMKfIQWynwBL2X8A6J1o
        AUweg++Ukhc8jLmXhoxq+eP/he+tQ51ooXqjVkPLrjp21UuuSSNsC7AZK2zy2pXRIP1REDUzKR+lA
        zfpbt7f+aAQFDqxUIog4pLUkAF7yuzXBhfwXMIbzG8UTytEbwSRo4nT3SfuZ5OaDleo7PUKtAHtEr
        K/3ct1Ol4VRTfVEIDWMLrmlsDfve0oR8XQjSVgjPI1Z1NKAKZzDQ7Hc5tYqJVcP8A3bSnZuiW7R2d
        BgTucAuYbJkLyZqafKa+LmgTFnj4xKjd+cOxMpmy07g3PZjG5JYFPuujBa/Qg1rN+l44FufzESjT7
        BMueKIsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j44Xl-0006q0-18; Tue, 18 Feb 2020 15:12:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3D43300606;
        Tue, 18 Feb 2020 16:10:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91F862B935591; Tue, 18 Feb 2020 16:12:11 +0100 (CET)
Date:   Tue, 18 Feb 2020 16:12:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, hdanton@sina.com
Subject: Re: [PATCH v2 4/5] sched/pelt: Add a new runnable average signal
Message-ID: <20200218151211.GE14914@hirez.programming.kicks-ass.net>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-5-vincent.guittot@linaro.org>
 <5ea96f6e-433e-1520-56dc-a10e9a8e63c7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea96f6e-433e-1520-56dc-a10e9a8e63c7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 02:54:40PM +0000, Valentin Schneider wrote:
> Humph, that's an exact copy of update_tg_cfs_util(). FWIW the following
> eldritch horror compiles...
> 

> +#define DECLARE_UPDATE_TG_CFS_SIGNAL(signal)				\
> +static inline void						\
> +update_tg_cfs_##signal(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq) \
> +{								\
> +	long delta = gcfs_rq->avg.signal##_avg - se->avg.signal##_avg; \
> +								\
> +	/* Nothing to update */					\
> +	if (!delta)						\
> +		return;						\
> +								\
> +	/*									\
> +	 * The relation between sum and avg is:					\
> +	 *									\
> +	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib				\
> +	 *									\
> +		* however, the PELT windows are not aligned between grq and gse.	\
> +	*/									\
> +	/* Set new sched_entity's runnable */			\
> +	se->avg.signal##_avg = gcfs_rq->avg.signal##_avg;	\
> +	se->avg.signal##_sum = se->avg.signal##_avg * LOAD_AVG_MAX; \
> +								\
> +	/* Update parent cfs_rq signal## */			\
> +	add_positive(&cfs_rq->avg.signal##_avg, delta);		\
> +	cfs_rq->avg.signal##_sum = cfs_rq->avg.signal##_avg * LOAD_AVG_MAX; \
> +}								\
>  
> -	/* Update parent cfs_rq runnable */
> -	add_positive(&cfs_rq->avg.runnable_avg, delta);
> -	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
> -}
> +DECLARE_UPDATE_TG_CFS_SIGNAL(util);
> +DECLARE_UPDATE_TG_CFS_SIGNAL(runnable);

I'm not sure that's actually better though... :-)
