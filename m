Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23F0C3524F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7848122522
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="BEcDma12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBCNmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:42:13 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60650 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726192AbgBCNmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:42:12 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013DbSXT021637;
        Mon, 3 Feb 2020 14:41:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=RcMehdqn0uRmXCnWjD5sbndr/3c7hO8WoiR/j5qCSVg=;
 b=BEcDma12RmPQKWysJNn2tWgrVc4fMM/KkYqwE8fXNon9+c21hMx2uWGJiJmk46HhW1Zf
 FYDm5ERt+0locSkjs9LOdgHi6uMSxlQDPtBPxd/BeO9SLVRwAbYfoY9z+2nn2Pj3F99o
 Yy7/AOu4j1tEwyQVy7nPgoRkdrBmQCVQjJogNc83TDAhnSnhhe4KipudgamHggkqyOka
 djA+6ocYFZ0gKidh06sCVY+N0cKYQBUZsH1bCmZRPdISvJFOulvJgbq9FFQALUq6Ndei
 O3sUYHa0Qu0j0lq3Wy9DY4mZAmo70ITOUdpioC0afrS/WsBV0tkoifATHmek3LIob3sX fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xw13nh8f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 14:41:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF61410002A;
        Mon,  3 Feb 2020 14:41:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node1.st.com [10.75.127.19])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C67502A88C8;
        Mon,  3 Feb 2020 14:41:55 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE1.st.com
 (10.75.127.19) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 14:41:55 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 3 Feb 2020 14:41:55 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/7] Introduce bus firewall controller framework
Thread-Topic: [PATCH v2 0/7] Introduce bus firewall controller framework
Thread-Index: AQHV1fD3HkoxlN8gBkO/naZ6SuTotagANYcAgAAC24CAAAijAIAALxcAgAAhvgCAAQS1gIADnRiAgAQ/FoA=
Date:   Mon, 3 Feb 2020 13:41:55 +0000
Message-ID: <d8b41083-9dfa-5fb8-ecd7-d12151a29aad@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128163628.GB30489@bogus> <7f54ec36-8022-a57a-c634-45257f4c6984@st.com>
 <20200128171639.GA36496@bogus> <26eb1fde-5408-43f0-ccba-f0c81e791f54@st.com>
 <6a6ba7ff-7ed9-e573-63ca-66fca609075b@arm.com>
 <c4d5c46a-7f90-ff2b-9496-26102114c5e6@st.com>
 <e370fb7a-02a6-f5f3-c87d-cd09a80d69ec@gmail.com>
