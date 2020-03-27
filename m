Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A02C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FC42074F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V14ZuboK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgC0MMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:12:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46757 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgC0MMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:12:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so11071834wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CUiNH0fTVA8sWzw/AYTfBd2HLFCeSkZT6ClcIL3H9v4=;
        b=V14ZuboKkD4qd4LaZyDPH1whtWYrtM2qRjYA79lluKWh36n85Y3yCGmU3K6leg3HqK
         wRIrvN6mWJUJt1SuBF7JfQcf+7/D7LLG8yqqY9zSpWiXJi/7QCnOBDZsctQT7GNQ0gnC
         QvGcW7Gpu1NtQi/RdTOJplVe/Mvq3jWvuabIx3HNHF3r+B0bIpPfsQSr6Hww3CaYwbsH
         dQc05E2NhX6v80eqy8MrbfDhulQeOUdWve0S+NdS89UxGaeJ7ix8748edhjchSSxck/3
         3WpeK2CUVfX9h978rh00KOTPj087GtYs15st0MJGHFzaWdMh9TtK0+tcF1I6Hs5ZDq4Z
         yGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CUiNH0fTVA8sWzw/AYTfBd2HLFCeSkZT6ClcIL3H9v4=;
        b=Lwjn1xOPkw0ZiRaWjFNzhDAR6KSNZTpNsUwpbmFYHgIPqE/Z3dGWm1BTfilOtMkUFT
         oud9LkeQ/Jg4+trn3SLhcGfvFljbjRFROCPPvGYYSk4KuSKDGcbZ/b6QSAXYJi02YMSl
         HEgafRbBFiUqRkJPzanUcbfCMt/r/KIkkugeNwmSzqbEAiaNwDmKVUSNuKSGlfbI242i
         ZBflwsSXRXBqfMLQVEUEBcJ4AcP+zCD39CnJteWhGhp3peOvgKEpyw74h5I9M173QoeF
         V+DDuiM/Eawo7qpDbdJqSuOYMnfOrKjgG6J8u3YUA510J57UAoM92hvC+HNZZF1dwDfD
         vCHQ==
X-Gm-Message-State: ANhLgQ24IUR5oue8KGofw+qStnHP/aqr8+R0LhCZWFs8kqf9FGaUiY85
        nmErStrGRgc+Bb6Qkqj22h4=
X-Google-Smtp-Source: ADFU+vuJ9aerEJXEOaiSabitWRVaw7hwPu0xTEw3lR3e7uubpKeFlViKg9fc57GyA0az1mygc1NgPw==
X-Received: by 2002:adf:a457:: with SMTP id e23mr14895961wra.21.1585311168560;
        Fri, 27 Mar 2020 05:12:48 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a14sm7984275wmj.6.2020.03.27.05.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 05:12:47 -0700 (PDT)
To:     wens@kernel.org
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, wens@csie.org
References: <20200327030414.5903-3-wens@kernel.org>
Subject: Re: [PATCH 2/6] arm64: dts: rockchip: rk3328: Replace RK805 PMIC node
 name with "pmic"
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <8bfb3237-4bd3-8452-1860-ac05f3a23503@gmail.com>
Date:   Fri, 27 Mar 2020 13:12:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327030414.5903-3-wens@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu Tsai,

The Documentation/ portion of the patch should come in the series before
the code implementing the binding.

If you like, could you convert the binding as well and fix the example?

Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt

> Example:
> --------
> rk805: rk805@18 {
> 	compatible = "rockchip,rk805";

