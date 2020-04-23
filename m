Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E0DC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF99E2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VHUsVj3J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PS2TOO22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgDWNGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:06:49 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52938 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726685AbgDWNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:06:49 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 049B9C009B;
        Thu, 23 Apr 2020 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587647208; bh=YAKACk9peFjLASh1n+EbNmnqOngfTZeDVMnvYNCdLMQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VHUsVj3JhqwvS8dHkZO02dYPRoJLjinLH1ws0C+ccxcMx7XOLfrlSNK+izXgI3aa1
         o8uM4rFC97NxITvTcqn1hUHV6OtlmwsOHPQoAWFUYuzkJW4zps/4eWHwH5MfmY8aGD
         gf6bUKCZabvCxXOd4JCtBIj6JHtvleKLm3yDnJN3y1efqbFQ4ql8hmzaSXl7tx4XMS
         FtBrdh0OB+h7v1Zf9kQkwXCYe9jvO6bSTmEN0QaDga1AMBGHIY4lMA4HZuQtE73ZgR
         QIX6/obE7sS52yRkSCAOgwnzMbyTcEb8TKiUDHGxKMUw4SewFSJyEC4Bah0dTc/zAG
         zigNrop+huBmQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 82AC0A00CA;
        Thu, 23 Apr 2020 13:06:47 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 23 Apr 2020 06:06:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Thu, 23 Apr 2020 06:06:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzK7IeR9I4RuwgPDAktSG20ndc7slgiwfLDVzUDEBhC8OhZR2P62f9AsFlow09jQfszaSPN/pjZrQKTbSlP3LrN6IUBJqT4vZFFr9BruMLd6sP/6itBlP3B14iXxS7510Fwrr8XN9upFmTj3otYW6zeAFQy1DU9y1HMaxo31fiNx7wSwdKmFauRCwSu+wrZwKu359TlCI05TxmkQZR6NL4CoCLCscmKf6J6jYq+f4Ylwcfx2oXxaC8BiiOW0h53QamqlTyBlSv3NXo/2RR4sIXkKtPNIVdl6UFEoCG//EQsKb98KUaImtt/ZomGTmLX8RPDfumYmv6VdqNEBS0+MEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAKACk9peFjLASh1n+EbNmnqOngfTZeDVMnvYNCdLMQ=;
 b=AaWnlkDIQQryySMBOzfIUa5xmLHGXaeQlyEzSEsYjCg07M0Ej6e22lsuHCeu7jK1KlRSmpsqRXkkqhoeygwcLRH5i4bkEpnpBwizzZ4boDu5Lbirohp9f9RylMLyIHknjBBuUmmZBTottsFBeIShwXq+WDL0c9n4NrK9DrRsaJazNds7hMJsze2F+WOKjUCrNNFD++A8yhXGpALALJUeoxuUgQsgUBeZuVn26B1xBU1+rSY4FKVEw0mg7hN0jaxTxmBjCvFnYmsnfO/h07RgNJCs/Bag9tgAvCBIeVlpC4rjAyFy09FQMWQD62+/iP6kdP5cOSsvkoPWQuvyuYa7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAKACk9peFjLASh1n+EbNmnqOngfTZeDVMnvYNCdLMQ=;
 b=PS2TOO2222BWnL+vfLjmkhKkpXXLGfstot7tnmzWcr2+QGEK0buqvgI9FwuVmpOl2M8eIhKlV/VropQUtg9MxxBCH8lvDW0u8f1Ztljz5brWFy6UNLBro4boDao+QPrNIU/6PVEJhxEpH/imXrSXAnt1NQxIaL5LApH58pZE/6M=
Received: from SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 13:06:22 +0000
Received: from SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d]) by SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d%7]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 13:06:22 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "amelie.delaunay@st.com" <amelie.delaunay@st.com>
Subject: Re: [PATCH v2 1/4] usb: dwc2: gadget: move gadget resume after the
 core is in L0 state
Thread-Topic: [PATCH v2 1/4] usb: dwc2: gadget: move gadget resume after the
 core is in L0 state
Thread-Index: AQHWGWZMfx42yC6umE2yal3pGaWhlqiGrSqA
Date:   Thu, 23 Apr 2020 13:06:21 +0000
Message-ID: <d8ed6262-110b-b77c-40d2-2e9408986c36@synopsys.com>
References: <1587642956-8157-1-git-send-email-fabrice.gasnier@st.com>
 <1587642956-8157-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1587642956-8157-2-git-send-email-fabrice.gasnier@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eb1dbf2-0edc-471a-7d0d-08d7e7871edc
