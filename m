Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C6EC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C27820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="UjMAiyHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgBCNQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:16:30 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24068 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727308AbgBCNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:16:30 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013DDkls004591;
        Mon, 3 Feb 2020 14:16:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=eKUMSsfaSS3DKlATW7x6z4h915ZK9Rxrx5+47GP+oO0=;
 b=UjMAiyHOT8Fu8d4vUAU3a7Hvbnnq8oyswQi8MrJnN5IZXT6ikxda3A+R/pIbUPNLBpWD
 np2VhXcDJjL8gGrLlY9LI12rSQIhdtgGCsXekDK4EneWYf0hGqSLdFD2Xp4np5uFFNcE
 EwX3uPZ6xRam0eP79AGFS2o60gTqcNoZk5JzdXnJwTempTWQA1Ubn4fsXmJrMNyI8xlf
 JGD3bWQH1/yOcdM4PNIRJmMLEKxQHgzfx0aD81jccIrWxUy5lHse168GwUCBcr2hR7Oc
 KEaS44W6m8q7QYoP06LY6xRahOdQEUS9cdnOTN8cBMmvha+BC5T6gM7K0qp//TVA9b24 xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvybdsgjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 14:16:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5544610002A;
        Mon,  3 Feb 2020 14:16:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node1.st.com [10.75.127.19])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3943A2CD0EC;
        Mon,  3 Feb 2020 14:16:03 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE1.st.com
 (10.75.127.19) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 14:16:02 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 3 Feb 2020 14:16:02 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
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
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/7] Introduce bus firewall controller framework
Thread-Topic: [PATCH v2 0/7] Introduce bus firewall controller framework
Thread-Index: AQHV1fD3HkoxlN8gBkO/naZ6SuTotagANYcAgAAC24CAAAijAIAALxcAgAAhvgCAAQS1gIADdFSAgARgoQA=
Date:   Mon, 3 Feb 2020 13:16:02 +0000
Message-ID: <df6fcb24-2357-af1d-8060-1a9ca0064758@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128163628.GB30489@bogus> <7f54ec36-8022-a57a-c634-45257f4c6984@st.com>
 <20200128171639.GA36496@bogus> <26eb1fde-5408-43f0-ccba-f0c81e791f54@st.com>
 <6a6ba7ff-7ed9-e573-63ca-66fca609075b@arm.com>
 <c4d5c46a-7f90-ff2b-9496-26102114c5e6@st.com>
 <3624ec3e-b06a-907d-ebfa-8516b14cb306@arm.com>
