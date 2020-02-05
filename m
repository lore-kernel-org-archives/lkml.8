Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34514C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E822082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k4N7IVeZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="X+HwUBb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBEMFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:05:53 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:39956 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbgBEMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:05:52 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0C5DBC0597;
        Wed,  5 Feb 2020 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1580904351; bh=EOkW2IkJtwyhjmP0Z2o8jJVLarggTibA+p6EhERtcE4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=k4N7IVeZhRXY6TL0fkLLGFoslvDn0JaC8hfr52h6c3Cn3U4ShLOuQ11SfmhdFq4/q
         uBuyDvIr5/l7NCKBijP5ImP7vVQpPlsvRYYEYNvHaWECRGXL8Ocy+J7SQcig/n+tBv
         z+Kcr2mGAaTZyPWiT5YEwoQtGxpmT4InGorZZRACs8/jD9MhbYD462OO6KiorWR7M7
         epyPy/jwDJr73wQD2UlXpLEtnTM+wvifNfxshhMvZKoEKp7W5n4ww0jMGT0my4Z0rR
         MJm9qKFzCFMbb4ZWhFUDzj9EhXTnkLoSo+btfmtAbYBn7MF45PBmhcgjwHgxOllh+d
         Xm7vZrkpFjM1w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E8895A0067;
        Wed,  5 Feb 2020 12:05:49 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 5 Feb 2020 04:05:39 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 5 Feb 2020 04:05:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JttMwME1P/JniGexumefLWI62CcCVRrL7kNUa+OSMGNvqHmWFjZcLQO72t6P5cViN74193IrCTT4fs5JYY1YN7R4J/6Il1De3Vp1Xbupby4XxEjqLyAcJOIBeOHj4DCWm+CNsbABa3UrxcWmSASjKq7Y4OfSc7cIAmaJhwZrwmFdPp+7Vzy+nF41oGiuJy1dBLj+0FJz8fp9ncipPoUtwlIrU+QlwivMlGKXd8Mt6JNROAAMiNBfroGhNTEdBSpFz3K9DKo6eyjCYSp7UXjcb0JFzN0YBEo9DT9p6FDvO26MFS0qKvR0ZAIOqPeGoMmxynqnMCCzgMCu5DupTEP8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOkW2IkJtwyhjmP0Z2o8jJVLarggTibA+p6EhERtcE4=;
 b=Jq7+2LSTF3bzL3Js91HBgeXsPKB2GG7Nzcq+3w8azvtNkkDukcAt+O1yPTEp8XDtMVuvA5qYU8zGRuqfHTWlN/BYD2/Ql1HRmY5+qwg96Hoi+yhuRW9fk2mqQ0w4oxxLVbZr0M2YaVpg6uByOQ/2tY5GCO6acsF20nEIxb6a695hZFwnkY+0t07aNWGjALMwI0f0AT0g/2P5KPPC6xLsMJsmD7q2tSIb1GLdguzq0JQUkiNl84SDkwt2XEDO7oQEjSTadaL7AiKVNXFt2tMQCANWv1++YBbNyPrMDFNJZCqmG197ATPz1kyGIECyBKDJKyrATjwnxeN2lZkV7ueRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOkW2IkJtwyhjmP0Z2o8jJVLarggTibA+p6EhERtcE4=;
 b=X+HwUBb7XfkcLKhohfKEhBSwB0eypOfxFNS7d8lzesWd9O9evKICWFgtSHzZW3tU144hoXsspPqnHXQlVTG30xjbDAdKWtWi5og+r2IdWtSwkBRHUUhePVAjhrSIbKBdrrllbW1pqsNVA8FPngkGX7EFpwL3JOnIy+Sm4KPtF9I=
Received: from MN2PR12MB4093.namprd12.prod.outlook.com (52.135.51.203) by
 MN2PR12MB4221.namprd12.prod.outlook.com (52.135.48.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 12:05:38 +0000
Received: from MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::35cf:644a:cfa6:72f8]) by MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::35cf:644a:cfa6:72f8%7]) with mapi id 15.20.2707.020; Wed, 5 Feb 2020
 12:05:38 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Implement set_selfpowered()
