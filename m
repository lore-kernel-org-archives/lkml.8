Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CF7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1BA20658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="a5+c1N1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHRQjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:39:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:2670 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgHRQjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:39:00 -0400
IronPort-SDR: vntvlb09i06F2be9M+FO17XSVcH0wW64VVXLszRTTAYrz8UYUl/+ECxHD1neTqgxlzQL2hqRZL
 3JpErTA95dIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239780740"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="239780740"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 09:38:58 -0700
IronPort-SDR: qiJ3gSU67KhGoLRBaWM7jmzEz146Etnwt02zOc3TnKwTuMxsz8kJW9/MWN/fdHiyLnxWEiku50
 B9Ja1Zm3UCHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="310496148"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2020 09:38:57 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Aug 2020 09:38:57 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 18 Aug 2020 09:38:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 18 Aug 2020 09:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUkx1I14PQzS5uJlZkFGYOWaP/+z2XS5uB+pJdJz5s5TXkBclg0jMSJ4vEf3lx76Swocecq7dzyn1pqjCXTkFos8c+jznSI1CXBP4+uZKFovQQqH1xVP5wNXF8pFpnTA8NSVkPdAR+J/m5ZWaeUpLb6wC7CgYvoOFk39b8ncIkJ5LajugkFV1LZXYobyxusRTt6qJv7zMFqP34Pqtz8yV5qWe8R8fB7yhByqlwY8sH+rBtB5op6hoKnWE5oZEYEuZSTQf6KM8kF3dAB9uNYcGhCvpULRNcfCLjPn93HlZ81OvOo70sTjqaoc2ruKQx3JKd8S6RDGf2BLaQ36hbGc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR2YvZ38/DkEurcIc7gkfnH2c/YL+9FEeNxd5Kfkla8=;
 b=enEAdVXBD2FGwwxP6XLjcbpSrYI0+Pp7qGrT4eOzu5CSMtXWO2W7pIAACtLQeHqMTE59CslOkEI9l460o3CRr0oBc7KgRhpaEU0vYQrgojw8dhucLGXqhaprwTthnDMS6WatTShDAcv+Vz0wCCsr2HjQPbTHw5pCNMcNQ864oYyuBGf5m4io0vObKXj1zY/DlsEy5XytvuagCogRfVE29qyCeVybovNZSszQQT6YfVVKX4gzYs+pAaF9Jw0Rv+HUzdWbHkabs6gI0m/snc8JXCInW/ZrUH03RpjE2FfrKz7rVZ8CxhB7Xi5TZUwXHTItjw8dN40u7qWKcNgG4YsW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR2YvZ38/DkEurcIc7gkfnH2c/YL+9FEeNxd5Kfkla8=;
 b=a5+c1N1Vkc5YimwcGDJne56DQ75Yq8ZmNFM+84vCdKTOcWhyuwfyZtZ0yO8MPvOxhJ0hdxF/qx66I0xTiOYle/du/CIbs9jP+wJChMPJB/Po0SGBgymAurJOW8Lt/8vprpVq2LpxEx5DlbsOg9fmmTPBXwOky/sP6Tbheiu8TMw=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 16:38:53 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::18a3:e19c:fd98:f75a]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::18a3:e19c:fd98:f75a%9]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 16:38:53 +0000
From:   "Zhi, Yong" <yong.zhi@intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Support Opensource" <support.opensource@diasemi.com>
Subject: RE: [PATCH 0/3] ASoC: da7219: Reorganise device/codec level
 probe/remove
Thread-Topic: [PATCH 0/3] ASoC: da7219: Reorganise device/codec level
 probe/remove
