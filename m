Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CDAC2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816B52072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gqAeQAnN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="muM4Cywo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438167AbgDNKJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:09:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48766 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438130AbgDNKJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:09:47 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 47DE2C009A;
        Tue, 14 Apr 2020 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586858986; bh=2r8w/c/FilHUE7izw1Qk0Pu9lamY3aAG3/wommZCXdw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gqAeQAnNZ+7+NabDNGCbd1edUufsXxhJ+cRd7lzRRfx/n96UkhrC7iq7AunjZurmS
         AvpqI7yNqK+gI4z5vNMY2ZdOp3x/Wz/2rPL/RoK+jWKI0sJqFO3NX7bBLKMFIjP5Eu
         cBKEcDJp+9kLhEiJWn/qtcY3jnZisEe5V89FZlrZMAkDzPmOg4TxREPOR0uZShVHqo
         orWUIH0IFby+1pdFB+hu0B0+YhPSek+JbPVaER338ZDz3Sd8oqlg8wioJ0t1lRKK1J
         6UCbuvGSuV1pnCZXfp01guc7WX4+qO2tdhiYG3GavLIa+zm+y+U/27ZdTc7GpiBpTB
         ztNOp5/ZKMVDQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8C2B4A008A;
        Tue, 14 Apr 2020 10:09:45 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 Apr 2020 03:09:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 14 Apr 2020 03:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS+JUp/TIVW8QxsvO34fe1ohBdzdPwbTv452XeKMtstdp5Su6Ii9VwCdiYQ+sX9i8Qv3Lmoequxvfjxw0g/4L9Z6HzI+7ZWpokXRI7BU/3NOIIokcck7q+hx4f6Z750Hh92iefmBXmAbd88e0S1m+HYzKICkpmM4+zl4gkHIXVAdXbkHr9oXWtvNZxYF54hNcZIbSCV6t5sy4YNSLf+hSxt+llliIaqqx/dI22/EPM870VLZ3cbStHWh2TBlVhEAGYDCACPYyOn7jYJXGKkk/nIFg0kL5nw8k3KCsZaL9LDwWkITOmyHMZX4xHvYslhcmv1RXMRr+ALf75RuusJq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r8w/c/FilHUE7izw1Qk0Pu9lamY3aAG3/wommZCXdw=;
 b=AgdDqZAM+UHWNMDtJdP74fDgqsIZJoh8mVR582P2P8F/gF3zdDiF2nzigHk4ScpYFzOFhOHyC+8zOnqGDTeIBo4LJ85AnnSuUpiJlt2hGmXohWKszp2OHrmzQAQODx9f8zIKedKaGUy0tuylHRsoEz1Yh9ay0tIud9DInaWiEODKONahBRx69A0Xs7fVnE8sPrirApRaXXnMWe9YOb+uMe7X8kap1wkZW+lyT2A72XYzxo7aj4pGLTcPCVl/WGU+UkelAVlnFniLo1sRJAQfZ00e6ssqV8q6/KvATrWo6lVVQ/HPW2Qszj5hyAZzax1DPifFCXFqtuIzqVB8Y8jBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r8w/c/FilHUE7izw1Qk0Pu9lamY3aAG3/wommZCXdw=;
 b=muM4CywoJ37G2gM4mB/uw35mwhUpaCvyPDNcHspg2pVDAIZkIqrNrTXrzvaeNttF1d2zJ1HSrAX1abkTqOAO7EXqBockJP9+DpGDqLIcL8OorOPJtHxzBcgrF5egE0qXlZ6Egm62KdwEuIqBuaEOImZMXcm/Phe220FhVFVabGE=
Received: from DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Tue, 14 Apr
 2020 10:09:36 +0000
