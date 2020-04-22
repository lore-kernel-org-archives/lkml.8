Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24D1C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794792076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="evkl7pVH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TDJ0xKxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgDVQQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:16:45 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36496 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgDVQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:16:44 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 07103C00AD;
        Wed, 22 Apr 2020 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587572204; bh=+odkonGKh8I/uNQEv1xU5FnB0KjU1G7BDRAj8u//EW0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=evkl7pVHgJ9mlGVZytScDfkR5WBWESXcr0uW7IQEYRLOwQx9MTCICOf2o9M9CmV+6
         HBzXbKA/BnUx3qp8WpxS/4CbIF0UXIIQdP9E6VrsWCtyi1mBB8FCFPoDuFzzjvM6my
         +cEBOyb6WAhsPsvf7CIrsv6yuCPKo8rvgEWAw3tNv8Pyli1+b/QK3OBo5n/j4um661
         8+ZRLoxa3zKHGjmkd13L3r/XQ2lFsSfuScw5Oa2Rf8F5fTgSOhn6+5z7m+qi8KE9k2
         mqPhVRq8LDVlWBTr5T9GIXrhiCwMYxgLWJn7cjzvJGVysZT8H3SRki93uKfwpwnCba
         z3FTazkAqPCrA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DFED9A0069;
        Wed, 22 Apr 2020 16:16:42 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 22 Apr 2020 09:16:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 22 Apr 2020 09:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQAnMFAH41SMxykGd8/95fF3Ke/6vKqOmtcw0QmUjZkFBfBNMdft20bZc1SrqNW6udPqKHaE/WYf35YLH/QMhOM8vSLs4931jm58TonGPMdjDycOoUdZ9SjmWu9/xsTsF4pZSLWvevZQvWQMF8L4Bx+HSXpEBxtrc9touV262KI+LHK/8g3Dy/vZeN9ovNaQe7MyWL5tECykzYXVM1hP5xo/MRxJ8INxIXf08aZaxbZc++kWdytiLHX5pJp6jx3qYadPPCIMqxxKtIIqYcnHdo6hfHd/teFQyOhuWYRGoAXxSg3/qqJmyjUqU6hMwSJmBoJ4a2QRjZb2v8vnzQLUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+odkonGKh8I/uNQEv1xU5FnB0KjU1G7BDRAj8u//EW0=;
 b=l/CZhFVwK5sPfUVYO2+mvTEQMPmf0YA8PFlykpju/NVtO0Y0U2cpF0M4/+gd9O3Gq/7zIJpHfk0etu2vweFio7Q1B9H9S3iD5lGtAL1zDD8hO3oY1Ew/f9cAoFsUwBIvO0jmlFo/nirkXGU5Eo276IJFjAevFeMdVPZupDnOFtgfDUFKEW9m2n8aL5tF+7mcGm7hgVHAnNhfaPlxXhmNYxOuhAVQKGKF8oXKWajww6yvG3swzHJJSPVmi9s7AaUgmP/PlXyGRivtrLFRJKlv5aPU7WUoscL0JFqeO5lDwVU/yDka4LBNvr8C+Cd5CwxZGg3m6olDLob0kWsRSOME0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+odkonGKh8I/uNQEv1xU5FnB0KjU1G7BDRAj8u//EW0=;
 b=TDJ0xKxZv9s/rgtHanqpsD8GBn6TJU1fSN7UIwXPPnUSLE0g9Azua12lkCKIMGv7ANDJKf2zAjQeTSCfePgBRCABuQgy+RxZOuAE404sEl+dVgNapjo6QKYOE07uONq8x1ZaZvZf1jL6eF8Dqn4sBWrkagjRKRmEXp4LZqUhzOE=
Received: from SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 16:16:41 +0000
Received: from SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d]) by SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d%7]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 16:16:41 +0000
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
Thread-Index: AQHWF9kltb5ivodInUCMhTw1JrJADqiFOpOAgAATFACAAAV1AA==
Date:   Wed, 22 Apr 2020 16:16:40 +0000
Message-ID: <13a35aac-a3c9-df9f-a2b7-64abdbf9463c@synopsys.com>
References: <1587472341-17935-1-git-send-email-fabrice.gasnier@st.com>
 <1587472341-17935-2-git-send-email-fabrice.gasnier@st.com>
 <5391768a-da52-def8-9b2a-aeb559d8e26b@synopsys.com>
 <ba525953-fbab-c2cf-beba-8755846cd27e@st.com>
