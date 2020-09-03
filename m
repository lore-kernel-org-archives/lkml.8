Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326CCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F8E20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zu9icTeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgICPVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:21:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57382 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgICLYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:24:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083BNmZu073910;
        Thu, 3 Sep 2020 06:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599132228;
        bh=NQo7vUhMynuWKGR7nysjqjeboPuk+AK5YMlGBnTcHWU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Zu9icTeSjqIxCdXj+48f6EVVaFLF196A1IfPMbjhblFy+GXWToUbLUJPfEzvd+NH6
         P1XILBLc96enbD1fCX07hha5ybwgfWgiI07TPFTw7a1Mpy6AKvv9ZauqwbIEmlbxwv
         WHWPNuJ0ID7eKlyzAnVDxV9h/xrAb8YQrrXHf/uQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083BNmth100340;
        Thu, 3 Sep 2020 06:23:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 06:23:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 06:23:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083BNmhR079007;
        Thu, 3 Sep 2020 06:23:48 -0500
Date:   Thu, 3 Sep 2020 06:23:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: Re: [PATCH 6/7] arm64: dts: ti: k3-*: Use generic adc for node names
Message-ID: <20200903112348.dcj7b7zytgdt6pjv@akan>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-7-nm@ti.com>
 <60e6b790-360a-6eaf-03a3-5bb256adf215@ti.com>
 <20200902181820.nlvl3pfzeh4agzzi@akan>
 <9fb2f8f4-5eeb-6190-9cbf-b28084c58a8f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9fb2f8f4-5eeb-6190-9cbf-b28084c58a8f@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:55-20200903, Vignesh Raghavendra wrote:
> Hi Nishanth,
> 
> On 9/2/20 11:48 PM, Nishanth Menon wrote:
> > On 11:51-20200902, Suman Anna wrote:
> >> On 9/1/20 5:30 PM, Nishanth Menon wrote:
> >>> Use adc@ naming for nodes following standard conventions of device
> >>> tree (section 2.2.2 Generic Names recommendation in [1]).
> >>>
> >>> [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> >>>
> >>> Suggested-by: Suman Anna <s-anna@ti.com>
> >>> Signed-off-by: Nishanth Menon <nm@ti.com>
> >>> ---
> >>>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         | 4 ++--
> >>>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
> >>>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> >>> index 51ca4b4d4c21..6dfec68ac865 100644
> >>> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> >>> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> >>> @@ -80,7 +80,7 @@
> >>>  		#size-cells = <0>;
> >>>  	};
> >>>  
> >>> -	tscadc0: tscadc@40200000 {
> >>> +	tscadc0: adc@40200000 {
> >>
> >> OK with these changes, since these seem to be only have the adc child nodes.
> >> This node is essentially a parent node for touchscreen and adc child nodes. The
> >> driver is currently looking for "tsc" on touchscreen child nodes, but none of
> >> the K3 SoCs have them atm.
> >>
> > 
> > 
> > Vignesh: are you ok with this, care to comment?
> > 
> 
> On K3 SoCs, ADC IP is reuse from AM335x but just lacks resistive
> touchscreen interfaces. So, existing AM335x ADC driver is being reused
> for K3 devices as well. Unfortunately, ADC driver cannot be used as
> standalone and is dependent on MFD parent to be present...
> Above node represents the MFD parent and ADC itself is the child node
> (see arch/arm64/boot/dts/ti/k3-am654-base-board.dts). So, I recommend
> that we keep this node's name as tscadc in order to avoid having same
> name for parent and child node which will be quite confusing.


Thanks for your feedback. I will drop this patch.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
