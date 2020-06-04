Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073FE2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SlvlZTbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgFDIQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:16:13 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:19424
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbgFDIQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:16:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llnjRBVMOHLAP9o+Wft6pqv5RTyeQemuASYlyZo96Dd2pass3TlYlg5nD2daKReK0FNvO/ZHwtGBz3xWcISBzMFX678KP8F6fyqTeqaK1/N6docsCIO00zLdNFdm51AefxmYvP7xVkZhKUJCO1XvP48bnAADT/PSB1ye7vmQV5RYjaTBmRFoFjuhqM1oGZbmT5K2HN6hPVQEA1+N0pVqgALCsU0c1Hjlx8WbHKkIy4BxGK1LJdrfJK2/rQSKEz9uFUzB2LMUZbFl2HR9NYl+oJTDTgdTvAg4nAeZOJCSkqCPF5ZUw9fEg11G2eQ10qbqUa5aELAcZ5bQzTuwNw3r9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKV6UOSeCltR07cN3fJgIH1zb1+WBvUTYlyMMWgkNck=;
 b=XF5E+tXpX5xc+2yMD+QaLQsyrIGZBeK7dn3gf5mcOxhQC7tKLK1LSoYYR4ar8Kz4IUhbBVc3ijV1yfGkhXSgNQpVlokqtCuXKaquZ3XfKOGkc6qdLxCEvhGQq+P6yCOrsuLGFG7mqh+H1FXuUKUkl+LDty9X3o50M6iIEKdr3eNJL9rdSrI64ZvZ5+zObrfMhbTF2z55W86OnEL5v73NyuBXt5hplnvLgTl3v75g+6aOcbW1lVljW3g6EKiTQ3IUG+uxWO3yzy5y16P6Es313xPeseNTNQlTfqiIWben1h8Y1QH8jy4u5pygevYGnZaqt5iwxPw6ESWZdXKIwmV2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKV6UOSeCltR07cN3fJgIH1zb1+WBvUTYlyMMWgkNck=;
 b=SlvlZTbdTesUrfQB/HyLEkN5SPEBSjxNXAHTQ8BeNrvv6O2ih2DpJgaYg7fyzT4cQdZ/sYu8P9emnqDjBfwrywp1IH9hlB3U4uOUmBrS/FkVpQDoio9oRPVIQLGUxIy+nGVmac13ah+mAJrMUxsRPmi8H27+WgrEEuNvoJGAau8=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4694.eurprd04.prod.outlook.com (2603:10a6:20b:a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 08:16:05 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 08:16:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/3] firmware: imx: add resource management api
Thread-Topic: [PATCH V2 2/3] firmware: imx: add resource management api
Thread-Index: AQHWOVkVyZOOG/6+fkys2OkB94SqeqjIHeCA
Date:   Thu, 4 Jun 2020 08:16:05 +0000
Message-ID: <AM6PR04MB4966B2E779E2B7718A1D99A580890@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591155143-25972-1-git-send-email-peng.fan@nxp.com>
 <1591155143-25972-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1591155143-25972-3-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a397c76b-3e74-45fa-fa71-08d8085f8717
