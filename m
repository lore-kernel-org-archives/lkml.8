Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C6020738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599586189;
	bh=DmJzJmf2KKQ5j6OGtkcShLF/eJKI7z/6XBYXt7bWGcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tbaRBj77SgMK4IEY0xoRXpso9q2AIpy0zJw6jqS5UoFluJp1LE+iFJmIFRgE6/XFF
	 zT/veNIcA16A05ht4yJBOaXpacjGwKBcGNSDEP6J2G2GjONLGlmoO3aJVAjwRNQRjU
	 yB94qeNFWnFRe1lFchZMzXxnJ8zm69lGwk7S7/cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbgIHR3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:29:43 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35012 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgIHR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:28:43 -0400
Received: by mail-il1-f195.google.com with SMTP id l4so16191005ilq.2;
        Tue, 08 Sep 2020 10:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZDRFa+2FuzyOVKxJ4jjiTbradJpie+kd91cLXtCONaU=;
        b=MNrhi8BZ7Tz6mLA/WimQFYJfX4ENA6lfT6CxAJFanlTigaG667DdzBfQXeWUj39as8
         7GbpGTwYjkTXE0TalTtrdz+jw4z4xwyAwMdZtoqqhkyziQ6HF4sqnZJPk/kGG3vL64n1
         w1OT2TJJEiPRHhmzrXAYpgq4XPhJS2cgv8lvKTL7R7gUgPOPfvjMpfywEdWf882iJLgD
         rrOQ6j+cGR04569qTtdeLokdH32St+iPqXWPDQQLcbdwJJ2vR/z/4HPz5MNyPP5MxuRP
         wWelGlYHDYEa4wDQO07BA47lVFZT5ztu+NoXSqKLOzhixIlsH9KqSFGB07Qy8kGRnyDZ
         KIjg==
X-Gm-Message-State: AOAM532bqNz+mprR5g2eDmtqVp6cS9F6YZCkWzOJcFD5odVTpoYYce7L
        HxSSKmazYwt147TUOF/vfw==
X-Google-Smtp-Source: ABdhPJzg6HCD8rHyQwEcjNJ3z57BYcVVla1+9asQ4qGPgxwd6B9R8Mq1CaVfa/5tR2qePaTbBRyesA==
X-Received: by 2002:a92:480f:: with SMTP id v15mr22411134ila.123.1599586121806;
        Tue, 08 Sep 2020 10:28:41 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j20sm2678815ilq.6.2020.09.08.10.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 10:28:41 -0700 (PDT)
Received: (nullmailer pid 576505 invoked by uid 1000);
        Tue, 08 Sep 2020 17:28:39 -0000
Date:   Tue, 8 Sep 2020 11:28:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Wei Xu <xuwei5@hisilicon.com>, Ray Jui <rjui@broadcom.com>,
        devicetree@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: timers: sp-804: Convert to
 json-schema
Message-ID: <20200908172839.GA575693@bogus>
References: <20200828142018.43298-1-andre.przywara@arm.com>
 <20200828142018.43298-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828142018.43298-2-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 15:20:13 +0100, Andre Przywara wrote:
> This converts the DT binding documentation for the ARM SP-804 timer IP
> over to json-schema.
> Most properties are just carried over, the clocks property requirement
> (either one or three clocks) is now formalised and enforced.
> As the former binding didn't specify clock-names, and there is no
> common name used by the existing DTs, I refrained from adding them in
> detail (just allowing the property).
> The requirement for the APB clock is enforced by the primecell binding
> already.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/timer/arm,sp804.txt   | 29 ------
>  .../devicetree/bindings/timer/arm,sp804.yaml  | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.yaml
> 

Applied, thanks!

I dropped the primecell.yaml ref as it is redundant.

Rob
