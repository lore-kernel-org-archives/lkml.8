Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3F4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B9120663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="eOb26pOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgFCXsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:48:47 -0400
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com ([40.107.94.98]:38259
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbgFCXsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:48:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMstDFwiC799yuBLZJsA4Oph69suwb9ofo89KUAVwBxN6AuuqkhqKLN9ZS5GHRaH1Q+rBuTxRMGAya66UZSRe+a0Hd1gL1EyeP6fQOlMvDB0io9wZaIGNZzwyjc60hy4M8U4nYnDJaz2wWyCUW1DKFTHlSuB4IaJZRw5XYZfikmGjLxlaCkENT4YhQcUYrEoA21sg7JZTiGbxGswuu49emenqHRXsLpEvF6pmcWKmfCVOfgVYrffgH/Bp5wa3bfxFrLbIHiUE5gpKHPtZ5Xe7wVxwPpQkeUjVbojwNVWXNlG1Ov4HbJN4BhupYnA7BPQS1HE3HZfxT57WhtZrwwo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+02thDz6m0KR2nBrznAjCv9b+rmWIPsu2l/KJMVyQs=;
 b=Td3Sjp31yaH0eiPDUeQe+z1X6Mq3fPtONM3Db8JnNSXmJzlK/APpokmV3O+7xxsqeuNElVoCL4P5YtOZMzsXHpI3HAy9VyD59ZemnAH0uRhtJBZZKMPJCFN9WGSFctTps+tplqraMiCXa4FKgV1ZvIkJngoNXPqnRzEIDmmCyVDYUXcwV59DdqnlLoX1V7Kg0hRx7Qac0gcUALzZujTQIQcyqaAnC1xnwaNePAkP6Y1YdpY5r5yKI+rpOVMEKLETrelcRpOusd+WuBhHdV/qNGtGPABotoIsuSkwHi04Ym28wv2xiV7PCGdobRamo4S65lhxMXOegD0fk6BOwCTAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+02thDz6m0KR2nBrznAjCv9b+rmWIPsu2l/KJMVyQs=;
 b=eOb26pOHL5OGU7JvCWAdRBzJplCHxEnbY5ylW4lr9MeNC0EBiTbz/jPiuglvSVOZeYpo5Vjj5/Sai25zBz5P6kx493kXirQ10XvuPLzSGjNV3hEEe2O0xXN680GF52I9xFjs9ZXI8914qTuaAu5SSbc923ge4laejo8wcGpLIfo=
Received: from DM5PR11MB2041.namprd11.prod.outlook.com (2603:10b6:3:d::7) by
 DM5PR11MB2041.namprd11.prod.outlook.com (2603:10b6:3:d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Wed, 3 Jun 2020 23:48:44 +0000
Received: from DM5PR11MB2041.namprd11.prod.outlook.com
 ([fe80::943e:5d50:4046:208d]) by DM5PR11MB2041.namprd11.prod.outlook.com
 ([fe80::943e:5d50:4046:208d%12]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 23:48:44 +0000
From:   Steve Lee <SteveS.Lee@maximintegrated.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "steves.lee.maxim@gmail.com" <steves.lee.maxim@gmail.com>
Subject: RE: [PATCH] ASoC: max98390: Fix potential crash during param fw
 loading
Thread-Topic: [PATCH] ASoC: max98390: Fix potential crash during param fw
 loading
Thread-Index: AQHWOZjok5hm+3ydWEypvnQMZosX1ajGwe2AgAABq6CAAAFjgIAAytiw
Date:   Wed, 3 Jun 2020 23:48:43 +0000
Message-ID: <DM5PR11MB20410DF19D2353D0C0C04CFC92880@DM5PR11MB2041.namprd11.prod.outlook.com>
References: <20200603111819.5824-1-steves.lee@maximintegrated.com>
 <20200603113145.GC5327@sirena.org.uk>
 <MWHPR11MB2047B58F4B5E395CB76CCB2392880@MWHPR11MB2047.namprd11.prod.outlook.com>
 <20200603114241.GD5327@sirena.org.uk>
In-Reply-To: <20200603114241.GD5327@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=maximintegrated.com;
x-originating-ip: [211.35.184.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b07e3b8-e334-46ea-f7a7-08d80818a6bd
x-ms-traffictypediagnostic: DM5PR11MB2041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB204113051BA9DA408C4FC0DD92880@DM5PR11MB2041.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMCfFfiyDh0lBdC3vPxqgGwZ2ao9nMjr80MAKWXzSxh46gR16cN0EumCY/+JhbtC+hmuCHqBt4hAH7H/Vs6GioTKwM5PISodgBZcNrNryGFHdsahUN8wjNQFHuBM8rvwzFXerJ3d4uQlMtJlLn7gPPiIVDCFofnanbk2n8fYQp0gT+ndIYrHHIQLGoqGdwJ+pHn/isuMVUmv/eo0kan6+r6zWX5r005Pn0wW21MZ+FeajaPV52VK0nRMr8Pq758C99AnIpCsLFGUAYnDy+wAzdNH9lSQGlF/EN75kcXW07iXMl2CXXmljZRLeKlqPCwc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB2041.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(33656002)(478600001)(76116006)(66556008)(71200400001)(66476007)(186003)(26005)(2906002)(64756008)(66446008)(86362001)(66946007)(8936002)(6916009)(316002)(53546011)(7696005)(8676002)(9686003)(52536014)(54906003)(55016002)(7416002)(4326008)(83380400001)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KvLRvNIvxioO36+/noEqX59CcmsaBgYqMsciu1p7QqMWRLPpQCTOfCbXGmHEmZ3Ot/KgudgyV9ElxaakFdrC1InwbEKq/lrc83eHE9cVCEBWHrm5/O3nCsMycfCPZlXF2HT87mU5n7TjmRXR6cI5jgnUjSgyIC72kgDOa8Dx1Eu8cGKDOnNq5RReJut5a57YWgDFGDTmMJ0ii0CrcYzGaFnbhbVhLpHBbUAxMZhQkClV/BXqavwh8gWp+Dj/h/bdxsSGBp4iHdUa7JZ/qlGoYw59/kqXvf5P0++wCcSoDbFGCCytKCyjzxEyuhIusGeeWe4Qe/EdWWRmG7/Y5AuIzOAxvbLJPHwdejKK4U1mBG+kbwuqs6B8uTKhxG/ofg9rRwOBHpzypSajp9mg7fJfkstGQXNFGp5TYLy+gN8ppJR9soPfyQ91GNzVlZBJBh/4v9pLz3EIlsOUtLFbKdq4cHQZjqfGwjV3icBRE12K2tU5SlG0A2KdEPnlCWydTvh0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b07e3b8-e334-46ea-f7a7-08d80818a6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 23:48:44.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRqIMcpFLrgpGPpdre5ffJ+A05VBuMqD8kbchqpkwJbFDygyTXuxkqf5UXD2yHRBW85PhrFL6JmuhFODbw0j+uxuCujywo0Td5QG7QrHsyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, June 3, 2020 8:43 PM
> To: Steve Lee <SteveS.Lee@maximintegrated.com>
> Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com;
> ckeepax@opensource.cirrus.com; geert@linux-m68k.org;
> rf@opensource.wolfsonmicro.com; shumingf@realtek.com;
> srinivas.kandagatla@linaro.org; krzk@kernel.org; dmurphy@ti.com;
> jack.yu@realtek.com; nuno.sa@analog.com; linux-kernel@vger.kernel.org;
> alsa-devel@alsa-project.org; ryan.lee.maxim@gmail.com; Ryan Lee
> <RyanS.Lee@maximintegrated.com>; steves.lee.maxim@gmail.com
> Subject: Re: [PATCH] ASoC: max98390: Fix potential crash during param fw
> loading
>=20
> On Wed, Jun 03, 2020 at 11:37:44AM +0000, Steve Lee wrote:
>=20
> > > This is now reading the size out of the header of the file which is
> > > good but it should also validate that the file is big enough to have
> > > this much data in it, otherwise it's possible to read beyond the end
> > > of the firmware file (eg, if it got truncated somehow).  Previously
> > > the code used the size of the file read from disk so that wasn't an i=
ssue.
>=20
> >  Thanks for quick comment. Can this case cover by below line?
> > +	if (fw->size < MAX98390_DSM_PARAM_MIN_SIZE) {
> > +		dev_err(component->dev,
> > +			"param fw is invalid.\n");
> > +		goto err_alloc;
> > +	}
>=20
> No, that doesn't cover all of it - the case I'm concerned about is the ca=
se where
> we've got enough data for the header but the payload is truncated.  You n=
eed a
> check that param_size + _PAYLOAD_OFFSET is less than fw->size as well.

  Yes, I will update this and good enough.
