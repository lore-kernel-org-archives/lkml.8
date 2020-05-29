Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B117C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60DE205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590788724;
	bh=4zbEZSZyMk5DhqI3Bb1UCHq7lh988vHi4SYqLvxciNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ovNFgdt26ySh50YIc+rnUpZFed9Q+Xn3+huH8RnqiYcmzz7rNe9TzBpWfXzbOG1W4
	 ReXgGAff9g7sgDyt2r1YToel1gHm0y0nYiHtHfIvFLRkJ9WbC0eLNYI3yup0X4cf+R
	 zRvmqWs/TJg0rgX500oxaTok8RAaFo0xCB+zGq88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgE2VpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:45:24 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37214 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2VpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:45:23 -0400
Received: by mail-il1-f196.google.com with SMTP id r2so3962034ila.4;
        Fri, 29 May 2020 14:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gr0zXVVEplEEw2j9ufWrSiyQP2XN9MvxyfVD2I7gbHQ=;
        b=Op1WLfQciyUdcxkX6WcZIwGbhOObiLGqF3km8uKHORMsQSuHTyAqtjkglyGM/d3+fX
         BcgeY5A1ChiKuhxiIUNqRgsdlu+x8FgAWMFOWkv6YDgNUiJr5fi5heWBxLGbQhsL/EOr
         6S7KVDpYOb+Ql3N4gJsBz6zcBJGd3/o2mk8bU9VeOkILgAXWAnTaqzqjAwSKTCbVNBLe
         7v6Lf6zjaZTbiGsFUvc6gJ7SlGkXj7xt4E9l+sgGnPjLK5M2Jutgp/qCm/5aNqmju7q/
         TuvMST8M5bl70FBjo7cHzfqwprP9q/XHljXhQBw2+zSWEcoUzv1idST4AABM5Hdhg7is
         wFeA==
X-Gm-Message-State: AOAM533UgvJ355Hgv9/JKVy6ggkBD0RTEVIuLydmO3C8I2bs5dP8db6w
        Vw7oHiW4vduh64ErOSB7VA==
X-Google-Smtp-Source: ABdhPJzjdTgPakR313ticbx9ElFMdis/0s2/gMfV5CG62ElhWJEG0x+1MYzSLCe7d3QknAKFV0d7CQ==
X-Received: by 2002:a92:c68c:: with SMTP id o12mr8480896ilg.96.1590788722523;
        Fri, 29 May 2020 14:45:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g4sm5334133ilj.45.2020.05.29.14.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:45:21 -0700 (PDT)
Received: (nullmailer pid 3036995 invoked by uid 1000);
        Fri, 29 May 2020 21:45:19 -0000
Date:   Fri, 29 May 2020 15:45:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Scott Branden <sbranden@broadcom.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: Document 7211 compatible
 for brcm, bcm2835-gpio.txt
Message-ID: <20200529214519.GA3036732@bogus>
References: <20200529191522.27938-1-f.fainelli@gmail.com>
 <20200529191522.27938-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529191522.27938-2-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 12:15:19 -0700, Florian Fainelli wrote:
> Document the brcm,bcm7211-gpio compatible string in the
> brcm,bcm2835-gpio.txt document.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
