Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800DBC433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB812065D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="kr2ymY1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgGMIUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:20:19 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com ([40.107.8.103]:35150
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgGMIUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:20:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5jCyn/0hEHxKftWKJXPWe4pGH33dTOBicHJ0XhKhTNj5lYW7UwoZAaz8hK5G0P2XeN1dxWj1YUyDcAciWmQ9q0PpmfJdyIb0459eeT6FZMSzCCNcpPKbELuxWdOQ4oaQcERAKrTT1A4ZyHo+gAytmcbVuEx1AVcYpYpZsZg2rYLvcSmiu6g4/5gZUmAHoJs73tUeijS2yA9Pz+UjRo0xs7IqV6dXN+zfNTTTQLOopF/8twaCzYBUGdeHG8WTlDfxQgfSNnSv4TAClGgCloDzxJyy9ITl2FYgMJoYfBTr9ll24uqHPbxFdES8yA8Q3eGoWLHpeY4WSg39ZC2YQD9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urWkkhJPZY5OeszWQqW+cOVTvu5rONZMxKTQL6ouHKQ=;
 b=BUJKVAPueemmKKdY5TazGSg8mkCtEG/9E6B0PHM5JfrkrmPjXQ7uodMyX/5q7FUoS8CTdnI0SYo7+ANGPwS/fbpwFS2a2hmgNShYzpbuybZq8R1LgCX868fHt3bJGbP7GsYoNBefnOme9r7i+pYEwzkYP3ADAy6WjeJEA3GqD0AhNnFHICcQVylEk8y6saRgky2IE7db061Cyk5vdJjWeiicyeHeUUxNypGhO+5+zmnX4R8RQ/7PaCnAGxM+sItGN1dRJkPWLAK8q1Psh183C8GpSaGOOy0DJ7dw70Lv/rnOieUsi5CDXYtyVKjea977bqq3IVGjivfM5H4PMid2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urWkkhJPZY5OeszWQqW+cOVTvu5rONZMxKTQL6ouHKQ=;
 b=kr2ymY1B64TXMo68ctrgOH4qfGDpBFDLL68mXPPomeGfZrpV+07NkywJI8eoho6A3udeFIRGYDj5hB97QjsiIjO2Fu+lZWica5INkUS/UlcOz8pvC1sfiiPp+MUBwNrbGAOb8Msg+c4Oy5F0qU5dO7PfIGENrIJ9w0alu2G6ipc=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM5PR0502MB3026.eurprd05.prod.outlook.com (2603:10a6:203:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 08:20:09 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 08:20:09 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "Peter.Chen@nxp.com" <Peter.Chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: usb: ci-hdrc-usb2: add property
 disable-runtime-pm
Thread-Topic: [PATCH 1/3] dt-bindings: usb: ci-hdrc-usb2: add property
 disable-runtime-pm
Thread-Index: AQHWVtG65io4S6/m/keMdd0DT0bFGakA97WAgAQ3fgA=
Date:   Mon, 13 Jul 2020 08:20:09 +0000
Message-ID: <6dc0449f57405c997ce94ef9e9ea6435fb6c0a7d.camel@toradex.com>
References: <20200710154935.697190-1-philippe.schenker@toradex.com>
         <CAOMZO5DvArJPAJ+PzDi=zpDmTdr3u0j9nbd3wSVT5tdV+STmWw@mail.gmail.com>
In-Reply-To: <CAOMZO5DvArJPAJ+PzDi=zpDmTdr3u0j9nbd3wSVT5tdV+STmWw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d26fd19-aea8-4f23-c809-08d827058eca
x-ms-traffictypediagnostic: AM5PR0502MB3026:
x-microsoft-antispam-prvs: <AM5PR0502MB30267A5BCB31F27B7EFC2C4FF4600@AM5PR0502MB3026.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2uLNYki0rwz8A06zv48kcxyRIW/wwkiYK9rhDqP39msnanlJf+V5tYVZuyL89BzQcIAbmYDBRK5kCt3HKDYvRzcjzj3wvmbZ4TgNJM9ELpYqeblBu+Bs9wandYi8FnQfgO3Tucfhj1wv1ai0CZVrYyPEcny9PhcLOcM62G/Wc80bREXZqYUFkFUX7Zyo3Sbs1uT5rhJflMTRrXtesG+Ql2V8EFoiRq4gP9Amq2W6Q8Ye1A24WKqbQTzyMELNlF8k/bK1aOAloqPCaHwQLi1/A76KoiLE4AHUbddK1CjcNMPiofLcMrBryJIFeDfSXe0uBpdmjV24eskec7HtYR5giA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(39840400004)(366004)(136003)(83380400001)(6916009)(26005)(5660300002)(71200400001)(8676002)(54906003)(6512007)(6486002)(66556008)(76116006)(316002)(6506007)(44832011)(86362001)(53546011)(8936002)(91956017)(64756008)(66476007)(66446008)(66946007)(2906002)(2616005)(478600001)(4326008)(36756003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nEXmA5o0kMhl4u5Bgztt+YllFyu0Xoy5f3mNXEMi2+c5S++Jv3C09LTjeo0ptFBaF/lHWnDVBULIayooestzOBGPAgsJyMcfDB8OPN/CHg+H+25LBCfL7zGjxhtDTHMvQ7E5N1rUyDGbUCRjSuNwHZAw60gea7guz5qWN4RzaGsJOI7FDJbvaNkXY3bjGlGMKPNnI5sIsKPwg9myq8OJ1hdWS5JNMeF6+CiC+cMrKU5hqVL5gVYqL1UP0nR7O9xovUExT7goD24AaJR81VTcjHZT1ix0RrOTBsdxO52OZbdmzq+ZQuc10hxCRMZ1mjnKdssGe7GdrlP3qH339Zp1kSQ5yn3fFoYrZ3kyJhAEeAae55OfB2xeIDqfytzPx4/XoPqklbRCy578hsVsA1UFnZtU1Po/+Q7va+WkMyqYg+U3wYjDfa6bgGBkm2FlXKBL3rjQaMCAcEi9xkeM/TGQv39xKonzJ8gz/Nm7PFzaIEE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFAF005E6E2B4E4C824AADF0E91B2C36@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d26fd19-aea8-4f23-c809-08d827058eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 08:20:09.4970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmhhKxIWt/2PkO0j3TKDINivKb2a5+t/N8GCvSek8ONaAUc1BOLtZLc2p4eB6yL+kygmDUdzXk1mfr5skbV+iahbBrShSXlUn0eTlfQjifs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB3026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTEwIGF0IDEyOjU2IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBQaGlsaXBwZSwNCj4gDQo+IE9uIEZyaSwgSnVsIDEwLCAyMDIwIGF0IDEyOjUxIFBNIFBo
aWxpcHBlIFNjaGVua2VyDQo+IDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4gd3JvdGU6
DQo+ID4gQ2hpcGlkZWEgZGVwZW5kcyBvbiBzb21lIGhhcmR3YXJlIHNpZ25hbHMgdG8gYmUgdGhl
cmUgaW4gb3JkZXINCj4gDQo+IEkgdGhpbmsgdGhpcyBkZXNjcmlwdGlvbiBpcyB0b28gdmFndWUu
DQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgbW9yZSBkZXRhaWxzIHNvIHRoYXQgYSB1
c2VyIGNhbiBrbm93IGlmIHRoZWlyDQo+IGhhcmR3YXJlIGZhbGxzIGludG8gdGhpcyBjYXRlZ29y
eT8NCj4gDQo+IEl0IGlzIG5vdCBjbGVhciBmcm9tIHNlZWluZyB0aGlzIHNlcmllcyB3aGF0IGlz
IHRoZSBoYXJkd2FyZSBkZXRhaWxzDQo+IHRoYXQgd291bGQgcmVxdWlyZSB0aGlzIHByb3BlcnR5
IHRvIGJlIHVzZWQuDQoNCkhpIEZhYmlvLCBQZXRlciwNCg0KSSB0cmllZCB0byBrZWVwIHRoZSBk
ZXNjcmlwdGlvbiBmb3IgdGhpcyBwYXRjaCBzb21ld2hhdCBnZW5lcmFsLiBCdXQgYXMNClBldGVy
IHN1Z2dlc3RlZCBJIHdpbGwgYWRkIFRvcmFkZXgncyB1c2UtY2FzZSBmb3IgdGhpcy4NCg0KVGhl
IHByb2JsZW0gd2l0aCBDb2xpYnJpIGlNWDZVTEwgaXMgdGhhdCB3ZSBhcmUgc3R1Y2sgd2l0aCBh
IGxlZ2FjeQ0KbW9kdWxlIHN0YW5kYXJkIHRoYXQgZG9lcyBvbmx5IGluY2x1ZGUgb25lIFVTQiBo
b3N0L2RldmljZSBzd2l0Y2hpbmcNCnNpZ25hbC4gUGx1cyBvbiB0aGF0IHNwZWNpZmljIG1vZHVs
ZSB3ZSBoYXZlIG5vIDVWIGF2YWlsYWJsZSBoZW5jZSBsZWZ0DQp0aGUgY29ubmVjdGlvbiBvZiBW
QlVTIHNpZ25hbCBhd2F5Lg0KVGhpcyB3b3JrcyBub3JtYWxseSBwcmV0dHkgd2VsbCBidXQgZm9y
IG91ciAiZHVhbC1yb2xlIE9URyIgcG9ydCBJIGNvdWxkDQpub3QgbWFrZSBpdCB3b3JrIHdpdGgg
cnVudGltZS1wbSBydW5uaW5nIGFuZCBwcm9wZXIgZXh0Y29uDQpjb25maWd1cmF0aW9uLiBUaGUg
cHJvYmxlbSB3YXMsIHdoZW4gcGx1Z2dpbmcgaW4gc29tZXRoaW5nIGluIGRldmljZSBvcg0KaG9z
dCBtb2RlIGdldHMgbm90IGVudW1lcmF0ZWQgYW5kIGRldGVjdGVkLg0KDQpUaGF0IGFyZSB0aGUg
cmVhc29ucyB3aHkgSSBiZWxpZXZlIHRoZSBQSFkgb3Igc29tZXRoaW5nIGVsc2UgaW4gQ2hpcGlk
ZWENCm5lZWRzIGEgc2lnbmFsIHRoYXQgaXQgZG9lcyBub3QgaGF2ZSBvbiB0aGF0IG1vZHVsZSB0
aGF0IHdvdWxkIHdha2UgdGhlDQp3aG9sZSB0aGluZyBmcm9tIHJ1bnRpbWUtc3VzcGVuZC4NCg0K
SSB3aWxsIHRoaW5rIGFib3V0IGEgYmV0dGVyIGRlc2NyaXB0aW9uIGFuZCBzZW5kIGEgdjINCg0K
VGhhbmtzDQpQaGlsaXBwZQ0K
