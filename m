Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84094C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F85620716
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597577018;
	bh=6LokpQwfqgW5BehVbZZQHyXA11ff8IliLriuXnIbjGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SsDzUoXV1Nn36b06JenPLNXPMbFkLo9E4RucDYo2XRg5+NDAhltJuJTljbLv5RbuL
	 xPWLIvAvMEiE4Izr/bMETpg9NGGSlIbXxgzCGGt90GSbnsRY0Ql8z0CbBb3hgLwcMX
	 Gv22lDxSzFKQTCq2dYL8GiApOTcfymyP5+1Ospec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgHPLXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 07:23:17 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:35470 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgHPLWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 07:22:11 -0400
Received: by mail-ej1-f67.google.com with SMTP id a26so14565847ejc.2;
        Sun, 16 Aug 2020 04:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NDqZLaZAT+LKFKOpKoexWRgxjioc2twCyNagGsOfYI0=;
        b=Ol5HWjxsnpw0TwFhp89MWVzJlrwCpi97GXJzJPVICjBVV0bWGa4dvyw7pnXPmY5Cyn
         +zXSD+ZCX4/yRttWcvgMnaCQKjriH7pA3TOBgL4PcFSXIINslFAtv3V0VIyBpsuJOEps
         ncpnCLFG3Hu6vXBDKbd2wQNOSLFfD272VGPQV52AfeUdnEEdy0kL89bQFWrov9C+9mjf
         u9cAdl61vseRTRRlFTEtDz6I3SUEOgeNUrp8CoCkHqTH05Ev5hgHNQYOWDwsvxg+Vg3S
         F/mIVmYR0L7rB5eoM2lFEkfx14PuYiUze6TE/K61Tv3/CN2ZIxTZVEe+NUN68LaDrB4x
         4+6A==
X-Gm-Message-State: AOAM533zvTFGznh3TD/Zv5w1XDTVFnVZzOKGzhRXepv+2nPXOc/YLFeN
        fzFntXNhdS0axwY6UA+2MG6xpNWy8jp7/dDU
X-Google-Smtp-Source: ABdhPJzjHr1zmNZpLW256mgTL4s+DvfPwKy+KJBLcHS6IN6oDBwYBiC8ZTrX/nGXdo0JTwN1TgdTvw==
X-Received: by 2002:a17:907:213c:: with SMTP id qo28mr10334391ejb.174.1597576913965;
        Sun, 16 Aug 2020 04:21:53 -0700 (PDT)
Received: from kozik-lap ([194.230.155.201])
        by smtp.googlemail.com with ESMTPSA id b62sm11435753edf.61.2020.08.16.04.21.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Aug 2020 04:21:52 -0700 (PDT)
Date:   Sun, 16 Aug 2020 13:21:51 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: xilinx: Align IOMMU nodename with dtschema
Message-ID: <20200816112151.GA20020@kozik-lap>
References: <20200629081744.13916-1-krzk@kernel.org>
 <3c28bb72-35ae-6c76-6935-624e90316f71@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c28bb72-35ae-6c76-6935-624e90316f71@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:46:55PM +0200, Michal Simek wrote:
> 
> 
> On 29. 06. 20 10:17, Krzysztof Kozlowski wrote:
> > Fix dtschema validator warnings like:
> >     smmu@fd800000: $nodename:0: 'smmu@fd800000' does not match '^iommu@[0-9a-f]*'
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > index 9174ddc76bdc..2b82206eba02 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > @@ -601,7 +601,7 @@
> >  			power-domains = <&zynqmp_firmware PD_SD_1>;
> >  		};
> >  
> > -		smmu: smmu@fd800000 {
> > +		smmu: iommu@fd800000 {
> >  			compatible = "arm,mmu-500";
> >  			reg = <0x0 0xfd800000 0x0 0x20000>;
> >  			status = "disabled";
> > 
> 
> Applied.

Hi Michal,

What happened with this patch? I cannot find it in Linus' nor in
next/master trees.

Best regards,
Krzysztof

