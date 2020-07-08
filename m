Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC79FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01932067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fpjx3n8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgGHJoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgGHJoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:44:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809B3C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 02:44:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so48109829wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Jns/yX+3aClnQNyC+2ax+ymiJLw8nGPUIjOZoROxiY=;
        b=Fpjx3n8ZM6TtASQQ3MqccK2166U6UtGHVdKdKpM3ddmRW6w37DoBJGZeWy3playtH6
         XMn4zZPaScEpr/td03Xw+MaTulQdOgQz1sXzldnbiLDhXcQiOsS0RGVFQe6SZDzeeqGq
         vfArGvSMPUBdeBTY0OkzS32iiNEAnprj2fXz4EoyuqeSL08SBbp84UpDl/ENkgNBihxC
         Gd9R0zJmsL6dmFREtzOW8xeg+yoUxlnaYF+KyjfUs/3EnYuVToJ+WO0oAoecIoSQXscS
         irB3j5n875UM7DbOon8DS4aGeQzoTG/zw6U+uwJW3wYd8Ne6/Y3YbtC9e1DsKmqC/cuK
         XGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Jns/yX+3aClnQNyC+2ax+ymiJLw8nGPUIjOZoROxiY=;
        b=D3VKeNu0sBlL8NG5hTVt9hmTxeg9uxCkK+8QrTzADRIMybYHuXsag/K8WF+W8GofdP
         aDFrnGzkOvh0vii5qc5MURGIWUiibc/3dDDx7qV/cBpp/r4rvxMxNwBg9Am1gkOhGgCB
         LwMMdlYptrDhLzoC0TY19QnE5jgB6m2Wbzk4Uy26Xc9Y+d0PrHoyYzcwJpvfTfXmC9u9
         NmBX93wpr3Fh0hWrwsjR0QYZPrgxZbQXcvBQAurP7e7oJS3UJyq65NifO18Q5oRiMoh7
         gQXvvBrKPPaniquKLv7O97MN4JfeUnfKQ3uEAyywUKxJKzECDcNZwaQnH+8O+QTM1ga3
         tiJg==
X-Gm-Message-State: AOAM532+Q0rQAo5hGVSISBHPsSjA996IQFroebffa34cKiX8XCm22oXF
        mWQWCjO+7AsB5qHZ6NAPlMY/rw==
X-Google-Smtp-Source: ABdhPJyOe8hm51EM8jb8HvCuyASFEnECIqcU4tIDM0/F7Tr+eWobQ0z+voWarZPRT+sExqYKK2NL2w==
X-Received: by 2002:adf:ef89:: with SMTP id d9mr61277066wro.124.1594201461254;
        Wed, 08 Jul 2020 02:44:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y77sm5640094wmd.36.2020.07.08.02.44.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 02:44:20 -0700 (PDT)
Subject: Re: [PATCH 03/11] ASoC: q6asm: make commands specific to streams
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-4-srinivas.kandagatla@linaro.org>
 <9ff595b4-1093-36c8-f27f-f097e24657a0@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4eedae20-903f-77c6-c6e9-fbf3db209bcf@linaro.org>
Date:   Wed, 8 Jul 2020 10:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9ff595b4-1093-36c8-f27f-f097e24657a0@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for quick review,

On 07/07/2020 17:52, Pierre-Louis Bossart wrote:
> 
> 
> 
>> @@ -184,8 +186,8 @@ static void event_handler(uint32_t opcode, 
>> uint32_t token,
>>       switch (opcode) {
>>       case ASM_CLIENT_EVENT_CMD_RUN_DONE:
>>           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> -            q6asm_write_async(prtd->audio_client,
>> -                   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
>> +            q6asm_write_async(prtd->audio_client, prtd->stream_id,
>> +                   prtd->pcm_count, 0, 0, 0);
> 
> sound/soc/qcom/qdsp6/q6asm.h:#define NO_TIMESTAMP    0xFF00
> 
> is the change on the previous line intentional?

May be not!

Plan is that the users of these apis will send flags directly instead of 
boiler plating this!

This change should go as part of next patch("[PATCH 04/11] ASoC: q6asm: 
use flags directly from asm-dai") which would make it much clear!

thanks,
srini
