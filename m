Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA879C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59562070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bBlb7kK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBRTHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:07:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40197 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:07:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so8442160plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XDlxGgCpGeqU3KzfKq+0G+pODQzyu67LnVcRDv+D+D4=;
        b=bBlb7kK0umzlqU+tMcH3s28HrHzKVOWGYgR0f+WFk8H08TYaiaZTu70twpujC0wnlL
         jvPAxB/i9TZ8TfXzYS00HfBLRn4AaFjHwPpED0345d9rY2hlt8VFBYtOMONkmQRbfwLa
         SfRGM16Ck3w2GMG+0yDfUWHKyfaxFrHzkq4HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XDlxGgCpGeqU3KzfKq+0G+pODQzyu67LnVcRDv+D+D4=;
        b=W749PCOdMc4Xd8b0IFB1byaeA8+4MsEfsN/YIFmLPT7erDKzHJqa6N7AkTX/OVZYlz
         34oGJIlZrplebLwJDMW7a3sYNlF78HkU1Sm/fbUmO7cM+IU18BajLaB9nsUmS2Qa+nbh
         oiAbVN2WWWNxwqpMvw9ecud6a8I4nV3nCoovf1MAbeR2Sc+LVlxFqlNZy1FGljpWjGG1
         IWPD6wiuqj3JILKiuJXZZX6wXoy+LBKmblME7ZSgRTC5p1XAFnaE2vukHAfrVRnSvyq8
         iRoA31HzGuyrj1bDS3ooI0gTaOuFSCNHPeI0ryG+vPmRKWUkw2yqF2HCLagsJI1jVApT
         qn7A==
X-Gm-Message-State: APjAAAU+8GGniikwR4qJypxEQY9FB2Tqs+N45i6m5ZssbyJ5L72Ds44k
        upcj8Ri1Smq15HYhRaKGLI3n9Q==
X-Google-Smtp-Source: APXvYqzQ9M1KsgU04ibpPhVZLv0ZY49qRY006V1Xcr4FsYN69DcQUVER/9RLVtPWkxP6bYsZHXAfTA==
X-Received: by 2002:a17:902:b718:: with SMTP id d24mr22854885pls.80.1582052854867;
        Tue, 18 Feb 2020 11:07:34 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id q25sm5175786pfg.41.2020.02.18.11.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 11:07:33 -0800 (PST)
Date:   Tue, 18 Feb 2020 11:07:31 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org, swboyd@chromium.org
Subject: Re: [PATCH V4 3/3] dt-bindings: geni-se: Add binding for UART pin
 swap
Message-ID: <20200218190731.GC15781@google.com>
References: <1581932212-19469-1-git-send-email-akashast@codeaurora.org>
 <1581932212-19469-4-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581932212-19469-4-git-send-email-akashast@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akash,

I didn't see a patch that implements the binding, did you post it?


On Mon, Feb 17, 2020 at 03:06:52PM +0530, Akash Asthana wrote:
> Add documentation to support RX/TX/CTS/RTS pin swap in HW.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> index 11530df..7e4b9af 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> @@ -165,6 +165,15 @@ patternProperties:
>            - description: UART core irq
>            - description: Wakeup irq (RX GPIO)
>  
> +      rx-tx-swap:
> +        description: RX and TX pins are swap.

s/swap/swapped/

> +
> +      cts-rts-swap:
> +        description: CTS and RTS pins are swap.

s/swap/swapped/

> +
> +      rx-tx-cts-rts-swap:
> +        description: RX-TX and CTS-RTS both pairs are swap.

I don't think this option adds much value, if both pairs are swapped
the above two properties can be set.

> +
>      required:
>        - compatible
>        - interrupts
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
