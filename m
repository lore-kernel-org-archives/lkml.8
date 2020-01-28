Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC55C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A442173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wJaerqNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgA1Qlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:41:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47306 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgA1Qlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:41:51 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SGWbJd004416;
        Tue, 28 Jan 2020 17:41:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=X6unbUqYU6R+TSthYBHa+4O1CSkYj4znlr55hHsVQV8=;
 b=wJaerqNHP+JqtLXcMJpzcCM4s0C2tAyEdrX1+ACeGQ6wY/iljHyc7xnerXaACfVp1L35
 ID0nEdDN5DxOvNzq9as2e7+BHYii6Xih+qV+eNYCdU1xf8u5LSR6l7ABA4Hnwgisr8Fj
 NfNVEFhwmLaVzyPrHdAKJAKNJKCiFiL2Epm6Zl/Yz2SjRkqTmsIX9fljyD6CKI/Pvr6w
 byJZzNyEZS+djW3p8IUKVR3mfgOg5qnPyhku6ooLOfxyByG7s6+Ggpy+2LKq5mquwWEh
 QAZZ5I21dmmMZdpElPbuPXI9VhV1xRGD7LhPJANmiGi/PZbJbxxZx+IRVjmSOIdZtEnA tQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdekeutu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 17:41:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB283100038;
        Tue, 28 Jan 2020 17:41:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node3.st.com [10.75.127.21])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A1D52FF5FB;
        Tue, 28 Jan 2020 17:41:29 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE3.st.com
 (10.75.127.21) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 17:41:29 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 28 Jan 2020 17:41:29 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "lkml@metux.net" <lkml@metux.net>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
Thread-Topic: [PATCH v2 2/7] bus: Introduce firewall controller framework
Thread-Index: AQHV1fD3WqS5xyjWNkazyajQl95bjqgAKU6AgAANnwA=
Date:   Tue, 28 Jan 2020 16:41:29 +0000
Message-ID: <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com>
 <20200128155243.GC3438643@kroah.com>
In-Reply-To: <20200128155243.GC3438643@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDCF163FFEDC9E4EA7E20A7087EB997E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI4LzIwIDQ6NTIgUE0sIEdyZWcgS0ggd3JvdGU6DQo+IE9uIFR1ZSwgSmFuIDI4LCAy
MDIwIGF0IDA0OjM4OjAxUE0gKzAxMDAsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4gVGhl
IGdvYWwgb2YgdGhpcyBmcmFtZXdvcmsgaXMgdG8gb2ZmZXIgYW4gaW50ZXJmYWNlIGZvciB0aGUN
Cj4+IGhhcmR3YXJlIGJsb2NrcyBjb250cm9sbGluZyBidXMgYWNjZXNzZXMgcmlnaHRzLg0KPj4N
Cj4+IEJ1cyBmaXJld2FsbCBjb250cm9sbGVycyBhcmUgdHlwaWNhbGx5IHVzZWQgdG8gY29udHJv
bCBpZiBhDQo+PiBoYXJkd2FyZSBibG9jayBjYW4gcGVyZm9ybSByZWFkIG9yIHdyaXRlIG9wZXJh
dGlvbnMgb24gYnVzLg0KPiBTbyBwdXQgdGhpcyBpbiB0aGUgYnVzLXNwZWNpZmljIGNvZGUgdGhh
dCBjb250cm9scyB0aGUgYnVzIHRoYXQgdGhlc2UNCj4gZGV2aWNlcyBsaXZlIG9uLiAgV2h5IHB1
dCBpdCBpbiB0aGUgZHJpdmVyIGNvcmUgd2hlbiB0aGlzIGlzIG9ubHkgb24gb25lDQo+ICJidXMi
IChpLmUuIHRoZSBjYXRjaC1hbGwtYW5kLWEtYmFnLW9mLWNoaXBzIHBsYXRmb3JtIGJ1cyk/DQoN
Ckl0IGlzIHJlYWxseSBzaW1pbGFyIHRvIHdoYXQgcGluIGNvbnRyb2xsZXIgZG9lcywgY29uZmln
dXJpbmcgYW4gDQpoYXJkd2FyZSBibG9jayBnaXZlbiBEVCBpbmZvcm1hdGlvbi4NCg0KSSBjb3Vs
ZCBhcmd1ZSB0aGF0IGZpcmV3YWxscyBhcmUgbm90IGJ1cyB0aGVtc2VsdmVzIHRoZXkgb25seSBp
bnRlcmFjdCANCndpdGggaXQuDQoNCkJ1cyBmaXJld2FsbHMgZXhpc3Qgb24gb3RoZXIgU29DLCBJ
IGhvcGUgc29tZSBvdGhlcnMgY291bGQgYmUgYWRkZWQgaW4gDQp0aGlzIGZyYW1ld29yay4gRVRa
UEMgaXMgb25seSB0aGUgZmlyc3QuDQoNCj4NCj4gQW5kIHJlYWxseSwgdGhpcyBzaG91bGQganVz
dCBiZSBhIHRvdGFsbHkgbmV3IGJ1cyB0eXBlLCByaWdodD8gIEFuZCBhbnkNCj4gZGV2aWNlcyBv
biB0aGlzIGJ1cyBzaG91bGQgYmUgY2hhbmdlZCB0byBiZSBvbiB0aGlzIG5ldyBidXMsIGFuZCB0
aGUNCj4gZHJpdmVycyBjaGFuZ2VkIHRvIHN1cHBvcnQgdGhlbSwgaW5zdGVhZCBvZiB0cnlpbmcg
dG8gb3ZlcmxvYWQgdGhlDQo+IHBsYXRmb3JtIGJ1cyB3aXRoIG1vcmUgc3R1ZmYuDQoNCkkgaGF2
ZSB0cmllZCB0byB1c2UgdGhlIGJ1cyBub3RpZmllciB0byBhdm9pZCB0byBhZGQgdGhpcyBjb2Rl
IGF0IHByb2JlIA0KdGltZSBidXQgd2l0aG91dCBzdWNjZXNzOg0KDQpodHRwczovL2xrbWwub3Jn
L2xrbWwvMjAxOC8yLzI3LzMwMA0KDQpJIGhhdmUgYWxzbyB0cmllZCB0byBkaXNhYmxlIHRoZSBu
b2RlcyBhdCBydW50aW1lIGFuZCBNYXJrIFJ1dGxhbmQgDQpleHBsYWluIG1lIHdoeSBpdCB3YXMg
d3JvbmcuDQoNCkJlbmphbWluDQoNCj4NCj4gdGhhbmtzLA0KPg0KPiBncmVnIGstaA==
