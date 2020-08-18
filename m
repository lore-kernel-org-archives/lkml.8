Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73877C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6D220658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="lIIEPHgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHRRRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:17:06 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:51363
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727913AbgHRRQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldHZt+JDmZ8uGoIaWhVYA4DUct3IUprWsmNHbwc8jrQdw2kd8TRr9PwY8GjKgAigxqBtBu3JwyGXzWcl98Q25Hh+6uLwM5knnABkgwddoYbqpXOtlr6TTimeIrl6wrSmx5CkWICYgJkGMj6csfDfkQqKxuVYnXefYLgBOMAMWKXSmDAAukppiWrLLVfS5dj9EVDiuOEBCa9JiD2NNEK74vttfGR+zSXk+uyaqjUhAZmuhqjuM7LsvR1H6ByGEg2KPOTwHbWKkan7Dz4l/CFjTeMttsD8dgNhb27cigtjg06tENWRRrVtEfYxYinEXEfRQcb4MHfueXCNRKNJ3+elmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUYNiDEnewyb/Bw4/0rkWxmcdxg0ChaWFdrVErAso4o=;
 b=EJdHeS4SbSvLCrD1a8CZn1/oENaybZrvVqq2T11j0T3kmhbsr6Jat0byuWvOwkbRMNBikzlJ0up08tmO3aAnFETlLVy4eWUmYKRZfqxfabmMN5vLcL+kHd8tZXTQEoF/USGeL40f69ehTkEntj1S1JONeOAippd//UOXH18pQDod39G2MEviQ05RF4CsjlhH/bVN4fTa5Gu2DkULrV/Qtw5ntXosdgFSVPEO23/n9dVDBTIGXSV42AAP/BmnqXCCvvHK4mtuzhAtbhVZmxPQ50gsGnIU2t6Q200wLtEnh7HZ8nlP3j29qq5twYojHz75cGbBmSFSG7siXIxnF32xVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUYNiDEnewyb/Bw4/0rkWxmcdxg0ChaWFdrVErAso4o=;
 b=lIIEPHgFJJ/hjDBHwXyhr2LyA5hhbwoaYOJ+A3gttXvzEcrvGH+HImeRO7HoWQYzLb10oBWBO0IA846SzczD0NogWbo9l3sSywU9LphIILbWFqkLj++3cIW3DdeSPmoOJz5GK+8p00V2yIsHu1KH+YJnaNeEtNX2tR1bBqmIAMM=
Received: from DB8PR10MB3642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13a::19)
 by DB8PR10MB3739.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 18 Aug
 2020 17:16:49 +0000
Received: from DB8PR10MB3642.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::61f3:d87e:a882:d80a]) by DB8PR10MB3642.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::61f3:d87e:a882:d80a%6]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 17:16:49 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     "Zhi, Yong" <yong.zhi@intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 0/3] ASoC: da7219: Reorganise device/codec level
 probe/remove
Thread-Topic: [PATCH 0/3] ASoC: da7219: Reorganise device/codec level
 probe/remove
Thread-Index: AQHWcAB+3ABTLeJ5E0KRr+mgQ5L1xqk+HByAgAAKNhA=
Date:   Tue, 18 Aug 2020 17:16:49 +0000
Message-ID: <DB8PR10MB3642D592D97B7AE6AA3186CF805C0@DB8PR10MB3642.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1597164865.git.Adam.Thomson.Opensource@diasemi.com>
 <MW3PR11MB4665D9AD35EF41A7F24F5208855C0@MW3PR11MB4665.namprd11.prod.outlook.com>
In-Reply-To: <MW3PR11MB4665D9AD35EF41A7F24F5208855C0@MW3PR11MB4665.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aaa5211-19a1-43e6-b045-08d8439a7e3b
x-ms-traffictypediagnostic: DB8PR10MB3739:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3739EE8B83C9520625CF11B7A75C0@DB8PR10MB3739.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kIUKck1O+DUMYGBPxFbhRJxrQewTNY+HQly4bp0N4EXzbdA1RCw3u1QCEKMvvQ62dQ4A2mAWzypYLQsyJuFBV5jGRauKz4ces5QFrOyMjI37AWwCI9fk9L2m9mfhEklnpsxPKgp+rll17wabXt+rs6uvPfeOIG6SpoAEbp807SYR1BLOK81Y00Ayxdf9gmOaTkz/cgES9JqG6Jk5WSFL4x2xMgjuWCfqbOFNpY6fSrOCCh+Xv9dUV4kbLUPswQtSlbhfmU6m4H2DfLitzAO0AtNE72Tju1CzKl5fKvEExKfB+2iG132OC5iVsmj6hUUdkrMOmYPBPZ/+6sRbe7pOnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3642.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39850400004)(186003)(53546011)(52536014)(55016002)(9686003)(7696005)(107886003)(478600001)(316002)(76116006)(66946007)(86362001)(64756008)(66556008)(66446008)(66476007)(8936002)(54906003)(55236004)(71200400001)(2906002)(6506007)(110136005)(26005)(4744005)(83380400001)(5660300002)(8676002)(4326008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UBEsBhkSOBRA8h70xqbj9hUamKmrkSg0vPQG1XCurqVNjDjQ1TrcDEho4ZBX3f/TTDhQHtOzsYxwXz/64f8uHsD2i5UVxe+vdivzKlQ+yp6Gz/TEMX2kl9jUYWimpD9zahn66w5dWHFT4j+EoNDwC++M7gE3jEuTBzhryEKQrpkooPzlztWznTjLIXxXV0x3mttZns6M5WgcKPzz3zd7rdB9N0l7UGYzfCgYkcEUNnoo5fdPiaL/wsewBYTTxgANprOFQjmxB7M9jW2WooX5EoWXJd3uiHz34iFt6r9So63IXarv7e8g5aupGv9ziawBZJF95vfbdZRqqYkTFRIjX/xjh8pBG5USaO8Y+GDznt/8MdXcvMzePIu4toNsD2qW1qaas2bOr2XGaI+yyWSfc7hAUuQqPFZZFVxcuKisaNsd39+rp217UgW4DNhVC5ESWhIcxALBQvd0NhMd9bwi1Qq5zeLK93wwi8Z+ylRwROL1XbZ8IP68H7Dzfpb6KOWfn33xkxj2jA6QLcCpENEmj63x0q8/Bchpc7mbdxSKQ+sLWCASeelpSurAYiQthjem1LxqHq4kgftGuaHu1LoEtjMX9ri+2cDv/7mIYqisKXkNcmCRuzbhJBc4cIvWzUrpBdyMMcEXWf9BVVnLGkZxOA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3642.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaa5211-19a1-43e6-b045-08d8439a7e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 17:16:49.4044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wc1hozbt2IyvUdDtHnBLK2d0gGpP0ftEZ5j6KcfBEviGl49zSsAXo9pPSzH7SkMlbippeDi5r9K4VneU+I9fiLuxeaerqUdppR228i/VILg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 August 2020 17:39, Zhi, Yong wrote:

> > This patch set reorganises and fixes device and codec level probe/remov=
e
> > handling within the driver, to allow clean probe and remove at the code=
c level.
> >
> > This set relates to an issue raised by Yong Zhi where a codec level re-=
probe
> > would fail due to clks still being registered from the previous instant=
iation.
> > In addition some improvements around regulator handling and soft reset =
have
> > also been included.
> >
>=20
> Just to let you know that I tested this series on the JSL platform, the o=
riginal issue
> was resolved, also sanity checked basic use case like plug/unplug and
> suspend/resume, no regression found.
>=20
> thanks,
> yong

That's great. Many thanks for verifying your side.
