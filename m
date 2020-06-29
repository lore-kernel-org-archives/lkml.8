Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6054DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0EF20720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGXdcKt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgF2VDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbgF2TMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9302DC014AB8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:05:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so15148491wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5+hczelMMEDbYcHP5+CW5lQUh+iqmRD+aRAJuSk8CxM=;
        b=uGXdcKt0pHO/pN/1e1d6qjxm6dypuBJxXYRvEDVJpohbWz0nM3+E0h2zX19UjPTDJT
         /TUbDJkiNOZdbwZfrECDpJW5FBCvhNuLpD8BwD1Yd+fp+lBP4iODaZJxq6IaS4XkeiIM
         xV6HwIgYOETVk8DEQy7tRQuOSAjBKL9Y4EmcnT1soTsMJDWuonlBeqo23WJSnrlCbREa
         7PUtod/r12dmFpz1eTNc5ZYslMpGhvZiXtOepOO2ld9AbC+qtNFtB9Kozz8wjHYtLzuu
         KPgEFHYSO9twXbF5nASFfCOLAXf6qhdYQjt5FbVZBB5uFhg0BeZngnyKJ9/q3fHxRsW9
         O+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5+hczelMMEDbYcHP5+CW5lQUh+iqmRD+aRAJuSk8CxM=;
        b=axdsBCkzgx+ykEItGvAc955XS3GXnAuVhdLH6jaA3PjpkaZXUcDH6r9QrK8h7s8yrv
         gSW/Dq9OK3kQ99Xl2HtDHwcgvSJBIwDRSZ2iizJwsZq03Kboemmkqxt/0XO6GV+UqYQv
         kLC5+nqoCpRP8qPc6cX9WIQv6Au2IJ8+N7sWOCNl6233ChRsOURXDISqM1C0MtzFO2dN
         rv7atQM7W5ulU+ZmQD5h0DcX0QRLbyJo1rs/0NFXBliAf048X6fO6HAjPFoa88dIH/j7
         ip6R2oaU4Vi3zPAdKOsb7WI1i8Qv5fjBT1DfKbSC1EZMIXkh5ZRKhMfouX+L+VlRgH7W
         UhMQ==
X-Gm-Message-State: AOAM533ru2tJd200U0J/P0zDpkTNwddZfnvmjpFLmwjepn3XmfW7y1EC
        4POS6so3tIGm9/10mnexe2vN9g==
X-Google-Smtp-Source: ABdhPJxzGmtYixvHk5OQIS11ERm+5ABmfFXTzChdfi8AO/NDYvXEPyeBiFluSdHDuoghA2KTZOI0yQ==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr15114921wme.0.1593417915196;
        Mon, 29 Jun 2020 01:05:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id y16sm47498532wro.71.2020.06.29.01.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:05:14 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:05:11 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] cpufreq: Fix locking issues with governors
Message-ID: <20200629080511.GB1217385@google.com>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
 <f366ed3dd3dd111e42173b366fe4dd5a0e4647fd.1593143118.git.viresh.kumar@linaro.org>
 <20200626082433.GA284605@google.com>
 <20200629021309.eleyysuh5f5g52qw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629021309.eleyysuh5f5g52qw@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 Jun 2020 at 07:43:09 (+0530), Viresh Kumar wrote:
> I described why I chose to keep it that way in the other email, but I
> am all for dropping the variable. And so what about this ?
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e798a1193bdf..d9e9ae7051bb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1064,18 +1064,17 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>         struct cpufreq_governor *def_gov = cpufreq_default_governor();
>         struct cpufreq_governor *gov = NULL;
>         unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> -       bool put_governor = false;
>         int ret;
>  
>         if (has_target()) {
>                 /* Update policy governor to the one used before hotplug. */
>                 gov = get_governor(policy->last_governor);
>                 if (gov) {
> -                       put_governor = true;
>                         pr_debug("Restoring governor %s for cpu %d\n",
>                                  policy->governor->name, policy->cpu);
>                 } else if (def_gov) {
>                         gov = def_gov;
> +                       module_get(gov->owner);
>                 } else {
>                         return -ENODATA;
>                 }
> @@ -1099,7 +1098,7 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>         }
>  
>         ret = cpufreq_set_policy(policy, gov, pol);
> -       if (put_governor)
> +       if (gov)
>                 module_put(gov->owner);
>  
>         return ret;

Right, I guess this is a good trade-off, so that works for me.

Thanks,
Quentin
