Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A11BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C4220DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JcgyJLxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgFQKeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:34:50 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:27877
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbgFQKet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:34:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGRlf7iaXUelfeKM/yPUqs4BomYYm5IrjJXenVBdbDYpxh+a6/U65SAJ+h89sxlI2ZIuQl5KnCndqJMjMAnU66eGKwjetSeEAi4UkN5MpBf0Qy5mh3LBUT49JMH6YbS/cup1z3MAHZGitn5e4oFmOhuK40Ep2d6n/sl9frwstfJO0GGTfj3fEmIro1t4e0KsAXBnavO1Bi6mhyIXISX0PZuYu6jfwGWhIQEyWxs17okl+z09XkgblaHWzhQuBXjPgEGlsng+9uAXSEo96lsmAQC0J7Dy79YlcAplP8v3agdsCyh4oltN6eJzNjEdXxb71A/xUWUbNWybW8fTJwmOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3EurD+TM0RnBE6S6o8LIahDye1Qr24o29M91Lp9fa8=;
 b=DB5G6q8YRU1jcQse7WyrBFFfDXrc3AMtN2BQBJGkzibWsj9ekRLaIaiIEyrYk6O5r5mC9Yjd5H6wwBxWHLJzBnXS0hHNAXi2UvYPUkLR1p9W2yIc9rjl1c2KC2hmC0hGypWu/zo8M28FVngU4J6lME2glgTB+Vc2XIOeNC5CMvty97WNwtPFrbpO7QgAWTPK2L92f4sZ+LYLSSE04KUqXwsvFoHRjdhKc7yvSwkqbQz2pYMqQQf51LZ2EtLkyz6eNPU7ribtFjLCIP6ctiHwXlBv1/Sjq1wmBDjo/GautEf019YayLxEfQtFfQAwuKzEoTIvHQVtuP4jj45JYMsvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3EurD+TM0RnBE6S6o8LIahDye1Qr24o29M91Lp9fa8=;
 b=JcgyJLxvvjBO8G3Y70e/CJ8tqcJmXRb0sU1remTSGsX4QJidqmIPLCSts4RJvFYimwrMY/P/6b7BGWKQAQJtbTT/ulZfhX3/I2t1NulhMcbNVL9vn7jqHt/LsPTMpuW1EoCrdaSR5Iccyc4RGDrC000av34cVrpUSkDbatWEE3A=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5959.eurprd04.prod.outlook.com (2603:10a6:20b:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 17 Jun
 2020 10:34:45 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 10:34:45 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Abel Vesa <abel.vesa@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/9] ARM: imx: Select MXC_CLK for ARCH_MXC
