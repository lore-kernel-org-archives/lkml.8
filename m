Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A2EC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B18221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="yQmwd6sJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgDQKsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:48:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10936 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729301AbgDQKsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:48:24 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HAlHR7012849;
        Fri, 17 Apr 2020 12:48:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=U0KuCPkod9VCkNMm1+gsvxdMKO+LfeTwPrz1C/kNOFc=;
 b=yQmwd6sJjj16ZGoExmKg/oSc8qcfK/u1FNR7zv8HrwIk5xvBganoJwS1yPVn2AZNl9fk
 ohcMf1latO8UPTIz6for3kJZPwW4VHrBz3q5W2VainDHFA1gIFRbj2g4078N29XnCrtE
 ki17XRsrdO4Z9qwMh8oAEhZfPD7KUaCN05a9G9H0YBDI5aTMaUJs7+j0Gl2PxiS9cuIb
 vPf+z0iJBEmyiMeeSyjEw+hcVn9X7RV0GZ1Vjeodc7nNdCav0ddp/+qojhD+mhKbv6lz
 nntJ/L8PZxoZ1y7RJUjFVUrtNG7mPDhXObxDbqYxdMpg9WHHx1qbNpqipdWLg8KrbWKQ yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn6t8ykj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 12:48:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D682B10002A;
        Fri, 17 Apr 2020 12:48:09 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C79422AA21F;
        Fri, 17 Apr 2020 12:48:09 +0200 (CEST)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 12:48:09 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 17 Apr 2020 12:48:09 +0200
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
Thread-Index: AQHWAGU6HT4ybsc2/E+ksa70VtGSzKh9KQyA
Date:   Fri, 17 Apr 2020 10:48:09 +0000
Message-ID: <d9073372-e51a-518c-09ea-37aebb225406@st.com>
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
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B947ACF6CAAE14987E5EDB57737EB04@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_03:2020-04-17,2020-04-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhaW4NCg0KT24gMy8yMi8yMCA1OjE2IFBNLCBBbGFpbiBWb2xtYXQgd3JvdGU6DQo+IHRo
ZSAyIHJuZyBub2RlcyBhcmUgZHVwbGljYXRlZCB3aXRoaW4gdGhlIHN0aWg0MDctZmFtaWx5LmR0
c2kNCj4NCj4gU2lnbmVkLW9mZi1ieTogQWxhaW4gVm9sbWF0IDxhdm9sbWF0QG1lLmNvbT4NCj4g
LS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9zdGloNDA3LWZhbWlseS5kdHNpIHwgMTQgLS0tLS0t
LS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctZmFtaWx5LmR0c2kgYi9hcmNoL2FybS9i
b290L2R0cy9zdGloNDA3LWZhbWlseS5kdHNpDQo+IGluZGV4IDdjMzZjMzcyNjBhNC4uMjNhMTc0
NmYzYmFhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDA3LWZhbWlseS5k
dHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctZmFtaWx5LmR0c2kNCj4gQEAg
LTc2NywyMCArNzY3LDYgQEANCj4gIAkJCQkgPCZjbGtfc19jMF9mbGV4Z2VuIENMS19FVEhfUEhZ
PjsNCj4gIAkJfTsNCj4gIA0KPiAtCQlybmcxMDogcm5nQDhhODkwMDAgew0KPiAtCQkJY29tcGF0
aWJsZSAgICAgID0gInN0LHJuZyI7DQo+IC0JCQlyZWcJCT0gPDB4MDhhODkwMDAgMHgxMDAwPjsN
Cj4gLQkJCWNsb2NrcyAgICAgICAgICA9IDwmY2xrX3N5c2luPjsNCj4gLQkJCXN0YXR1cwkJPSAi
b2theSI7DQo+IC0JCX07DQo+IC0NCj4gLQkJcm5nMTE6IHJuZ0A4YThhMDAwIHsNCj4gLQkJCWNv
bXBhdGlibGUgICAgICA9ICJzdCxybmciOw0KPiAtCQkJcmVnCQk9IDwweDA4YThhMDAwIDB4MTAw
MD47DQo+IC0JCQljbG9ja3MgICAgICAgICAgPSA8JmNsa19zeXNpbj47DQo+IC0JCQlzdGF0dXMJ
CT0gIm9rYXkiOw0KPiAtCQl9Ow0KPiAtDQo+ICAJCW1haWxib3gwOiBtYWlsYm94QDhmMDAwMDAg
IHsNCj4gIAkJCWNvbXBhdGlibGUJPSAic3Qsc3RpaDQwNy1tYWlsYm94IjsNCj4gIAkJCXJlZwkJ
PSA8MHg4ZjAwMDAwIDB4MTAwMD47DQoNCkFwcGxpZWQgb24gc3RpLWR0LWZvci12NS44LXJvdW5k
MQ0KDQpUaGFua3MNCg0KUGF0cmljZQ0K