Received: from DM6PR12MB4251.namprd12.prod.outlook.com
 ([fe80::7809:7719:df21:9539]) by DM6PR12MB4251.namprd12.prod.outlook.com
 ([fe80::7809:7719:df21:9539%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 10:09:36 +0000
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
To:     Rob Herring <robh@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Youn <John.Youn@synopsys.com>
Subject: Re: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Thread-Topic: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Thread-Index: AQHWCuwLvvH52um5KUelC2TK68yepqh4c8CA
Date:   Tue, 14 Apr 2020 10:09:36 +0000
Message-ID: <fe59318a-b3dd-c6af-702e-1ca4aed04a8b@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
 <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
 <20200405014548.GA25539@bogus>
In-Reply-To: <20200405014548.GA25539@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joglekar@synopsys.com; 
x-originating-ip: [157.49.150.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86f46cd6-105c-40f4-b70b-08d7e05bef8a
x-ms-traffictypediagnostic: DM6PR12MB3211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3211E478837FC035B51EB0BBA4DA0@DM6PR12MB3211.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4251.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(366004)(39850400004)(376002)(396003)(346002)(66946007)(66446008)(66476007)(64756008)(6486002)(8936002)(76116006)(91956017)(478600001)(81156014)(86362001)(36756003)(31696002)(2906002)(66556008)(4326008)(6512007)(5660300002)(26005)(186003)(107886003)(6506007)(2616005)(8676002)(31686004)(71200400001)(54906003)(110136005)(53546011)(316002)(142933001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJQWvKpWKRp3Dxzla7bvq/swkAyeOV2D4CofdWNopUJZ4OMNnEO3N4PB7ocObhXuMrIns8xS7T2tjtbLKS5VsjI4xd28GWLKdV6NgjajDP5ghxqBjH/tDyggDEug2TOD7BBO7wYqG26r5TFSTz1NwwY2CqNWErH6JQ3nLpH11F3orj9DuTq9nx3rBHGwGThthvw+SYKLDJHpHoLRGgIZZf+WwRz3848qSvjY4gdwRyEAcQzF4xY2wbYMlmW4NHegEwh0rNM5lSgjKCRgqH2InKXWFcHUI/esJpkfRHKGUGhjdDnjaZQGrVTP367F9IRIVqvAFegbOZ+PK+PiqbG59lqQKoAqOAOSOttGbLGusYDt3eI6YaVM3uyhAHsNnMFZLQQuckjAzljbv78Y6b1MBaTD81ij02oXRQB5/NdAVABKCngNNtB91389HoD4ga0I7r3rXseCyNTPR8VJRCGkL4bysXsKrbM2YPz1Ti96nwWQvcmmbXSEzqV2ciA0V0eD
x-ms-exchange-antispam-messagedata: ursDCo/hhKGrYfXzAHwB26vQQGrEh/NUfg+d68iuypgs4hbdKYQmeKpIGAooGWGfI1H/rnE4OMa+u/UkZ7c4xL2+zMIVLzcMXdY+9EiyIS2YFDjPE2hkhKfB0mZ42iu6tqcbbt9wj88unMfLrABboQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ACE03974CED764BBE48C740152FD99F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f46cd6-105c-40f4-b70b-08d7e05bef8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 10:09:36.1247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2u5BQi/bpbocbJK4mUjRZqil5dAJKHFJ24jRHrrgV3ThE6V1WAdnWZNxMWyK85fh1NW8FkRBhvZoo/bzYinPKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpPbiA0LzUvMjAyMCA3OjE1IEFNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gRnJpLCBN
YXIgMjcsIDIwMjAgYXQgMDM6MTE6NTZQTSArMDUzMCwgVGVqYXMgSm9nbGVrYXIgd3JvdGU6DQo+
PiBUaGlzIGNvbW1pdCBhZGRzIHRoZSBkb2N1bWVudGF0aW9uIGZvciBjb25zb2xpZGF0ZS1zZ2ws
IGFuZA0KPj4gc25wcyxjb25zb2xpZGF0ZS1zZ2wgcHJvcGVydHkuIFRoZXNlIHdoZW4gc2V0IGVu
YWJsZXMgdGhlIHF1aXJrIGZvcg0KPj4gWEhDSSBkcml2ZXIgZm9yIGNvbnNvbGlkYXRpb24gb2Yg
c2cgbGlzdCBpbnRvIGEgdGVtcG9yYXJ5IGJ1ZmZlciB3aGVuIHNtYWxsDQo+PiBidWZmZXIgc2l6
ZXMgYXJlIHNjYXR0ZXJlZCBvdmVyIHRoZSBzZyBsaXN0IG5vdCBtYWtpbmcgdXAgdG8gTVBTIG9y
IHRvdGFsDQo+PiB0cmFuc2ZlciBzaXplIHdpdGhpbiBUUkIgY2FjaGUgc2l6ZSB3aXRoIFN5bm9w
c3lzIHhIQy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUZWphcyBKb2dsZWthciA8am9nbGVrYXJA
c3lub3BzeXMuY29tPg0KPj4gLS0tDQo+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9kd2MzLnR4dCAgICAgfCAzICsrKw0KPj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy91c2IvdXNiLXhoY2kudHh0IHwgMyArKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvdXNiL2R3YzMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9kd2MzLnR4dA0KPj4gaW5kZXggOTk0NmZmOWJhNzM1Li4yOTJkMWY3OTY5ZTQg
MTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3
YzMudHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3
YzMudHh0DQo+PiBAQCAtMTA0LDYgKzEwNCw5IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+PiAg
CQkJdGhpcyBhbmQgdHgtdGhyLW51bS1wa3QtcHJkIHRvIGEgdmFsaWQsIG5vbi16ZXJvIHZhbHVl
DQo+PiAgCQkJMS0xNiAoRFdDX3VzYjMxIHByb2dyYW1taW5nIGd1aWRlIHNlY3Rpb24gMS4yLjMp
IHRvDQo+PiAgCQkJZW5hYmxlIHBlcmlvZGljIEVTUyBUWCB0aHJlc2hvbGQuDQo+PiArIC0gc25w
cyxjb25zb2xpZGF0ZS1zZ2w6IGVuYWJsZSBzZyBsaXN0IGNvbnNvbGlkYXRpb24gLSBob3N0IG1v
ZGUgb25seS4gU2V0IHRvIHVzZQ0KPj4gKwkJCVNHIGJ1ZmZlcnMgb2YgYXQgbGVhc3QgTVBTIHNp
emUgYnkgY29uc29saWRhdGluZyBzbWFsbGVyIFNHDQo+PiArCQkJYnVmZmVycyBsaXN0IGludG8g
YSBzaW5nbGUgYnVmZmVyLg0KPiANCj4gVGhlIHByZWZlcmVuY2UgaXMgbm90IHRvIGtlZXAgYWRk
aW5nIHByb3BlcnRpZXMgZm9yIGV2ZXJ5IHNpbmdsZSBxdWlyayANCj4gb3IgZmVhdHVyZS4gVGhl
c2Ugc2hvdWxkIGJlIGltcGxpZWQgYnkgc3BlY2lmaWMgY29tcGF0aWJsZXMuIEFzIFN5bm9wc3lz
IA0KPiBrbm93cyB3aGF0IHF1aXJrcy9lcnJhdGEvZmVhdHVyZXMgYXJlIGluIGVhY2ggdmVyc2lv
biBvZiBJUCwgdGhlIA0KPiBjb21wYXRpYmxlIHN0cmluZ3Mgc2hvdWxkIHJlZmxlY3QgdGhvc2Ug
dmVyc2lvbnMuIChBbmQgeWVzLCBJJ20gc3VyZSANCj4gdGhlcmUncyBjdXN0b21lciBFQ08gZml4
ZXMgdGhhdCBhcmVuJ3QgcmVmbGVjdGVkIGluIHRoZSB2ZXJzaW9uLCBidXQgDQo+IHRoYXQncyB3
aHkgd2UgaGF2ZSBTb0Mgc3BlY2lmaWMgY29tcGF0aWJsZXMgdG9vLikgVGhpcyBpcyB0aGUgb25s
eSB3YXkgDQo+IHdlIGNhbiBmaXggcXVpcmtzIGluIHRoZSBPUyB3aXRob3V0IGRvaW5nIERUIHVw
ZGF0ZXMuIEZvciBjb21wYXJpc29uLCBkbyANCj4geW91IHdhbnQgdG8gaGF2ZSB0byB1cGRhdGUg
eW91ciBQQyBCSU9TIHNvIGFuIE9TIGNhbiB3b3JrLWFyb3VuZCBpc3N1ZXM/DQo+DQpZZXMsIEkg
dW5kZXJzdGFuZCB3aGF0IHlvdSB3YW50IHRvIHNheSBoZXJlLiBCdXQgSSB0aGluayB0aGlzIGNv
bXBhdGlibGUgc3RyaW5nDQpkb2VzIG5vdCB3b3JrIHdpdGggdGhlIHBsYXRmb3JtIGRyaXZlcnMg
d2l0aCBQQ0kgYmFzZWQgc3lzdGVtcy4gU28gYmFzZWQgb24gdGhlIHZlbmRvciANCmlkIGFuZCBk
ZXZpY2UgaWQgdGhlbiBJIG5lZWQgdG8gc2V0IHRoZSBxdWlyayByZXF1aXJlZC4gDQoNCkBGZWxp
cGU6IFdoYXQgZG8geW91IHN1Z2dlc3QgZm9yIHNldHRpbmcgdXAgcXVpcmsgd2l0aG91dCB0aGUg
RFQgdXBkYXRlIGZvciBkd2MzPw0KIA0KPiBSb2INCj4gDQoNClRoYW5rcyAmIFJlZ2FyZHMsDQog
VGVqYXMgSm9nbGVrYXINCg0K
