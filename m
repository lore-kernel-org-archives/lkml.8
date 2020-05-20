Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89984C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629DF207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kf7tzvX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETGpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:45:30 -0400
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:57952
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbgETGp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:45:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBtjl12e62L1geWq88ZI1P0gIJ2FW5C+btMyibjQpzRxJ8fbSaQDQcH4lxjWBTeBC74bLnOF9+bcukGFYEFwE/FXyLrN/Pjgf5DvGdApj62B1M1K8bwZTq47/LirEKHpEPk9siq8rlwy29Hp7x46mCxE1aDfByKwtCCO0MKFnQ6dxX+R+iApKieZPSl256IHZ9XkGCufwIlDndRCTjzH1dXKQR2drbnS6r1AfW5TDqfyMWbAc4FC7k0pYdsLfPYHMcCz4pWJsqTLsNERhIFkI7Y81hv4ApuNlHqfSwPW1bTEZQ+QOAveE47Rnsk1E+mUXiR5TTAFiavZyZ9YVG+m4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75ad9pCRXdVxNnqjdVV5LqFltR5tPDqz8C0pN9TJnYM=;
 b=e3dHpD6tlrZfJLLA21rELJhtjHOrTytDaQTJgeSNBJ2EsheSe0AooQFRdXg0M+8T6rTaEoWrQNemRo3Dpgwt4Ny/EPfHBwRjLfvpY7abn3nDm0lq9QLd2N4fcA/t10b4EZ8L+zL+w+4sOjEfwYi+iNPShr9Gleb56761xE4FFayPCTIpGszZzylo95ErEibk3l8blLsbjVvZpcpogyJ4rY6BV/ktdwttw43klXcNK9pEEk1DOddSFY+f761/T5asS3XWsCOqGxBun0DmNBDiZNoaUkMZaxeLr44KzIiGCnlYq1MSpmgG6OhAXzXQ8fWaj3Jd4c4N3446rbtt+ypTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75ad9pCRXdVxNnqjdVV5LqFltR5tPDqz8C0pN9TJnYM=;
 b=kf7tzvX798Tc/ppyeWHIUjUdDwV7MdVbVyWkgF8byf232JhXjl4aHFrEjZodW8hm+7q3sM/QrKRSbO7PtrzJXlb+Ch2ktOjpaPPgnRSKrtKd/dN5EsJD5cATImSv7neLRTnQK45y/jgW9wVLJ17NpxmhMePfuC9UHspD1ExlI3I=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4918.eurprd04.prod.outlook.com (2603:10a6:20b:6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 06:45:23 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 06:45:23 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 1/3] arm64: dts: imx8m: add mu node
Thread-Topic: [PATCH 1/3] arm64: dts: imx8m: add mu node
Thread-Index: AQHWLkxsKIabieZfZk2PIUvIL0rSeqiwhwEw
Date:   Wed, 20 May 2020 06:45:23 +0000
Message-ID: <AM6PR04MB4966A1E2252B7FDEA49C75E580B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
 <1589940278-3680-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1589940278-3680-2-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a0466be-a07b-45ba-eed9-08d7fc895f4e
