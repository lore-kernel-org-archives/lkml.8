Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7917AC38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A17C20753
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="ptGPI75R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDSGPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 02:15:00 -0400
Received: from mail-eopbgr80132.outbound.protection.outlook.com ([40.107.8.132]:59268
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbgDSGO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 02:14:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cacWO0XjJDQ0bf02G7D2W7v8BSIV0DLCl1IdtmLYWDLydCudbOqPRnY5iAaOSXwq7Ft+SlFMx4GxCoUn4LaI8hgpEW480ilG8JcxDhHxH5qhIzo03rqg2U37iTd4tcKwUAc+lay27cN4JahF7rqZQENpEAt41zjZrxONjlB80nbtIN2jdoeVX2dhK/yEKUSpuUhXeTM8lWqHaKtYvnttyLq/8pZFORtltWFffwfxHjWoeQvQJBHL8qdR6pH6KYONjIS+dNG4mQ4xnUxSkABA+JRHxT/xRa2ejIw0UZHpcR1lX+Ac4mZxFtIGEd4uI1NuWsNK962Q9+q65SQRMmWrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsKYtaQ7UClvWDGV6W6Jesf0eJSkxrYxVlnfqKiBo0E=;
 b=em4ZzfCHulz21gOiJ1WSEKaLyZUpLyzHB7QPlx7KcH/hrDv+rf3c1QZvuuNR/FF0e3cjqKAwDJsTr6IMOt4TTAMNIIArVJFgTBLsKFMm1qsr7ie2j217TTp6PiRVZOHE/c1ohWoHTSeBiCyWmiiGu0jZVGfOUfL9Qu4/adDgX5jxu5hy6I1iotKO0Wd2WlIX/HmwtmzOmYqfZWtrB9EY1A1IFSB39FFnozo7VPHQf2zRZL8G86DLwzexuHtk4X8GLhh4d1Af/5KPlC6QWAlpgiv6xJSjMVrl3m85UpuMl0uMWVMDsfYSYSV/Hl665VeDpOZwxQTkR+X9g//wg2VqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsKYtaQ7UClvWDGV6W6Jesf0eJSkxrYxVlnfqKiBo0E=;
 b=ptGPI75RXco53mh3KkFXcus7cZDI3EU/j1ibwAeSLd4pjZ45ZzkOfAHF0ZV0njvNuBIbVp4VUqwSXrPGSgNpEVBATYvY4Erl6SEVge5kmj8grmcJA1ZSNE5C4BHQDoyhO5M58Surkhxik+75A1ZbWjajxJuZtaUjl/lf2M3enyU=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5897.eurprd02.prod.outlook.com (2603:10a6:10:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Sun, 19 Apr
 2020 06:14:53 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713%6]) with mapi id 15.20.2921.027; Sun, 19 Apr 2020
 06:14:53 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 5/5] habanalabs: leave space for 2xMSG_PROT in CB
Thread-Topic: [PATCH 5/5] habanalabs: leave space for 2xMSG_PROT in CB
Thread-Index: AQHWFVrW6cnpFnKpyE6lrEirBMddbqh/+G6Q
Date:   Sun, 19 Apr 2020 06:14:53 +0000
Message-ID: <DB8PR02MB546875CACCFB013422C021D7D2D70@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200418082440.21277-1-oded.gabbay@gmail.com>
 <20200418082440.21277-5-oded.gabbay@gmail.com>
In-Reply-To: <20200418082440.21277-5-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [217.132.6.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa4ea4f4-3e1d-4025-dc2b-08d7e428f9e0
x-ms-traffictypediagnostic: DB8PR02MB5897:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB5897CD266A5FD62AD36757C2D2D70@DB8PR02MB5897.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0378F1E47A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39840400004)(6636002)(76116006)(5660300002)(86362001)(55016002)(4326008)(9686003)(478600001)(71200400001)(2906002)(316002)(6506007)(8936002)(53546011)(26005)(33656002)(8676002)(81156014)(186003)(110136005)(66946007)(52536014)(7696005)(64756008)(66556008)(66476007)(4744005)(66446008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfNJWpbo7ooEsH6BBHUe9UjcrQ+JvHHT6yT258+PyBY2o6XiKRpPyAwh+ZTAHVpjKXdq/H/Re+IPEhtfcl3OTVlBJXGEBVy/MXNDTlHROEajgXHnJrexr15P6TrC9No8cS54embyW+f23Fs8qQQ4jP7iMsSmaZQ6KeQKgV9GJAZgHUf61GCq585Bhoa97onDk4+CoWSwpyP+mO8zrnYANkLFRFooz6PtJ6B3g81VVnC6ilE6POe/+HD+G4+7WIpAHNvYXv91Dx8RV0avHpwgAeLFeSqe+lUZV87cT+xmp6ZR6DZq7tTZoMPAK/PnyU0WIlED+HPU4OyCz+j2bY0n/oRxyaeoJRiqdulHr+Lsjylna4/aOTIrGT2yvA+98z2/eTtvYA6O6Ujv00+/h4z+pLXS7zIbMGPnOwwcd9D3wvf5IdRyZeLGSkVNA8WjGIh/
x-ms-exchange-antispam-messagedata: myHoS5p+kks4iSYReBVwT0eFZMO89hfS+H30huRPBOw7HWfShNxnH7DlyNf/3Yab+nTwadgScpmbDynU+C9Rw7FY25hfUgWQBVQyHIeE5KqB5NLBHaBo7XzkCy/+DaMFjtOfA6f5qiDP9nhK9PLS3g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4ea4f4-3e1d-4025-dc2b-08d7e428f9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2020 06:14:53.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlwTd+4/ck0nVmgoXFnStUES3opp7BZGSQcp1x8OtZvbxwRm0gvHSr80Bcu91oWaz4/lwZMTrtcazxt6WcGRTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 11:25 AM, Oded Gabbay <oded.gabbay@gmail.com> wrote=
:
> The user must leave space for 2xMSG_PROT in the external CB, so adjust th=
e
> define of max size accordingly. The driver, however, can still create a C=
B
> with the maximum size of 2MB. Therefore, we need to add a check
> specifically for the user requested size.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
