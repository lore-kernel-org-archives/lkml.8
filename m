Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063D0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2440206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaV8G1BF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgGGV7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgGGV7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:59:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E63BC061755;
        Tue,  7 Jul 2020 14:59:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so43864107wrw.1;
        Tue, 07 Jul 2020 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hP5lKsxCUbdC6kqyhMJGnecNGTvBw/vIA2MO2AsuiYY=;
        b=DaV8G1BFj0dYJjK188o/2xGmMS/z+kmMprdUpAWW4Z3I9z8+lEM5Luwd+1RP3xevuS
         /zCauslHt69qtvCmlFfS6+/uryRpj5HI08bIr5mYNWvHWKpj9ck0FZ5dem2rec2L73RG
         6XmQbNRlNJGv9Zj37/vlCNxBzDx393f0pDOWRC7DeHrahdHjUOFnaF7MbP7EjaJOxYDQ
         xyQzTmCHkl1e5/cw1YoALosZQ+xa5+K9ZLqmiZyoEFNQIzdgBWmud1x2496aKjIWa4Oh
         KnX527KMtAf9KMREpxKVCryisNDgDrVNslhZGZEHoXY6AbIcooJBJcwibE6ontwJAHxn
         SZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hP5lKsxCUbdC6kqyhMJGnecNGTvBw/vIA2MO2AsuiYY=;
        b=CoOJXwgM3duIRvXjbgpuoaLgwvBpIglN4leW8T08nSfW3rUUcYQNzUxVZSOmvdg3I5
         BlP8I3NNAJx7Hum62ZxCxP5J9sQPPg1uL3stHgmOd970Sp0xKeZz+dqmkJvUGlRhWNkr
         J8V6dHN6dvCScb429gyMTKfl4JJ8AyCpj2mG2cV+5S183dkfgjUaApvP8q5HtTOHVho/
         N63Uo4LDHTtl06cSrjPXWrsoRNIO9UZJ/Xcq4SnoDfs4Jp+C5QuXhZdlUo2O+Vy/KrJM
         q1aO7iIetTmbenMslbIQ5HVbjDk6FYz0qvcU+MGD0mxGuLhuctfRgajB22vtyumDZ4ix
         6EOA==
X-Gm-Message-State: AOAM531KVSDYAxPDdJucssyHzN0bnXv+NbYn3nN2ZN4nlm3otZTevIks
        iDZJsRc7v45FpnM0BE8yzE0=
X-Google-Smtp-Source: ABdhPJy9H3HdBEwao2QKxERxcVTo8z9Fxh9sNnULPY0DMyAehw17s0RH7TIaQvaiA7L1RCl1JqlSrg==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr54732283wrj.336.1594159175659;
        Tue, 07 Jul 2020 14:59:35 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id h5sm3137699wrc.97.2020.07.07.14.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 14:59:35 -0700 (PDT)
Subject: Re: [PATCH] ARM64: dts: update MDIO speed and preamble for zii-ultra
 device
To:     Chris Healy <cphealy@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CAFXsbZrVZjiyO_G6z6T82t0xT36Zi2gGo0kPnt6n58R-rO3TVg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7f627cb8-2eae-cdc9-09fc-e3e612b5632a@gmail.com>
Date:   Tue, 7 Jul 2020 14:59:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFXsbZrVZjiyO_G6z6T82t0xT36Zi2gGo0kPnt6n58R-rO3TVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 7/4/2020 6:26 PM, Chris Healy wrote:
> Update MDIO configuration with zii-ultra device to fully utilize
> MDIO endpoint capabilities.  Device supports 12.5MHz clock and
> doesn't require MDIO preamble.
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> index 6a55165bd76a..98aa67a4c040 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> @@ -132,6 +132,8 @@
>          #address-cells = <1>;
>          #size-cells = <0>;
>          status = "okay";
> +        suppress-preamble = <1>;

suppress-preamble is defined as a boolean, so you can remove the "= <1>"
part entirely.
-- 
Florian
