Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EE0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D354D20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8mP/a6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgICPKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgICN6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:58:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB295C061A1D;
        Thu,  3 Sep 2020 06:47:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t7so3069865ljo.13;
        Thu, 03 Sep 2020 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k3qzuThp72U/KRxwqVBmH8skw7M3iKBLI2uUGRnjLys=;
        b=L8mP/a6IrjsOnBUJNLH9gtRvDP+4OMbHI+ZwhcrchPmprm1bWwSXCF3qdpZNSLZitr
         5vxo1+pmmZE4aqpsEmb9R44gchROZJsr06CkDcuqrYl2QZJuhGs2QZpQ3dhuJkfnkkyp
         drHo4YDPArnj1+J49nUababBHTtwnFLT0B5m//G0fxwxB/gKJHtQtLIKtgs4CbdZfkge
         SO1qNNzSOsZLrGVzu2UB6UkuJ/emvvSSx0zcPF5cLIJjv9LQlc5q34Erkx5cL3E46lZU
         i+hpfnP8g/Nm4s66rEd5vhzeG+kMEWSztvvit157Lw7hGQBHSK7WWoyKqlgwaSSEWCDf
         fqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3qzuThp72U/KRxwqVBmH8skw7M3iKBLI2uUGRnjLys=;
        b=jwBk7gYLNiMAxzl0VacAbMtAjdcKiNqnbStDTWbvhkxd10FwezL1DXN0WTecIW/9hO
         b+18eKz1c0EvzTrr6b1xhqVM7+bBm1LnDlLirseu48WS4nMVRPI5Ei2cHRXLt0Y41q9m
         VnkGFnCvkG1JMHWgiavaNVCBWT6ofLZeSrfG4kewL7pKmlBECtLy5XfI8I0Ww6r8Ol3J
         XWoVROlFrTg0+iY2yNLfnbCqYCO04kVe+ZQ04kuMqZ7IdyA0okUdljaPBiaQx6eYc07B
         LrnxwjNhHOht5xGxBFMTLHjbKzhozeMYry3vBAi1SrTrJ4t1d6Fu4F5HYpUgFF48Ww9Z
         mh2g==
X-Gm-Message-State: AOAM532tFxt1LQufFJk+tHhE0suHQBsciM15Lw/2Vce1VNrvirhAIw7T
        VCrYWC50LHKiTR531Wri0Mg=
X-Google-Smtp-Source: ABdhPJy8eL2bmmPblOvXEyLk1+3kYW10KFUyH34uTWW02OusL+7ojvhtmrJ/zedSljYSdLAXGPWwGg==
X-Received: by 2002:a2e:574c:: with SMTP id r12mr1398000ljd.302.1599140832286;
        Thu, 03 Sep 2020 06:47:12 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id k12sm614296ljh.95.2020.09.03.06.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:47:11 -0700 (PDT)
Subject: Re: [PATCH v3 05/22] i2c: tegra: Use reset_control_reset()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20200903005300.7894-1-digetx@gmail.com>
 <20200903005300.7894-6-digetx@gmail.com>
 <CAHp75VefJMxAoGxN8muTxLUJ=bwcMyjzX4uEGvYdckE6xYJvjw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <07e418bb-77c1-a3bc-bb8b-b930b8c723df@gmail.com>
Date:   Thu, 3 Sep 2020 16:47:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VefJMxAoGxN8muTxLUJ=bwcMyjzX4uEGvYdckE6xYJvjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.09.2020 14:11, Andy Shevchenko пишет:
> On Thu, Sep 3, 2020 at 3:53 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Use a single reset_control_reset() instead of assert/deasset couple in
>> order to make code cleaner a tad.
> 
>> Note that the reset_control_reset()
>> uses 1 microsecond delay instead of 2 that was used previously, but this
>> shouldn't matter.
> 
> What datasheet says about this delay?

The public datasheet doesn't say anything specific about the I2C
controller reset time. IIUC, controller logic runs at 200/400 MHz, so
1us should be enough for the reset.

I'm sure that somebody from NVIDIA should know the exact answer and will
correct me if I'm wrong. I CC'd Peter De Schrijver who is a maintainer
of the Tegra's clock-and-reset driver.
