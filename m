Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB074206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hiTtpfzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFBFXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:23:41 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:26435
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbgFBFXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:23:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3J0HRkgSFiXU3kBBkVKSE8cMFp8nxYOptwnkyaA59eoQheDqsX5wogKXAwYWmGaNNP6HsqErYqDvIfi2e4H4rckBJ2Qv/S27W6PQ+2wW/UyvRWYP5JdxsYzr6J/c7v5zfm9QaH43A5kaSeJ2UBkEMC0N0fKDpxPiXaAIuiBgCUYQDNoi4+UdaKFXLHxMyYaHYH5KkKMTYbdHBJztp4f1Qi7yOUc829leaO80M8FNYIwuQ6Ca+sim2+uln+mQitsgp7goeLanYySjvmmCSAGE2fTkJUdW8tTyNYNl4aRPU23/co31SLFkNyRQgJ5dGEr7bpjm4lG3B5ykyEbO984Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JR0oLX+9LIYjafyMccGNcvX7rb5hyW24CZVQdNzmCk=;
 b=V5vXntYcwf5AKSMLdqNIYTjIM6kb+tzJC+nCxCoYm5nYFtTLRCu/hUGStTWXOjJkMDtQGvc/zB4We0khKLcl7bd4AuEX/JKOuEgxEVCb/tyC4jlI972Wgomonynqkv62rHOIUWEAsSPl+Q+XSrDbg54KhaZmtMcEmbGVbJkrt9lZuOP+1Nh+e275+WtbiSRhMdpqk5SEwFSp3zyNyCymdQ6Naw1eph6l9jkH5rFFV5iM9MGPo/G0/8A2Vf2PtSv4QkzyPNj0D2t5khxqwoPjYTvpkBV85Sx6xRZGM6SEBnUXx5NMvyUnv1lOJi8SYUHGfctWwJSY9V0VoTKTDaPr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JR0oLX+9LIYjafyMccGNcvX7rb5hyW24CZVQdNzmCk=;
 b=hiTtpfzd3cLlLcaiK0mXI+U58xAuUj1rKqBKNcP+yG83bIve/KNAMxuuyC5rGF56DM05pa6BPO78VKz+BQIx4hOvgXO9OcwPyf4fmNILRTh2ixTvrm1+Sr4PkkxZYeS7V+9GL2S5z1S2S1Pg4ThqL/0EoTlRFk4AacP0J0rI1+I=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2887.eurprd04.prod.outlook.com (2603:10a6:4:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 05:23:35 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 05:23:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Subject: RE: [PATCH 2/4] firmware: imx: add resource management api
Thread-Topic: [PATCH 2/4] firmware: imx: add resource management api
Thread-Index: AQHWGT37doAjG8vSF0ywBJjXXTGn3qjE43+AgAAlTCA=
Date:   Tue, 2 Jun 2020 05:23:35 +0000
Message-ID: <DB6PR0402MB2760C2AC0CAEF7D8EEB1CA49888B0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
 <1587625174-32668-3-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966DA95F44FA63CDEF7E4F5808B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966DA95F44FA63CDEF7E4F5808B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 754c3067-3e46-41fb-2bde-08d806b51913
x-ms-traffictypediagnostic: DB6PR0402MB2887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2887E6A2B8BAA27738C14C2B888B0@DB6PR0402MB2887.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vvkG2gmcaNhvxPmhfgihsGWWiGIg6n3M/iI1jJlzw8pkQ2Pfx6w3GPPKt+JjHOpKofuNXYy9VVZabKuDCs0Qlcj/q5ewJk9D+Ru19TsLHp6Wua02YF7W/f70JTuzCflUQHWy+yXUJ8r9wQZ/LrriJ91PKzmkXeBfPdewRuFwt/iCMm5gYEgjd+24N6WfUAoXv2uQLDhzYj+g4hGK1p8jUos1YHtahIeUrrjh7pD5UlpYxfuvathWjjN8oAzCsAqW+onVUevYmq60ndJhCJ3cwKx47NTvLk3pgji/5cUP6FShGoZryPvmXMLEeNDaKBW19j2NEvCey76x/wbUrZfo6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(55016002)(44832011)(33656002)(7696005)(8936002)(86362001)(110136005)(54906003)(66556008)(66946007)(9686003)(478600001)(2906002)(186003)(66446008)(64756008)(66476007)(52536014)(5660300002)(71200400001)(6506007)(26005)(83380400001)(8676002)(4326008)(316002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wFrhF7BCqn48LvYF2d7JActO8DItA6DJcL0hulBWDkAAei2AGGECGz55cyVzm+6YPk8A1/7h+fsQPtFrWoC/q7TiEmhatm+eYeVslxtHUTEeEoJ9xgkvDBXejEDmsO93g1MdRJ0zzyqWQPv8Y4rg6re8QyMYVc6Q5H+tlu2jNMNNvfYE6RP8vSQNvb4cWK/mLGhYMOWAcr32if3gXmG/rz5QUDZVPoRyBvRk5NrHNZSlGTpP86CZnWWOEbzQDIA4UWrEWgLIRxc1iEfP51R5UTZOQqSN0D2b3DbFSHVIplE4vPxwkExmPW7mdzROcXe6dA5uYtwUtjWv8JSAIyMwqzsDfFULAoz5zAbmn+ezdAkbuagU6GTPJQtQ+VqXqmZCckNFTQh1kLe6YnCGho6irFoWYPloV6znlC3OAnfaMJDXF2CSy0bk+QrY/ijLcuwNE64ZtrNzy5HvuwMXkO3yLJifSs51o8KrOtCpCgbacIFP2LXwWIB0bQFNQGzeHr2f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754c3067-3e46-41fb-2bde-08d806b51913
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 05:23:35.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqbjy5j3V0gqVGr2ay4SGImNUQTFzlWBkjufUzobiSiX1LZ1UUU+vIMei5jAevPf8dRwynpdozvaZPc9Ptg9AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIIDIvNF0gZmlybXdhcmU6IGlteDogYWRkIHJlc291cmNlIG1h
bmFnZW1lbnQgYXBpDQo+IA0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyMywgMjAyMCAzOjAwIFBNDQo+ID4NCj4gPiBBZGQg
cmVzb3VyY2UgbWFuYWdlbWVudCBBUEksIHdoZW4gd2UgaGF2ZSBtdWx0aXBsZSBwYXJ0aXRpb24g
cnVubmluZw0KPiA+IHRvZ2V0aGVyLCByZXNvdXJjZXMgbm90IG93bmVkIHRvIGN1cnJlbnQgcGFy
dGl0aW9uIHNob3VsZCBub3QgYmUgdXNlZC4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBMZW9uYXJk
IENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Zpcm13YXJl
L2lteC9NYWtlZmlsZSAgICAgICB8ICAyICstDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUvaW14L3Jt
LmMgICAgICAgICAgIHwgNDAgKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGlu
dXgvZmlybXdhcmUvaW14L3NjaS5oICAgIHwgIDEgKw0KPiA+ICBpbmNsdWRlL2xpbnV4L2Zpcm13
YXJlL2lteC9zdmMvcm0uaCB8IDY5DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDExMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBkcml2ZXJzL2Zpcm13YXJlL2lteC9ybS5j
ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMv
cm0uaA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxl
DQo+ID4gYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZSBpbmRleCAwOGJjOWRkZmJkZmIu
LjE3ZWEzNjEzZTE0Mg0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvaW14
L01ha2VmaWxlDQo+ID4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvTWFrZWZpbGUNCj4gPiBA
QCAtMSw0ICsxLDQgQEANCj4gPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0K
PiA+ICBvYmotJChDT05GSUdfSU1YX0RTUCkJCSs9IGlteC1kc3Aubw0KPiA+IC1vYmotJChDT05G
SUdfSU1YX1NDVSkJCSs9IGlteC1zY3UubyBtaXNjLm8gaW14LXNjdS1pcnEubw0KPiA+ICtvYmot
JChDT05GSUdfSU1YX1NDVSkJCSs9IGlteC1zY3UubyBtaXNjLm8gaW14LXNjdS1pcnEubyBybS5v
DQo+ID4gIG9iai0kKENPTkZJR19JTVhfU0NVX1BEKQkrPSBzY3UtcGQubw0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9ybS5jIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvcm0u
YyBuZXcNCj4gPiBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uN2IwMzM0ZGU1
NDg2DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvaW14L3Jt
LmMNCj4gPiBAQCAtMCwwICsxLDQwIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wKw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgMjAyMCBOWFANCj4gPiArICoN
Cj4gPiArICogRmlsZSBjb250YWluaW5nIGNsaWVudC1zaWRlIFJQQyBmdW5jdGlvbnMgZm9yIHRo
ZSBSTSBzZXJ2aWNlLg0KPiA+ICtUaGVzZQ0KPiA+ICsgKiBmdW5jdGlvbiBhcmUgcG9ydGVkIHRv
IGNsaWVudHMgdGhhdCBjb21tdW5pY2F0ZSB0byB0aGUgU0MuDQo+ID4gKyAqLw0KPiA+ICsNCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaD4NCj4gPiArDQo+ID4gK3N0
cnVjdCBpbXhfc2NfbXNnX3JtX3JzcmNfb3duZWQgew0KPiA+ICsJc3RydWN0IGlteF9zY19ycGNf
bXNnIGhkcjsNCj4gPiArCXUxNiByZXNvdXJjZTsNCj4gPiArfSBfX3BhY2tlZCBfX2FsaWduZWQo
NCk7DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIGNoZWNrIEByZXNvdXJj
ZSBpcyBvd25lZCBieSBjdXJyZW50IHBhcnRpdGlvbiBvciBub3QNCj4gPiArICoNCj4gPiArICog
QHBhcmFtW2luXSAgICAgaXBjICAgICAgICAgSVBDIGhhbmRsZQ0KPiA+ICsgKiBAcGFyYW1baW5d
ICAgICByZXNvdXJjZSAgICByZXNvdXJjZSB0aGUgY29udHJvbCBpcyBhc3NvY2lhdGVkIHdpdGgN
Cj4gPiArICoNCj4gPiArICogQHJldHVybiBSZXR1cm5zIDAgZm9yIHN1Y2Nlc3MgYW5kIDwgMCBm
b3IgZXJyb3JzLg0KPiA+ICsgKi8NCj4gPiArYm9vbCBpbXhfc2Nfcm1faXNfcmVzb3VyY2Vfb3du
ZWQoc3RydWN0IGlteF9zY19pcGMgKmlwYywgdTE2DQo+ID4gK3Jlc291cmNlKSB7DQo+ID4gKwlz
dHJ1Y3QgaW14X3NjX21zZ19ybV9yc3JjX293bmVkIG1zZzsNCj4gPiArCXN0cnVjdCBpbXhfc2Nf
cnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ID4gKw0KPiA+ICsJaGRyLT52ZXIgPSBJTVhfU0Nf
UlBDX1ZFUlNJT047DQo+ID4gKwloZHItPnN2YyA9IElNWF9TQ19SUENfU1ZDX1JNOw0KPiA+ICsJ
aGRyLT5mdW5jID0gSU1YX1NDX1JNX0ZVTkNfSVNfUkVTT1VSQ0VfT1dORUQ7DQo+ID4gKwloZHIt
PnNpemUgPSAyOw0KPiA+ICsNCj4gPiArCW1zZy5yZXNvdXJjZSA9IHJlc291cmNlOw0KPiA+ICsN
Cj4gPiArCWlteF9zY3VfY2FsbF9ycGMoaXBjLCAmbXNnLCB0cnVlKTsNCj4gDQo+IE5vIG5lZWQg
Y2hlY2sgZXJyIHJldHVybj8NCg0KTm8uIGl0IHVzZSBoZHItPmZ1bmMgYXMgdGhlIHJlc291cmNl
IG93bmVyIGJvb2wuDQpIb3dldmVyIGlteF9zY3VfY2FsbF9ycGMgYWxzbyB1c2UgaGRyLT5mdW5j
DQp0byBjaGVjayBlcnJvciB2YWx1ZSBvciBub3QuDQoNCldoZW4gaGRyLT5mdW5jIGlzIDEsIGlt
eF9zY190b19saW51eF9lcnJubw0Kd2lsbCByZXBvcnQgaXQgLUVJTlZBTC4gSG93ZXZlciBoZXJl
IDEgbWVhbnMNCm5vdCBvd25lZC4NCg0KPiANCj4gPiArDQo+ID4gKwlyZXR1cm4gaGRyLT5mdW5j
Ow0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0woaW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVk
KTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmgNCj4g
PiBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oDQo+ID4gaW5kZXggMTdiYTRlNDA1
MTI5Li5iNWM1YTU2ZjI5YmUgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9maXJtd2Fy
ZS9pbXgvc2NpLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaA0K
PiA+IEBAIC0xNSw2ICsxNSw3IEBADQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJl
L2lteC9zdmMvbWlzYy5oPiAgI2luY2x1ZGUNCj4gPiA8bGludXgvZmlybXdhcmUvaW14L3N2Yy9w
bS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5oPg0KPiA+DQo+
ID4gIGludCBpbXhfc2N1X2VuYWJsZV9nZW5lcmFsX2lycV9jaGFubmVsKHN0cnVjdCBkZXZpY2Ug
KmRldik7ICBpbnQNCj4gPiBpbXhfc2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3Qgbm90
aWZpZXJfYmxvY2sgKm5iKTsgZGlmZiAtLWdpdA0KPiA+IGEvaW5jbHVkZS9saW51eC9maXJtd2Fy
ZS9pbXgvc3ZjL3JtLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5o
DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZjNmVh
NjJkOWQwZQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13
YXJlL2lteC9zdmMvcm0uaA0KPiA+IEBAIC0wLDAgKzEsNjkgQEANCj4gPiArLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAo
QykgMjAxNiBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciwgSW5jLg0KPiA+ICsgKiBDb3B5cmlnaHQg
MjAxNy0yMDE5IE5YUA0KPiANCj4gVXBkYXRlIGNvcHlyaWdodA0KDQpvaw0KDQo+IA0KPiA+ICsg
Kg0KPiA+ICsgKiBIZWFkZXIgZmlsZSBjb250YWluaW5nIHRoZSBwdWJsaWMgQVBJIGZvciB0aGUg
U3lzdGVtIENvbnRyb2xsZXINCj4gPiArKFNDKQ0KPiA+ICsgKiBQb3dlciBNYW5hZ2VtZW50IChQ
TSkgZnVuY3Rpb24uIFRoaXMgaW5jbHVkZXMgZnVuY3Rpb25zIGZvciBwb3dlcg0KPiA+ICtzdGF0
ZQ0KPiA+ICsgKiBjb250cm9sLCBjbG9jayBjb250cm9sLCByZXNldCBjb250cm9sLCBhbmQgd2Fr
ZS11cCBldmVudCBjb250cm9sLg0KPiANCj4gRml4IHRoZSBjb2RlIGNvbW1lbnRzDQo+IA0KPiBP
dGhlcndpc2UsIEknbSBmaW5lIHdpdGggdGhpcyBwYXRjaC4NCk9rLg0KDQpUaGFua3MsDQpQZW5n
Lg0KDQo+IA0KPiBSZWdhcmRzDQo+IEFpc2hlbmcNCj4gDQo+ID4gKyAqDQo+ID4gKyAqIFJNX1NW
QyAoU1ZDKSBSZXNvdXJjZSBNYW5hZ2VtZW50IFNlcnZpY2UNCj4gPiArICoNCj4gPiArICogTW9k
dWxlIGZvciB0aGUgUmVzb3VyY2UgTWFuYWdlbWVudCAoUk0pIHNlcnZpY2UuDQo+ID4gKyAqLw0K
PiA+ICsNCj4gPiArI2lmbmRlZiBfU0NfUk1fQVBJX0gNCj4gPiArI2RlZmluZSBfU0NfUk1fQVBJ
X0gNCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc2NpLmg+DQo+ID4g
Kw0KPiA+ICsvKg0KPiA+ICsgKiBUaGlzIHR5cGUgaXMgdXNlZCB0byBpbmRpY2F0ZSBSUEMgUk0g
ZnVuY3Rpb24gY2FsbHMuDQo+ID4gKyAqLw0KPiA+ICtlbnVtIGlteF9zY19ybV9mdW5jIHsNCj4g
PiArCUlNWF9TQ19STV9GVU5DX1VOS05PV04gPSAwLA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfUEFS
VElUSU9OX0FMTE9DID0gMSwNCj4gPiArCUlNWF9TQ19STV9GVU5DX1NFVF9DT05GSURFTlRJQUwg
PSAzMSwNCj4gPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElPTl9GUkVFID0gMiwNCj4gPiArCUlN
WF9TQ19STV9GVU5DX0dFVF9ESUQgPSAyNiwNCj4gPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElP
Tl9TVEFUSUMgPSAzLA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfUEFSVElUSU9OX0xPQ0sgPSA0LA0K
PiA+ICsJSU1YX1NDX1JNX0ZVTkNfR0VUX1BBUlRJVElPTiA9IDUsDQo+ID4gKwlJTVhfU0NfUk1f
RlVOQ19TRVRfUEFSRU5UID0gNiwNCj4gPiArCUlNWF9TQ19STV9GVU5DX01PVkVfQUxMID0gNywN
Cj4gPiArCUlNWF9TQ19STV9GVU5DX0FTU0lHTl9SRVNPVVJDRSA9IDgsDQo+ID4gKwlJTVhfU0Nf
Uk1fRlVOQ19TRVRfUkVTT1VSQ0VfTU9WQUJMRSA9IDksDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19T
RVRfU1VCU1lTX1JTUkNfTU9WQUJMRSA9IDI4LA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX01B
U1RFUl9BVFRSSUJVVEVTID0gMTAsDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfTUFTVEVSX1NJ
RCA9IDExLA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX1BFUklQSEVSQUxfUEVSTUlTU0lPTlMg
PSAxMiwNCj4gPiArCUlNWF9TQ19STV9GVU5DX0lTX1JFU09VUkNFX09XTkVEID0gMTMsDQo+ID4g
KwlJTVhfU0NfUk1fRlVOQ19HRVRfUkVTT1VSQ0VfT1dORVIgPSAzMywNCj4gPiArCUlNWF9TQ19S
TV9GVU5DX0lTX1JFU09VUkNFX01BU1RFUiA9IDE0LA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfSVNf
UkVTT1VSQ0VfUEVSSVBIRVJBTCA9IDE1LA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfR0VUX1JFU09V
UkNFX0lORk8gPSAxNiwNCj4gPiArCUlNWF9TQ19STV9GVU5DX01FTVJFR19BTExPQyA9IDE3LA0K
PiA+ICsJSU1YX1NDX1JNX0ZVTkNfTUVNUkVHX1NQTElUID0gMjksDQo+ID4gKwlJTVhfU0NfUk1f
RlVOQ19NRU1SRUdfRlJBRyA9IDMyLA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfTUVNUkVHX0ZSRUUg
PSAxOCwNCj4gPiArCUlNWF9TQ19STV9GVU5DX0ZJTkRfTUVNUkVHID0gMzAsDQo+ID4gKwlJTVhf
U0NfUk1fRlVOQ19BU1NJR05fTUVNUkVHID0gMTksDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRf
TUVNUkVHX1BFUk1JU1NJT05TID0gMjAsDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19JU19NRU1SRUdf
T1dORUQgPSAyMSwNCj4gPiArCUlNWF9TQ19STV9GVU5DX0dFVF9NRU1SRUdfSU5GTyA9IDIyLA0K
PiA+ICsJSU1YX1NDX1JNX0ZVTkNfQVNTSUdOX1BBRCA9IDIzLA0KPiA+ICsJSU1YX1NDX1JNX0ZV
TkNfU0VUX1BBRF9NT1ZBQkxFID0gMjQsDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19JU19QQURfT1dO
RUQgPSAyNSwNCj4gPiArCUlNWF9TQ19STV9GVU5DX0RVTVAgPSAyNywNCj4gPiArfTsNCj4gPiAr
DQo+ID4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19JTVhfU0NVKQ0KPiA+ICtib29sIGlteF9zY19y
bV9pc19yZXNvdXJjZV9vd25lZChzdHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB1MTYNCj4gPiArcmVz
b3VyY2UpOyAjZWxzZSBzdGF0aWMgaW5saW5lIGJvb2wNCj4gPiAraW14X3NjX3JtX2lzX3Jlc291
cmNlX293bmVkKHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHUxNiByZXNvdXJjZSkgew0KPiA+ICsJ
cmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gKyNlbmRpZg0KPiA+IC0tDQo+
ID4gMi4xNi40DQoNCg==
