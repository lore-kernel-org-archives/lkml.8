Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC42C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E74F2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmCLRJ44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGXQxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgGXQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:53:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60113C0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:53:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 9so8509397wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=as4fmSRb387YS8gfp6BovwXw3R68Emkk0kN+WY1ZJ10=;
        b=SmCLRJ44dBBQotYlC662u00MDZ5k4Teg/q73JDHfyu2mT2tUikZZqtRgsqZZQPyNan
         VppmGwKiMK3RvpLWpYUTI2sLrjBHbvI5+0/gtuTztc4plpqp5Z93XASHFJTd+XENm8m5
         nibPgSJJwCaEXF5VNcX9o0a8XW67UuYXdFhnChbgX/gwRnOJpLNc25izUdZyKiEjOnFN
         KZgmGB+zNkgaPcHl7DFcS3Z0MYB65kA03Fx8uJXrTxloFlE+vunIeY+vpjUhgeFLUT8e
         7OcYiepqJJROILp1YgSjybupPwwdnhZS0bsYsqDSxbHhWtBw5CK+DrYXC+dv9vKd7DFO
         ok3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=as4fmSRb387YS8gfp6BovwXw3R68Emkk0kN+WY1ZJ10=;
        b=em1UhNy90sul5uEgUSrwdMBZTpT91CVKc89E5SPc60A7SygPn34s0RH6PSbTDmf0rR
         swe7X11o3ngYjYzrZ2/OLDHfOuOliCEq7xqwLU/QKhSQAYU3lpeirhInoH4vakApIHJm
         WEMxOph+cpM2J2NkodcKnFxb1zMEBo9Ut0N8rInzRO5oS0NOXDDI+vOxpP5xqhXOCK4B
         a5JQGTdPaeuJerf/BeaQduiHBkISu1f4gytYAswW5brEKbp2GsxCnrhgXujOlcDmZ4YM
         liLyHTAfmoLS+pAH/mS7cqLheBNAuzm9O+cB+8N+fvND0VRJHwSHfXF4Zfam7RQnWFRH
         xpwg==
X-Gm-Message-State: AOAM5327h0NoiJjOz0OvfqSJunOQQexLOQ0To/+CbU8BAtuehZO5K5HM
        w/Vx9vijQCj41DizUQqzK499Ig==
X-Google-Smtp-Source: ABdhPJzvcZscyx0ElMoCx6+ZPgt1DJp28aDHhZQ0OpmWwtl54FOTGkKDr5QqjN4KJyP0BhjX2+r1nw==
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr9920796wmb.104.1595609580911;
        Fri, 24 Jul 2020 09:53:00 -0700 (PDT)
Received: from [192.168.1.4] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id l15sm1838328wro.33.2020.07.24.09.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 09:53:00 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] arm64: dts: sdm845: Add OPP tables and
 power-domains for venus
To:     Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Maulik Shah <mkshah@codeaurora.org>
References: <1595503612-2901-1-git-send-email-rnayak@codeaurora.org>
 <1595503612-2901-5-git-send-email-rnayak@codeaurora.org>
 <e68ff810-362a-5b99-206b-f676b204101d@linaro.org>
 <654e0fcb-ae4d-c151-fa8a-4d029fc823fb@codeaurora.org>
 <20200724162825.GH9185@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <d3fe38de-2f79-713f-eb9e-f72f4b9f6dc0@linaro.org>
Date:   Fri, 24 Jul 2020 19:52:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724162825.GH9185@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On 7/24/20 7:28 PM, Lina Iyer wrote:
> On Fri, Jul 24 2020 at 03:03 -0600, Rajendra Nayak wrote:
>> Hi Maulik/Lina,
>>
>> On 7/23/2020 11:36 PM, Stanimir Varbanov wrote:
>>> Hi Rajendra,
>>>
>>> After applying 2,3 and 4/5 patches on linaro-integration v5.8-rc2 I see
>>> below messages on db845:
>>>
>>> qcom-venus aa00000.video-codec: dev_pm_opp_set_rate: failed to find
>>> current OPP for freq 533000097 (-34)
>>>
>>> ^^^ This one is new.
>>>
>>> qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x30000
>>>
>>> ^^^ and this message is annoying, can we make it pr_debug in rpmh?
>>
> How annoyingly often do you see this message?

I haven't gig deeply but on every driver pm_runtime_suspend (after
applying Rajendra's patches). And I guess it comes after a call to
dev_pm_opp_set_rate(dev, 0).

IMO this is too often.

> Usually, this is an indication of bad system state either on remote
> processors in the SoC or in Linux itself. On a smooth sailing build you
> should not see this 'warning'.
> 
>> Would you be fine with moving this message to a pr_debug? Its currently
>> a pr_info_ratelimited()
> I would rather not, moving this out of sight will mask a lot serious
> issues that otherwise bring attention to the developers.
> 
> --Lina

-- 
regards,
Stan
