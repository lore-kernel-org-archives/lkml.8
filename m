Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6418C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F1A206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jYGxGa9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgBUPzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:55:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728235AbgBUPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:55:23 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LFhAUN005224;
        Fri, 21 Feb 2020 16:54:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=ROT/iOnqrfVSU9ijMpaQxfKfuAyFkTIabMfISg7FtfU=;
 b=jYGxGa9j/+XAP2+y41QpABkqTrowJtuZQyejHh2XeJPqio5sbPSNKrq7RXTksUw/w61J
 bvJIl3pI2htB7ykpduKO8XZTNzjfn26vK6tAYAmV8MY6SjbY0/FOessi0qSytIlPbSO1
 9vwLamnm7ZDFiabh0Zor9eWPuZkH79g9AkcAgI+IcPuSQsOVD64CqAG7nvlq/Q/+kpQk
 QCrivJ91JhTcpwoxDvsZI6rMb2H4XibBMUJiGKOj3jDQH4KcsvqZQLyERXrk5Or+D5bg
 G0/4nnvdpYL/u1VXwzAoBOEO9bVmZyPAlQODkhT19v4MFe8Wp9LNtlXtdL6Ns0TeVPdv Xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y8uag090q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 16:54:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A1B71100034;
        Fri, 21 Feb 2020 16:54:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 794412BC7C1;
        Fri, 21 Feb 2020 16:54:51 +0100 (CET)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Feb
 2020 16:54:51 +0100
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1473.003; Fri, 21 Feb 2020 16:54:51 +0100
From:   Erwan LE RAY <erwan.leray@st.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Olof Johansson" <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Subject: Re: [PATCH v3 0/4] STM32 early console
Thread-Topic: [PATCH v3 0/4] STM32 early console
Thread-Index: AQHV2prax5EEBcSNuEGO1gU2i+LKNqgJeEAAgBxgRQA=
Date:   Fri, 21 Feb 2020 15:54:51 +0000
Message-ID: <889ce6c3-bcce-c0fa-69fd-3a05f6e44973@st.com>
References: <20200203140425.26579-1-erwan.leray@st.com>
 <CAJiuCcfRuHXajo7+cDMpQ73vhGuerW3_ObrfG0YOEzogKaH-sA@mail.gmail.com>
In-Reply-To: <CAJiuCcfRuHXajo7+cDMpQ73vhGuerW3_ObrfG0YOEzogKaH-sA@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <22961633DE64E3408A1C412FCA67F660@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_05:2020-02-21,2020-02-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnVzc2VsLCBNYXgsIEFsZXgsIEFybmQsIExpbnVzIGFuZCBPbG9mLA0KDQpHZW50bGUgcmVt
aW5kZXIuDQoNCkNhbiB5b3UgcGxlYXNlIHByb3ZpZGUgeW91ciBmZWVkYmFjayBvbiB0aGlzIHNl
cmllcyA/DQoNCkJlc3QgUmVnYXJkcywgRXJ3YW4uDQoNCg0KT24gMi8zLzIwIDM6MzUgUE0sIENs
w6ltZW50IFDDqXJvbiB3cm90ZToNCj4gSGkgRXJ3YW4sDQo+DQo+IE9uIE1vbiwgMyBGZWIgMjAy
MCBhdCAxNTowNCwgRXJ3YW4gTGUgUmF5IDxlcndhbi5sZXJheUBzdC5jb20+IHdyb3RlOg0KPj4g
QWRkIFVBUlQgaW5zdGFuY2UgY29uZmlndXJhdGlvbiB0byBTVE0zMiBGNCBhbmQgRjcgZWFybHkg
Y29uc29sZS4NCj4+IEFkZCBTVE0zMiBINyBhbmQgTVAxIGVhcmx5IGNvbnNvbGUgc3VwcG9ydC4N
Cj4+DQo+PiBDaGFuZ2VzIGluIHYzOg0KPj4gLSBmaXggYSBtaXNzaW5nIGNvbmRpdGlvbiBmb3Ig
U1RNMzJNUDENCj4+DQo+PiBDaGFuZ2VzIGluIHYyOg0KPj4gLSBzcGxpdCAiW1BBVENIXSBBUk06
IGRlYnVnOiBzdG0zMjogYWRkIFVBUlQgZWFybHkgY29uc29sZSBjb25maWd1cmF0aW9uIg0KPj4g
ICAgaW50byBzZXBhcmF0ZSBwYXRjaGVzIGFzIHN1Z2dlc3RlZCBieSBDbGVtZW50IGludG8gWzFd
DQo+IFRoYW5rcyBmb3Igc3BsaXR0aW5nIHRoZSBwYXRjaCwgdGhlIHdob2xlIHNlcmllcyBsb29r
cyBmaW5lIHRvIG1lLg0KPg0KPiBBY2tlZC1ieTogQ2zDqW1lbnQgUMOpcm9uIDxwZXJvbi5jbGVt
QGdtYWlsLmNvbT4NCj4NCj4gQ2zDqW1lbnQNCj4NCj4NCj4NCj4+IFsxXSBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAxOS80LzEwLzE5OQ0KPj4NCj4+IEVyd2FuIExlIFJheSAoNCk6DQo+PiAgICBB
Uk06IGRlYnVnOiBzdG0zMjogYWRkIFVBUlQgZWFybHkgY29uc29sZSBjb25maWd1cmF0aW9uIGZv
ciBTVE0zMkY0DQo+PiAgICBBUk06IGRlYnVnOiBzdG0zMjogYWRkIFVBUlQgZWFybHkgY29uc29s
ZSBjb25maWd1cmF0aW9uIGZvciBTVE0zMkY3DQo+PiAgICBBUk06IGRlYnVnOiBzdG0zMjogYWRk
IFVBUlQgZWFybHkgY29uc29sZSBzdXBwb3J0IGZvciBTVE0zMkg3DQo+PiAgICBBUk06IGRlYnVn
OiBzdG0zMjogYWRkIFVBUlQgZWFybHkgY29uc29sZSBzdXBwb3J0IGZvciBTVE0zMk1QMQ0KPj4N
Cj4+ICAgYXJjaC9hcm0vS2NvbmZpZy5kZWJ1ZyAgICAgICAgIHwgNDIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLQ0KPj4gICBhcmNoL2FybS9pbmNsdWRlL2RlYnVnL3N0bTMyLlMg
fCAgOSArKysrLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDEx
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IC0tDQo+PiAyLjE3LjENCj4+