Thread-Topic: [PATCH V2 2/9] ARM: imx: Select MXC_CLK for ARCH_MXC
Thread-Index: AQHWPjGjLfNEVvc8HUmhxuTW0pJGcKjcqIMg
Date:   Wed, 17 Jun 2020 10:34:45 +0000
Message-ID: <AM6PR04MB4966F4A5E0276AEDB5605260809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1591687933-19495-3-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d53e41f-0c4f-45c7-37bb-08d812aa0db4
x-ms-traffictypediagnostic: AM6PR04MB5959:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5959B84957AB3CC45BA9A64D809A0@AM6PR04MB5959.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aI7xI4yu7zftKFZ/cztIc+gp+pNGr1AQrRRxeHtzKiq2XWlMiX+nYPBdp5I8yU4nFdEQoxt2AIbXvt48rbBNArkRpUXhfzuQndr+pcsa/VOlYEW3mjwwCkYSfpDnvMFnyr3l493jK+ItZ+R49loX0qtE7V4j6GqrimUegiJyN//WyPfemA7c0fOQlvXyGnG3Usgu4aRjX9mzb4RAlOMsff0z05mXRu+ScjERTn+v5crzIQLOgb+Lsxei/LktJIS6TxNIje0WcWRs5pRhwmgmZSBjIdT0klOsl8H3bh4vP9yFndDAkY5MdQD13nzTVBQAL6bzfSyoLN50Af8X1RX1FboBIlvFrmKqPcv85CBOvm5rbU6sBM9gQk94tnmvPfWkNZeoGrE5h6pEde7Gvc8pKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(83380400001)(4326008)(66946007)(52536014)(44832011)(26005)(86362001)(5660300002)(64756008)(66476007)(76116006)(66446008)(66556008)(6506007)(110136005)(8676002)(8936002)(7416002)(316002)(7696005)(478600001)(9686003)(55016002)(71200400001)(2906002)(4744005)(186003)(33656002)(921003)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RtgtYQWQEm+YOg+jGrevBj8FV+29pFYTjLEuUFsOyjwYgF10owyTQv9KhHMXAwuRFUmlh9fdDRpRZZ4i7o2oq+f5oIRuLsrXVJybpKTtYtABUbvrIBSbb5F3Zh0XIsSv+Dh29GV5syRYP8MWo0tl0rlL+SjHyt+ifB37uZNbhc+U7bWGK78MM4k2FjgTUQ5q1eIaHWhVD8WAIbX63YukwxMa+Tzhf2NbqHt63V0FjUOyyjWrrFwZDQYL68awtv9l4MITp+gu+TFJOF20Zk9rIyp8suG8qdfoMBL/oTIDwfqX8FSBgBYyaHsym28bakmaAeH7ISQX/BhBjLKJefy4WKfOwijU5RMbAR+Y4heZ4nSbscWgIq49SHxryZ+RAOMjnXC1ZoA3X2EqJVDeoqLRbIlQY/3e1fMJ72N7qL/jO/Od1gCaEHhX/GVcgP4827a8/g+jVMvtMaZ+j0mSehOayhhmCdITxoukdhB2TBQIAc9hHq5Fd6lC/TZoCrHstK3i
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d53e41f-0c4f-45c7-37bb-08d812aa0db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 10:34:45.6090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgAOhnb0KEG/RGz4o+qGVTho1etLQOXmzOeL69T603bAM9c9EGswPF9+AWE8XdRmB7a6llmA2TM66ZFk1iQjfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgSnVuZSA5LCAyMDIwIDM6MzIgUE0NCj4gDQo+IGkuTVggY29tbW9uIGNsb2NrIGRyaXZlcnMg
bWF5IHN1cHBvcnQgbW9kdWxlIGJ1aWxkLCBzbyBpdCBpcyBOT1Qgc2VsZWN0ZWQgYnkNCj4gZGVm
YXVsdCwgZm9yIEFSQ0hfTVhDIEFSTXY3IHBsYXRmb3JtcywgbmVlZCB0byBzZWxlY3QgaXQgbWFu
dWFsbHkgdG8gbWFrZQ0KPiBidWlsZCBwYXNzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNCkNhbid0IHRoZSBvcmlnaW5hbCBkZWZfeHh4
IHdvcms/DQoNCmNvbmZpZyBNWENfQ0xLDQogICAgICAgIHRyaXN0YXRlDQogICAgICAgIGRlZl90
cmlzdGF0ZSBBUkNIX01YQw0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gLS0tDQo+IE5vIGNoYW5n
ZS4NCj4gLS0tDQo+ICBhcmNoL2FybS9tYWNoLWlteC9LY29uZmlnIHwgMSArDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNo
LWlteC9LY29uZmlnIGIvYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZyBpbmRleA0KPiBlN2Q3Yjkw
Li40N2IxMGQyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNoLWlteC9LY29uZmlnDQo+ICsr
KyBiL2FyY2gvYXJtL21hY2gtaW14L0tjb25maWcNCj4gQEAgLTQsNiArNCw3IEBAIG1lbnVjb25m
aWcgQVJDSF9NWEMNCj4gIAlkZXBlbmRzIG9uIEFSQ0hfTVVMVElfVjRfVjUgfHwgQVJDSF9NVUxU
SV9WNl9WNyB8fA0KPiBBUk1fU0lOR0xFX0FSTVY3TQ0KPiAgCXNlbGVjdCBBUkNIX1NVUFBPUlRT
X0JJR19FTkRJQU4NCj4gIAlzZWxlY3QgQ0xLU1JDX0lNWF9HUFQNCj4gKwlzZWxlY3QgTVhDX0NM
Sw0KPiAgCXNlbGVjdCBHRU5FUklDX0lSUV9DSElQDQo+ICAJc2VsZWN0IEdQSU9MSUINCj4gIAlz
ZWxlY3QgUElOQ1RSTA0KPiAtLQ0KPiAyLjcuNA0KDQo=