x-ms-traffictypediagnostic: AM6PR04MB4694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4694DEF3CADB33D32675629280890@AM6PR04MB4694.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4saQ2WnhrdPtcDwZRsCHYfyBbfCYC6yMtddQUlLP3vtIMXfeVuMXl14o7jHr6vdNs+W6Lfdvh7lMMbucw/rkF/SEYyEreGCXQ6fjg3KtDuIKC/Z0bUyzMdevz1WZXAlc5zaSQqBAmrR+3robxRXNgmdM3L4XaOnVb/ECsEBwWjSoaj5qqmyKVOXCV9FGrD9uWkmq4RtVHD8Gv48QYPRRTZ1/VC4gb2xmxLymWtkfZFzCsQMr4fMWpIpnr99VUlcnJ49Yq3RY2B68dhPbs+DHwPTyUFRxsIYKeG+4YVtWCaMVglORz0bnE/wQiwxuE9D7APh9hwwTRK9GkYsTE9x+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(6506007)(7696005)(26005)(44832011)(186003)(86362001)(71200400001)(9686003)(55016002)(8676002)(83380400001)(76116006)(66476007)(64756008)(66946007)(66556008)(66446008)(54906003)(52536014)(478600001)(5660300002)(4326008)(316002)(2906002)(33656002)(8936002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mIgcIN4g5xQaz7bkj3TRc/O34mqvg4272RS1O4Ncou2SVTlCfx0UHM0xhYzXBI3V3F2k5nf3yeaGfjNoxNnjRxQ8psW/IcuahdoMWdNgnd85P4stMxNNbN2e9TEmvXhwe7Tt64NcZSPwPT5pem1kDSjwbVCmqQMSKGUtdP856TtWPs6g4LdTvTWoaGvYeSdoqfnbTd3eiDxJed9b0+KRWXSM0ocWGM0D9wr4hguc6QK0fzDthpj6GdGP5NJpjYfeak4NwU0lJyYxcRI+8w0sT+DVQStjskg0wXGv4afyq5UiCNL8Iu1FAyKIgW/20HaXWxfRtk4suPx1M5u58/6e/d0OIDQ3hqaErHncloSjuW1qJgq3EpWeOelDMZkzD1diCgqiRt+Z6TA9Ts1iizJJKrVUD41D43Q/z2VHQ0JfQH70EAKUYWeFBU0MlaR7NUAKy7PAWugJqEIGTjnGojFbpZQuNyUVRNGRU1cDwAhJ4/e3nYfm6fKFDMhBHYWAvIgd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a397c76b-3e74-45fa-fa71-08d8085f8717
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 08:16:05.3096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTCgC7NzCLmp2MSSlPt2Vo/4wOsrWUGGUiPTQPqt8kXifRxPrnkZghZRfbDzXOdPVwSdQ9Oqbs8yce8RvHCVGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBK
dW5lIDMsIDIwMjAgMTE6MzIgQU0NCj4gDQo+IEFkZCByZXNvdXJjZSBtYW5hZ2VtZW50IEFQSSwg
d2hlbiB3ZSBoYXZlIG11bHRpcGxlIHBhcnRpdGlvbiBydW5uaW5nDQo+IHRvZ2V0aGVyLCByZXNv
dXJjZXMgbm90IG93bmVkIHRvIGN1cnJlbnQgcGFydGl0aW9uIHNob3VsZCBub3QgYmUgdXNlZC4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZSAgICAgICB8ICAyICstDQo+ICBkcml2
ZXJzL2Zpcm13YXJlL2lteC9ybS5jICAgICAgICAgICB8IDQ1ICsrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmggICAgfCAgMSArDQo+ICBp
bmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaCB8IDY5DQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBkcml2ZXJzL2Zpcm13
YXJlL2lteC9ybS5jICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gaW5jbHVkZS9saW51eC9maXJtd2Fy
ZS9pbXgvc3ZjL3JtLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9N
YWtlZmlsZSBiL2RyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxlDQo+IGluZGV4IDA4YmM5ZGRm
YmRmYi4uMTdlYTM2MTNlMTQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9N
YWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZQ0KPiBAQCAtMSw0
ICsxLDQgQEANCj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gIG9iai0k
KENPTkZJR19JTVhfRFNQKQkJKz0gaW14LWRzcC5vDQo+IC1vYmotJChDT05GSUdfSU1YX1NDVSkJ
CSs9IGlteC1zY3UubyBtaXNjLm8gaW14LXNjdS1pcnEubw0KPiArb2JqLSQoQ09ORklHX0lNWF9T
Q1UpCQkrPSBpbXgtc2N1Lm8gbWlzYy5vIGlteC1zY3UtaXJxLm8gcm0ubw0KPiAgb2JqLSQoQ09O
RklHX0lNWF9TQ1VfUEQpCSs9IHNjdS1wZC5vDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13
YXJlL2lteC9ybS5jIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvcm0uYyBuZXcgZmlsZQ0KPiBtb2Rl
IDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLmExMmRiNmZmMzIzYg0KPiAtLS0gL2Rldi9udWxs
DQo+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvaW14L3JtLmMNCj4gQEAgLTAsMCArMSw0NSBAQA0K
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ICsvKg0KPiArICogQ29w
eXJpZ2h0IDIwMjAgTlhQDQo+ICsgKg0KPiArICogRmlsZSBjb250YWluaW5nIGNsaWVudC1zaWRl
IFJQQyBmdW5jdGlvbnMgZm9yIHRoZSBSTSBzZXJ2aWNlLiBUaGVzZQ0KPiArICogZnVuY3Rpb24g
YXJlIHBvcnRlZCB0byBjbGllbnRzIHRoYXQgY29tbXVuaWNhdGUgdG8gdGhlIFNDLg0KPiArICov
DQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL3JtLmg+DQo+ICsNCj4g
K3N0cnVjdCBpbXhfc2NfbXNnX3JtX3JzcmNfb3duZWQgew0KPiArCXN0cnVjdCBpbXhfc2NfcnBj
X21zZyBoZHI7DQo+ICsJdTE2IHJlc291cmNlOw0KPiArfSBfX3BhY2tlZCBfX2FsaWduZWQoNCk7
DQo+ICsNCj4gKy8qDQo+ICsgKiBUaGlzIGZ1bmN0aW9uIGNoZWNrIEByZXNvdXJjZSBpcyBvd25l
ZCBieSBjdXJyZW50IHBhcnRpdGlvbiBvciBub3QNCj4gKyAqDQo+ICsgKiBAcGFyYW1baW5dICAg
ICBpcGMgICAgICAgICBJUEMgaGFuZGxlDQo+ICsgKiBAcGFyYW1baW5dICAgICByZXNvdXJjZSAg
ICByZXNvdXJjZSB0aGUgY29udHJvbCBpcyBhc3NvY2lhdGVkIHdpdGgNCj4gKyAqDQo+ICsgKiBA
cmV0dXJuIFJldHVybnMgMCBmb3Igbm90IG93bmVkIGFuZCAxIGZvciBvd25lZC4NCj4gKyAqLw0K
PiArYm9vbCBpbXhfc2Nfcm1faXNfcmVzb3VyY2Vfb3duZWQoc3RydWN0IGlteF9zY19pcGMgKmlw
YywgdTE2IHJlc291cmNlKQ0KPiArew0KPiArCXN0cnVjdCBpbXhfc2NfbXNnX3JtX3JzcmNfb3du
ZWQgbXNnOw0KPiArCXN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ICsN
Cj4gKwloZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gKwloZHItPnN2YyA9IElNWF9T
Q19SUENfU1ZDX1JNOw0KPiArCWhkci0+ZnVuYyA9IElNWF9TQ19STV9GVU5DX0lTX1JFU09VUkNF
X09XTkVEOw0KPiArCWhkci0+c2l6ZSA9IDI7DQo+ICsNCj4gKwltc2cucmVzb3VyY2UgPSByZXNv
dXJjZTsNCj4gKw0KPiArCS8qDQo+ICsJICogU0NVIGZpcm13YXJlIG9ubHkgcmV0dXJucyB2YWx1
ZSAwIG9yIDENCj4gKwkgKiBmb3IgcmVzb3VyY2Ugb3duZWQgY2hlY2sgd2hpY2ggbWVhbnMgbm90
IG93bmVkIG9yIG93bmVkLg0KPiArCSAqIFNvIGl0IGlzIGFsd2F5cyBzdWNjZXNzZnVsLg0KPiAr
CSAqLw0KPiArCWlteF9zY3VfY2FsbF9ycGMoaXBjLCAmbXNnLCB0cnVlKTsNCj4gKw0KPiArCXJl
dHVybiBoZHItPmZ1bmM7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGlteF9zY19ybV9pc19yZXNv
dXJjZV9vd25lZCk7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9z
Y2kuaCBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oDQo+IGluZGV4IDNmYTQxOGE0
Y2E2Ny4uM2M0NTlmNTRhODhmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJl
L2lteC9zY2kuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaA0KPiBA
QCAtMTQsNiArMTQsNyBAQA0KPiANCj4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc3Zj
L21pc2MuaD4gICNpbmNsdWRlDQo+IDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL3BtLmg+DQo+ICsj
aW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5oPg0KPiANCj4gIGludCBpbXhfc2N1
X2VuYWJsZV9nZW5lcmFsX2lycV9jaGFubmVsKHN0cnVjdCBkZXZpY2UgKmRldik7ICBpbnQNCj4g
aW14X3NjdV9pcnFfcmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7
IGRpZmYgLS1naXQNCj4gYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaCBiL2lu
Y2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTkyNDIxNmYzZTQ1DQo+IC0tLSAvZGV2L251bGwNCj4g
KysrIGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc3ZjL3JtLmgNCj4gQEAgLTAsMCArMSw2
OSBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQo+ICsvKg0K
PiArICogQ29weXJpZ2h0IChDKSAyMDE2IEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQo+
ICsgKiBDb3B5cmlnaHQgMjAxNy0yMDIwIE5YUA0KPiArICoNCj4gKyAqIEhlYWRlciBmaWxlIGNv
bnRhaW5pbmcgdGhlIHB1YmxpYyBBUEkgZm9yIHRoZSBTeXN0ZW0gQ29udHJvbGxlciAoU0MpDQo+
ICsgKiBQb3dlciBNYW5hZ2VtZW50IChQTSkgZnVuY3Rpb24uIFRoaXMgaW5jbHVkZXMgZnVuY3Rp
b25zIGZvciBwb3dlcg0KPiArc3RhdGUNCj4gKyAqIGNvbnRyb2wsIGNsb2NrIGNvbnRyb2wsIHJl
c2V0IGNvbnRyb2wsIGFuZCB3YWtlLXVwIGV2ZW50IGNvbnRyb2wuDQoNCkZpeCB0aGUgY29kZSBj
b21tZW50cy4NCk90aGVyd2lzZToNCkRvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+
DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
