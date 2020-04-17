Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58AFC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868CD208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ev4Oxbrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgDQK7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:59:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29006 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729512AbgDQK7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:59:31 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HAvcTt020241;
        Fri, 17 Apr 2020 12:59:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=1UoqmxcN2xm7+o3/rLjZ3PjuAvs4O6us+ArwhYCH4fo=;
 b=Ev4Oxbrk9KN78BIc4eXAhl/XXjLBk63APBtijsi6k01vO90Q4GblggozNpXJHwcyoL5N
 8HexTdpeE0AEQdulRfoaWbCEkcv5JQ1tapVNYIp9OdhYwnc7s+L014B5XvVJ2TpxYKUe
 FC/lwbQdqjoKjzbowUFRTrR8aY5kEstLiUGIpEQqNPWXVuM8T2GTaozPGnPSQMeea3L4
 tAZeSvSfJX6JRm1wGo4SdPEUGZ2sEjRtqou4N1m1m3WKY0diiXgS3jeIiW98F/Ga3xVP
 p9nUjh5+X5UDq+CtTSaaX32rnydz/6YWwtFPaaCYUWJF4vEbZK/S3qk8p7L67gS4l81Q pA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn8s8yw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 12:59:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2CC0D10002A;
        Fri, 17 Apr 2020 12:59:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D05C2AC2CA;
        Fri, 17 Apr 2020 12:59:20 +0200 (CEST)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 17 Apr
 2020 12:59:19 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 17 Apr 2020 12:59:19 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Alain VOLMAT <alain.volmat@st.com>
Subject: Re: [GIT PULL] STi DT update for v5.8 round 1
Thread-Topic: [GIT PULL] STi DT update for v5.8 round 1
Thread-Index: AQHWFKXGRE1MaIpH7Eq9IiX+E6fFPah9A6mA
Date:   Fri, 17 Apr 2020 10:59:19 +0000
Message-ID: <546fb50c-3b71-f77d-f499-5c26e0b40d9c@st.com>
References: <6fd7974d-a5f2-f7cd-fa7a-d761fac75b3c@st.com>
In-Reply-To: <6fd7974d-a5f2-f7cd-fa7a-d761fac75b3c@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7651BD43D6D92D4095BBBFC96510A12C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_03:2020-04-17,2020-04-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkNCg0KSSBoYXZlIGZvcmdvdHRlbiB0byBhZGQgc29jQGtlcm5lbC5vcmcsIGkgd2lsbCBy
ZXNlbmQgdGhpcyBwdWxsIHJlcXVlc3QNCg0KUGF0cmljZQ0KDQpPbiA0LzE3LzIwIDEyOjQ4IFBN
LCBQYXRyaWNlIENIT1RBUkQgd3JvdGU6DQo+IEhpIEFybmQsIE9sb2YsIEtldmluDQo+DQo+IFBs
ZWFzZSBmaW5kIFNUaSBkdCB1cGRhdGUgZm9yIHY1Ljggcm91bmQgMToNCj4NCj4NCj4gVGhlIGZv
bGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA4ZjNkOWYzNTQyODY3NDVjNzUxMzc0ZjVmMWZj
YWZlZTZiM2YzMTM2Og0KPg0KPiAgIExpbnV4IDUuNy1yYzEgKDIwMjAtMDQtMTIgMTI6MzU6NTUg
LTA3MDApDQo+DQo+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KPg0K
PiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wY2hvdGFy
ZC9zdGkuZ2l0IHN0aS1kdC1mb3ItdjUuOC1yb3VuZDENCj4NCj4gZm9yIHlvdSB0byBmZXRjaCBj
aGFuZ2VzIHVwIHRvIDdmMjFhODUwODViNzIxMWVjMWQxNTgzZDEwOTEyYWQyNzJhYjc2YmM6DQo+
DQo+ICAgZHRzOiBhcm06IHN0aWg0MDctZmFtaWx5OiByZW1vdmUgZHVwbGljYXRlZCBybmcgbm9k
ZXMgKDIwMjAtMDQtMTcgMTA6MTc6NTQgKzAyMDApDQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gU1RpIERUIGZp
eGVzOg0KPiAtIFJlbW92ZSBkdXBsaWNhdGVkIHJuZyBub2RlIGluIHN0aWg0MDctZmFtaWx5LmR0
c2kNCj4gLSBGaXggY29tcGxhaW4gYWJvdXQgSVJRX1RZUEVfTk9ORSB1c2FnZSBpbiBzdGloNDE4
LmR0c2kNCj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBBbGFpbiBWb2xtYXQgKDIpOg0KPiAgICAgICBkdHM6IGFy
bTogc3RpaDQxODogRml4IGNvbXBsYWluIGFib3V0IElSUV9UWVBFX05PTkUgdXNhZ2UNCj4gICAg
ICAgZHRzOiBhcm06IHN0aWg0MDctZmFtaWx5OiByZW1vdmUgZHVwbGljYXRlZCBybmcgbm9kZXMN
Cj4NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctZmFtaWx5LmR0c2kgfCAxNCAtLS0tLS0t
LS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxOC5kdHNpICAgICAgICB8ICA4ICsr
KystLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25z
KC0p
