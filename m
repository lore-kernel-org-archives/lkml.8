Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6AAC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE722085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMXljtYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBJROB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:14:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51508 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgBJROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:14:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so66900wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6QO5silzydkt0yEhC4NmJJauJoMXe8lq0S5SvnaM2xE=;
        b=aMXljtYmtaulEwFUbTj9+nhuffnDZ/MDaMKem8UNvXITcIlAyi84kpd0cllskVrEOz
         1vg0NC1F4+AOdk6vlQYTgmHiJuarHgzO4HpNzqSFbYyN9sXXHdwWmnXGh3SaijIj1BVH
         2O+fwefq1rMgfrIYrQ0AaLve99u+VK3sQSfqbPgTTh2eeMKb+IBQazXTL7QxEABbka3Q
         YfzqAUGaFZf1JNKWl2aWzVecCmVx8FgKROL85B583d8Ncprl3IfFOwfcGKR6yFtE5aMk
         VxySgp7BsQS7albzzuG17TXN2H3Fc1pTQhVS14dgxVMf8pNQRPCBHR4XNuZ6cQdnmo3o
         JVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QO5silzydkt0yEhC4NmJJauJoMXe8lq0S5SvnaM2xE=;
        b=icLmMEJ/tVyboIEVG1GWK01f/HDwiilyJRsdnlzF4hn/N+QaCO1Vdy109OiDjcWIVe
         dL7TSIY3K1IzeGLO5u5kgCUEQE/Oach8Yze0ZXyiYE/tH7RnTX9JUy3LM6zSvsvfqBKI
         iTMPnkAb+ooxSsw9sdV8t6TXHBEXN3KbHaq/imH+d1pQV5Hyg86N5Ch/7Shz2WLE2Apa
         Hyx2kFW63O/UEeBmO5cn+pN2Pg6qN457ngRwm0hL93xXgCn7BCz9wMx8939fHamCGWCQ
         JEcMDLtyKnKQtpLss+oD4FLLLZCurrPG33ggf9WUyYGNYl7ZsMGC6I/tKaMh2JS+UAix
         yXNw==
X-Gm-Message-State: APjAAAVaqGp7e3yOLwhh9LrCkiIX+iZvLsGTM0EOTbVcJDuHlFB9e27/
        xamVXLySM5JrPnxHg4zp+HyRTFaBPLs=
X-Google-Smtp-Source: APXvYqwfej4Y9cv7uzUU3bRN24Smc8vOxuiVDdH7q0FalpK/QSoS39/ifGPuVhODur6Q81JC88x27g==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr5331wmf.75.1581354837581;
        Mon, 10 Feb 2020 09:13:57 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id w22sm356wmk.34.2020.02.10.09.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 09:13:56 -0800 (PST)
Subject: Re: [PATCH v2 1/8] ASoC: qdsp6: dt-bindings: Add q6afe pcm dt binding
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
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-2-adam@serbinski.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f70e0ac0-c78a-fcaf-6572-0052b563b724@linaro.org>
Date:   Mon, 10 Feb 2020 17:13:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200209154748.3015-2-adam@serbinski.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/02/2020 15:47, Adam Serbinski wrote:
> This patch adds bindings required for PCM ports on AFE.
> 
> Signed-off-by: Adam Serbinski <adam@serbinski.com>
> CC: Andy Gross <agross@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Liam Girdwood <lgirdwood@gmail.com>
> CC: Patrick Lai <plai@codeaurora.org>
> CC: Banajit Goswami <bgoswami@codeaurora.org>
> CC: Jaroslav Kysela <perex@perex.cz>
> CC: Takashi Iwai <tiwai@suse.com>
> CC: alsa-devel@alsa-project.org
> CC: linux-arm-msm@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>   include/dt-bindings/sound/qcom,q6afe.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
> index 1df06f8ad5c3..f3a435a112cb 100644
> --- a/include/dt-bindings/sound/qcom,q6afe.h
> +++ b/include/dt-bindings/sound/qcom,q6afe.h
> @@ -107,6 +107,14 @@
>   #define QUINARY_TDM_RX_7	102
>   #define QUINARY_TDM_TX_7	103
>   #define DISPLAY_PORT_RX		104
> +#define PRIMARY_PCM_RX		105
> +#define PRIMARY_PCM_TX		106
> +#define SECONDARY_PCM_RX	107
> +#define SECONDARY_PCM_TX	108
> +#define TERTIARY_PCM_RX		109
> +#define TERTIARY_PCM_TX		110
> +#define QUATERNARY_PCM_RX	111
> +#define QUATERNARY_PCM_TX	112
>   
>   #endif /* __DT_BINDINGS_Q6_AFE_H__ */
>   
> 
