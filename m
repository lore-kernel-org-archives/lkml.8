Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E67C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E6820671
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CSfth0hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgFBDHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 23:07:53 -0400
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:31830
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbgFBDHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 23:07:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHB8lB+2ein6oGe+MwWAjDJExmELOqk4/ZZdfMXoeXy1Rn0GcEo4y5oCqV/Boykz5M1CixesNVnMfazP+DJYYbKIHqgNP95VZSFU2VPkwP/A+EoA2OzMtQQvHIs/HBR1bGhu7DhRlkIBpn+2/71yKfanEVRdD5LsGgAw1ic7wxAb0igSe6gi9hPrc6SryJ/MShZL9tvJl2fBiVLpqb4A/Wq9HMO+1etwXMdwSXnXVJp4Xm9mMp1WSU9w50qgyT6KcKcZiiNUNVC2E051ghbvBOvtDmnWRSF3h/1KE4vlJCzzQAUAUIsghfrxlMW5+fBASciTXbg5bk5TBf21lal04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqY5ko8V9grjIDzG6nssN5vJUeB9aJb0cBX65tiRakw=;
 b=GlTo2AN+iPz9rWzMdQAKWModqm+cXeuAqLDfHRFX9P9lhq4p115SLZoy/ERg5+0ziXTR0cZWQDoW9IajU/vVHONjaIpc6YTxUMcG0ZnKVUAFI4ut4ZDwyWj/o/uvRDIpchxptvPLI+Q1LPe+9oed1J9x+0TemuOPNOtj3be/A7Yf+ed05lUQOuznRZrEXngYmB203WMeoaN7nvxaAabEVfgSbEaYkMvDHSgN/MijmT17ro3uX1We3MPQB4K45XhALAyXtxyYez/R6foGLkkm3Cq72X4uvyM/+7L0y2L6kc1ZQZoOZFPPYn8fGXBUFZ0UZ75EfTY+Ee9fF3I4beTGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqY5ko8V9grjIDzG6nssN5vJUeB9aJb0cBX65tiRakw=;
 b=CSfth0hO9mhRtU1OiNkd7ILtVEXp1PEsWzwpWNzbgRKHlPezeUrdjJI1Kd3dBL4VBQMbvZfhnD3WQgazH02rfUJd8XdAeb6c2ASAo8IJv2Cnsuohw8PM9k9bRj//tomuYNd+MsWlgNmtkB7gP1nz1xvPT7N26jpTLnDhO2YQfj4=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5783.eurprd04.prod.outlook.com (2603:10a6:20b:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 03:07:47 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 03:07:47 +0000
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
Subject: RE: [PATCH 2/4] firmware: imx: add resource management api
Thread-Topic: [PATCH 2/4] firmware: imx: add resource management api
Thread-Index: AQHWGT38Z8g88FkqQ0uX8uLlRjqzhqjE34aA
Date:   Tue, 2 Jun 2020 03:07:47 +0000
Message-ID: <AM6PR04MB4966DA95F44FA63CDEF7E4F5808B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
 <1587625174-32668-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1587625174-32668-3-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5052df4-acad-4a58-eb11-08d806a2207f
