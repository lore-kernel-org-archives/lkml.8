Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A890C7114E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED6F222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cSzEnT08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgBOMlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 07:41:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37150 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgBOMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 07:41:52 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01FCd4pS026279;
        Sat, 15 Feb 2020 13:41:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=maaDk/azENS4baRBQqHcVa4rKgzogN8NBTTBrKI34WU=;
 b=cSzEnT08Ym/LkLeV+cSkcDLPWePdrfLGU6LBkvlsvkAtn1lw7oc5GZnkLNy/nSj2MbSj
 pUgANszC6CRWNc/cjWBjG3HLmXfeWgyKEQVuLyEeLM+hizDpImHUY8scF9l8AQc4vgnx
 zpnYA6qrkPbCq/K3FdJb10dhdVOtgWSlL9lhKx/si5RcVyO37z42/U8r/xGT6uErqscL
 C1mALHQDOcSExIROZmK/5+U/Jg56XqL6Z4E31uvgrmWkEDgfPgFwBUdzU1FL8ucCA73I
 9iJbpInnPck3+AzjIUz3LRqQQeqtRUushYhGx/n26zH7nMNs37RwAE/79atjAxyPxXnD /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y6705a8c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Feb 2020 13:41:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F7DA10002A;
        Sat, 15 Feb 2020 13:41:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node3.st.com [10.75.127.21])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CBB7A2B39E6;
        Sat, 15 Feb 2020 13:41:07 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE3.st.com
 (10.75.127.21) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 15 Feb
 2020 13:41:07 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Sat, 15 Feb 2020 13:41:07 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Grant Likely <grant.likely@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
Thread-Topic: [PATCH v2 2/7] bus: Introduce firewall controller framework
Thread-Index: AQHV1fD3WqS5xyjWNkazyajQl95bjqgAKU6AgAANnwCAAARlAIAAO2IAgADdioCAAALMAIAAF6SAgAL4AQCAAAg2AIAWdYKAgABdzYCAAPuHAA==
Date:   Sat, 15 Feb 2020 12:41:07 +0000
Message-ID: <409eb745-aab2-86a7-bd3a-9e8e05bed057@st.com>
References: <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
 <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
 <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
 <20200129095240.GA3852081@kroah.com> <20200129111717.GA3928@sirena.org.uk>
 <0b109c05-24cf-a1c4-6072-9af8a61f45b2@st.com>
 <20200131090650.GA2267325@kroah.com>
 <CACRpkdajhivkOkZ63v-hr7+6ObhTffYOx5uZP0P-MYvuVnyweA@mail.gmail.com>
 <20200214214051.GA4192967@kroah.com>
