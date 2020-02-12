Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3D8C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1A321569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9m2Yshy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgBLJxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:53:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46998 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgBLJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:53:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so1373128wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 01:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yOWsJgHXZuM43+uu9LOFAsCRPWTVXnpDLuoV98thPag=;
        b=u9m2YshyI8yy/fuehpb8RwqSIycSNchwZr20ZOFgMxXs5xH+ouy/8hhoF3kYZM889c
         C67AE0RDBV4IcsYZm5yUv2RyNrXoJfKnEc5rTgSDgDDlVeOTDeQIYmKLQv9AK3vuD8Eu
         MUZo8aIBJ6BMCdWo/FOgJkEihjDLj/KjoFquosK4p0x+5T6lBH3WVVTxh48C8lzX5kIu
         dsVq24OH2u/yGckWkaSrmGJEV02yU/ravwzaIDzsLq7YxNkbu9GO/+AYcZ+tudvDdS2B
         unAkgw1RrPhYoQmLiu7OERT/cmy/KNtb3s2gORNIP2SvP9vn4UagBbZ7dQm9plic0vHU
         oE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yOWsJgHXZuM43+uu9LOFAsCRPWTVXnpDLuoV98thPag=;
        b=l1mIvEiTi4aAyybHhv2RzioQ3aJCrxJFzOqbVKKzRIY/C0rBOGTw5qOImeh1D7RYUn
         6K//i5HkD+CQc2UxVGqK/hPEdZLGn9Hha6o41016a02bIUklIKzx/kzL96G8G4kORQff
         CeKO/1UjDMQIlZk2F1iun+l5i1q2NtVElqKjFC9xc30OgPFh62XJpT8dF46rBmerX/oB
         Y3aRVgf7eAqZTLuN0xVpWSAZrHbRyuecz//KQ/GmQ8V9FPm83W1I8b5fmlNCWp8RGqXe
         4D241WcWAcXbq0JefhGESHq7abOwFi47WjzxJLydMQohqfJ53ZQs8aNgz2VJIh8Mup+8
         zBLA==
X-Gm-Message-State: APjAAAU7T0hEvwjmzvLTeHTZh3ZFeeuA8RBiMPb+bhUK/AIl+3qzMpRG
        xynC0rfpt/jCbIJAM5JKtzD803wwrII=
X-Google-Smtp-Source: APXvYqzaWASCq9oTzeguO9TliT5Fv8gq1QYgqhC7hAV9dwbVqF9vZ/u7BBNK8pP59w0DmP/sZhKLqA==
X-Received: by 2002:a5d:5148:: with SMTP id u8mr15044395wrt.132.1581501211277;
        Wed, 12 Feb 2020 01:53:31 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f1sm8992892wro.85.2020.02.12.01.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 01:53:30 -0800 (PST)
Subject: Re: [PATCH v3 3/6] ASoC: qdsp6: q6afe-dai: add support to pcm port
 dais
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Adam Serbinski <adam@serbinski.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200212015222.8229-1-adam@serbinski.com>
 <20200212015222.8229-4-adam@serbinski.com>
 <1875fb89-6a25-0d1a-c367-183ae6980ac8@linaro.org>
Message-ID: <d0fdfa51-c4ed-4f82-149d-1ffb32e1efdf@linaro.org>
Date:   Wed, 12 Feb 2020 09:53:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1875fb89-6a25-0d1a-c367-183ae6980ac8@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/2020 09:52, Srinivas Kandagatla wrote:
> 
> 
> On 12/02/2020 01:52, Adam Serbinski wrote:
>> +            ret = of_property_read_u32(node, "qcom,pcm-quantype",
>> +                           &priv->quantype);
>> +            if (ret) {
>> +                dev_err(dev, "No quantype from DT\n");
>> +                break;
>> +            }
>> +
>> +            ret = of_property_read_variable_u32_array(node,
>> +                        "qcom,pcm-slot-mapping",
>> +                        priv->slot_number_mapping,
>> +                        1, AFE_MAX_PCM_SLOT_COUNT);
> 
> These new bindings needs to be documented in 
> Documentation/devicetree/bindings/sound/qcom,q6afe.txt

Replied too quickly!

I would normally have expected bindings patch before this patch though..

--srini

> 
> --srini
