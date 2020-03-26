Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8568C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFAA20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ppo05eiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgCZTCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:02:38 -0400
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:1666
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbgCZTCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:02:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWsMnLhHK98YNnrdnCMWYrZcqDEGrAbwJEcVEGC1K8LDBPwRp2OSkn4+v3p1FytwOe8CrfydMRgDXuoLYcvtgyl2pEsTJWUPdYBZt/nltVjC0PlQEFFp/iemdMnKSW5QQFQUOQ+PiWGKW9pEn93G90GDXBe34K9nab62sW3dqV50pxfHxE9aVdl4RiicPsNdxh77nwBIp4X3MtxksOLDHph7qLLZ0genHPNgAKFGA/RDPMGFsoXj1o4n6eFbOYgFlVPj73H0VrPqgvbALnB3CZ5dLxj4NExgJ31t1kqNnaV1g2O5RADpadaF3fJeblnFSdZ0BK76ctDdqmgwyFcZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTI6KSlUtKn8hZNiiWiFDLcXXY6J6ICOBXqfsO84CjA=;
 b=K3UEsDe9MEMMelpbJ6iIPrwItABivZVTmOHEgyLtBdck79/HQEFowothuHqXwm3t5iUTngY8kGZBZc51iL3sjY+Ore6ka9OVaE09NvhxebKaNbZuYBO03gm/1ovoRqL4gYoJsxtqjr4yOgndDb04hbevZ9EkPPZc4zyCuViF7/45JVXfNMgGyREQLhyLpixBN789QkANVASWRjGEa/UTWWfeiIl9rRI+XT0aqQcRapCk/kHeAn8ej8vZ/9VS5hTAdtdiTL753/nIiFgedy6GIHZ4bl650DBbEGcwOCCFkdiYqs1RGtDEfILfP6H/e4aH2hzimdnhN216tiLlM0UtzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTI6KSlUtKn8hZNiiWiFDLcXXY6J6ICOBXqfsO84CjA=;
 b=ppo05eiyih5/vOkEW99eBKwdC2Ey0YYUb3yuOFkBaGbVfnOc+gxDsIhxNnu/BRVgvpg9J+rJ9LGFp2ajs7IdsydqkFp/USoUPzASoA+WiCAXNJIqcVG6OPmbnHrIu0PmLVdlHeDBUnUMtvIMU1QXLI+J1PNJR0UuvX0hqVzu0Ig=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB3958.namprd05.prod.outlook.com (2603:10b6:a02:87::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.9; Thu, 26 Mar
 2020 19:02:33 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331%2]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 19:02:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        tglx <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
Subject: Re: [RESEND][PATCH v3 06/17] static_call: Add basic static call
 infrastructure
Thread-Topic: [RESEND][PATCH v3 06/17] static_call: Add basic static call
 infrastructure
Thread-Index: AQHWAegAhdNiMLofE02jpsU0DrVXFKhbFyMAgAAFbgCAABLlAIAABWSAgAAJi4A=
Date:   Thu, 26 Mar 2020 19:02:33 +0000
Message-ID: <313E79F2-E277-4C66-97C8-40B545B58370@vmware.com>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.632535759@infradead.org>
 <12A30BA0-18DA-4748-B82F-6008179CC88C@vmware.com>
 <20200326170128.GQ20713@hirez.programming.kicks-ass.net>
 <9D47A4CA-39AD-4408-879B-677BE9D891B7@vmware.com>
 <20200326182823.GB2452@worktop.programming.kicks-ass.net>
