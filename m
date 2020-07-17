Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC1C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49AC52064C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lov4sdCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgGQXLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgGQXLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:11:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855EC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:11:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so12727996wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rzjn/eYPwCM6Moj4rlObmsEsReunmRsAEC0/KZLwCVg=;
        b=Lov4sdCnWQ+sBRfBNL+0G/LP/iK7IUI/22PUpseUjsRwmSVhhsKTNfh0HcvxTeEmYl
         WlrmebPlQiavtHDYNLWRQrcXG3ccPYoROmr6vd19HtI9mp/KlnVdNkMIF9k2IAnlC3pu
         9XoT04HEBib/De7FxRLtlPObMGBXc1ddRgK8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rzjn/eYPwCM6Moj4rlObmsEsReunmRsAEC0/KZLwCVg=;
        b=BvYKwtsZ+LhQWu7ie9jckNXcA2tKnxzehMWfFNlvI8cqxrhdtY42wKzy8S4DB/ICTj
         RVtURybSGX/v8dwP0+EvzlgGXS5yQKabv+yLz8TfIYmE31s88t+P6Wd8O542eOJZU30s
         sJB4/QpUUYGRsUD+ycAnRefv4Tf2uC/EqlqcBreM1IIFQIKmAVFLZBvN3kE+PsF2kRBr
         8C55tZwihSaePiQUqDK2pkX5cZqFRlSji+u7F0cyh4i5kpRkZ3sCz9QIobg7zeYJ2ijB
         c49EYjiGfpQkXrB/42H8D9WQdzFDEI3Z4q+6bD4WUmVggRJAQs1QtAlAAz70Xa1BbSQ9
         eX5A==
X-Gm-Message-State: AOAM532FxVM//+YRVHeDQrgua4nxAd4WAtnWdzlvwHd3z5zfYhcYPF3C
        R64IuMqH2uJ1dFRMq8kBg8/eS5Xsi405Zg==
X-Google-Smtp-Source: ABdhPJxIeTbByBtvJPFBWtoEQwfx1aw0jKUYoGevVA/FgRszcMTAzmlm2Y25dEQktbQ/CvQGb+K4Pw==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr12694318wrl.246.1595027504036;
        Fri, 17 Jul 2020 16:11:44 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c3sm4296419wrx.5.2020.07.17.16.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 16:11:43 -0700 (PDT)
Subject: Re: [PATCH v2] pwm: bcm-iproc: handle clk_get_rate() return
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20200717182512.26001-1-scott.branden@broadcom.com>
 <20200717230431.4oj44cfnkhkd2o6z@pengutronix.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <61a62404-6a44-53c3-6d17-89fa7a4c8551@broadcom.com>
Date:   Fri, 17 Jul 2020 16:11:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717230431.4oj44cfnkhkd2o6z@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-07-17 4:04 p.m., Uwe Kleine-König wrote:
> On Fri, Jul 17, 2020 at 11:25:12AM -0700, Scott Branden wrote:
>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>
>> Handle clk_get_rate() returning <= 0 condition to avoid
>> possible division by zero.
> You advertise handling <= 0, but in the code only == 0 is checked. One
> of the two is wrong ...
I checked - clk_get_rate can't return negative values.
I'll update the commit message from <= to ==.
>
> Best regards
> Uwe
>
Thanks,
  Scott
