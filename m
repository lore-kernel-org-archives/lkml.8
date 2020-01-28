Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF25EC47409
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BE22467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Dh2pdnDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgA1QrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:47:02 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26250 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726211AbgA1QrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:47:02 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SGXKvH005871;
        Tue, 28 Jan 2020 17:46:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=3Rk+qm0XuAAR8ujuxjYe/W1dSCkCwAqvtaZc+Mo2CT4=;
 b=Dh2pdnDmJgslSmBqlDE+BVm/reheKkhuwDG4tmBMRtnkzKrQUiT6HfpC9zTm8JVyaaAT
 dGtiEr8UFSBa7T/gfJsVQl0OZwWC57/P6MixI7v1Ldlipk7SR0l5H0o8kvtzYtk3FaKs
 PGs1q3Ms12xb0pPlrfIc8rIWkxu9nJp5qZ4yuLXB3KKtbuJ/dVZMNGMcDNv2MhDmg5rN
 RJFbYl7oB0cTl1EISFW5FRT/nTgSNaJfKAM2PhJgJj7FqcbGBZqPxxEkL6XdVt4fYskc
 Xovg/KSujdfftBNaZ8Bs8l7cO8mRiUoAuVCpf/WstW/NKrVvKbsCi5Awf+YKpKJGBS/K /Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpay5ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 17:46:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94BA010002A;
        Tue, 28 Jan 2020 17:46:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 57DDB21D6C0;
        Tue, 28 Jan 2020 17:46:42 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE2.st.com
 (10.75.127.20) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 17:46:42 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 28 Jan 2020 17:46:41 +0100
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
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 0/7] Introduce bus firewall controller framework
Thread-Topic: [PATCH v2 0/7] Introduce bus firewall controller framework
Thread-Index: AQHV1fD3HkoxlN8gBkO/naZ6SuTotagANYcAgAAC24A=
Date:   Tue, 28 Jan 2020 16:46:41 +0000
Message-ID: <7f54ec36-8022-a57a-c634-45257f4c6984@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128163628.GB30489@bogus>
In-Reply-To: <20200128163628.GB30489@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <833F454B2A621647B173517B482702ED@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI4LzIwIDU6MzYgUE0sIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MjgsIDIwMjAgYXQgMDQ6Mzc6NTlQTSArMDEwMCwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6DQo+
PiBCdXMgZmlyZXdhbGwgZnJhbWV3b3JrIGFpbXMgdG8gcHJvdmlkZSBhIGtlcm5lbCBBUEkgdG8g
c2V0IHRoZSBjb25maWd1cmF0aW9uDQo+PiBvZiB0aGUgaGFyd2FyZSBibG9ja3MgaW4gY2hhcmdl
IG9mIGJ1c3NlcyBhY2Nlc3MgY29udHJvbC4NCj4+DQo+PiBGcmFtZXdvcmsgYXJjaGl0ZWN0dXJl
IGlzIGluc3BpcmF0ZWQgYnkgcGluY3RybCBmcmFtZXdvcms6DQo+PiAtIGEgZGVmYXVsdCBjb25m
aWd1cmF0aW9uIGNvdWxkIGJlIGFwcGxpZWQgYmVmb3JlIGJpbmQgdGhlIGRyaXZlci4NCj4+ICAg
IElmIGEgY29uZmlndXJhdGlvbiBjb3VsZCBub3QgYmUgYXBwbGllZCB0aGUgZHJpdmVyIGlzIG5v
dCBiaW5kDQo+PiAgICB0byBhdm9pZCBkb2luZyBhY2Nlc3NlcyBvbiBwcm9oaWJpdGVkIHJlZ2lv
bnMuDQo+PiAtIGNvbmZpZ3VyYXRpb25zIGNvdWxkIGJlIGFwbGxpZWQgZHluYW1pY2FsbHkgYnkg
ZHJpdmVycy4NCj4+IC0gZGV2aWNlIG5vZGUgcHJvdmlkZXMgdGhlIGJ1cyBmaXJld2FsbCBjb25m
aWd1cmF0aW9ucy4NCj4+DQo+PiBBbiBleGFtcGxlIG9mIGJ1cyBmaXJld2FsbCBjb250cm9sbGVy
IGlzIFNUTTMyIEVUWlBDIGhhcmR3YXJlIGJsb2NrDQo+PiB3aGljaCBnb3QgMyBwb3NzaWJsZSBj
b25maWd1cmF0aW9uczoNCj4+IC0gdHJ1c3Q6IGhhcmR3YXJlIGJsb2NrcyBhcmUgb25seSBhY2Nl
c3NpYmxlIGJ5IHNvZnR3YXJlIHJ1bm5pbmcgb24gdHJ1c3QNCj4+ICAgIHpvbmUgKGkuZSBvcC10
ZWUgZmlybXdhcmUpLg0KPj4gLSBub24tc2VjdXJlOiBoYXJkd2FyZSBibG9ja3MgYXJlIGFjY2Vz
c2libGUgYnkgbm9uLXNlY3VyZSBzb2Z0d2FyZSAoaS5lLg0KPj4gICAgbGludXgga2VybmVsKS4N
Cj4+IC0gY29wcm9jZXNzb3I6IGhhcmR3YXJlIGJsb2NrcyBhcmUgb25seSBhY2Nlc3NpYmxlIGJ5
IHRoZSBjb3Byb2Nlc3Nvci4NCj4+IFVwIHRvIDk0IGhhcmR3YXJlIGJsb2NrcyBvZiB0aGUgc29j
IGNvdWxkIGJlIG1hbmFnZWQgYnkgRVRaUEMuDQo+Pg0KPiAvbWUgY29uZnVzZWQuIElzIEVUWlBD
IGFjY2Vzc2libGUgZnJvbSB0aGUgbm9uLXNlY3VyZSBrZXJuZWwgc3BhY2UgdG8NCj4gYmVnaW4g
d2l0aCA/IElmIHNvLCBpcyBpdCBhbGxvd2VkIHRvIGNvbmZpZ3VyZSBoYXJkd2FyZSBibG9ja3Mg
YXMgc2VjdXJlDQo+IG9yIHRydXN0ZWQgPyBJIGFtIGZhaWxpbmcgdG8gdW5kZXJzdGFuZCB0aGUg
b3ZlcmFsbCBkZXNpZ24gb2YgYSBzeXN0ZW0NCj4gd2l0aCBFVFpQQyBjb250cm9sbGVyLg0KDQpO
b24tc2VjdXJlIGtlcm5lbCBjb3VsZCByZWFkIHRoZSB2YWx1ZXMgc2V0IGluIEVUWlBDLCBpZiBp
dCBkb2Vzbid0IG1hdGNoDQoNCndpdGggd2hhdCBpcyByZXF1aXJlZCBieSB0aGUgZGV2aWNlIG5v
ZGUgdGhlIGRyaXZlciB3b24ndCBiZSBwcm9iZWQuDQoNCkJlbmphbWluDQoNCj4NCj4+IEF0IGxl
YXN0IHR3byBvdGhlciBoYXJkd2FyZSBibG9ja3MgY2FuIHRha2UgYmVuZWZpdHMgb2YgdGhpczoN
Cj4+IC0gQVJNIFRaQy00MDA6IGh0dHA6Ly9pbmZvY2VudGVyLmFybS5jb20vaGVscC90b3BpYy9j
b20uYXJtLmRvYy4xMDAzMjVfMDAwMV8wMl9lbi9hcm1fY29yZWxpbmtfdHpjNDAwX3RydXN0em9u
ZV9hZGRyZXNzX3NwYWNlX2NvbnRyb2xsZXJfdHJtXzEwMDMyNV8wMDAxXzAyX2VuLnBkZg0KPj4g
ICAgd2hpY2ggaXMgYWJsZSB0byBtYW5hZ2UgdXAgdG8gOCByZWdpb25zIGluIGFkZHJlc3Mgc3Bh
Y2UuDQo+IEkgc3Ryb25nbHkgaGF2ZSB0byBkaXNhZ3JlZSB3aXRoIHRoZSBhYm92ZSBhbmQgTkFD
SyBhbnkgcGF0Y2ggdHJ5aW5nDQo+IHRvIGRvIHNvLiBBRkFJSywgbm8gc3lzdGVtIGRlc2lnbmVk
IGhhcyBUWkMgd2l0aCBub24tc2VjdXJlIGFjY2Vzcy4NCj4gU28gd2Ugc2ltcGx5IGNhbid0IGFj
Y2VzcyB0aGlzIGluIHRoZSBrZXJuZWwgYW5kIGhlbmNlIG5lZWQgbm8gZHJpdmVyDQo+IGZvciB0
aGUgc2FtZS4gUGxlYXNlIGF2b2lkIGFkZGluZyBhYm92ZSBtaXNsZWFkaW5nIGluZm9ybWF0aW9u
IGluIGZ1dHVyZS4NCj4NCj4gLS0NCj4gUmVnYXJkcywNCj4gU3VkZWVwDQo+
