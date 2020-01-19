Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5182CC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B10206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="j3MKV1yL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgASVZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 16:25:07 -0500
Received: from mail-eopbgr150125.outbound.protection.outlook.com ([40.107.15.125]:46038
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728721AbgASVZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 16:25:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPTsFFIDlQYrMIxOeD6IB79ZKZWZDRXLXFb9WXsu3/BRiy71o5tBh73qfuUy0eBfqEpklJdKXa5PppkgWrIOPFOEvRoI4thVa6j5ciBlDgjadIBtu2i5oQIGeThMf4bTqhIRPKYIiyL2kJWxp/7oEDtf7M8yghLLU62FOvysd+pYTud1CmQ2XpcqxBk7K36YdouoeOUJcRU3S4MHjMX8eJC63bDtVd39oMra7+kVfseGizLwk4trAxSk2wBwDHcnOMWyDK7kcp62KWpz93hy2w9nk2Dv7AovMhlCPF8BqEHPnI9UjjfE89H6FITnfGGKZPpPJ07VTV0PgV74umCPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMs1m2QepKV+cB+yfxuaFuoya2sVNkan0tua7pA9n18=;
 b=bzcC6X9agtLhduVmdiEMouEE5he4eL+qUdT1BS4V3oNnSpmXwixFhJJI5BdIS/eGDFs77FMx5d2mwlDeeaW8WQU0jPDN/5bk7N5s1oA0oQaJZmldxaOrLhecDrM7SlhR4orQ5088r/CizSR+rpGpoNc13osnUorGoP4XHQafyK+dJe944izr05T6AJ4jsnux3SpE4N7lquS5kc8u7TVwrJzC2tWFtRgBDQ6eH2xyMm+xywOhY1+qLQPyA0AIF3IVfEwioGbZAhWi94iitQG6BdZfJwT7s/oxMqKMAvUY+OlrXWMK9duhOhfCaHzUmDhXtQryryVMX2uVmRpCeorscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMs1m2QepKV+cB+yfxuaFuoya2sVNkan0tua7pA9n18=;
 b=j3MKV1yLN1LBgHdJEkmxOzx0oL04VqmSVK4BQALmy/lEMm/VJuz/U1nnCpO9ID1Vr60pcfRzXSvJEUA01aNRU/xCNfrunOvq7dayAgSzbphuYnFSoScooXhNnvSWv9sL7zCFjxpb2NCyt1OMktcEPiTR2DFqfKZt86TnM3XquyA=
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com (10.186.163.80) by
 VI1PR05MB5375.eurprd05.prod.outlook.com (20.178.10.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Sun, 19 Jan 2020 21:25:03 +0000
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::9192:77a8:62cf:c098]) by VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::9192:77a8:62cf:c098%3]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020
 21:25:03 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "info@logictechno.com" <info@logictechno.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "j.bauer@endrich.com" <j.bauer@endrich.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: [PATCH v2 3/3] dt-bindings: display: panel: add bindings for
 logic technologies displays
Thread-Topic: [PATCH v2 3/3] dt-bindings: display: panel: add bindings for
 logic technologies displays
Thread-Index: AQHVjNKZdd5XHtZGzk6i73CvPQ4gHKdzQvqAgH/BMgA=
Date:   Sun, 19 Jan 2020 21:25:02 +0000
Message-ID: <db84ef6c90a9f327bc32c4948109c759b572a2af.camel@toradex.com>
References: <20191027142609.12754-1-marcel@ziswiler.com>
         <20191027142609.12754-3-marcel@ziswiler.com> <20191030142835.GA31293@bogus>
