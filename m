Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F01C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337EB20735
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="LPgTxnEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgHPPYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:24:51 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:13792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728310AbgHPPYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5HP4bl/rKghR5+3CTyTdo8HhEIwrpiXg4wYoURtDcJLZ9v9OW+n4CplFNnEnXZ51E5ojevXEoZ4LrsNp9ICMz3VVI3BoOa05UPdFR3ytl3hesRlLOTFLLMOeCZAY1yyUlidShuQoAFDp58legetCORQYhYfw8pR8BHF+7z8TIoWG49bkfkpEI7po5TDP0OPVoR0e8bPSPIMRqAbcMGWYFj5jw9AoAfCPkcYDcPSdJRCjhfMo64f7Q0hBpbyW2ogyU5oQo4XTnc7Fn9Hmc6qHgEDCszqbVxbMqIpyBIyjonJBd7TLIYO4NjL3AbbglJwvQxD7L0KdcnnyxekdkDsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDyUzPtqbBlcBVNVNhOkVEOZRvKswLn0sUq2nMP1qj4=;
 b=EqaWkQ5ialjvDwIcb9F/KvN8Ofs+RBCPj+gmMMOJI4Wq0RSS7AS6E5k5Er5F7Sbtyun9wJShB9HYFpNjmYvQzNgY/i/9XD4ksjkBFOLLbA0+De4Y07X3Z6IGrB3VEgdvFnMESeWhwnmSnq7Swzp+65eDKJAOTWUaQDbr+a1gFF0iQoxTOFZNQg6HuH74BQepFARej64uS7nvFqI1Op0Yq3lq4xt+gDSx4rIpliYZ5mvUYJmweQslvtQeJkFWR8fBV6NMp8Se9rUyHonIL5XPYK8ofLv2rSolTfJqFWSQXeB29jTWCCT3sd0B91qzuviIDA5++A6jDys5LDePbnd8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDyUzPtqbBlcBVNVNhOkVEOZRvKswLn0sUq2nMP1qj4=;
 b=LPgTxnEr4xrUIr23Eh992i2aUw9+rsMTZ/h4fFP24IJfD2m5bRTViHUMTk6dT9zMR6EKfzmRJa64G4YyBspxUiekCkpogkMcLxgVd9Y44CAxla6+JFjAUM3U48mjY0qok7TcDkYeWIUh7O/F0vM5T7iYDeVsP8Hy/mYYTVWliRk=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3547.eurprd02.prod.outlook.com (2603:10a6:8:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Sun, 16 Aug
 2020 15:24:23 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 15:24:23 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 4/9] habanalabs: use standard BIT() and GENMASK()
Thread-Topic: [PATCH 4/9] habanalabs: use standard BIT() and GENMASK()
Thread-Index: AQHWcy3e3Uearxb4B063VswUd07Gyak6t8TA
Date:   Sun, 16 Aug 2020 15:24:23 +0000
Message-ID: <DB8PR02MB546805F0CEB593E581CB74D7D25E0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
 <20200815175938.16619-4-oded.gabbay@gmail.com>
In-Reply-To: <20200815175938.16619-4-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [46.116.96.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d8427e5-3269-4820-e396-08d841f87463
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3547CE16F0CB155AE1C23F77D25E0@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Zss13ViHZBZ3qpgvnfshDbd9j3zIvpPMWUS23+TAc3eyMZR28P6+UN7fZkBizEval8MFkj9NE88Xu0bl/kXSNioCXGq319ymVcGP0BU5WPK1yy8cI7CQ0Uiw3bNxfM34sY5i6glHuIpMnibjl8aDGy8CDjV7r0S9Uvuh5gndJRhBsgzwo9mUD48KwkhepICnPey/TB190RgvQ/FzwkfabJziZd+6m43bY2fLB7pjTdatAPSzquGw2I7Kf3sxwBJAC3cnG/rKIaDqx+BUvlT9/I4mE4dHFdt2I6P2cyAny6qWXEYPMtedb0LWsCZdMiJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(7696005)(86362001)(110136005)(52536014)(76116006)(55016002)(6636002)(8676002)(316002)(9686003)(5660300002)(53546011)(6506007)(8936002)(66556008)(558084003)(33656002)(2906002)(66476007)(66446008)(26005)(64756008)(478600001)(66946007)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FYMdbJGOQ63ym/m5ZpHrJtuISfUee82v0t5v3iYeIWQc44HTbqYjsOZDaCGaVHe5V/kazDLNDje4o79D4Uq5zIcBCYqcnpbxWauhsAtdJuV004w874jXqMdZH4LWRoMAAyL+M7osg7WSffh4pm0fUzBsPt2r+23TN7I4B8EM6fgluDF2UPV26zykVTygOo293VpgpjaX2EHF9KkGxot7vjShoCssuNEe5GR639Pub0XUHdtbsFZaMyuFztLsoo/+KSi2h3nJrxic9swmSZsZmW7iRjzugrLg8Iu5pCgScZe1qpcrnJivXXDakosPGQ5LrscHrnD0J4xmIjzsCDOK3rs2RjhpaYu8qvbllhQ/VPf82v3++UqMtft0F+9dzVRx6qTRUKoxYhl/ZXCMewYJ4Acff2YYfxuwGOYwgks9OOSeWUQhuU1fE6wV9EUpbr+X5nGcBBZYhiZLMoDOApkmVNQ0EY5ffmCrGph1tBL/9Raw/k2Bll7P5eUXzC1pAK79UBmZ4mZbQN2pHvzEjdSZV774Jq5/tOXktccdyiv2k89zDim/ZKVt3JV3ejbJKJZAo0TlA5N/Gk6L9cLziB1m1zMtdMYBMEMKCUx+4zuYpH+ln5f5dm3dhpco8IJfqBK3qz0jNTs2ylCymxbEeZ8ZZA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8427e5-3269-4820-e396-08d841f87463
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2020 15:24:23.1794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60DGf7LJBlygpxpUGWtc1yRRFIFjuvlyzKbZAxx37+vZLLQaieDLOxbThH25QRvspGEZXho0CJfdlhsacgLmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 21:00 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Use the standard macros to define bitmasks.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
