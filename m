Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1549C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A28C2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="UxvTmpm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgAPLOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:14:21 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24612 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgAPLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:14:21 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GBCq2n010010;
        Thu, 16 Jan 2020 06:13:44 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xfc59n78v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 06:13:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei/pfpkrrMzP1z4KHAxAkrSTyxGbm22u5vMHDBZFtSslM4ZFc9TyGfWXeXct0hyJtDnZJCriTANEB5ISSARNoExVPqSyVEQt8m7k0C1Wr7wYx/Y6vrtTKnP+fiVEROi3/FpvTRvXre8QXW1RkP1S54b1LK0OaaJVdMK5wz8aqJRjhK9pjxaVax/7hkW6SfzYKTpS+tFEFlmZyOCjsKaiViRWx9GMErZpzfIiWZFKH94PqxMOXo80HHVWJ1nmTHMF8lQpEUCtGSTXMo55KlPEDgOcvhiF/h/Q0XYHlNQ8vXvk0DZEg3nxULQY+rlcP9i3/RZ95CYFqa/Tq6AsSR3WmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm/jlmsgmx8WMkMGi4AiHFwaYaqAKy08fnu6jnEW2Uw=;
 b=KGPfdHT2w16GWfqU8/2P7T+H1HAddMrcPQ4UroNhMVhPVma8E0hK/U+BRDt0cW/MTFba/1jvIgESMmNwjP2Dx3zChzZl8SZbjf+rKYzSa1OBOkCzT2jcl8XOv35TP81aG14w0IBPeZ0l06uexdABuLwWE9pJmKxr3RaC3HAAt0WXOERjAZjTLL/Mz01+7WaQ0dKjfSALtTQK2p/8BnuVQdzMMtQ/gZX3weWVOhAtqBxdpoYiB2+hegUIuEiLcNtFXrPYf3hmc8PvbtmEhpP6akRdYrRP6M8729h5VSsoR41N0HgJb3QmAec6ZReZkMf06iQ2YizwQ3qHwiI+ZZTv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm/jlmsgmx8WMkMGi4AiHFwaYaqAKy08fnu6jnEW2Uw=;
 b=UxvTmpm74b50L3V/rODjrOf16ztusu4f9+xu0RNV9weQlhqin5S2ixvwFxJZ61VYsWk5lFQX+HBjM7MUCcR5fpTMKXSd4IHaRnuNldFfSYyWjYd1hSEx0p8GNUI7+NV9HVWjDAetBgoBBw2cY+6FuofNn0ba9SQBCOf2v1ductc=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5301.namprd03.prod.outlook.com (20.180.15.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 11:13:43 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2644.021; Thu, 16 Jan 2020
 11:13:43 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mina86@mina86.com" <mina86@mina86.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: Re: [PATCH] usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ
 flags
Thread-Topic: [PATCH] usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ
 flags
Thread-Index: AQHVlJoPRhMSTshV10KJVpaiJ2qsxKftk2wA
Date:   Thu, 16 Jan 2020 11:13:42 +0000
Message-ID: <f3f8e2a6480da78ba23ddedb68beee71f47e178f.camel@analog.com>
References: <20191106120219.15028-1-alexandru.ardelean@analog.com>
In-Reply-To: <20191106120219.15028-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3b98ac2-e139-4010-bf2d-08d79a7525b5
x-ms-traffictypediagnostic: CH2PR03MB5301:
x-microsoft-antispam-prvs: <CH2PR03MB530117C473F1EB59E0E82DC5F9360@CH2PR03MB5301.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(6506007)(86362001)(6486002)(6512007)(71200400001)(5660300002)(8936002)(8676002)(2616005)(81156014)(110136005)(54906003)(316002)(81166006)(186003)(26005)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(478600001)(4326008)(2906002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5301;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LODCyzOXfRHiT9weMEMn6HI1qI9xftN1DG2owK70VD/FJVY3cU2XwDMKKxOQkMfF5qiRZPTTs1PogAJLXPHrE8KR3WM958YiIb5mIEVda3cx3K8foNafyeHHt3Xnlh+NLAZX/4LE+hmBCVVmpThKVCvpZzho9Yxzktp1F8bo4zXZtr5uDvCdNa2oOJvUnKIRFdX5sMIw+Xe3Fo5d5ajFxTOh6gz1+ED/jMJzJJN+F42oj+ipTJo0dLQM6vhXP7g5KypDgSGv0HeZSLathpCTglTWHAJxlcxMYgT/6jeVTrFS86HHw5/726TOvjnmgb6SF78CINu/f68ZDbuwNAoaHx4qWgYTAm1senZL3eCHbwm8OXxjkZbPBHk9W1h92TQRG9XiXsfiLLFB/mu+DaxpLmyT5kjbjC/e3vUVY5zmOZO3MUifT6SWnaAQD6WlUR7K
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA71178F5B212C4993CCD9DC8DBD1827@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b98ac2-e139-4010-bf2d-08d79a7525b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 11:13:42.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxlbwDOWkqun1WG5beE4Yj2aNiGb0UdTUh/BjhIZ4V4xR4znqGAqoDhIpCmuu+/qNtJoibTBGeXyejHfz3Axx4ZKHKdCP/Q9IXshsDjRRO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5301
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_03:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=646 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001160095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTA2IGF0IDE0OjAyICswMjAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IEZyb206IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiANCj4g
ZmZzX2Fpb19jYW5jZWwoKSBjYW4gYmUgY2FsbGVkIGZyb20gYm90aCBpbnRlcnJ1cHQgYW5kIHRo
cmVhZCBjb250ZXh0Lg0KPiBNYWtlDQo+IHN1cmUgdGhhdCB0aGUgY3VycmVudCBJUlEgc3RhdGUg
aXMgc2F2ZWQgYW5kIHJlc3RvcmVkIGJ5IHVzaW5nDQo+IHNwaW5fe3VuLH1sb2NrX2lycXtzYXZl
LHJlc3RvcmV9KCkuDQo+IA0KPiBPdGhlcndpc2UgdW5kZWZpbmVkIGJlaGF2aW9yIG1pZ2h0IG9j
Y3VyLg0KDQpIZXksDQoNClRoaXMgaXMgYSBwYXRjaC1waW5nLg0KDQpUaGFua3MNCkFsZXgNCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+
DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFu
QGFuYWxvZy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZnMu
YyB8IDUgKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zf
ZnMuYw0KPiBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2ZzLmMNCj4gaW5kZXggNTlk
OWQ1MTJkY2RhLi5lZDNiY2JiODRiOTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi9mX2ZzLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zf
ZnMuYw0KPiBAQCAtMTE2MCwxOCArMTE2MCwxOSBAQCBzdGF0aWMgaW50IGZmc19haW9fY2FuY2Vs
KHN0cnVjdCBraW9jYiAqa2lvY2IpDQo+ICB7DQo+ICAJc3RydWN0IGZmc19pb19kYXRhICppb19k
YXRhID0ga2lvY2ItPnByaXZhdGU7DQo+ICAJc3RydWN0IGZmc19lcGZpbGUgKmVwZmlsZSA9IGtp
b2NiLT5raV9maWxwLT5wcml2YXRlX2RhdGE7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4g
IAlpbnQgdmFsdWU7DQo+ICANCj4gIAlFTlRFUigpOw0KPiAgDQo+IC0Jc3Bpbl9sb2NrX2lycSgm
ZXBmaWxlLT5mZnMtPmVwc19sb2NrKTsNCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmZXBmaWxlLT5m
ZnMtPmVwc19sb2NrLCBmbGFncyk7DQo+ICANCj4gIAlpZiAobGlrZWx5KGlvX2RhdGEgJiYgaW9f
ZGF0YS0+ZXAgJiYgaW9fZGF0YS0+cmVxKSkNCj4gIAkJdmFsdWUgPSB1c2JfZXBfZGVxdWV1ZShp
b19kYXRhLT5lcCwgaW9fZGF0YS0+cmVxKTsNCj4gIAllbHNlDQo+ICAJCXZhbHVlID0gLUVJTlZB
TDsNCj4gIA0KPiAtCXNwaW5fdW5sb2NrX2lycSgmZXBmaWxlLT5mZnMtPmVwc19sb2NrKTsNCj4g
KwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZlcGZpbGUtPmZmcy0+ZXBzX2xvY2ssIGZsYWdzKTsN
Cj4gIA0KPiAgCXJldHVybiB2YWx1ZTsNCj4gIH0NCg==
