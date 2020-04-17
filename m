Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D87C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2C721D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AojqR0yU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgDQKtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:49:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57522 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729301AbgDQKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:49:02 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HAluJO027657;
        Fri, 17 Apr 2020 12:48:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=iaKOkD8P3V9vzBfI10Q5OH02fO1tCp/xIClsudvRayc=;
 b=AojqR0yUgJLEggzEyJNJcbFYUAtixBNt0sfjzgVA70WwmZOZSEQ1hIxyWuLEiua+ce6d
 upBUtUnkkt0nlGhKmXrjQ97Uvtj8hzzEeG99tuSmk8KLRtPp7/swlbNFIyBCKUZWWgGX
 eaX7h9lezY7diurQPhkkJLIlaEuWdTLqSf4Gi+aFR1q/04PAN5ahiQMbqVsZiAsGBNKI
 8N/C8gUZptet33XqukunlUARxuzEXU2+ERLu5yaOqp8K0OGBuU4vuiafid+WRCcGcnPb
 gSRaor8E+yopxM8dn3s1rSuz+qpnHozPcEkDN5DUHngaO6bComVOVfUKJR0I3wBut7e8 gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn760xw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 12:48:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF62610002A;
        Fri, 17 Apr 2020 12:48:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D34812AA9F0;
        Fri, 17 Apr 2020 12:48:48 +0200 (CEST)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 12:48:48 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 17 Apr 2020 12:48:48 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Alain VOLMAT <alain.volmat@st.com>
Subject: [GIT PULL] STi DT update for v5.8 round 1
Thread-Topic: [GIT PULL] STi DT update for v5.8 round 1
Thread-Index: AQHWFKXGRE1MaIpH7Eq9IiX+E6fFPQ==
Date:   Fri, 17 Apr 2020 10:48:48 +0000
Message-ID: <6fd7974d-a5f2-f7cd-fa7a-d761fac75b3c@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <387F1F919E614F4591A0EA8A484238EC@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_03:2020-04-17,2020-04-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwgT2xvZiwgS2V2aW4NCg0KUGxlYXNlIGZpbmQgU1RpIGR0IHVwZGF0ZSBmb3IgdjUu
OCByb3VuZCAxOg0KDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgOGYzZDlm
MzU0Mjg2NzQ1Yzc1MTM3NGY1ZjFmY2FmZWU2YjNmMzEzNjoNCg0KICBMaW51eCA1LjctcmMxICgy
MDIwLTA0LTEyIDEyOjM1OjU1IC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVw
b3NpdG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvcGNob3RhcmQvc3RpLmdpdCBzdGktZHQtZm9yLXY1Ljgtcm91bmQxDQoNCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA3ZjIxYTg1MDg1YjcyMTFlYzFkMTU4M2QxMDkxMmFkMjcy
YWI3NmJjOg0KDQogIGR0czogYXJtOiBzdGloNDA3LWZhbWlseTogcmVtb3ZlIGR1cGxpY2F0ZWQg
cm5nIG5vZGVzICgyMDIwLTA0LTE3IDEwOjE3OjU0ICswMjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpTVGkgRFQg
Zml4ZXM6DQotIFJlbW92ZSBkdXBsaWNhdGVkIHJuZyBub2RlIGluIHN0aWg0MDctZmFtaWx5LmR0
c2kNCi0gRml4IGNvbXBsYWluIGFib3V0IElSUV9UWVBFX05PTkUgdXNhZ2UgaW4gc3RpaDQxOC5k
dHNpDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCkFsYWluIFZvbG1hdCAoMik6DQogICAgICBkdHM6IGFybTogc3RpaDQx
ODogRml4IGNvbXBsYWluIGFib3V0IElSUV9UWVBFX05PTkUgdXNhZ2UNCiAgICAgIGR0czogYXJt
OiBzdGloNDA3LWZhbWlseTogcmVtb3ZlIGR1cGxpY2F0ZWQgcm5nIG5vZGVzDQoNCiBhcmNoL2Fy
bS9ib290L2R0cy9zdGloNDA3LWZhbWlseS5kdHNpIHwgMTQgLS0tLS0tLS0tLS0tLS0NCiBhcmNo
L2FybS9ib290L2R0cy9zdGloNDE4LmR0c2kgICAgICAgIHwgIDggKysrKy0tLS0NCiAyIGZpbGVz
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo=
