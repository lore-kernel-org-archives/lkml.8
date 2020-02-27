Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6960EC3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBFB246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582839904;
	bh=2cnlI/uTKU8xtivP/KKPg2reOpgPfx9FSzUtxtfa5bw=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=j5URIyTLYlmIwA46qc8AdEMnVrG/e7JR0h+G9tXYznBJq+YIhQp/Tl5VZkcJuuHoN
	 fBjK9a1K4Eg7hrNExn9A+wj6ZKfIxzudV49DgFPwiLVSqCybDSpvHK6l1+KPIlvOkz
	 dC8l5D97Bssv0hl3UphQaZlhEANjZzYycRnUNCpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgB0VpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:45:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35345 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgB0VpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:45:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so822099oie.2;
        Thu, 27 Feb 2020 13:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8K8GxDjHWN8nw5B/MJxXE6qGFFNBAsQvBhfvCisLcQw=;
        b=CXP5pckPmZrfbDFvDRRBnY2TOm8bf7UOL40ZiGEnJPPi6dYjFt2Sn+aicQ4Df62WjX
         h10KU9jK/IucHKmyS2vhjNukX+aw4BfvqUNsPraK5fI8RzfmHaRVp0DSXXht5w9B5ZsW
         rHWR+4jDWHWll5e8X5edJFc8oI8x34npFGoGBztBfl3TAh+hn7Qn0vQ0/GYX5RBPo+cP
         8I6hSxBVVttedlmJu4sGYet6fIx9wJ1WJWdlG9WzETzIYKH2vDcx9DY4geKlTK28XeP8
         8qvLbchKkuUDaMt2mQnsHaUG+F2hv5XIJXCQ95IEepvygamErGdqbCI+inp/v29XH0Ku
         HziA==
X-Gm-Message-State: APjAAAWigFXF4rlsQve7+JsCfznKf3YNd7ovyYDe2aPGmJSFpX+EC3PY
        TiKs2CFEaER/SrTh3VEcfA==
X-Google-Smtp-Source: APXvYqwL/253WG+MaGdQ7iZMlqBjJ/aGplVqi0qJagYe77yQrHrUQ+OOCjtWvPmeGK+9wH55yDWvWg==
X-Received: by 2002:aca:d03:: with SMTP id 3mr846106oin.69.1582839901619;
        Thu, 27 Feb 2020 13:45:01 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h1sm2353634otm.34.2020.02.27.13.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:45:01 -0800 (PST)
Received: (nullmailer pid 6216 invoked by uid 1000);
        Thu, 27 Feb 2020 21:45:00 -0000
Date:   Thu, 27 Feb 2020 15:45:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
List-Id: <soc.lore.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 03/13] arm: dts: calxeda: Fix interrupt grouping
Message-ID: <20200227214500.GC26010@bogus>
References: <20200227182210.89512-1-andre.przywara@arm.com>
 <20200227182210.89512-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227182210.89512-4-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:22:00PM +0000, Andre Przywara wrote:
> Currently multiple interrupts for some devices are written as one array
> instead of using the DT grouping notation (<0 42 4>, <0 23 4>).
> This ends up in the same binary representation in the .dtb, but is
> semantically not equivalent. The yaml schema checks will stumble over
> this, so lets fix that first.
> 
> I refrained from using the symbolic names for GIC_SPI/GIC_PPI and
> IRQ_TYPE_LEVEL_HIGH, mostly because it increases the delta between the
> original DTS files and the mainline versions, so it's just additional
> churn.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/boot/dts/ecx-2000.dts    | 2 +-
>  arch/arm/boot/dts/ecx-common.dtsi | 4 ++--
>  arch/arm/boot/dts/highbank.dts    | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
