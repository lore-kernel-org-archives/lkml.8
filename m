Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BD8C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B782070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="xJr62jWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD2A6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:58:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:6494 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgD2A6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:58:16 -0400
IronPort-SDR: jys6npQ5W+Cyj8oEJ6xRc5tPhr3n7BI6CZ8mpWRp9DATfSoPXPdYTV/wcybBKge+rH0DwgPnCZ
 KWszfXpztueQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 17:58:16 -0700
IronPort-SDR: LN4ceVhZ7x8N8342ELfvWV+/WkK2d7WeR1O3PRCrx8YC2+mz2RnD4dgme7sGjRwbR/VfyamLEy
 VVz5RcDeVoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,329,1583222400"; 
   d="scan'208";a="247859891"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2020 17:58:16 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Apr 2020 17:58:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 28 Apr 2020 17:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eodDZHUZx9NyK/LMFcgXtCYolCbPChzpXpB8gYDK5kSmYKcCX1e76sP0DMxPz/yQM7BFfTL+LU0SV/hkUwVGu1WE4krvQrc8nUDWyy5HXaB5GXqt5qCnM9VpoYe7dvjyURGJZuP08fjCge3HuV97FRDMdqqf1Ix+yCC3ft0HCTurYZK8j1+wY3DAwZQflZsscTxE19T52M16McAe5uyatbGCC0Za0xEeKUl05C3X2ErwamXR2kc6La6I4ZVdBmAgL0uAAugXUBGqnqWnWBJDDoF8wDot/Voxs5XsaLV3Po7dKRaGhPbYlBtw5/BfcuCJ/1xH2a/dNYVyLpFK7JpErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OpW1qzZgxNb+1kzNQvuJ3KyVfS/Bp1DIQMlDiX2CjA=;
 b=F4SxVa1FxLsd1ui2uoTJHRgJUVtrfbXTIECN/BlMC0LXYPR9mLJkfEVd7cfZusBS5yf7cy0cpHuLpy22JZq32j66GSQUfHkFbDqJh7LdsrqY0cR4g4c+4lwaf6t3tDBvjC0QnuvFwBkBczyXTd79GGq3H4QwVMoBYZxPQK9PkN+6IvsbkAkNgsTaMaBhX4XRJ8ItY3fpNrGppVsVPeWZ/J5tL7TP6mh8eF74L8BPzhD//4NIqeNL55mwxGnZFmMrsp3hTLlp/PslKYZL7HgD0yjvfabhgiiLuhfljLZNap9568aoVu5kTjRmYFEGiSNRKAOER449Yb0odvX2cMOmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OpW1qzZgxNb+1kzNQvuJ3KyVfS/Bp1DIQMlDiX2CjA=;
 b=xJr62jWLDrHBMzzn43ONoJ/tn/3m0zerKwZW1/kprS0bzem3UI45MZYWFKtw1axkJkMnx/HilvKPrKhwCCHosVBWJCeRY5kPYyEW1jbz71yvTGSwtJ2Xt//oVn/6jTF3bC0zH6wRFHi/K9PEGvkFWeSwZkkZ6Yx1ePnsi/XObug=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB3610.namprd11.prod.outlook.com (2603:10b6:5:139::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 00:58:14 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::c99e:2207:35b8:6fa5]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::c99e:2207:35b8:6fa5%7]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 00:58:14 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: phy: intel: Add documentation for Keem
 Bay eMMC PHY
Thread-Topic: [PATCH 1/2] dt-bindings: phy: intel: Add documentation for Keem
 Bay eMMC PHY
