Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90153C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694F72076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="wyFY2lG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgFOMd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:33:27 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:59461
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729642AbgFOMd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:33:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fq+6LR+nmb3A6/W1lDgVjRhawSQMcUnN1tUYuYiRvZcCenKd7UKqCbS88lhDPS+Jc4aO/llkm4GUiGYF9uws1zG+dQLNRLHbP3hgztHflY+bcBAPFICuYmvCGXuyXlu20sSsQ/O/Mmo10+d2ec9/DvVGDTVSLbKOlfu6p/4Fyk3Vq7z+M31PNDE8QU97XCiQ49t7h7UpcNC/ilZs73XKaQBDgjF4y3oJKphQsHQemgxaCl2DWOUMcnQ03v3q9CIDBNX2bd1JgqYOPED4lCxhIgw612ia0CbVWkjRc+aUiEJto8z2PZ66tDaeNWQJ1sjMhsPfCjDdsfBnCrGimAegfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl2o6Au9c7d9mdMKv87uvwJw1Gn5H4DRQObBRiRrTpA=;
 b=RQq8XWaO/ZOrW7wbwa9TXyaMHbAtW59MXX2nbz7SmyMmylbNHQtnZO2jUasKUMCOh9iCG5EblSzlGJ+VR9MTGvc27v7IBnhilivZvSCxrTe+awNwQLQzQEVEZPe2IQK+eXWoh5NolWWC7MUF4yfa63aN1TZWa99yLOogEYCPlLuhQbztH1gb5uWlAWZQdOmlVA22R/bh/PLSZtZYQh33YL69TRZo5+PXEKdp6SmI/LJ1XRm3mDVvbjbLy4eLfM7qrTbTIqtyRsh2c07sgN9Ustu2HQuOJx42bLd8kTSVMoyb/gHzcVrUBx11J1ppNJ/YImeIG5rHRyDRs86TA19fVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl2o6Au9c7d9mdMKv87uvwJw1Gn5H4DRQObBRiRrTpA=;
 b=wyFY2lG6KeDWwsdmZ9sHI/BjmuvKpaaHkD0fj2QNdZ2p6H7mJM29XZzwAHrICLEl3UN8vDDWVgEirGydYc4VG5mr2ajSGSiigaEYqtv4TflzEhjVT4b3V8QTCtbnecR1/Uz7ZRn3F+pGCh/mAw+UldG+qk/PAM2zW7B1+3Y2W1c=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52::13)
 by AM6PR10MB2967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 12:33:23 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d54:9ddd:f235:d379]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d54:9ddd:f235:d379%5]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 12:33:23 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v3 0/2] Resolve revision handling and add support for DA
 silicon
Thread-Topic: [PATCH v3 0/2] Resolve revision handling and add support for DA
 silicon
Thread-Index: AQHWFKbAxolLPFA1QUK2S7dHIqCGEKjZ+NMw
Date:   Mon, 15 Jun 2020 12:33:23 +0000
Message-ID: <AM6PR10MB22634185776E32DDE236CB0C809C0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: diasemi.com; dkim=none (message not signed)
 header.d=none;diasemi.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [146.199.34.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8951b1bf-1d71-4d19-1897-08d811284b8e
x-ms-traffictypediagnostic: AM6PR10MB2967:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2967CAB248C415AEEAA8785FA79C0@AM6PR10MB2967.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ifHfN0nuDkqJnsUypGuVEXutmFd6ah2karXA1BqeTYQP5uI/mJobem/u2dm1Y0gWIJkCabngpwRqLUnKyeobl+D+blq9fOj/XUZlnkZZTbkKPeVFJlCmF9pjipDDVvMuRROR9FQ04RNxuqWJQQKY6NwtSFpuwYYRmRxnw7nD+ZWRWot7ldPgnf7l0EYf1hv1izmrRtWoOZiw+yaA+OmXvM/UjQ+tfQ8Be0ipAd6iFx1uCRJ15Bo9IPZ649/GK79Gm7kcr+e/K4VYy0KAbxcWBxD8RsB6a7i+5lNCxeXE5PX8P5cZq6fd0rquutTjffDl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(39850400004)(136003)(26005)(33656002)(83380400001)(4326008)(8676002)(316002)(2906002)(9686003)(110136005)(478600001)(7696005)(55016002)(54906003)(8936002)(76116006)(5660300002)(86362001)(52536014)(66446008)(71200400001)(64756008)(6506007)(66556008)(53546011)(4744005)(107886003)(66476007)(66946007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: N0h5fGtCymwZaAGd4F+erJ2aedLSL0eoMGx9IeLShevjD/HmgytpeOHejkrHotyhM9XbnxW4aVHe5H0docUgW/DT+ooLqSWElnXOW6R9hWLLEUJV4xKLFCUKQm3oBui7GNFZgQanH2Ba/W+m2yGd/K+GlvHR5fSjn/AgxpvwjVdSRfqccW+3VJ6uimW4g8Zwc/rtfkyzZbFej/RKgNwo3RAi4zAVtaeOOuOQsKI0jr0RzCvlaDjzskhW41t6NuIQoFBATB1wVEcEUoxQ8ad1K/09o+4XfskNeQGDWNfUaf9EfXuK/9KBmeo+BS8cc/TedDeG8dLNliaf77R22vfBcXxF0Z71FtW5UYxg4EBHqN5vFQMtdQunZDTMMkTGP/PFpe46TJIeDQQlcK9/AKjnfYy1JGp8m1iFMyDsL6PR2FJybeCHUEdTM8UVdQxG0IHMqZnoZcviyCg4a6Hf+D2tYW4UHuMhR1P4Baah4B/Hb9G2jLCddkDWmme8JmkB/Q5M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8951b1bf-1d71-4d19-1897-08d811284b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 12:33:23.6453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSHoBAehURV9wv2BNQazt/rgCD7hVAxfjyCegHhhEZXT+o+ZieifnHd+BpP8qgcQ3WHrj9jN5wmMDu40zc6OaaMPc/i7GE8YtFozzmagH3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 April 2020 11:56, Adam Thomson wrote:

> This patch set fixes the currently broken revision handling in the driver=
's
> i2c_probe() function and then adds DA support to existing permitted revis=
ions.

Do I need to resend this patch, or will you still pick up the original mail
submission from April, Lee?

>=20
> v3:
>  - Replaced magic numbers around I2C paged access code with enums and
> defines
>  - Small style tidy ups as requested by Lee Jones
>=20
> v2:
>  - Use raw I2C read access instead of a temporary regmap to interrogate c=
hip and
>    variant id registers
>=20
> Adam Thomson (2):
>   mfd: da9063: Fix revision handling to correctly select reg tables
>   mfd: da9063: Add support for latest DA silicon revision
>=20
>  drivers/mfd/da9063-core.c            |  31 ----
>  drivers/mfd/da9063-i2c.c             | 271 +++++++++++++++++++++++++++++=
++---
> -
>  include/linux/mfd/da9063/core.h      |   1 +
>  include/linux/mfd/da9063/registers.h |  15 +-
>  4 files changed, 257 insertions(+), 61 deletions(-)
>=20
> --
> 1.9.1

