Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B2C11D25
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A6B206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk0CLeyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgBUA1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:27:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40882 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgBUA1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:27:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id b185so261108pfb.7;
        Thu, 20 Feb 2020 16:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlf9e8PCxMy8eGHAA66JnCJwWWqoU2+bIGR18Xk5wUE=;
        b=Mk0CLeyDzct1sX63axT7hMDuzVKps8CcPRH1gOBCgnC7dn6oGylada1Aq+d2q80tY0
         IsrTO0zoWHUIkV7J+5At6YZmXgmlXtk7b3/Atb4YkT3gjxHVOJD4X11a9gW3J9xogMmC
         yZBgYo6tX7Y4rEeYV94pJ3gMaQvTCMue/PkSOzNkDi3wVYc0Imdo+gDWx9lys6yorXP2
         d6/f8BRHjs4lhqKHRWX2KYa9vABy7PeVZWqGP83q3chVv32+JaUjuUhP7LbrHgI0eWz2
         lb7i9Cbef+4fPYScbvO2rLsq4RJVaRPY/sle1TzfSAEKVlNCVpgcPl4xE/r0AtBWBNaB
         ZYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlf9e8PCxMy8eGHAA66JnCJwWWqoU2+bIGR18Xk5wUE=;
        b=Nk2/ybu+6izzY2zR5NHxdKXrcY2xuFVkg/68YqGlgpZBqvXEMVvFFK8pI2gHMVFUkT
         Bv3dOg5Z2ThENioVD6Xu/jL5HI1m3qqH1J0z9YKW3NwYGUJPD8bb25lx/9OTNMPdmxkS
         rPgrzZwBjAbEJ3KOH1t7x8zc83m+IJT3gEud1KYNGDgYzZs8b7kbDWzpO4ZtA9+FLvHS
         Dt8/npKCguk8+6i1NLamh00e8G4bz00GFJJVaUlvlx5bk4uWuoPhxYTdK2pYO2kIOEeP
         5lT5iRbL0Z5DmRWyFqMmM+gSaviaYgwuNbCGtVQYKZM/JnHl7p0+BJb79nCWX2hfJZaf
         Jnmw==
X-Gm-Message-State: APjAAAVp/hKqhosmzIJv/F1HFUdn7kb4wyB3WXoFU6hn/8W/bjGlc0JR
        2IomjlgCAdZjwkDH4JWmalk=
X-Google-Smtp-Source: APXvYqyeVIYTi7VwppjFDqFRf+PGuo3qQ+FGi2uyU11/sFnMcwObMpN+4M+7gA1IAJ8rt9kz3zp3MA==
X-Received: by 2002:a62:1883:: with SMTP id 125mr33901467pfy.166.1582244839582;
        Thu, 20 Feb 2020 16:27:19 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::6:8f30])
        by smtp.gmail.com with ESMTPSA id fh24sm535479pjb.24.2020.02.20.16.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 16:27:19 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:27:16 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v3 0/5] aspeed-g6: enable usb support
Message-ID: <20200221002715.GC7815@taoren-ubuntu-R90MNF91>
References: <20200218031315.562-1-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218031315.562-1-rentao.bupt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Could you provide some comments on this patch series while I'm working on
the other patch set (for vhub descriptors and DT binding document)?


Cheers,

Tao

On Mon, Feb 17, 2020 at 07:13:10PM -0800, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series aims at enabling USB Host and Gadget support on AST2600
> platforms.
> 
> Patch #1 replaces hardcoded vhub port/endpoint number with device tree
> properties, so that it's more convenient to add support for ast2600-vhub
> which provides more downstream ports and endpoints.
> 
> Patch #2 enables ast2600 support in aspeed-vhub usb gadget driver.
> 
> Patch #3 adds USB devices and according pin groups in aspeed-g6 dtsi.
> 
> Patch #4 and #5 add vhub port/endpoint properties into aspeed-g4 and
> aspeed-g5 dtsi.
> 
> Tao Ren (5):
>   usb: gadget: aspeed: read vhub properties from device tree
>   usb: gadget: aspeed: add ast2600 vhub support
>   ARM: dts: aspeed-g6: add usb functions
>   ARM: dts: aspeed-g5: add vhub port and endpoint properties
>   ARM: dts: aspeed-g4: add vhub port and endpoint properties
> 
>  arch/arm/boot/dts/aspeed-g4.dtsi           |  2 +
>  arch/arm/boot/dts/aspeed-g5.dtsi           |  2 +
>  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   | 25 +++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi           | 45 ++++++++++++
>  drivers/usb/gadget/udc/aspeed-vhub/Kconfig |  4 +-
>  drivers/usb/gadget/udc/aspeed-vhub/core.c  | 79 +++++++++++++++-------
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c   | 30 +++++---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c   |  4 +-
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c   | 26 ++++---
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h  | 23 +++----
>  10 files changed, 178 insertions(+), 62 deletions(-)
> 
> -- 
> 2.17.1
> 
