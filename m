Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B188C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C3820C09
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599396283;
	bh=HRlZKQz3TCc1TZbzCGrO9aZ+j2yK6L3jRGTsVlI1Qgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pp0WREiqDXJbrlskdp90nyajCIb2jNAeRwe7sJ97XlaD9tvOtAz2q1XenoIQPtAt2
	 YBwtI0WTpyGfGHyqaVC949MY+QyBhtMDQP7QvgwE3u7JS33+qz65wmM0rYw/q7aXT9
	 2epWTazU1HfLGsVk51Fglu5QIp7i2Lz43TkLZzM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgIFMok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 08:44:40 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:33962 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgIFMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 08:44:13 -0400
Received: by mail-ej1-f68.google.com with SMTP id gr14so13212086ejb.1;
        Sun, 06 Sep 2020 05:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ralIEjNoFtwj5RBf8iVIO+7hQNji8TPKqkwx5rPMfW8=;
        b=YPYDFJCMCRd7MkA0WiDlq0TqsrOCQUV3Yq4cgTFpOJaIsZC+axyRnRcFP0CydQuy2a
         8ogjIx2PrvU735a+asGRN3JVN/cMF9rtttRKJh6oYk1HfcgUbHFbV3GK9SiAntbl9vZV
         JI+6x0WvFYLGBNrlHHogJzpcMEdlF6+GghbILKXXDYKKjexDSR7wyiWNEDYAWCqtKYT1
         8+EWyw/xf2cnjr0E6g1eqzrdphggHnkH6PCQcYq3FC+kYaQ+Ou1OyuNbm/1H5Zsk5axn
         6USN+x3y8yOw8KwFfYbEC5iGoFPj4IPj4ZqmoXq2nr5ovux8SlO9Q/5QIqqw9RFztR7Q
         8kbg==
X-Gm-Message-State: AOAM5313cKTagmdX9I3fFycW6i/zfIw1tZF2iSba2YuOAvfa8Ehc7cig
        okPNigLBr6FZDvuPDuSjveXGcy35V+Q=
X-Google-Smtp-Source: ABdhPJzA6dUBJEnmsFqsm7+L48vhwErR8Th/TvoUyATAz1Bfovh0eQUU0X1hyJaz8BYw7hNVPwUa7w==
X-Received: by 2002:a17:907:2168:: with SMTP id rl8mr16195778ejb.308.1599396250643;
        Sun, 06 Sep 2020 05:44:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id p12sm11877066ejb.42.2020.09.06.05.44.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Sep 2020 05:44:09 -0700 (PDT)
Date:   Sun, 6 Sep 2020 14:44:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v2 1/3] ARM: dts: exynos: Add assigned clock parent to
 CMU in Exynos3250
Message-ID: <20200906124407.GA4829@kozik-lap>
References: <CGME20200903181437eucas1p16b97d1c425672700bac7ece19084584c@eucas1p1.samsung.com>
 <20200903181425.5015-1-krzk@kernel.org>
 <4bc2ea2e-65a2-6c0b-9557-5777e359241a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bc2ea2e-65a2-6c0b-9557-5777e359241a@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:47:10AM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 03.09.2020 20:14, Krzysztof Kozlowski wrote:
> > Commit 52005dece527 ("ARM: dts: Add assigned clock parents to CMU node
> > for exynos3250") added assigned clocks under Clock Management Unit to
> > fix hangs when accessing ISP registers.
> >
> > However the dtschema expects "clocks" property if "assigned-clocks" are
> > used.  Add reference to input clock, the parent used in
> > "assigned-clock-parents" to silence the dtschema warnings:
> >
> >    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Add clocks property.
> >
> > This is a v2 for:
> > https://lore.kernel.org/linux-samsung-soc/20200901101534.GE23793@kozik-lap/T/#me85ac382b847dadbc3f6ebf30e94e70b5df1ebb6
> > ---
> >   arch/arm/boot/dts/exynos3250.dtsi | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> > index a1e93fb7f694..89b160280469 100644
> > --- a/arch/arm/boot/dts/exynos3250.dtsi
> > +++ b/arch/arm/boot/dts/exynos3250.dtsi
> > @@ -214,6 +214,7 @@
> >   			compatible = "samsung,exynos3250-cmu";
> >   			reg = <0x10030000 0x20000>;
> >   			#clock-cells = <1>;
> > +			clocks = <&cmu CLK_FIN_PLL>;
> 
> This is not a correct input clock for this CMU. Please assign it to 
> xusbxti, xxti or xtcxo in the respective board dts, as this is a board 
> property.

Makes sense, although all this is kind of a hack as neither the bindings
nor the driver take the input clock.


Best regards,
Krzysztof

> 
> >   			assigned-clocks = <&cmu CLK_MOUT_ACLK_400_MCUISP_SUB>,
> >   					  <&cmu CLK_MOUT_ACLK_266_SUB>;
> >   			assigned-clock-parents = <&cmu CLK_FIN_PLL>,
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
