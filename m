Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C191C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87FE20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvmBHnBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCSMMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:12:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36283 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgCSMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:12:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id g62so1963178wme.1;
        Thu, 19 Mar 2020 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=daN7ej1V/WbdDXvs8Fgxqp9xAyCMYiSLqVG5aeGru8U=;
        b=dvmBHnBUXGiqvvQ1+2E51PjzCzn/o0oGD7PLE7ea8u0pLrC31AtHH/04xGfdBYmXEZ
         bFrsZ23yrpPVd9GhXnKVFJMFe+Z/nOVknS97xlq4HF9IUENfspVLHt0yk36Hc0D8TWWl
         RfxTZSc95T4TII146KC0tdDa9Z5XTpyBaB2T8OcPTbRVpK6JJ/zOFGvVZrDVQ695g6kn
         3CfQN9LJgEBIz3n/lbi1DaJfyWpqQFbrv9+xOJgp9XypgVB6GWkV9798vtpzBuw3ndX+
         5kBfdzL42NLgQLemfpeza4Wr4lQ+OUj3UMPNqYlEuGeMWtPad0BQZEtvtPU1VRR9eqDT
         5Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=daN7ej1V/WbdDXvs8Fgxqp9xAyCMYiSLqVG5aeGru8U=;
        b=YLXTJzoEaWVU5uxZn9DZmsdRLCtmQ28nwxg9wRCOm2UGQ5YYxcLjHmBGDna7h+mx8J
         0bGZw6s1/5w+v32Le94wKtV+KCyYzgpugHteyb849jfvfB6QY15i/AZ7q/57nEKMoE5s
         OwEw30hZ0MuFCbX+nphySFn1F+fLIHUPzHuPDzAGxUUbf83KgNgi3pLp+RvOc9hDcxNG
         XPbgotpLyODSyhyUfJqJR4vx/KhNmUiu/m31Vvp5UsdbeLHGyivzxhxy/7rz1PD8xOk9
         IbVKsQMJ2psNtHWxZyXf/IQpq1Ejj7qgdCWcbxVydtYk3NiC21oT4YCH5/7bN48WUBiP
         k5qA==
X-Gm-Message-State: ANhLgQ04qlf3DGeNwiw0JbKb+8SjCqr1Ml8t9xjoHqe2zzpYSQ6snamO
        0VmKNIxSVZfA6BwvAhO80YY=
X-Google-Smtp-Source: ADFU+vsWdNexPTrldLcXBS702PY8o8wIPXwP8saxqT60mkVJ/ps29oW5lL6dM5+K82yyY3AUWrKxag==
X-Received: by 2002:a1c:9d0b:: with SMTP id g11mr3450811wme.77.1584619936056;
        Thu, 19 Mar 2020 05:12:16 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c85sm2910002wmd.48.2020.03.19.05.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 05:12:15 -0700 (PDT)
To:     jbx6244@gmail.com
Cc:     devicetree@vger.kernel.org, heiko@sntech.de, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org
References: <20200318192901.5023-1-jbx6244@gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: phy: convert phy-rockchip-inno-usb2
 bindings to yaml
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <86f9bff8-4e3e-8a26-b89b-ce80cb865103@gmail.com>
Date:   Thu, 19 Mar 2020 13:12:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318192901.5023-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A test with the command below gives this error:

  DTC     Documentation/devicetree/bindings/phy/
phy-rockchip-inno-usb2.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/phy/
phy-rockchip-inno-usb2.example.dt.yaml
Documentation/devicetree/bindings/phy/
phy-rockchip-inno-usb2.example.dt.yaml: usb2-phy@e450:
'#phy-cells' is a required property

'phy-provider.yaml' uses regex pattern:

"^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"

in combination with nodename 'usb2-phy' gives a full match.
'#phy-cells' is only for subnodes I think.

Question:
Should we:
1: rename all 'usb2-phy' nodes in dtsi, then please advise what name
should be used.

Or:
2:  add '#phy-cells' to 'usb2-phy' nodes? Please advice.

make -k ARCH=arm dt_binding_check

> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>

> +    u2phy0: usb2-phy@e450 {

Regex gives a full match.

> +      compatible = "rockchip,rk3399-usb2phy";
> +      reg = <0xe450 0x10>;
> +      clocks = <&cru SCLK_USB2PHY0_REF>;
> +      clock-names = "phyclk";
> +      clock-output-names = "clk_usbphy0_480m";
> +      #clock-cells = <0>;
> +
> +      u2phy0_host: host-port {
> +        #phy-cells = <0>;
> +        interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>;
> +        interrupt-names = "linestate";
> +      };
> +
> +      u2phy0_otg: otg-port {
> +        #phy-cells = <0>;
> +        interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>;
> +        interrupt-names = "otg-bvalid", "otg-id", "linestate";
> +      };
> +    };