In-Reply-To: <e370fb7a-02a6-f5f3-c87d-cd09a80d69ec@gmail.com>
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
Content-ID: <78E7C1C58A1B2046841DA49BA12E6C90@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_04:2020-02-02,2020-02-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzMxLzIwIDk6NTEgUE0sIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6DQo+IE9uIDEvMjkv
MjAgNTo0MCBBTSwgQmVuamFtaW4gR0FJR05BUkQgd3JvdGU6DQo+PiBPbiAxLzI4LzIwIDExOjA2
IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+Pj4gT24gMjAyMC0wMS0yOCA4OjA2IHBtLCBCZW5q
YW1pbiBHQUlHTkFSRCB3cm90ZToNCj4+Pj4gT24gMS8yOC8yMCA2OjE3IFBNLCBTdWRlZXAgSG9s
bGEgd3JvdGU6DQo+Pj4+PiBPbiBUdWUsIEphbiAyOCwgMjAyMCBhdCAwNDo0Njo0MVBNICswMDAw
LCBCZW5qYW1pbiBHQUlHTkFSRCB3cm90ZToNCj4+Pj4+PiBPbiAxLzI4LzIwIDU6MzYgUE0sIFN1
ZGVlcCBIb2xsYSB3cm90ZToNCj4+Pj4+Pj4gT24gVHVlLCBKYW4gMjgsIDIwMjAgYXQgMDQ6Mzc6
NTlQTSArMDEwMCwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6DQo+Pj4+Pj4+PiBCdXMgZmlyZXdh
bGwgZnJhbWV3b3JrIGFpbXMgdG8gcHJvdmlkZSBhIGtlcm5lbCBBUEkgdG8gc2V0IHRoZQ0KPj4+
Pj4+Pj4gY29uZmlndXJhdGlvbg0KPj4+Pj4+Pj4gb2YgdGhlIGhhcndhcmUgYmxvY2tzIGluIGNo
YXJnZSBvZiBidXNzZXMgYWNjZXNzIGNvbnRyb2wuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gRnJhbWV3
b3JrIGFyY2hpdGVjdHVyZSBpcyBpbnNwaXJhdGVkIGJ5IHBpbmN0cmwgZnJhbWV3b3JrOg0KPj4+
Pj4+Pj4gLSBhIGRlZmF1bHQgY29uZmlndXJhdGlvbiBjb3VsZCBiZSBhcHBsaWVkIGJlZm9yZSBi
aW5kIHRoZSBkcml2ZXIuDQo+Pj4+Pj4+PiAgwqDCoMKgwqAgSWYgYSBjb25maWd1cmF0aW9uIGNv
dWxkIG5vdCBiZSBhcHBsaWVkIHRoZSBkcml2ZXIgaXMgbm90IGJpbmQNCj4+Pj4+Pj4+ICDCoMKg
wqDCoCB0byBhdm9pZCBkb2luZyBhY2Nlc3NlcyBvbiBwcm9oaWJpdGVkIHJlZ2lvbnMuDQo+Pj4+
Pj4+PiAtIGNvbmZpZ3VyYXRpb25zIGNvdWxkIGJlIGFwbGxpZWQgZHluYW1pY2FsbHkgYnkgZHJp
dmVycy4NCj4+Pj4+Pj4+IC0gZGV2aWNlIG5vZGUgcHJvdmlkZXMgdGhlIGJ1cyBmaXJld2FsbCBj
b25maWd1cmF0aW9ucy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBBbiBleGFtcGxlIG9mIGJ1cyBmaXJl
d2FsbCBjb250cm9sbGVyIGlzIFNUTTMyIEVUWlBDIGhhcmR3YXJlIGJsb2NrDQo+Pj4+Pj4+PiB3
aGljaCBnb3QgMyBwb3NzaWJsZSBjb25maWd1cmF0aW9uczoNCj4+Pj4+Pj4+IC0gdHJ1c3Q6IGhh
cmR3YXJlIGJsb2NrcyBhcmUgb25seSBhY2Nlc3NpYmxlIGJ5IHNvZnR3YXJlIHJ1bm5pbmcNCj4+
Pj4+Pj4+IG9uIHRydXN0DQo+Pj4+Pj4+PiAgwqDCoMKgwqAgem9uZSAoaS5lIG9wLXRlZSBmaXJt
d2FyZSkuDQo+Pj4+Pj4+PiAtIG5vbi1zZWN1cmU6IGhhcmR3YXJlIGJsb2NrcyBhcmUgYWNjZXNz
aWJsZSBieSBub24tc2VjdXJlDQo+Pj4+Pj4+PiBzb2Z0d2FyZSAoaS5lLg0KPj4+Pj4+Pj4gIMKg
wqDCoMKgIGxpbnV4IGtlcm5lbCkuDQo+Pj4+Pj4+PiAtIGNvcHJvY2Vzc29yOiBoYXJkd2FyZSBi
bG9ja3MgYXJlIG9ubHkgYWNjZXNzaWJsZSBieSB0aGUNCj4+Pj4+Pj4+IGNvcHJvY2Vzc29yLg0K
Pj4+Pj4+Pj4gVXAgdG8gOTQgaGFyZHdhcmUgYmxvY2tzIG9mIHRoZSBzb2MgY291bGQgYmUgbWFu
YWdlZCBieSBFVFpQQy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+IC9tZSBjb25mdXNlZC4gSXMgRVRaUEMg
YWNjZXNzaWJsZSBmcm9tIHRoZSBub24tc2VjdXJlIGtlcm5lbCBzcGFjZSB0bw0KPj4+Pj4+PiBi
ZWdpbiB3aXRoID8gSWYgc28sIGlzIGl0IGFsbG93ZWQgdG8gY29uZmlndXJlIGhhcmR3YXJlIGJs
b2NrcyBhcw0KPj4+Pj4+PiBzZWN1cmUNCj4+Pj4+Pj4gb3IgdHJ1c3RlZCA/IEkgYW0gZmFpbGlu
ZyB0byB1bmRlcnN0YW5kIHRoZSBvdmVyYWxsIGRlc2lnbiBvZiBhDQo+Pj4+Pj4+IHN5c3RlbQ0K
Pj4+Pj4+PiB3aXRoIEVUWlBDIGNvbnRyb2xsZXIuDQo+Pj4+Pj4gTm9uLXNlY3VyZSBrZXJuZWwg
Y291bGQgcmVhZCB0aGUgdmFsdWVzIHNldCBpbiBFVFpQQywgaWYgaXQgZG9lc24ndA0KPj4+Pj4+
IG1hdGNoDQo+Pj4+Pj4gd2l0aCB3aGF0IGlzIHJlcXVpcmVkIGJ5IHRoZSBkZXZpY2Ugbm9kZSB0
aGUgZHJpdmVyIHdvbid0IGJlIHByb2JlZC4NCj4+Pj4+Pg0KPj4+Pj4gT0ssIGJ1dCBJIHdhcyB1
bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IGl0IHdhcyBtYWRlIGNsZWFyIHRoYXQgTGludXggaXMN
Cj4+Pj4+IG5vdCBmaXJtd2FyZSB2YWxpZGF0aW9uIHN1aXRlLiBUaGUgZmlybXdhcmUgbmVlZCB0
byBlbnN1cmUgYWxsIHRoZQ0KPj4+Pj4gZGV2aWNlcw0KPj4+Pj4gdGhhdCBhcmUgbm90IGFjY2Vz
c2libGUgaW4gdGhlIExpbnV4IGtlcm5lbCBhcmUgbWFya2VkIGFzIGRpc2FibGVkIGFuZA0KPj4+
Pj4gdGhpcyBuZWVkcyB0byBoYXBwZW4gYmVmb3JlIGVudGVyaW5nIHRoZSBrZXJuZWwuIFNvIGlm
IHRoaXMgaXMgd2hhdA0KPj4+Pj4gdGhpcw0KPj4+Pj4gcGF0Y2ggc2VyaWVzIGFjaGlldmVzLCB0
aGVuIHRoZXJlIGlzIG5vIG5lZWQgZm9yIGl0LiBQbGVhc2Ugc3RvcA0KPj4+Pj4gcHVyc3VpbmcN
Cj4+Pj4+IHRoaXMgYW55IGZ1cnRoZXIgb3IgcHJvdmlkZSBhbnkgb3RoZXIgcmVhc29ucyhpZiBh
bnkpIHRvIGhhdmUgaXQuIFVudGlsDQo+Pj4+PiB5b3UgaGF2ZSBvdGhlciByZWFzb25zLCBOQUNL
IGZvciB0aGlzIHNlcmllcy4NCj4+Pj4gTm8gaXQgZG9lc24ndCBkaXNhYmxlIHRoZSBub2Rlcy4N
Cj4+Pj4NCj4+Pj4gV2hlbiB0aGUgZmlybXdhcmUgZGlzYWJsZSBhIG5vZGUgYmVmb3JlIHRoZSBr
ZXJuZWwgdGhhdCBtZWFucyBpdCBjaGFuZ2UNCj4+Pj4NCj4+Pj4gdGhlIERUQiBhbmQgdGhhdCBp
cyBhIHByb2JsZW0gd2hlbiB5b3Ugd2FudCB0byBzaWduIGl0LiBXaXRoIG15IHByb3Bvc2FsDQo+
Pj4+DQo+Pj4+IHRoZSBEVEIgcmVtYWlucyB0aGUgc2FtZS4NCj4+PiA/Pz8NCj4+Pg0KPj4+IDov
DQo+Pj4NCj4+PiBUaGUgRFRCIGlzIHVzZWQgdG8gcGFzcyB0aGUga2VybmVsIGNvbW1hbmQgbGlu
ZSwgbWVtb3J5IHJlc2VydmF0aW9ucywNCj4+PiByYW5kb20gc2VlZHMsIGFuZCBhbGwgbWFubmVy
IG9mIG90aGVyIHRoaW5ncyBkeW5hbWljYWxseSBnZW5lcmF0ZWQgYnkNCj4+PiBmaXJtd2FyZSBh
dCBib290LXRpbWUuIEFwb2xvZ2llcyBmb3IgYmVpbmcgYmx1bnQgYnV0IGlmICJjaGFuZ2luZyB0
aGUNCj4+PiBEVEIiIGlzIGNvbnNpZGVyZWQgYSBwcm9ibGVtIHRoZW4gSSBjYW4ndCBoZWxwIGJ1
dCB0aGluayB5b3UncmUgZG9pbmcNCj4+PiBpdCB3cm9uZy4NCj4+IFllcyBidXQgSSB3b3VsZCBs
aWtlIHRvIGxpbWl0IHRoZSBudW1iZXIgb2YgY2FzZXMgd2hlcmUgYSBmaXJtd2FyZSBoYXMNCj4+
IHRvIGNoYW5nZSB0aGUgRFRCLg0KPj4NCj4+IFdpdGggdGhpcyBwcm9wb3NhbCBub2RlcyByZW1h
aW4gdGhlIHNhbWUgYW5kIGVtYmVkZGVkIHRoZSBmaXJld2FsbA0KPj4gY29uZmlndXJhdGlvbihz
KS4NCj4+DQo+PiBVbnRpbCBub3cgZmlyZXdhbGwgY29uZmlndXJhdGlvbiBpcyAic3RhdGljIiwg
dGhlIGZpcm13YXJlIGRpc2FibGUgKG9yDQo+PiByZW1vdmUpIHRoZSBub2RlcyBub3QgYWNjZXNz
aWJsZSBmcm9tIExpbnV4Lg0KPj4NCj4+IElmIExpbnV4IGNhbiByZWx5IG9uIG5vZGUncyBmaXJl
d2FsbCBpbmZvcm1hdGlvbiBpdCBjb3VsZCBhbGxvdyBzd2l0Y2gNCj4+IGR5bmFtaWNhbGx5IGFu
IGhhcmR3YXJlIGJsb2NrIGZyb20gTGludXggdG8gYSBjb3Byb2Nlc3Nvci4NCj4+DQo+PiBGb3Ig
ZXhhbXBsZSBMaW51eCBjb3VsZCBtYW5hZ2UgdGhlIGRpc3BsYXkgcGlwZSBjb25maWd1cmF0aW9u
IGFuZCB3aGVuDQo+PiBnb2luZyB0byBzdXNwZW5kIGhhbmRvdmVyIHRoZSBkaXNwbGF5IGhhcmR3
YXJlIGJsb2NrIHRvIGEgY29wcm9jZXNzb3IgaW4NCj4+IGNoYXJnZSBhIHJlZnJlc2hpbmcgb25s
eSBzb21lIHBpeGVscy4NCj4gT0ssIGxldCdzIGNvbnRpbnVlIHRoYXQgZXhhbXBsZSwgd291bGQg
bm90IGl0IG1ha2Ugc2Vuc2UgdGhlbiB0byBqdXN0DQo+IHN0ZWFsIHRoZSBwZXJpcGhlcmFsIGF3
YXkgZnJvbSBMaW51eCBieSBlbnN1cmluZyB0aGF0IExpbnV4IGlzIG5vIGxvbmdlcg0KPiBydW5u
aW5nIGFuZCB0aGUgb25seSB0aGluZyB0aGF0IHlvdSBuZWVkIHRvIG1ha2Ugc3VyZSBvZiBpcyB0
aGF0IGVpdGhlcg0KPiB5b3UgcmVzdG9yZSB0aGUgSFcgaW4gdGhlIGV4YWN0IHNhbWUgdGhhdCB5
b3Ugc3RvbGUgaXQgZnJvbSwgb3IgdGhhdA0KPiBMaW51eCBpcyBjYXBhYmxlIG9mIHJlZnJlc2hp
bmcgaXRzIHN0YXRlIGFnYWluc3Qgd2hhdCB0aGUgSFcgc3RhdGUgd2FzDQo+IGxlZnQgaW4/DQo+
DQo+IElmIHlvdSBoYXZlIGEgc2V0IG9mIGRpc3BsYXkgcGlwZWxpbmUgZHJpdmVycywgb24geW91
ciB3YXkgdG8gc3VzcGVuZCwNCj4geW91IGNhbiBkZWZpbmUgYSBwcm90b2NvbCB3aXRoIHRoZSBj
by1wcm9jZXNzb3Igc28gYXMgdG8gc2lnbmFsIGFuDQo+IG93bmVyc2hpcCBjaGFuZ2UsIGFuZCB0
aGUgY28tcHJvY2Vzc29yIGNhbiB0YWtlIGNvbnRyb2wgZnJvbSB0aGVyZS4NClRvIGhhbmRvdmVy
IGEgaGFyZHdhcmUgYmxvY2sgdG8gdGhlIGNvLXByb2Nlc3NvciB3ZSBuZWVkIHRvIGluZm9ybSBp
dCANCmFuZCBjaGFuZ2UgdGhlIGZpcmV3YWxsIGNvbmZpZ3VyYXRpb24uDQpNeSBwcm9wb3NhbCBv
bmx5IGFpbSB0byBjb3ZlciB0aGlzIGxhc3QgcG9pbnQgYnkgZGVzY3JpYmluZyBpbiB0aGUgDQpk
ZXZpY2UgdHJlZSB0aGUgcG9zc2libGUgY29uZmlndXJhdGlvbi4NClRoZSBleGFtcGxlIEkgaGFk
IG1pbmQgaXMgaG93IHRoZSBwaW5jdHJsIGZyYW1ld29yayBpcyB3b3JraW5nIHdpdGggaXQgDQpz
dGF0ZXMgc28gZG9pbmcgc29tZXRoaW5nIGxpa2UgY2hhbmdpbmcgZmlyZXdhbGwgY29uZmlndXJh
dGlvbiBhbmQgdGhlbiANCmluZm9ybSB0aGUgY28tcHJvY2Vzc29yIGluIHN1c3BlbmQgZnVuY3Rp
b24uDQo+DQo+IEluIHlvdXIgZXhhbXBsZSwgaXQgc291bmRzIGxpa2UgdGhlIGZpcmV3YWxsIGNv
dWxkIGJlIG1lYW50IHRvIGRldGVjdA0KPiB1bmNvb3JkaW5hdGVkIGNvbmN1cnJlbnQgYWNjZXNz
ZXMgdG8gdGhlIHNhbWUgSFcgYmxvY2sgYmV0d2VlbiBkaWZmZXJlbnQNCj4gU1cvRlcgZW50aXRp
ZXMuIElmIHRoYXQgaXMgdGhlIGNhc2UsIHRoaXMgaXMgbW9zdCBsaWtlbHkgYSBidWcgYW5kIHlv
dQ0KPiBjYW4gcHJvYmFibHkganVzdCBnZXQgYXdheSB3aXRoIGRvaW5nIHJlcG9ydGluZyBpbnN0
ZWFkIG9mIGFuIGVudGlyZWx5DQo+IG5ldyBzdWJzeXN0ZW0/DQpQcm9oaWJpdGVkIGFjY2Vzc2Vz
LCBtb3N0IG9mIHRoZSB0aW1lLCBnZW5lcmF0ZSBhbiBhYm9ydCBvbiB0aGUgYnVzIHNvIA0KeW91
ciBwbGF0Zm9ybSBqdXN0IGNyYXNoIGFuZCB5ZXMgaXQgaXMgYSBidWcuDQpUaGlzIG5ldyBzdWJz
eXN0ZW0gd29uJ3QgY2hhbmdlIHRoYXQsIGl0IG9ubHkgYWxsb3cgdG8gZGVzY3JpYmUgYW5kIA0K
ZHluYW1pY2FsbHkgc2V0IGEgY29uZmlndXJhdGlvbiBmb3IgRFQgaW5mb3JtYXRpb24gcmF0aGVy
IGRvaW5nIHRoYXQgZm9yIA0KdHlwZSBvZiBmaXJld2FsbC4NCg0KQmVuamFtaW4NCg==
