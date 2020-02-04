Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA1C3524F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC2220732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="BrjeL9Qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBDCvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:51:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43090 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgBDCva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:51:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id z9so8793157wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=325lqkSDMMWaBbJgLVgP2ODozFzfO6WA9dT9uwSiycs=;
        b=BrjeL9QiNkL5n/ulUmoBejQ/k71MXIMuV8g+UV2GFsXj/FA2TgaZMOqLXXOgjSK0b6
         xTQn1QmWn/WjyI5mpAcscdlvWXaCKIn+DRciPDX8m4E5NWnOFlwq8ttBgyh+mfmc26Wg
         fZDsNkaAXKblnrRkLKL3AtyXdpTjeloGDqnpKpJVMC6ulejxBp2/sB2TmKtioDoNt9op
         x7HVk1x50w+4njRBK0idi+iGB5I0tK7ajDPkFj2elkhaLG9/eR9ibEU4oeHzv+tozAEa
         7/xB6uOJNFkS2N5tB9/RcfGIZTN3b8BC5IfWgIO7vOAS5PW2Lur4y/g4VVWhUdU9XwNj
         8mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=325lqkSDMMWaBbJgLVgP2ODozFzfO6WA9dT9uwSiycs=;
        b=PPxecAzJOROShCyKlq6F6r9zRzSqtRWTrF2UgsO2jFpmvSPprkCzbVQzDOqrnWkKw9
         wr+WEHO5p+6ByYuuJg3mt2LUOjWtnY8Cr4WD8smI42MotFje0quytLGPXBaBCIIpK5dQ
         3/2F+JWaFtmuznge4o71EZhic1Vn/1R7dMrEWo125oclZeQte6a7n4VOhBc/Al8986+H
         uscV+/wYRlIDZHgpFs+SgUTX1r3Ilb9TfP+4clq0fvVOVVjMWSee+h6pU/3Rbqn3NymL
         NUZd65qOItGgBnfzXxH60uKABynNVZ68nSMlFKW8xpOU45XvRrlvHYEEmSYS/Mne/oQW
         wzrQ==
X-Gm-Message-State: APjAAAUbhdY149xZchc1SXEDkWLRWv2LJoMNpkr1KPoJRtJUeVyR7zE1
        xBSyDtb1rBpHtWr2VIgy7dtxgg6Q+M4=
X-Google-Smtp-Source: APXvYqyaUrAWqdp0Ep7HCJzxg0S98QuctD/y5iRD9CgA6my5m9ml2y3i3n+yWbZMsPSE4FROP/EQbg==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr14291242wrw.187.1580784688422;
        Mon, 03 Feb 2020 18:51:28 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c9sm1691940wmc.47.2020.02.03.18.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 18:51:27 -0800 (PST)
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
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <9483dfa0-15ea-e9ed-79ee-3dcf97e98136@nexus-software.ie>
Date:   Tue, 4 Feb 2020 02:51:31 +0000
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
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> new file mode 100644
> index 0000000..57476ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> @@ -0,0 +1,43 @@
> +* Qualcomm Technologies Inc Embedded USB Debugger (EUD)
> +
> +The EUD (Embedded USB Debugger) is a mini-USB hub implemented
> +on chip to support the USB-based debug and trace capabilities.

on chip to support USB-based debug and trace capabilities.

> +
> +Required properties:
> +
> + - compatible:  Should be "qcom,msm-eud"
> + - interrupts:  Interrupt number
> + - reg: Should be address and size of EUD register space
> +
> +EUD notifies clients for VBUS attach/detach and charger enable/disable
> +events. The link between event consumer(i.e.USB controller for vbus
missing space
consumer (i.e.

> +attach/detach event) and EUD is established via a directed graph. EUD
> +act 
The EUD acts

> as an output link and clients of EUD as input link of this directed
> +graph. Events flows through the directed graph only during debug mode.

Probably this is a very obvious question but, you mean debug and trace 
events or do you mean VBUS/charger events?

> +
> +An example for EUD device node:
> +
> +	eud: qcom,msm-eud@88e0000 {
> +		compatible = "qcom,msm-eud";
> +		interrupts = <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0x88e0000 0x4000>;
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			port {
> +				eud_usb_output: endpoint {
> +					remote-endpoint = <&eud_usb3_input>;
> +				};
> +			};
> +		};
> +	};
> +
> +An example for EUD client:
> +
> +	usb3 {
> +		port {
> +			eud_usb3_input: endpoint {
> +				remote-endpoint = <&eud_usb_output>;
> +			};
> +		};
> +	};
> 
