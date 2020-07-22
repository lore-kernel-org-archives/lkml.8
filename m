Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421E5C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E47B2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5yOvdZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgGVI7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGVI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:59:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD7C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:59:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so816944wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SP0c2GvVtx+b6Ros2vCvfF+tahmqr0w4KW5Dw5alhsY=;
        b=l5yOvdZOx14odmspvktZ7ZTu76/nmkS1cWsDzX94SFiOkrV0hbJwcFFPbgt8paY0RL
         G1SbejDEbKDVq9SsZl0fdpJOqtk3oocOJgfonM9TBE7wkMa3H7RAQe0zbleqzmVedyc+
         SLb9mLEP1prpZcd5DLiAnfeUMZKCqN/21rQO0/HnykTap37/0POixzHi9BAZCD57vFpg
         ebdKo+HmKBZ2H0rN/G98XncTWXqd2ZhYlA2aZ0C0N4DTTOCPIxLC5iuRcN1rejeiCcrc
         PV0FI8DvfpPLdoEuGMBSHDMr/hG6yy+M/CA8US5yAbawyh9TB3CpIbN62RHJ+UiTDOe0
         Iv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SP0c2GvVtx+b6Ros2vCvfF+tahmqr0w4KW5Dw5alhsY=;
        b=S5Cxx3fqpPZTiHe8uM1ppDZQv983euIEiShLzvtoGpYFn4qpJbx8c0GPWumtZLNOL7
         gk2V1rClEnRL7CqlcrrJ/+Isg6dEQpggWaSGhUC6vs0+wsLPHMIQVdMhQsY2cnsWZlpv
         VMBeIYauqFj/cB649tX+5OvsysYi22XQO6URwdt61JejgPyxhaWQ9RnrjwDkU+9gTiTN
         iJnhSIvKtqFaaWfb4fr3MNoN2yszJb98EPlZLdQAXHfxQUisTg4Wtank0UCpn7+A8DsP
         AGwN7wuK1OTNOkByRzji+EdgReVX7x9upRxYJWxcuWPPMRXVt2FW4CQa8qWSnxGTj75E
         qwUg==
X-Gm-Message-State: AOAM530bJykL+pC3QUqWw+2XNwwMQEwQwuu6DEv6wKrtqFJ6rQeyRtXu
        812COVnincH6XsJJg4kQsCkzPT0zUAA=
X-Google-Smtp-Source: ABdhPJzcZw2BFFndFeBVpKiOt0sEkVRTdh8x+EnHzkiSU67L4IGJk2d97MA+9BAcg+AS+XqaVp3Psw==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr7591733wma.9.1595408388682;
        Wed, 22 Jul 2020 01:59:48 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t14sm28577281wrv.14.2020.07.22.01.59.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 01:59:47 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] ASoC: q6asm: make commands specific to streams
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
 <20200721165306.29082-3-srinivas.kandagatla@linaro.org>
 <52075b51-2053-573a-4cd0-685d3d469bdf@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2a1e0045-84b9-6c8b-74be-aa5cbf318427@linaro.org>
Date:   Wed, 22 Jul 2020 09:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <52075b51-2053-573a-4cd0-685d3d469bdf@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for review,

On 21/07/2020 20:31, Pierre-Louis Bossart wrote:
> 
> 
> 
>> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c 
>> b/sound/soc/qcom/qdsp6/q6asm-dai.c
>> index 941f3216399c..fb0488e7beb9 100644
>> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
>> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
>> @@ -67,6 +67,8 @@ struct q6asm_dai_rtd {
>>       uint16_t bits_per_sample;
>>       uint16_t source; /* Encoding source bit mask */
>>       struct audio_client *audio_client;
>> +    /* Active */
> 
> nit-pick: what does this 'Active' comment try to say? the stream_id 
> seems to be used for RUN/EOS/CLOSE operations.

Active mean its the active stream id which is consuming the data at the 
point in time. As we toggle stream ids between 1 and 2. This active 
stream_id is used for every command sent to dsp.

> 
>> +    uint32_t stream_id;
>>       uint16_t session_id;
>>       enum stream_state state;
>>   };
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
> In the V1 review we discussed this
> 

Sorry, I missed that! will address this in next version!

> "
>  > sound/soc/qcom/qdsp6/q6asm.h:#define NO_TIMESTAMP    0xFF00
>  >
>  > is the change on the previous line intentional?
> 
> May be not!
> 
> Plan is that the users of these apis will send flags directly instead of 
> boiler plating this!
> 
> This change should go as part of next patch("[PATCH 04/11] ASoC: q6asm: 
> use flags directly from asm-dai") which would make it much clear!
> "
> 
> doesn't look like there was a change here?
> 
> 
