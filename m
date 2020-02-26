Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDB0C4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C581320838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582728987;
	bh=WnRBH6j5af4j7aShdtsZ0RNMnqrTMWVB077lZSJrA8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OiASO9cPJOmIW7r0tt0ZbNpJE9Plg8H3WDpQrRLCJSinzitMLcNdtn3xCFnqu4mY5
	 RMLEOUhOSSwIDQbMawx8z31SMiZztGSbjtwjlvvkw4vbH2U4curMLFw48yDx8SAfFm
	 ph7GfNjFgtXQ9Vw/bEZuBfyyAFohLVCWCxe8n63w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBZO40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:56:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43138 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgBZO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:56:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so3151020oth.10;
        Wed, 26 Feb 2020 06:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4+aLnsPdP1/QbRnyIoXI03Tshsf4suv6arri2MUC+qo=;
        b=qS12SSGbHKCyaChRT2Aao1t91Ll4Qp71UCkJ8ED1GcOBCqD41j/kaGT5vUNomuyS5o
         irhug963VPxIbsyicZCVDRwZXA3T+IrWMeQgp6OTgGtFIsD/Wb3v/am8V8nMLHDPGcBo
         YXlYpzxbMiBCcKXp8FuKrxI4uZwbN//aA2YO22acQagypTUnsA+TWGFedPNcBLZCVyi2
         0QbjzjWxpQsen4WBEn64aurMYJx2BOa+ScKthLNTQWLT7J1NTJPXPKqD4cmy6fUuA1pb
         VeBzNl55M9+J/UHoraKsebssbxTE7FyXllhGMT6WkcelhCJ3s1X65MkGl6fM3V0obBji
         bUNA==
X-Gm-Message-State: APjAAAXhdqDsS9t8gKHPjgIAANaBXfGlnae6MqyiVNUkf5CneBJrGhu9
        gIrBLzhqMAB8gQnB6MEhZw==
X-Google-Smtp-Source: APXvYqzrUda0vSZtD9CpveeEfxdVZW6Zdsm+zPooigQG/TE92zsXfEODvCU6ebACAkEHgk7TJbw6sA==
X-Received: by 2002:a05:6830:1047:: with SMTP id b7mr3582500otp.77.1582728985048;
        Wed, 26 Feb 2020 06:56:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w197sm884841oia.12.2020.02.26.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 06:56:24 -0800 (PST)
Received: (nullmailer pid 23432 invoked by uid 1000);
        Wed, 26 Feb 2020 14:56:23 -0000
Date:   Wed, 26 Feb 2020 08:56:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Torsten Duwe <duwe@suse.de>, Icenowy Zheng <icenowy@aosc.io>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/6] dt-bindings: Add Guangdong Neweast
 Optoelectronics CO. LTD vendor prefix
Message-ID: <20200226145623.GA22420@bogus>
References: <20200226081011.1347245-1-anarsoul@gmail.com>
 <20200226081011.1347245-4-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226081011.1347245-4-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:10:08AM -0800, Vasily Khoruzhick wrote:
> Add vendor prefix for Guangdong Neweast Optoelectronics CO. LTD
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
