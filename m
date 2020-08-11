Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663FD20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SATSNvRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgHKLQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgHKLQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:16:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD65C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:16:49 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bs17so8779736edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6cufjOFrT/hcspnN5aAafTE/4pFcFv+P9DAHTf0Alws=;
        b=SATSNvRFgruxKUzD1yxGTGH+w8XpGtxSqpnYC97tFqgvs27XA4hgyY3OPtsy65a/ip
         XU+sYFd0BpCB4dDedbItsxRYNDin7SE/FiWOvMjE2ij2a8NJCfpfLxoFXTvrPBvo0ycF
         QxJ8wm5WDamdoXUT+N1c3MFzyK3om2H3xOLqqCF4l8yfjsu3GIQ8trgq2Gk3nfvJ3xdw
         R7D4tRi8gCQ4TZc1F37UPcsYyqWUw6tBErctFtEq8si0A8UyP+iHkiwTNhhe4bP10Rk7
         nzPgZz+fnX5oBuyzgvKF+n7uGHzjCZTFxbAtAD3D7wA1OUcej+bIOfqr49fgO85BsrqZ
         CXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6cufjOFrT/hcspnN5aAafTE/4pFcFv+P9DAHTf0Alws=;
        b=E0hXJU48KNxX7RcklszoGdsMZg3gaIUhheQftN5n/564nCW8zWZM/1CJP7mlVONcNN
         Bl1oWBraoA3d/64Gb7gmcwlnJReRSOwg5SvamAlSM8vkNg9O+K39EUId8eEUFiinR0pu
         giOzHoe2ffhRMDe1dEp0TbJjRk2ALXNCipr8UrpU0t5cb8yl2J+W/dSJ/VeeySR0KLIK
         AbSoypltgYyZ0fbaD/7f2EPuJobMhKJusxSsUY4ryFMQ60Sr4oOnr9HOd3VOYeWflpp0
         TCLeAc7NAI+kstKDDj3sjFYKviYy4jWqQr4sUfFaQDepjNE3rYYRFW9OzKQ2Lnsx7zD/
         ICOg==
X-Gm-Message-State: AOAM531tnIA8fzTc3nsS2sx8PVZqrwpJsuKy4sEQb9Z6qh/YriUQqkCH
        fnz/p8kVy0aysL2HA3rRGkMTvg==
X-Google-Smtp-Source: ABdhPJz486z2bZFpt1XUVZO12LzbgOKzz74hODxz1NU+0tiv1qSPZYMBXRqHUusPMC0lIUDz8INZkQ==
X-Received: by 2002:aa7:dd94:: with SMTP id g20mr24838626edv.238.1597144607755;
        Tue, 11 Aug 2020 04:16:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id u4sm14245784edy.18.2020.08.11.04.16.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 04:16:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] ASoC: q6afe-dai: add dummy register read function
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        john.stultz@linaro.org
References: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
 <20200811110409.GA1481@gerhold.net>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <002fa321-93ca-07a6-abc2-bd1d7433f98b@linaro.org>
Date:   Tue, 11 Aug 2020 12:16:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200811110409.GA1481@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/08/2020 12:04, Stephan Gerhold wrote:
> On Tue, Aug 11, 2020 at 11:25:51AM +0100, Srinivas Kandagatla wrote:
>> Most of the DAPM widgets for DSP ASoC components reuse reg field
>> of the widgets for its internal calculations, however these are not
>> real registers. So read/writes to these numbers are not really
>> valid. However ASoC core will read these registers to get default
>> state during startup.
>>
> 
> Actually q6afe-dai does not seem to make use of the register number.
> The DAPM widgets all look like
> 
>    SND_SOC_DAPM_AIF_IN("HDMI_RX",  NULL,   0,    0,     0,      0),
>                    /* (wname,    stname, wchan, wreg, wshift, winvert)
> 
> Wouldn't it be better to replace wreg = 0 with SND_SOC_NOPM in this case
> so the read/write won't happen at all?
That should work, let me try that!

--srini
> 
> q6routing on the other hand does make use of wreg, so this would not
> work there...
> 
> Also: If I remember correctly the ASoC core will also attempt to write
> to these "registers" when starting to play some audio, so you might also
> need to implement component->write().

> 
> Stephan
> 
