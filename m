Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787AC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58162076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GhZrAiHg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eRYzu79i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgDVOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:49:03 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60962 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbgDVOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:49:02 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CC6C6C0B87;
        Wed, 22 Apr 2020 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587566941; bh=38TA8zEJ2eQQzm3e3PrgiAixNlTw7edM3oLvlFL5vLA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GhZrAiHg4gDQdL44m3Qk6ZI53cbxXkXdsPFiD70dRSWRJM2iFOvaIgR/bURVgJKvB
         i9wpeY01UJ/GWxXgPZ+ENb9c43EEVWuXlljF32JTs2Wj1dvGBM0ap1b1c3CeBk1Rss
         P640doklJqDNC3OalpJrh+Kc23XtlUNR2hB7mIl02ZBWiraST/hNqAiC2MZre52gQ/
         ZuHIGjHTnWFV6IHVhxX59NdwPjFTPCjpsFkCjw389DSqEg2ucOeglslHGIAm6DaOeJ
         KIQejdM/c94prJdURtaMO38u6/Pe3f5sffnPH1c64lot4L4BsDBL2PaMGvv5lLJXgv
         rZOPe6j1kG1wg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 49E4BA00D4;
        Wed, 22 Apr 2020 14:49:00 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 22 Apr 2020 07:48:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 22 Apr 2020 07:48:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQq4X4cZCh+F3uwBaHGWD8mZ0KdLqDqa5dh67PTe1fqZYoJIpQcGTdEAiNSvFvqWsKtLTNZArPSBXf8P1WcNFiSKAzQ1gtwUHbgR1LEBQCo7Hz4LGH8+d+H5xXG60be+S8TZVWYVDko7UXIMC552KZjp92KC7mtijCZn+mXoDwVWU9Lh0TY5uc9F+rUW0iZyZYZWJKB0NT5QJ61qb0CVnEgYyEMhDePcBOSNL9IgfnHfKs4D5n4x10k70qo0uOwFXjxEC9azdxeHHo43Q+cQLXCU25kP4dQLrc7kgkzg27+ObgMhmr0Jsoh4OFldbx5yEcL73vMjrm0TaAJnwt9Crw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38TA8zEJ2eQQzm3e3PrgiAixNlTw7edM3oLvlFL5vLA=;
 b=E1lQX+5By5JL1R8bulsyIiYP83KVS/l4ocmQFEwiZSQ87QYYMrGVluCI9AH0zLNIAAxRG+Gmn9tekGBwa8Bj/DFqVNBTnuVLlAut2vdqhS2+g3PwyeBJ7cblXA2GdSW6twZIPTSiDDRghzF1FXpirb/QLOCgyS//Ith7v+9vomySRdFLE1XlagYvQhiVrc6hSPzDwIveWluyJ1dOZ11QuZoVxk0p2SUD364IyOQ5x6dfp97NY31ZNZBVDBjoyzyF/ZZR6vjA+WC5pM4BS+2Hs8Oa/j5cbFS4tofRFdWtVaWrTbrkvCj5iXakDBli9DvaZshPFr9UrDPIfH7s0T45zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38TA8zEJ2eQQzm3e3PrgiAixNlTw7edM3oLvlFL5vLA=;
 b=eRYzu79ii8jSzomKSCoUPzPYPa93Mqn/2UJX8bWmybpKdukcuLDkFLXqga57otFAH6p3RGUO5j61si8d5ryG6QbfVLQLC2wgpjBtL2tg34xbloLCt1Lkf0KSPpkxIhHqQpPLiDDUihGrNolkqFOrHI0bTI5DPIE2SwrnDcT3l+w=
