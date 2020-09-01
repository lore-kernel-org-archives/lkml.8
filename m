Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB2DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09F3208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="AOx/MDON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIAE7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:59:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:19263 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIAE7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:59:21 -0400
IronPort-SDR: pTHfXUMshQ8ltFDdnZM3Tsy7ErEQhXztSs1kx1otuPoZfqNIS4jrTinpSwh2YvWWFcVvf4o2rE
 kS/dWIgp6ajg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="241918592"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="241918592"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 21:59:20 -0700
IronPort-SDR: TOLDWYL0vNcicxJ5eKz/DJkkRGk8cg4E7LZT7cYNXY9zYwyqaYJkbOYgyRUBQbZ/6zU8etNJik
 jX6OO/gPsq7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="333593563"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2020 21:59:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 21:58:49 -0700
Received: from orsmsx104.amr.corp.intel.com (10.22.225.131) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 31 Aug 2020 21:58:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 31 Aug 2020 21:58:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 31 Aug 2020 21:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxJxe9DM0NP3JVRIHPlCplkVKjHUq+Lqruy/a9UDyE/lmYF0+3ktd78GgJ7iAhAQsqmjiTZaT1jnYEgpjAwG4EwKAOsA/g/LpP1zjFATWQ48CW7tntdtlUbFs81Ng1INsQXjLDkYWuAd9t3Kh6screg6iXPd3sfXoKckI6E98IUfQdPzBGYJRkf24iTGWJwqTtHDtsZS0sF4xcXiHwQgGv9dK/26PSpNcYuTaSQmb9W4U6dkFFuiW7tOYWPOv1cZ7qMyRn7cjmmR6qbkn1UsTuDAVrC1omLDMqIdZVItvsMs8HqcrvR57lZrPoHo7QmGHa0kZjyl9AdK3h13+DKGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoOPBr7vo3yUUuR0SPo+3JPjj70L0k5f4dO5t9oEPyM=;
 b=RSSyPny4b3K5Gt4Izo7GFz1RPSJxCKuVpzDvIAm/382AqXChXkx/dozkV0cTIrtvDxh60GkhrYVNyiI1D6UflC/tCr3y+UUABeWFGyGo+PUXCJPwQ2pVNET8X9kRcOIN9YO80nz3SEcwVRAaWUdoY8SiP/lIJtvO6fz++tX39OsPVpltzFIOSuBRxvcTBzWIE8jf2Y+a6wpH6dVng1MqS+Z5Thuo0ujvfcXMP9RBUzZgoo8pauRGkzj2GdBkg7ZmUCO2mzZSnMdbL0X7yfG0Suz2ZTzI+7djasuhGcmaNbfsw1Me4Bgiq6673+oavFWXR9VrBIzEKnrkyJypIAPjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoOPBr7vo3yUUuR0SPo+3JPjj70L0k5f4dO5t9oEPyM=;
 b=AOx/MDONrlauLq/9cTaOIE3KFcsqcVU/tnVGdZN4yXo8bf7eDimF8TuTVpOvIRYjP0DcqbSUx2mk2sZDWVQxWltdZrcTJmURU7ZcczA8Ov9vbdRCfpG5J9OgV49m4mYW1+DoXgP5iTtvtfU7T31YOFu3rQBxjSuG+ptbL3KdcyM=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM5PR1101MB2236.namprd11.prod.outlook.com (2603:10b6:4:58::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 04:58:46 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::7883:72bf:ad85:5166]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::7883:72bf:ad85:5166%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 04:58:46 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "eswara.kota@linux.intel.com" <eswara.kota@linux.intel.com>,
        "vadivel.muruganx.ramuthevar@linux.intel.com" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC PHY
 bindings
