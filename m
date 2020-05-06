Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1899C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDE1206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEFLp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:45:56 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:60176 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgEFLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:45:55 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        by skedge03.snt-world.com (Postfix) with ESMTP id 586F467A6F3;
        Wed,  6 May 2020 13:45:49 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 13:45:48 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Wed, 6 May 2020 13:45:48 +0200
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
Thread-Index: AQHWHu1XU8cnqZiR7kmt3VxL/7fb7aiWVM8AgASDlAA=
Date:   Wed, 6 May 2020 11:45:48 +0000
Message-ID: <0df68f7c-13d2-5bd6-e27a-4bf8534f88fb@kontron.de>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
 <20200430124602.14463-5-frieder.schrempf@kontron.de>
 <CAHCN7xJ=srZxygtG6hW_+us=qH1heY-k=EosavYH9tDk-KG0Bw@mail.gmail.com>
In-Reply-To: <CAHCN7xJ=srZxygtG6hW_+us=qH1heY-k=EosavYH9tDk-KG0Bw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5D0FB36A8FD884AA9AA8B63FC338A6F@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 586F467A6F3.A2ED9
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

T24gMDMuMDUuMjAgMTY6NDksIEFkYW0gRm9yZCB3cm90ZToNCj4gT24gVGh1LCBBcHIgMzAsIDIw
MjAgYXQgNzo0NiBBTSBTY2hyZW1wZiBGcmllZGVyDQo+IDxmcmllZGVyLnNjaHJlbXBmQGtvbnRy
b24uZGU+IHdyb3RlOg0KPj4NCj4+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2No
cmVtcGZAa29udHJvbi5kZT4NCj4+DQo+PiBBY2NvcmRpbmcgdG8gdGhlIGRvY3VtZW50cywgdGhl
IGkuTVg4TS1NaW5pIGZlYXR1cmVzIGEgR0MzMjAgYW5kIGENCj4+IEdDTmFub1VsdHJhIEdQVSBj
b3JlLiBFdG5hdml2IGRldGVjdHMgdGhlbSBhczoNCj4+DQo+PiAgICAgICAgICBldG5hdml2LWdw
dSAzODAwMDAwMC5ncHU6IG1vZGVsOiBHQzYwMCwgcmV2aXNpb246IDQ2NTMNCj4+ICAgICAgICAg
IGV0bmF2aXYtZ3B1IDM4MDA4MDAwLmdwdTogbW9kZWw6IEdDNTIwLCByZXZpc2lvbjogNTM0MQ0K
Pj4NCj4+IFRoaXMgc2VlbXMgdG8gd29yayBmaW5lIG1vcmUgb3IgbGVzcyB3aXRob3V0IGFueSBj
aGFuZ2VzIHRvIHRoZSBIV0RCLA0KPj4gd2hpY2ggc3RpbGwgbWlnaHQgYmUgbmVlZGVkIGluIHRo
ZSBmdXR1cmUgdG8gY29ycmVjdCBzb21lIGZlYXR1cmVzLA0KPj4gZXRjLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4N
Cj4+IC0tLQ0KPiBTaW5jZSBub3QgZXZlcnlvbmUgdXNlcyB0aGUgM0Qgb3IgMkQsIHdvdWxkIGl0
IG1ha2Ugc2Vuc2UgdG8gbWFyayB0aGVtDQo+IGFzIGRpc2FibGVkIGJ5IGRlZmF1bHQgYW5kIGxl
dCBwZW9wbGUgd2hvIG5lZWQgdGhlIDNEIGFuZCAyRCBlbmFibGUNCj4gdGhlbSBhdCB0aGVpciBy
ZXNwZWN0aXZlIGJvYXJkIGZpbGVzPw0KDQpJIHdvdWxkIHJhdGhlciBrZWVwIGl0IHRoZSB3YXkg
aXQgaGFzIGJlZW4gZG9uZSBmb3Igb3RoZXIgU29Dcy4gTG9va2luZyANCmF0IHRoZSBpLk1YNiBk
ZXZpY2V0cmVlcywgdGhleSBhbGwgc2VlbSB0byBoYXZlIHRoZSBHUFVzIGVuYWJsZWQgYnkgZGVm
YXVsdC4=
