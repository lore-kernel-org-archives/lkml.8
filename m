Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B4DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC37206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qlR93dSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgGOKNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGOKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:13:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED74C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 03:13:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so1825769wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hn1Hbjff+9Afv2Xeip4oNSq9d24avIQDuzU6faxXekA=;
        b=qlR93dSPHSbqYU0Gl7DzP6gPZu10L3MypqxPjXRCd3zNlT8TlEC6m6Emrl5IBiFU1J
         DvS9LgkqWmXclVuVF7eg4Y3VJ/BFPwhIter84emkwYWrXg6eJKmAdTWpVOL02taH6M/s
         ws/vvSueQ8jw/viS+72dcaQPaxdYvi1GENdrZOfWMvPnL/0MCDx4q/mMSqFOp8QQHArp
         aZ2U5T4imohTHyYFz2Mc4/+JJEMmkH+o4DpX2yqPmu/O4oVsIWtL7T48dk1uGKNwpRgE
         CE5pZsKIyFkaJok/rludtGQVXlsS062uymdMtf9BELZ5hXh15NssRLqmPXbWGpr0sbBk
         L1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hn1Hbjff+9Afv2Xeip4oNSq9d24avIQDuzU6faxXekA=;
        b=bz1qfaDIXA05ZX7fRuC2ptKm7kTaiWvEFMMB0O/uxOfqPCo6DRIipqRPK6ipQH1irI
         m2+Hflxxw4cIZXLQWYQusQIkRSsJ8EJecfAUY782vKLsyDBkylTn4yppopE5teR5WHCA
         q9+yJjK/C2DrR0hVgTBHxHpUM/IxRybGOGosw0hdQfQOJO4DMw/GeWQ55LsFVfrmvy77
         KjOSWB/ISGD5f7D3YXqVScrWVf/MKJ6YDABX86/1WU7k6MEsoEDqaqiVUl5Qw1RVjeIn
         ClDG/5ttosy5kY+4chnyeMTp8sl786hiKvsn+tHg+1GcJ4V9McmMhFqNjjLuaNzdVLe2
         lK5A==
X-Gm-Message-State: AOAM530MiBuVosln66ybwgHjVOOii8C/x3Pc2hSI7CZ712HysKpo1I1C
        FY49otm+pQ4nRyoMD7IneA+ufA==
X-Google-Smtp-Source: ABdhPJz1sof9nbSox7QA78MbtsQxOffGJyaBrE6z+a2qbZEL+1W2WAWsKdYybzfKFDfNwDKsEZNt6w==
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr9987696wrt.138.1594808020835;
        Wed, 15 Jul 2020 03:13:40 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 68sm2712443wmz.40.2020.07.15.03.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 03:13:40 -0700 (PDT)
Date:   Wed, 15 Jul 2020 11:13:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 06/13] cpufreq: powernv-cpufreq: Functions only used
 in call-backs should be static
Message-ID: <20200715101338.GA3165313@dell>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
 <20200715082634.3024816-7-lee.jones@linaro.org>
 <20200715094504.val6rb7wibysh7dn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715094504.val6rb7wibysh7dn@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 15-07-20, 09:26, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/cpufreq/powernv-cpufreq.c:669:6: warning: no previous prototype for ‘gpstate_timer_handler’ [-Wmissing-prototypes]
> >  drivers/cpufreq/powernv-cpufreq.c:902:6: warning: no previous prototype for ‘powernv_cpufreq_work_fn’ [-Wmissing-prototypes]
> > 
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> > index 8646eb197cd96..068cc53abe320 100644
> > --- a/drivers/cpufreq/powernv-cpufreq.c
> > +++ b/drivers/cpufreq/powernv-cpufreq.c
> > @@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
> >   * according quadratic equation. Queues a new timer if it is still not equal
> >   * to local pstate
> >   */
> > -void gpstate_timer_handler(struct timer_list *t)
> > +static void gpstate_timer_handler(struct timer_list *t)
> >  {
> >  	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
> >  	struct cpufreq_policy *policy = gpstates->policy;
> > @@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
> >  	.notifier_call = powernv_cpufreq_reboot_notifier,
> >  };
> >  
> > -void powernv_cpufreq_work_fn(struct work_struct *work)
> > +static void powernv_cpufreq_work_fn(struct work_struct *work)
> >  {
> >  	struct chip *chip = container_of(work, struct chip, throttle);
> >  	struct cpufreq_policy *policy;
> 
> Don't you want to drop this patch now ? As you already reviewed the
> other one on the list ?

Yes, please drop/ignore.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