In-Reply-To: <20200214214051.GA4192967@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A06384E1ADEF80438FC62DE73245951C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-15_03:2020-02-14,2020-02-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyLzE0LzIwIDEwOjQwIFBNLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBGcmksIEZlYiAxNCwg
MjAyMCBhdCAwNTowNTowN1BNICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPj4gT24gRnJp
LCBKYW4gMzEsIDIwMjAgYXQgMTA6MDYgQU0gR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOg0KPj4NCj4+PiBXaHkgZG8gcGVvcGxlIHdhbnQgdG8gYWJ1c2UgdGhlIHBs
YXRmb3JtIGJ1cyBzbyBtdWNoPyAgSWYgYSBkZXZpY2UgaXMgb24NCj4+PiBhIGJ1cyB0aGF0IGNh
biBoYXZlIHN1Y2ggYSBjb250cm9sbGVyLCB0aGVuIGl0IGlzIG9uIGEgcmVhbCBidXMsIHVzZSBp
dCENCj4+IEknbSBub3Qgc2F5aW5nIGl0IGlzIGEgZ29vZCB0aGluZywgYnV0IHRoZSByZWFzb24g
d2h5IGl0IGlzIChhYil1c2VkIHNvDQo+PiBtdWNoIGNhbiBiZSBmb3VuZCBpbjoNCj4+IGRyaXZl
cnMvb2YvcGxhdGZvcm0uYw0KPj4NCj4+IFRMO0RSOiBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIGlz
IHRoZSBEZXZpY2UgTWNEZXZpY2VGYWNlIGFuZA0KPj4gcGxhdGZvcm0gYnVzIHRoZSBCdXMgTWNC
dXNGYWNlIHVzZWQgYnkgdGhlIGRldmljZSB0cmVlIHBhcnNlciBzaW5jZQ0KPj4gaXQgaXMgc2xp
Z2h0bHkgdG8gY29tcGxldGVseSB1bmF3YXJlIG9mIHdoYXQgZGV2aWNlcyBpdCBpcyBhY3R1YWxs
eQ0KPj4gc3Bhd25pbmcuDQo+IDxzbmlwPg0KPg0KPiBZZWFoLCBncmVhdCBleHBsYWluYXRpb24s
IGFuZCBJIHVuZGVyc3RhbmQuICBEVCBzdHVmZiByZWFsbHkgaXMgb2sgdG8gYmUNCj4gb24gYSBw
bGF0Zm9ybSBidXMsIGFzIHRoYXQncyB3aGF0IGFsbW9zdCBhbGwgb2YgdGhlbSBhcmUuDQo+DQo+
IEJ1dCwgd2hlbiB5b3UgdHJ5IHRvIHN0YXJ0IG1lc3NpbmcgYXJvdW5kIHdpdGggdGhpbmdzIGxp
a2UgdGhpcw0KPiAiZmlyZXdhbGwiIHNheXMgaXQgaXMgZG9pbmcsIGl0J3MgdGhlbiBvYnZpb3Vz
IHRoYXQgdGhpcyByZWFsbHkgaXNuJ3QgYQ0KPiBEVCBsaWtlIHRoaW5nLCBidXQgcmF0aGVyIHlv
dSBkbyBoYXZlIGEgYnVzIGludm9sdmVkIHdpdGggYSBjb250cm9sbGVyDQo+IHNvIHRoYXQgc2hv
dWxkIGJlIHVzZWQgaW5zdGVhZC4NCg0KT2sgYnV0IGhvdyBwdXQgaW4gcGxhY2UgYSBuZXcgYnVz
IHdoaWxlIGtlZXBpbmcgdGhlIGRldmljZXMgb24gcGxhdGZvcm0NCmJ1cyB0byBhdm9pZCBjaGFu
Z2luZyBhbGwgdGhlIGRyaXZlcnMgPw0KDQo+DQo+IE9yIGp1c3QgZmlsdGVyIGF3YXkgdGhlIERU
IHN0dWZmIHNvIHRoYXQgdGhlIGtlcm5lbCBuZXZlciBldmVuIHNlZXMNCj4gdGhvc2UgZGV2aWNl
cywgd2hpY2ggbWlnaHQganVzdCBiZSBzaW1wbGVzdCA6KQ0KDQp5ZXMgYnV0IHdlIGxvc3QgdGhl
IHBvc3NpYmlsaXR5IHRvIGNoYW5nZSB0aGUgZmlyZXdhbGwgY29uZmlndXJhdGlvbiBhdA0KcnVu
IHRpbWUuIEkgZG8gZXhwZWN0IHRvIGJlIGFibGUgdG8gZGVzY3JpYmUgaW4gdGhlIERUIGZpcmV3
YWxsIGNvbmZpZ3VyYXRpb24NCmFuZCB0byB1c2UgdGhlbSBhdCBydW4gdGltZS4gVGhhdCBjb3Vs
ZCBhbGxvdywgZm9yIGV4YW1wbGUsIHRvIGhhbmRvdmVyDQphIEhXIGJsb2NrIHRvIHRoZSBjb3By
b2Nlc3NvciB3aGVuIHRoZSBtYWluIGNvcmUgaXMgZ29pbmcgdG8gYmUgc3VzcGVuZGVkDQp0byBz
YXZlIHBvd2VyLg0KDQpCZW5qYW1pbg0KDQo+DQo+IHRoYW5rcywNCj4NCj4gZ3JlZyBrLWg=
