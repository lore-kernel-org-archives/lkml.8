Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A546CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79352207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="onCPvNv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgE2I3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:29:13 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:56230
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbgE2I3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:29:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTuM8aDddsFenAunY4QzQfaNKe/c6R6XCHOvWUJ1FRxT2FE8MCaPblNASxMM0WSifszT37yqppoLXaEJEQNi6fFmyumPsx7Rnn34ONvU/Bk1GTKJ9P7r+/IEBMbnS22EqwST5QrG5uzQYccHicK46wIeg0lf+0htQuriPua50PP6kX53+G0VLhgRio220P7jKWB6RRQp5IVbo/7eqqw5HOT0C8baemG+49A4jGDq9EyTZBckgHJXduP/CNHKYFszl7ahQnyz5s8oFQvr1ICGLzyPt9eT2r/HRgXu7zhS3S9Qdd5jv7uicBE8vuenjYmCIpALEQs4AS8NgPKKoC3Tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5f/GHiyAxdGewEwzJoiyJWgBqhudAy9BZ+C1Lp1lEY=;
 b=HGC1cRavAgHENCSnIWF020W8YaVqyHo45B2r7DCKEkadskDKWW4q/6p8YkMQ/FRmFn3mjruMeyJKrlvdQtLJGccRjFXcu3YlzdyregRTUSq4PPRXBkFxBhnm8QPg+JsqYX+R3Uy3+JvLqP3aTxiYN0T31omhvGIlS8Swr2mKpgit9HUsNulpCRgjs0IpGGn03lDGiocmmuPMxuM04XxR56Q5lTn4bA617pCEeGaozRd9Cw1WVTj1CssRxq5dMtnuJPUZr2ZaI4t7cJCX1Lcoh2SQ5u5Po2gJ+/ky9PAzg6X4M+xUsf38lJTaZfS0RFSH1Zbjyl5sboVIRfv6BI/V+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5f/GHiyAxdGewEwzJoiyJWgBqhudAy9BZ+C1Lp1lEY=;
 b=onCPvNv1gcy3gwn9/Fe/fJfGbfuwIlG+s9PNxBUISKsL/pDN1/QLxDjqn7EGPfZIi9tz9hyNCi7ycevbO/ITCehFjM9/IyZ9zowV+uE9/2CHPr0tkBCpgh5H0KXo5ezC5b2FsjBsj0zovM3jIiurTVpd5rjbyUDI9c5MouOYIQg=
Received: from DM6PR02MB4140.namprd02.prod.outlook.com (2603:10b6:5:97::21) by
 DM6PR02MB6985.namprd02.prod.outlook.com (2603:10b6:5:25d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Fri, 29 May 2020 08:29:09 +0000
Received: from DM6PR02MB4140.namprd02.prod.outlook.com
 ([fe80::3de9:d192:ff78:5302]) by DM6PR02MB4140.namprd02.prod.outlook.com
 ([fe80::3de9:d192:ff78:5302%5]) with mapi id 15.20.3021.030; Fri, 29 May 2020
 08:29:09 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/3] misc: xilinx-sdfec: convert get_user_pages() -->
 pin_user_pages()
Thread-Topic: [PATCH 0/3] misc: xilinx-sdfec: convert get_user_pages() -->
 pin_user_pages()