In-Reply-To: <ba525953-fbab-c2cf-beba-8755846cd27e@st.com>
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
x-ms-office365-filtering-correlation-id: 87b8c1f9-f86d-4b19-57bf-08d7e6d88aba
x-ms-traffictypediagnostic: SN1PR12MB2349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB23496CB6081B4DAF9D473A19A7D20@SN1PR12MB2349.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39860400002)(76116006)(5660300002)(6486002)(2616005)(91956017)(2906002)(66476007)(66556008)(6512007)(86362001)(66446008)(66946007)(4326008)(81156014)(31696002)(8936002)(64756008)(8676002)(110136005)(36756003)(478600001)(186003)(71200400001)(53546011)(316002)(31686004)(26005)(6506007)(54906003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CebWBRcl+Ozjs6fKFWCSBx43FOn9tngMSACq2nkQkQCZkEeek46klbuhQErBr57gK+7Ui/GszcE3PJ+kLMlKdiwlrLJHJhVE6UNjVzNBL/grI0mtVA29JaqONfYRAH6neGV7XcWib6Xwch9i+2N8HQrVCO3cC2nhpFuB+MUalV3emItEJddHRdoRsMKuY+PLExBWiITMYQOPx1e/LGo3gxVVZJ0K6cOthOb2b9k8BlyfKNKaNwHZ5sqPqdDRW2AAoAnvUqKEEiFctIn5rLRxYNqDnzP84UgM54ezV7M9PI4bGvOWB/Zj/c9VDsv94HapCF1CJ+Zkg8ANYIBpDED0AlUJQi6C/WPwGku3oB+YjhLaH89SsfvcQm3aDetncVcY3bWamxrUgBoU+aimY9czulzFsh8lngeL8mS/rMXWAxo+KXsuWWFF+2juSMktKefI
x-ms-exchange-antispam-messagedata: SDpZ/v4rci1l1JFQhzRIzlOgYYCom8LROMPOzhHqGd6YOf2eRdR5Vm3RmoO7Yc9naTuKEC5LR0WFJJthS+3zJ0QmdzaX64xMhvQAU2NMrTYK4jm1c4UWk69vNJDaqiBSkaUpmM/dl+UcWym4gNH/ug==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E2A93375C477A42BAD7FD3E53CAF114@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b8c1f9-f86d-4b19-57bf-08d7e6d88aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 16:16:40.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9p8ebPUtx3Vd66Rh6miGyh6q4R9vyGZsfnztsz3Nv5F9MWjpw5bU8Oz7oTAYB//ygOmmqwv1e8Ogl6iQ5+bbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFicmljZSwNCg0KT24gNC8yMi8yMDIwIDc6NTcgUE0sIEZhYnJpY2UgR2FzbmllciB3cm90
ZToNCj4gT24gNC8yMi8yMCA0OjQ4IFBNLCBNaW5hcyBIYXJ1dHl1bnlhbiB3cm90ZToNCj4+IEhp
IEZhYnJpY2UsDQo+Pg0KPj4gT24gNC8yMS8yMDIwIDQ6MzIgUE0sIEZhYnJpY2UgR2FzbmllciB3
cm90ZToNCj4+PiBXaGVuIHRoZSByZW1vdGUgd2FrZXVwIGludGVycnVwdCBpcyB0cmlnZ2VyZWQs
IGx4X3N0YXRlIGlzIHJlc3VtZWQgZnJvbSBMMg0KPj4+IHRvIEwwIHN0YXRlLiBCdXQgd2hlbiB0
aGUgZ2FkZ2V0IHJlc3VtZSBpcyBjYWxsZWQsIGx4X3N0YXRlIGlzIHN0aWxsIEwyLg0KPj4+IFRo
aXMgcHJldmVudHMgdGhlIHJlc3VtZSBjYWxsYmFjayB0byBxdWV1ZSBhbnkgcmVxdWVzdC4gQW55
IGF0dGVtcHQNCj4+PiB0byBxdWV1ZSBhIHJlcXVlc3QgZnJvbSByZXN1bWUgY2FsbGJhY2sgd2ls
bCByZXN1bHQgaW46DQo+Pj4gLSAic3VibWl0IHJlcXVlc3Qgb25seSBpbiBhY3RpdmUgc3RhdGUi
IGRlYnVnIG1lc3NhZ2UgdG8gYmUgaXNzdWVkDQo+Pj4gLSBkd2MyX2hzb3RnX2VwX3F1ZXVlKCkg
cmV0dXJucyAtRUFHQUlODQo+Pj4NCj4+PiBNb3ZlIHRoZSBjYWxsIHRvIHJlc3VtZSBnYWRnZXQg
YWZ0ZXIgdGhlIGNvcmUgaXMgcHV0IGluIERXQzJfTDAgc3RhdGUuDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBGYWJyaWNlIEdhc25pZXIgPGZhYnJpY2UuZ2FzbmllckBzdC5jb20+DQo+Pj4gLS0t
DQo+Pj4gICAgZHJpdmVycy91c2IvZHdjMi9jb3JlX2ludHIuYyB8IDEwICsrKysrKystLS0NCj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMgYi9kcml2ZXJz
L3VzYi9kd2MyL2NvcmVfaW50ci5jDQo+Pj4gaW5kZXggODc2ZmYzMS4uYjhlYmRhNSAxMDA2NDQN
Cj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jDQo+Pj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMi9jb3JlX2ludHIuYw0KPj4+IEBAIC00MDQsOSArNDA0LDExIEBAIHN0YXRpYyB2
b2lkIGR3YzJfaGFuZGxlX3dha2V1cF9kZXRlY3RlZF9pbnRyKHN0cnVjdCBkd2MyX2hzb3RnICpo
c290ZykNCj4+PiAgICAJfQ0KPj4+ICAgIA0KPj4+ICAgIAlpZiAoZHdjMl9pc19kZXZpY2VfbW9k
ZShoc290ZykpIHsNCj4+PiArCQllbnVtIGR3YzJfbHhfc3RhdGUgbHhfc3RhdGUgPSBoc290Zy0+
bHhfc3RhdGU7DQo+Pj4gKw0KPj4+ICAgIAkJZGV2X2RiZyhoc290Zy0+ZGV2LCAiRFNUUz0weCUw
eFxuIiwNCj4+PiAgICAJCQlkd2MyX3JlYWRsKGhzb3RnLCBEU1RTKSk7DQo+Pj4gLQkJaWYgKGhz
b3RnLT5seF9zdGF0ZSA9PSBEV0MyX0wyKSB7DQo+Pj4gKwkJaWYgKGx4X3N0YXRlID09IERXQzJf
TDIpIHsNCj4+PiAgICAJCQl1MzIgZGN0bCA9IGR3YzJfcmVhZGwoaHNvdGcsIERDVEwpOw0KPj4+
ICAgIA0KPj4+ICAgIAkJCS8qIENsZWFyIFJlbW90ZSBXYWtldXAgU2lnbmFsaW5nICovDQo+Pj4g
QEAgLTQxNSwxMSArNDE3LDEzIEBAIHN0YXRpYyB2b2lkIGR3YzJfaGFuZGxlX3dha2V1cF9kZXRl
Y3RlZF9pbnRyKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4+PiAgICAJCQlyZXQgPSBkd2My
X2V4aXRfcGFydGlhbF9wb3dlcl9kb3duKGhzb3RnLCB0cnVlKTsNCj4+PiAgICAJCQlpZiAocmV0
ICYmIChyZXQgIT0gLUVOT1RTVVBQKSkNCj4+PiAgICAJCQkJZGV2X2Vycihoc290Zy0+ZGV2LCAi
ZXhpdCBwb3dlcl9kb3duIGZhaWxlZFxuIik7DQo+Pj4gLQ0KPj4+IC0JCQljYWxsX2dhZGdldCho
c290ZywgcmVzdW1lKTsNCj4+PiAgICAJCX0NCj4+PiAgICAJCS8qIENoYW5nZSB0byBMMCBzdGF0
ZSAqLw0KPj4+ICAgIAkJaHNvdGctPmx4X3N0YXRlID0gRFdDMl9MMDsNCj4+PiArDQo+Pj4gKwkJ
LyogR2FkZ2V0IG1heSBxdWV1ZSBuZXcgcmVxdWVzdHMgdXBvbiByZXN1bWUgdG8gTDAgc3RhdGUg
Ki8NCj4+PiArCQlpZiAobHhfc3RhdGUgPT0gRFdDMl9MMikNCj4+PiArCQkJY2FsbF9nYWRnZXQo
aHNvdGcsIHJlc3VtZSk7DQo+Pj4gICAgCX0gZWxzZSB7DQo+Pj4gICAgCQlpZiAoaHNvdGctPnBh
cmFtcy5wb3dlcl9kb3duKQ0KPj4+ICAgIAkJCXJldHVybjsNCj4+Pg0KPj4NCj4+IFdoYXQgYWJv
dXQgYmVsb3cgcGF0Y2ggd2l0aG91dCBpbnRyb2R1Y2luZyBhZGRpdGlvbmFsIHZhcmlhYmxlLg0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jIGIvZHJpdmVy
cy91c2IvZHdjMi9jb3JlX2ludHIuYw0KPj4gaW5kZXggODc2ZmYzMTI2MWQ1Li41NDM4NjVlMzFj
NzIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jDQo+PiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jDQo+PiBAQCAtNDE2LDYgKzQxNiw4IEBAIHN0
YXRpYyB2b2lkIGR3YzJfaGFuZGxlX3dha2V1cF9kZXRlY3RlZF9pbnRyKHN0cnVjdA0KPj4gZHdj
Ml9oc290ZyAqaHNvdGcpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgJiYg
KHJldCAhPSAtRU5PVFNVUFApKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRldl9lcnIoaHNvdGctPmRldiwgImV4aXQgcG93ZXJfZG93bg0KPj4gZmFpbGVkXG4iKTsNCj4+
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAvKiBDaGFuZ2UgdG8gTDAgc3RhdGUgKi8NCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgIGhzb3RnLT5seF9zdGF0ZSA9IERXQzJfTDA7DQo+IA0K
PiBIaSBNaW5hcywNCj4gDQo+IFRoYXQgd2FzIG15IGZpcnN0IGFwcHJvYWNoIGxvY2FsbHksIGJ1
dCBJIGFkZGVkIGEgdmFyaWFibGUgdG8gYXZvaWQgZG8NCj4gaXQgdHdpY2UuLi4gZmV3IGxpbmVz
IGFmdGVyLg0KPiANCj4gQnV0IGlmIHlvdSBwcmVmZXIsIEkgY2FuIGNoYW5nZSBpbiBWMiA/DQo+
IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cuDQo+IA0KPiBUaGFua3MsDQo+IEZhYnJpY2UNCj4gDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGNhbGxfZ2FkZ2V0KGhzb3RnLCByZXN1bWUpOw0K
Pj4gICAgICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgICAgICAgICAgLyogQ2hhbmdlIHRv
IEwwIHN0YXRlICovDQo+Pg0KPj4NCj4+IFRoYW5rcywNCj4+IE1pbmFzDQo+Pg0KVG8gYXZvaWQg
dHdpY2Ugc2V0dGluZyBseF9zdGF0ZSB5b3UgY2FuIGFkZCAnZWxzZScgYmVmb3JlIHNlY29uZCBz
ZXR0aW5nLg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9jb3JlX2ludHIuYyBiL2Ry
aXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMNCmluZGV4IDg3NmZmMzEyNjFkNS4uZjU5ZGFiZDQ2
ZTYwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMi9jb3JlX2ludHIuYw0KKysrIGIvZHJp
dmVycy91c2IvZHdjMi9jb3JlX2ludHIuYw0KQEAgLTQxNiwxMCArNDE2LDE0IEBAIHN0YXRpYyB2
b2lkIA0KZHdjMl9oYW5kbGVfd2FrZXVwX2RldGVjdGVkX2ludHIoc3RydWN0IGR3YzJfaHNvdGcg
Kmhzb3RnKQ0KICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgJiYgKHJldCAhPSAtRU5P
VFNVUFApKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycihoc290Zy0+
ZGV2LCAiZXhpdCBwb3dlcl9kb3duIA0KZmFpbGVkXG4iKTsNCg0KKyAgICAgICAgICAgICAgICAg
ICAgICAgLyogQ2hhbmdlIHRvIEwwIHN0YXRlICovDQorICAgICAgICAgICAgICAgICAgICAgICBo
c290Zy0+bHhfc3RhdGUgPSBEV0MyX0wwOw0KICAgICAgICAgICAgICAgICAgICAgICAgIGNhbGxf
Z2FkZ2V0KGhzb3RnLCByZXN1bWUpOw0KICAgICAgICAgICAgICAgICB9DQotICAgICAgICAgICAg
ICAgLyogQ2hhbmdlIHRvIEwwIHN0YXRlICovDQotICAgICAgICAgICAgICAgaHNvdGctPmx4X3N0
YXRlID0gRFdDMl9MMDsNCisgICAgICAgICAgICAgICBlbHNlIHsNCisgICAgICAgICAgICAgICAg
ICAgICAgIC8qIENoYW5nZSB0byBMMCBzdGF0ZSAqLw0KKyAgICAgICAgICAgICAgICAgICAgICAg
aHNvdGctPmx4X3N0YXRlID0gRFdDMl9MMDsNCisgICAgICAgICAgICAgICB9DQogICAgICAgICB9
IGVsc2Ugew0KICAgICAgICAgICAgICAgICBpZiAoaHNvdGctPnBhcmFtcy5wb3dlcl9kb3duKQ0K
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCg0KDQoNCkFtIEkgbWlzc2VkIHNvbWV0
aGluZz8NCg0KVGhhbmtzLA0KTWluYXMNCg==
