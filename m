Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DA6C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E992070E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zr5JWRbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGODHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgGODHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:07:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8751FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:07:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k4so1302241pld.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G2eRhXKmTEwTRQanSal/vSTAH9sP+NPQp5iAdhOZfgg=;
        b=zr5JWRbTGLJp8u1/MRQxIwWW/APlv9WqwsvnqgQGG8mSRtvxbJYHVHv43e4/bUsskg
         m9YsiPUcPQSqG9NYzOsapwL/AL0euAzYN+yFHAygI6Rbv2i0iy2VW3erNMQMx6b+o+bK
         CqQ5PR5wRHps18XmeeLDlHBdpaFq4Dbp/NA/AK/UaTjmxhqlqq7ncpED5RPZnusmlFdI
         ZvXa96YRX4SN4a6TVM9u+nBQtNNFuSk2CDQP32u/iJd+rBShWhobxpQlmQ2ErLkN3r24
         F7sZD2wX99im9YbzgEC1lDsjOXAzZS6uDX+t3YnDY9MDgpytN3Tyd90smDlsEZ4i9qRV
         w3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G2eRhXKmTEwTRQanSal/vSTAH9sP+NPQp5iAdhOZfgg=;
        b=mG8yqjjtO1uMpcs712p3P18YmPJ86CsojHRq3I39qKc70pcav1fu8qnikLXk6BsrQJ
         Dj75oJmLQEtotn2PMZmeFAETJGlo+wmMlpC7PP1cQh6u554yzaxmzfJ+sOHrmZ1u4g9d
         uaMy+DNzBLdehlmHowehsG2hHUTiS/x2yHtIye+59Q+r8yzc++vw8gQqVfIPA/vbdK8T
         mh7UtK5c0UW4sqbRYDy9yzNi4hF9AyewmQC1FxxL1+f560tIjDKT0hcYZVgJVV2+Jk9o
         VEMd6edlo+fQOM6M6vjdbMHPHwWLns0QrrCEhESGR9HW0bh/smlNhAKOSml39k+UhXC+
         AaKA==
X-Gm-Message-State: AOAM5313XVjrqBoq6xzmt9dXs42Mo5WOuNx3miwSSdh3n3spkswnvXC3
        0GGbk6e2Pmoxo17Jb5n9HaPW5fh87+4=
X-Google-Smtp-Source: ABdhPJy6G78yRMtYXULRufyLyim3gEDYCwAAZwkqYmBwjzlqARktEGcx+FHp/26xKL2ZJaDT5cfH6w==
X-Received: by 2002:a17:90a:db02:: with SMTP id g2mr7405784pjv.43.1594782456515;
        Tue, 14 Jul 2020 20:07:36 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id b15sm465430pga.54.2020.07.14.20.07.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:07:35 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:37:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/13] cpufreq: powernv-cpufreq: Functions only used in
 call-backs should be static
Message-ID: <20200715030734.3kdqmyr7rjlmrd3h@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714145049.2496163-7-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/powernv-cpufreq.c:669:6: warning: no previous prototype for ‘gpstate_timer_handler’ [-Wmissing-prototypes]
>  drivers/cpufreq/powernv-cpufreq.c:902:6: warning: no previous prototype for ‘powernv_cpufreq_work_fn’ [-Wmissing-prototypes]
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 8646eb197cd96..068cc53abe320 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
>   * according quadratic equation. Queues a new timer if it is still not equal
>   * to local pstate
>   */
> -void gpstate_timer_handler(struct timer_list *t)
> +static void gpstate_timer_handler(struct timer_list *t)
>  {
>  	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
>  	struct cpufreq_policy *policy = gpstates->policy;
> @@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>  };
>  
> -void powernv_cpufreq_work_fn(struct work_struct *work)
> +static void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
>  	struct cpufreq_policy *policy;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
