Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE330C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A66B221F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hPcIpy9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgDQKp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:45:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22372 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729143AbgDQKpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:45:25 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HAgK8n005749;
        Fri, 17 Apr 2020 12:45:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=AcG7+GmMq13N6s6AesohpTV9dUnF9RbuITAh7iOUyd0=;
 b=hPcIpy9A4/lBcGev7bb79Qb+LtnohSo19cR5aJWglNylUEAdxISgYT9vdnVqdyN3D3R+
 OX8NUbXcFP7xNWfxGiLOZVMENZ9Kq4IYb6WpCJZp/mi+mnusr1g/3RsmluUXaiviSFwv
 4UEj0naU8bK58m819nF1Zqsq/YpI0At0KmX0g3MuY8ykLjUDN6v81DSpmEiW9HJdJ68o
 2o68H9lgpXz1eaA7ZKRQq0aLc5Dgv0h+UKx0Xe91wsbKEB2V7++yXg0oCbYWp878QART
 1qH8z5C5irosu1jx6tFRU+RzJOW2i0rNgI0SYfQ8Z9AGtQli8njI1hRKj2vDl0OwF53K +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn94rxuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 12:45:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA1B4100034;
        Fri, 17 Apr 2020 12:45:07 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4CFF2A96FC;
        Fri, 17 Apr 2020 12:45:07 +0200 (CEST)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 17 Apr
 2020 12:45:07 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 17 Apr 2020 12:45:07 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Alain Volmat <avolmat@me.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dts: arm: stih418: Fix complain about IRQ_TYPE_NONE usage
Thread-Topic: [PATCH] dts: arm: stih418: Fix complain about IRQ_TYPE_NONE
 usage
Thread-Index: AQHWAGVD1LVv67fNzEC4+ePomo0cJKh9KDEA
Date:   Fri, 17 Apr 2020 10:45:07 +0000
Message-ID: <348e46ed-c0f6-ffb8-f8e0-0aa6e7e207f9@st.com>
References: <20200322161631.19151-1-avolmat@me.com>
In-Reply-To: <20200322161631.19151-1-avolmat@me.com>
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
Content-ID: <50C629EAC0776D40B4B6E7A1DFC45ECF@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_03:2020-04-17,2020-04-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhaW4NCg0KT24gMy8yMi8yMCA1OjE2IFBNLCBBbGFpbiBWb2xtYXQgd3JvdGU6DQo+IFNp
bmNlIGNvbW1pdCA4M2E4NmZiYjViNTYgKCJpcnFjaGlwL2dpYzogTG91ZGx5IGNvbXBsYWluIGFi
b3V0IHRoZSB1c2Ugb2YgSVJRX1RZUEVfTk9ORSIpDQo+IGtlcm5lbCBpcyBjb21wbGFpbmluZyBh
Ym91dCB0aGUgSVJRX1RZUEVfTk9ORSB1c2FnZSB3aGljaCBzaG91bGRuJ3QNCj4gYmUgdXNlZC4N
Cj4NCj4gVXNlIElSUV9UWVBFX0xFVkVMX0hJR0ggaW5zdGVhZC4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogQWxhaW4gVm9sbWF0IDxhdm9sbWF0QG1lLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290
L2R0cy9zdGloNDE4LmR0c2kgfCA4ICsrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvc3RpaDQxOC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxOC5kdHNpDQo+IGlu
ZGV4IDgzNDExMzIyYmQ5Mi4uYTA1ZTIyNzhiNDQ4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9i
b290L2R0cy9zdGloNDE4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxOC5k
dHNpDQo+IEBAIC01MCw3ICs1MCw3IEBADQo+ICAJCW9oY2kwOiB1c2JAOWEwM2MwMCB7DQo+ICAJ
CQljb21wYXRpYmxlID0gInN0LHN0LW9oY2ktMzAweCI7DQo+ICAJCQlyZWcgPSA8MHg5YTAzYzAw
IDB4MTAwPjsNCj4gLQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxODAgSVJRX1RZUEVfTk9ORT47
DQo+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTgwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0K
PiAgCQkJY2xvY2tzID0gPCZjbGtfc19jMF9mbGV4Z2VuIENMS19UWF9JQ05fRElTUF8wPjsNCj4g
IAkJCXJlc2V0cyA9IDwmcG93ZXJkb3duIFNUSUg0MDdfVVNCMl9QT1JUMF9QT1dFUkRPV04+LA0K
PiAgCQkJCSA8JnNvZnRyZXNldCBTVElINDA3X1VTQjJfUE9SVDBfU09GVFJFU0VUPjsNCj4gQEAg
LTYyLDcgKzYyLDcgQEANCj4gIAkJZWhjaTA6IHVzYkA5YTAzZTAwIHsNCj4gIAkJCWNvbXBhdGli
bGUgPSAic3Qsc3QtZWhjaS0zMDB4IjsNCj4gIAkJCXJlZyA9IDwweDlhMDNlMDAgMHgxMDA+Ow0K
PiAtCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE1MSBJUlFfVFlQRV9OT05FPjsNCj4gKwkJCWlu
dGVycnVwdHMgPSA8R0lDX1NQSSAxNTEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICAJCQlwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCQkJcGluY3RybC0wID0gPCZwaW5jdHJsX3VzYjA+
Ow0KPiAgCQkJY2xvY2tzID0gPCZjbGtfc19jMF9mbGV4Z2VuIENMS19UWF9JQ05fRElTUF8wPjsN
Cj4gQEAgLTc2LDcgKzc2LDcgQEANCj4gIAkJb2hjaTE6IHVzYkA5YTgzYzAwIHsNCj4gIAkJCWNv
bXBhdGlibGUgPSAic3Qsc3Qtb2hjaS0zMDB4IjsNCj4gIAkJCXJlZyA9IDwweDlhODNjMDAgMHgx
MDA+Ow0KPiAtCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE4MSBJUlFfVFlQRV9OT05FPjsNCj4g
KwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxODEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICAJ
CQljbG9ja3MgPSA8JmNsa19zX2MwX2ZsZXhnZW4gQ0xLX1RYX0lDTl9ESVNQXzA+Ow0KPiAgCQkJ
cmVzZXRzID0gPCZwb3dlcmRvd24gU1RJSDQwN19VU0IyX1BPUlQxX1BPV0VSRE9XTj4sDQo+ICAJ
CQkJIDwmc29mdHJlc2V0IFNUSUg0MDdfVVNCMl9QT1JUMV9TT0ZUUkVTRVQ+Ow0KPiBAQCAtODgs
NyArODgsNyBAQA0KPiAgCQllaGNpMTogdXNiQDlhODNlMDAgew0KPiAgCQkJY29tcGF0aWJsZSA9
ICJzdCxzdC1laGNpLTMwMHgiOw0KPiAgCQkJcmVnID0gPDB4OWE4M2UwMCAweDEwMD47DQo+IC0J
CQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTUzIElSUV9UWVBFX05PTkU+Ow0KPiArCQkJaW50ZXJy
dXB0cyA9IDxHSUNfU1BJIDE1MyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gIAkJCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAJCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfdXNiMT47DQo+
ICAJCQljbG9ja3MgPSA8JmNsa19zX2MwX2ZsZXhnZW4gQ0xLX1RYX0lDTl9ESVNQXzA+Ow0KDQpB
cHBsaWVkIG9uIHN0aS1kdC1mb3ItdjUuOC1yb3VuZDENCg0KVGhhbmtzDQoNClBhdHJpY2UNCg==
