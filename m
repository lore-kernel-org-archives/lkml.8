Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8CAC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857632082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Z4N0jj36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBDMhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:37:34 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17300 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727126AbgBDMhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:37:34 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014CS5JR011049;
        Tue, 4 Feb 2020 13:37:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=j6Gu6X4AdfXr88JUQjVDd6lirRJ23U4rW0VUUwrSU7w=;
 b=Z4N0jj36W8Vt1DmKvyH5ye5ahyNX0/aVmDkOJloX3vMrWE9fIBUGnrfK+GKKCizxQIFq
 EbLU+3xii1fDgNi0QeJbaSKLQA41m7q4N0LAa5B2QsyetTPkguKdMpKV/GjEQJnMgQa1
 o+xQlcV7mR7Tl5kFwNjGNDoogJ1g75y01WFpiRxvupf98Y+/L7Sh1pTMINaAW+lcP9tX
 zJUVLDdG9SEzpMRg7j5TWgYjlu6IWpQ/WeIsTwOMmvj7g/4AEohXFV/iy+Kf0SMwZFZE
 nVAJq4TgE7fC3Fy+dqs5AYlGYNFG2HBKrQtF7oN2t6zZ8b9UlzwVpk91GA0B3urga2FE OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvybe1fms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 13:37:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 865D410002A;
        Tue,  4 Feb 2020 13:37:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A2182BE237;
        Tue,  4 Feb 2020 13:37:15 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 13:37:15 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Tue, 4 Feb 2020 13:37:15 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Patrice CHOTARD <patrice.chotard@st.com>
Subject: [GIT PULL] STi DT update for v5.6 round 1
Thread-Topic: [GIT PULL] STi DT update for v5.6 round 1
Thread-Index: AQHV21fUlvmf1pIO+EOSI+9it4Ghsg==
Date:   Tue, 4 Feb 2020 12:37:14 +0000
Message-ID: <c6f76adc-b32f-a64f-c7b1-417a26de1667@st.com>
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
Content-ID: <46CB922553A16C469783DA69C0F2ED22@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_03:2020-02-04,2020-02-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwgT2xvZiwgS2V2aW4NCg0KUGxlYXNlIGZpbmQgU1RpIGR0IHVwZGF0ZSBmb3IgdjUu
NiByb3VuZCAxOg0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGQ1MjI2ZmE2
ZGJhZTA1NjllZTQzZWNmYzA4YmRjZDY3NzBmYzQ3NTU6DQoNCg0KwqAgTGludXggNS41ICgyMDIw
LTAxLTI2IDE2OjIzOjAzIC0wODAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KwqAgZ2l0QGdpdG9saXRlLmtlcm5lbC5vcmc6cHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3BjaG90YXJkL3N0aS5naXQgdGFncy9zdGktZHQtZm9yLTUuNi1yb3VuZDENCg0KZm9y
IHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDIxZWViYWU5YTExZmYxOGZlNmQ2YjQzYWRjY2Fk
ZDUzM2FiZGYwZDY6DQoNCsKgIEFSTTogc3RpaHh4eC1iMjEyMC5kdHNpOiBmaXh1cCBzb3VuZCBm
cmFtZS1pbnZlcnNpb24gKDIwMjAtMDItMDQgMTE6MjE6MzcgKzAxMDApDQoNCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClNU
aSBkdCBmaXhlczoNCi0tLS0tLS0tLS0tLS0NCsKgIC0gcmVtb3ZlIGRlcHJlY2F0ZWQgU3lub3Bz
eXMgUEhZIGR0IHByb3BlcnRpZXMNCsKgIC0gZml4IHNvdW5kIGZyYW1lLWludmVyc2lvbiBwcm9w
ZXJ0eQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpLdW5pbm9yaSBNb3JpbW90byAoMSk6DQrCoMKgwqDCoMKgIEFSTTog
c3RpaHh4eC1iMjEyMC5kdHNpOiBmaXh1cCBzb3VuZCBmcmFtZS1pbnZlcnNpb24NCg0KUGF0cmlj
ZSBDaG90YXJkICgxKToNCsKgwqDCoMKgwqAgQVJNOiBkdHM6IHN0aWg0MTAtYjIyNjA6IFJlbW92
ZSBkZXByZWNhdGVkIHNucHMgUEhZIHByb3BlcnRpZXMNCg0KwqBhcmNoL2FybS9ib290L2R0cy9z
dGloNDEwLWIyMjYwLmR0c8KgIHwgMyAtLS0NCsKgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaHh4eC1i
MjEyMC5kdHNpIHwgMiArLQ0KwqAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRl
bGV0aW9ucygtKQ0K
