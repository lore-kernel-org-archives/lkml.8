Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FC0C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD682072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="G9nQPvqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCWJSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:18:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31704 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbgCWJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:18:05 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02N97TuQ011197;
        Mon, 23 Mar 2020 10:17:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=UdIOJn9PEvaK3zLSkhSUlGSzzu66xRfXTNSMnBonJJ8=;
 b=G9nQPvqYGNjjIAjTmwr3YVxhCx8A2ltNxKCg7ZAmaZZtF9Ky8bWyWHeEHn8uWxhvuW2X
 p91Jp670TMCvF/olYo1aivTuVU86Bus509S290wo4hLJ7yNTJTcwohIh5pm43MGX9dvH
 HZ+t/fsc9fkgcZACwkNVUSJKWp4ywVIw/SdEY83COOoCjHKO7c8SNFnBpqT4WMafqzSW
 A8qtUl/CbrUy8x7oOZjwLemIA1ApTqgIQXiJaoA1R+rLV1Woyq9ImU35g+MrsoTHI1o3
 Jo8R/gn4yNt1e/bmO2pzIESa6IizIpdYCJxk0ae/n18c1kmka3Ou5pSBH8uHMe0gAu/v gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw99592rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Mar 2020 10:17:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 660FB100034;
        Mon, 23 Mar 2020 10:17:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 57AE42AAA8D;
        Mon, 23 Mar 2020 10:17:49 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Mar
 2020 10:17:48 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Mon, 23 Mar 2020 10:17:48 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Alain Volmat <avolmat@me.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dts: arm: stih407-family: remove duplicated rng nodes
Thread-Topic: [PATCH] dts: arm: stih407-family: remove duplicated rng nodes
Thread-Index: AQHWAGU6HT4ybsc2/E+ksa70VtGSzKhV1j6A
Date:   Mon, 23 Mar 2020 09:17:48 +0000
Message-ID: <6f1c708c-f415-5ed0-d39d-327737042507@st.com>
References: <20200322161616.19111-1-avolmat@me.com>
In-Reply-To: <20200322161616.19111-1-avolmat@me.com>
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
Content-ID: <65323D67C51D7046B2EE139A7B779FD7@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_02:2020-03-21,2020-03-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhaW7CoMKgDQoNCk9uIDMvMjIvMjAgNToxNiBQTSwgQWxhaW4gVm9sbWF0IHdyb3RlOg0K
PiB0aGUgMiBybmcgbm9kZXMgYXJlIGR1cGxpY2F0ZWQgd2l0aGluIHRoZSBzdGloNDA3LWZhbWls
eS5kdHNpDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsYWluIFZvbG1hdCA8YXZvbG1hdEBtZS5jb20+
DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1mYW1pbHkuZHRzaSB8IDE0IC0t
LS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDA3LWZhbWlseS5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvc3RpaDQwNy1mYW1pbHkuZHRzaQ0KPiBpbmRleCA3YzM2YzM3MjYwYTQuLjIz
YTE3NDZmM2JhYSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1mYW1p
bHkuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9zdGloNDA3LWZhbWlseS5kdHNpDQo+
IEBAIC03NjcsMjAgKzc2Nyw2IEBADQo+ICAJCQkJIDwmY2xrX3NfYzBfZmxleGdlbiBDTEtfRVRI
X1BIWT47DQo+ICAJCX07DQo+ICANCj4gLQkJcm5nMTA6IHJuZ0A4YTg5MDAwIHsNCj4gLQkJCWNv
bXBhdGlibGUgICAgICA9ICJzdCxybmciOw0KPiAtCQkJcmVnCQk9IDwweDA4YTg5MDAwIDB4MTAw
MD47DQo+IC0JCQljbG9ja3MgICAgICAgICAgPSA8JmNsa19zeXNpbj47DQo+IC0JCQlzdGF0dXMJ
CT0gIm9rYXkiOw0KPiAtCQl9Ow0KPiAtDQo+IC0JCXJuZzExOiBybmdAOGE4YTAwMCB7DQo+IC0J
CQljb21wYXRpYmxlICAgICAgPSAic3Qscm5nIjsNCj4gLQkJCXJlZwkJPSA8MHgwOGE4YTAwMCAw
eDEwMDA+Ow0KPiAtCQkJY2xvY2tzICAgICAgICAgID0gPCZjbGtfc3lzaW4+Ow0KPiAtCQkJc3Rh
dHVzCQk9ICJva2F5IjsNCj4gLQkJfTsNCj4gLQ0KPiAgCQltYWlsYm94MDogbWFpbGJveEA4ZjAw
MDAwICB7DQo+ICAJCQljb21wYXRpYmxlCT0gInN0LHN0aWg0MDctbWFpbGJveCI7DQo+ICAJCQly
ZWcJCT0gPDB4OGYwMDAwMCAweDEwMDA+Ow0KDQoNClJldmlld2VkLWJ5OiBQYXRyaWNlIENob3Rh
cmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQoNClRoYW5rcw0KDQpQYXRyaWNlDQo=