In-Reply-To: <20200326182823.GB2452@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4700:9b2:857a:d913:34b7:2afa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a68cb8c6-15ae-42d5-c53a-08d7d1b83de6
x-ms-traffictypediagnostic: BYAPR05MB3958:
x-microsoft-antispam-prvs: <BYAPR05MB395810C742BF73B6F3155AA4D0CF0@BYAPR05MB3958.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(86362001)(2906002)(2616005)(478600001)(186003)(66446008)(71200400001)(4326008)(8676002)(33656002)(66946007)(81156014)(8936002)(81166006)(5660300002)(36756003)(6512007)(54906003)(316002)(66556008)(7416002)(6916009)(66476007)(53546011)(76116006)(6506007)(64756008)(6486002)(21314003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HoGj45DBp3b1IkBxkPl42qa0iz04yld0N17mh4sodXb2bYYp0O/Hq4gqoWCHt4tKSiinZ6lvne6cp75vIVwwVdMLUtxU27QVTa2GjdWOongKIz868FtSFXSeWH1iusUtR2oMvJwOfmt+1hXs8gcq2Ff7prp0PDJPL52hipw1XvAV0Iyw+gwuhflVfNb2NUKXlDVbpXi125EjxjnqamWRnYeTKjo1zMQG3LqY5Rtaxvh0EHqQvU2Us+LTdmYpFfXzJ9ZRyw6+W6cBQEmcmrq8u0NfvgaGvaAzOtLWyhaRZrfUMRrK54LTn+b/cV2NOsaP9/wRfqIwe8wVWYBR+mnDG5D+smwDaNYDzBejBL0aYAZAYB2MIA689Sw17l+MQR7A5IHWWB5QFbS98CyNX1rsAzC2ajjq+Sc88zqlap8yud0Oa7iSlib4RZBN0t0M7+NkJiySPsA1QOEn99PPJ13CO7QSqwHLiYK5jdvJosXCS7N1hVcyy8mbJX4LB25nLQlI
x-ms-exchange-antispam-messagedata: DBaffNjHujdk1N2DgNaN+wuwGgDjflSQloR1bb948d38K+kAQUJSgbp/pNoTZzj1Va/GDF0YAMWS32gN1Srz2vCQG15xiTZh75Y9lsu3XVV54JTQ2JWH4EJLAiKRuQKTxB+GHBCDBxyUIEY1e94d3s9n6r4h9ppgGvXs7XDJ7LGDUMUiyzOj6OjYCI2VSeigh+hSCMd1tQlUEYQpjaAxIQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <23AFEB682B888441B8ED58884787ECD7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68cb8c6-15ae-42d5-c53a-08d7d1b83de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 19:02:33.7357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNXvwmDQGfeABFT1uRAZ0O1rq46w7rjh2QSVp1cEFKzqURNSZyJm+VRJ2Clrc9VvUo5C3Hfj8KBDaVEmLFt7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3958
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXIgMjYsIDIwMjAsIGF0IDExOjI4IEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBNYXIgMjYsIDIwMjAgYXQgMDY6MDk6
MDdQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4gDQo+PiBJIHRoaW5rIHRoYXQgdGhlIGtl
cm5lbCB1bmRlcnV0aWxpemVzIHRoZSBwdXJlIGF0dHJpYnV0ZSBpbiBnZW5lcmFsLg0KPj4gQnVp
bGRpbmcgaXQgd2l0aCAiLVdzdWdnZXN0LWF0dHJpYnV0ZT1wdXJl4oCdIHJlc3VsdHMgaW4gbWFu
eSB3YXJuaW5ncy4NCj4+IEZ1bmN0aW9uIHBvaW50ZXJzIHN1Y2gga3ZtX3g4Nl9vcHMuZ2V0X1hY
WCgpIGNvdWxkIGhhdmUgYmVlbiBjYW5kaWRhdGVzIHRvDQo+PiB1c2UgdGhlIOKAnHB1cmXigJ0g
YXR0cmlidXRlLg0KPj4gDQo+PiBUaGUgc3ludGF4IGlzIHdoYXQgeW91IHdvdWxkIGV4cGVjdDoN
Cj4+IA0KPj4gIHN0YXRpYyB2b2lkIF9fYXR0cmlidXRlX18oKHB1cmUpKSgqcHRyKSh2b2lkKTsN
Cj4gDQo+IFdlbGwsIEkgZGlkbid0IGluIGZhY3QgZXhwZWN0IHRoYXQsIGJlY2F1c2UgYW4gYXR0
cmlidXRlIGlzIG5vdCBhDQo+IHR5cGUgcXVhbGlmaWVyLg0KDQpKdXN0IGEgc21hbGwgY29ycmVj
dGlvbiBmb3IgbXkgc3R1cGlkIGV4YW1wbGUgLSBwdXJlIGZ1bmN0aW9uIHNob3VsZCBhbHdheXMN
CnJldHVybiBhIHZhbHVlLg0KDQo+PiBIb3dldmVyLCB5b3UgaGF2ZSBhIHBvaW50LCBnY2MgZG9l
cyBub3QgYXBwZWFyIHRvIHJlc3BlY3Qg4oCccHVyZeKAnSBmb3INCj4+IGZ1bmN0aW9uIHBvaW50
ZXJzIGFuZCBlbWl0cyBhIHdhcm5pbmcgaXQgaXMgaWdub3JlZC4gR0NDIGFwcGFyZW50bHkgb25s
eQ0KPj4gcmVzcGVjdHMg4oCcY29uc3TigJ0uIEluIGNvbnRyYXN0IGNsYW5nIGFwcGVhcnMgdG8g
cmVzcGVjdCB0aGUgcHVyZSBhdHRyaWJ1dGUNCj4+IGZvciBmdW5jdGlvbiBwb2ludGVycy4NCj4g
DQo+IFN0aWxsLCB3ZSBjYW4gcHJvYmFibHkgbWFrZSBpdCBoYXBwZW4gZm9yIHN0YXRpY19jYWxs
KCksIHNpbmNlIGl0IGlzIGENCj4gZGlyZWN0IGNhbGwgdG8gdGhlIHRyYW1wb2xpbmUsIGFsbCB3
ZSBuZWVkIHRvIGRvIGlzIG1ha2Ugc3VyZSB0aGUNCj4gdHJhbXBvbGluZSBpcyBkZWNsYXJlZCBw
dXJlLg0KPiANCj4gSXQgZG9lcyBob3dldmVyIG1lYW4gdGhhdCBzdGF0aWNfY2FsbCgpIGluaGVy
aXRzIGFsbCB0aGUgZGFuZ2VycyBhbmQNCj4gcGl0LWZhbGxzIG9mIGZ1bmN0aW9uIHBvaW50ZXJz
IHdpdGggc29tZSBleHRyYSBvbiB0b3AuIEl0IHdpbGwgYmUNCj4gaW1wb3NzaWJsZSB0byB2YWxp
ZGF0ZSB0aGlzIHN0dWZmLg0KPiANCj4gVGhhdCBpcywgeW91IGNhbiBzdGF0aWNfY2FsbF91cGRh
dGUoKSB3aXRoIGEgcG9pbnRlciB0byBhICFwdXJlIGZ1bmN0aW9uDQo+IGFuZCB5b3UgZ2V0IHRv
IGtlZXAgdGhlIHBpZWNlcy4NCg0KSSB1bmRlcnN0YW5kLiBXZWxsLCBwZXJoYXBzIGl0IGNhbiBi
ZSBhZGRlZCBsYXRlciwgYXMgYW55aG93IEdDQyBkb2VzIG5vdA0Kc3VwcG9ydCBpdC4NCg0KT24g
YW5vdGhlciBub3RlIC0gaXQgbWF5IGJlIGJlbmVmaWNpYWwgdG8gc2VlIGlmIHRoZSBpbmZyYXN0
cnVjdHVyZSB0aGF0IHlvdQ0KYnVpbHQgY2FuIGFjY29tbW9kYXRlIG5vdGlmaWVyLWNoYWlucy4g
SXQgaXMgbm90IHRoZSBtb3N0IHBhaW5mdWwgcG9pbnQsIGJ1dA0KaXQgd291bGQgYmUgbmljZSB0
byBkZWFsIHdpdGggdGhvc2UgYXMgd2VsbC4gU2luY2UgbWFueSBvZiB0aG9zZSBhcmUgY2hhbmdl
ZA0KYXN5bmNocm9ub3VzbHksIEkgYW0gbm90IHN1cmUgaXQgaXMgdGhlIGVhc2llc3QgdGhpbmcg
dG8gZG8uDQoNCg==
