Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D58C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687A420656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBqp9xb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgG3GKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgG3GKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:10:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F68C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so6162308pfx.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uQYpM0l2BVpiJWQZFm1BaeuXeXgCvf7ouFHsM+pxK3o=;
        b=XBqp9xb8A9zcXM17E9TiNethe3UCCEif5I2cMuTLDm+LzY/Q2h/KEWFSUUIU7+OOsp
         fGEfbag1AKQoz9XbUpT/O8kbZdNkENjutG77LUQoYDU1WZSv71gcM3J/pBNKIVOkdclA
         FLTQ7DrgWZXGCECvMsiy7JgW113vuB7rqh+MYWSubjaMXMJDnSj1gFZMVwHl9DVCZWnr
         V1QOc8GZRqNu9ZCgYrn1pMnHs9SapztI74OlUkc0AskHJD/mQ9yWV9lupgZKwp63IBNg
         afahJsaFHOxnIDSCUeF37d3jphtAWoDYcShcDIXQ22qeNvzkR4hQyZz+1pQhbjw8WLa1
         NhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQYpM0l2BVpiJWQZFm1BaeuXeXgCvf7ouFHsM+pxK3o=;
        b=MUJHeFw9Dpwd/YUr8ErvgclQre3/BwruBcAMmy7is6uN5i71YYTOxWZFG24Nfx82tf
         DcFDLx75v7/Ocx6g+UbrGKAc9rxsn0CkxNmn9s/Mv84xXD+c8pRPCeD9jUeqy/d9y9AD
         kuCXX61LmofKRR5UZyFLpdq/GAbjczdGJYWL5s6SALI5xhIj7uPQYG1dADnZ7bVfyx+9
         KFngWciTWAcOg3Zf6CNU7oNf+gJkBUpMlB+FlzixWsMC1dY0ehZ/ZfBZ9t07YUjz4bPy
         joWHZHWv5jD0Bi6GqGL2AyzFi/Ye+99DkRMnAsS5upri37ns8fLSAmrWka7EDAMFn4+m
         ccTA==
X-Gm-Message-State: AOAM531C3yoCUqp4isOE3u+QAEiwE6pJdD7yro5YuUIzXsAKpWOtylYM
        sVoLvMr6DuqeZYZDmOkXB1NYew==
X-Google-Smtp-Source: ABdhPJxSQvMRu1T3KgR5lHuZ010N5ABhbRziRXq9ba4d0wesRySTDuiJw9HJ7RCTVwThb1P+v7OFrQ==
X-Received: by 2002:a62:7c09:: with SMTP id x9mr1632779pfc.229.1596089444870;
        Wed, 29 Jul 2020 23:10:44 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id t73sm4667429pfc.78.2020.07.29.23.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 23:10:44 -0700 (PDT)
Date:   Thu, 30 Jul 2020 11:40:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: cached_resolved_idx can not be negative
Message-ID: <20200730061041.gyprgwfkzfb64t3m@vireshk-mac-ubuntu>
References: <d48d824ab3abacb2356878780979d7ed42191eaf.1596080365.git.viresh.kumar@linaro.org>
 <CAHLCerP4YPHc4sKD_RTq=Gxfj+ex4F=J2is1Y-UzGXcOuEOrOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerP4YPHc4sKD_RTq=Gxfj+ex4F=J2is1Y-UzGXcOuEOrOQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-07-20, 11:29, Amit Kucheria wrote:
> On Thu, Jul 30, 2020 at 9:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > It is not possible for cached_resolved_idx to be invalid here as the
> > cpufreq core always sets index to a positive value.
> >
> > Change its type to unsigned int and fix qcom usage a bit.
> 
> Shouldn't you fix up idx in cpufreq_driver_resolve_freq() to be
> unsigned int too?

Yes, merged this into the patch.

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0128de3603df..053d72e52a31 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -538,7 +538,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
        policy->cached_target_freq = target_freq;
 
        if (cpufreq_driver->target_index) {
-               int idx;
+               unsigned int idx;
 
                idx = cpufreq_frequency_table_target(policy, target_freq,
                                                     CPUFREQ_RELATION_L);

-- 
viresh
