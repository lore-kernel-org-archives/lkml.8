Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EC3C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51ED2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b4adefcy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SfpNXZK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDWKgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:36:20 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48066 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgDWKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:36:19 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E4FE5C0089;
        Thu, 23 Apr 2020 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587638178; bh=dfa9KE7rEKtsCnAHPW2sHuoQejq5TEMKtN6lcuWXONM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=b4adefcyB2iGqpxisdWW6x9BKHxKbWVhjLyjmk0avdna5vLmLREFZwIxcW5thwhJr
         iCdghZV+lcGfr604GhEutrHXg5Y0+bgCj3NgQS3Z2uDf2zZf5jtr8VjrsgJ3+saGdt
         bPnJZuMkoZcWAghKH6ELFjAMhj8x8rdWKVVHr/FTdDE/r87Jd2NwMH6ZJ8I8gdLfxZ
         PqFEeI3F0DkRb9JJzSDRE0oVDettbWaYgWLMqcFmVWOJXUHSlumbhE0gU7Wg9rd16l
         uLgYXXx/UCzefMA9qWPQ/9jzagUETXOD3EZO0yX6F84hV7uo3nzqN/3vXEPOVJdMQv
         6btWOHWnxwdAg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 28E12A0091;
        Thu, 23 Apr 2020 10:36:17 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 23 Apr 2020 03:35:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Thu, 23 Apr 2020 03:35:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjfZ3NQ+CtdYmMNVXnNJbHMBSK9kHT1w8TXWcZX2UbkbYceY6n2o/R7SVZUpU5+lHMSXJ6Rn94tFu1LuzeyzPqFvI30pOQiEsAQMcrmm1W6MjsYwIJiuuRoc+cNUdUxUxAZ4mZ0RTbn7f9zG4GlUzpP8mb5SOOlchU1my0/jkMMMHJfY8hDjsR6/wnnqToa+MIlwl2aUMWt94duBuwCI/I1FEvAksQjwa5PCwA4ENdml0t1yj9trnJHE0bo3yZQuVKWRlzL6pdMf14XywxJFTTyrDGY57uGLqH2bM8TeCIh8dkKrWISLAPn7Ow0VQe70WtUQ44o2ZssSlir/ItNzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfa9KE7rEKtsCnAHPW2sHuoQejq5TEMKtN6lcuWXONM=;
 b=T/elyBRkig51PQiWPWGWp8mLtoNAMqct61/5WO7U9GNKoODWLv732sSRzw52md18Ul7sRJikkpoIYjjN5HCqdvcRbk1VuGBl92x+tAnJkqI5mRqGzrAvtps42IB5MyC6JxhdTFgfzO0oLh53UIfHll6ropqkU7SK9dwGL0ZX/+5YYhnQySxuYhZxbGNV0HM/tLLbN9/14khEZ+1oUHtpam6d2ulEaWTiArHSA4h5ImVP/C5YpsRyCVlM0uxYQ8dCeo9cIP9zYAVWZHIB9RuW/fu1LT9ecHD9bYKnpppm1P7mwzwv4haXWnJ237i9/V+v/Dac8MhperbaGTvo2jHlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfa9KE7rEKtsCnAHPW2sHuoQejq5TEMKtN6lcuWXONM=;
 b=SfpNXZK/LsUFYhCjtHsAIilgJVKr9YuDkfIYmLK0JKlyE0N5+3v1p4FFDFutlDWbAgXER0ZJL1GxQXqBShpAy70/4GedL069py3msjW6Qls751Hay4B1z2xq9D1opVenWE2/WBiuItqbX+FSr9axzW1s7/0wVLJZzP2doYvVIgg=
Received: from SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 23 Apr
 2020 10:35:42 +0000
Received: from SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d]) by SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d%7]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 10:35:42 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "amelie.delaunay@st.com" <amelie.delaunay@st.com>
Subject: Re: [PATCH 1/4] usb: dwc2: gadget: move gadget resume after the core
 is in L0 state
Thread-Topic: [PATCH 1/4] usb: dwc2: gadget: move gadget resume after the core
 is in L0 state
