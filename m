Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24ECC83006
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9BB2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="u3V7ADK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD1NOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:14:09 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25272 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726764AbgD1NOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:14:09 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SDChAB020530;
        Tue, 28 Apr 2020 15:13:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=lacSSkWzlQgfEqOpGzNZ5KMynxTMC2Ry6JNMtvAjEgo=;
 b=u3V7ADK5t6k/7/qA6ArL15iaaSyWdIzGLKSd7sRrxzaK/T+LY5qlT5NV0+/gLJUOGcJ+
 7wzM/WyZ7ffuuxXCDl54FjdOsCmqULKzBRmIdvdnWIb9AJEwjcS4zOi1Q2c/fNHTR1Vk
 eLojP+Ascrbi66Yb6ZYVlQaiGOg/XVAhBxWqlq6ABmTnSzUp1dok0i1CHNXNEfXg1BCv
 oRQq9HtRcKuntWPAlO2LYdxDmqtwUIKx40yqkU0pFbPJVBxfD7Ob3iIsqjztRoxDAVPC
 9ig1xxcqZQeSYGjCnHVOTRKzvM/Tck4hvwUR8AHvMTLJmGiNmXWPuGzHsqFNRrdStTJn 3w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30n4j5v5r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 15:13:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EFECD10002A;
        Tue, 28 Apr 2020 15:13:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF0862B8A0A;
        Tue, 28 Apr 2020 15:13:45 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Apr
 2020 15:13:45 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 28 Apr 2020 15:13:45 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: bus: Add firewall bindings
Thread-Topic: [PATCH 1/5] dt-bindings: bus: Add firewall bindings
Thread-Index: AQHWFxpQ9gVgCvdMT0SVViT5CkNk0KiOT0yAgAAeqAA=
Date:   Tue, 28 Apr 2020 13:13:45 +0000
Message-ID: <13b16e13-690b-ad3f-a800-28c7805cbb96@st.com>
References: <20200420134800.31604-1-benjamin.gaignard@st.com>
 <20200420134800.31604-2-benjamin.gaignard@st.com>
 <CACRpkdatGwWyruTLC=+BUtnunvqyxnXAYDhcHqy26oeud8Bs1w@mail.gmail.com>
In-Reply-To: <CACRpkdatGwWyruTLC=+BUtnunvqyxnXAYDhcHqy26oeud8Bs1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C34B4DE90D8EF4C901A2C48542A843B@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_09:2020-04-28,2020-04-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjgvMjAgMToyNCBQTSwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gSGkgQmVuamFt
aW4sDQo+DQo+IE9uIE1vbiwgQXByIDIwLCAyMDIwIGF0IDM6NDggUE0gQmVuamFtaW4gR2FpZ25h
cmQNCj4gPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4gd3JvdGU6DQo+PiBBZGQgc2NoZW1hcyBm
b3IgZmlyZXdhbGwgY29uc3VtZXIgYW5kIHByb3ZpZGVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+DQo+PiArJGlkOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9idXMvc3RtMzIvZmlyZXdhbGwtY29uc3VtZXIu
eWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Nv
cmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQ29tbW9uIEJ1cyBGaXJld2FsbCBjb25zdW1lciBi
aW5kaW5nDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIEJlbmphbWluIEdhaWduYXJk
IDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+DQo+IFRoaXMgcmVhbGx5IG5lZWRzIGEgZGVzY3Jp
cHRpb246IHRvIHRlbGwgd2hhdCBpcyBnb2luZyBvbiBhbmQgd2hhdA0KPiB0aGVzZSBmaXJld2Fs
bHMNCj4gYXJlIGZvciBhbmQgaG93IHRoZXkgYXJlIHN1cHBvc2VkIHRvIHdvcmsuDQpIaSBMaW51
cywNCg0KRG9lcyB0aGUgZm9sbG93aW5nIGRlc2NyaXB0aW9uIHNvdW5kIGdvb2QgZm9yIHlvdToN
CkZpcmV3YWxsIHByb3BlcnRpZXMgcHJvdmlkZSB0aGUgcG9zc2libGUgZmlyZXdhbGwgYnVzIGNv
bnRyb2xsZXIgDQpjb25maWd1cmF0aW9ucyBmb3IgYSBkZXZpY2UuDQpCdXMgZmlyZXdhbGwgY29u
dHJvbGxlcnMgYXJlIHR5cGljYWxseSB1c2VkIHRvIGNvbnRyb2wgaWYgYSBoYXJkd2FyZSANCmJs
b2NrIGNhbiBwZXJmb3JtIHJlYWQgb3Igd3JpdGUgb3BlcmF0aW9ucyBvbiBidXMuDQpUaGUgY29u
dGVudHMgb2YgdGhlIGZpcmV3YWxsIGJ1cyBjb25maWd1cmF0aW9uIHByb3BlcnRpZXMgYXJlIGRl
ZmluZWQgYnkgDQp0aGUgYmluZGluZyBmb3IgdGhlIGluZGl2aWR1YWwgZmlyZXdhbGwgY29udHJv
bGxlciBkZXZpY2UuDQpUaGUgZmlyc3QgY29uZmlndXJhdGlvbiAnZmlyZXdhbGwtMCcgb3IgdGhl
IG9uZSBuYW1lZCAnZGVmYXVsdCcgaXMgDQphcHBsaWVkIGJlZm9yZSBwcm9iaW5nIHRoZSBkZXZp
Y2UgaXRzZWxmLg0KDQpSZWdhcmRzLA0KQmVuamFtaW4NCj4NCj4gSSBzdXBwb3NlIGp1c3QgYSBi
aXQgb2YgY3V0J24ncGFzdGUgZnJvbSB0aGUgY292ZXIgbGV0dGVyIDpEDQo+DQo+IE90aGVyd2lz
ZSBpdCBsb29rcyBnb29kIHRvIG1lLg0KPg0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K
