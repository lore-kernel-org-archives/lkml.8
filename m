Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66694C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4CD206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="in/AJ3pS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgGMH2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:28:54 -0400
Received: from mail-vi1eur05on2106.outbound.protection.outlook.com ([40.107.21.106]:61888
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgGMH2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4NP/RiFPUsnSf25rCLv3NdROyYBm0VEwQSuzu0T6jk+186xmV6ndcliqj27H4ecX7qplNNUhBzqpGpYMazzxBCtQstc01DAxJnNTYaSw0jP45RGz6AjSNYpIIcPIrvNyK5IWnjh5h1mPg02BfDQJNXlqa3feu6xHIcPjEcRL7JBfigemHBMz+hkThjtam0YDFLDc2gHpKgbfQfChb2NZHl8gpq8dEIn2SK1sGqilyfNcP/xVu64KgQBTNbruMsiBB+6Gcxu0M6Cpj3Xqf6lnEUe6ZF2xtdn1kuV+rKIL3WAXyiQKYTmuo7ZVAky1kKZmE+gFYPXsaHjTu3jIoyhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpMOSG+cbcNNH2OU1lkYFliWD+38b9QN4wG6+pIpGyw=;
 b=H3Wn/6Q6EVGRK5x5pvsZaeTSp8VMgYuetblgvWWZgl451psfbI/uzCjztZ6/LZtjo/CKUCAfoKhiv9RmeAHfjbDXemy9VS4pX7k8XC34fGMvFU7UdhWTrS73KrIisvy2tyI73/EURAlzp5QLgUCkK74lAK3EY+3VvIc3iETc9PxOWZCf2MUr2FIz3/zavaofS4hOLgFfji3yVNf6Iu8JuB6iZ0krtrvXvc3TDkbcrknBvw9PM8oahlk/TBDUh+g5rCH/JDqYlLt9GHdZEvyht7WiWuBsWo1GY0yKB7kDrN3WkJjL3hqrR0okBfpWAtQ6Xb3TXjGhKVu5OS2846mwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpMOSG+cbcNNH2OU1lkYFliWD+38b9QN4wG6+pIpGyw=;
 b=in/AJ3pSkCt35V+fMOMa00+zofc1zH79O6a3GHoDSBRekihZIZzqLliiTYyG4plJo8Qor0HqPHto1mQWrDpco3w+0KxpQSKEvkroEQTzjZ2HZvrDhQVP/25+aXXfwB09R/3nb+DwkdBTitgdGVJZUBWrUjjfaF0o/9QzJaADRfs=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB6PR0202MB2837.eurprd02.prod.outlook.com (2603:10a6:4:b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 07:28:48 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 07:28:48 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH] habanalabs: prevent possible out-of-bounds array access
Thread-Topic: [PATCH] habanalabs: prevent possible out-of-bounds array access
Thread-Index: AQHWWI1+OjFUlkUcMECaVUGeWg9lqqkFHHpg
Date:   Mon, 13 Jul 2020 07:28:48 +0000
Message-ID: <DB8PR02MB5468341CA181B4B908DFB0DFD2600@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200712204621.29357-1-oded.gabbay@gmail.com>
In-Reply-To: <20200712204621.29357-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78f53615-46d2-42d0-dab3-08d826fe6249
x-ms-traffictypediagnostic: DB6PR0202MB2837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0202MB283771920FF78F598002CD53D2600@DB6PR0202MB2837.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDKEQE8Z8yomlYH5GYcTgJAP5T5ga+LYpEY/VsK0p3jqsAc7nWzfhWrrst1b6EVsMIuRNeICljo9vSdFNND2vtYbPX8R285NpCsNyLN65o7zNar/Jr9cWGidW1hpYbjYeW6H6csUPhZYwgM4jA/kVbhLFsCZgQlydfzsS/ao/vmKGYTPDd66eZDssP7AIw9KQHYiEuxmaA/oCTIxFUGJWxDLsSoXWPB08EUfG3fOK+tTgfpPnsFKOfGDjztdlactPEJUIgHNndVGR4kL5ZqGwHAGFz+wr9hCY1YUl58A38Qndl77zPnVERViEsC93t8qJfFNJGnSQMAWl545lHsDkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(136003)(366004)(396003)(346002)(376002)(33656002)(5660300002)(558084003)(2906002)(55016002)(52536014)(7696005)(66946007)(76116006)(26005)(8676002)(6506007)(9686003)(71200400001)(86362001)(64756008)(66556008)(66476007)(66446008)(6636002)(8936002)(478600001)(110136005)(186003)(83380400001)(53546011)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AYOlxJbo3NRnWIRIN6fucjhdF2QLmuOGnvKZ0BU0wn2+JUuWmLOcO5nzY+rCCDsrAk7jgnJ6re5WKPBc51qYzkxTrtdvsTosoWcfaygWxHxXNbtLWyXt9d0Kh85ZKobywGQp1qKzxg1tzVp+bqYn0W6ehKCBbiprsUfvdoN/3enFXK35cwv3UULBCqcpO/OnjqDmaiQrBLuQ9Bd8RKaIyefQkOwKufci1LhtI5u64NbAsCyeU8X4zHoBLyIeESM/yCblqPHnxKAJfa6X6saKRidB1XrRkGceyhdxBmnaJFucTeELa45OARGzeAHCDredqUhDjbnEvEE3d0EofpwYnEszQVspczlgqmD0yCy1zfeFe92p8vvZk6kFzn8ZMPgjG8nIVx/C8bdajCywAL+wI5oTG3xJpaaHN1uofY7c3yNRkeH2PkZsWLGXCOx1M+4FivzJtwWuF+4+kj+Nl0Ezpskkugypmo9WSCHblVRUq1pRKNcKEljuTNXE6ZGp45LJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f53615-46d2-42d0-dab3-08d826fe6249
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 07:28:48.4261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxixDUif6u7YXNgMeWkXiZoiv18Jea2jlLPakWGXiacDehk3j1qqqSRIZPnVzq8Q/tTZDMPIv7UkBcEivy6PMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 23:46 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Queue index is received from the user. Therefore, we must validate it bef=
ore
> using it to access the queue props array.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
