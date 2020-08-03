Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFE6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91BF206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596460407;
	bh=mqzRjMTBknaYYB0b5DWwGonUiuqXZ8C2DH9TELJUUoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fq+przQ6vP1gGcbQidwn+OhvMVAPhgnDEEnE8eTAPAIyd+xtc/aWfpaeuB7xPP1AY
	 BlLffRU6j59L3Gik5C07jhwUvmt735TMRgw1YGxGq/8lFE9H4DEoNQhAecS4q142lw
	 04IYKW1Yc1Fb1CjtGAi/EuPqpIDRpjfuWVcoq9Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHCNN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:13:26 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44938 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHCNNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:13:25 -0400
Received: by mail-ej1-f68.google.com with SMTP id bo3so15934695ejb.11;
        Mon, 03 Aug 2020 06:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+FpiC6SBJves8/PE+l3DO1tLqwjopB2TqZYhqiDVGgs=;
        b=m1pUGDf84Mold3ftFsIeru71uimgYc09qfAHa2FNpHqDzPEiwVB3TnWzgBWNkVJMdP
         I+MdmvTC9Ep0qOdBbJZ2blQtDtrD+ZNuuZf2arrEh0kHuZ1JycyWZalr2uQYwBvbMZCJ
         bJpDyQTIJPcQh659SWTBwYzvz3K648P9d2BpQu/4UtYyliFV6qpC3NZKhvR6GuRAM7MO
         j8wC+CssMeFjkJBnHg2ae9a3PsPx5/3ir1d1eIey/yNXOZB0rknijAcw5oulID0k1zI7
         sQ5xAtxe2Co5UF9nL3X0uLLcSwVRyz0kJkS+SX0T/1hhu1f5r2KRkobMUZqG3Hfp5j9r
         4Dvw==
X-Gm-Message-State: AOAM531k4YJ3Wvm0Lp4qyJzsuuloYwLGeLCHnjRb4qo4gtiVp8qPiTis
        skDCfmG+VWUPzAbYEr1+T9aSe7inrwI=
X-Google-Smtp-Source: ABdhPJww3e44rCw/lb1LRSSCM7XBqiiK3Wcu4e8qs/RZ5+ekZllE5x4nfwYjYojiauotgynpE70l3A==
X-Received: by 2002:a17:906:260f:: with SMTP id h15mr16251265ejc.48.1596460403460;
        Mon, 03 Aug 2020 06:13:23 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id h9sm5868580ejt.50.2020.08.03.06.13.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 06:13:22 -0700 (PDT)
Date:   Mon, 3 Aug 2020 15:13:15 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: exynos: use DT prefetch attributes rather than
 l2c_aux_val
Message-ID: <20200803131147.GA476@kozik-lap>
References: <860eb8a1eed879e55daf960c96acdac514cbda93.1596028601.git.guillaume.tucker@collabora.com>
 <5e41140ddb1afe42699715cca59c44fa2fa29e60.1596028601.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e41140ddb1afe42699715cca59c44fa2fa29e60.1596028601.git.guillaume.tucker@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 02:47:33PM +0100, Guillaume Tucker wrote:
> Use the standard l2c2x0 device tree bindings to enable data and
> instruction prefetch on exynos4210 and exynos4412 and clear the
> respective bits in the default l2c_aux_val.  No other Exynos platform
> relying on this default register value appears to be using the l2x0
> cache.
> 
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>  arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>  arch/arm/mach-exynos/exynos.c     | 4 ++--

I will need these split between DTS and mach changes.

Best regards,
Krzysztof
