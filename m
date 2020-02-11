Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725CCC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1CD2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="KRL78Pg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgBKCTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:19:39 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36906 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgBKCTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:19:39 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9DEF0886BF;
        Tue, 11 Feb 2020 15:19:35 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581387575;
        bh=A5GX5xUW6nLmWiPBZjEPCz4jyaiP4LXwEU7uGYSDH1s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=KRL78Pg9kNyQ+9m1NXh7NLTvjq3p67R0xBpCYz1fj8GKoMyQF5W2EGeCbENthgkUR
         fPrnqyxcbcdFE0JfdEDtwlyMTUETmBI/q/BEO4d1NIORbcj56FEt5itsoKVvD12Wal
         OrT2T1kJXczv+01ivw661lnDgUJamwo/ZP9SMeH3Ym3BMdlFwMPlxDcwdOzmubZbeP
         8u38lcEOvqumaSLk6ZLBWz78u+KxCC69TtBEHdGZJFXRBN+2B0QX1ECt0FyEG09ZOi
         2RrC2eQC8FQzAFDeNMtxqPFD2h2+7NZd/QUWSdAQ2+xqGV2EhyQzlAG5TL+mBbSBk+
         zHudrQ36X8Bjw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e420f370000>; Tue, 11 Feb 2020 15:19:35 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb 2020 15:19:30 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Tue, 11 Feb 2020 15:19:30 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Henry Shen <Henry.Shen@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vadimp@mellanox.com" <vadimp@mellanox.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Add TI LM73 as a trivial device
Thread-Topic: [PATCH] dt-bindings: Add TI LM73 as a trivial device
Thread-Index: AQHV4IGwATGfpWs6Gk2p++pmrLV+Mw==
Date:   Tue, 11 Feb 2020 02:19:29 +0000
Message-ID: <4e5b6e4d9cc254b13d083f4d0b7cd8b6a848d2e4.camel@alliedtelesis.co.nz>
References: <20200205004956.28719-1-henry.shen@alliedtelesis.co.nz>
         <20200205004956.28719-2-henry.shen@alliedtelesis.co.nz>
In-Reply-To: <20200205004956.28719-2-henry.shen@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:7107:d7a8:1069:3b0e]
Content-Type: text/plain; charset="utf-8"
Content-ID: <083577D42D0B3643A5DBD99232BE34E9@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkaW5nIFJvYiBhbmQgdGhlIGRldmljZS10cmVlIG1haWxpbmcgbGlzdC4NCg0KSGkgSGVucnks
DQoNCk9uIFdlZCwgMjAyMC0wMi0wNSBhdCAxMzo0OSArMTMwMCwgSGVucnkgU2hlbiB3cm90ZToN
Cj4gVGhlIFRleGFzIEluc3RydW1lbnRzIExNNzMgaXMgYSBkaWdpdGFsIHRlbXBlcmF0dXJlIHNl
bnNvciB3aXRoIDItd2lyZQ0KPiBpbnRlcmZhY2UuIEFkZCBMTTczIGFzIGEgdHJpdmlhbCBkZXZp
Y2UuDQoNCk5lZWRzIHlvdXIgU2lnbmVkLW9mZi1ieS4NCg0KPiAtLS0NCj4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy90cml2aWFsLWRldmljZXMueWFtbCB8IDIgKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnlhbWwgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnlhbWwNCj4gaW5kZXgg
OTc4ZGU3ZDM3YzY2Li4yMGU2YmFlNjhmZWMgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy90cml2aWFsLWRldmljZXMueWFtbA0KPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnlhbWwNCj4gQEAgLTM1
MCw2ICszNTAsOCBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgICAgIC0gdGksYWRzNzgzMA0KPiAg
ICAgICAgICAgICAgIyBUZW1wZXJhdHVyZSBNb25pdG9yaW5nIGFuZCBGYW4gQ29udHJvbA0KPiAg
ICAgICAgICAgIC0gdGksYW1jNjgyMQ0KPiArICAgICAgICAgICAgIyBUZW1wZXJhdHVyZSBzZW5z
b3Igd2l0aCAyLXdpcmUgaW50ZXJmYWNlDQo+ICsgICAgICAgICAgLSB0aSxsbTczDQo+ICAgICAg
ICAgICAgICAjIFRlbXBlcmF0dXJlIHNlbnNvciB3aXRoIGludGVncmF0ZWQgZmFuIGNvbnRyb2wN
Cj4gICAgICAgICAgICAtIHRpLGxtOTYwMDANCj4gICAgICAgICAgICAgICMgSTJDIFRvdWNoLVNj
cmVlbiBDb250cm9sbGVyDQo=
