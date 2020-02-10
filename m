Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45930C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E80206ED
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQ5SjqjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgBJRlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:41:04 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45536 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgBJRlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:41:03 -0500
Received: by mail-wr1-f50.google.com with SMTP id g3so7783167wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3gIUz/+oLLuaq19t30k8Jz+s5aA2PVpnAzXQO10cT/Y=;
        b=FQ5SjqjI8mESjcAV3hk0fQYB1DIjyI3CqJt/Aw53H9qwncQV+lCBRMSjQ9ez4AuPS9
         TO7MkvREuIQeW/8B7MTc602yDlTEDGJeJW2aW15lFEJSUDTv2cwNH3coJVWJL3uztvdQ
         8eHriud893T21Xf6LGypKFQcYCVPSKUIVcn9fWTNO9j2jF7Gi+iZQB+cDdbI9YZ6YoZP
         CEWpAt/4hPKW5geh6ytp1UpQN70S1ciZz061CDJL/aboGKgm4pnl8PidJ06uNY+3yli9
         DN8AeGMPwJZDOSEWRrpTIa0PI6WclosM+d3+AeBamTiIZPLsF35gyimD/PAgQIksG9ab
         r2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3gIUz/+oLLuaq19t30k8Jz+s5aA2PVpnAzXQO10cT/Y=;
        b=Y2fBOT0FKVUVDFgqUP7PTPW8h6Zrpp8sqW2v3oUAbfto6r0PD4/yiz7Oc+LmRClFcX
         jLa4M0RwIQm5EbMERzakSB1esk0wi3/K5llBsP+02N52uILbuBtZgjg1JlVLYZ6I1/Cp
         D138Du755OE2GYTt2ka2Mx0uP8sdoUDrHLF98MRNei3Wizd5ua49GBmTBxVgvkjI0wOW
         NiJoLmFZ0IL/rutVS/nK10nBVHaVTaXsTnl4axnWyfD4cC8s0TrsWJhus96Rx6SUDBzM
         i+7av6WtgLHePbjM1MAyyIY8cwO2H2axl4mIhlPEHMqFQEZbMQ/OYuRTXv4ElGPIwhux
         MfoA==
X-Gm-Message-State: APjAAAVu9HndMxCZmSxy/UK2OEUDFMBRP4xjpwvnxC6+EmYNnFZsNCwv
        RSyRHH4wwKRZEnONLbEP0u9KtygNMVI=
X-Google-Smtp-Source: APXvYqwbPVn4r/e2i10UW5NrTzU1jT70XhhtfiutTlrnJyFJyV3h+DHyidgLZwaetvsInEsC+lSh5Q==
X-Received: by 2002:a5d:6292:: with SMTP id k18mr3078880wru.256.1581356461456;
        Mon, 10 Feb 2020 09:41:01 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id o15sm1401166wra.83.2020.02.10.09.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 09:41:00 -0800 (PST)
Subject: Re: [PATCH v2 3/8] ASoC: qdsp6: q6afe-dai: add support to pcm port
 dais
To:     Adam Serbinski <adam@serbinski.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-4-adam@serbinski.com>
 <d0437f6d-84c8-e1cd-b6f5-c1009e00245d@linaro.org>
 <616e3042f46cb7f052fc71e0ba4919a2@serbinski.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5464ab87-f711-4aa6-3f22-f27bf4819998@linaro.org>
Date:   Mon, 10 Feb 2020 17:40:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <616e3042f46cb7f052fc71e0ba4919a2@serbinski.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2020 17:22, Adam Serbinski wrote:
>>>
>>
>> Why are we adding exactly duplicate function of q6afe_mi2s_set_sysclk 
>> here?
> 
> It isn't an exact duplicate.
> 
> The reason I split off the new function is because the clock IDs for PCM
> overlap/duplicate the clock IDs for TDM, yet the parameters to
> q6afe_port_set_sysclk are not the same for PCM and TDM.
> 
we should be able to use dai->id to make that decision.

--srini




> 
>>>   +    SND_SOC_DAPM_AIF_IN("QUAT_PCM_RX", NULL,
>>> +                0, 0, 0, 0),
