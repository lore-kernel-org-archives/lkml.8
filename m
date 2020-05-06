Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D60C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E779206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgEFL7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:59:34 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:40186 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgEFL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:59:33 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        by skedge04.snt-world.com (Postfix) with ESMTP id 283B267A887;
        Wed,  6 May 2020 13:59:27 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 13:59:26 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Wed, 6 May 2020 13:59:26 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Adam Ford <aford173@gmail.com>
CC:     Anson Huang <Anson.Huang@nxp.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Li Jun" <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] arm64: dts: imx8mm: Add GPU nodes for 2D and 3D
 core using Etnaviv
Thread-Topic: [RFC PATCH 4/4] arm64: dts: imx8mm: Add GPU nodes for 2D and 3D
 core using Etnaviv
Thread-Index: AQHWHu1XU8cnqZiR7kmt3VxL/7fb7aiWVM8AgASDlACAAAPOgA==
Date:   Wed, 6 May 2020 11:59:26 +0000
Message-ID: <c9379cdb-cd53-804b-a214-bfee3022a859@kontron.de>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
 <20200430124602.14463-5-frieder.schrempf@kontron.de>
 <CAHCN7xJ=srZxygtG6hW_+us=qH1heY-k=EosavYH9tDk-KG0Bw@mail.gmail.com>
 <0df68f7c-13d2-5bd6-e27a-4bf8534f88fb@kontron.de>
In-Reply-To: <0df68f7c-13d2-5bd6-e27a-4bf8534f88fb@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <44F5D1A06A190C449A968796CBDACFE2@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 283B267A887.AF18A
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: aford173@gmail.com, anson.huang@nxp.com,
        christian.gmeiner@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org, festevam@gmail.com, jun.li@nxp.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, linux+etnaviv@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYuMDUuMjAgMTM6NDUsIEZyaWVkZXIgU2NocmVtcGYgd3JvdGU6DQo+IE9uIDAzLjA1LjIw
IDE2OjQ5LCBBZGFtIEZvcmQgd3JvdGU6DQo+PiBPbiBUaHUsIEFwciAzMCwgMjAyMCBhdCA3OjQ2
IEFNIFNjaHJlbXBmIEZyaWVkZXINCj4+IDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+IHdy
b3RlOg0KPj4+DQo+Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBr
b250cm9uLmRlPg0KPj4+DQo+Pj4gQWNjb3JkaW5nIHRvIHRoZSBkb2N1bWVudHMsIHRoZSBpLk1Y
OE0tTWluaSBmZWF0dXJlcyBhIEdDMzIwIGFuZCBhDQo+Pj4gR0NOYW5vVWx0cmEgR1BVIGNvcmUu
IEV0bmF2aXYgZGV0ZWN0cyB0aGVtIGFzOg0KPj4+DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBldG5h
dml2LWdwdSAzODAwMDAwMC5ncHU6IG1vZGVsOiBHQzYwMCwgcmV2aXNpb246IDQ2NTMNCj4+PiDC
oMKgwqDCoMKgwqDCoMKgIGV0bmF2aXYtZ3B1IDM4MDA4MDAwLmdwdTogbW9kZWw6IEdDNTIwLCBy
ZXZpc2lvbjogNTM0MQ0KPj4+DQo+Pj4gVGhpcyBzZWVtcyB0byB3b3JrIGZpbmUgbW9yZSBvciBs
ZXNzIHdpdGhvdXQgYW55IGNoYW5nZXMgdG8gdGhlIEhXREIsDQo+Pj4gd2hpY2ggc3RpbGwgbWln
aHQgYmUgbmVlZGVkIGluIHRoZSBmdXR1cmUgdG8gY29ycmVjdCBzb21lIGZlYXR1cmVzLA0KPj4+
IGV0Yy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIu
c2NocmVtcGZAa29udHJvbi5kZT4NCj4+PiAtLS0NCj4+IFNpbmNlIG5vdCBldmVyeW9uZSB1c2Vz
IHRoZSAzRCBvciAyRCwgd291bGQgaXQgbWFrZSBzZW5zZSB0byBtYXJrIHRoZW0NCj4+IGFzIGRp
c2FibGVkIGJ5IGRlZmF1bHQgYW5kIGxldCBwZW9wbGUgd2hvIG5lZWQgdGhlIDNEIGFuZCAyRCBl
bmFibGUNCj4+IHRoZW0gYXQgdGhlaXIgcmVzcGVjdGl2ZSBib2FyZCBmaWxlcz8NCj4gDQo+IEkg
d291bGQgcmF0aGVyIGtlZXAgaXQgdGhlIHdheSBpdCBoYXMgYmVlbiBkb25lIGZvciBvdGhlciBT
b0NzLiBMb29raW5nIA0KPiBhdCB0aGUgaS5NWDYgZGV2aWNldHJlZXMsIHRoZXkgYWxsIHNlZW0g
dG8gaGF2ZSB0aGUgR1BVcyBlbmFibGVkIGJ5IA0KPiBkZWZhdWx0Lg0KDQpBaCwgSSBoYWQgbWlz
c2VkIEx1Y2FzIHJlcGx5LiBIZSBhbHJlYWR5IHByb3ZpZGVkIG11Y2ggYmV0dGVyIGFyZ3VtZW50
cyANCmZvciBrZWVwaW5nIHRoZSBHUFVzIGVuYWJsZWQgYnkgZGVmYXVsdC4=
