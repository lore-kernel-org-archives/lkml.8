Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8302DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B31D2089D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593675561;
	bh=wWiFkYyYMP2WwvSYeZw5ASaMoJ6PQY8vOQ0lKc9zjE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=01asPo2IaiC5wd6L7qzFlYUHJYLVLIUnbP9jIecaLLaKK1ytFh9yBAWIc0Dum05Gy
	 guI1rWx3uYcfWfs+/4cUEbd+kANFCM5BH58hnlYX+Z4pZiWIe+9bGxrUUKwmlCvHMP
	 ZDxRx+UX7pZAEbzTjKeuPx7q0x04o2UPrhv9izzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGBHjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:39:19 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42993 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgGBHjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:39:18 -0400
Received: by mail-ej1-f66.google.com with SMTP id f12so1879027eja.9;
        Thu, 02 Jul 2020 00:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+qtrKeUknobDsiDsqcsCQWN3hO9VKyL68T69UrtNic=;
        b=Z+X5rHOyWUGQQOzN0IvKFPjnX2Va0khS9K5AeUUIiLQ/mTihQNddWS5PsFeaw8w2Dj
         otOu36jRIrb3uEW0elavruCI/tXU9YqrUNR1mIEOeeNBwASQ/n8ylR8CFNGWH/DXvU40
         5yH825HY6KUpkRKaqLaEl+oG8DQOctBreFN0GCBJk83B3ih1UwPwal7NflnHc/VQqSg0
         PJLfBS1CaszE6y0S0otolOydQw3cHrF9W4ZZoKxq/XEHjxLXCt1xBqoStByBXcFbuWjd
         0av0J2/66e8UcSIzZVSDSA7x8wh+JmUyi6z+JSpB0mllt0XbFJi0vLR3joX+7wy6uNt5
         SU6Q==
X-Gm-Message-State: AOAM53334Ybj0QrPVr6luojHQgFgicSwbXCQds5OluFntIMSrg+/OoFg
        yUCJ/whlFtLZ/TAI8hEJYvk=
X-Google-Smtp-Source: ABdhPJwAvhXIPghcOcmZpMa7MJoAcsGQ9JyVGobacO92qgnYbbeRf3sNWsQ+8MdyqKFuV4Agxd2xTA==
X-Received: by 2002:a17:906:899:: with SMTP id n25mr24916943eje.298.1593675556682;
        Thu, 02 Jul 2020 00:39:16 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id w8sm6284760ejb.10.2020.07.02.00.39.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 00:39:15 -0700 (PDT)
Date:   Thu, 2 Jul 2020 09:39:13 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v2] ARM: dts: exynos: Fix missing empty reg/ranges
 property regulators on Trats
Message-ID: <20200702073913.GA1187@kozik-lap>
References: <CGME20200629210025eucas1p219a52e75ecce9e813aa80f0126780189@eucas1p2.samsung.com>
 <20200629205948.32250-1-krzk@kernel.org>
 <97651868-30f3-6b91-1ea2-551ee1ebad8f@samsung.com>
 <20200702061611.GC4175@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200702061611.GC4175@kozik-lap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:16:11AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Jun 30, 2020 at 08:27:01AM +0200, Marek Szyprowski wrote:
> > Hi Krzysztof,
> > 
> > On 29.06.2020 22:59, Krzysztof Kozlowski wrote:
> > > Remove the regulators node entirely because its children do not have any
> > > unit addresses.  This fixes DTC warning:
> > >
> > >      Warning (simple_bus_reg): /regulators/regulator-0: missing or empty reg/ranges property
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > What about removing the regulators node from other boards: 
> > exynos4412-origen.dts, exynos5420-smdk5420.dts and exynos5250-arndale.dts?
> > 
> > On the other hand, maybe it would be really easier to add missing 
> > address/size-cells properties to exynos4210-trats.dts/regulators node?
> 
> Indeed let's keep it consistent so in such case better to add here
> proper address/size-cells.

Actually more of DTSes put fixed regulators directly in root node, not
under "regulators" node:
exynos3250-monk.dts
exynos4210-i9100.dts
exynos4210-origen.dts
exynos4210-universal_c210.dts
exynos4412-galaxy-s3.dtsi
exynos4412-midas.dtsi
exynos4412-n710x.dts
exynos4412-odroidx.dts
exynos5250-smdk5250.dts
exynos5250-snow-common.dtsi
exynos5420-peach-pit.dts
exynos5800-peach-pi.dts

If we want it to be consistent, it's easier to remove the regulator
nodes from exynos4412-origen.dts, exynos5420-smdk5420.dts and
exynos5250-arndale.dts.

Best regards,
Krzysztof