Thread-Index: AQHWM8XbFH9/8DdNtUSGETogEigyZ6i+vMbg
Date:   Fri, 29 May 2020 08:29:09 +0000
Message-ID: <DM6PR02MB41405A1300813F8A511BE449CB8F0@DM6PR02MB4140.namprd02.prod.outlook.com>
References: <20200527012628.1100649-1-jhubbard@nvidia.com>
In-Reply-To: <20200527012628.1100649-1-jhubbard@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb2d2c2c-c441-4bc4-5def-08d803aa5c2e
x-ms-traffictypediagnostic: DM6PR02MB6985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB6985545487B81FCC9796EA6BCB8F0@DM6PR02MB6985.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EqK8yBQPOTrwPqQ3ksaSpWAnD0Av1MFaUQJKEA6uwleyoSLURS/d2g+bscN8BYHC1CASwKPpaQOQpApfaJLWsUOOOlPEAmjDaLlHlIFInwbelURukogibzcHqJJTEX3RrGk66kpAPtmCW4iQ6RNef2KMXkyoI/1NojFdQSKek/CI/WDe/gSryRb8QdSGek0cPcNZXPuouHHEcbUfmzM74ZWjOLYxXt1+1e3YMGFKWvpZmiB+5QLG1J8CKL0bjKbbUrL3mQH4LocpTBE7tfb+bj312QEZV7rS1jyArRpHt+xCyrCViatzNKdPPYLrSLJWZMqQ0gxNvwSOtlqRZZsdmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4140.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(136003)(396003)(366004)(186003)(26005)(76116006)(66946007)(66476007)(66446008)(9686003)(8676002)(8936002)(55016002)(64756008)(478600001)(4326008)(52536014)(66556008)(83380400001)(316002)(54906003)(6506007)(33656002)(53546011)(7696005)(5660300002)(2906002)(71200400001)(86362001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ypbHU9TrfTdCAqNnilmXCSiKSBQFt1P+hIz49i8L+jvyyuS0CRobvzejW9Ge0p6nMd9hJWB/OSOfe3U4IMBIXQnHD9Nie8OCYQ93vSz32GMqzabAT+VJkj8baGA7HL53NKLAygDKARmcOCuxSVBNwoFsld2NxgKqDurncLI/h6+h/s1rNPBWUZbn8W2vi0FfRWwC8EbCIOVo/uslZi7ivRDh7I2unptoqf7dONY3utg0ANu0M1AYhMnma+Icj8733t3aNch//X8NdkaIEnAvoUYp1UUfl/RdFe4WGrd85vtbKiAzfTdoGzyItfoYVGygaj/IG/izoVdokiwIddye7qRqlEfa4FQk7UhhPyZn3dWe6XxQ/RFAfUsGlOlM3is+k5O2rhPVgxOmDLMqlUy3Z34TArsB31+GJsNZ3nY3ArfMpeX/EZLpfiD1XucrJ8QQTA0alZ6AgM8p8/HFeTtkGtFYgBIeAr/dr6nOf+kWQsIRhmOmyc+zvX5wTGMVFnn5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2d2c2c-c441-4bc4-5def-08d803aa5c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 08:29:09.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhLkLsuTdMv9MorOtqiBVJCwMY4qGr3aaluv2D1aQeMy30aqpTa4/0hI5KcOYvTth3nhgYn2zZFevKFEwF20/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thank you for the suggestion, please find my comment below:=20

> -----Original Message-----
> From: John Hubbard <jhubbard@nvidia.com>
> Sent: Wednesday 27 May 2020 02:26
> To: LKML <linux-kernel@vger.kernel.org>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>; John Hubbard <jhubbard@nvidi=
a.com>; Derek Kiernan <dkiernan@xilinx.com>; Dragan
> Cvetic <draganc@xilinx.com>; Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Ha=
rtman <gregkh@linuxfoundation.org>; Michal Simek
> <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH 0/3] misc: xilinx-sdfec: convert get_user_pages() --> pin=
_user_pages()
>=20
> Hi,
>=20
> There are also a couple of tiny cleanup patches, just to fix up a few
> minor issues that I spotted while converting from get_user_pages_fast()
> to pin_user_pages_fast().
>=20
> Note that I have only compile-tested these patches, although that does
> also include cross-compiling for a few other arches. Any run-time
> testing would be greatly appreciated!
>=20
> Cc: Derek Kiernan <derek.kiernan@xilinx.com>
> Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org
>=20
> John Hubbard (3):
>   misc: xilinx-sdfec: improve get_user_pages_fast() error handling
>   misc: xilinx-sdfec: cleanup return value in xsdfec_table_write()
>   misc: xilinx-sdfec: convert get_user_pages() --> pin_user_pages()


Reviewed-by:
	Technically there is no problem in this patch, but as you said this should=
 be tested.
	Currently due to Covid-19 I'm not able to access the HW and I cannot valid=
ate this suggestion.


>=20
>  drivers/misc/xilinx_sdfec.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>=20
>=20
> base-commit: 9cb1fd0efd195590b828b9b865421ad345a4a145
> --
> 2.26.2

