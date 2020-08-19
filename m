Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC756C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0567206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597841042;
	bh=p1vhfj05/ImpL1YamOJt4Amr4O07pdWTDsBGH/jAeBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D8rUS8VPvtUq3MCMRV64Zjnp15NT4EzyUMJMzDjSY3xQxik5tufZArW3PQuuGwjJh
	 4EZiuWeW5kitDKwHNn16eAKxWfQvi3rFqkhwBNFCDtHlykA/Hs84PZsO8ZPhJSZDTe
	 UuBMBychv2zAUMyqRC/Ve34ublNzk6ttKCzzjGNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgHSMn5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:43:57 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40826 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgHSMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:43:41 -0400
Received: by mail-ej1-f66.google.com with SMTP id o18so26101061eje.7;
        Wed, 19 Aug 2020 05:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZctuP1CMTcrHiFJrxq/97buNSvRxRav1gdS+WK4BXKE=;
        b=a5lHJZTPfCV5q2Emon8VA5pz+87CCjuN6FuoDyNLroBT/dJ510VQWyJNZ/OO5vyCA+
         PLy5f50YJSIDULHMdqcjyvO/aEN0xUMrcNRUiBgLKtyW6BhOHEnpuLluhmmdHBkrZ+An
         UHSJJW6oUnHuR4by1qccNit5K3CqwnvVJ6EOOpld0NdP+nSSFMbtVEqhnjBD9AlQ3VfZ
         90DDvPdhtGA8HBR9MCo7ll7iCRyzCth53cU3XnwSZhZ18fbvcvOdCdyCInjtd50iT9Hm
         yvdKa5WJ9yFF+d2aU+sEMLagocwT+BM+mB0QYitQP4GC0Blcqbh2ELQG/g4RtCy4vGlF
         rB+A==
X-Gm-Message-State: AOAM530Eq/Q7QFOaMu1jWDeF7PqjLLvLeLXhfk8w9qPrTTI9CgHvwfUX
        k3H839eWe5Rd2EJt1KkT/LY=
X-Google-Smtp-Source: ABdhPJx7aI8b4UuPppvm7ZVq9l8TZjjwjaoKNcHU2tnGRaF3hJhwZoXkU9F4920cWP8Hq9PaligR6w==
X-Received: by 2002:a17:906:1b04:: with SMTP id o4mr26301964ejg.332.1597841018997;
        Wed, 19 Aug 2020 05:43:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id g11sm17995300edt.88.2020.08.19.05.43.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:43:38 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:43:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 3/8] spi: spi-s3c64xx: Report more information when
 errors occur
Message-ID: <20200819124336.GD18122@kozik-lap>
References: <20200819123208.12337-1-l.stelmach@samsung.com>
 <CGME20200819123226eucas1p2dc50cd60f71f2155524ec21bf4dcdd74@eucas1p2.samsung.com>
 <20200819123208.12337-4-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-4-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:03PM +0200, Łukasz Stelmach wrote:
> Report amount of pending data when a transfer stops due to errors.
> 
> Report if DMA was used to transfer data and print the status code.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

