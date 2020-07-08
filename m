Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BF7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DC52078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHi3NQ6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgGHP0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHP0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:26:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FBAC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:26:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so3663261wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rs6MPvocUji5XwIYCOn+gelVQBocwRHLVhtpEwxkopg=;
        b=zHi3NQ6B1pEluj+8pRje9dKHgoKbTqzf12bvtSJLqPgPd1PZ5P/N/fsCC/EByu/GTd
         ++8Oc6NBX8a3f5/bPCKW7JM4YnUQKD8/hAJR2PJ1Uc9vHLTPnL9e/cFg89VZjBPxvMzA
         y4BkWh5zSPAoF+FoDDhsEVdd8b6S+E1jCbnRDpAHk4hdpNP3GXOj53AHr5r8yK89s+GP
         pye/KGXh35xCAojrNnVW13bWLMqwi7ezhX/xSyPxR0U/y3l+I2x14vaCYP+bBk8+3woy
         zXWpdvdAKra2z194nEkS5/3ll8CQYGCRGxHuQIglF0ZGeS3njAoh8uv9HwlKTkLxnZZH
         a63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rs6MPvocUji5XwIYCOn+gelVQBocwRHLVhtpEwxkopg=;
        b=PoZ17HDcTO6pdZT02Oo+ja2R6/ekLGkcis+igcCLD9P1c59OYavIt9TyzwoFmRlyHA
         1pTfSH+Mz4qilfIIeOwOQQG9W2QydTuOzMgxnolpeAQv1Hu7limJDDni8W+9f2r7/OQQ
         tLGKy1vL6b28Q/0gde1NgtQ1sT0o02S2ve2cC0Sl85+xNfCFUeHFN4O/J53rP809IJ1T
         rR5c6odTYFLv/aAU3Winsa4Vf978l/7m1gQQkMOQU+SHPdZbCdtsln/KzD8UBUoJpEIy
         bh8Q9fWAtdQefVUxVpByGZNkrMZbhFkZvFJo3Xn7ujaQQIYgGIGiBw8i678snggSRteo
         +Xzg==
X-Gm-Message-State: AOAM532pe33bmbdUXxEn/GFfOtPJ5r1WjBlUWlM1CNFcp4TVR50cxkRf
        w822NJYXdRj0Lzorb5VJIqmWJg==
X-Google-Smtp-Source: ABdhPJzwmo/GYeZxAsTWJXB+WycKYqDbjAStLBPyn3jw2SSdLqcjmDlSfW2zCFpuBDE+OXnWOYizbw==
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr9955647wmb.16.1594221974686;
        Wed, 08 Jul 2020 08:26:14 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y77sm154483wmd.36.2020.07.08.08.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:26:13 -0700 (PDT)
Subject: Re: [PATCH 03/11] ASoC: q6asm: make commands specific to streams
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-4-srinivas.kandagatla@linaro.org>
 <9ff595b4-1093-36c8-f27f-f097e24657a0@linux.intel.com>
 <4eedae20-903f-77c6-c6e9-fbf3db209bcf@linaro.org>
 <20200708131307.GO4655@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <863fb181-9814-ee1e-c174-ca58ff6468f1@linaro.org>
Date:   Wed, 8 Jul 2020 16:26:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200708131307.GO4655@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2020 14:13, Mark Brown wrote:
>> Plan is that the users of these apis will send flags directly instead of
>> boiler plating this!
>> This change should go as part of next patch("[PATCH 04/11] ASoC: q6asm: use
>> flags directly from asm-dai") which would make it much clear!
> It should be in here.
> 
> Please be also consistent in your use of ASM, especially given that asm
> is a widely used name in the kernel.

I agree, I will fix such usage in next patchset!

--srini
