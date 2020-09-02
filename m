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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F213C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7752D207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qc90Wo+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgIBSS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:18:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57214 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:18:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082IIK1M072928;
        Wed, 2 Sep 2020 13:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599070700;
        bh=7OPmsbCXRtEPuYhTxLo0fWEgyxg39eQfloSk03tiLhQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Qc90Wo+gMi6zuQKXv1EUquQEjbP9AsttUcWv5xZmiH8TFx/uCBOTjR6HcdVYa3KJ5
         Hqp+uhFj9McJWd7a4eZ29uQgunCroQPoTz5MJgTTDdAT6FB6iX/Zh/MRqO44YXOzfV
         n564SXcZPpkemuyU/84yBjSDs2twnhOCj9Cb5TqY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082IIKp6007964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 13:18:20 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 13:18:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 13:18:20 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082IIKIp111197;
        Wed, 2 Sep 2020 13:18:20 -0500
Date:   Wed, 2 Sep 2020 13:18:20 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Suman Anna <s-anna@ti.com>, <vigneshr@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: Re: [PATCH 6/7] arm64: dts: ti: k3-*: Use generic adc for node names
Message-ID: <20200902181820.nlvl3pfzeh4agzzi@akan>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-7-nm@ti.com>
 <60e6b790-360a-6eaf-03a3-5bb256adf215@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60e6b790-360a-6eaf-03a3-5bb256adf215@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:51-20200902, Suman Anna wrote:
> On 9/1/20 5:30 PM, Nishanth Menon wrote:
> > Use adc@ naming for nodes following standard conventions of device
> > tree (section 2.2.2 Generic Names recommendation in [1]).
> > 
> > [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> > 
> > Suggested-by: Suman Anna <s-anna@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         | 4 ++--
> >  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > index 51ca4b4d4c21..6dfec68ac865 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > @@ -80,7 +80,7 @@
> >  		#size-cells = <0>;
> >  	};
> >  
> > -	tscadc0: tscadc@40200000 {
> > +	tscadc0: adc@40200000 {
> 
> OK with these changes, since these seem to be only have the adc child nodes.
> This node is essentially a parent node for touchscreen and adc child nodes. The
> driver is currently looking for "tsc" on touchscreen child nodes, but none of
> the K3 SoCs have them atm.
> 


Vignesh: are you ok with this, care to comment?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