x-ms-traffictypediagnostic: AM6PR04MB4918:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB49189619153B36AA1F35381D80B60@AM6PR04MB4918.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:338;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqfvMhUujuOXdcGk1GmLSc62/V7Jx41gi1FoXXYJYV/odZ1t86+w6dyKuwt4TUMCG4dgQC3i9pU5eX1jxDxxw1eQiXjZUtAp5fxgv/o0Gt1Lo4qBh6Berk55tIwm7JtLEjCxMbrrQiZTHlAIt3oV1zq9z3nYZ0+tR9Smp2VNBXVpS3dfw+yX2QqTJM4F3s2QJHzEPoCMA7nhq2x7/WUM1v5QLVLMMJO9RYUk7t+KlDMYULniNWnycFvlEWXVawxyAoO9hhmTKvejClxRGfif7JO6tZ6TzGcg1aBYcc5esOkYm2siGb61HDWLDvkvw8i+lLRgExTZjUe15Z7SwOJV0zfAsAnYYKNjBPYwFtJPGk+zGRX9bpQcw0Oo9MyfUgnK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(9686003)(55016002)(7696005)(33656002)(66476007)(64756008)(44832011)(6506007)(8676002)(66556008)(186003)(86362001)(26005)(8936002)(66946007)(4326008)(66446008)(76116006)(478600001)(71200400001)(52536014)(54906003)(110136005)(5660300002)(2906002)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iCMNQFWfsA5h/oGo2LGiv2DLev6Yy0W/x0qXn458zitTggVv77AT7pt3OCpHsWu+7STnMPa/m8DJcTQc3FiYBlFu+g+fnzfuC+178tx95dlk/1u4GejYQIY2f3qzOe92LZ97TzHZyjVzWHOQY59/+WSWBjFhx9gKbCxPLa1+pBoKo/MWKvSLvOADPwTpmKksij/4n0cWD9t/QViOHWI6+qc7wa10GCb19JFrlIIK1RtQ+T0usR2fon3FWa405YVgTM6caFhYUU3+xXVJc6MAsqoWoYFDcgPLHKJ182qDi3Wi/UPq/1WOQiCsSHqmR6HBlHgRFsYJpeoUROsi2rErNU2uU+GKeqUrAVke7zxI0wqsvkO9bS2M3ckES4FXojFv5BEyNVmO0uD2gByIopmjgC84BA61VdfjtSyeaEqXE4HHTI6iaHyU0e6DEmkCZgqOAVtf28hD753JU7cV+kQzwfEvtVmI8G6eVbBpapq9au+k1J3NgO3Rrxo3g5ObVux6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0466be-a07b-45ba-eed9-08d7fc895f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 06:45:23.4822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzO1+QbPgHoyixOzlGUsWBHsmQKIwMaXqiWgszLGbaHZaWzhThDVFRikJd8hhgPGqfgykAAMuM9JMiSDKWMnLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBN
YXkgMjAsIDIwMjAgMTA6MDUgQU0NCj4gDQo+IEFkZCBtdSBub2RlIHRvIGxldCBBNTMgY291bGQg
Y29tbXVuaWNhdGUgd2l0aCBNIENvcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bW0uZHRzaSB8IDkgKysrKysrKysrDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtbi5kdHNpIHwgOSArKysrKysrKysNCj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1xLmR0c2kgfCA5ICsrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNyBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1tLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW0uZHRzaQ0KPiBpbmRleCBmM2JiZWZlM2U1OWYuLjk3MjJmNzZkOGMzZiAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gQEAgLTc3MSw2ICs3NzEs
MTUgQEANCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgCQkJfTsNCj4gDQo+ICsJCQlt
dTogbWFpbGJveEAzMGFhMDAwMCB7DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14NnN4LW11
IjsNCg0KVXN1YWxseSB3ZSBhbHNvIGFkZCBjdXJyZW50IFNvQyBjb21wYXRpYmxlIHN0cmluZy4N
CmNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1tdSIsICJmc2wsaW14NnN4LW11Ig0KDQo+ICsJCQkJ
cmVnID0gPDB4MzBhYTAwMDAgMHgxMDAwMD47DQo+ICsJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDg4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9D
TEtfTVVfUk9PVD47DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAibXUiOw0KDQpVbmRvY3VtZW50ZWQg
cHJvcGVydHksIGRyb3AgaXQNCg0KPiArCQkJCSNtYm94LWNlbGxzID0gPDI+Ow0KPiArCQkJfTsN
Cj4gKw0KPiAgCQkJdXNkaGMxOiBtbWNAMzBiNDAwMDAgew0KPiAgCQkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhtbS11c2RoYyIsICJmc2wsaW14N2QtdXNkaGMiOw0KPiAgCQkJCXJlZyA9IDwweDMw
YjQwMDAwIDB4MTAwMDA+Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1uLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW4uZHRzaQ0KPiBpbmRleCBmYjYzYTk4ZmRmZjUuLjVmMzBmMWQ1MDQ2MCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gQEAgLTY3MSw2ICs2NzEs
MTUgQEANCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgCQkJfTsNCj4gDQo+ICsJCQlt
dTogbWFpbGJveEAzMGFhMDAwMCB7DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14NnN4LW11
IjsNCj4gKwkJCQlyZWcgPSA8MHgzMGFhMDAwMCAweDEwMDAwPjsNCj4gKwkJCQlpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgODggSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsJCQkJY2xvY2tzID0gPCZj
bGsgSU1YOE1OX0NMS19NVV9ST09UPjsNCj4gKwkJCQljbG9jay1uYW1lcyA9ICJtdSI7DQo+ICsJ
CQkJI21ib3gtY2VsbHMgPSA8Mj47DQo+ICsJCQl9Ow0KPiArDQo+ICAJCQl1c2RoYzE6IG1tY0Az
MGI0MDAwMCB7DQo+ICAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1uLXVzZGhjIiwgImZzbCxp
bXg3ZC11c2RoYyI7DQo+ICAJCQkJcmVnID0gPDB4MzBiNDAwMDAgMHgxMDAwMD47DQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IGluZGV4IDFkMTU2ODBh
NDk2Mi4uZTk2OWZjYmJkMTVmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXEuZHRzaQ0KPiBAQCAtOTU2LDYgKzk1NiwxNSBAQA0KPiAgCQkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ICAJCQl9Ow0KPiANCj4gKwkJCW11OiBtYWlsYm94QDMwYWEwMDAwIHsNCj4g
KwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2c3gtbXUiOw0KPiArCQkJCXJlZyA9IDwweDMwYWEw
MDAwIDB4MTAwMDA+Ow0KPiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4OCBJUlFfVFlQRV9M
RVZFTF9ISUdIPjsNCj4gKwkJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX01VX1JPT1Q+Ow0K
PiArCQkJCWNsb2NrLW5hbWVzID0gIm11IjsNCj4gKwkJCQkjbWJveC1jZWxscyA9IDwyPjsNCj4g
KwkJCX07DQo+ICsNCj4gIAkJCXVzZGhjMTogbW1jQDMwYjQwMDAwIHsNCj4gIAkJCQljb21wYXRp
YmxlID0gImZzbCxpbXg4bXEtdXNkaGMiLA0KPiAgCQkJCSAgICAgICAgICAgICAiZnNsLGlteDdk
LXVzZGhjIjsNCj4gLS0NCj4gMi4xNi40DQoNCg==
