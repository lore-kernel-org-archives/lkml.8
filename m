Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C79C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 03:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D88E20732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 03:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ntq0vDAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBDDRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 22:17:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42202 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgBDDRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 22:17:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so21029985wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 19:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zAILjWnGpR64ApE/VIc16t+QeMtOijCsh2+8KuWkxNM=;
        b=Ntq0vDAxIs6ev78entCJdSxSUuM0k0WAGpR2ZJzcYs03/Dp1l7PG7KeAsssfpi24nr
         1m1rww7xW+L8OEysYDJXFa1HG/+fK0QkXTvRDxjTjbW+5IDzEmZjbr9XL/zg5wZsNvaf
         Y36nZ90AotUDCaWWf6jgkHPA89lgppcxLHWUNHWGIshHY31rFveoL225WlzGdvonoxVX
         Ar+ZIVG2K7Lm9hxBgpHpLhU4rgbNSeNcGbyGoTu2CiXEq1Tg7jeVYkqIwBQgTI8wlJDH
         4LvwBrIxMMZKNOarI6SOUPHxZNry0odxUi4tJ5vqR8JPsX3L3A4rGe2Y0XGWBibJJzdk
         5XTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zAILjWnGpR64ApE/VIc16t+QeMtOijCsh2+8KuWkxNM=;
        b=gFLZGGOc8PB9rGjNxRk0MZGbmmC/9foaVcPhQTa4INx9NDy6JnZhjpoZ2BRB/53WT8
         PWE/XfFadsjadNocHtbPm8bFlIc7odYPQEP8BYsPf5V8MNbeAc5M3ssbCm0KrYH4Tv0J
         S6+OuT/B7i8FuO/4GNuidlAYA81sacKdU5t6ICfkaxyMpaA8PJzLbU30tMq9eRtPnv1B
         fxzJxzX+pmmvNlcsW1VvVPm8fLZcOobDBIUAUV63bDjQpURwdAa1y2uaFAH0aLIPD4Wl
         q2W6bri0a52jOBofr3ylCpfiQLNoGnJ+wYAqg/ZOEMsyy+s/6oJqNIugWY74i/I2HeJ9
         iqqA==
X-Gm-Message-State: APjAAAXBcHeTpa460Ye2lPq/QXBtHGIMHMwgWk25mnu7RVu23EEZb+8t
        XtYtrVKtJVNzD3ENDJ1kAEVRg0njSqM=
X-Google-Smtp-Source: APXvYqxAzH2Mr4YWUjg4UzrS6BI7zknPs9nKRaCBTGplTtPRA5N0czrnd+fmuMX7DOvPF4/YBKnfGA==
X-Received: by 2002:a5d:6451:: with SMTP id d17mr14714946wrw.255.1580786258746;
        Mon, 03 Feb 2020 19:17:38 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id y185sm1923831wmg.2.2020.02.03.19.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 19:17:38 -0800 (PST)
Subject: Re: [PATCH v4 1/2] dt-bindings: Documentation for qcom,eud
To:     Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org, rnayak@codeaurora.org,
        satyap@codeaurora.org, pheragu@codeaurora.org
References: <1580445811-15948-1-git-send-email-akdwived@codeaurora.org>
 <1580445811-15948-2-git-send-email-akdwived@codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <f06e6af6-5045-ce75-fcc6-e07890b3a29c@linaro.org>
Date:   Tue, 4 Feb 2020 03:17:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1580445811-15948-2-git-send-email-akdwived@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2020 04:43, Avaneesh Kumar Dwivedi wrote:
> Documentation for Embedded USB Debugger (EUD) device tree bindings.
> 
> Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> Signed-off-by: Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
> ---
>   .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  | 43 ++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt

Forgot to mention, this file should be described in YAML.

./Documentation/devicetree/writing-schema.rst
./Documentation/devicetree/bindings/example-schema.yaml

---
bod