Thread-Index: AQHWcACDJNkriZkGX0yTzROdPr+vcqk+GLYQ
Date:   Tue, 18 Aug 2020 16:38:53 +0000
Message-ID: <MW3PR11MB4665D9AD35EF41A7F24F5208855C0@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <cover.1597164865.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1597164865.git.Adam.Thomson.Opensource@diasemi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
authentication-results: diasemi.com; dkim=none (message not signed)
 header.d=none;diasemi.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [72.180.71.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1beb868b-a805-4563-d46b-08d843953160
x-ms-traffictypediagnostic: MWHPR11MB2047:
x-microsoft-antispam-prvs: <MWHPR11MB2047BE83056F8F4CB1A483AA855C0@MWHPR11MB2047.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Win53JuoCpVF+b868qS7QTwplM8Qpgs5nmMKkPOHltbhEb6BxrTcEW2wpFKU8nkc6/jLA4TxxvlTlRGQJAtQoW1NuzbyjeLhuD89DELczraD2CfRQLrGv7Okr31bSgfSEZv6JzOHW+xAf7/VGQ/xxfkiFBYtqSwltcqNmiuEx1pH+3TgL8r2CjstCMOu/ZTLlV0jLHzfXEdq3YTDMolGauVwodxnSMmF2Krs3Sc6/PYNATpPtRBcXV6iz3zMthPrN8YwvhtEueKAIw/Rj3+twMzldz4pfZNsfeAAvTqKZWWsdNbAK1Ld0Zj0YsmA5hPs1IWQERxLf3ZUrh/ICvpJfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(86362001)(7696005)(9686003)(53546011)(64756008)(186003)(76116006)(71200400001)(33656002)(55016002)(6506007)(66946007)(83380400001)(66476007)(26005)(66446008)(66556008)(2906002)(478600001)(54906003)(316002)(110136005)(4326008)(8936002)(8676002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uyuqo8OK7IC5r2hNvHD3JD76WIJz0Z0/+GbI803NciF+xuXQGUYizkcl/ceKqITN+TvLKfg4WRdsFIq1B9Pj4OXugFTDYCoURfD79sA6j4cThM9RbeqglfDFeLn85ZaH4CtTF5M3QlWAsx+bdhn94u9TcojnbfD7zc5MZvysawBlsMfgTJoQ8zoSI2rI+d5CwuRqDrfufVDhWJyXkFWNT/IL3ZS/cb5Wz5wFsMty412r4Z2xApJmHuxiMtapygWHnrvGnfR2JWUu6PFPQOP+8P2u6/Q/BAXXHPdPodciW2A/Fz9AdEjTqruIHLeeIzY/TN9tkCt/51917eFXH3Fv3GRpwcmy2kX6BjHrZbSrS6fCXA39wYK5sXSkev38Mp0G9mD578h8nt2Pc0/mEa0nNizYims/m9YvCUDJbPADtVU9cy1D96Pe2EkPJ5ElIIaMyjLt1gPCD5G1aBbD7w378x+QtOwFs0T4sQb0r20jr6k331Aaly5k4JEs6UWltJuAv2UotgFeg7XJp6Nb75n4+fFEikzr9t+ua17GWSjt3hts+tSEfmercIHqpsHkEl1ZDyD2tItu89OCtIdVUH2iLbh2rKaCKbL3Fs+1DHUPMZILfeWZ2Y7xi8FzfUKbm/p+Lq9qmMtJ2kOko1X1cTxScQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1beb868b-a805-4563-d46b-08d843953160
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 16:38:53.0283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HStD/gtMftTeYztzLH82VVyPwzKev47JQehk9BD9vGMOtxUUztFlLJh8QkW2pgYm/scUNfS9jmYlgFdQjE8gIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2047
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adam,

> -----Original Message-----
> From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Sent: Tuesday, August 11, 2020 11:57 AM
> To: Mark Brown <broonie@kernel.org>; Takashi Iwai <tiwai@suse.com>; Liam
> Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz>
> Cc: Zhi, Yong <yong.zhi@intel.com>; Pierre-Louis Bossart <pierre-
> louis.bossart@linux.intel.com>; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; Support Opensource
> <support.opensource@diasemi.com>
> Subject: [PATCH 0/3] ASoC: da7219: Reorganise device/codec level
> probe/remove
>=20
> This patch set reorganises and fixes device and codec level probe/remove
> handling within the driver, to allow clean probe and remove at the codec =
level.
>=20
> This set relates to an issue raised by Yong Zhi where a codec level re-pr=
obe
> would fail due to clks still being registered from the previous instantia=
tion.
> In addition some improvements around regulator handling and soft reset ha=
ve
> also been included.
>=20

Just to let you know that I tested this series on the JSL platform, the ori=
ginal issue was resolved, also sanity checked basic use case like plug/unpl=
ug and
suspend/resume, no regression found.

thanks,
yong
> Adam Thomson (3):
>   ASoC: da7219: Move required devm_* allocations to device level code
>   ASoC: da7219: Move soft reset handling to codec level probe
>   ASoC: da7219: Fix clock handling around codec level probe
>=20
>  sound/soc/codecs/da7219-aad.c |  85 +++++---
>  sound/soc/codecs/da7219-aad.h |   3 +
>  sound/soc/codecs/da7219.c     | 493 +++++++++++++++++++++++-------------=
----
> --
>  sound/soc/codecs/da7219.h     |   1 +
>  4 files changed, 328 insertions(+), 254 deletions(-)
>=20
> --
> 1.9.1

