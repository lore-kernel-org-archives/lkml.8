Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD06C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A236C22522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="BBgb5dj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgAOMeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:34:20 -0500
Received: from mail-eopbgr40123.outbound.protection.outlook.com ([40.107.4.123]:20855
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgAOMeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:34:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfdIlJBflney3DA29PyG57UaWjXZwVmqUBU6D5PnnZGoztzlsAlvf0TJERs9FHwLqId4owEXsi3DEcE2K8jPFNDua0WSWepdntnqLmF2NfCbFzwwzxfXTaD/35Dz+CwPnMmcFkIEU1mcWVfmuLldK8b7NMKCiw5Ws+OtecT6ReO4tjknDgqgZGReU1PjDNhK4lwZycBFALYQW0pdIHAyEKHrYOm4D0doibNOVy245CmfQpHjDRSox9B74pbwdrPikvE3fonwSk4EZ7thmIV154BfewAHtedZdaqLLBBQeLXlU84IHaXOkYBUVGOP6KVKi1E2m+a7D6+ralGoLS5ldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0++l4pSV8qZSWWEAowIEmfkLXv+gRwGYOHzBbZd84Jg=;
 b=N92ibGyQGvA0+LYCrDsxtGhkt4NJRYQOAeiJIZGMg3RFKqo6l51QQaIvNC8OmL3ytsG6+k+zOigzGcScGzUFOQP7iaPiMtxnUQMeIaWuwBS67CaXrRC+EJV4aB/WX33qpBns01mnEBENSTj4F82JfP9ShpUWbcIwdahz7Fy66Xpa8eyOMl6RZ4cQ9rEuk40xwZcg+guMgS2zs+Ub2T1PHJarMvYQeeb6iATmV6F9SMzyRnPx0InbgwoxHJhsuvVtwFYtl4k3BvPsZrC5FXrc7fc1TtuO5Ip8hOx16jQxo9HJLpMr6R/YuXns+r0gDKmxPk+X8YWJQRvIAV4gn4VXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0++l4pSV8qZSWWEAowIEmfkLXv+gRwGYOHzBbZd84Jg=;
 b=BBgb5dj3EX6ycRbGjwdEVJHdKcHHfy4A+W87RDxu4R0nN1q/ZvIsnsveWx0UJ/gKGTJqkbBNQNT/5dj4T3z1w4c4pdq/YO0PWmyKWCycCHLVnxxvmqQJVM/r2rJ7hKTa2Cwx6CEKVrqNpMDxA8LFQGM24QrdaRyOJbo5NMay4mM=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 AM6SPR01MB0060.eurprd05.prod.outlook.com (10.255.22.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 12:34:15 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 12:34:15 +0000
Received: from localhost (194.105.145.90) by PR2P264CA0024.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 12:34:14 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Igor Opanyuk <igor.opanyuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] Generic DPI panel on Colibri iMX7 / Col.Eval.board
Thread-Topic: [PATCH 0/3] Generic DPI panel on Colibri iMX7 / Col.Eval.board
Thread-Index: AQHVy6AYaTiOcgTuZUi7icglqlQMCA==
Date:   Wed, 15 Jan 2020 12:34:15 +0000
Message-ID: <20200115123401.2264293-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2P264CA0024.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::36)
 To VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5284854c-c217-43e0-06e5-08d799b73b5c
x-ms-traffictypediagnostic: AM6SPR01MB0060:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6SPR01MB0060BE1A99E10CCB7FB9FB25F9370@AM6SPR01MB0060.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(54906003)(52116002)(6496006)(6916009)(81156014)(316002)(66556008)(64756008)(8676002)(66446008)(66946007)(7416002)(86362001)(71200400001)(44832011)(66476007)(4326008)(36756003)(16526019)(26005)(478600001)(2906002)(5660300002)(4744005)(81166006)(8936002)(186003)(1076003)(6486002)(956004)(2616005)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6SPR01MB0060;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kakSYJMVOxE9VbR1+D54jv6izu3sKMdlQQ8M+URcoL3tYTvbJ6kjDj/95u0LoE8TQC+lCqN2FQTcF5oKdC8HOZ7zdNefgDT3nnIuqgf8xne5o455v5e0ZNpauIkTsAOL5EtC/wDWXtfNUhVyps0B4truiau9z5zaogs+dTCXyxuqQVcUrtp2Szz/v8iIdGPbZ1Zr5/Ue3UZ/GN2WQL6WEQnycSJhEvROp6x7P4znn6RBRaKu9DNcbFXTW/wZHwbyE9nDw2m90IePzu2LTUBfhPE2EMYqvzctCAZNfG7/YtP0wqileYTc1YCMiiU2Yy2Vp9B/mkAWLV/U94N6v0xGVFzW5ljhwzwOe/nLnx3kCiWe7sh0k/8MK6xRidsljNQGTYzDwHt1EiTF/3MaHs6Fhw0rB1MCh+KowihHvMpsGcj5zE2JoOTXZ60txyDXc8+DqrSbwCkbfAS/9PJbbwYK7BNNUM0kER0Xucoqlk1Zw0sY27aukkDETvHpXd9iT4Jg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5284854c-c217-43e0-06e5-08d799b73b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 12:34:15.4183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNlSyCzsKh9xGdPHH9zaVp3g9CMs/vC9Vmixt5BVahDrUsJZnAOY21q2+RvM6ke3lyFykvbuGFMkeIpmrQqkRixLUTd8CtGY6dFFLhCGwOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Make LVDS panel driver DPI capable and use it to add generic
RGB (DPI) panel support for Colibri iMX7 SoM on Colibri Evaluation Board.


Oleksandr Suvorov (1):
  ARM: dts: imx7-colibri: add generic RGB (DPI) panel

Stefan Agner (2):
  drm/panel: make LVDS panel driver DPI capable
  drm/panel: pass video modes bus_flags

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 29 +++++++++++++-
 drivers/gpu/drm/panel/panel-lvds.c          | 44 ++++++++++++++++-----
 2 files changed, 62 insertions(+), 11 deletions(-)

--=20
2.24.1