Thread-Index: AQHV+38Ct5ErQ2mOFESCzgducVHEHqhhqx6AgC3fF6A=
Date:   Wed, 29 Apr 2020 00:58:14 +0000
Message-ID: <DM6PR11MB3721F4B7281CDD101E37A9ABDDAD0@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200316103726.16339-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200316103726.16339-2-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200330202321.GA9386@bogus>
In-Reply-To: <20200330202321.GA9386@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5793077f-b375-4bb8-baa8-08d7ebd865a2
x-ms-traffictypediagnostic: DM6PR11MB3610:
x-microsoft-antispam-prvs: <DM6PR11MB3610E2875743E8057C6DC469DDAD0@DM6PR11MB3610.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(39850400004)(136003)(396003)(6916009)(26005)(316002)(8676002)(186003)(478600001)(86362001)(52536014)(8936002)(7696005)(4326008)(9686003)(6506007)(55016002)(5660300002)(2906002)(66946007)(66446008)(71200400001)(76116006)(66556008)(64756008)(54906003)(53546011)(33656002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KkBfRnVlw0NUWEuVRNgPtoWT+KOhl5KqzHtYBrQQHhKT0JHhDnmf9CcFBcaWohNM2trmcQAzNoc98pcXmstX9wprcbGpXUEn+U0rCofni4MRZoo7jCSdzwTgVAiaTyRxJTfuuxQHprTxHKEBuJPEfAVgmjuSrlda1s1j9bHJLF/Fyw9j2xfVKpEfgFJSMTIv15GOTJbTQ1cWA8WbZuadV+xrMH4BewyEcqcmAWUboGI43NVblsIw08geqqma+/lIvazvWtn7KyX/Um8MuwJ244ZeBOBy81lOt+eT1VJiweWQEM3gkQTnJ/hgUPBoKVrWIg++sdqenKiSSYeIaItt88yH9fJjJnqbXtwodQ0hxneDMYHFfOdcAaGteLVxKRiOZ+RNoEvp5W379SqAdFJdkQwJmHhBeuGsBuBfhGAsM5YJUC36XrJ6zJtYnInIdotQIZU+FwtdMk1CIQQLPBebinsuJnIlyo1nOcTJyslo4sgg5bxVgA0BHqR0KvOzoHKJx9K6hf+xYl8zecu5DXFt3w==
x-ms-exchange-antispam-messagedata: LNVqzE/7j22pHhSEGHdg0A2mVQs/RUCE8z977htjlHwt9GhIvYvms62FdayTIfYBe02rVEv7k90Msy3dUOvP9mKLzlJ+LjNxTWw5T8rmZBTwujmbrBl/yq7102nWvAW5lNAFxZPXPGymRdN+qBjRVsqubEicTXeMS5oQotAKRUTMrbUzop89SjOUsGlmIgF6EyF7iP4FQqww3rC+/XSThMZPcVLe3EK7suqIndGN/YS2KHZcIYQwl0+QG1MN204bUriqFejlnSUuAO7iVja6PAmh8Xk2y16CLCARAouNOYCmRjXCFYzRE9WsA8TpgWiyEpABu7DoRzR2QyEK0zk8iyArko88JxeuFVQ7xfdAqWTUSAUULSwcvCPvwNUTHSLGWUDcKMr9SodmAeV1wbywrayi9gNxJde+1/R1rAeNc6/cDFDgo1/jw81Ul/sB2MO+kHdgRz4a3AMoPGrbCSqQ2uI9CbugguK5hgiFa35D49iVmclfelzuduWya/E1SZpg2D/0sRd78/K+mqp6eH/PUru7y0cNMottDd80nk18wKAsgrW2gAi8eunhe8S4wdq/SoWdlD6gnT+qSzbQ8jIiLczTcvqyPJ8vGZISmI7GwQstjJgrLUYSnyBl6a8ApveyoiA8T194O0BBll6yd+g2nxlZtAqtKJAS+k3Q569+ntILzr/jFYY6OVHBBZh7v5j2ozdFBnvR8k1kSJ/Vdmhp+uOuKI68UJk20Q5CKmHe1Y2TklxWgRqATtpAHR0s8n2JZBt7FezC+GI9HmGNpcqcWm4ccDzgyXeKiKbCe5dEObNR4TkafiW4UcF2iBsV1WS4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5793077f-b375-4bb8-baa8-08d7ebd865a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 00:58:14.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGl7A8s/IIDTfpBbGn7enRarEbPn327pEHhIu0ttuzZdF914QKKsEF/CI/moxdLn3k5ZaIGePQ8wgdLvRlwfi9/Ek52LqL/64azmbC2JRgr4ghbhGf/kWfiC5WZx9a0o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3610
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, March 31, 2020 4:23 AM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; mark.rutland@arm.com; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH 1/2] dt-bindings: phy: intel: Add documentation for
> Keem Bay eMMC PHY
>=20
> On Mon, Mar 16, 2020 at 06:37:25PM +0800, Wan Ahmad Zainie wrote:
> > Document Intel Keem Bay eMMC PHY DT bindings.
> >
> > Signed-off-by: Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> > ---
> >  .../bindings/phy/intel,keembay-emmc-phy.yaml  | 57
> +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/intel,keembay-
> emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-
> emmc-phy.yaml
> > new file mode 100644
> > index 000000000000..af1d62fc8323
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-
> phy.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
>=20
> Dual license new bindings:
>=20
> (GPL-2.0-only OR BSD-2-Clause)

Will change in v2.

>=20
> > +# Copyright 2020 Intel Corporation
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-
> phy.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Intel Keem Bay eMMC PHY
> > +
> > +maintainers:
> > +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - intel,keembay-emmc-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: emmcclk
> > +
> > +  intel,syscon:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle'
>=20
> Make this binding  a child of the syscon and get rid of this.
>=20
> > +    description:
> > +      A phandle to a syscon device used to access core/phy configurati=
on
> > +      registers.
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - intel,syscon
> > +  - "#phy-cells"
> > +
> > +examples:
> > +  - |
> > +    mmc_phy_syscon: syscon@20290000 {
> > +          compatible =3D "simple-mfd", "syscon";
> > +          reg =3D <0x0 0x20290000 0x0 0x54>;
> > +    };
> > +
> > +    emmc_phy: mmc_phy@20290000 {
>=20
> phy@...

Will change in v2.

>=20
> > +          compatible =3D "intel,keembay-emmc-phy";
> > +          reg =3D <0x0 0x20290000 0x0 0x54>;
>=20
> Here you have overlapping register regions. Don't do that.
>=20
> Given they are the same size, why do you need the syscon at all?

In v2, the driver will use regmap_mmio. With that, can remove
intel,syscon. I will send out once reviewed internally.

>=20
> > +          clocks =3D <&mmc>;
> > +          clock-names =3D "emmcclk";
> > +          intel,syscon =3D <&mmc_phy_syscon>;
> > +          #phy-cells =3D <0>;
> > +    };
> > --
> > 2.17.1
> >
