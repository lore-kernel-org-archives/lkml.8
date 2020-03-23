Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2A1C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0381E2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="senVKjhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgCWJU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:20:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7410 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727704AbgCWJUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:20:25 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02N987et024548;
        Mon, 23 Mar 2020 10:20:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Dudl/6ic43fwYciD6uXT4+SGztEtn/oENuWytjVm2+Y=;
 b=senVKjhcdhef1B/iQcKpUgJkG8zt/RUJCmd393A32hibCC31Lnchr45p1FmQqfPGP2XD
 PLaXyKRA3Losj2q/XVq6qqDFzNvj2OTy5Y354FKVSqKBAJGTrrwTUhyK+fE9Cx7/MEi+
 0n3XM/Bhwpkn4POL/Q9e5w+YO0Rm8h+5rHL5G59jZvuUNyagdfbeQ2TMLL1PPAsPaLUe
 cV+HXglAkZi8XuQzgzxBt79akZXmBNUt0k9dywHnkgBcZjjqLYxhflAE8T06uWfApmg3
 HyeYN7/gw2qhvk5WM6FBV1lHh2DRiaFqSI96M8DBz77P8wxl5cj5CnokhaWAMMuQ9kF7 /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw8xds6dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Mar 2020 10:20:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3340810002A;
        Mon, 23 Mar 2020 10:20:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D8B22AAA80;
        Mon, 23 Mar 2020 10:20:09 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 23 Mar
 2020 10:20:08 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Mon, 23 Mar 2020 10:20:08 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Alain Volmat <avolmat@me.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: clk-flexgen: fix clock-critical handling
Thread-Topic: [PATCH] clk: clk-flexgen: fix clock-critical handling
Thread-Index: AQHWAFNHkLAqe43qQkuc3T0nvLdzvahV1xEA
Date:   Mon, 23 Mar 2020 09:20:08 +0000
Message-ID: <f053f9c4-557c-d32b-7bc6-c3ff2c6fa966@st.com>
References: <20200322140740.3970-1-avolmat@me.com>
In-Reply-To: <20200322140740.3970-1-avolmat@me.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8E9D270121A0745ABFB28C37B2BC1A0@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_02:2020-03-21,2020-03-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhaW4NCg0KT24gMy8yMi8yMCAzOjA3IFBNLCBBbGFpbiBWb2xtYXQgd3JvdGU6DQo+IEZp
eGVzIGFuIGlzc3VlIGxlYWRpbmcgdG8gaGF2aW5nIGFsbCBjbG9ja3MgZm9sbG93aW5nIGEgY3Jp
dGljYWwNCj4gY2xvY2tzIG1hcmtlZCBhcyB3ZWxsIGFzIGNyaXRpY2Fscy4NCj4NCj4gRml4ZXM6
IGZhNjQxNWFmZmUyMCAoImNsazogc3Q6IGNsay1mbGV4Z2VuOiBEZXRlY3QgY3JpdGljYWwgY2xv
Y2tzIikNCj4NCj4gU2lnbmVkLW9mZi1ieTogQWxhaW4gVm9sbWF0IDxhdm9sbWF0QG1lLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2Nsay9zdC9jbGstZmxleGdlbi5jIHwgMSArDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3N0
L2Nsay1mbGV4Z2VuLmMgYi9kcml2ZXJzL2Nsay9zdC9jbGstZmxleGdlbi5jDQo+IGluZGV4IDQ0
MTNiNmUwNGE4ZS4uNTU4NzNkNGI3NjAzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9zdC9j
bGstZmxleGdlbi5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL3N0L2Nsay1mbGV4Z2VuLmMNCj4gQEAg
LTM3NSw2ICszNzUsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgc3Rfb2ZfZmxleGdlbl9zZXR1cChz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4gIA0KPiArCQlm
bGV4X2ZsYWdzICY9IH5DTEtfSVNfQ1JJVElDQUw7DQo+ICAJCW9mX2Nsa19kZXRlY3RfY3JpdGlj
YWwobnAsIGksICZmbGV4X2ZsYWdzKTsNCj4gIA0KPiAgCQkvKg0KDQoNClJldmlld2VkLWJ5OiBQ
YXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQoNClRoYW5rcw0KDQpQYXRy
aWNlDQo=
