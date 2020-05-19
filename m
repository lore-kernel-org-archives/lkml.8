Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EABBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4993420674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kVHJ56Vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgESDDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:03:30 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:60310
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbgESDDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiZ+iW66KTyrORxq+ZAGvAkWgXAXD4wRqGLVH5NWd12MEgNZzkz3keE2EbBP7Z7UoF0mdn2RixpwK+PNQu4dMJuI4xB3CQAfjBRExTgwJCk2O61jYmvlLrCCk4PAH3e2SUSMw08++/LGssk0tJceyMdHL/gYECNzxv6TVw7mjytzWW0l7hjDuGSIs7F/VJE/J5Tj4A8fesGgIV3WR5aBk2wijRHORbqhr6XF3L3AHdfwg6SyDx83KL88hHd7zzjYuyjwJMryFXKXOhb9HFPcRF04UxHi1XY6WR7e/BUfcHjsUKFmP3FwNl7yvx35ABb/kZuuOUANbbp2vOvwU16sOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnjKNkUplrZwqV9WxWqlbyGb3v0XZ/jB2sNZ0Lsu/s0=;
 b=J82mIg/3FHXZuZ1/yaeg+9gnEqwUfzVoLnu9SRtOx0ezvfztPF7O6XukW5paclfeDZyVcpnNYw1tlCSIWs2bobJrBVNaSs2Ao/njE2TF/tZlJiPAFAO5wVoGtTFM2xnFaFwgcqLpj71dg/HM8/HHT6uOBFhKRi+2esAJ1ymwgWc1E0TNfpYOrxN49X7bjqy1C/wlEXGB4dszs2fG3XdIdFXIH8EnTXoGQK6pMh6QTJNo1eMTAG8hmkDkm+ayPf9UTko0rYeXGFPU0OqK4pchXDP7AGlLdoOjdRY5XU3XNV2K67EV802/931r2HyEYFEDqPtzLyqPEy09iWMrvgkY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnjKNkUplrZwqV9WxWqlbyGb3v0XZ/jB2sNZ0Lsu/s0=;
 b=kVHJ56VdyqB9ST5ZTlHWtGkk950mThqfmJWNIjjl8sI6CUba1L0k1qk0YB/GZQQCvtKd5JqU+5/e8vSjrFxmaiVcLx+Nf73SVVaP1GPzrkG6PEP+7uHZ3cSV1hcc54VqBgOrlgnW8QY5UpLM0sqT/vHJRio4DKtCN3kM2FBX3uc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3820.eurprd04.prod.outlook.com (2603:10a6:8:3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Tue, 19 May
 2020 03:03:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 03:03:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] dt-bindings: timer: Convert i.MX GPT to json-schema
Thread-Topic: [PATCH 1/3] dt-bindings: timer: Convert i.MX GPT to json-schema
Thread-Index: AQHWLSSm+hmARz7RGkeECubw76HaxaiutRGAgAAEUQA=
Date:   Tue, 19 May 2020 03:03:26 +0000
Message-ID: <DB3PR0402MB3916A243DDB5BDE55AFA0577F5B90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
 <1589813260-20036-2-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49669345E21DC28009C486E680B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49669345E21DC28009C486E680B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42dc37b5-3f86-4025-243e-08d7fba13343
