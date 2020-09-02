Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB9BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F375207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XFDgAjeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIBSQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:16:19 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37020 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:16:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082IGEve057006;
        Wed, 2 Sep 2020 13:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599070574;
        bh=RpxqYHRaG0XyjrJcEF0T02Xh9a9IE8YwRxpfTIOcgSc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XFDgAjeGFN7GJOYP4FTBwrFo7/T9/C5YbpYdcLcKaGp2Q3sjDbjv2HshR8ys49ijN
         aZm7kfT8LhI8l9gYbpEfZkMWPnm2bmIWmurOhkjA/+9HYcAZ+leonMglUSaLOUo4fe
         KiziS7IwoqY0z1J4NtL6w4wC8BJ3CGVYYQ0i0lCk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082IGE4B087512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 13:16:14 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 13:16:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 13:16:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082IGDLD107933;
        Wed, 2 Sep 2020 13:16:13 -0500
Date:   Wed, 2 Sep 2020 13:16:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Suman Anna <s-anna@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: Re: [PATCH 7/7] arm64: dts: ti: k3-*: Fix up node_name_chars_strict
 errors
Message-ID: <20200902181613.mrffnxy4klc5l75d@akan>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-8-nm@ti.com>
 <7fbf0ee5-0c7e-ae18-fa8a-bbdc6e9da926@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7fbf0ee5-0c7e-ae18-fa8a-bbdc6e9da926@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:54-20200902, Suman Anna wrote:
> On 9/1/20 5:30 PM, Nishanth Menon wrote:
> > Building with W=2 throws up a bunch of easy to fixup errors..
> > node_name_chars_strict is one of them.. Knock those out.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  6 +++---
> >  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        |  4 ++--
> >  arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 16 ++++++++--------
> >  .../dts/ti/k3-am654-industrial-thermal.dtsi    | 12 ++++++------
> >  .../boot/dts/ti/k3-j721e-common-proc-board.dts | 18 +++++++++---------
> >  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi      |  6 +++---
> >  .../arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  2 +-
> >  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi    |  2 +-
> >  8 files changed, 33 insertions(+), 33 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > index 9c96e3f58c86..ff3e38408dbc 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > @@ -305,7 +305,7 @@
> >  		no-1-8-v;
> >  	};
> >  
> > -	scm_conf: scm_conf@100000 {
> > +	scm_conf: scm-conf@100000 {
> >  		compatible = "syscon", "simple-mfd";
> >  		reg = <0 0x00100000 0 0x1c000>;
> >  		#address-cells = <1>;
> > @@ -344,7 +344,7 @@
> >  					<0x4090 0x3>; /* SERDES1 lane select */
> >  		};
> >  
> > -		dss_oldi_io_ctrl: dss_oldi_io_ctrl@41E0 {
> > +		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41E0 {
> >  			compatible = "syscon";
> >  			reg = <0x0000041E0 0x14>;
> 
> We should %s/41E0/41e0/, but that change is not directly associated with the
> patch subject line. Perhaps, an additional patch? Remember seeing similar
> warning on some downstream crypto nodes, but strangely I am not seeing on these
> upstream nodes.

yeah - probably a separate patch, but thanks, i can fix it as well(will
check if there are similar ones around as well).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
