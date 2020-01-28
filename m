Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E042C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEDF206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QueoJBd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA1UaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:30:07 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52478 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbgA1UaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:30:07 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SKSfSF032459;
        Tue, 28 Jan 2020 21:29:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=dZMb6Jsfq4sPYbLiWw1LM0ambnif8LS+pRCn5Rru/bE=;
 b=QueoJBd+JJ/vIOhgWsY4z2bZSurXJhS8ysLSo93SnIJlJHaaAh4C0wTN6sOg5vnbhskr
 q5nSjpeIexfK5aWdUXGEksKPRkod9hmXV72cZUAkqZ/31HZBrItlQgYVGl+PzddP7qSO
 Id5rQrpkFlQj87DCZqKrjIItJJfNYP94HcEyuCVtPVFr+xSeK11z6JdbkZ+qjr4Un2Mr
 is4Z/VdSsKGoFKGDvqTHd5ID9TzWTCcV8asDAuclHyNA3nKS5+Z0QllwzD9F3/ulB3qq
 7+IiFp1V8O6lVqBZvhiiOesIsuSwErtK/7VtheNmw/cno9sirtB0p6jwCAgk4y3Wf8H5 lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdekfqe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 21:29:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ECE2810002A;
        Tue, 28 Jan 2020 21:29:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node3.st.com [10.75.127.21])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B70702A4D7F;
        Tue, 28 Jan 2020 21:29:45 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE3.st.com
 (10.75.127.21) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 21:29:45 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 28 Jan 2020 21:29:45 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "lkml@metux.net" <lkml@metux.net>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
Thread-Topic: [PATCH v2 2/7] bus: Introduce firewall controller framework
Thread-Index: AQHV1fD3WqS5xyjWNkazyajQl95bjqgAKU6AgAANnwCAAARlAIAAO2IA
Date:   Tue, 28 Jan 2020 20:29:45 +0000
Message-ID: <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com>
 <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
 <20200128165712.GA3667596@kroah.com>
