Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF62206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="AZWX8CMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHXPJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:09:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:37005 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbgHXPJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:09:04 -0400
IronPort-SDR: BrWB+Cvj0GvGQ+2UIK8sCSH5rhTflzol7OV7YN3icjncsdTSMQIKLgU+NpVyFAxOzZoJg7KWfA
 c0bREIijU2sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="153326932"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="153326932"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:08:46 -0700
IronPort-SDR: +oQiDraBh5fOfgscv6j9rhN6PcIRsq6jOKEuBtgLrRNoCT8WhPliTLgDd+j3t/WW/+0JnwZyDW
 Aa9uKG4cjWKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="298745058"
Received: from unknown (HELO fmsmsx606.amr.corp.intel.com) ([10.18.84.216])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2020 08:08:44 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 08:08:43 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Aug 2020 08:08:43 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 24 Aug 2020 08:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez9OoF3NA65Gks4nsmDalwROz8sA5dUsO2U1ysiZdzsg5xAY7VEXrSM5R291AvPgn0LOIImkrnzmBZnUwQ9x26p4SgmTiXxOR0Y173lnut2k7NOSYxvd6g0cLpVveht7Thd5TcGtIxwGi3UXwmfSOAZKilkhXVna5qP/JZEO3qET2u63NNbijc3/a9Kmpksa2OzGMRTHQOyy5KvFet061e16xguYEKokbyobxM7OjBAfTTAnfDFwBU9huS/FxQlyu1Z+6cMEPSreqDcReZ7bjWglUN3r+b6lWkrLfHxQWIwvBBQzzi1dIy2fHtErlV2wy+wldRlQ35EJ4Gq52GtsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcVg7icyb8NWpK/rtrkemcj3yOyYRhRvq+3OH6yIpaI=;
 b=CuE54gKcdZ8iKyQV5ILNA1g3Vm+murFUVHr3yehEl+FOpZffDTcfYvLOkNArBw7j5fSGAvkujWC+N6vYZSxAdA4yKPCirR4VVx4Q+XNEhBRB+/4sSGyaKbpH6W96+3rQI+4gkTYmG/JlAidrcOUKWqDAKSvHvOJmzHOCAPUznORZ0ZpKEMDv2dsAyNXqZk8PLA+fgGG7dpND1t+aaWEXlfHjmCRvLiJuHD+4hW4y6Mh3clpJQXT8C/NpFv03mIFJdMiB7cmXF5lZu3OyOZI32cL9YHp+PgBqpHpeZ7hXElwvxZRHzyD87w8rjhLHnA586f3H0xvDk5xaMX9+tSBUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcVg7icyb8NWpK/rtrkemcj3yOyYRhRvq+3OH6yIpaI=;
 b=AZWX8CMcUdz/3R0xZi8/0mUO4OcyQiEg7FTX4k6iLnPCQNneOWCtAEWL8z//nP2NkldwgR/GNhd5t4hOg3CtDpvngGKQn3hER5ZTQmi2Lb8FEbSKCGDszrb8wuE7CppqQHYXp0qijbQQ4+qaZpEKz9gL29avT5Ckchur29hwv6M=