Thread-Index: AQHWF9kltb5ivodInUCMhTw1JrJADqiFOpOAgAATFACAAAV1AIABIAeAgAATCYA=
Date:   Thu, 23 Apr 2020 10:35:42 +0000
Message-ID: <0cd4f5f9-f729-f638-098a-285bbd5f8542@synopsys.com>
References: <1587472341-17935-1-git-send-email-fabrice.gasnier@st.com>
 <1587472341-17935-2-git-send-email-fabrice.gasnier@st.com>
 <5391768a-da52-def8-9b2a-aeb559d8e26b@synopsys.com>
 <ba525953-fbab-c2cf-beba-8755846cd27e@st.com>
 <13a35aac-a3c9-df9f-a2b7-64abdbf9463c@synopsys.com>
 <d1a2ce55-450b-47ea-15f9-a8532000a647@st.com>
In-Reply-To: <d1a2ce55-450b-47ea-15f9-a8532000a647@st.com>
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
x-ms-office365-filtering-correlation-id: 3b5d175a-a6f6-456a-b273-08d7e77212c9
x-ms-traffictypediagnostic: SN1PR12MB2509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2509CF9A33A853737880DFA0A7D30@SN1PR12MB2509.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(366004)(396003)(346002)(39860400002)(376002)(53546011)(4326008)(81156014)(6506007)(26005)(8676002)(86362001)(31696002)(6512007)(8936002)(54906003)(110136005)(316002)(71200400001)(76116006)(186003)(91956017)(2906002)(31686004)(2616005)(66476007)(66946007)(64756008)(66446008)(66556008)(478600001)(6486002)(5660300002)(36756003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMjhaMdJUVU4c6ojXxgECS6gia22b+WTuHs6ImHS/w0A1KfWxpqN+1ghQoNeT4rGep3K3kfvyAIG1iyhAmp8tznnoKn/Sf8GUHkuoje+x2yWiopVbDlbY3Q2NU0puw2lsVW3+Pt5y0jdxr2O8aB1oUilOBT+byF3R6cHDb7+5vVIxbfMsnk05OH1O4x651DLKE1UvT+LcrfZFhRN+wuk/22UVkEJMGl9wmUdG09mp+l9VM8ot7sKyCNMf+w3FWj28SSetiKjRqyNshjLaR+0zID/6Hvsxq5W2sbpkrdLhxDYcsGoGjYhnrFRbrpM1cjhkLVgSqgFqZ5Y6UsW9b9JQFsw5vKFWjogw8h1h4rlBE0HZDM3BFPenTsXlumKrOGCd5yM8hH4B6TuO5FJKdpQEFTiVXgOMnaBqvEOappzDb4BofRqWNJCSWPRN2gsJ7DY
x-ms-exchange-antispam-messagedata: KhuWRwYhQU06ewOeeDHATI3fN51re/IzAcv0lUMLzhMqoFVZ511XfNKM3e7NCI/rnDHO54gjRLe73oAz2KqRhKou67lEDwTv0cNgDoAi/Q/6uqosX2C9FQWPn7929/gERjdjviYqL8AimTbn0tp6Qg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C32F802B2BEEFA49A21FAEC4D17C48CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5d175a-a6f6-456a-b273-08d7e77212c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:35:42.2311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uB9PVbAicc4m+f8O8R5W5LjaNpdru+/bzsTh5QibLdE7R7dKdR9Tl1ekPSX/atFOuSOVigEn50XwCnhZPTmGiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFicmljZSwNCg0KT24gNC8yMy8yMDIwIDE6MjcgUE0sIEZhYnJpY2UgR2FzbmllciB3cm90
ZToNCj4gT24gNC8yMi8yMCA2OjE2IFBNLCBNaW5hcyBIYXJ1dHl1bnlhbiB3cm90ZToNCj4+IEhp
IEZhYnJpY2UsDQo+Pg0KPj4gT24gNC8yMi8yMDIwIDc6NTcgUE0sIEZhYnJpY2UgR2FzbmllciB3
cm90ZToNCj4+PiBPbiA0LzIyLzIwIDQ6NDggUE0sIE1pbmFzIEhhcnV0eXVueWFuIHdyb3RlOg0K
Pj4+PiBIaSBGYWJyaWNlLA0KPj4+Pg0KPj4+PiBPbiA0LzIxLzIwMjAgNDozMiBQTSwgRmFicmlj
ZSBHYXNuaWVyIHdyb3RlOg0KPj4+Pj4gV2hlbiB0aGUgcmVtb3RlIHdha2V1cCBpbnRlcnJ1cHQg
aXMgdHJpZ2dlcmVkLCBseF9zdGF0ZSBpcyByZXN1bWVkIGZyb20gTDINCj4+Pj4+IHRvIEwwIHN0
YXRlLiBCdXQgd2hlbiB0aGUgZ2FkZ2V0IHJlc3VtZSBpcyBjYWxsZWQsIGx4X3N0YXRlIGlzIHN0
aWxsIEwyLg0KPj4+Pj4gVGhpcyBwcmV2ZW50cyB0aGUgcmVzdW1lIGNhbGxiYWNrIHRvIHF1ZXVl
IGFueSByZXF1ZXN0LiBBbnkgYXR0ZW1wdA0KPj4+Pj4gdG8gcXVldWUgYSByZXF1ZXN0IGZyb20g
cmVzdW1lIGNhbGxiYWNrIHdpbGwgcmVzdWx0IGluOg0KPj4+Pj4gLSAic3VibWl0IHJlcXVlc3Qg
b25seSBpbiBhY3RpdmUgc3RhdGUiIGRlYnVnIG1lc3NhZ2UgdG8gYmUgaXNzdWVkDQo+Pj4+PiAt
IGR3YzJfaHNvdGdfZXBfcXVldWUoKSByZXR1cm5zIC1FQUdBSU4NCj4+Pj4+DQo+Pj4+PiBNb3Zl
IHRoZSBjYWxsIHRvIHJlc3VtZSBnYWRnZXQgYWZ0ZXIgdGhlIGNvcmUgaXMgcHV0IGluIERXQzJf
TDAgc3RhdGUuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRmFicmljZSBHYXNuaWVyIDxm
YWJyaWNlLmdhc25pZXJAc3QuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgICAgZHJpdmVycy91c2Iv
ZHdjMi9jb3JlX2ludHIuYyB8IDEwICsrKysrKystLS0NCj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jIGIvZHJpdmVycy91c2IvZHdjMi9jb3Jl
X2ludHIuYw0KPj4+Pj4gaW5kZXggODc2ZmYzMS4uYjhlYmRhNSAxMDA2NDQNCj4+Pj4+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzIvY29yZV9pbnRyLmMNCj4+Pj4+IEBAIC00MDQsOSArNDA0LDExIEBAIHN0YXRpYyB2b2lkIGR3
YzJfaGFuZGxlX3dha2V1cF9kZXRlY3RlZF9pbnRyKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykN
Cj4+Pj4+ICAgICAJfQ0KPj4+Pj4gICAgIA0KPj4+Pj4gICAgIAlpZiAoZHdjMl9pc19kZXZpY2Vf
bW9kZShoc290ZykpIHsNCj4+Pj4+ICsJCWVudW0gZHdjMl9seF9zdGF0ZSBseF9zdGF0ZSA9IGhz
b3RnLT5seF9zdGF0ZTsNCj4+Pj4+ICsNCj4+Pj4+ICAgICAJCWRldl9kYmcoaHNvdGctPmRldiwg
IkRTVFM9MHglMHhcbiIsDQo+Pj4+PiAgICAgCQkJZHdjMl9yZWFkbChoc290ZywgRFNUUykpOw0K
Pj4+Pj4gLQkJaWYgKGhzb3RnLT5seF9zdGF0ZSA9PSBEV0MyX0wyKSB7DQo+Pj4+PiArCQlpZiAo
bHhfc3RhdGUgPT0gRFdDMl9MMikgew0KPj4+Pj4gICAgIAkJCXUzMiBkY3RsID0gZHdjMl9yZWFk
bChoc290ZywgRENUTCk7DQo+Pj4+PiAgICAgDQo+Pj4+PiAgICAgCQkJLyogQ2xlYXIgUmVtb3Rl
IFdha2V1cCBTaWduYWxpbmcgKi8NCj4+Pj4+IEBAIC00MTUsMTEgKzQxNywxMyBAQCBzdGF0aWMg
dm9pZCBkd2MyX2hhbmRsZV93YWtldXBfZGV0ZWN0ZWRfaW50cihzdHJ1Y3QgZHdjMl9oc290ZyAq
aHNvdGcpDQo+Pj4+PiAgICAgCQkJcmV0ID0gZHdjMl9leGl0X3BhcnRpYWxfcG93ZXJfZG93biho
c290ZywgdHJ1ZSk7DQo+Pj4+PiAgICAgCQkJaWYgKHJldCAmJiAocmV0ICE9IC1FTk9UU1VQUCkp
DQo+Pj4+PiAgICAgCQkJCWRldl9lcnIoaHNvdGctPmRldiwgImV4aXQgcG93ZXJfZG93biBmYWls
ZWRcbiIpOw0KPj4+Pj4gLQ0KPj4+Pj4gLQkJCWNhbGxfZ2FkZ2V0KGhzb3RnLCByZXN1bWUpOw0K
Pj4+Pj4gICAgIAkJfQ0KPj4+Pj4gICAgIAkJLyogQ2hhbmdlIHRvIEwwIHN0YXRlICovDQo+Pj4+
PiAgICAgCQloc290Zy0+bHhfc3RhdGUgPSBEV0MyX0wwOw0KPj4+Pj4gKw0KPj4+Pj4gKwkJLyog
R2FkZ2V0IG1heSBxdWV1ZSBuZXcgcmVxdWVzdHMgdXBvbiByZXN1bWUgdG8gTDAgc3RhdGUgKi8N
Cj4+Pj4+ICsJCWlmIChseF9zdGF0ZSA9PSBEV0MyX0wyKQ0KPj4+Pj4gKwkJCWNhbGxfZ2FkZ2V0
KGhzb3RnLCByZXN1bWUpOw0KPj4+Pj4gICAgIAl9IGVsc2Ugew0KPj4+Pj4gICAgIAkJaWYgKGhz
b3RnLT5wYXJhbXMucG93ZXJfZG93bikNCj4+Pj4+ICAgICAJCQlyZXR1cm47DQo+Pj4+Pg0KPj4+
Pg0KPj4+PiBXaGF0IGFib3V0IGJlbG93IHBhdGNoIHdpdGhvdXQgaW50cm9kdWNpbmcgYWRkaXRp
b25hbCB2YXJpYWJsZS4NCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIv
Y29yZV9pbnRyLmMgYi9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jDQo+Pj4+IGluZGV4IDg3
NmZmMzEyNjFkNS4uNTQzODY1ZTMxYzcyIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9k
d2MyL2NvcmVfaW50ci5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMN
Cj4+Pj4gQEAgLTQxNiw2ICs0MTYsOCBAQCBzdGF0aWMgdm9pZCBkd2MyX2hhbmRsZV93YWtldXBf
ZGV0ZWN0ZWRfaW50cihzdHJ1Y3QNCj4+Pj4gZHdjMl9oc290ZyAqaHNvdGcpDQo+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgJiYgKHJldCAhPSAtRU5PVFNVUFApKQ0KPj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoaHNvdGctPmRldiwg
ImV4aXQgcG93ZXJfZG93bg0KPj4+PiBmYWlsZWRcbiIpOw0KPj4+Pg0KPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAvKiBDaGFuZ2UgdG8gTDAgc3RhdGUgKi8NCj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgaHNvdGctPmx4X3N0YXRlID0gRFdDMl9MMDsNCj4+Pg0KPj4+IEhpIE1pbmFz
LA0KPj4+DQo+Pj4gVGhhdCB3YXMgbXkgZmlyc3QgYXBwcm9hY2ggbG9jYWxseSwgYnV0IEkgYWRk
ZWQgYSB2YXJpYWJsZSB0byBhdm9pZCBkbw0KPj4+IGl0IHR3aWNlLi4uIGZldyBsaW5lcyBhZnRl
ci4NCj4+Pg0KPj4+IEJ1dCBpZiB5b3UgcHJlZmVyLCBJIGNhbiBjaGFuZ2UgaW4gVjIgPw0KPj4+
DQo+Pj4gUGxlYXNlIGxldCBtZSBrbm93Lg0KPj4+DQo+Pj4gVGhhbmtzLA0KPj4+IEZhYnJpY2UN
Cj4+Pg0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjYWxsX2dhZGdldChoc290Zywg
cmVzdW1lKTsNCj4+Pj4gICAgICAgICAgICAgICAgICAgIH0NCj4+Pj4gICAgICAgICAgICAgICAg
ICAgIC8qIENoYW5nZSB0byBMMCBzdGF0ZSAqLw0KPj4+Pg0KPj4+Pg0KPj4+PiBUaGFua3MsDQo+
Pj4+IE1pbmFzDQo+Pj4+DQo+PiBUbyBhdm9pZCB0d2ljZSBzZXR0aW5nIGx4X3N0YXRlIHlvdSBj
YW4gYWRkICdlbHNlJyBiZWZvcmUgc2Vjb25kIHNldHRpbmcuDQo+IA0KPiBIaSBNaW5hcywNCj4g
DQo+IFRoYW5rcyBmb3IgeW91ciBxdWljayBhbnN3ZXIuIFN1cmUsIEknbGwgdXBkYXRlIGl0IGlu
IHYyLg0KPiANCj4gQWxzbywgZG8geW91IHRoaW5rIHRoaXMgY2FuL3Nob3VsZCBiZSBtYXJrZWQg
YXMgYSBmaXggPw0KPiAtIGUuZy4gYWRkIGEgRml4ZXMgdGFnPw0KPiANCj4gRml4ZXM6IGY4MWY0
NmUxZjUzMCAoInVzYjogZHdjMjogaW1wbGVtZW50IGhpYmVybmF0aW9uIGR1cmluZyBidXMNCj4g
c3VzcGVuZC9yZXN1bWUiKQ0KPiANCg0KWWVzLCBnbyBhaGVhZCB0byBzdWJtaXQgVjIgd2l0aCBt
ZW50aW9uZWQgIkZpeGVzOiIgdGFnLg0KDQpUaGFua3MsDQpNaW5hcw0KDQoNCj4gUGxlYXNlIGFk
dmlzZSwNCj4gQmVzdCBSZWdhcmRzLA0KPiBGYWJyaWNlDQo+IA0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jIGIvZHJpdmVycy91c2IvZHdjMi9jb3JlX2lu
dHIuYw0KPj4gaW5kZXggODc2ZmYzMTI2MWQ1Li5mNTlkYWJkNDZlNjAgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9kd2My
L2NvcmVfaW50ci5jDQo+PiBAQCAtNDE2LDEwICs0MTYsMTQgQEAgc3RhdGljIHZvaWQNCj4+IGR3
YzJfaGFuZGxlX3dha2V1cF9kZXRlY3RlZF9pbnRyKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCAmJiAocmV0ICE9IC1FTk9UU1VQ
UCkpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycihoc290Zy0+
ZGV2LCAiZXhpdCBwb3dlcl9kb3duDQo+PiBmYWlsZWRcbiIpOw0KPj4NCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIC8qIENoYW5nZSB0byBMMCBzdGF0ZSAqLw0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaHNvdGctPmx4X3N0YXRlID0gRFdDMl9MMDsNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY2FsbF9nYWRnZXQoaHNvdGcsIHJlc3VtZSk7DQo+PiAgICAgICAgICAgICAgICAg
ICB9DQo+PiAtICAgICAgICAgICAgICAgLyogQ2hhbmdlIHRvIEwwIHN0YXRlICovDQo+PiAtICAg
ICAgICAgICAgICAgaHNvdGctPmx4X3N0YXRlID0gRFdDMl9MMDsNCj4+ICsgICAgICAgICAgICAg
ICBlbHNlIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIC8qIENoYW5nZSB0byBMMCBzdGF0
ZSAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaHNvdGctPmx4X3N0YXRlID0gRFdDMl9M
MDsNCj4+ICsgICAgICAgICAgICAgICB9DQo+PiAgICAgICAgICAgfSBlbHNlIHsNCj4+ICAgICAg
ICAgICAgICAgICAgIGlmIChoc290Zy0+cGFyYW1zLnBvd2VyX2Rvd24pDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybjsNCj4+DQo+Pg0KPj4NCj4+IEFtIEkgbWlzc2VkIHNvbWV0
aGluZz8NCj4+DQo+PiBUaGFua3MsDQo+PiBNaW5hcw0KPj4NCg==
