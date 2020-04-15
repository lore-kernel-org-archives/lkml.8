Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A4C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BF720768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRHh+oFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896313AbgDOKMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896235AbgDOKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:11:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB029C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:11:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f13so18398617wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=30de/AlaqjlX2SQ6sRQq6eEEGq+Ce5SXtlCKnRfiafQ=;
        b=jRHh+oFAJV8Tgx5k7HU8HwVLEOIdROElftVnkovMBaV0dYnaGaI26lfUn/Rltxvqw1
         IrTzQFim4nimJ6tDEDZFwMfbSKq0gIawHT6Z6IvUOEYIaj7Ay81Vnz4gwWNIpTPjOtPk
         czVljyjYsxvuFUPAWIuDeVPGa2fIFL+SRSUw2CtkR6aGqnoBU5+Qsx1LEJgmZvJOQ70E
         zB/NPJpD6Ck87Rr2cygLCbpbiM/lRvmB7n5OYtiaKQt/ASJZUrdqqC8Asb6E+y/jCICV
         /JkQlg4fC4uF+OoaWM1Lya1oXpqG867D9dg2LD0bcXQyKXy02xyt0S8eL7whlZ3rc1Mr
         KvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=30de/AlaqjlX2SQ6sRQq6eEEGq+Ce5SXtlCKnRfiafQ=;
        b=iBd0azRfD63D7g4Q69uiO4yMHbaWwijr1UGpdN0JpucH6empii5+Z7f56C1Xcm2sRN
         6yRpORMJOccIfbpHo38yYkmMSBAdG0OTLYWIFtb2RJ2jq1Y19Pk4C+5kdZCTI6craFdR
         1/4wpg/R7spvdzyTK1fzk1LzgQSY4v2KfHjf2Lf9NG9+KOy5rp4AVNK37veBRvW95uLl
         qkzpVKMIa/ZbHWVz+Sz0+N/TTCdUasLmrVFKK7KNJh5DGIpunTpD2ER/odr7/4hKAaF1
         hsz1DoDUreM4A0yo1H/yK4uC07y9yh+XbovAFAH8UMeLtWmdzjIxuflPYmFsYL6jvDpZ
         WPoA==
X-Gm-Message-State: AGi0PuaG7iBEHg+ILRy3Ah2tuaqXvwT6v739mFrC1e5j69JZiHue1ok2
        rOHQXT/8X4pLTRyZy/3H4vpS/g==
X-Google-Smtp-Source: APiQypITjl8sl8rPg8i/DwZP4DdcaJAmWeApCTCpntNLn88ytBpJQ3R0bUll0FQH9UWGZ2HxNOUElA==
X-Received: by 2002:adf:9d4a:: with SMTP id o10mr26328854wre.99.1586945487115;
        Wed, 15 Apr 2020 03:11:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id x132sm17945135wmg.33.2020.04.15.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:11:26 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:11:22 +0100
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200415101122.GA14447@google.com>
References: <20200403123020.13897-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403123020.13897-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Friday 03 Apr 2020 at 13:30:19 (+0100), Qais Yousef wrote:
<snip>
> +	/*
> +	 * The new value will be applied to all RT tasks the next time they
> +	 * wakeup, assuming the task is using the system default and not a user
> +	 * specified value. In the latter we shall leave the value as the user
> +	 * requested.
> +	 */
>  	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
>  	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
>  		result = -EINVAL;
>  		goto undo;
>  	}
>  
> +	if (sysctl_sched_rt_default_uclamp_util_min > SCHED_CAPACITY_SCALE) {
> +		result = -EINVAL;
> +		goto undo;
> +	}

Hmm, checking:

	if (sysctl_sched_rt_default_uclamp_util_min > sysctl_sched_uclamp_util_min)

would probably make sense too, but then that would make writing in
sysctl_sched_uclamp_util_min cumbersome for sysadmins as they'd need to
lower the rt default first. Is that the reason for checking against
SCHED_CAPACITY_SCALE? That might deserve a comment or something.

<snip>
> @@ -1241,9 +1293,13 @@ static void uclamp_fork(struct task_struct *p)
>  	for_each_clamp_id(clamp_id) {
>  		unsigned int clamp_value = uclamp_none(clamp_id);
>  
> -		/* By default, RT tasks always get 100% boost */
> +		/*
> +		 * By default, RT tasks always get 100% boost, which the admins
> +		 * are allowed to change via
> +		 * sysctl_sched_rt_default_uclamp_util_min knob.
> +		 */
>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			clamp_value = uclamp_none(UCLAMP_MAX);
> +			clamp_value = sysctl_sched_rt_default_uclamp_util_min;
>  
>  		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
>  	}

And that, as per 20200414161320.251897-1-qperret@google.com, should not
be there :)

Otherwise the patch pretty looks good to me!

Thanks,
Quentin
