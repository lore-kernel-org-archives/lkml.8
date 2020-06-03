Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2911320772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="bCB/P1BV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgFCLhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:37:50 -0400
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:3975
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbgFCLht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM6LScYA03zgCrDFDjDg7yQeIDUMpl0yGWIeKHFS2uyUqZ221xo90rwb0196qSpk5j0gwfPY3rHGoRy4jhbHGYHRMgzySG7RxywQn03uqOEHn+lSA+b89khiU729PcgNMHK8s3egkoTuyZr6GBXhnPX3tFpKTq2OfdtLAa10kcfam5zaH60cg7PwKdqWNhftVOiEQbtruHwHnA9uoBg+Vv5nn97ggWTl5PcfSnqbaHv/hwmPX/+9L/ccwHVKL+FX/pDwVL6zgYkv2BphR1oABaB18bkRwD8MOsWQLlNpJRoGd8mqjc3qxf14TbBtPneeFtAfshnnI0WIGVgi7j5ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5ix0Af7wIF4fJ31qvEaMntMH1NmpvD+udCa978Lx7M=;
 b=JDQvxVRv+EvVCNHI2+XPuieIOTojkSXW3GFFwxk2LvqA6p/qSJZsuAt+wdZ7kZ/RGneDcQTdE4finYw4XFiKVuNsIzilB2ENMoxGQVUCfR/lgDsc1JnMtoqf6n9pTNaHqK/aDrnAYos2R57B4uWBFAMGHWjqcUMxxvJS8u0DDRy1rjTALbVpXmQpTnkwoCfXBxetSbJ2w/8/6bvD8PtdeVV2NpNNe/qmT8nH45DswCBJDVkWI3sfcD38naWnPKLzA1c+O7wEWQoyxLcmhvCV92SGB3GnhMz2D7KphKFHkWT8L4wdMxUlbfe2EC+WlQuqzssXBteY3ghFKURg6lswPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5ix0Af7wIF4fJ31qvEaMntMH1NmpvD+udCa978Lx7M=;
 b=bCB/P1BV2iGAWaGs7u9uleMFRHpWDkXVxKB4tmFApbyLjkrtV0xSRx0/40NOC7bSxzp838s6qTEdorRkf6bk+4yZVOqVC8iYZP60Lj5AklgQ6jUr8+Bos2q3RKjLZiLq+JQ385u0/vSI2S6nDZEvI55aWCWnlzv9/dXtDX0bHLg=
Received: from MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12)
 by MWHPR11MB1485.namprd11.prod.outlook.com (2603:10b6:301:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 11:37:45 +0000
Received: from MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363]) by MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 11:37:45 +0000
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
Thread-Index: AQHWOZjok5hm+3ydWEypvnQMZosX1ajGwe2AgAABq6A=
Date:   Wed, 3 Jun 2020 11:37:44 +0000
Message-ID: <MWHPR11MB2047B58F4B5E395CB76CCB2392880@MWHPR11MB2047.namprd11.prod.outlook.com>
References: <20200603111819.5824-1-steves.lee@maximintegrated.com>
 <20200603113145.GC5327@sirena.org.uk>
In-Reply-To: <20200603113145.GC5327@sirena.org.uk>
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
x-ms-office365-filtering-correlation-id: 2d87ae0c-7d11-47f9-4f9f-08d807b288b3
x-ms-traffictypediagnostic: MWHPR11MB1485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1485859259DCE08049E35E5892880@MWHPR11MB1485.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysbT71dBRbPOejGim9u/87pBS3dqlvGu7oseAImp1Go2LyVfLJBha1+1Cphtwy2ubHldBIcHvq2AKVLERvQnK0K7HcK07fPkpycQnosuQTTvePCV9/c4OgZhz4dpdE1QuEMlaLr7LGWuN54uqDAMY+ocqB3lLfYWNrLm1MvU7JxsMcPKvXRD/ZpOih+qLWFybLsJtgaZVJzWRWyaMiFJTmJB4VbsTdicB9BV7jHkHXjDFyH7EBmgvIbwAQFpZN3K7QL8JslG1+6LfyXU4EI/gAneDZw009748K8yjrxJy6kY7PptVX8hsbzJU+X447QU4H50PO4c30sjD12cpU0TkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB2047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(8936002)(6916009)(4326008)(7416002)(8676002)(33656002)(316002)(54906003)(71200400001)(86362001)(52536014)(5660300002)(76116006)(64756008)(26005)(9686003)(186003)(2906002)(66946007)(66476007)(478600001)(55016002)(66446008)(6506007)(53546011)(7696005)(83380400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FXAaoZA7k4D2M9InBCzjLx3zotHGWLe4oMcwRhD6VpNqQAmfY3rvYiNMZ7e4rJ0qiBkMYwmz7Xp1kuyqiCvUPQg4InTDghdpZIYZsv/Ujd35+q3FYP8XGG1K1F8Z6WkC3OO9xNrqHLtCbZgOYxtURrEelj+mnC4dxXINQc+9T3wMo396e3D+NIkTGSkAm9GROTJ+ZbJkqX7ehnc6U1XWPcGdK1XEq4sCT9rrjgMklvm4FfiQMF18/VwA6I8aUlA8+ltgmeQ7KpBfoOm5YWtRmTflizPGihMN54gJXO4EU8uHkjuqC9tjSGddJtjx5i6sSnEhfO0bNEKX6DNHypnaAkdHS7FNm809oSkilqZuewHY3BlnuDRWwov4f+OZPxl8QpMnSSrsFhVnW+dAPoxDc0/UFgJOggqyxDA004H481v7GO1ANwOlvk/foZ0D1ae9ghwh2APwtJfCJGkWf8D+gOoshj0heBZxR60SdA2Yc+LZLQfayDcHvuP/ojGEmOpF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d87ae0c-7d11-47f9-4f9f-08d807b288b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 11:37:45.0071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDh7p4GiZolNM/3QkQr3VeFLcFDKht3BHZx/ReypQVMPjeyDg4tmhPg75atrT64UjKmdLC7fKSCFvmhuTr2IEYk4HJvTgrPFz9Hq5wfeQ4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, June 3, 2020 8:32 PM
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
> On Wed, Jun 03, 2020 at 08:18:19PM +0900, Steve Lee wrote:
>=20
> > +	param_start_addr =3D (dsm_param[0] & 0xff) | (dsm_param[1] & 0xff) <<
> 8;
> > +	param_size =3D (dsm_param[2] & 0xff) | (dsm_param[3] & 0xff) << 8;
> > +	if (param_size > MAX98390_DSM_PARAM_MAX_SIZE ||
> > +		param_start_addr < DSM_STBASS_HPF_B0_BYTE0) {
> > +		dev_err(component->dev,
> > +			"param fw is invalid.\n");
> > +		goto err_alloc;
> > +	}
>=20
> This is now reading the size out of the header of the file which is good =
but it
> should also validate that the file is big enough to have this much data i=
n it,
> otherwise it's possible to read beyond the end of the firmware file (eg, =
if it got
> truncated somehow).  Previously the code used the size of the file read f=
rom disk
> so that wasn't an issue.

 Thanks for quick comment. Can this case cover by below line?
+	if (fw->size < MAX98390_DSM_PARAM_MIN_SIZE) {
+		dev_err(component->dev,
+			"param fw is invalid.\n");
+		goto err_alloc;
+	}
=20