x-ms-traffictypediagnostic: SN1PR12MB2366:
x-microsoft-antispam-prvs: <SN1PR12MB23666B40A60426C8D8F58296A7D30@SN1PR12MB2366.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(396003)(376002)(136003)(39860400002)(66446008)(186003)(4326008)(8936002)(76116006)(86362001)(66476007)(64756008)(26005)(66556008)(478600001)(36756003)(71200400001)(66946007)(91956017)(31696002)(6506007)(2906002)(5660300002)(53546011)(6486002)(6512007)(31686004)(316002)(81156014)(2616005)(54906003)(110136005)(8676002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jf3uFU8JRN1QFliddLN9b1EmfwkLsQnZGchB/fCpoA5L6HbYHycdXv7PiexoiFaDi6UEubFF/JxXjTKjRHPU6c93+9eV9bDgLtYAPZUyea/X6AHCVdOvR0ZIDHdHPyMGd+DgtSBUFXIUQ1CnuZc8Gj4+Pmo/VZFPfj8XTXcpLR9AKCUmAzlmL0Bfjbnr/pRWtdifa0R4ah99grien08iXGFKqfKXG0ZDBsA0Amv6+uTagfpuH4SilwQzdL/CtpBXGxPpatbATFOhgvhXMPYhSh+ZFwSid2Z030xhto7uKqVjxnHDUfTFeWrLUylAqQ2Hsl7BzLpNV3KhrWSTi3LbfTelKWThLu9GCJrW1TDixOlcYllVtBhg0fsLvBzxgVVuuJf4YECWWT09LqrA3mN3bGWPcj3YWPHjdSy0GpdTNodnYt5ElTKZajLAW42tH/UQ
x-ms-exchange-antispam-messagedata: VrmnCzX3ZaEF8aCMicfmS0p8jJtkUB/e7gg43cWwrfKxmyK2KZGopxpexDM2NkMugOZMEtwqAATzSZQPj6+IP+3iH7pDsOEkXd/9NtxOtMBeG+wob5bIhdMJPhTr3cPeuul9HdHjCnQvdf6yK+kuMg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD12BA6B9EABD049881F5A1DF3308AE0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb1dbf2-0edc-471a-7d0d-08d7e7871edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 13:06:21.9003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+0qzSJICd3iYtX0/AVTkXjv4/OkKDFmwz9Nf7L7tOcSWVQxOSTJukvnFRrKa8/Fqp3PwKfj/W8SoezHe8YHYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjMvMjAyMCAzOjU1IFBNLCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6DQo+IFdoZW4g
dGhlIHJlbW90ZSB3YWtldXAgaW50ZXJydXB0IGlzIHRyaWdnZXJlZCwgbHhfc3RhdGUgaXMgcmVz
dW1lZCBmcm9tIEwyDQo+IHRvIEwwIHN0YXRlLiBCdXQgd2hlbiB0aGUgZ2FkZ2V0IHJlc3VtZSBp
cyBjYWxsZWQsIGx4X3N0YXRlIGlzIHN0aWxsIEwyLg0KPiBUaGlzIHByZXZlbnRzIHRoZSByZXN1
bWUgY2FsbGJhY2sgdG8gcXVldWUgYW55IHJlcXVlc3QuIEFueSBhdHRlbXB0DQo+IHRvIHF1ZXVl
IGEgcmVxdWVzdCBmcm9tIHJlc3VtZSBjYWxsYmFjayB3aWxsIHJlc3VsdCBpbjoNCj4gLSAic3Vi
bWl0IHJlcXVlc3Qgb25seSBpbiBhY3RpdmUgc3RhdGUiIGRlYnVnIG1lc3NhZ2UgdG8gYmUgaXNz
dWVkDQo+IC0gZHdjMl9oc290Z19lcF9xdWV1ZSgpIHJldHVybnMgLUVBR0FJTg0KPiANCj4gQ2Fs
bCB0aGUgZ2FkZ2V0IHJlc3VtZSByb3V0aW5lIGFmdGVyIHRoZSBjb3JlIGlzIGluIEwwIHN0YXRl
Lg0KPiANCj4gRml4ZXM6IGY4MWY0NmUxZjUzMCAoInVzYjogZHdjMjogaW1wbGVtZW50IGhpYmVy
bmF0aW9uIGR1cmluZyBidXMgc3VzcGVuZC9yZXN1bWUiKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTog
RmFicmljZSBHYXNuaWVyIDxmYWJyaWNlLmdhc25pZXJAc3QuY29tPg0KQWNrZWQtYnk6IE1pbmFz
IEhhcnV0eXVueWFuIDxobWluYXNAc3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIE1pbm9yIHVwZGF0ZSB0byBmb2xsb3cgTWluYXMgc3VnZ2VzdGlvbnMNCj4gLS0t
DQo+ICAgZHJpdmVycy91c2IvZHdjMi9jb3JlX2ludHIuYyB8IDcgKysrKystLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMi9jb3JlX2ludHIuYyBiL2RyaXZlcnMvdXNiL2R3YzIvY29y
ZV9pbnRyLmMNCj4gaW5kZXggODc2ZmYzMS4uNTVmMWQxNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMi9jb3JlX2ludHIuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50
ci5jDQo+IEBAIC00MTYsMTAgKzQxNiwxMyBAQCBzdGF0aWMgdm9pZCBkd2MyX2hhbmRsZV93YWtl
dXBfZGV0ZWN0ZWRfaW50cihzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgCQkJaWYgKHJl
dCAmJiAocmV0ICE9IC1FTk9UU1VQUCkpDQo+ICAgCQkJCWRldl9lcnIoaHNvdGctPmRldiwgImV4
aXQgcG93ZXJfZG93biBmYWlsZWRcbiIpOw0KPiAgIA0KPiArCQkJLyogQ2hhbmdlIHRvIEwwIHN0
YXRlICovDQo+ICsJCQloc290Zy0+bHhfc3RhdGUgPSBEV0MyX0wwOw0KPiAgIAkJCWNhbGxfZ2Fk
Z2V0KGhzb3RnLCByZXN1bWUpOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJLyogQ2hhbmdlIHRvIEww
IHN0YXRlICovDQo+ICsJCQloc290Zy0+bHhfc3RhdGUgPSBEV0MyX0wwOw0KPiAgIAkJfQ0KPiAt
CQkvKiBDaGFuZ2UgdG8gTDAgc3RhdGUgKi8NCj4gLQkJaHNvdGctPmx4X3N0YXRlID0gRFdDMl9M
MDsNCj4gICAJfSBlbHNlIHsNCj4gICAJCWlmIChoc290Zy0+cGFyYW1zLnBvd2VyX2Rvd24pDQo+
ICAgCQkJcmV0dXJuOw0KPiANCg==
