Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65492C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1F8214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="nRu7l5/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBJIPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:15:35 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42144 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbgBJIPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:15:35 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01A8DgMV025251;
        Mon, 10 Feb 2020 09:15:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=csTbRj70vU7WI1+2GoXNCPXKkNYa2CfNAeRYI6le68Q=;
 b=nRu7l5/r2Xip6i6hUmzISgCodZG16ZDos3vxZm/MuS1ldJA1um9RYLaiwvJ9QXfZS1nY
 xb+0ON1PKOU7XsINAr/n/6Yo2QFUP1VDso8jN+CYngLUxSxM2hxouo8roYlybB1uHyC9
 ObFInUEHviY0ocTIArGCppG8XBVqfsoNvfySXoZHtM3GyC8/LxZsP1+S5yjJ0X1BEsmb
 KtvcK7O9kXSn20Z6pnnRr5jY1NPyLOH3aJCyRgAKVX5XNp1tlLlqdcbIn2ZxdM6+GWiW
 GbAOJGgOErLNS0h6L7pOaHIO7m7kshaASxqgpXIujMExq9vaPuE808wL/ZQtJcmvGNsQ 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ufgr0b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 09:15:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AAA13100038;
        Mon, 10 Feb 2020 09:15:17 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 624C92B1863;
        Mon, 10 Feb 2020 09:15:17 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 09:15:16 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Mon, 10 Feb 2020 09:15:16 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Olof Johansson <olof@lixom.net>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "arm@kernel.org" <arm@kernel.org>
Subject: Re: [GIT PULL] STi DT update for v5.6 round 1
Thread-Topic: [GIT PULL] STi DT update for v5.6 round 1
Thread-Index: AQHV21fUlvmf1pIO+EOSI+9it4GhsqgStwaAgAFV+gA=
Date:   Mon, 10 Feb 2020 08:15:16 +0000
Message-ID: <8a845623-0f30-b1b2-1a8a-8dfbcb67ddf4@st.com>
References: <c6f76adc-b32f-a64f-c7b1-417a26de1667@st.com>
 <CAOesGMhxN3MW69EcJ_DigrvfruHzACNP8J-JOR9GmCnk4Tjodw@mail.gmail.com>
