Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC26C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48B320663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="f2vC4Eae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgCPIFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:05:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29648 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729745AbgCPIFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:05:30 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02G7x3fB004532;
        Mon, 16 Mar 2020 09:05:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=aAX015zEGt1iDYd9fLCWz8ZRf1VeNZVoWYmUVUrHks0=;
 b=f2vC4EaeDXBjoM0/YX0nT/EhpV5U2WjmtwN+wNbFsRnKDCeUC4oxyYFOqzbtdOIaNKB3
 38gSfGtLXWQ9j/VNRqXm9g4HxG5gPGd3pSc0uVeQdAWo5tG0OWarn6hQsVEYu3WFrVSI
 6pAG1WgNVMvdwub+41DryELM43TBY/RZUaYgUTD3ducrNqLOanuXoBS/wTJNiePSlZ6x
 tFPbnlKLUznJv6yWirKahnHEcKlnEHU0uU7Zq060Q5dkRjHac2XKCATtEdA/q2vtWMuJ
 IzHKMbTxYIOnts2a5c08j76MjtmAh3ZFAK2xI8q5wj2TMwktQGrVN0u1j/FRkq2Jj9Y7 FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yrqa9e9hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 09:05:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B18E410003B;
        Mon, 16 Mar 2020 09:05:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1DF221E687;
        Mon, 16 Mar 2020 09:05:07 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 16 Mar
 2020 09:05:07 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 16 Mar 2020 09:05:07 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Joe Perches <joe@perches.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: adjust to VIVANTE GPU schema conversion
Thread-Topic: [PATCH] MAINTAINERS: adjust to VIVANTE GPU schema conversion
Thread-Index: AQHV+ppWk7Ve7/6Ys0G/uL6TUzmfJKhKzTwA
Date:   Mon, 16 Mar 2020 08:05:07 +0000
Message-ID: <18450dfa-a150-45df-5b9c-c543c110c478@st.com>
References: <20200315072109.6815-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200315072109.6815-1-lukas.bulwahn@gmail.com>
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
Content-ID: <6D3788AD8A1BE941B64C12E7789BE437@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-16_02:2020-03-12,2020-03-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMTUvMjAgODoyMSBBTSwgTHVrYXMgQnVsd2FobiB3cm90ZToNCj4gQ29tbWl0IDkw
YWVjYTg3NWY4YSAoImR0LWJpbmRpbmdzOiBkaXNwbGF5OiBDb252ZXJ0IGV0bmF2aXYgdG8NCj4g
anNvbi1zY2hlbWEiKSBtaXNzZWQgdG8gYWRqdXN0IHRoZSBEUk0gRFJJVkVSUyBGT1IgVklWQU5U
RSBHUFUgSVAgZW50cnkNCj4gaW4gTUFJTlRBSU5FUlMuDQo+DQo+IFNpbmNlIHRoZW4sIC4vc2Ny
aXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtLXNlbGYtdGVzdCBjb21wbGFpbnM6DQo+DQo+ICAgIHdh
cm5pbmc6IG5vIGZpbGUgbWF0Y2hlcyBcDQo+ICAgIEY6IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L2V0bmF2aXYvDQo+DQo+IFVwZGF0ZSBNQUlOVEFJTkVSUyBlbnRy
eSB0byBsb2NhdGlvbiBvZiBjb252ZXJ0ZWQgc2NoZW1hLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBM
dWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhuQGdtYWlsLmNvbT4NClJldmlld2VkLWJ5OiBCZW5q
YW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KDQpUaGFua3MNCj4gLS0t
DQo+IGFwcGxpZXMgY2xlYW5seSBvbiBuZXh0LTIwMjAwMzEzDQo+DQo+IEJlbmphbWluLCBwbGVh
c2UgYWNrLg0KPiBSb2IsIHBsZWFzZSBwaWNrIHRoaXMgcGF0Y2ggKGl0IGlzIG5vdCB1cmdlbnQs
IHRob3VnaCkNCj4NCj4NCj4gICBNQUlOVEFJTkVSUyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL01BSU5U
QUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggNzdlZWRlOTc2ZDBmLi41MGE3YTZkNjJlMDYg
MTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC01
NzY2LDcgKzU3NjYsNyBAQCBMOglkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ICAg
UzoJTWFpbnRhaW5lZA0KPiAgIEY6CWRyaXZlcnMvZ3B1L2RybS9ldG5hdml2Lw0KPiAgIEY6CWlu
Y2x1ZGUvdWFwaS9kcm0vZXRuYXZpdl9kcm0uaA0KPiAtRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvZXRuYXZpdi8NCj4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ncHUvdml2YW50ZSxnYy55YW1sDQo+ICAgDQo+ICAgRFJNIERSSVZFUlMg
Rk9SIFpURSBaWA0KPiAgIE06CVNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCg==
