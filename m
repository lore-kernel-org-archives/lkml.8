Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA313C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1CA206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Fx87Y38B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIAEty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:49:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:47357 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIAEtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:49:53 -0400
IronPort-SDR: ww/a0pG0504si7PYb812+nYb2y3QalE7TteIYWTLkHJiq/Or1DCs45SafOHz6MACnot6g/m2gE
 2DdTwUOvCNGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="218658241"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="218658241"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 21:49:52 -0700
IronPort-SDR: DFV3ri+NETpGNt+y003w/cL+Zx2O/7HPU8ecgTLFqqsiiLsE2eSKsp2jdcqIidv7Go0rTnWItC
 EFrcsP+W0YGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="325196879"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2020 21:49:52 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 21:49:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 31 Aug 2020 21:49:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 31 Aug 2020 21:49:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3BB4fFT10NKk7QJKPjBJuHitywIVJXuDOgBCAR8r4Yq2KP8DcotwI9zosscMoXUU8axC46oNHJGZjqZz+NCKdVVVy8/EbaFEELvXYbFA7fBC80k41aEJ/SxEBTrW1kTw1jdyHMi/ALTcwYyu3axxksYzJVFPUFDoGD8X13o0LUTMZkC0BIxV1En8K9gxQKQCXqPUe2nlXIRuyI8ireg5+pzJeBbVolysqme7MPrS3v9QwGVku4QG60fXgn+PW+Ui47EOROJ5ohleHomctWCLGhof2zPg/f+pIqKvUD/a7Tki4cJYTjO8D7oZpF70y0IHlmW97YmgDf2Hkb5Rtp4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt2q0w+Ue6Uj5BuuTYXkdLCLTf8PCTMmdeZy/CleXKs=;
 b=G50UPPGTvRNgnAViJ+4vrtX/JO2OSlC2PMrKPbClRp7pTvq262wB/Q8MqO4rg6XQGC6BIJCwwneMcY+M+rc+Zcd9NyPumbhaESwgRbo/ncXr2p0/tjAGTwZLJ6gfCSn8zXh/sssAS41TpF5I3d/rnFi3nBss0p1aE+0CS4GMyCcX+9PBYOVRb881XhtVvPPKP5cIrOKiroGeFg1lpFc/JHd54ObwBSd18VigqMKFEWaDrd3igy/d8Jbgw1jTEp5+/KTWGsfH0ZnrRjr4bifYQxSbp833otYJM5/m1QLia2hLxEGB5pKYpQF0FjY3haEVu0/9bF+r1DVHcKoz9JqWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt2q0w+Ue6Uj5BuuTYXkdLCLTf8PCTMmdeZy/CleXKs=;
 b=Fx87Y38BYXCE7YkNUbTPYp/7hT8/rdSynkoqWgT4qbJWZMnRcUXo44er78EeXiHrMyMvQ7BdQSV08TTdtOyBwP0HCC1Nl7yi0PwaJNnKejxcWo0Gi6W1jIaXwmv2ZlLfuYF2VDhHRQIF50hdgTCtDS6uvTfZWcRxaErlmuV2gVs=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 1 Sep
 2020 04:49:25 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::7883:72bf:ad85:5166]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::7883:72bf:ad85:5166%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 04:49:25 +0000
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
Subject: RE: [PATCH v7 3/3] phy: intel: Add Keem Bay eMMC PHY support
Thread-Topic: [PATCH v7 3/3] phy: intel: Add Keem Bay eMMC PHY support
Thread-Index: AQHWf3fYgpT7j7ykyEyv+5f3vsznaKlTNxFw
Date:   Tue, 1 Sep 2020 04:49:25 +0000
Message-ID: <DM6PR11MB37212B71B26A9642CDEBC320DD2E0@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200821113747.2912-4-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200831091936.GM2639@vkoul-mobl>
In-Reply-To: <20200831091936.GM2639@vkoul-mobl>
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
x-ms-office365-filtering-correlation-id: 2048ddd3-5dce-45d1-8326-08d84e3266c1
x-ms-traffictypediagnostic: DM6PR11MB4628:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4628D888EA4C51CC355617FFDD2E0@DM6PR11MB4628.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNvkbn/wFbIMPoW3CJUH6isbuxevezPIdKOJx9YFzg3rdCjQ2S7wEKSVdvn3NoN1KNCd3JNqmogJl2hMSK6+QG5Kr4Dp7FDFYLCiY4Bg5NW1mfvbu8crEelS1DJqZ0lthx0FA3cHIqYu1aWrhUgftynoFSTbkNdS97fRw9rJzaSAZcvneVe+A1uMqe5xR+KdMaF586LpqT8ruairR5TCnTb9iXraRqPG17hS+DmjkkPzC6Ou5hgqiw2OOPQrqrf8DleTyn8e1KrW1fNo3+WR41tLw2i3sdx3Wvo9zOUkZxZA5hN3YYpZ8ZEXjIlSk3AqUYwJ6guW1fm3ZaF9kf6f9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(6506007)(5660300002)(83380400001)(66946007)(66476007)(7696005)(33656002)(8936002)(19627235002)(9686003)(76116006)(64756008)(52536014)(53546011)(2906002)(316002)(86362001)(8676002)(66556008)(26005)(6916009)(55016002)(4326008)(71200400001)(186003)(478600001)(66446008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CBdG48IyveYLZRigj4dp+8oAaXPo804ZOm/tAgvkrZmDz9QDJiw5Jmj5puCG9gmARWJADsCdeM7kQbaIt6LnvPuAFl2YbftOo9NWDPiCrSiO0NeLfz5cHcZ5MMOyUuPughSEwA+tTwslT4PwlbfrgvG01uJp6eYl7X6nPd3XCuUn4KUgrPgyArRo7L8g0zfXvAeh+NJHqT8nXQEWbT4lg4cAr4+JnM+go2aDFlPusAoG9ZH2GxuXGrImLhTuiZn//8HNRQbiJ64qzVxpGpHFnYIBWwi77ri+ME4gocBZ5q2OTq+UcHJYtyOOdeQmjKyVWA9ocK66JhqyekBSwi4Fae1JVY0iWSP6Oz+tWz7TsGUrwTdeB0Gn8cIzJCQ9y1dD2Z6MTtP/sPBqKkjSttBFLDzmzxZIhp2YbmvyEQynIm+n71JWMtV3ejrMKQ48lqBsu3NWkVCjJFYGt22GNUzAAMRNJSXKoeUwvfrlzwttNJgBSpd7+wl2PlBImqA5vufOEmMRRC7DLZDfPuNNzeSP+8+411tpEjStn4Mf4ckECkuVQgl3o12NfgyODFARbvtkOsILXRHlILheMdrIvXOZaESNwb6b0W9nq8RX1XfdgWy8OWWIWZbtLoitZ73D/21UArUoageRObLLQuqg0W8WVg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2048ddd3-5dce-45d1-8326-08d84e3266c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 04:49:25.1105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFoV/6r88SWeDOVgns0TdPMg5vqvlaYs2JyhiMLHkMrNRuiSsaq5wgxIdYudiWfLp7t8ME6yFCtmVKsJ+MASU5pOOK3GdTN+H+Xq82tFELu+A22Q0AWdtTJmrpVi6x/d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod.

Thanks for the review.

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Monday, August 31, 2020 5:20 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; robh+dt@kernel.org; Shevchenko, Andriy
> <andriy.shevchenko@intel.com>; eswara.kota@linux.intel.com;
> vadivel.muruganx.ramuthevar@linux.intel.com; Raja Subramanian, Lakshmi
> Bai <lakshmi.bai.raja.subramanian@intel.com>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v7 3/3] phy: intel: Add Keem Bay eMMC PHY support
>=20
> On 21-08-20, 19:37, Wan Ahmad Zainie wrote:
>=20
> > +/* From ACS_eMMC51_16nFFC_RO1100_Userguide_v1p0.pdf p17 */
> > +#define FREQSEL_200M_170M	0x0
> > +#define FREQSEL_170M_140M	0x1
> > +#define FREQSEL_140M_110M	0x2
> > +#define FREQSEL_110M_80M	0x3
> > +#define FREQSEL_80M_50M		0x4
> > +
> > +#define maskval(mask, val)	(((val) << (ffs(mask) - 1)) & mask)
>=20
> Kernel has a macro do this for you, please use FIELD_PREP instead of

I have updated to v8, to remove this macro and use FIELD_PREP.
I also add changes based on Andy's comments.

>=20
> your own macro
> --
> ~Vinod

Best regards,
Zainie
