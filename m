Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB7CC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7264922BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nde3Vt9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgGTN6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:58:31 -0400
Received: from mail-eopbgr700042.outbound.protection.outlook.com ([40.107.70.42]:32385
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbgGTN6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:58:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iszuE3pAHUSFfV/IHFTeLUKS04DwSasKSbuy7ggLDKCJ+xy9eIQ2oDf1x/KifxmioDCCSrYJUAFZGHEdMLVhBY3F0LhqexODE0uKmLEw40u/Pq8mqF0/QoPplaC7x8Fu5YHVpH6VH4MxmiE1U+tng3fFL2lHxprmbuI7S4jLaCvRB/AHEhL5u1lCL9rSJb0naWuNoG/+A9YlSn17UO3oP3AbT1iKO0NiSUZPyChnFPFIaiI8vu3FWYv1H1P1OOimg8p2ZAeIIYmhC9TPtZmFgAAfvXRcFKlG5348wdPyPaSmcqyLM4PqcklUg85sQvRfXlYNrfE65pSEU6FOkbOj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpbTcpGch/Pp0eMXCVEpVU/KPU+6rms8Rvp3PyUnU78=;
 b=Ueq4FWIgCze2tWHHAKWgpAg9fPnZRvUJjUZPYiQZkWGVOhnsWuqi+z5hTGDWnCds1k6KWa6wA5yXazQJmX/WxLsa7G8PuC69OIrx+oN0BSMRAituaeTzSBc7cq30QjTKNNgL6/95qcH3PVtKY6lFBAqvnUK6u/X2oysgUKTjs5f/zyxOr2v19qf3UqihPpc/BOp3FaNhtzJrQXQ2DG49aNx4tSPMTp5cIeV3JwQljFSSEU6if6CZKIbrmNMb+5Y4nk6lxk4fFDEcW1ews/uKfvbciV24lM7vgvsvutuuLqPPHoCZhDfnpWjvl038hmsMeTO45GwfaoYlEqTQroX62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpbTcpGch/Pp0eMXCVEpVU/KPU+6rms8Rvp3PyUnU78=;
 b=nde3Vt9vbKEbqMOsddQFI6C1prcixwXH9jJrCBr/E/RhqkT4g57+AN5ZTImR54/B5TsW2kR+MZOo2iaiWfRybOLKaCFBPyMWi9cosjV+wTKoPqkSUIWM8Ifp/KubzTdvhoQC6VhjZplMS0GNHMlDI+eKKWB2HejQIqxm9FNSsGE=
Received: from BYAPR02MB5815.namprd02.prod.outlook.com (2603:10b6:a03:121::14)
 by BY5PR02MB6657.namprd02.prod.outlook.com (2603:10b6:a03:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 13:58:26 +0000
Received: from BYAPR02MB5815.namprd02.prod.outlook.com
 ([fe80::45b2:efce:265c:bc38]) by BYAPR02MB5815.namprd02.prod.outlook.com
 ([fe80::45b2:efce:265c:bc38%5]) with mapi id 15.20.3174.026; Mon, 20 Jul 2020
 13:58:25 +0000
From:   Sai Krishna Potthuri <lakshmis@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
Subject: RE: [PATCH 2/2] reset: reset-zynqmp: Added support for Versal
 platform
Thread-Topic: [PATCH 2/2] reset: reset-zynqmp: Added support for Versal
 platform
Thread-Index: AQHWWagTZ0brXQkbj0WpuNYIoMTEN6kQQnKAgAAxv8A=
Date:   Mon, 20 Jul 2020 13:58:25 +0000
Message-ID: <BYAPR02MB581507D07FBE0C8D2672A53EBD7B0@BYAPR02MB5815.namprd02.prod.outlook.com>
References: <1594708149-29944-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
         <1594708149-29944-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <b1073a020623a5bda99c74d3b424a498d59b9ec3.camel@pengutronix.de>
In-Reply-To: <b1073a020623a5bda99c74d3b424a498d59b9ec3.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54930a94-4dca-49aa-62d0-08d82cb4f909
x-ms-traffictypediagnostic: BY5PR02MB6657:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB66574B8FE5085BAD2E7DD015BD7B0@BY5PR02MB6657.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQBZyTPG2Gbn8lwxEFkBasd1sdQGhv8EZauGNAQs4HTXwx1dV+FUtBrAElGVfj0fg20VvQ1KUN1ELisLwnLdQhxDMhwMDuC9QPSbB0u0gCGstiEn8ZgqGiAb0VlC7C0kA2bTCmLr1PNVq5nPkDv8aK+iT89/gNjhqJwQpscQ/DznH4FbdDpGoqJmpIMdah+OSQUGHgc3AE33F538ZsmgT49uZGg1HC/2+iy5Uh0e3F0zL7RKcrzqq10i+znllMYalVtB7wz09A6NUmeY/+IOyk+9s6q1FBLzVNqO8ydJILTJncKsvgNHMcmINVSsZxeihOyzLDmz/YlrSmPm4Wid4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5815.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(366004)(376002)(39860400002)(136003)(83380400001)(7696005)(4326008)(71200400001)(55016002)(9686003)(8936002)(66946007)(33656002)(66446008)(66556008)(76116006)(86362001)(2906002)(316002)(5660300002)(6636002)(8676002)(52536014)(186003)(54906003)(6506007)(110136005)(53546011)(478600001)(66476007)(64756008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xSbPZfROHrknGi/ezrUnwjCrDuAhnBWfcLb2nmeZVDfkCSpmIFsEgHgs9p18Yv/NCJ8dcCoo3EJifMsqyfEc2DSQm458ZERuOOlIY3mxeoKj7Q/8zqhxItUmGXaRXEbuFdf1mGzttCA5e1Jkm5E2wroq/1AZs4zZwFrWq0yyK5ZHkVoyc12yHY4WJcHPJOXZags4mOJ9H45RnCZDgbmkhiI2GJgS1QiXWunOCiz8g+LwDR/LsXLrKip8a7EM+Er+iVw/z2adWq9TTBLmptxsaXOcMO/ve+PBaDpjiHcDl0zRkni4UTRWCk8R8ObYM2/0Xod4iTjk2ebhC4dJf/XoRGCSSmMf3cwmv2JGuKj09A8u9J+9d8nkwfkrIQOuIzprkFI49Kv73G6+TKucDPCQyXLLVufBRKuuI91vqAds9g1/IGLkozKG8lBfFlVyU6yGPJqsQ/yWTTVYwEVRNg1w+/fUT2rXNAm3tzZ17UK4pDkB3xbX00YAxt8uoldczDbW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5815.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54930a94-4dca-49aa-62d0-08d82cb4f909
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 13:58:25.6032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgof2YuLLhH8EKF3ZF7FE26cA1Yi42xvLdD9gcsyU1lzRQC9SrfXwdQyQbvVDgmmTPKrYyhyZGVZZvbkVdSHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcCwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXgu
ZGU+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAyMCwgMjAyMCAzOjE4IFBNDQo+IFRvOiBTYWkgS3Jp
c2huYSBQb3R0aHVyaSA8bGFrc2htaXNAeGlsaW54LmNvbT47IFJvYiBIZXJyaW5nDQo+IDxyb2Jo
K2R0QGtlcm5lbC5vcmc+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT4NCj4gQ2M6
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBnaXQgPGdpdEB4aWxp
bnguY29tPjsgc2Fpa3Jpc2huYTEyNDY4QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDIvMl0gcmVzZXQ6IHJlc2V0LXp5bnFtcDogQWRkZWQgc3VwcG9ydCBmb3IgVmVyc2FsDQo+IHBs
YXRmb3JtDQo+IA0KPiBPbiBUdWUsIDIwMjAtMDctMTQgYXQgMTE6NTkgKzA1MzAsIFNhaSBLcmlz
aG5hIFBvdHRodXJpIHdyb3RlOg0KPiA+IFVwZGF0ZWQgdGhlIHJlc2V0IGRyaXZlciB0byBzdXBw
b3J0IFZlcnNhbCBwbGF0Zm9ybS4NCj4gPiBBcyBwYXJ0IG9mIGFkZGluZyBWZXJzYWwgc3VwcG9y
dA0KPiA+IC0gQWRkZWQgVmVyc2FsIHNwZWNpZmljIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+IC0g
UmVzZXQgSWQgYW5kIG51bWJlciBvZiByZXNldHMgYXJlIGRpZmZlcmVudCBmb3IgVmVyc2FsIGFu
ZCBaeW5xTVAsDQo+ID4gaGVuY2UgdGFrZW4gY2FyZSBvZiB0aGVzZSB0d28gYmFzZWQgb24gY29t
cGF0aWJsZSBzdHJpbmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWkgS3Jpc2huYSBQb3R0
aHVyaQ0KPiA+IDxsYWtzaG1pLnNhaS5rcmlzaG5hLnBvdHRodXJpQHhpbGlueC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvcmVzZXQvcmVzZXQtenlucW1wLmMgfCAyNCArKysrKysrKysrKysr
KysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC16eW5x
bXAuYw0KPiA+IGIvZHJpdmVycy9yZXNldC9yZXNldC16eW5xbXAuYyBpbmRleCAzNzNlYThkNGY3
YTEuLjE3YWE0NTMyZWM1ZQ0KPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0
LXp5bnFtcC5jDQo+ID4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC16eW5xbXAuYw0KPiA+IEBA
IC0xMiw5ICsxMiwxMSBAQA0KPiA+DQo+ID4gICNkZWZpbmUgWllOUU1QX05SX1JFU0VUUyAoWllO
UU1QX1BNX1JFU0VUX0VORCAtDQo+ID4gWllOUU1QX1BNX1JFU0VUX1NUQVJUKSAgI2RlZmluZSBa
WU5RTVBfUkVTRVRfSUQNCj4gWllOUU1QX1BNX1JFU0VUX1NUQVJUDQo+ID4gKyNkZWZpbmUgVkVS
U0FMX05SX1JFU0VUUwk5NQ0KPiA+DQo+ID4gIHN0cnVjdCB6eW5xbXBfcmVzZXRfZGF0YSB7DQo+
ID4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgcmNkZXY7DQo+ID4gKwl1MzIgcmVzZXRf
aWQ7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSBzdHJ1Y3QgenlucW1wX3Jlc2V0
X2RhdGEgKiBAQCAtMjYsMjMgKzI4LDI4IEBADQo+ID4gdG9fenlucW1wX3Jlc2V0X2RhdGEoc3Ry
dWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldikgIHN0YXRpYyBpbnQNCj4gPiB6eW5xbXBf
cmVzZXRfYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4gIAkJ
CSAgICAgICB1bnNpZ25lZCBsb25nIGlkKQ0KPiA+ICB7DQo+ID4gLQlyZXR1cm4genlucW1wX3Bt
X3Jlc2V0X2Fzc2VydChaWU5RTVBfUkVTRVRfSUQgKyBpZCwNCj4gPiArCXN0cnVjdCB6eW5xbXBf
cmVzZXRfZGF0YSAqcHJpdiA9IHRvX3p5bnFtcF9yZXNldF9kYXRhKHJjZGV2KTsNCj4gPiArDQo+
ID4gKwlyZXR1cm4genlucW1wX3BtX3Jlc2V0X2Fzc2VydChwcml2LT5yZXNldF9pZCArIGlkLA0K
PiA+ICAJCQkJICAgICAgUE1fUkVTRVRfQUNUSU9OX0FTU0VSVCk7DQo+ID4gIH0NCj4gPg0KPiA+
ICBzdGF0aWMgaW50IHp5bnFtcF9yZXNldF9kZWFzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxl
cl9kZXYgKnJjZGV2LA0KPiA+ICAJCQkJIHVuc2lnbmVkIGxvbmcgaWQpDQo+ID4gIHsNCj4gPiAt
CXJldHVybiB6eW5xbXBfcG1fcmVzZXRfYXNzZXJ0KFpZTlFNUF9SRVNFVF9JRCArIGlkLA0KPiA+
ICsJc3RydWN0IHp5bnFtcF9yZXNldF9kYXRhICpwcml2ID0gdG9fenlucW1wX3Jlc2V0X2RhdGEo
cmNkZXYpOw0KPiA+ICsNCj4gPiArCXJldHVybiB6eW5xbXBfcG1fcmVzZXRfYXNzZXJ0KHByaXYt
PnJlc2V0X2lkICsgaWQsDQo+ID4gIAkJCQkgICAgICBQTV9SRVNFVF9BQ1RJT05fUkVMRUFTRSk7
DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgaW50IHp5bnFtcF9yZXNldF9zdGF0dXMoc3RydWN0
IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPiAgCQkJICAgICAgIHVuc2lnbmVkIGxv
bmcgaWQpDQo+ID4gIHsNCj4gPiArCXN0cnVjdCB6eW5xbXBfcmVzZXRfZGF0YSAqcHJpdiA9IHRv
X3p5bnFtcF9yZXNldF9kYXRhKHJjZGV2KTsNCj4gPiAgCWludCB2YWwsIGVycjsNCj4gPg0KPiA+
IC0JZXJyID0genlucW1wX3BtX3Jlc2V0X2dldF9zdGF0dXMoWllOUU1QX1JFU0VUX0lEICsgaWQs
ICZ2YWwpOw0KPiA+ICsJZXJyID0genlucW1wX3BtX3Jlc2V0X2dldF9zdGF0dXMocHJpdi0+cmVz
ZXRfaWQgKyBpZCwgJnZhbCk7DQo+ID4gIAlpZiAoZXJyKQ0KPiA+ICAJCXJldHVybiBlcnI7DQo+
ID4NCj4gPiBAQCAtNTIsNyArNTksOSBAQCBzdGF0aWMgaW50IHp5bnFtcF9yZXNldF9zdGF0dXMo
c3RydWN0DQo+ID4gcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LCAgc3RhdGljIGludCB6eW5x
bXBfcmVzZXRfcmVzZXQoc3RydWN0DQo+IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4g
PiAgCQkJICAgICAgdW5zaWduZWQgbG9uZyBpZCkNCj4gPiAgew0KPiA+IC0JcmV0dXJuIHp5bnFt
cF9wbV9yZXNldF9hc3NlcnQoWllOUU1QX1JFU0VUX0lEICsgaWQsDQo+ID4gKwlzdHJ1Y3Qgenlu
cW1wX3Jlc2V0X2RhdGEgKnByaXYgPSB0b196eW5xbXBfcmVzZXRfZGF0YShyY2Rldik7DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIHp5bnFtcF9wbV9yZXNldF9hc3NlcnQocHJpdi0+cmVzZXRfaWQgKyBp
ZCwNCj4gPiAgCQkJCSAgICAgIFBNX1JFU0VUX0FDVElPTl9QVUxTRSk7DQo+ID4gIH0NCj4gPg0K
PiA+IEBAIC03NiwxMyArODUsMjAgQEAgc3RhdGljIGludCB6eW5xbXBfcmVzZXRfcHJvYmUoc3Ry
dWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXByaXYtPnJjZGV2Lm9wcyA9ICZ6
eW5xbXBfcmVzZXRfb3BzOw0KPiA+ICAJcHJpdi0+cmNkZXYub3duZXIgPSBUSElTX01PRFVMRTsN
Cj4gPiAgCXByaXYtPnJjZGV2Lm9mX25vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gPiArCXBy
aXYtPnJlc2V0X2lkID0gWllOUU1QX1JFU0VUX0lEOw0KPiA+ICAJcHJpdi0+cmNkZXYubnJfcmVz
ZXRzID0gWllOUU1QX05SX1JFU0VUUzsNCj4gPiArCWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJs
ZShwZGV2LT5kZXYub2Zfbm9kZSwNCj4gPiArCQkJCSAgICAieGxueCx2ZXJzYWwtcmVzZXQiKSkg
ew0KPiANCj4gSXQgd291bGQgYmUgYmV0dGVyIHRvIHVzZSBvZl9tYXRjaF9kZXZpY2UgYW5kIHN0
YXRpYyBjb25zdCBpbml0YWxpemF0aW9uIGRhdGENCj4gZm9yIHRoaXMuDQpXaWxsIGNyZWF0ZSBz
b2Mgc3BlY2lmaWMgaW5pdGlhbGl6YXRpb24gZGF0YSBzdHJ1Y3R1cmUgYW5kIGFzc2lnbiBiYXNl
ZCBvbg0Kb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkuDQoNCj4gDQo+ID4gKwkJcHJpdi0+cmVz
ZXRfaWQgPSAwOw0KPiA+ICsJCXByaXYtPnJjZGV2Lm5yX3Jlc2V0cyA9IFZFUlNBTF9OUl9SRVNF
VFM7DQo+IA0KPiBUaGlzIHdvbid0IHdvcmsuIEFsbCB5b3VyIHJlc2V0IGlkcyBhcmUgZ3JlYXRl
ciB0aGFuIDk1LCBhbmQgdGhpcyBkcml2ZXIgaXMgdXNpbmcNCj4gdGhlIGRlZmF1bHQgb2ZfeGxh
dGUgY2FsbGJhY2ssIHNvIG9mX3Jlc2V0X3NpbXBsZV94bGF0ZSB3aWxsIGZhaWwgYWxsIHJlc2V0
DQo+IGNvbnRyb2wgcmVxdWVzdHMgd2l0aCAtRUlOVkFMLg0KV2lsbCBjcmVhdGUgb2ZfeGxhdGUg
Y2FsbGJhY2sgdGhhdCB3aWxsIHNpbXBseSByZXR1cm4gdGhlIHJlc2V0IGxpbmUgbnVtYmVyDQp3
aXRob3V0IGFueSBjaGVja3MuIFdlIGhhdmUgdW5kZXJseWluZyBzZWN1cmUgbGlicmFyeSB3aGlj
aCB3aWxsIHZhbGlkYXRlDQp0aGUgcmVzZXQgbGluZSBudW1iZXIuDQoNClJlZ2FyZHMNClNhaSBL
cmlzaG5hDQo+IA0KPiByZWdhcmRzDQo+IFBoaWxpcHANCg==
