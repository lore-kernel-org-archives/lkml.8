Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C607C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FB72166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="M6kTjYLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgCDQn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:43:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2878 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729739AbgCDQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:43:28 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024GbPrD011137;
        Wed, 4 Mar 2020 17:42:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=+w7TBSBgLDE2Teg6+clwcWdskIiO4YFIp83k3XHalzc=;
 b=M6kTjYLRpGwuY4eT7pAtP/3D4n3l83K2qdFKS2zfrodHMgY8b6nppTd1iO0lnCrWhuVD
 cTxjnoti+kDLCYr8aXQV1ee+d2oBmaDjIWCyFYnK0yK2XW3v0IkjNK1/j5ZYD9ZiUkrZ
 CR98qAZtHUG+vdNZ7Rk78PFBIX1z9P9DhazCHR0ZQwG6Xxw05hCiQgf7vNj/OngCg16D
 kDAckweJyAlGC5X6ylxn4+MDFQFHlyLzaPy1XPwLv4mY5isPtQacYQxwppH/KhE0Ubkd
 pJ3xW6fnBkgNYUSRQ0eBzUlTwmTA8jS4jvSwksPtBaHK+KgH/qJ1ULIBaEBkH38hIGKy sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yfdyd2ss4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 17:42:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1460E10003A;
        Wed,  4 Mar 2020 17:42:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4CD82C2510;
        Wed,  4 Mar 2020 17:42:10 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 4 Mar
 2020 17:42:10 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 4 Mar 2020 17:42:09 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: drm: context: Clean up documentation
Thread-Topic: [PATCH] gpu: drm: context: Clean up documentation
Thread-Index: AQHV2Bfdg2vUklVZ90OGQMC6Ot+gVag4vS2AgAAJkYA=
Date:   Wed, 4 Mar 2020 16:42:09 +0000
Message-ID: <f8af37a1-ff6b-9a09-7b24-a7e3f9a981c2@st.com>
References: <20200131092147.32063-1-benjamin.gaignard@st.com>
 <CACvgo50=Wt9LFWDjkJa99T8r8A64JWgfqApmir8kX=kSXd1yog@mail.gmail.com>
In-Reply-To: <CACvgo50=Wt9LFWDjkJa99T8r8A64JWgfqApmir8kX=kSXd1yog@mail.gmail.com>
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
Content-ID: <C058D96537F8D2408B63FD25D7D3F3A5@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_06:2020-03-04,2020-03-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvNC8yMCA1OjA3IFBNLCBFbWlsIFZlbGlrb3Ygd3JvdGU6DQo+IE9uIE1vbiwgMyBG
ZWIgMjAyMCBhdCAwODoxMSwgQmVuamFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdhaWduYXJkQHN0
LmNvbT4gd3JvdGU6DQo+PiBGaXgga2VybmVsIGRvYyBjb21tZW50cyB0byBhdm9pZCB3YXJuaW5n
cyB3aGVuIGNvbXBpbGluZyB3aXRoIFc9MS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1p
biBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZl
cnMvZ3B1L2RybS9kcm1fY29udGV4dC5jIHwgMTQ1ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwg
ODQgZGVsZXRpb25zKC0pDQo+Pg0KPiBTaW5jZSB3ZSdyZSB0YWxraW5nIGFib3V0IGxlZ2FjeSwg
YWthIHVzZXIgbW9kZS1zZXR0aW5nIGNvZGUsIEkgdGhpbmsNCj4gYSB3aXNlciBzb2x1dGlvbiBp
cyB0byBzaW1wbHkgcmVtb3ZlIHRoZSBkb2N1bWVudGF0aW9uLiBJdCBpcyBfbm90Xw0KPiBzb21l
dGhpbmcgd2Ugc2hvdWxkIGVuY291cmFnZSBwZW9wbGUgdG8gcmVhZCwgbGV0IGFsb25lIHVzZS4N
Cj4NCj4gTml0OiBwcmVmaXggc2hvdWxkIGJlICJkcm06Ig0KU2hvdWxkIEkgYXNzdW1lIGl0IGlz
IHRoZSBzYW1lIGZvciBkcm1fdm0uYyBhbmQgZHJtX2J1ZnMuYyA/DQoNCkJlbmphbWluDQo+IC1F
bWlsDQo=