x-ms-traffictypediagnostic: DB3PR0402MB3820:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3820CFAF88D66F80F5022A54F5B90@DB3PR0402MB3820.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hXpSFVN3uGiAhYhXM2HGNr/8VJf92zmewNja6nlqTeYcT10FC2q4R9SGh4k96S3azhvClQL9U4YJyncXf7s6DUqhFDiGYvCBCm8WinDWtoR8TeZLa0x6LGCrElmofjecUcCscxhUWZu1DNXtkhKdGdFVZN1qckmhGNdA3Z9vhy84IdBa1/o595RV99Qjg6OytdyAa+ytSwQxzYW8165CmgW2IcCZpnoB8OC6J0R12pMS8OVprIFideJQX8HF5BRZ2NVhna031kMRUW2unINbEM1J82i/MPcaQz8kVmK01qv0GwpNi25wvve+y/91AMMGZC+OY+kB9ZoiITK+fvWYI1Ty8TuUpp9liySut2YhzJItOC0O76mDi7QBBTTnUSZbFPEZlv3YkmBjIVZGlbodATrLYK2pOIeUwYwNQueF7Al1h9tBj7ecZqH9hwJvj3ZXouqPz+l8ZHa7nENwXYDI0GpctsmmD3k/kmmu7wslPGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6506007)(71200400001)(66946007)(26005)(66556008)(44832011)(5660300002)(76116006)(66476007)(52536014)(8676002)(64756008)(66446008)(2906002)(86362001)(186003)(7696005)(110136005)(316002)(33656002)(8936002)(4326008)(7416002)(55016002)(9686003)(478600001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DjVMpsWW9nObyzYET0r3goVLc4cfqiRiBK5ZlJo/6Dosk5PBk+xcn1fwTtji/FViYXYJLPGeIvP6HXveXefSusXG5PjDRPOJDbhIYZazVS31TF2zVr6BIlrGm4DxTO2AsnDK7YBL3mNOlcYoJSskB0cIXFzg00ldQIBjFnQw/V0Q05/jcTmq5tqrsAnbt0WNi+wARhPim/8/fjxO9ygDeQomVihfe1XcPStVaZef8+nIns3baeGyTwGFaQCZ1sCGfdI1jvWfdKF2Lu1qOudhkPNJzAo23cn6T9ZIcyeatnLU/Kve9Rr4WTKlQVLEDSFe9Hh7jCCGmuiUVKeHLVYvEb/mR5Qhr2iojhP2e6FensILyZAAbFzXMV2y9WDKxM0NbCEGrREx1Y4XZdl7eVA96vSsIOKLtNl8gaPT216OI30HfcFDlRJVlXs974cgmuFJi/O3MbckIWZC0UBKztPrIpl/tz3tZorIZCO6861Y1N11WDTVRKxZqcBQa1UK3utE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dc37b5-3f86-4025-243e-08d7fba13343
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 03:03:26.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pYNsqYoD8QFLcf2ZhI0uzeLK7BKoRF3AB36CIMAhCADFDRonoKHpI/Bz8iVRrebRiaJO/JjAsQvMwfmK6ElsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCAxLzNdIGR0LWJpbmRpbmdzOiB0aW1lcjogQ29udmVy
dCBpLk1YIEdQVCB0byBqc29uLXNjaGVtYQ0KPiANCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIE1heSAxOCwgMjAyMCAxMDo0OCBQ
TQ0KPiA+DQo+ID4gQ29udmVydCB0aGUgaS5NWCBHUFQgYmluZGluZyB0byBEVCBzY2hlbWEgZm9y
bWF0IHVzaW5nIGpzb24tc2NoZW1hLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RpbWVyL2ZzbCxpbXhncHQudHh0ICAgICAgIHwgIDQ1IC0tLS0tLS0tLQ0KPiA+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9mc2wsaW14Z3B0LnlhbWwgICAgICB8IDEwOQ0K
PiA+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEwOSBpbnNl
cnRpb25zKCspLCA0NSBkZWxldGlvbnMoLSkgIGRlbGV0ZSBtb2RlDQo+ID4gMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9mc2wsaW14Z3B0LnR4dA0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dGltZXIvZnNsLGlteGdwdC55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhncHQudHh0DQo+ID4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvZnNsLGlteGdwdC50eHQNCj4gPiBkZWxl
dGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCA1ZDhmZDViLi4wMDAwMDAwDQo+ID4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhncHQudHh0
DQo+ID4gKysrIC9kZXYvbnVsbA0KPiA+IEBAIC0xLDQ1ICswLDAgQEANCj4gPiAtRnJlZXNjYWxl
IGkuTVggR2VuZXJhbCBQdXJwb3NlIFRpbWVyIChHUFQpDQo+ID4gLQ0KPiA+IC1SZXF1aXJlZCBw
cm9wZXJ0aWVzOg0KPiA+IC0NCj4gPiAtLSBjb21wYXRpYmxlIDogc2hvdWxkIGJlIG9uZSBvZiBm
b2xsb3dpbmc6DQo+ID4gLSAgZm9yIGkuTVgxOg0KPiA+IC0gIC0gImZzbCxpbXgxLWdwdCI7DQo+
ID4gLSAgZm9yIGkuTVgyMToNCj4gPiAtICAtICJmc2wsaW14MjEtZ3B0IjsNCj4gPiAtICBmb3Ig
aS5NWDI3Og0KPiA+IC0gIC0gImZzbCxpbXgyNy1ncHQiLCAiZnNsLGlteDIxLWdwdCI7DQo+ID4g
LSAgZm9yIGkuTVgzMToNCj4gPiAtICAtICJmc2wsaW14MzEtZ3B0IjsNCj4gPiAtICBmb3IgaS5N
WDI1Og0KPiA+IC0gIC0gImZzbCxpbXgyNS1ncHQiLCAiZnNsLGlteDMxLWdwdCI7DQo+ID4gLSAg
Zm9yIGkuTVg1MDoNCj4gPiAtICAtICJmc2wsaW14NTAtZ3B0IiwgImZzbCxpbXgzMS1ncHQiOw0K
PiA+IC0gIGZvciBpLk1YNTE6DQo+ID4gLSAgLSAiZnNsLGlteDUxLWdwdCIsICJmc2wsaW14MzEt
Z3B0IjsNCj4gPiAtICBmb3IgaS5NWDUzOg0KPiA+IC0gIC0gImZzbCxpbXg1My1ncHQiLCAiZnNs
LGlteDMxLWdwdCI7DQo+ID4gLSAgZm9yIGkuTVg2UToNCj4gPiAtICAtICJmc2wsaW14NnEtZ3B0
IiwgImZzbCxpbXgzMS1ncHQiOw0KPiA+IC0gIGZvciBpLk1YNkRMOg0KPiA+IC0gIC0gImZzbCxp
bXg2ZGwtZ3B0IjsNCj4gPiAtICBmb3IgaS5NWDZTTDoNCj4gPiAtICAtICJmc2wsaW14NnNsLWdw
dCIsICJmc2wsaW14NmRsLWdwdCI7DQo+ID4gLSAgZm9yIGkuTVg2U1g6DQo+ID4gLSAgLSAiZnNs
LGlteDZzeC1ncHQiLCAiZnNsLGlteDZkbC1ncHQiOw0KPiA+IC0tIHJlZyA6IHNwZWNpZmllcyBi
YXNlIHBoeXNpY2FsIGFkZHJlc3MgYW5kIHNpemUgb2YgdGhlIHJlZ2lzdGVycy4NCj4gPiAtLSBp
bnRlcnJ1cHRzIDogc2hvdWxkIGJlIHRoZSBncHQgaW50ZXJydXB0Lg0KPiA+IC0tIGNsb2NrcyA6
IHRoZSBjbG9ja3MgcHJvdmlkZWQgYnkgdGhlIFNvQyB0byBkcml2ZSB0aGUgdGltZXIsIG11c3Qg
Y29udGFpbg0KPiA+IC0gICAgICAgICAgIGFuIGVudHJ5IGZvciBlYWNoIGVudHJ5IGluIGNsb2Nr
LW5hbWVzLg0KPiA+IC0tIGNsb2NrLW5hbWVzIDogbXVzdCBpbmNsdWRlICJpcGciIGVudHJ5IGZp
cnN0LCB0aGVuICJwZXIiIGVudHJ5Lg0KPiA+IC0NCj4gPiAtRXhhbXBsZToNCj4gPiAtDQo+ID4g
LWdwdDE6IHRpbWVyQDEwMDAzMDAwIHsNCj4gPiAtCWNvbXBhdGlibGUgPSAiZnNsLGlteDI3LWdw
dCIsICJmc2wsaW14MjEtZ3B0IjsNCj4gPiAtCXJlZyA9IDwweDEwMDAzMDAwIDB4MTAwMD47DQo+
ID4gLQlpbnRlcnJ1cHRzID0gPDI2PjsNCj4gPiAtCWNsb2NrcyA9IDwmY2xrcyBJTVgyN19DTEtf
R1BUMV9JUEdfR0FURT4sDQo+ID4gLQkJIDwmY2xrcyBJTVgyN19DTEtfUEVSMV9HQVRFPjsNCj4g
PiAtCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KPiA+IC19Ow0KPiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvZnNsLGlteGdwdC55YW1s
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvZnNsLGlteGdw
dC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi41Yzcx
ODZiDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy90aW1lci9mc2wsaW14Z3B0LnlhbWwNCj4gPiBAQCAtMCwwICsxLDEwOSBAQA0K
PiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICsNCj4gPiArdGl0bGU6IEZyZWVzY2FsZSBp
Lk1YIEdlbmVyYWwgUHVycG9zZSBUaW1lciAoR1BUKQ0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6
DQo+ID4gKyAgLSBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+ID4gKw0K
PiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBvbmVPZjoNCj4g
PiArICAgICAgLSBkZXNjcmlwdGlvbjogb24gaS5NWDEgdGhlIGZvbGxvd2luZyBjb21wYXRpYmxl
IG11c3QgYmUNCj4gPiArc3BlY2lmaWVkDQo+IA0KPiBTdWNoIGEgZGVzY3JpcHRpb24gc2VlbXMg
bm90IG5lY2Vzc2FyeSBpbiBvcmRlciB0byBtYWtlIHRoZSBkb2MgbW9yZSBjbGVhbg0KDQpZb3Ug
bWVhbnQgdGhlIGRlc2NyaXB0aW9uIGlzIE5PVCBuZWNlc3NhcnkgZm9yIHRob3NlIHNpbXBsZSBj
b21wYXRpYmxlIHN0cmluZyBwbGF0Zm9ybXMgb3IgZm9yDQphbGwgcGxhdGZvcm1zLCBJIGZlZWwg
bGlrZSBoYXZpbmcgdGhlIGRlc2NyaXB0aW9uIGlzIG1vcmUgY2xlYXIgZm9yIHVzZXJzLg0KDQpB
bnNvbg0K
