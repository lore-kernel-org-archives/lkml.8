Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD83C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9ECB206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eKQfDg0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgIBSOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:14:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45272 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:14:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082IEjVR105945;
        Wed, 2 Sep 2020 13:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599070485;
        bh=VkCOVQ5uxVARjNX9T8FosOrt2wUqD7roXG4iCY1NK5A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eKQfDg0FbSTqqwSic1qeN80TJ5pHAxhSF7NyYGlQW5KR2hTRlQ7wHPc2OJuGUx4p/
         Ldmj2lAhcueZrFCsXmD0WE1fX6zAva3dFHGhHdyBdwPyjH05xsEU4hQVK3XHgPhe9v
         V4W2Tno3P7krltiD1PTJ8P9P3vilKpktrHLriOyw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082IEiBJ002659
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 13:14:44 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 13:14:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 13:14:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082IEi7v045986;
        Wed, 2 Sep 2020 13:14:44 -0500
Date:   Wed, 2 Sep 2020 13:14:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Suman Anna <s-anna@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        "J, KEERTHY" <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: Re: [PATCH 5/7] arm64: dts: ti: k3-am65-wakeup: Use generic
 temperature-sensor for node name
Message-ID: <20200902181439.ywzxknv3vb7fcfeo@akan>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-6-nm@ti.com>
 <1cdb8cb1-3a08-423d-ba34-299ac1a4b9b4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1cdb8cb1-3a08-423d-ba34-299ac1a4b9b4@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:55-20200902, Suman Anna wrote:
> On 9/1/20 5:30 PM, Nishanth Menon wrote:
> > Use temperature-sensor@ naming for nodes following standard conventions of device
> > tree (section 2.2.2 Generic Names recommendation in [1]).
> > 
> > [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> > 
> > Suggested-by: Suman Anna <s-anna@ti.com>
> > Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> > index bb498be2f0a4..ed42f13e7663 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> > @@ -95,7 +95,7 @@
> >  		clock-names = "gpio";
> >  	};
> >  
> > -	wkup_vtm0: thermal@42050000 {
> > +	wkup_vtm0: temperature-sensor@42050000 {
> 
> There has been a suggestion to use something like thermal-sensor during the
> bindings review, but it is better to use this standard node name.

Yes - I did notice it as well, and then picked up the recommendation
straight from 0.3 spec itself.
> 
> Reviewed-by: Suman Anna <s-anna@ti.com>
> 
> regards
> Suman
> 
> >  		compatible = "ti,am654-vtm";
> >  		reg = <0x42050000 0x25c>;
> >  		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> > 
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