In-Reply-To: <20191030142835.GA31293@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [81.221.128.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 203ef583-470a-4005-64a9-08d79d260bff
x-ms-traffictypediagnostic: VI1PR05MB5375:
x-microsoft-antispam-prvs: <VI1PR05MB537597D778D1A2246F93FE78FB330@VI1PR05MB5375.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39840400004)(346002)(396003)(376002)(199004)(189003)(66556008)(91956017)(66476007)(66946007)(76116006)(4326008)(478600001)(6916009)(66446008)(2906002)(316002)(2616005)(36756003)(64756008)(6506007)(5660300002)(71200400001)(4001150100001)(54906003)(7416002)(6486002)(81166006)(6512007)(44832011)(186003)(81156014)(86362001)(8936002)(966005)(8676002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5375;H:VI1PR05MB6845.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6LXWo5rFjM6MtrJURihhiPIjK02fOnFD2npc4FFa1E3cKABmSnCvPBSmzld2+5L5YfHhxXI9ZU7qiCWVe6ChWZTXtGlUrp5XXJtzQ6zODPqd0SznyVKWuUvlzTWGFQJApSYhrrM7WzZoIQHvGBBz2dA4IVg3iWs2oTI0Si6VTzubL4j260r/3mTStiJfl0s+PYFPdZQ1bmxS/lZ5wIHfeMhFa882XDr7GFgxYZlUYDLbc2sW1CtYlH9yIRxfZJMUL10rdiqgkk2g8yqOER6HBPdwksEZHlwGNclUh0PuN/TdEn+QeV39ercIrEjcPEHnnaxL51JGtJUG5pp3v6acR6ZfdaZ/XH01SRX5AuH4N1u4KPLJDBWv5jXCckRRsgbR/lRdUzSup55gk/T8XBYfrVmMQZbzFFAKE2/fRBLSFVhIy4X8epqLyphhr2dt1y2OqQTnP51432rI9lIwKQZRlU4T6jj/jj23htlbIxP2tPh/vYYe/e38UXvVWn+RVqRTJ0XzkunSA9fNC6FXS9qNw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <886853856403844FA968D4E169C09836@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203ef583-470a-4005-64a9-08d79d260bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 21:25:02.9579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4DHorglhEq4JmUHMEOYvSt9AfAeNa1TW5+u5LM/6RQLWMmW73decpyuRbBQ/0yfYzvUyATx2YXA/2+ozpR1xmepLqRGCFhm8z7p4H2UOn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIGp1c3Qgbm90aWNlZCB0aGF0IHRoaXMgaGFzIG5vdCBnb25lIHRocm91Z2ggeWV0Lg0K
DQpPbiBXZWQsIDIwMTktMTAtMzAgYXQgMDk6MjggLTA1MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0K
PiBPbiBTdW4sIE9jdCAyNywgMjAxOSBhdCAwMzoyNjowOVBNICswMTAwLCBNYXJjZWwgWmlzd2ls
ZXIgd3JvdGU6DQo+ID4gRnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9y
YWRleC5jb20+DQo+ID4gDQo+ID4gQWRkIGJpbmRpbmdzIGZvciB0aGUgZm9sbG93aW5nIDMgcHJl
dmlvdXNseSBhZGRlZCBkaXNwbGF5IHBhbmVscw0KPiA+IG1hbnVmYWN0dXJlZCBieSBMb2dpYyBU
ZWNobm9sb2dpZXMgTGltaXRlZDoNCj4gPiANCj4gPiAtIExUMTYxMDEwLTJOSEMgZS5nLiBhcyBm
b3VuZCBpbiB0aGUgVG9yYWRleCBDYXBhY2l0aXZlIFRvdWNoDQo+ID4gRGlzcGxheQ0KPiA+IDci
IFBhcmFsbGVsIFsxXQ0KPiA+IC0gTFQxNjEwMTAtMk5IUiBlLmcuIGFzIGZvdW5kIGluIHRoZSBU
b3JhZGV4IFJlc2lzdGl2ZSBUb3VjaA0KPiA+IERpc3BsYXkgNyINCj4gPiBQYXJhbGxlbCBbMl0N
Cj4gPiAtIExUMTcwNDEwLTJXSEMgZS5nLiBhcyBmb3VuZCBpbiB0aGUgVG9yYWRleCBDYXBhY2l0
aXZlIFRvdWNoDQo+ID4gRGlzcGxheQ0KPiA+IDEwLjEiIExWRFMgWzNdDQo+ID4gDQo+ID4gVGhv
c2UgcGFuZWxzIG1heSBhbHNvIGJlIGRpc3RyaWJ1dGVkIGJ5IEVuZHJpY2ggQmF1ZWxlbWVudGUN
Cj4gPiBWZXJ0cmllYnMNCj4gPiBHbWJIIFs0XS4NCj4gPiANCj4gPiBbMV0gDQo+ID4gaHR0cHM6
Ly9kb2NzLnRvcmFkZXguY29tLzEwNDQ5Ny03LWluY2gtcGFyYWxsZWwtY2FwYWNpdGl2ZS10b3Vj
aC1kaXNwbGF5LTgwMHg0ODAtZGF0YXNoZWV0LnBkZg0KPiA+IFsyXSANCj4gPiBodHRwczovL2Rv
Y3MudG9yYWRleC5jb20vMTA0NDk4LTctaW5jaC1wYXJhbGxlbC1yZXNpc3RpdmUtdG91Y2gtZGlz
cGxheS04MDB4NDgwLnBkZg0KPiA+IFszXSANCj4gPiBodHRwczovL2RvY3MudG9yYWRleC5jb20v
MTA1OTUyLTEwLTEtaW5jaC1sdmRzLWNhcGFjaXRpdmUtdG91Y2gtZGlzcGxheS0xMjgweDgwMC1k
YXRhc2hlZXQucGRmDQo+ID4gWzRdIA0KPiA+IGh0dHBzOi8vd3d3LmVuZHJpY2guY29tL2lzaTUw
X2lzaTMwX3RmdC1kaXNwbGF5cy9sdDE3MDQxMC0xd2hjX2lzaTMwDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+
ID4gDQo+ID4gLS0tDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAtIE5ldyBwYXRjaCBh
ZGRpbmcgZGlzcGxheSBwYW5lbCBiaW5kaW5ncyBhcyB3ZWxsIGFzIHN1Z2dlc3RlZCBieQ0KPiA+
IFJvYi4NCj4gPiANCj4gPiAgLi4uL3BhbmVsL2xvZ2ljdGVjaG5vLGx0MTYxMDEwLTJuaGMueWFt
bCAgICAgIHwgNDQNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9wYW5lbC9sb2dp
Y3RlY2hubyxsdDE2MTAxMC0ybmhyLnlhbWwgICAgICB8IDQ0DQo+ID4gKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAuLi4vcGFuZWwvbG9naWN0ZWNobm8sbHQxNzA0MTAtMndoYy55YW1sICAgICAg
fCA0NA0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMzIg
aW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9sb2dpY3RlY2hubyxsdDE2MTAxDQo+
ID4gMC0ybmhjLnlhbWwNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvbG9naWN0ZWNobm8sbHQxNjEwMQ0K
PiA+IDAtMm5oci55YW1sDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL2xvZ2ljdGVjaG5vLGx0MTcwNDEN
Cj4gPiAwLTJ3aGMueWFtbA0KPiANCj4gSSB3b3VsZCBqdXN0IHB1dCB0aGVzZSBpbnRvIDEgZG9j
dW1lbnQgYXMgdGhlIGNvbXBhdGlibGUgaXMgdGhlIG9ubHkgDQo+IGRpZmZlcmVuY2UuDQoNCk5v
LCBub3QgcXVpdGUganVzdCB0aGUgY29tcGF0aWJsZSBhcmUgZGlmZmVyZW50IGFzIHRoZSBmaXJz
dCBhbmQgbGFzdA0KcGFuZWwgZmVhdHVyZSBjYXBhY2l0aXZlIHRvdWNoIHdoaWxlIHRoZSBtaWRk
bGUgb25lIGlzIHJlc2lzdGl2ZSBhbmQNCnRoZSBmaXJzdCB0d28gcGFuZWxzIGFyZSBwYXJhbGxl
bCBSR0Igb25lcyB3aGlsZSB0aGUgbGFzdCBvbmUgaXMgYW4NCkxWRFMgcGFuZWwuDQoNCj4gRWl0
aGVyIHdheToNCj4gDQo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
Pg0KPiANCj4gUm9iDQo=