In-Reply-To: <CAOesGMhxN3MW69EcJ_DigrvfruHzACNP8J-JOR9GmCnk4Tjodw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B894766D3142BD41868C6E39FFE5CB85@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_02:2020-02-07,2020-02-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xvZg0KDQpPbiAyLzkvMjAgMTI6NTEgUE0sIE9sb2YgSm9oYW5zc29uIHdyb3RlOg0KDQo+
IEhpIFBhdHJpY2UsDQo+DQo+IFtQbGVhc2UgYWxzbyBjYyBzb2NAa2VybmVsLm9yZyBvbiBwdWxs
IHJlcXVlc3RzLCBzaW5jZSB0aGV5IHRoZW4gZW5kDQo+IHVwIGluIG91ciBwYXRjaHdvcmsgYW5k
IHdlJ3JlIGxlc3MgbGlrZWx5IHRvIG1pc3MgdGhlbV0NCg0KT2sNCg0KDQo+DQo+IE9uIFR1ZSwg
RmViIDQsIDIwMjAgYXQgMTozNyBQTSBQYXRyaWNlIENIT1RBUkQgPHBhdHJpY2UuY2hvdGFyZEBz
dC5jb20+IHdyb3RlOg0KPj4gSGkgQXJuZCwgT2xvZiwgS2V2aW4NCj4+DQo+PiBQbGVhc2UgZmlu
ZCBTVGkgZHQgdXBkYXRlIGZvciB2NS42IHJvdW5kIDE6DQo+IFRoZSB0aW1pbmcgZm9yIHRoaXMg
aXMgYmFkLiBNYXRlcmlhbCBzaG91bGQgYXJyaXZlIHRvIG91ciB0cmVlIGFyb3VuZA0KPiAtcmM2
IHRpbWVmcmFtZSBmb3IgdGhlIHByZXZpb3VzIHJlbGVhc2UsIGZvciB1cyB0byBoYXZlIHRpbWUg
dG8gbWVyZ2UNCj4gaXQgYW5kIGV4cG9zZSBpdCBpbiBsaW51eC1uZXh0IGZvciBhIHdoaWxlIGJl
Zm9yZSB0aGUgbWVyZ2Ugd2luZG93DQo+IG9wZW5zLg0KDQpPayB1bmRlcnN0YW5kLCB0aGlzIHB1
bGwgcmVxdWVzdCBpcyBub3QgdXJnZW50IGF0IGFsbCwgaSB3aWxsIHJlc3VibWl0IGl0IGxhdGVy
IDstKQ0KDQo+DQo+PiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGQ1MjI2ZmE2
ZGJhZTA1NjllZTQzZWNmYzA4YmRjZDY3NzBmYzQ3NTU6DQo+Pg0KPj4NCj4+ICAgTGludXggNS41
ICgyMDIwLTAxLTI2IDE2OjIzOjAzIC0wODAwKQ0KPiAuLi4gd2UgYWxzbyBhc2sgdGhhdCB0aGUg
aW5jb21pbmcgYnJhbmNoZXMgYXJlIGJhc2VkIG9uIHJjMSBvciByYzIgb2YNCj4gdGhlIHByZXZp
b3VzIHJlbGVhc2UsIG5vdCB0aGUgbGF0ZXN0IHBvc3NpYmxlIHJlbGVhc2UgKHVubGVzcyB0aGVy
ZSdzDQo+IGEgZ29vZCByZWFzb24gZm9yIGl0KS4NCj4NCj4+IGFyZSBhdmFpbGFibGUgaW4gdGhl
IEdpdCByZXBvc2l0b3J5IGF0Og0KPj4NCj4+ICAgZ2l0QGdpdG9saXRlLmtlcm5lbC5vcmc6cHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3BjaG90YXJkL3N0aS5naXQgdGFncy9zdGktZHQtZm9yLTUu
Ni1yb3VuZDENCj4gUGxlYXNlIHVzZSB0aGUgcHVibGljIGdpdDovLyBvciBodHRwczovLyB2ZXJz
aW9ucyBpbiBwdWxsIHJlcXVlc3RzLg0KT2sNCj4NCj4+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byAyMWVlYmFlOWExMWZmMThmZTZkNmI0M2FkY2NhZGQ1MzNhYmRmMGQ2Og0KPj4NCj4+
ICAgQVJNOiBzdGloeHh4LWIyMTIwLmR0c2k6IGZpeHVwIHNvdW5kIGZyYW1lLWludmVyc2lvbiAo
MjAyMC0wMi0wNCAxMToyMTozNyArMDEwMCkNCj4+DQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiBTVGkgZHQgZml4
ZXM6DQo+PiAtLS0tLS0tLS0tLS0tDQo+PiAgIC0gcmVtb3ZlIGRlcHJlY2F0ZWQgU3lub3BzeXMg
UEhZIGR0IHByb3BlcnRpZXMNCj4+ICAgLSBmaXggc291bmQgZnJhbWUtaW52ZXJzaW9uIHByb3Bl
cnR5DQo+Pg0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gS3VuaW5vcmkgTW9yaW1vdG8gKDEpOg0KPj4gICAgICAg
QVJNOiBzdGloeHh4LWIyMTIwLmR0c2k6IGZpeHVwIHNvdW5kIGZyYW1lLWludmVyc2lvbg0KPj4N
Cj4+IFBhdHJpY2UgQ2hvdGFyZCAoMSk6DQo+PiAgICAgICBBUk06IGR0czogc3RpaDQxMC1iMjI2
MDogUmVtb3ZlIGRlcHJlY2F0ZWQgc25wcyBQSFkgcHJvcGVydGllcw0KPiBJdCdzIGEgZ29vZCBp
ZGVhIHRvIGtlZXAgYSByZWFzb25hYmx5IGNvbnNpc3RlbnQgcHJlZml4IHVzYWdlLiAiQVJNOg0K
PiBkdHM6IDxwbGF0Zm9ybT46IiBpcyB3aGF0IHdlIHByZWZlciwgc28gZmVlbCBmcmVlIHRvIHRv
dWNoIHRoYXQgdXAgZm9yDQo+IHBhdGNoZXMgdGhhdCB5b3UgYXBwbHkuDQoNCm9rIG5vdGVkDQoN
ClRoYW5rcw0KDQpQYXRyaWNlDQoNCj4NCj4NCj4gLU9sb2Y=
