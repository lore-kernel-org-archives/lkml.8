Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0CA2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ej7On6D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgGHJok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGHJoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:44:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF77C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 02:44:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so20170355wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v9AIm6DN48ankAafEBRPujrUBGThinGUo487AT2ZYnI=;
        b=Ej7On6D1FjUedjzUMWW8M4FOFnY9gQuR2ByeadVXAG2kPNiLojZdHlwzjz0XdshZnr
         TquPfnDH5gTteLy0VV3GHyLVY+dGw8skM9V39sn5f8e+8A4QIZYNAZA3x0fILIhMrHr8
         e6ddlq7L0hr0FLqsKLwDXXLyHsKwmATfwN2s4fV/zFCrbJFXkm9rTENAlDwftT5i44U1
         SqqiC7BQS3v+GZkvdiJdt+HvW/fGrb5ZpOt09BaIbbWBfzOjVqs59IP3c0QN1irq9DID
         SHgo56RnjEnNQvTYEgtGLbw7z6ID8KIBl1argXOU3AfFqfICVwvjXKvSGESE3jJVvZv5
         gT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9AIm6DN48ankAafEBRPujrUBGThinGUo487AT2ZYnI=;
        b=SfBaKd0tAP6KU1hL6E7FWO10Bh7l+FkfOPENUEbL4zT3kfqdyGcO4Fh4MrcoK42U+C
         QJqGnWQib3lUYgIiYujMxQzWJlRlk38BK58bHLzO/IS3j7sySCW+9yiiL/JWHhyJ//Pl
         XDjOL/nK+UlmAvRXEGLBbn+ep24oLkRpxT+MaY15PyOfY0LhUXC4wWpbEnhBIKW3Pw3z
         OZiFdUg2AtBhesO31cKOeGLqdUiM27FHOLkhU1tVMaHDCMD325nhwRFuXSxMqlTxkayT
         beWNP7z7q3FCVxs8mL8YzNElfs47oO1DeP8r/JH3qnUbCfDsEooecdicv6muCWcOTSGE
         /+/w==
X-Gm-Message-State: AOAM531+cTabyqXj/Mn2Lps5vDScKfDIykbNuZRDPvdynVUAbafpPGWe
        JkjD1505nYuZTMDSp54Zldbpsw==
X-Google-Smtp-Source: ABdhPJwB1mMz13fdwTdLFRo94oXfjU9s2n7IjStxG+8rt5MiF3WPL9xa7EiW5xM+AuxznQKTH5Do/g==
X-Received: by 2002:a5d:504b:: with SMTP id h11mr56401217wrt.160.1594201477900;
        Wed, 08 Jul 2020 02:44:37 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q7sm5567838wrs.27.2020.07.08.02.44.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 02:44:37 -0700 (PDT)
Subject: Re: [PATCH 10/11] ASoC: qdsp6-dai: add gapless support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-11-srinivas.kandagatla@linaro.org>
 <62af11d3-db26-a31b-00c8-9d78b11862cc@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <04a7f696-e23d-5563-7cc3-aedfaf2c7636@linaro.org>
Date:   Wed, 8 Jul 2020 10:44:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <62af11d3-db26-a31b-00c8-9d78b11862cc@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for review,

On 07/07/2020 18:07, Pierre-Louis Bossart wrote:
> 
> 
> On 7/7/20 11:36 AM, Srinivas Kandagatla wrote:
>> Add support to gapless playback by implementing metadata,
>> next_track, drain and partial drain support.
>>
>> Gapless on Q6ASM is implemented by opening 2 streams in a single asm 
>> stream
> 
> What does 'in a single asm stream' means?


So in QDSP6 ASM (Audio Stream Manager) terminology we have something 
called "asm session" for each ASoC FE DAI, Each asm session can be 
connected with multiple streams (upto 8 I think). However there will be 
only one active stream at anytime. Also there only single data buffer 
associated with each asm session.

For Gapless usecase, we can keep two streams open for one asm-session, 
allowing us to fill in data on second stream while first stream is playing.

> 
>> and toggling them on next track.
> 
> It really seems to me that you have two streams at the lowest level, 
> along with the knowledge of how many samples to remove/insert and hence 
> could do a much better job - including gapless support between unrelated 
> profiles and cross-fading - without the partial drain and next_track 
> mechanism that was defined assuming a single stream/profile.
At the end of the day its a single session with one data buffer but with 
multiple streams.

Achieving cross fade should be easy with this design.

We need those hooks for partial drain and next track to allow us to 
switch between streams and pass silence information to respective stream 
ids.

--srini
> 
