Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1643AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A3A2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mO2Z3EWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgGHJo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGHJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:44:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C6C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 02:44:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so25884131wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CU3teNK4ks5V+nQ8QE1n/8I+d2JYVjp3ohi8QaUE2+A=;
        b=mO2Z3EWxs2SyDUrComTdddyIotT1xafU+QNTaEs96rLfhca1Nbi6y1EnOhWbf75ms+
         c1srnsfalQGDoomtkmtiY5uMJuMRU9ba5pPkAgvgvoOJORvy2Rsu6ckijDb2Ze7FPfNM
         AtE044uKQmWu/ZMcRp1dg6ueVYGXaHg5Zx9aFXiyDuaJof+z6X7QfhDVJe1LHRdTUvm9
         v2dRFC3afRT7GWBAYY2S/wT0Tb07Pt2Yy5Df6VmWKtMgemyXzGAP8EvPgrUPDaIYcB+2
         JPuS/OCJnWCYAFfi3SyW0oFY6w+ku3pDOzJeHRpL5syBxYUrFTO22mEZXUBkyz4EljDa
         TxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CU3teNK4ks5V+nQ8QE1n/8I+d2JYVjp3ohi8QaUE2+A=;
        b=l0cU0/hhIawK/9mYr1gaEisqZIXd3FcEw9lT9TosZsL7SL2XIDVVW+8c6ec9OMwmR2
         QwTB5U9fH9NUnM2s2LxFVCAtbqRoUlLkkfwC5Ruqz20xmTni4td2t3tLfiWdYGAMlmT8
         InuJ8wCnfiYiTEOtHg/gQVC3t7ik+g6oO1cv/WRhXSbkLs1JeDgs7h7tXfrwAUeW3NTy
         lfPPtwEgYZJXG0e5gR4KmY6nMzAoBkdURa3vQ/asys/ftWSLusSHVff0v2zjXVf2qEqw
         Q49bGNweOGaOenmfW4UPMAZgA2owlRhh39mv5yC2xO7BsVb8JuQy+93nhtIIg8pd+D0a
         5WJw==
X-Gm-Message-State: AOAM530Q91GelfmPzUNpT6dWeWCc1vCSqYcSLKM8Gomu92kqbKf0j1Xg
        xle4h+Wpz5Yi20Ooo3vRMlzGu3RNzoo=
X-Google-Smtp-Source: ABdhPJzoQSbQ3K7dl6+kZu9qeVvMuXnB1kvnRfVepdCezPHL5RgNw0zEqV1nz8vpJGK+tGX3m7noOA==
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr59916781wrw.2.1594201465666;
        Wed, 08 Jul 2020 02:44:25 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t4sm5443551wmf.4.2020.07.08.02.44.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 02:44:25 -0700 (PDT)
Subject: Re: [PATCH 06/11] ASoC: q6asm: add support to remove intial and
 trailing silence
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-7-srinivas.kandagatla@linaro.org>
 <dd0d970e-109f-9a41-f2b9-a970e4d20caa@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <08d9598d-2ae7-3da8-752e-b588c8ebdd61@linaro.org>
Date:   Wed, 8 Jul 2020 10:44:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dd0d970e-109f-9a41-f2b9-a970e4d20caa@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for review,

On 07/07/2020 17:55, Pierre-Louis Bossart wrote:
> 
> 
> 
>> +int q6asm_stream_remove_initial_silence(struct audio_client *ac,
>> +                    uint32_t stream_id,
>> +                    uint32_t initial_samples)
>> +{
>> +    return q6asm_stream_remove_silence(ac, stream_id,
>> +                       ASM_DATA_CMD_REMOVE_INITIAL_SILENCE,
>> +                       initial_samples);
>> +}
>> +EXPORT_SYMBOL_GPL(q6asm_stream_remove_initial_silence);
>> +
>> +int q6asm_stream_remove_trailing_silence(struct audio_client *ac, 
>> uint32_t stream_id,
>> +                     uint32_t trailing_samples)
>> +{
>> +    return q6asm_stream_remove_silence(ac, stream_id,
>> +                   ASM_DATA_CMD_REMOVE_TRAILING_SILENCE,
>> +                   trailing_samples);
>> +}
>> +EXPORT_SYMBOL_GPL(q6asm_stream_remove_trailing_silence);
> 
> do you need those wrappers? Might as well call the _remove_silence() 
> function with the right parameters, no?

Intention is to abstract out the CMDs within dsp specific wrappers.
This is how rest of the apis are also done! Also its possible that in 
future these IDs could potentially upgraded on different versions of DSP fw.
Making a single call would mean that either CMD IDs or some kinda of 
other intermediate flags.

So I would like to keep it as it is for now!

Thanks,
srini

