Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A01C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFF62465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="j/zSANJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgA1UG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:06:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25492 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726007AbgA1UG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:06:26 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SK3OAv001771;
        Tue, 28 Jan 2020 21:06:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=QtK10QkzspDmDSuwJ4qZX17Wym1ujmLQHvWb3VQQQCw=;
 b=j/zSANJkMXggcHeczRzJ1ZsbFtjRAAAPdv3PLOceITUwQQ7/4fC/tbhyWm0XLR7prqeW
 fe0ewA0J27Sx9vcGM/bJUnwcDE6BzhIbzsvcFmRzX0Y6Zk6plLjzn9Ew12Dzi84yNfqc
 W7F45BU/4Eb27E6XP2CyKm3cS8Aeaz2R4EQVNdoETAFMm2I/b+hftRQ9+mByseY8pjEE
 i3A9BzJqdR+X4rZEauvpcwnJJ3uX+mvDN//hefVYyjH2mfAkVLJHga6gt6xU/8a1JKO4
 4RP9reRD30Fgfx4PbNtMf93ghtcBYs8UCpSjgB2JlAWJOTXqqj9BN1VoM9c8BdH67eIc JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpayx6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 21:06:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E5B710002A;
        Tue, 28 Jan 2020 21:06:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node1.st.com [10.75.127.19])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D0632B5E6A;
        Tue, 28 Jan 2020 21:06:09 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE1.st.com
 (10.75.127.19) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 21:06:08 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 28 Jan 2020 21:06:08 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "lkml@metux.net" <lkml@metux.net>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Robin.Murphy@arm.com" <Robin.Murphy@arm.com>
Subject: Re: [PATCH v2 0/7] Introduce bus firewall controller framework
Thread-Topic: [PATCH v2 0/7] Introduce bus firewall controller framework
Thread-Index: AQHV1fD3HkoxlN8gBkO/naZ6SuTotagANYcAgAAC24CAAAijAIAALxcA
Date:   Tue, 28 Jan 2020 20:06:08 +0000
Message-ID: <26eb1fde-5408-43f0-ccba-f0c81e791f54@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128163628.GB30489@bogus> <7f54ec36-8022-a57a-c634-45257f4c6984@st.com>
 <20200128171639.GA36496@bogus>