Thread-Topic: [PATCH] usb: dwc2: Implement set_selfpowered()
Thread-Index: AQHV23AHZCKSO2mqU0iflYr2FT5Mp6gMPZgAgABCQQCAAAJugA==
Date:   Wed, 5 Feb 2020 12:05:37 +0000
Message-ID: <326e87da-1ac6-33de-1d6f-5ba4852c7e99@synopsys.com>
References: <20200204152933.2216615-1-john@metanate.com>
 <34b74e48-a3ea-f68f-540e-121ae98afb31@synopsys.com>
 <20200205115656.3c698385.john@metanate.com>
In-Reply-To: <20200205115656.3c698385.john@metanate.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 028cff06-d4c5-4940-8e17-08d7aa33b6a0
x-ms-traffictypediagnostic: MN2PR12MB4221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4221C11E6164B0806C3C0306A7020@MN2PR12MB4221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(53546011)(36756003)(6506007)(2906002)(86362001)(31696002)(71200400001)(8676002)(81166006)(8936002)(81156014)(76116006)(110136005)(4326008)(26005)(54906003)(6486002)(186003)(2616005)(5660300002)(66476007)(31686004)(316002)(66556008)(66946007)(66446008)(64756008)(478600001)(6512007)(91956017)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB4221;H:MN2PR12MB4093.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjRfZSI/Mg4daFipR9/2h5O9PAt92A1Sd1uwocgPyNIXbZ8Tjk3+BZzAAW0UqTGB9oiHzFYrUh5y5PsA3enB/sSLQHGkR/scKCVaf3go11RovGgUU79+tcxAh45NbjmERQyBnZxDzO5xELr5geTtoYZFiRpqoYUxI7JKhBseAvoyya5Wsa0SlX16gAWlyOnlMEesLj3l4xxHYE3GpE629CJucTAeMxjV5bZapumSitiF47lBwP+zqY/f1AKO6QzENu/j0n4erFELE8oho6jSBea4K6Mrykv7ooONdYVlJEHEN5GD50jBA0OGqSrJADoZE0KjDs+skSOngKRaUD3chTaVUd5YcYhZqz4I+Bbq5gdJX+Q7N5ftKLACw6SlUfKUfKfU2JgSnMDYiVPEpDsXUaZS4AfjlDJ8zUlenTCqB5cuKzNU9d5PFImGpVWGMxrStcHT5qnz5e3eXNpE5LRHr8NfvIppNoMOyRhxnSU+ZQhYBUhRNYol6HgiK7UQz0YR
x-ms-exchange-antispam-messagedata: gVyiJ1AWKEpnENt5Rq+doY58G7iL/5oKU3KvnkwoQS0L7CmBS0pVIwnkEgncPa8HyXUmVKctMJjkdmrmgFurJxvM7D0iDQ5Ghtu7VxsxW3R+X60D0DouGPxx1IIMSq2osZC0qr5V1V/WWbdh43nDHg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEECEF784E1D6348951277D9310A1CA1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 028cff06-d4c5-4940-8e17-08d7aa33b6a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 12:05:37.7944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adwIaRwJbJ5UDAlyux5oV7TzOxYUwh8wjsMXE24P+EnZS1VCegjtSZca1f2ND5tYBB7sVP4ssLjEtoJA35/mIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDIvNS8yMDIwIDM6NTYgUE0sIEpvaG4gS2VlcGluZyB3cm90ZToNCj4gSGkgTWlu
YXMsDQo+IA0KPiBPbiBXZWQsIDUgRmViIDIwMjAgMDc6NTk6NDggKzAwMDANCj4gTWluYXMgSGFy
dXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+IA0KPj4g
T24gMi80LzIwMjAgNzoyOSBQTSwgSm9obiBLZWVwaW5nIHdyb3RlOg0KPj4+IGR3YzIgYWx3YXlz
IHJlcG9ydHMgYXMgc2VsZi1wb3dlcmVkIGluIHJlc3BvbnNlIHRvIGEgZGV2aWNlIHN0YXR1cw0K
Pj4+IHJlcXVlc3QuICBJbXBsZW1lbnQgdGhlIHNldF9zZWxmcG93ZXJlZCgpIG9wZXJhdGlvbnMg
c28gdGhhdCB0aGUgZ2FkZ2V0DQo+Pj4gY2FuIHJlcG9ydCBhcyBidXMtcG93ZXJlZCB3aGVuIGFw
cHJvcHJpYXRlLg0KPj4+DQo+Pj4gVGhpcyBpcyBtb2RlbGxlZCBvbiB0aGUgZHdjMyBpbXBsZW1l
bnRhdGlvbi4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpvaG4gS2VlcGluZyA8am9obkBtZXRh
bmF0ZS5jb20+DQo+Pg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPGhtaW5hc0BzeW5v
cHN5cy5jb20+DQoNCj4+IEdvb2QgY2F0Y2guIEp1c3Qgb25lIGNvbmNlcm4uIFlvdXIgcGF0Y2gg
cGFydGlhbGx5IGZpeCBteSBwYXRjaCB0aGlzIGlzDQo+PiB3aHkgSSB0aGluayB5b3UgbmVlZCB0
byBhZGQgRml4ZXMgdGFnIG90aGVyd2lzZSBpdCBjYW4gY3JlYXRlIG1lcmdlDQo+PiBjb25mbGlj
dCBpZiB5b3VyIHBhdGNoIHdpbGwgYmUgbWVyZ2VkIHRvIG5leHQgZWFybGllciB0aGFuIG15Lg0K
PiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIGFjdHVhbGx5IGEgZml4IGZvciB5b3VyIHBhdGNo
LCBpdCdzIGEgc2VwYXJhdGUgZml4DQo+IHdoaWNoIGhhcHBlbnMgdG8gdG91Y2ggdGhlIHNhbWUg
Y29kZS4NCj4gDQo+IFNpbmNlIGR3YzIgaGFzIG5ldmVyIHN1cHBvcnRlZCB0aGUgc2V0X3NlbGZw
b3dlcmVkKCkgb3BlcmF0aW9uLCBJJ20gbm90DQo+IHJlYWxseSBzdXJlIGlmIHRoaXMgY291bnRz
IGFzIGEgYnVnZml4IG9yIGEgZmVhdHVyZS4NCj4gDQo+IEknbSBoYXBweSB0byByZS1zZW5kIHdp
dGggYSBmaXhlcyB0YWcgaWYgeW91IHRoaW5rIGl0J3MgbmVjZXNzYXJ5LCBidXQgSQ0KPiBkb24n
dCB0aGluayBpdCdzIGFjY3VyYXRlIGluIHRoaXMgY2FzZSAtIHlvdXIgcGF0Y2ggZGlkIG5vdCBp
bnRyb2R1Y2UgYQ0KPiBidWcgaGVyZSA6LSkNCj4gDQo+IA0KPiBSZWdhcmRzLA0KPiBKb2huDQo+
IA0KPj4+IC0tLQ0KPj4+ICAgIGRyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMgfCAyNCArKysrKysr
KysrKysrKysrKysrKysrKy0NCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIv
Z2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+Pj4gaW5kZXggMjcxN2Y0NDAx
Yjk3Li43NmMwYTUyNDIxNzUgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9nYWRn
ZXQuYw0KPj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4+PiBAQCAtMTY0Niw3
ICsxNjQ2LDggQEAgc3RhdGljIGludCBkd2MyX2hzb3RnX3Byb2Nlc3NfcmVxX3N0YXR1cyhzdHJ1
Y3QgZHdjMl9oc290ZyAqaHNvdGcsDQo+Pj4gICAgDQo+Pj4gICAgCXN3aXRjaCAoY3RybC0+YlJl
cXVlc3RUeXBlICYgVVNCX1JFQ0lQX01BU0spIHsNCj4+PiAgICAJY2FzZSBVU0JfUkVDSVBfREVW
SUNFOg0KPj4+IC0JCXN0YXR1cyA9IDEgPDwgVVNCX0RFVklDRV9TRUxGX1BPV0VSRUQ7DQo+Pj4g
KwkJc3RhdHVzID0gaHNvdGctPmdhZGdldC5pc19zZWxmcG93ZXJlZCA8PA0KPj4+ICsJCQkgVVNC
X0RFVklDRV9TRUxGX1BPV0VSRUQ7DQo+Pj4gICAgCQlzdGF0dXMgfD0gaHNvdGctPnJlbW90ZV93
YWtldXBfYWxsb3dlZCA8PA0KPj4+ICAgIAkJCSAgVVNCX0RFVklDRV9SRU1PVEVfV0FLRVVQOw0K
Pj4+ICAgIAkJcmVwbHkgPSBjcHVfdG9fbGUxNihzdGF0dXMpOw0KPj4+IEBAIC00NTMwLDYgKzQ1
MzEsMjYgQEAgc3RhdGljIGludCBkd2MyX2hzb3RnX2dhZGdldF9nZXRmcmFtZShzdHJ1Y3QgdXNi
X2dhZGdldCAqZ2FkZ2V0KQ0KPj4+ICAgIAlyZXR1cm4gZHdjMl9oc290Z19yZWFkX2ZyYW1lbm8o
dG9faHNvdGcoZ2FkZ2V0KSk7DQo+Pj4gICAgfQ0KPj4+ICAgIA0KPj4+ICsvKioNCj4+PiArICog
ZHdjMl9oc290Z19zZXRfc2VsZnBvd2VyZWQgLSBzZXQgaWYgZGV2aWNlIGlzIHNlbGYvYnVzIHBv
d2VyZWQNCj4+PiArICogQGdhZGdldDogVGhlIHVzYiBnYWRnZXQgc3RhdGUNCj4+PiArICogQGlz
X3NlbGZwb3dlcmVkOiBXaGV0aGVyIHRoZSBkZXZpY2UgaXMgc2VsZi1wb3dlcmVkDQo+Pj4gKyAq
DQo+Pj4gKyAqIFNldCBpZiB0aGUgZGV2aWNlIGlzIHNlbGYgb3IgYnVzIHBvd2VyZWQuDQo+Pj4g
KyAqLw0KPj4+ICtzdGF0aWMgaW50IGR3YzJfaHNvdGdfc2V0X3NlbGZwb3dlcmVkKHN0cnVjdCB1
c2JfZ2FkZ2V0ICpnYWRnZXQsDQo+Pj4gKwkJCQkgICAgICBpbnQgaXNfc2VsZnBvd2VyZWQpDQo+
Pj4gK3sNCj4+PiArCXN0cnVjdCBkd2MyX2hzb3RnICpoc290ZyA9IHRvX2hzb3RnKGdhZGdldCk7
DQo+Pj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4+ICsNCj4+PiArCXNwaW5fbG9ja19pcnFz
YXZlKCZoc290Zy0+bG9jaywgZmxhZ3MpOw0KPj4+ICsJZ2FkZ2V0LT5pc19zZWxmcG93ZXJlZCA9
ICEhaXNfc2VsZnBvd2VyZWQ7DQo+Pj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoc290Zy0+
bG9jaywgZmxhZ3MpOw0KPj4+ICsNCj4+PiArCXJldHVybiAwOw0KPj4+ICt9DQo+Pj4gKw0KPj4+
ICAgIC8qKg0KPj4+ICAgICAqIGR3YzJfaHNvdGdfcHVsbHVwIC0gY29ubmVjdC9kaXNjb25uZWN0
IHRoZSBVU0IgUEhZDQo+Pj4gICAgICogQGdhZGdldDogVGhlIHVzYiBnYWRnZXQgc3RhdGUNCj4+
PiBAQCAtNDYyMSw2ICs0NjQyLDcgQEAgc3RhdGljIGludCBkd2MyX2hzb3RnX3ZidXNfZHJhdyhz
dHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LCB1bnNpZ25lZCBpbnQgbUEpDQo+Pj4gICAgDQo+Pj4g
ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZ2FkZ2V0X29wcyBkd2MyX2hzb3RnX2dhZGdldF9v
cHMgPSB7DQo+Pj4gICAgCS5nZXRfZnJhbWUJPSBkd2MyX2hzb3RnX2dhZGdldF9nZXRmcmFtZSwN
Cj4+PiArCS5zZXRfc2VsZnBvd2VyZWQJPSBkd2MyX2hzb3RnX3NldF9zZWxmcG93ZXJlZCwNCj4+
PiAgICAJLnVkY19zdGFydAkJPSBkd2MyX2hzb3RnX3VkY19zdGFydCwNCj4+PiAgICAJLnVkY19z
dG9wCQk9IGR3YzJfaHNvdGdfdWRjX3N0b3AsDQo+Pj4gICAgCS5wdWxsdXAgICAgICAgICAgICAg
ICAgID0gZHdjMl9oc290Z19wdWxsdXAsDQo+Pj4gICAgDQo+IA0K
