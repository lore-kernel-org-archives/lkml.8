Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4E8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753A62076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="hDRflfqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHEVQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgHEVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:16:40 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF127C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:16:40 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u24so31038178oiv.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Grm1cy93TykL2UQMLvitYfHftzNHr5WnvDxuij6JO+U=;
        b=hDRflfqSy7WcRWVgHidQaxalAI6pcrvC53q01AJTbJpMbWw0sNYAQ9P8vdMHgeRPzt
         pUMxybYMki+htTItPgxlEP+8j/xk9QLY3EMGVh9z6ID72rcfx2NsTFKdbZkn34p/DPpP
         sATeXwBCbvxxrxPCwOuI8ihYtOlfZ7xmHXT9/x8dv+2qc4DekekRa9QXqMEbg4nPpLoe
         mCp17blYYj28WG6NcfnvFnXtPSr1c/W8XUYmWMHx9vukbEXs2AwcAcUDWTuD7C8CDMIG
         55CsIkGcXeDMzVmXgFMgfXN+LBKjaHa4o7RvWYyAjaNKs5sVrbjm4uCVACRUrrNdkB6H
         aYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Grm1cy93TykL2UQMLvitYfHftzNHr5WnvDxuij6JO+U=;
        b=Nwwy81ua8czQ002t8kIdlOht0WLXIkEDJLfvAdqZZpp5DMYQmKJWoaEb3e6eDfQk7m
         hKZ+Shu+bT69WpcmAeZXFmDHf3nKk22lgWZHCqZVg+6ejH2om5+Ll4fST7cdFbZZFyYz
         AoL21EL1ZzFyooC3bnAoiM4AyXr4T0n5T52d1VLjyRqex+hVhAKjhJn+MLBF4ywBOifU
         0dtkKkJTkRXVkaTsvWfHvlojBpbDjnu+TZjGgeNq2Elreecj87Sd2lsyXkO6u0qqJ5Ga
         02rx/MSMAhycnHuWRKQTCr7TTn146E/F+waglEt8oCwWaHEtwwrQOEsm8sTale8oGtp1
         2YrQ==
X-Gm-Message-State: AOAM532Zx9zlYUBb7iToTpo4xokt40W5C/Ca/26umFhNgPrEPDxKmodM
        979gkaOY0TFVnnxhFILawAzQSw==
X-Google-Smtp-Source: ABdhPJyq3up6BgBEF4JBbpDeMKpsNeJVYqW/Eie4xYc5kopvUzCGvKOxeLD5qDnmN0Ym3dFzcn5GIA==
X-Received: by 2002:aca:c5d6:: with SMTP id v205mr4539034oif.143.1596662200100;
        Wed, 05 Aug 2020 14:16:40 -0700 (PDT)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id 33sm609369ots.12.2020.08.05.14.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 14:16:39 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using
 IRQCHIP_PLATFORM_DRIVER helper macros
To:     Saravana Kannan <saravanak@google.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
References: <20200718000637.3632841-1-saravanak@google.com>
 <20200718000637.3632841-3-saravanak@google.com>
 <CALAqxLVZ+rFE+hM9OtQ46NqpTHeLu6oKLNWKstLv1U5zbwyq7g@mail.gmail.com>
 <CAGETcx_rkK3-bKhDP_N4n_WyXLXFPoaUV9rbY_Y+H1Joj=dCyw@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <f314b687-11a9-5a5e-e79e-c46dd2f16c6f@kali.org>
Date:   Wed, 5 Aug 2020 16:16:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx_rkK3-bKhDP_N4n_WyXLXFPoaUV9rbY_Y+H1Joj=dCyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/5/20 3:19 PM, Saravana Kannan wrote:
> On Wed, Aug 5, 2020 at 12:44 AM John Stultz <john.stultz@linaro.org> wrote:
>> <sigh>
>> So this is where I bashfully admit I didn't get a chance to try this
>> patch series out, as I had success with a much older version of
>> Saravana's macro magic.
>>
>> But unfortunately, now that this has landed in mainline, I'm seeing
>> boot regressions on db845c. :( This is in the non-modular case,
>> building the driver in.
> Does that mean the modular version is working? Or you haven't tried
> that yet? I'll wait for your reply before I try to fix it. I don't
> have the hardware, but it should be easy to guess this issue looking
> at the code delta.

For what it's worth, I saw this too on the Lenovo C630 (started on -next
around 20200727, but I didn't track it down as, well, there's less way
to get debug output on the C630.

In my testing, module or built-in doesn't matter, but reverting does
allow me to boot again.

> The only significant change from what your probe function is doing is
> this snippet. But it'd be surprising if this only affects the builtin
> case.
>
> + if (par_np == np)
> +         par_np = NULL;
> +
> + /*
> + * If there's a parent interrupt controller and  none of the parent irq
> + * domains have been registered, that means the parent interrupt
> + * controller has not been initialized yet.  it's not time for this
> + * interrupt controller to initialize. So, defer probe of this
> + * interrupt controller. The actual initialization callback of this
> + * interrupt controller can check for specific domains as necessary.
> + */
> + if (par_np && !irq_find_matching_host(np, DOMAIN_BUS_ANY))
> +         return -EPROBE_DEFER;
>
>> I managed to bisect it down to this patch, and reverting it avoids the
>> issue. I don't see what is wrong right off, but I really need to get
>> to bed, so I'll dig further tomorrow.
>>
>> Saravana: Apologies for not getting around to testing this beforehand!
> No worries. Apologies for breaking it accidentally.
>
> -Saravana