Received: from SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 by SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 14:48:52 +0000
Received: from SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d]) by SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d%7]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 14:48:52 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
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
Thread-Index: AQHWF9kltb5ivodInUCMhTw1JrJADqiFOpOA
Date:   Wed, 22 Apr 2020 14:48:52 +0000
Message-ID: <5391768a-da52-def8-9b2a-aeb559d8e26b@synopsys.com>
References: <1587472341-17935-1-git-send-email-fabrice.gasnier@st.com>
 <1587472341-17935-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1587472341-17935-2-git-send-email-fabrice.gasnier@st.com>
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
x-ms-office365-filtering-correlation-id: d88aa6a9-9df8-43e5-7881-08d7e6cc46a1
x-ms-traffictypediagnostic: SN1PR12MB2574:
x-microsoft-antispam-prvs: <SN1PR12MB2574F6399FB0C5CD5853016FA7D20@SN1PR12MB2574.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(8676002)(53546011)(31686004)(6506007)(110136005)(316002)(54906003)(2616005)(86362001)(81156014)(31696002)(478600001)(186003)(4326008)(71200400001)(8936002)(36756003)(26005)(91956017)(6512007)(66556008)(64756008)(66946007)(66476007)(66446008)(5660300002)(6486002)(76116006)(2906002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J4OLJ5PiRHKX3s/6wpY1JCKp9+/ZdJN0oaeqjkrtrDZZWMWa+1qYU/qrkLRAtBg/VWBeXv9MTrWCUDESws8Ofhwfr9iecgzU7MiWvOxEZ/tbJdMd65B25i5yREDPqcm+a1qb+3VtZ4KlUEGDKErYYWmuIrm+3PxYR8n3rbZZdfMXgnmzk7zf43eb8xrXIvm5OA/4j89K0Ay6uRyd9syAoBV4V/HUuNwVjx31SbLY7ffIni2hMqk1rp0S+w2r9qh/arzcwUzCGftQ5M8AIqP8Xls5I8NLMv8Os79TFEerCk0VwRUkWZOmg6SrCm4AlVMeb7D7GoM/jaAb90/VPys/JfBk0hU5iBcQlm8MN7Jh3/iSdk+kjZPZZ+pbSgrDDBjKaSu3yTt/xBXTrDQcDcWlM92oenIp9EaT66cnOor/gFflTzh3vZEyGKRHrOJdL3sj
x-ms-exchange-antispam-messagedata: E0t0i/JSmyD5/Kmy+Y64lWC1yRsGF5EHCfqJT7gGE/d0qEWPhNlWHcBIu4IZ1K4iGsjp0p/cGwN6mxsiu2J3yxoeuduNwXqWV/HiadQtndelpkcpXWW9rfcUNZm0JDmu2lXCB0t1NPHVphWmhzX77g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <44B65D7E0EC7F24DB7E0461B4EFC89C7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d88aa6a9-9df8-43e5-7881-08d7e6cc46a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 14:48:52.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cE5tO3O/59GpLnGUDvMO9VckQE/G04wCYkv+OBPLf7ZxJMfoIQUEzh9MZjJDbhHQXxgLdieKLB3IaYVCxHrdHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFicmljZSwNCg0KT24gNC8yMS8yMDIwIDQ6MzIgUE0sIEZhYnJpY2UgR2FzbmllciB3cm90
ZToNCj4gV2hlbiB0aGUgcmVtb3RlIHdha2V1cCBpbnRlcnJ1cHQgaXMgdHJpZ2dlcmVkLCBseF9z
dGF0ZSBpcyByZXN1bWVkIGZyb20gTDINCj4gdG8gTDAgc3RhdGUuIEJ1dCB3aGVuIHRoZSBnYWRn
ZXQgcmVzdW1lIGlzIGNhbGxlZCwgbHhfc3RhdGUgaXMgc3RpbGwgTDIuDQo+IFRoaXMgcHJldmVu
dHMgdGhlIHJlc3VtZSBjYWxsYmFjayB0byBxdWV1ZSBhbnkgcmVxdWVzdC4gQW55IGF0dGVtcHQN
Cj4gdG8gcXVldWUgYSByZXF1ZXN0IGZyb20gcmVzdW1lIGNhbGxiYWNrIHdpbGwgcmVzdWx0IGlu
Og0KPiAtICJzdWJtaXQgcmVxdWVzdCBvbmx5IGluIGFjdGl2ZSBzdGF0ZSIgZGVidWcgbWVzc2Fn
ZSB0byBiZSBpc3N1ZWQNCj4gLSBkd2MyX2hzb3RnX2VwX3F1ZXVlKCkgcmV0dXJucyAtRUFHQUlO
DQo+IA0KPiBNb3ZlIHRoZSBjYWxsIHRvIHJlc3VtZSBnYWRnZXQgYWZ0ZXIgdGhlIGNvcmUgaXMg
cHV0IGluIERXQzJfTDAgc3RhdGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaWNlIEdhc25p
ZXIgPGZhYnJpY2UuZ2FzbmllckBzdC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIv
Y29yZV9pbnRyLmMgfCAxMCArKysrKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MyL2NvcmVfaW50ci5jIGIvZHJpdmVycy91c2IvZHdjMi9jb3JlX2ludHIuYw0KPiBpbmRleCA4
NzZmZjMxLi5iOGViZGE1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50
ci5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMNCj4gQEAgLTQwNCw5ICs0
MDQsMTEgQEAgc3RhdGljIHZvaWQgZHdjMl9oYW5kbGVfd2FrZXVwX2RldGVjdGVkX2ludHIoc3Ry
dWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIAl9DQo+ICAgDQo+ICAgCWlmIChkd2MyX2lzX2Rl
dmljZV9tb2RlKGhzb3RnKSkgew0KPiArCQllbnVtIGR3YzJfbHhfc3RhdGUgbHhfc3RhdGUgPSBo
c290Zy0+bHhfc3RhdGU7DQo+ICsNCj4gICAJCWRldl9kYmcoaHNvdGctPmRldiwgIkRTVFM9MHgl
MHhcbiIsDQo+ICAgCQkJZHdjMl9yZWFkbChoc290ZywgRFNUUykpOw0KPiAtCQlpZiAoaHNvdGct
Pmx4X3N0YXRlID09IERXQzJfTDIpIHsNCj4gKwkJaWYgKGx4X3N0YXRlID09IERXQzJfTDIpIHsN
Cj4gICAJCQl1MzIgZGN0bCA9IGR3YzJfcmVhZGwoaHNvdGcsIERDVEwpOw0KPiAgIA0KPiAgIAkJ
CS8qIENsZWFyIFJlbW90ZSBXYWtldXAgU2lnbmFsaW5nICovDQo+IEBAIC00MTUsMTEgKzQxNywx
MyBAQCBzdGF0aWMgdm9pZCBkd2MyX2hhbmRsZV93YWtldXBfZGV0ZWN0ZWRfaW50cihzdHJ1Y3Qg
ZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgCQkJcmV0ID0gZHdjMl9leGl0X3BhcnRpYWxfcG93ZXJf
ZG93bihoc290ZywgdHJ1ZSk7DQo+ICAgCQkJaWYgKHJldCAmJiAocmV0ICE9IC1FTk9UU1VQUCkp
DQo+ICAgCQkJCWRldl9lcnIoaHNvdGctPmRldiwgImV4aXQgcG93ZXJfZG93biBmYWlsZWRcbiIp
Ow0KPiAtDQo+IC0JCQljYWxsX2dhZGdldChoc290ZywgcmVzdW1lKTsNCj4gICAJCX0NCj4gICAJ
CS8qIENoYW5nZSB0byBMMCBzdGF0ZSAqLw0KPiAgIAkJaHNvdGctPmx4X3N0YXRlID0gRFdDMl9M
MDsNCj4gKw0KPiArCQkvKiBHYWRnZXQgbWF5IHF1ZXVlIG5ldyByZXF1ZXN0cyB1cG9uIHJlc3Vt
ZSB0byBMMCBzdGF0ZSAqLw0KPiArCQlpZiAobHhfc3RhdGUgPT0gRFdDMl9MMikNCj4gKwkJCWNh
bGxfZ2FkZ2V0KGhzb3RnLCByZXN1bWUpOw0KPiAgIAl9IGVsc2Ugew0KPiAgIAkJaWYgKGhzb3Rn
LT5wYXJhbXMucG93ZXJfZG93bikNCj4gICAJCQlyZXR1cm47DQo+IA0KDQpXaGF0IGFib3V0IGJl
bG93IHBhdGNoIHdpdGhvdXQgaW50cm9kdWNpbmcgYWRkaXRpb25hbCB2YXJpYWJsZS4NCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMgYi9kcml2ZXJzL3VzYi9kd2My
L2NvcmVfaW50ci5jDQppbmRleCA4NzZmZjMxMjYxZDUuLjU0Mzg2NWUzMWM3MiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzIv
Y29yZV9pbnRyLmMNCkBAIC00MTYsNiArNDE2LDggQEAgc3RhdGljIHZvaWQgZHdjMl9oYW5kbGVf
d2FrZXVwX2RldGVjdGVkX2ludHIoc3RydWN0IA0KZHdjMl9oc290ZyAqaHNvdGcpDQogICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKHJldCAmJiAocmV0ICE9IC1FTk9UU1VQUCkpDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGhzb3RnLT5kZXYsICJleGl0IHBvd2Vy
X2Rvd24gDQpmYWlsZWRcbiIpOw0KDQorICAgICAgICAgICAgICAgICAgICAgICAvKiBDaGFuZ2Ug
dG8gTDAgc3RhdGUgKi8NCisgICAgICAgICAgICAgICAgICAgICAgIGhzb3RnLT5seF9zdGF0ZSA9
IERXQzJfTDA7DQogICAgICAgICAgICAgICAgICAgICAgICAgY2FsbF9nYWRnZXQoaHNvdGcsIHJl
c3VtZSk7DQogICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAgLyogQ2hhbmdlIHRv
IEwwIHN0YXRlICovDQoNCg0KVGhhbmtzLA0KTWluYXMNCg0K
