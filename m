Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C738C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D37320720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594326438;
	bh=0RmYEF3Hj1h1P4gwFbR25MVQlPryl/5muOfW86syesU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OCEqLhu+XoLlhtgm7rJIZwshs5E7JNSgSv7l0DoNrxszjQrOjuEnuSzZWz27bayZP
	 jnvrYkI37tV3S/eOISWk4g8SgID5PmGG0uQNUDviACDq6GgR77oHpEirnTkzwR8oCU
	 +VPEId+K6peCmwJ592iPpQD7xkPfF2/F87Fu0YmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGIU1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:27:17 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35470 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGIU1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:27:16 -0400
Received: by mail-il1-f195.google.com with SMTP id t18so3181499ilh.2;
        Thu, 09 Jul 2020 13:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wl8bT95gvjrpQLU1hak61DBtS66uA/5Q9z0qnRWi99w=;
        b=YcmMocP+hPh9WZ76ZBxCa3cqEUt5sbmQxiqI5EttmRMBfc2h1saEMvjrd740EVj7fZ
         2xGMtVIRUhRPkqXHxoYjJcn5HJfNt6jrQ1kHXjzecn1WDGzs4SuBy2MgQHMDqICm+Df1
         qf2YO6oDLZ3/XgjmmpJx5pdqfmGOdzhTgsBB2qZ5nyR0XREtlpAnwzf+aG6UhO9B2XM2
         5XFR8CFJF2S1E+eng/z6flHyXM/ImIFh1zLGvXvKC/XDDaqrKek1YquYIi/UHxlALumR
         JfRqJr75tH4j3rX4gAWqUD90oC7ruVW72YyUlsk3K0Uj/K9m2e+kY0L2XKDf7Hjh5Ptc
         3hbw==
X-Gm-Message-State: AOAM530BFiYk4kpgjJlMGH+fh4J0aKgBBs/VQkwmYHE3mCWGRuek3vNp
        DHjmJFE0t0v0/d2ZXULSyg==
X-Google-Smtp-Source: ABdhPJy8C/2Em9SRT2h8AT+nRMrHIYbRGa5uU79D9VKYSVm1B0dUGYuZza42cicwKWUFQMGBxZeBQg==
X-Received: by 2002:a92:b618:: with SMTP id s24mr50755034ili.39.1594326435450;
        Thu, 09 Jul 2020 13:27:15 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id l22sm2611970ioc.24.2020.07.09.13.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:27:14 -0700 (PDT)
Received: (nullmailer pid 832395 invoked by uid 1000);
        Thu, 09 Jul 2020 20:27:13 -0000
Date:   Thu, 9 Jul 2020 14:27:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-mips@vger.kernel.org,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v7 5/9] mips: bmips: dts: add BCM6358 reset controller
 support
Message-ID: <20200709202713.GA832363@bogus>
References: <20200617105042.3824116-1-noltari@gmail.com>
 <20200617105042.3824116-6-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617105042.3824116-6-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 12:50:37 +0200, Álvaro Fernández Rojas wrote:
> BCM6358 SoCs have a reset controller for certain components.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  v7: no changes.
>  v6: no changes.
>  v5: no changes.
>  v4: no changes.
>  v3: add reset controller definitions header file.
>  v2: no changes.
> 
>  arch/mips/boot/dts/brcm/bcm6358.dtsi      |  6 ++++++
>  include/dt-bindings/reset/bcm6358-reset.h | 15 +++++++++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 include/dt-bindings/reset/bcm6358-reset.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