Received: from BYAPR11MB3096.namprd11.prod.outlook.com (2603:10b6:a03:8f::14)
 by BYAPR11MB3365.namprd11.prod.outlook.com (2603:10b6:a03:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 15:08:41 +0000
Received: from BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::d806:4b30:7625:5375]) by BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::d806:4b30:7625:5375%6]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 15:08:41 +0000
From:   "Sun, Ning" <ning.sun@intel.com>
To:     Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Update Intel TXT maintainer
Thread-Topic: [PATCH] MAINTAINERS: Update Intel TXT maintainer
Thread-Index: AQHWcKOuufGUaux6fkqJeEis0dJUAalHbzEw
Date:   Mon, 24 Aug 2020 15:08:41 +0000
Message-ID: <BYAPR11MB3096662DD25482E46C8F3C0987560@BYAPR11MB3096.namprd11.prod.outlook.com>
References: <20200812122401.1751885-1-lukasz.hawrylko@linux.intel.com>
In-Reply-To: <20200812122401.1751885-1-lukasz.hawrylko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [47.7.63.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca324254-086e-4647-0717-08d8483f962d
x-ms-traffictypediagnostic: BYAPR11MB3365:
x-microsoft-antispam-prvs: <BYAPR11MB336590433D22E591A7FE123887560@BYAPR11MB3365.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OMLGKRfToLuQX5k6NJJv3VDjBUm5QIRvLX4G1LOJOuoWkzdkKG6VTeQina0SvSqsxiKOUQNufjyh8+xKmxhHMaB9z4AZHkB7a1OTGP/zlWYA1nCyE1qJq8TWracL412mXS0GSVoNnwP0HE3inWZZiuXxYc2jzMVr4WbbUEAihS1Xm89Y6PUyoJAT/BNAN5OCjuAC52Ae0StYB1Ip24hqo+AjVoa6ezGls+/g9BwEtnW6ok65ba/Zyq7XnRu8YPcL7hCzedgkYCkJTzw+6SQLyNIXtNZssce7XZ1xBdhWYyMazHrd4CItMASoVGkz9zguOpv9un4HwPtKpb+Mp7XGxN4RfDSvQ6OQkN3ysb67nrRXKN4dtnEZUalz875b0+RTyVffnjZveme+gTbu4zcTVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(279900001)(66446008)(66556008)(86362001)(4326008)(52536014)(33656002)(53546011)(6506007)(66476007)(478600001)(64756008)(8676002)(6916009)(7696005)(54906003)(66946007)(9686003)(15650500001)(83380400001)(2906002)(966005)(186003)(8936002)(5660300002)(316002)(55016002)(26005)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qdlpxCWFqBBuhWri8XzpXDat+CiguMWa5Ug7zgw26hB/OwpiQxn4TwPxXt0Mw6hawfbtfVs8w7KnTEYiQiqSMfqIZhgNz7QXFF91Pm95GFrmkgjD8D8mOsjvpThSr7+M/2C9wK2Zvh144aVEUIIw723xYMVU7/KepN7mDkQDTy51atPuFXB45cfgUDQGQpjF+PyVzuv2uFnSH+heWaBGC99JhZEzzV+fGXix6mf19VSXGkNsX2UgzENIH3RY8+IH4KDk/ly7bT/vcP2LBMYzhxMkwUEFPt8RfiAt7DZJLtqy9Yc+ULDHAIFW5lGthYTEIGDcbk/N8ITgL+xNx04LP4yyiOEBHkiHWHhRtqjlGjQBNNgAAwMkDpwtoTGRdNPtw8lk4ZET7OSPZVF0zmNR0TZgi4aM8p09u7HnYxjmtfoLoJZNWKRZYx0BpvlPDQGNztSRihnSpGPMkyI5+tQgTZDoiXi0kGGjbfRcRTtMaaVyi07i6SIf8Y0EffDWTfVqPyu9wJB9IvGJtn3FH4sOeUQ3FUU5didYIsSDKezuSQYMZAazpNXy74xXRciKLFsfxTkvTzP9qFXKFPc/VoVLjUhVTkD3P6v0/mIQqwE+wcEadIxJa0B9qd7JtVQc5Rdu7tOiFkr7QEWkAquXJ5NP0w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca324254-086e-4647-0717-08d8483f962d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 15:08:41.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDRpsR+2e8TcDkxyo1oce0br608XNUZ+3ufeCYLykdcL8YXfD9VLFa9hD6jMiAVrZb6Nny9YVlxd7hnBFsqlEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3365
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acknowledged.

-Ning=20

-----Original Message-----
From: Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>=20
Sent: Wednesday, August 12, 2020 5:24 AM
To: Sun, Ning <ning.sun@intel.com>
Cc: Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>; Mauro Carvalho Cheha=
b <mchehab+huawei@kernel.org>; David S. Miller <davem@davemloft.net>; Rob H=
erring <robh@kernel.org>; linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Intel TXT maintainer

As an effect of changes in Intel, I took resposibility for supporting Intel=
 TXT in Linux from Ning Sun. This patch also replaces link to repository, a=
s previous one became outdated.

Signed-off-by: Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e627ed60d75a..cc70a40bba20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9039,11 +9039,11 @@ F:	drivers/hwtracing/intel_th/
 F:	include/linux/intel_th.h
=20
 INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT)
-M:	Ning Sun <ning.sun@intel.com>
+M:	Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
 L:	tboot-devel@lists.sourceforge.net
 S:	Supported
 W:	http://tboot.sourceforge.net
-T:	hg http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot
+T:	hg http://hg.code.sf.net/p/tboot/code
 F:	Documentation/x86/intel_txt.rst
 F:	arch/x86/kernel/tboot.c
 F:	include/linux/tboot.h
--
2.25.4