In-Reply-To: <20200128165712.GA3667596@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E760C473F999D14C87C2BB3A9D1F67E5@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_07:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI4LzIwIDU6NTcgUE0sIEdyZWcgS0ggd3JvdGU6DQo+IE9uIFR1ZSwgSmFuIDI4LCAy
MDIwIGF0IDA0OjQxOjI5UE0gKzAwMDAsIEJlbmphbWluIEdBSUdOQVJEIHdyb3RlOg0KPj4gT24g
MS8yOC8yMCA0OjUyIFBNLCBHcmVnIEtIIHdyb3RlOg0KPj4+IE9uIFR1ZSwgSmFuIDI4LCAyMDIw
IGF0IDA0OjM4OjAxUE0gKzAxMDAsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4+PiBUaGUg
Z29hbCBvZiB0aGlzIGZyYW1ld29yayBpcyB0byBvZmZlciBhbiBpbnRlcmZhY2UgZm9yIHRoZQ0K
Pj4+PiBoYXJkd2FyZSBibG9ja3MgY29udHJvbGxpbmcgYnVzIGFjY2Vzc2VzIHJpZ2h0cy4NCj4+
Pj4NCj4+Pj4gQnVzIGZpcmV3YWxsIGNvbnRyb2xsZXJzIGFyZSB0eXBpY2FsbHkgdXNlZCB0byBj
b250cm9sIGlmIGENCj4+Pj4gaGFyZHdhcmUgYmxvY2sgY2FuIHBlcmZvcm0gcmVhZCBvciB3cml0
ZSBvcGVyYXRpb25zIG9uIGJ1cy4NCj4+PiBTbyBwdXQgdGhpcyBpbiB0aGUgYnVzLXNwZWNpZmlj
IGNvZGUgdGhhdCBjb250cm9scyB0aGUgYnVzIHRoYXQgdGhlc2UNCj4+PiBkZXZpY2VzIGxpdmUg
b24uICBXaHkgcHV0IGl0IGluIHRoZSBkcml2ZXIgY29yZSB3aGVuIHRoaXMgaXMgb25seSBvbiBv
bmUNCj4+PiAiYnVzIiAoaS5lLiB0aGUgY2F0Y2gtYWxsLWFuZC1hLWJhZy1vZi1jaGlwcyBwbGF0
Zm9ybSBidXMpPw0KPj4gSXQgaXMgcmVhbGx5IHNpbWlsYXIgdG8gd2hhdCBwaW4gY29udHJvbGxl
ciBkb2VzLCBjb25maWd1cmluZyBhbg0KPj4gaGFyZHdhcmUgYmxvY2sgZ2l2ZW4gRFQgaW5mb3Jt
YXRpb24uDQo+IEdyZWF0LCB0aGVuIHVzZSB0aGF0IGluc3RlYWQgOikNCkkgdGhpbmsgdGhhdCBM
aW51cyBXLiB3aWxsIGNvbXBsYWluIGlmIEkgZG8gdGhhdCA6KQ0KPg0KPj4gSSBjb3VsZCBhcmd1
ZSB0aGF0IGZpcmV3YWxscyBhcmUgbm90IGJ1cyB0aGVtc2VsdmVzIHRoZXkgb25seSBpbnRlcmFj
dA0KPj4gd2l0aCBpdC4NCj4gVGhleSBsaXZlIG9uIGEgYnVzLCBhbmQgZG8gc28gaW4gYnVzLXNw
ZWNpZmljIHdheXMsIHJpZ2h0Pw0KPg0KPj4gQnVzIGZpcmV3YWxscyBleGlzdCBvbiBvdGhlciBT
b0MsIEkgaG9wZSBzb21lIG90aGVycyBjb3VsZCBiZSBhZGRlZCBpbg0KPj4gdGhpcyBmcmFtZXdv
cmsuIEVUWlBDIGlzIG9ubHkgdGhlIGZpcnN0Lg0KPiBUaGVuIHB1dCBpdCBvbiB0aGUgYnVzIGl0
IGxpdmVzIG9uLCBhbmQgdGhlIGJ1cyB0aGF0IHRoZSBkcml2ZXJzIGZvcg0KPiB0aGF0IGRldmlj
ZSBhcmUgYmVpbmcgY29udHJvbGxlZCB3aXRoLiAgVGhhdCBzb3VuZHMgbGlrZSB0aGUgc2FuZSBw
bGFjZQ0KPiB0byBkbyBzbywgcmlnaHQ/DQoNCklmIHRoYXQgbWVhbnMgdGhhdCBhbGwgZHJpdmVy
cyBoYXZlIHRvIGJlIG1vZGlmaWVkIGl0IHdpbGwgYmUgDQpwcm9ibGVtYXRpYyBiZWNhdXNlIG5v
dCBhbGwNCg0KYXJlIHNwZWNpZmljcyB0byB0aGUgU29DLg0KDQo+DQo+Pj4gQW5kIHJlYWxseSwg
dGhpcyBzaG91bGQganVzdCBiZSBhIHRvdGFsbHkgbmV3IGJ1cyB0eXBlLCByaWdodD8gIEFuZCBh
bnkNCj4+PiBkZXZpY2VzIG9uIHRoaXMgYnVzIHNob3VsZCBiZSBjaGFuZ2VkIHRvIGJlIG9uIHRo
aXMgbmV3IGJ1cywgYW5kIHRoZQ0KPj4+IGRyaXZlcnMgY2hhbmdlZCB0byBzdXBwb3J0IHRoZW0s
IGluc3RlYWQgb2YgdHJ5aW5nIHRvIG92ZXJsb2FkIHRoZQ0KPj4+IHBsYXRmb3JtIGJ1cyB3aXRo
IG1vcmUgc3R1ZmYuDQo+PiBJIGhhdmUgdHJpZWQgdG8gdXNlIHRoZSBidXMgbm90aWZpZXIgdG8g
YXZvaWQgdG8gYWRkIHRoaXMgY29kZSBhdCBwcm9iZQ0KPj4gdGltZSBidXQgd2l0aG91dCBzdWNj
ZXNzOg0KPj4NCj4+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzIvMjcvMzAwDQo+IEFsbW9z
dCAyIHllYXJzIGFnbz8gIEkgY2FuJ3QgcmVtZW1iZXIgc29tZXRoaW5nIHdyaXR0ZW4gMSB3ZWVr
IGFnby4uLg0KPg0KPiBZZXMsIGRvbid0IGFidXNlIHRoZSBub3RpZmllciBjaGFpbi4gIEkgaGF0
ZSB0aGF0IHRoaW5nIGFzIGl0IGlzLg0KPg0KPj4gSSBoYXZlIGFsc28gdHJpZWQgdG8gZGlzYWJs
ZSB0aGUgbm9kZXMgYXQgcnVudGltZSBhbmQgTWFyayBSdXRsYW5kDQo+PiBleHBsYWluIG1lIHdo
eSBpdCB3YXMgd3JvbmcuDQo+IFRoZSBidXMgY29udHJvbGxlciBzaG91bGQgZG8gdGhpcywgcmln
aHQ/ICBXaHkgbm90IGp1c3QgZG8gaXQgdGhlcmU/DQoNClRoZSBidXMgY29udHJvbGxlciBpcyBh
IGRpZmZlcmVudCBoYXJkd2FyZSBibG9jay4NCg0KDQo+DQo+IHRoYW5rcywNCj4NCj4gZ3JlZyBr
LWg=
