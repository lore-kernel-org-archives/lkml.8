Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D4C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0623C207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wnyOWz5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgIBSVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:21:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37730 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgIBSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:21:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082ILVdm058293;
        Wed, 2 Sep 2020 13:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599070891;
        bh=nlUAMnNqJxMawe84yF+TSG/fCesyBZpd/y2oc4hXuVk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=wnyOWz5ZiDKFQtlwlkIZePnIONIsi0IQHtCFU+QZwHTv9OClh0yDx1DGslavTLxn8
         dnwTVlFNMuR7hvCxPvxJleKU2joZ2muQzJ3F1LyAkV9d54KjUBnB/QEMVQbDglwTie
         /0mDZx/uP+z6JqwQsnW9BMMi7HTh3gHEI9VBqAIw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082ILULd012165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 13:21:30 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 13:21:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 13:21:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082ILUqT112616;
        Wed, 2 Sep 2020 13:21:30 -0500
Date:   Wed, 2 Sep 2020 13:21:30 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Suman Anna <s-anna@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: Re: [PATCH 2/7] arm64: dts: ti: k3-am65*: Use generic clock for
 serdes clock name
Message-ID: <20200902182130.r3etp3fo4lclsdl4@akan>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-3-nm@ti.com>
 <762671ff-d78a-95aa-2817-62d3ebed104e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <762671ff-d78a-95aa-2817-62d3ebed104e@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:45-20200902, Suman Anna wrote:
> On 9/1/20 5:30 PM, Nishanth Menon wrote:
> > Use clock@ naming for nodes following standard conventions of device
> > tree (section 2.2.2 Generic Names recommendation in [1]).
> > 
> > [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> > 
> > Suggested-by: Suman Anna <s-anna@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Suman Anna <s-anna@ti.com>
> 
> > ---
> >  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > index 336d09d6fec7..03e28fc256de 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > @@ -327,12 +327,12 @@
> >  			reg = <0x00000210 0x4>;
> >  		};
> >  
> > -		serdes0_clk: serdes_clk@4080 {
> > +		serdes0_clk: clock@4080 {
> >  			compatible = "syscon";
> >  			reg = <0x00004080 0x4>;
> >  		};
> >  
> > -		serdes1_clk: serdes_clk@4090 {
> > +		serdes1_clk: clock@4090 {
> >  			compatible = "syscon";
> >  			reg = <0x00004090 0x4>;
> >  		};
> > 
> 
> Btw, there is also ehrpwm_tbclk alongside these nodes which is currently defined
> as a syscon, but is actually a clock.

aah, good catch.. I can fix that in the follow on V2.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