In-Reply-To: <20200128171639.GA36496@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <66B307CE2705F7409AD5AB7A8A9F7E04@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_07:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI4LzIwIDY6MTcgUE0sIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MjgsIDIwMjAgYXQgMDQ6NDY6NDFQTSArMDAwMCwgQmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+
PiBPbiAxLzI4LzIwIDU6MzYgUE0sIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+PiBPbiBUdWUsIEph
biAyOCwgMjAyMCBhdCAwNDozNzo1OVBNICswMTAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToN
Cj4+Pj4gQnVzIGZpcmV3YWxsIGZyYW1ld29yayBhaW1zIHRvIHByb3ZpZGUgYSBrZXJuZWwgQVBJ
IHRvIHNldCB0aGUgY29uZmlndXJhdGlvbg0KPj4+PiBvZiB0aGUgaGFyd2FyZSBibG9ja3MgaW4g
Y2hhcmdlIG9mIGJ1c3NlcyBhY2Nlc3MgY29udHJvbC4NCj4+Pj4NCj4+Pj4gRnJhbWV3b3JrIGFy
Y2hpdGVjdHVyZSBpcyBpbnNwaXJhdGVkIGJ5IHBpbmN0cmwgZnJhbWV3b3JrOg0KPj4+PiAtIGEg
ZGVmYXVsdCBjb25maWd1cmF0aW9uIGNvdWxkIGJlIGFwcGxpZWQgYmVmb3JlIGJpbmQgdGhlIGRy
aXZlci4NCj4+Pj4gICAgIElmIGEgY29uZmlndXJhdGlvbiBjb3VsZCBub3QgYmUgYXBwbGllZCB0
aGUgZHJpdmVyIGlzIG5vdCBiaW5kDQo+Pj4+ICAgICB0byBhdm9pZCBkb2luZyBhY2Nlc3NlcyBv
biBwcm9oaWJpdGVkIHJlZ2lvbnMuDQo+Pj4+IC0gY29uZmlndXJhdGlvbnMgY291bGQgYmUgYXBs
bGllZCBkeW5hbWljYWxseSBieSBkcml2ZXJzLg0KPj4+PiAtIGRldmljZSBub2RlIHByb3ZpZGVz
IHRoZSBidXMgZmlyZXdhbGwgY29uZmlndXJhdGlvbnMuDQo+Pj4+DQo+Pj4+IEFuIGV4YW1wbGUg
b2YgYnVzIGZpcmV3YWxsIGNvbnRyb2xsZXIgaXMgU1RNMzIgRVRaUEMgaGFyZHdhcmUgYmxvY2sN
Cj4+Pj4gd2hpY2ggZ290IDMgcG9zc2libGUgY29uZmlndXJhdGlvbnM6DQo+Pj4+IC0gdHJ1c3Q6
IGhhcmR3YXJlIGJsb2NrcyBhcmUgb25seSBhY2Nlc3NpYmxlIGJ5IHNvZnR3YXJlIHJ1bm5pbmcg
b24gdHJ1c3QNCj4+Pj4gICAgIHpvbmUgKGkuZSBvcC10ZWUgZmlybXdhcmUpLg0KPj4+PiAtIG5v
bi1zZWN1cmU6IGhhcmR3YXJlIGJsb2NrcyBhcmUgYWNjZXNzaWJsZSBieSBub24tc2VjdXJlIHNv
ZnR3YXJlIChpLmUuDQo+Pj4+ICAgICBsaW51eCBrZXJuZWwpLg0KPj4+PiAtIGNvcHJvY2Vzc29y
OiBoYXJkd2FyZSBibG9ja3MgYXJlIG9ubHkgYWNjZXNzaWJsZSBieSB0aGUgY29wcm9jZXNzb3Iu
DQo+Pj4+IFVwIHRvIDk0IGhhcmR3YXJlIGJsb2NrcyBvZiB0aGUgc29jIGNvdWxkIGJlIG1hbmFn
ZWQgYnkgRVRaUEMuDQo+Pj4+DQo+Pj4gL21lIGNvbmZ1c2VkLiBJcyBFVFpQQyBhY2Nlc3NpYmxl
IGZyb20gdGhlIG5vbi1zZWN1cmUga2VybmVsIHNwYWNlIHRvDQo+Pj4gYmVnaW4gd2l0aCA/IElm
IHNvLCBpcyBpdCBhbGxvd2VkIHRvIGNvbmZpZ3VyZSBoYXJkd2FyZSBibG9ja3MgYXMgc2VjdXJl
DQo+Pj4gb3IgdHJ1c3RlZCA/IEkgYW0gZmFpbGluZyB0byB1bmRlcnN0YW5kIHRoZSBvdmVyYWxs
IGRlc2lnbiBvZiBhIHN5c3RlbQ0KPj4+IHdpdGggRVRaUEMgY29udHJvbGxlci4NCj4+IE5vbi1z
ZWN1cmUga2VybmVsIGNvdWxkIHJlYWQgdGhlIHZhbHVlcyBzZXQgaW4gRVRaUEMsIGlmIGl0IGRv
ZXNuJ3QgbWF0Y2gNCj4+IHdpdGggd2hhdCBpcyByZXF1aXJlZCBieSB0aGUgZGV2aWNlIG5vZGUg
dGhlIGRyaXZlciB3b24ndCBiZSBwcm9iZWQuDQo+Pg0KPiBPSywgYnV0IEkgd2FzIHVuZGVyIHRo
ZSBpbXByZXNzaW9uIHRoYXQgaXQgd2FzIG1hZGUgY2xlYXIgdGhhdCBMaW51eCBpcw0KPiBub3Qg
ZmlybXdhcmUgdmFsaWRhdGlvbiBzdWl0ZS4gVGhlIGZpcm13YXJlIG5lZWQgdG8gZW5zdXJlIGFs
bCB0aGUgZGV2aWNlcw0KPiB0aGF0IGFyZSBub3QgYWNjZXNzaWJsZSBpbiB0aGUgTGludXgga2Vy
bmVsIGFyZSBtYXJrZWQgYXMgZGlzYWJsZWQgYW5kDQo+IHRoaXMgbmVlZHMgdG8gaGFwcGVuIGJl
Zm9yZSBlbnRlcmluZyB0aGUga2VybmVsLiBTbyBpZiB0aGlzIGlzIHdoYXQgdGhpcw0KPiBwYXRj
aCBzZXJpZXMgYWNoaWV2ZXMsIHRoZW4gdGhlcmUgaXMgbm8gbmVlZCBmb3IgaXQuIFBsZWFzZSBz
dG9wIHB1cnN1aW5nDQo+IHRoaXMgYW55IGZ1cnRoZXIgb3IgcHJvdmlkZSBhbnkgb3RoZXIgcmVh
c29ucyhpZiBhbnkpIHRvIGhhdmUgaXQuIFVudGlsDQo+IHlvdSBoYXZlIG90aGVyIHJlYXNvbnMs
IE5BQ0sgZm9yIHRoaXMgc2VyaWVzLg0KDQpObyBpdCBkb2Vzbid0IGRpc2FibGUgdGhlIG5vZGVz
Lg0KDQpXaGVuIHRoZSBmaXJtd2FyZSBkaXNhYmxlIGEgbm9kZSBiZWZvcmUgdGhlIGtlcm5lbCB0
aGF0IG1lYW5zIGl0IGNoYW5nZQ0KDQp0aGUgRFRCIGFuZCB0aGF0IGlzIGEgcHJvYmxlbSB3aGVu
IHlvdSB3YW50IHRvIHNpZ24gaXQuIFdpdGggbXkgcHJvcG9zYWwNCg0KdGhlIERUQiByZW1haW5z
IHRoZSBzYW1lLg0KDQo+DQo+IE5vdGUgeW91IGhhdmVuJ3QgY2MtZWQgMiBwZW9wbGUgd2hvIGhh
cyBjb21tZW50cyBlYXJsaWVyWzFdWzJdDQpJIHdpbGwgY2MgdGhlbSwgdGhhbmtzDQo+IC0tDQo+
IFJlZ2FyZHMsDQo+IFN1ZGVlcA0KPg0KPiBbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgv
Mi8yNy81MTINCj4gWzJdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzIvMjcvNTk4