Thread-Topic: [PATCH v7 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC PHY
 bindings
Thread-Index: AQHWf3dxw/rzA2qt3kKkXMMhVhHoqqlTN6sA
Date:   Tue, 1 Sep 2020 04:58:46 +0000
Message-ID: <DM6PR11MB37210C56315013E4995DE2A3DD2E0@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200821113747.2912-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200831091013.GL2639@vkoul-mobl>
In-Reply-To: <20200831091013.GL2639@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.227.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71f03cf-8cf7-40a9-4ba8-08d84e33b588
x-ms-traffictypediagnostic: DM5PR1101MB2236:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB2236522C6988EDE3BD2EAA39DD2E0@DM5PR1101MB2236.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TkQ2C+EB+glqaXOOFsexfLcMmL3BDoH3bXfCJJ6fPiqlX2GS14D9jTEZIhi91JCVZpzqpRVo5OSrsbIhBZrnEHw7F++8BjNf4IUYUsjIfao38DmrgdKEbLVHdq649w8PprzpUG7s8iqYAe+kbXMSxR8813xY4RtXyE0KCr3hqk9OT8kwfzf7D6TR1tFuDntw4nAk4M9JMEsgIaf34zlYGeFZkV9D3Vt90SA38K/eAySX8giKogQnFPN9KunRKIAvmG7aRyQQne9ZWFAgs4Bs4fi3gXB261te6KqSqBVwWWhpjOWbdnUrPS2pdiNo38qzag2h2GzcAIMJS1PXM9sml/DRTPNltfA9YGeKyQwvB16LblJ8YMXWh1w1F2sB5y3uOX0jbHUmg7W+sBwmZWbiZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(6916009)(8936002)(53546011)(64756008)(66946007)(66476007)(55016002)(33656002)(6506007)(7696005)(66446008)(5660300002)(8676002)(66556008)(316002)(71200400001)(54906003)(83380400001)(2906002)(9686003)(26005)(86362001)(76116006)(186003)(478600001)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: DR0PyBgoPfurdbwOfDluP/VyyuMluKouhVyyqT906srZOaXOclocG2bWiP8Ix+vcXHswCYjkJkmVkm8WU9NVDCc/LyLr2jlvMy5sav7U5kuOfmFTX4kV+bUkpHQuRcbh3jIcs8GBp4hhu+H4PhEiqhFccS6ny0Y6yaLPC+2MuzJvVJ54iqSvLHcMCFKDIxyOzNeQpBzCYJy2KgNmNLD0oOgR5K3dh/50+K9SOph0fhIDiunEPq6RNwEp7+ZnXAuxGvZ1Ul+gWIHZnJsW7g/WW3I4Wb+I+Xgz2WLVmDtlqzZi6pm0W6actspM79eZwkbKfN0wGaWWkGJkPt5d1Xt05753kYk2YTreIGLaF4kMjv74H59HeH3JSL7MwehEqnuV6XOa2yGFf2Vxov3w4rZz66/9M2Canuir5JMINbyKXRmCBWaqwiZ4rsfUYtIpp13aDDNwthNrUxYrwsxbkVMeTU/bkGCFrzb04gJgEZ8V/SEKPNpGQilY5Lw1jeW3O5huuvHpAn11qBBIO4d5WmPVAQP8LoezzgOS9fO13lqR2mBtTUtPzEOW9mTYiHmlrGCLoJfV/jz+Sdyj11YtwcYAQ4GriJNWLD3cOylaEAaeWIGZg07GyY1In3EzGRjZojbO8oZ15ERh9MRX4p/JSoYruQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71f03cf-8cf7-40a9-4ba8-08d84e33b588
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 04:58:46.7602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEibAI6maQbA6Y5lGMznVI0dFV+XaiJdniKkFeN5R8dxd+hBOb144aE9ur4INFzEquViNb48TJcG/yL+522uj7TJYL2SmSBhSEuMHKbLZdrTaXslt7ANy6o00X/4stOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2236
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Monday, August 31, 2020 5:10 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; robh+dt@kernel.org; Shevchenko, Andriy
> <andriy.shevchenko@intel.com>; eswara.kota@linux.intel.com;
> vadivel.muruganx.ramuthevar@linux.intel.com; Raja Subramanian, Lakshmi
> Bai <lakshmi.bai.raja.subramanian@intel.com>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v7 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC
> PHY bindings
>=20
> On 21-08-20, 19:37, Wan Ahmad Zainie wrote:
> > Binding description for Intel Keem Bay eMMC PHY.
> >
> > Signed-off-by: Wan Ahmad Zainie
> > <wan.ahmad.zainie.wan.mohamad@intel.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/phy/intel,keembay-emmc-phy.yaml  | 44
> > +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/phy/intel,keembay-emmc-
> phy.yaml
> > b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-
> phy.yaml
> > new file mode 100644
> > index 000000000000..4cbbd3887c13
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-
> phy.yam
> > +++ l
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-
> phy.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Intel Keem Bay eMMC PHY bindings
>=20
> This seems same as
> Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml, why
> not add a new compatible in lgm binding, or did I miss a difference?

AFAIK, LGM make use of syscon node, whilst KMB does not.
And LGM and KMB belongs to different SoC family. So, I prefer them to
be in separate file.

Having said that, with few changes in wordings in title and description,
I think we can make it generic and can be used across few products.

>=20
> > +
> > +maintainers:
> > +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: intel,keembay-emmc-phy
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
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#phy-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    phy@20290000 {
> > +          compatible =3D "intel,keembay-emmc-phy";
> > +          reg =3D <0x20290000 0x54>;
> > +          clocks =3D <&emmc>;
> > +          clock-names =3D "emmcclk";
> > +          #phy-cells =3D <0>;
> > +    };
> > --
> > 2.17.1
>=20
> --
> ~Vinod