In-Reply-To: <3624ec3e-b06a-907d-ebfa-8516b14cb306@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF77F517FFAD2C458C9E80E1C7A101E4@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_04:2020-02-02,2020-02-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzMxLzIwIDc6MjUgUE0sIFJvYmluIE11cnBoeSB3cm90ZToNCj4gT24gMjkvMDEvMjAy
MCAxOjQwIHBtLCBCZW5qYW1pbiBHQUlHTkFSRCB3cm90ZToNCj4+DQo+PiBPbiAxLzI4LzIwIDEx
OjA2IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+Pj4gT24gMjAyMC0wMS0yOCA4OjA2IHBtLCBC
ZW5qYW1pbiBHQUlHTkFSRCB3cm90ZToNCj4+Pj4NCj4+Pj4gT24gMS8yOC8yMCA2OjE3IFBNLCBT
dWRlZXAgSG9sbGEgd3JvdGU6DQo+Pj4+PiBPbiBUdWUsIEphbiAyOCwgMjAyMCBhdCAwNDo0Njo0
MVBNICswMDAwLCBCZW5qYW1pbiBHQUlHTkFSRCB3cm90ZToNCj4+Pj4+PiBPbiAxLzI4LzIwIDU6
MzYgUE0sIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+Pj4+Pj4gT24gVHVlLCBKYW4gMjgsIDIwMjAg
YXQgMDQ6Mzc6NTlQTSArMDEwMCwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6DQo+Pj4+Pj4+PiBC
dXMgZmlyZXdhbGwgZnJhbWV3b3JrIGFpbXMgdG8gcHJvdmlkZSBhIGtlcm5lbCBBUEkgdG8gc2V0
IHRoZQ0KPj4+Pj4+Pj4gY29uZmlndXJhdGlvbg0KPj4+Pj4+Pj4gb2YgdGhlIGhhcndhcmUgYmxv
Y2tzIGluIGNoYXJnZSBvZiBidXNzZXMgYWNjZXNzIGNvbnRyb2wuDQo+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4gRnJhbWV3b3JrIGFyY2hpdGVjdHVyZSBpcyBpbnNwaXJhdGVkIGJ5IHBpbmN0cmwgZnJhbWV3
b3JrOg0KPj4+Pj4+Pj4gLSBhIGRlZmF1bHQgY29uZmlndXJhdGlvbiBjb3VsZCBiZSBhcHBsaWVk
IGJlZm9yZSBiaW5kIHRoZSBkcml2ZXIuDQo+Pj4+Pj4+PiDCoMKgwqDCoMKgIElmIGEgY29uZmln
dXJhdGlvbiBjb3VsZCBub3QgYmUgYXBwbGllZCB0aGUgZHJpdmVyIGlzIG5vdCANCj4+Pj4+Pj4+
IGJpbmQNCj4+Pj4+Pj4+IMKgwqDCoMKgwqAgdG8gYXZvaWQgZG9pbmcgYWNjZXNzZXMgb24gcHJv
aGliaXRlZCByZWdpb25zLg0KPj4+Pj4+Pj4gLSBjb25maWd1cmF0aW9ucyBjb3VsZCBiZSBhcGxs
aWVkIGR5bmFtaWNhbGx5IGJ5IGRyaXZlcnMuDQo+Pj4+Pj4+PiAtIGRldmljZSBub2RlIHByb3Zp
ZGVzIHRoZSBidXMgZmlyZXdhbGwgY29uZmlndXJhdGlvbnMuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4g
QW4gZXhhbXBsZSBvZiBidXMgZmlyZXdhbGwgY29udHJvbGxlciBpcyBTVE0zMiBFVFpQQyBoYXJk
d2FyZSANCj4+Pj4+Pj4+IGJsb2NrDQo+Pj4+Pj4+PiB3aGljaCBnb3QgMyBwb3NzaWJsZSBjb25m
aWd1cmF0aW9uczoNCj4+Pj4+Pj4+IC0gdHJ1c3Q6IGhhcmR3YXJlIGJsb2NrcyBhcmUgb25seSBh
Y2Nlc3NpYmxlIGJ5IHNvZnR3YXJlIHJ1bm5pbmcNCj4+Pj4+Pj4+IG9uIHRydXN0DQo+Pj4+Pj4+
PiDCoMKgwqDCoMKgIHpvbmUgKGkuZSBvcC10ZWUgZmlybXdhcmUpLg0KPj4+Pj4+Pj4gLSBub24t
c2VjdXJlOiBoYXJkd2FyZSBibG9ja3MgYXJlIGFjY2Vzc2libGUgYnkgbm9uLXNlY3VyZQ0KPj4+
Pj4+Pj4gc29mdHdhcmUgKGkuZS4NCj4+Pj4+Pj4+IMKgwqDCoMKgwqAgbGludXgga2VybmVsKS4N
Cj4+Pj4+Pj4+IC0gY29wcm9jZXNzb3I6IGhhcmR3YXJlIGJsb2NrcyBhcmUgb25seSBhY2Nlc3Np
YmxlIGJ5IHRoZQ0KPj4+Pj4+Pj4gY29wcm9jZXNzb3IuDQo+Pj4+Pj4+PiBVcCB0byA5NCBoYXJk
d2FyZSBibG9ja3Mgb2YgdGhlIHNvYyBjb3VsZCBiZSBtYW5hZ2VkIGJ5IEVUWlBDLg0KPj4+Pj4+
Pj4NCj4+Pj4+Pj4gL21lIGNvbmZ1c2VkLiBJcyBFVFpQQyBhY2Nlc3NpYmxlIGZyb20gdGhlIG5v
bi1zZWN1cmUga2VybmVsIA0KPj4+Pj4+PiBzcGFjZSB0bw0KPj4+Pj4+PiBiZWdpbiB3aXRoID8g
SWYgc28sIGlzIGl0IGFsbG93ZWQgdG8gY29uZmlndXJlIGhhcmR3YXJlIGJsb2NrcyBhcw0KPj4+
Pj4+PiBzZWN1cmUNCj4+Pj4+Pj4gb3IgdHJ1c3RlZCA/IEkgYW0gZmFpbGluZyB0byB1bmRlcnN0
YW5kIHRoZSBvdmVyYWxsIGRlc2lnbiBvZiBhDQo+Pj4+Pj4+IHN5c3RlbQ0KPj4+Pj4+PiB3aXRo
IEVUWlBDIGNvbnRyb2xsZXIuDQo+Pj4+Pj4gTm9uLXNlY3VyZSBrZXJuZWwgY291bGQgcmVhZCB0
aGUgdmFsdWVzIHNldCBpbiBFVFpQQywgaWYgaXQgZG9lc24ndA0KPj4+Pj4+IG1hdGNoDQo+Pj4+
Pj4gd2l0aCB3aGF0IGlzIHJlcXVpcmVkIGJ5IHRoZSBkZXZpY2Ugbm9kZSB0aGUgZHJpdmVyIHdv
bid0IGJlIHByb2JlZC4NCj4+Pj4+Pg0KPj4+Pj4gT0ssIGJ1dCBJIHdhcyB1bmRlciB0aGUgaW1w
cmVzc2lvbiB0aGF0IGl0IHdhcyBtYWRlIGNsZWFyIHRoYXQgDQo+Pj4+PiBMaW51eCBpcw0KPj4+
Pj4gbm90IGZpcm13YXJlIHZhbGlkYXRpb24gc3VpdGUuIFRoZSBmaXJtd2FyZSBuZWVkIHRvIGVu
c3VyZSBhbGwgdGhlDQo+Pj4+PiBkZXZpY2VzDQo+Pj4+PiB0aGF0IGFyZSBub3QgYWNjZXNzaWJs
ZSBpbiB0aGUgTGludXgga2VybmVsIGFyZSBtYXJrZWQgYXMgZGlzYWJsZWQgDQo+Pj4+PiBhbmQN
Cj4+Pj4+IHRoaXMgbmVlZHMgdG8gaGFwcGVuIGJlZm9yZSBlbnRlcmluZyB0aGUga2VybmVsLiBT
byBpZiB0aGlzIGlzIHdoYXQNCj4+Pj4+IHRoaXMNCj4+Pj4+IHBhdGNoIHNlcmllcyBhY2hpZXZl
cywgdGhlbiB0aGVyZSBpcyBubyBuZWVkIGZvciBpdC4gUGxlYXNlIHN0b3ANCj4+Pj4+IHB1cnN1
aW5nDQo+Pj4+PiB0aGlzIGFueSBmdXJ0aGVyIG9yIHByb3ZpZGUgYW55IG90aGVyIHJlYXNvbnMo
aWYgYW55KSB0byBoYXZlIGl0LiANCj4+Pj4+IFVudGlsDQo+Pj4+PiB5b3UgaGF2ZSBvdGhlciBy
ZWFzb25zLCBOQUNLIGZvciB0aGlzIHNlcmllcy4NCj4+Pj4NCj4+Pj4gTm8gaXQgZG9lc24ndCBk
aXNhYmxlIHRoZSBub2Rlcy4NCj4+Pj4NCj4+Pj4gV2hlbiB0aGUgZmlybXdhcmUgZGlzYWJsZSBh
IG5vZGUgYmVmb3JlIHRoZSBrZXJuZWwgdGhhdCBtZWFucyBpdCANCj4+Pj4gY2hhbmdlDQo+Pj4+
DQo+Pj4+IHRoZSBEVEIgYW5kIHRoYXQgaXMgYSBwcm9ibGVtIHdoZW4geW91IHdhbnQgdG8gc2ln
biBpdC4gV2l0aCBteSANCj4+Pj4gcHJvcG9zYWwNCj4+Pj4NCj4+Pj4gdGhlIERUQiByZW1haW5z
IHRoZSBzYW1lLg0KPj4+DQo+Pj4gPz8/DQo+Pj4NCj4+PiA6Lw0KPj4+DQo+Pj4gVGhlIERUQiBp
cyB1c2VkIHRvIHBhc3MgdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUsIG1lbW9yeSByZXNlcnZhdGlv
bnMsDQo+Pj4gcmFuZG9tIHNlZWRzLCBhbmQgYWxsIG1hbm5lciBvZiBvdGhlciB0aGluZ3MgZHlu
YW1pY2FsbHkgZ2VuZXJhdGVkIGJ5DQo+Pj4gZmlybXdhcmUgYXQgYm9vdC10aW1lLiBBcG9sb2dp
ZXMgZm9yIGJlaW5nIGJsdW50IGJ1dCBpZiAiY2hhbmdpbmcgdGhlDQo+Pj4gRFRCIiBpcyBjb25z
aWRlcmVkIGEgcHJvYmxlbSB0aGVuIEkgY2FuJ3QgaGVscCBidXQgdGhpbmsgeW91J3JlIGRvaW5n
DQo+Pj4gaXQgd3JvbmcuDQo+Pg0KPj4gWWVzIGJ1dCBJIHdvdWxkIGxpa2UgdG8gbGltaXQgdGhl
IG51bWJlciBvZiBjYXNlcyB3aGVyZSBhIGZpcm13YXJlIGhhcw0KPj4gdG8gY2hhbmdlIHRoZSBE
VEIuDQo+DQo+IFN1cmUsIGJ1dCB1bmxlc3MgeW91IGNhbiBsaW1pdCB0aGF0IG51bWJlciB0byBz
dHJpY3RseSB6ZXJvLCB0aGVuIA0KPiBwcmVzdW1hYmx5IHRoZSBmaXJtd2FyZSBtdXN0IGhhdmUg
dGhlIGdlbmVyYWwgY2FwYWJpbGl0eSB0byB2ZXJpZnksIA0KPiBtb2RpZnksIGFuZCByZS1zaWdu
IGEgRFRCLiBBdCB0aGF0IHBvaW50IGhhdmluZyBpdCBhbHNvIHR3ZWFrIHRoZSANCj4gc3RhdHVz
IG9mIG5vZGVzIHRoYXQgaXQgd2FudHMgZm9yIGl0c2VsZiBkb2Vzbid0IHNlZW0gbGlrZSBhIA0K
PiBwYXJ0aWN1bGFybHkgYmlnIGFzay4NCj4NCj4+IFdpdGggdGhpcyBwcm9wb3NhbCBub2RlcyBy
ZW1haW4gdGhlIHNhbWUgYW5kIGVtYmVkZGVkIHRoZSBmaXJld2FsbA0KPj4gY29uZmlndXJhdGlv
bihzKS4NCj4+DQo+PiBVbnRpbCBub3cgZmlyZXdhbGwgY29uZmlndXJhdGlvbiBpcyAic3RhdGlj
IiwgdGhlIGZpcm13YXJlIGRpc2FibGUgKG9yDQo+PiByZW1vdmUpIHRoZSBub2RlcyBub3QgYWNj
ZXNzaWJsZSBmcm9tIExpbnV4Lg0KPj4NCj4+IElmIExpbnV4IGNhbiByZWx5IG9uIG5vZGUncyBm
aXJld2FsbCBpbmZvcm1hdGlvbiBpdCBjb3VsZCBhbGxvdyBzd2l0Y2gNCj4+IGR5bmFtaWNhbGx5
IGFuIGhhcmR3YXJlIGJsb2NrIGZyb20gTGludXggdG8gYSBjb3Byb2Nlc3Nvci4NCj4+DQo+PiBG
b3IgZXhhbXBsZSBMaW51eCBjb3VsZCBtYW5hZ2UgdGhlIGRpc3BsYXkgcGlwZSBjb25maWd1cmF0
aW9uIGFuZCB3aGVuDQo+PiBnb2luZyB0byBzdXNwZW5kIGhhbmRvdmVyIHRoZSBkaXNwbGF5IGhh
cmR3YXJlIGJsb2NrIHRvIGEgY29wcm9jZXNzb3IgaW4NCj4+IGNoYXJnZSBhIHJlZnJlc2hpbmcg
b25seSBzb21lIHBpeGVscy4NCj4NCj4gQW5kIGxpa2UgSSdtIHN1cmUgSSBzYWlkIGJlZm9yZSwg
dGhlIGludGVyZmFjZSBiZXR3ZWVuIExpbnV4IGFuZCB0aGUgDQo+IFNlY3VyZSBlbnZpcm9ubWVu
dCB0byB1bHRpbWF0ZWx5IGFjaGlldmUgdGhhdCB3aWxsIGFsbW9zdCBjZXJ0YWlubHkgDQo+IG1h
a2UgaW5zcGVjdGluZyBhIHBhc3NpdmUgc3RhdHVzIGJpdCBpbiBhIHJlZ2lzdGVyIHJlZHVuZGFu
dCBhbnl3YXkuDQoNCkl0IGlzIG5vdCBvbmx5IGFib3V0IHNlY3VyZSBhbmQgbm9uIHNlY3VyZSBo
YXJkd2FyZSBibG9ja3Mgc3BsaXQgYnV0IA0KYWxzbyBhYm91dCB0aGUgc3BsaXQgd2l0aCB0aGUg
Y29wcm9jZXNzb3IuDQoNClRoZSBnb2FsIGlzIHRvIGRlc2NyaWJlLCBpbiB0aGUgZGV2aWNlIHRy
ZWUsIHRoZXNlIHBvc3NpYmxlIA0KY29uZmlndXJhdGlvbnMgdG8gYmUgYWJsZSB0byB1c2UgdGhl
bSBkeW5hbWljYWxseSByYXRoZXIgdGhhbg0KDQpoYXZpbmcgYSBzdGF0aWMgY29uZmlndXJhdGlv
bi4gSXQgY291bGQgYWxzbyBoZWxwIHRvIGRldGVjdCANCm1pc2NvbmZpZ3VyYXRpb24gYmV0d2Vl
biB0aGUgZmlyZXdhbGwgYW5kIHRoZSBEVCBub2Rlcy4NCg0KPg0KPiBJbiB0aGUgaW50ZXJlc3Qg
b2YgYmVpbmcgcHJvZHVjdGl2ZSwgdGhvdWdoLCB0aGVyZSBpcyBhbm90aGVyIHdheSBvZiANCj4g
bG9va2luZyBhdCB0aGlzLiBJZiB3ZSBkcm9wIHRoZSBwcmV0ZW5jZSB0aGF0IGl0J3MgaW4gYW55
IHdheSBnZW5lcmljIA0KPiBvciBldmVyIGdvaW5nIHRvIGJlIHJlbGV2YW50IGJleW9uZCBjZXJ0
YWluIGNvbmZpZ3VyYXRpb25zIG9mIGNlcnRhaW4gDQo+IFNUTWljcm8gU29DcywgdGhlbiBpbiBw
bGFpbiB0ZXJtcyBpdCdzIGp1c3Qgc29tZSBibG9jayBvZiBNTUlPIA0KPiByZWdpc3RlcnMgdGhh
dCBoYXZlICpzb21ldGhpbmcqIHRvIGRvIHdpdGggdmFyaW91cyBvdGhlciBkZXZpY2VzLiBBdCAN
Cj4gdGhhdCBwb2ludCwgdGhlIGFuc3dlciBpcyBqdXN0IHRvIHRyZWF0IGl0IGFzIGEgc3lzY29u
IGFuZCBtYWtlIHRoZSANCj4gcmVsZXZhbnQgZHJpdmVycyBmb3IgdGhvc2UgU29DcyBhd2FyZSBv
ZiBpdC4gSSdtIG1vc3QgZmFtaWxpYXIgd2l0aCANCj4gdGhlICJHZW5lcmFsIFJlZ2lzdGVyIEZp
bGUiIG9uIFJvY2tjaGlwIFNvQ3MgYXMgYSBwcmltZSBleGFtcGxlIG9mIA0KPiAiYnVuY2ggb2Yg
cmVnaXN0ZXJzIHRoYXQgcmVsYXRlIHRvIHRoZSBpbnRlZ3JhdGlvbiBvZiB2YXJpb3VzIElQIA0K
PiBibG9ja3MiLCB3aGljaCBtYW5hZ2VzIHRvIGJlIHN1cHBvcnRlZCBqdXN0IGZpbmUgd2l0aG91
dCBpbnZhc2l2ZSANCj4gaG9va3MgaW4gdGhlIGRyaXZlciBjb3JlLg0KDQpJIGhhZCB0aG91Z2h0
IHRvIHVzZSBzeXNjb24gYnV0IHRoZXJlIGlzIHNvbWUgcHJvYmxlbXMgd2l0aCB0aGF0IHdheTog
aWYgDQp0aGUgZmlyZXdhbGwgaGFyZHdhcmUgY2hhbmdlIHRoZSB3YXkgaXQgZW5jb2RlIHRoZSBp
bmZvcm1hdGlvbiB5b3UgaGF2ZSANCmNoYW5nZSBhbGwgaXQgY3VzdG9tZXJzLiBUaGF0IHdvdWxk
IG1lYW4gYWRkIGluIGVhY2ggZHJpdmVyIGEgdGVzdCB0byANCmRldGVjdCB0aGUgZmlyZXdhbGwg
dmVyc2lvbiBhbmQgYWN0IGFjY29yZGluZ2x5LiBUaGF0IGRvZXNuJ3Qgc291bmQgDQpyZWFzb25h
YmxlIHRvIG1lIHNvIEkgZGVjaWRlIHRvIGNyZWF0ZSBhbiBpbnRlcmZhY2UgdG8gYWJzdHJhY3Qg
dGhlIA0KZmlyZXdhbGwgdG8gYXZvaWQgdGhpcyBwcm9ibGVtLg0KDQpJIGNvdWxkIHJldXNlIHRo
aXMgaW50ZXJmYWNlIGluIHRoZSB+NDAgaW1wYWN0ZWQgZHJpdmVycyAobm90IGFsbCANCmRlZGlj
YXRlZCB0byBTVE1pY3JvIFNvQ3MpIGJ1dCBhZGRpbmcgaXQgaW4gdGhlIGRyaXZlciBjb3JlIGFz
IGEgZ2VuZXJpYyANCnNlcnZpY2Ugd2FzIG1ha2luZyBtb3JlIHNlbnMgZm9yIG1lLiBOb3RlIHRo
YXQgSSBoYXZlIHRha2UgY2FyZSBvZiB1c2luZyANCmEgY29tcGlsYXRpb24gZmxhZyB0byBub3Qg
aW1wYWN0IHRoZSBvdGhlcnMgYXJjaGl0ZWN0dXJlcy4NCg0KQmVuamFtaW4NCg0KPg0KPiBSb2Jp
bi4=
