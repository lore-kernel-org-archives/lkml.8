Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C34CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3CF20734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RO7tec3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgFAHqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:46:55 -0400
Received: from mail-vi1eur05on2072.outbound.protection.outlook.com ([40.107.21.72]:6062
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbgFAHqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:46:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAtDg19ZHqcjhNfZ5kn+z79ANjHR1uyO39xHK6OwzjQcudf0X2a8rlF2cONEzor6cgpWIdipRAkLbfCHa7NohJMp3qaB1MliM62pTRIlAoo7XHXa2QtFWAT4Bd9I0O6SeiIwKZJOM5ANJT0IdNb5visAL7S5ObaVOkF7jeK3qeu+22FyyMRqyMmlKTpVlIPNLSRgHI3cvFFPh27jqIz52xIYcYaDc2CVaGAc7FbHre/jD7l2EXWD/q0dkzjhZ1YQD0K6tx7/VUa36RbrExNxwKaphc2vtmUL/O6wQZptYtHl7+tKKr6K5Sztm+2wTI6CvbhfrRmQqMLndqYRiWXijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpBtoyl5vtCYFHJ2bKE2PdquTCV5ebMWUXRKuhmkbHY=;
 b=lVLwral91M4g4suSJf0rdGknWvgzixEzXNuK3aqKA0QbiG8j1tGenPig3ydP0H1j7KiqO27zxhRdEnx2ImuqQHMddlAN96WSXRyY4ygysn+VeYz1tRNTBilM6qOhw57SoiSks0V/sLyXbGw5+V7y/B08L9eLVGckBDTt9ZPJdCG7bAVNluR9mv7QbCAQaRbDnwz0Mv9qGkDxPVkFsU0ELKdxGc+9fRnHHJv0beBkpXIGoN3VrxXz8dUOPLRvtV6LxP2wn3EZqbtL4XjSWfIcMRUydCVC8fAowIa/CxdwZ5jhAeWorNvnwRIONlsFvFw8ISz6d7HS55jZMnz3KSu8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpBtoyl5vtCYFHJ2bKE2PdquTCV5ebMWUXRKuhmkbHY=;
 b=RO7tec3zb9D8nUUHLYDL952t269h0UBQTbFlbGnTbXbcA2nsIiSHMyHhTlG/9V1gt0O7onEQSoruO5aJCrx5k1ZJn9U/vvoHRHODAU7s1W5lXE0Y8BmjMfqVollkUyy5YTMQi6zl+R4ihX7BDi+j7qGyuCeWUa7w7K389EdEISo=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6437.eurprd04.prod.outlook.com (2603:10a6:20b:f3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Mon, 1 Jun
 2020 07:46:50 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 07:46:50 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 2/3] arm64: dts: imx8m: add mu node
Thread-Topic: [PATCH V2 2/3] arm64: dts: imx8m: add mu node
Thread-Index: AQHWN8hFjjdbAZYyRk6dAkOuQwcHuajDYSkg
Date:   Mon, 1 Jun 2020 07:46:50 +0000
Message-ID: <AM6PR04MB496620ABEA09A0571B42A9B4808A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1590982999-7149-1-git-send-email-peng.fan@nxp.com>
 <1590982999-7149-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1590982999-7149-3-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2487ef8-e808-45b7-b335-08d805fff1a0
x-ms-traffictypediagnostic: AM6PR04MB6437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6437DFBE6027426814687B02808A0@AM6PR04MB6437.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdh4KfTt+eju1dsw0hWgiz1Usg74vhAI1Iyk95xw5k1HK0Jits9ujUMIQWJqIjlH/SIyDL3963Bqm6apnewgdllUKusNT713Wzm6pHpYdbfqgMWoIzu4QzNhE9Bt++dzjlSKphUOHa3YnZ7u1GEbiqwYHt6Iv+Kpl9TJL/rxyk66ZNaPImJifT5/b8BXGV+Brp0Tz8X5ybv1vwUuWK8HiYv7uWfC6YbHC/eV3PQAS7ieSk/KCqTfx5IEcZCHLVb8sEoeAV0o8T03DRVmdyXv0jKf1lVueV0cdBmwxSN3ycQknViYvGp5xhF9KsKEjC4gOvysyzk6oMMRQe25kGAkschynkMnNepbjnUrT4cEn3DyrS6eez8QaMddPlhOTSzBHajQPMz8gbxihUXlW+aMD8BfoDq9/sZQzdCFhuRxYqGoyaD9vQRS4CTnmyb+4AYdeW+m2Da2CU9ye7Pva9M1Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(6506007)(966005)(8936002)(86362001)(4326008)(44832011)(71200400001)(478600001)(33656002)(8676002)(7416002)(2906002)(7696005)(83380400001)(52536014)(54906003)(186003)(66476007)(66446008)(64756008)(66556008)(66946007)(110136005)(55016002)(26005)(316002)(76116006)(5660300002)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BZ8C6lbCV9xFVH8xQuyLEwJayJfTXrp/sEPuxF8Jd8mvzk708ihpyqxiWCddHIPGZt6zZqjGEn0LzyLRIoGRUEKH1sp3Fw3dPYINcaKafz3vzEjYf7kfV6B9KLEzldJg4q+83vINSQy/PFn5/bCYwQPPTTG/jmk8htk06eEj+UhTAIoFHe0B0mb3bLbKw2doMaLhWZea4LG/CftslpC3QZLQzilqIeWHY5s/gmn7f2Nr6sr36rX80T0yd1U2J4IC/Cu1qtdtEVYpQwHRKSw1BIBaLlO8nhaYGlAAEUGjusWW+LfTeXgQRI9Pk9hvZZOLYwSpTJxnZou9JNZa5AXgXpwMY2oifTy7uuZY/UeUmpoW1TgJDHpKd4C++QJejVStnjIOjPjmcbC57LtefzkHEA8gJLJ2hiycvRNThmxqZKcQUq7d+QQLLkBuft9K8NW+glQHXIXVsWwxjEHUYuC93l9Kn9C3hvgvbp3u54+9+YU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2487ef8-e808-45b7-b335-08d805fff1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 07:46:50.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ul8jkW/lx2Rn0GE2u22PLNd38EqF3NpuURK/sgHs5UJW0QuA3V25565amjiL/O5Xl61pr74UiIBbOuwR4a3Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5l
IDEsIDIwMjAgMTE6NDMgQU0NCj4gDQo+IEFkZCBtdSBub2RlIHRvIGxldCBBNTMgY291bGQgY29t
bXVuaWNhdGUgd2l0aCBNIENvcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVu
Zy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0uZHRzaSB8IDkgKysrKysrKysrDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbi5kdHNpIHwgOSArKysrKysrKysNCj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLmR0c2kgfCA5ICsrKysrKysrKw0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXEuZHRzaSB8IDkgKysrKysrKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDM2IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW0uZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS5kdHNpDQo+IGluZGV4IGFhZjZlNzExMDFhMS4uZmMwMDFmYjk3MWU5IDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiBAQCAtNzc1LDYgKzc3NSwx
NSBAQA0KPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJCQl9Ow0KPiANCj4gKwkJCW11
OiBtYWlsYm94QDMwYWEwMDAwIHsNCj4gKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bW0tbXUi
LCAiZnNsLGlteDZzeC1tdSI7DQo+ICsJCQkJcmVnID0gPDB4MzBhYTAwMDAgMHgxMDAwMD47DQo+
ICsJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDg4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiAr
CQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfTVVfUk9PVD47DQo+ICsJCQkJY2xvY2stbmFt
ZXMgPSAibXUiOw0KDQpZb3UgbWlzc2VkIG15IGNvbW1lbnRzIGFib3V0IHRoaXMgdW5uZWVkZWQg
bGluZSBpbiB0aGUgbGFzdCByb3VuZCBvZiByZXZpZXcuDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9wYXRjaHdvcmsvcGF0Y2gvMTI0NDc1Mi8NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+ICsJCQkJ
I21ib3gtY2VsbHMgPSA8Mj47DQo+ICsJCQl9Ow0KPiArDQo+ICAJCQl1c2RoYzE6IG1tY0AzMGI0
MDAwMCB7DQo+ICAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLXVzZGhjIiwgImZzbCxpbXg3
ZC11c2RoYyI7DQo+ICAJCQkJcmVnID0gPDB4MzBiNDAwMDAgMHgxMDAwMD47DQo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaQ0KPiBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpDQo+IGluZGV4IDlhNGI2NWEyNjdk
NC4uYzgyOTBkMjFjY2M5IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW4uZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW4uZHRzaQ0KPiBAQCAtNjc1LDYgKzY3NSwxNSBAQA0KPiAgCQkJCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+ICAJCQl9Ow0KPiANCj4gKwkJCW11OiBtYWlsYm94QDMwYWEwMDAwIHsNCj4gKwkJ
CQljb21wYXRpYmxlID0gImZzbCxpbXg4bW4tbXUiLCAiZnNsLGlteDZzeC1tdSI7DQo+ICsJCQkJ
cmVnID0gPDB4MzBhYTAwMDAgMHgxMDAwMD47DQo+ICsJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDg4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTl9D
TEtfTVVfUk9PVD47DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAibXUiOw0KPiArCQkJCSNtYm94LWNl
bGxzID0gPDI+Ow0KPiArCQkJfTsNCj4gKw0KPiAgCQkJdXNkaGMxOiBtbWNAMzBiNDAwMDAgew0K
PiAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbi11c2RoYyIsICJmc2wsaW14N2QtdXNkaGMi
Ow0KPiAgCQkJCXJlZyA9IDwweDMwYjQwMDAwIDB4MTAwMDA+Ow0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiBpbmRleCA0NWUyYzBhNGU4ODkuLmI1MzA4
MDRmNzYzZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1wLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0
c2kNCj4gQEAgLTYyMSw2ICs2MjEsMTUgQEANCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiAgCQkJfTsNCj4gDQo+ICsJCQltdTogbWFpbGJveEAzMGFhMDAwMCB7DQo+ICsJCQkJY29tcGF0
aWJsZSA9ICJmc2wsaW14OG1wLW11IiwgImZzbCxpbXg2c3gtbXUiOw0KPiArCQkJCXJlZyA9IDww
eDMwYWEwMDAwIDB4MTAwMDA+Ow0KPiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4OCBJUlFf
VFlQRV9MRVZFTF9ISUdIPjsNCj4gKwkJCQljbG9ja3MgPSA8JmNsayBJTVg4TVBfQ0xLX01VX1JP
T1Q+Ow0KPiArCQkJCWNsb2NrLW5hbWVzID0gIm11IjsNCj4gKwkJCQkjbWJveC1jZWxscyA9IDwy
PjsNCj4gKwkJCX07DQo+ICsNCj4gIAkJCWkyYzU6IGkyY0AzMGFkMDAwMCB7DQo+ICAJCQkJY29t
cGF0aWJsZSA9ICJmc2wsaW14OG1wLWkyYyIsICJmc2wsaW14MjEtaTJjIjsNCj4gIAkJCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1xLmR0c2kNCj4gaW5kZXggOTc4ZjgxMjJjMGQyLi42NmJhOGRhNzA0ZjYgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IEBAIC05NTksNiArOTU5
LDE1IEBADQo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gIAkJCX07DQo+IA0KPiArCQkJ
bXU6IG1haWxib3hAMzBhYTAwMDAgew0KPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1t
dSIsICJmc2wsaW14NnN4LW11IjsNCj4gKwkJCQlyZWcgPSA8MHgzMGFhMDAwMCAweDEwMDAwPjsN
Cj4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODggSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+
ICsJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19NVV9ST09UPjsNCj4gKwkJCQljbG9jay1u
YW1lcyA9ICJtdSI7DQo+ICsJCQkJI21ib3gtY2VsbHMgPSA8Mj47DQo+ICsJCQl9Ow0KPiArDQo+
ICAJCQl1c2RoYzE6IG1tY0AzMGI0MDAwMCB7DQo+ICAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14
OG1xLXVzZGhjIiwNCj4gIAkJCQkgICAgICAgICAgICAgImZzbCxpbXg3ZC11c2RoYyI7DQo+IC0t
DQo+IDIuMTYuNA0KDQo=