x-ms-traffictypediagnostic: AM6PR04MB5783:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB578302D88CCE142B9320F514808B0@AM6PR04MB5783.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AHANmImsijAb/e9uBN9/hzXun1o15yQMAJ0Uf28aH5YSjrU6MQRjxIhrT+FTWU8OYaORH2naGeYm7s6NcUhaRdm0rzAd/kT6IRsZsBvbCcs08LTld3+0YC+hkzahfEgdt6fOdi9i6mSD3DV+v3b/Mwcw+kKsFw7uBushRbbgl5vt5fjZXZQMF7ubRXdKahozfdek2WvmYlFgOaSf+zlVslGHi+ypM9qTCp3PfSCbHc+F9pfVk1J0nWjTtSNpjdkNwvdmHfGvRz8VcRMMCTytDubb/RJ4T7mxu6pet1LZpH2NuvO8EM3cwT/gJpk2AD8ReOfy8tHOJ/Ok6fcX8Ayxfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(5660300002)(66556008)(76116006)(7696005)(8936002)(6506007)(86362001)(66946007)(66476007)(186003)(26005)(64756008)(33656002)(8676002)(66446008)(44832011)(52536014)(4326008)(478600001)(71200400001)(2906002)(83380400001)(316002)(9686003)(55016002)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: W3KHyhypOO4cpwh8wrcsRmlIsCstD97vadwEtkUDCuNO+4kgg13vSo+1IRe9ZYqxXrhm00a2FBoptbjGUeKuhAfBehZw2t+Qi6fFr/xC/c0HTKnNGrUGcgHCdxw3ttjBanyWzJ1BpMck5E3M2Wtx67pFwFVLVfgtxoFOwtYhyhiiSwH8BaJg5Tnnl5hXXLnxSxqo7faxy01x5HkZtmpHWSXRs+PaWc6uUx1VDPnJsZODw9ezxpvUUfqf9CEiRK/nh4oefhXGfplHnziyQYMpJEVSLBoH6VDT9PV4tzVeWzAoNI3dS3+X4YDMYRGTyg0PtX1oqBgimceKekVq+9v59OgWiBJ6PtUsBVMKVdIgPJJ+k3bYhuJU7zjMorsXCFnXIIKKy6xI3uYsSEKqsgG1bbvaK0zLOo9uEYEV+Mxd2pCX3YH4a04F+5ilzwCQWPpTjQa6ZKZK0OUhFuPNvDLE+c/UFL0joUgM+m7QprOH8v8paFkWvpgJaZD59fZNpG09
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5052df4-acad-4a58-eb11-08d806a2207f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 03:07:47.1618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+aNPa67J+Lu0vCNI+fLs2+pKOqba8sr5JIK2LCBix7hdffSWkdy2aP3eiQ+/4mbapMtSCe8e2V7PLz7eQ1u9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5783
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFw
cmlsIDIzLCAyMDIwIDM6MDAgUE0NCj4gDQo+IEFkZCByZXNvdXJjZSBtYW5hZ2VtZW50IEFQSSwg
d2hlbiB3ZSBoYXZlIG11bHRpcGxlIHBhcnRpdGlvbiBydW5uaW5nDQo+IHRvZ2V0aGVyLCByZXNv
dXJjZXMgbm90IG93bmVkIHRvIGN1cnJlbnQgcGFydGl0aW9uIHNob3VsZCBub3QgYmUgdXNlZC4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZSAgICAgICB8ICAyICstDQo+ICBkcml2
ZXJzL2Zpcm13YXJlL2lteC9ybS5jICAgICAgICAgICB8IDQwICsrKysrKysrKysrKysrKysrKysr
Kw0KPiAgaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmggICAgfCAgMSArDQo+ICBpbmNs
dWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaCB8IDY5DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBkcml2ZXJzL2Zpcm13YXJl
L2lteC9ybS5jICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gaW5jbHVkZS9saW51eC9maXJtd2FyZS9p
bXgvc3ZjL3JtLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtl
ZmlsZSBiL2RyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxlDQo+IGluZGV4IDA4YmM5ZGRmYmRm
Yi4uMTdlYTM2MTNlMTQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtl
ZmlsZQ0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZQ0KPiBAQCAtMSw0ICsx
LDQgQEANCj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gIG9iai0kKENP
TkZJR19JTVhfRFNQKQkJKz0gaW14LWRzcC5vDQo+IC1vYmotJChDT05GSUdfSU1YX1NDVSkJCSs9
IGlteC1zY3UubyBtaXNjLm8gaW14LXNjdS1pcnEubw0KPiArb2JqLSQoQ09ORklHX0lNWF9TQ1Up
CQkrPSBpbXgtc2N1Lm8gbWlzYy5vIGlteC1zY3UtaXJxLm8gcm0ubw0KPiAgb2JqLSQoQ09ORklH
X0lNWF9TQ1VfUEQpCSs9IHNjdS1wZC5vDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJl
L2lteC9ybS5jIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvcm0uYyBuZXcgZmlsZQ0KPiBtb2RlIDEw
MDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLjdiMDMzNGRlNTQ4Ng0KPiAtLS0gL2Rldi9udWxsDQo+
ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvaW14L3JtLmMNCj4gQEAgLTAsMCArMSw0MCBAQA0KPiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ICsvKg0KPiArICogQ29weXJp
Z2h0IDIwMjAgTlhQDQo+ICsgKg0KPiArICogRmlsZSBjb250YWluaW5nIGNsaWVudC1zaWRlIFJQ
QyBmdW5jdGlvbnMgZm9yIHRoZSBSTSBzZXJ2aWNlLiBUaGVzZQ0KPiArICogZnVuY3Rpb24gYXJl
IHBvcnRlZCB0byBjbGllbnRzIHRoYXQgY29tbXVuaWNhdGUgdG8gdGhlIFNDLg0KPiArICovDQo+
ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL3JtLmg+DQo+ICsNCj4gK3N0
cnVjdCBpbXhfc2NfbXNnX3JtX3JzcmNfb3duZWQgew0KPiArCXN0cnVjdCBpbXhfc2NfcnBjX21z
ZyBoZHI7DQo+ICsJdTE2IHJlc291cmNlOw0KPiArfSBfX3BhY2tlZCBfX2FsaWduZWQoNCk7DQo+
ICsNCj4gKy8qDQo+ICsgKiBUaGlzIGZ1bmN0aW9uIGNoZWNrIEByZXNvdXJjZSBpcyBvd25lZCBi
eSBjdXJyZW50IHBhcnRpdGlvbiBvciBub3QNCj4gKyAqDQo+ICsgKiBAcGFyYW1baW5dICAgICBp
cGMgICAgICAgICBJUEMgaGFuZGxlDQo+ICsgKiBAcGFyYW1baW5dICAgICByZXNvdXJjZSAgICBy
ZXNvdXJjZSB0aGUgY29udHJvbCBpcyBhc3NvY2lhdGVkIHdpdGgNCj4gKyAqDQo+ICsgKiBAcmV0
dXJuIFJldHVybnMgMCBmb3Igc3VjY2VzcyBhbmQgPCAwIGZvciBlcnJvcnMuDQo+ICsgKi8NCj4g
K2Jvb2wgaW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKHN0cnVjdCBpbXhfc2NfaXBjICppcGMs
IHUxNiByZXNvdXJjZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgaW14X3NjX21zZ19ybV9yc3JjX293bmVk
IG1zZzsNCj4gKwlzdHJ1Y3QgaW14X3NjX3JwY19tc2cgKmhkciA9ICZtc2cuaGRyOw0KPiArDQo+
ICsJaGRyLT52ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJT047DQo+ICsJaGRyLT5zdmMgPSBJTVhfU0Nf
UlBDX1NWQ19STTsNCj4gKwloZHItPmZ1bmMgPSBJTVhfU0NfUk1fRlVOQ19JU19SRVNPVVJDRV9P
V05FRDsNCj4gKwloZHItPnNpemUgPSAyOw0KPiArDQo+ICsJbXNnLnJlc291cmNlID0gcmVzb3Vy
Y2U7DQo+ICsNCj4gKwlpbXhfc2N1X2NhbGxfcnBjKGlwYywgJm1zZywgdHJ1ZSk7DQoNCk5vIG5l
ZWQgY2hlY2sgZXJyIHJldHVybj8NCg0KPiArDQo+ICsJcmV0dXJuIGhkci0+ZnVuYzsNCj4gK30N
Cj4gK0VYUE9SVF9TWU1CT0woaW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKTsNCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oIGIvaW5jbHVkZS9saW51eC9m
aXJtd2FyZS9pbXgvc2NpLmgNCj4gaW5kZXggMTdiYTRlNDA1MTI5Li5iNWM1YTU2ZjI5YmUgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oDQo+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oDQo+IEBAIC0xNSw2ICsxNSw3IEBADQo+IA0K
PiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zdmMvbWlzYy5oPiAgI2luY2x1ZGUNCj4g
PGxpbnV4L2Zpcm13YXJlL2lteC9zdmMvcG0uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2Fy
ZS9pbXgvc3ZjL3JtLmg+DQo+IA0KPiAgaW50IGlteF9zY3VfZW5hYmxlX2dlbmVyYWxfaXJxX2No
YW5uZWwoc3RydWN0IGRldmljZSAqZGV2KTsgIGludA0KPiBpbXhfc2N1X2lycV9yZWdpc3Rlcl9u
b3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKTsgZGlmZiAtLWdpdA0KPiBhL2luY2x1
ZGUvbGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5oIGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9p
bXgvc3ZjL3JtLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAw
Li5mYzZlYTYyZDlkMGUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zp
cm13YXJlL2lteC9zdmMvcm0uaA0KPiBAQCAtMCwwICsxLDY5IEBADQo+ICsvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMCsgKi8NCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIw
MTYgRnJlZXNjYWxlIFNlbWljb25kdWN0b3IsIEluYy4NCj4gKyAqIENvcHlyaWdodCAyMDE3LTIw
MTkgTlhQDQoNClVwZGF0ZSBjb3B5cmlnaHQNCg0KPiArICoNCj4gKyAqIEhlYWRlciBmaWxlIGNv
bnRhaW5pbmcgdGhlIHB1YmxpYyBBUEkgZm9yIHRoZSBTeXN0ZW0gQ29udHJvbGxlciAoU0MpDQo+
ICsgKiBQb3dlciBNYW5hZ2VtZW50IChQTSkgZnVuY3Rpb24uIFRoaXMgaW5jbHVkZXMgZnVuY3Rp
b25zIGZvciBwb3dlcg0KPiArc3RhdGUNCj4gKyAqIGNvbnRyb2wsIGNsb2NrIGNvbnRyb2wsIHJl
c2V0IGNvbnRyb2wsIGFuZCB3YWtlLXVwIGV2ZW50IGNvbnRyb2wuDQoNCkZpeCB0aGUgY29kZSBj
b21tZW50cw0KDQpPdGhlcndpc2UsIEknbSBmaW5lIHdpdGggdGhpcyBwYXRjaC4NCg0KUmVnYXJk
cw0KQWlzaGVuZw0KDQo+ICsgKg0KPiArICogUk1fU1ZDIChTVkMpIFJlc291cmNlIE1hbmFnZW1l
bnQgU2VydmljZQ0KPiArICoNCj4gKyAqIE1vZHVsZSBmb3IgdGhlIFJlc291cmNlIE1hbmFnZW1l
bnQgKFJNKSBzZXJ2aWNlLg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYgX1NDX1JNX0FQSV9IDQo+
ICsjZGVmaW5lIF9TQ19STV9BUElfSA0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgvZmlybXdhcmUv
aW14L3NjaS5oPg0KPiArDQo+ICsvKg0KPiArICogVGhpcyB0eXBlIGlzIHVzZWQgdG8gaW5kaWNh
dGUgUlBDIFJNIGZ1bmN0aW9uIGNhbGxzLg0KPiArICovDQo+ICtlbnVtIGlteF9zY19ybV9mdW5j
IHsNCj4gKwlJTVhfU0NfUk1fRlVOQ19VTktOT1dOID0gMCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19Q
QVJUSVRJT05fQUxMT0MgPSAxLA0KPiArCUlNWF9TQ19STV9GVU5DX1NFVF9DT05GSURFTlRJQUwg
PSAzMSwNCj4gKwlJTVhfU0NfUk1fRlVOQ19QQVJUSVRJT05fRlJFRSA9IDIsDQo+ICsJSU1YX1ND
X1JNX0ZVTkNfR0VUX0RJRCA9IDI2LA0KPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElPTl9TVEFU
SUMgPSAzLA0KPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElPTl9MT0NLID0gNCwNCj4gKwlJTVhf
U0NfUk1fRlVOQ19HRVRfUEFSVElUSU9OID0gNSwNCj4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfUEFS
RU5UID0gNiwNCj4gKwlJTVhfU0NfUk1fRlVOQ19NT1ZFX0FMTCA9IDcsDQo+ICsJSU1YX1NDX1JN
X0ZVTkNfQVNTSUdOX1JFU09VUkNFID0gOCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfUkVTT1VS
Q0VfTU9WQUJMRSA9IDksDQo+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX1NVQlNZU19SU1JDX01PVkFC
TEUgPSAyOCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfTUFTVEVSX0FUVFJJQlVURVMgPSAxMCwN
Cj4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfTUFTVEVSX1NJRCA9IDExLA0KPiArCUlNWF9TQ19STV9G
VU5DX1NFVF9QRVJJUEhFUkFMX1BFUk1JU1NJT05TID0gMTIsDQo+ICsJSU1YX1NDX1JNX0ZVTkNf
SVNfUkVTT1VSQ0VfT1dORUQgPSAxMywNCj4gKwlJTVhfU0NfUk1fRlVOQ19HRVRfUkVTT1VSQ0Vf
T1dORVIgPSAzMywNCj4gKwlJTVhfU0NfUk1fRlVOQ19JU19SRVNPVVJDRV9NQVNURVIgPSAxNCwN
Cj4gKwlJTVhfU0NfUk1fRlVOQ19JU19SRVNPVVJDRV9QRVJJUEhFUkFMID0gMTUsDQo+ICsJSU1Y
X1NDX1JNX0ZVTkNfR0VUX1JFU09VUkNFX0lORk8gPSAxNiwNCj4gKwlJTVhfU0NfUk1fRlVOQ19N
RU1SRUdfQUxMT0MgPSAxNywNCj4gKwlJTVhfU0NfUk1fRlVOQ19NRU1SRUdfU1BMSVQgPSAyOSwN
Cj4gKwlJTVhfU0NfUk1fRlVOQ19NRU1SRUdfRlJBRyA9IDMyLA0KPiArCUlNWF9TQ19STV9GVU5D
X01FTVJFR19GUkVFID0gMTgsDQo+ICsJSU1YX1NDX1JNX0ZVTkNfRklORF9NRU1SRUcgPSAzMCwN
Cj4gKwlJTVhfU0NfUk1fRlVOQ19BU1NJR05fTUVNUkVHID0gMTksDQo+ICsJSU1YX1NDX1JNX0ZV
TkNfU0VUX01FTVJFR19QRVJNSVNTSU9OUyA9IDIwLA0KPiArCUlNWF9TQ19STV9GVU5DX0lTX01F
TVJFR19PV05FRCA9IDIxLA0KPiArCUlNWF9TQ19STV9GVU5DX0dFVF9NRU1SRUdfSU5GTyA9IDIy
LA0KPiArCUlNWF9TQ19STV9GVU5DX0FTU0lHTl9QQUQgPSAyMywNCj4gKwlJTVhfU0NfUk1fRlVO
Q19TRVRfUEFEX01PVkFCTEUgPSAyNCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19JU19QQURfT1dORUQg
PSAyNSwNCj4gKwlJTVhfU0NfUk1fRlVOQ19EVU1QID0gMjcsDQo+ICt9Ow0KPiArDQo+ICsjaWYg
SVNfRU5BQkxFRChDT05GSUdfSU1YX1NDVSkNCj4gK2Jvb2wgaW14X3NjX3JtX2lzX3Jlc291cmNl
X293bmVkKHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHUxNiByZXNvdXJjZSk7DQo+ICsjZWxzZSBz
dGF0aWMgaW5saW5lIGJvb2wgaW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKHN0cnVjdCBpbXhf
c2NfaXBjDQo+ICsqaXBjLCB1MTYgcmVzb3VyY2UpIHsNCj4gKwlyZXR1cm4gdHJ1ZTsNCj4gK30N
Cj4gKyNlbmRpZg0KPiArI2VuZGlmDQo+IC0tDQo+IDIuMTYuNA0KDQo=
