Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D444C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441F120672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Dl1JHR1k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PgL9es32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGIWRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:17:38 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:35340 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgGIWRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:17:37 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 954D3C0085;
        Thu,  9 Jul 2020 22:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1594333056; bh=Qt1FJKX7UzVe557qNHMkEaqKfLwQHfejd/BSoFXlF8g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Dl1JHR1kFhHDMg68WnvBHexFmHYIao1/Ap4le6r5rhVf867FEd61+EObugQNG4fDR
         GRdPCU89ftmoLbdCXjPWx85T1ygwqjeKd09Q7hcsIeyUJ/MfAbpANtcBfA8tKryQvL
         XKiqloK1dcNEWgb3TpqwkfnWlZ4zI2vnnm/i1lpFvLVcRMZoGlEOAMmLJWw2X3BOZJ
         qPJRlqIpUbeOTq71UkFVszRgKmogSXg06baaNVxsJpeHtr9fkS8xCTp1GMtytNIClt
         DrPEqdGNgT+7Cxl0SHDngOLtEooNcbFcdZf2JS3yM9mPMNzF2Nzqmd6grhjupikeKk
         ss7eHPqZESciw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C644CA005A;
        Thu,  9 Jul 2020 22:17:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 600D6800DE;
        Thu,  9 Jul 2020 22:17:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="PgL9es32";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUzSMpW9sgTUvjkPf9n2GkkdYaoXCyGnP8fH+eHxGueXK7URQGUpGNaAU1lObukA50rM7ha/3dQgoUqqG8EjO6gMWShlPM7RLhQ8M6ITmmq9qysACJGwYKV3csqMr82ZDRHV7zJ+BZtVYfz7LKyxRSm1BCt9U4ZbGNiWcg8VStXDo0IMrcYR2ajLqVBX/1Yzsiw8u1p5DoIMiejOm8zV2ik7p7FWGnM6sVfFMC/ZVF9WjFarXUayol+hnxaF+8S4bTqDfV4cgPNeoK3ZEShiE73Sh4/gmnrdjKa2M2bDRFEuTbK+hHt08wcZ9ekNvPSckvxmt+hac9R4+7hqwF6q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt1FJKX7UzVe557qNHMkEaqKfLwQHfejd/BSoFXlF8g=;
 b=VZyYXqCEDrCbBvY3pTEeN52cV5kGsuBRvsCsh4ZvsfopQFIoOXPJ5qOiHZ8jKg/MATndxsAQUD6pILbpYZDy/bneXGnwfeRcnvfTJFSU3jEtf/ERm0jkhl/30bRD3+kHw73G6lldMAH/Z8o+iL9hUGoIVD8N/k74loj4ZEGHo5bHYa+LDZlegSGIfdZC1te2Ov65qSJTMmIeJYiT4rmoT10EbKOuPmKLcowDVTqX1SnbbOZJaZ2kN0cmOHeYT5LWb1qahe5Yk7XaYO4hXadONJ4Tms5mZeFj5SJ3gwt0yYgXzj55gWAKwDNS1XTFNDlRW9kaCZPJ1Ifwwqcp8Ahg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt1FJKX7UzVe557qNHMkEaqKfLwQHfejd/BSoFXlF8g=;
 b=PgL9es32PJTWbG5Bkf6XWLC6dvsTMaKBnEGW2mi5KpIVaoN6gqhCuG4Mh3R2PmHVr318DkSajBQTF7faZlaYJcBfhRa6yN6N8wsa5dErin5QuUZm9FNAHPCLT68N/RepteABGEnYKSM7YD8LKYKkn9XbEmqbThkFcmmlq/oQjlc=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BY5PR12MB3874.namprd12.prod.outlook.com (2603:10b6:a03:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 22:17:27 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3844:ed8:654d:7456]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3844:ed8:654d:7456%5]) with mapi id 15.20.3153.032; Thu, 9 Jul 2020
 22:17:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [RFC PATCH] usb: dwc3: fix maximum_speed check for usb2.0-only
 core
Thread-Topic: [RFC PATCH] usb: dwc3: fix maximum_speed check for usb2.0-only
 core
Thread-Index: AQHWVciZhhgPOtxvykmm/JX0MmuCQ6j/0eIA
Date:   Thu, 9 Jul 2020 22:17:27 +0000
Message-ID: <6dff8574-e649-7a5c-4d80-c3fe6ddd6645@synopsys.com>
References: <1594282250-25544-1-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1594282250-25544-1-git-send-email-chunfeng.yun@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [149.117.7.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 277543ec-77c2-414b-9050-08d82455dd01
x-ms-traffictypediagnostic: BY5PR12MB3874:
x-microsoft-antispam-prvs: <BY5PR12MB3874035567D0742A59759E3EAA640@BY5PR12MB3874.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: psaEZOPacPfBl8iuiNVEG60nDDmyfOruGpEkEd/6KMkM8jm3bEjgyX7WtWLAy5+ScdObNl+Et+qpci9HoRnyQgy+2PZ1j7hE3fwE0Pr1TQVmNdZOukW9IzvjyCFoL52uTPiUG7BGmUS0+jjoVCGwGMNsLZT7W7noT+guBIrekDNZxBZgFkgEuqRjp4i8pOzyEN5zJlYi7GzEQqOl48sH+dsN5EYroNDRZzZNYz+2Jl4pvAH8xGYKkanYlO1Pkax0PAjdNWDu79wcoj2z1fwlgxJ0uMC2bA5YxM4+9hlg3vE5acsdR03NjELnyeFsG80c2jTBx4uGIh8nX5D0ZQzDe3fDLGu69R4vTtdKL+NUrwoMOqcpXiTPxlFwfJ9K0cww
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(366004)(376002)(396003)(136003)(66446008)(66476007)(66946007)(66556008)(64756008)(31696002)(31686004)(2616005)(76116006)(71200400001)(478600001)(6512007)(86362001)(36756003)(26005)(6486002)(2906002)(316002)(83380400001)(110136005)(8676002)(186003)(6506007)(4326008)(54906003)(8936002)(5660300002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vnsgZrkw1wKs26Z+8q26CvDiFxT6dzjkXlQjesKIKGPEA7LwqdOgoxLHStponOl+QwL3KiU42NljE8HbC/a5xtDKY+60zClzKgSe4fNBhURbzPa8howhkihzHYSsgYSF6kOxp9HXJNKplRGJYTe3DZkjJsfxdO9tn5l+StmUIXhPhiudW6HSBQK0RLWL3OynAm7xLM7kSxAwyK9BzkPgOrwS+ovEKsH9p92YY1gMRMH4LHNUNrYoLoreeoDm7swDC1Zs9KLhT2xM4i6jZKz7AwTAcL0th31d9+Rf9u1FF1nLV5yRybUhn4iURTfjsg3kAqlFcEwgevtRztxKSjAPQngGQe3kS0Js+TceQsv+BFbtQgw5fHLN3LpgHqomUdrEQPwQ96eJTkAdB7GvC0Sg4VbDTYQyVoPSWknmmkHBNLL4WJFZSKoJfkyqgH7EIeAbYoe27XpJ2XeVNaTF6EjOxYgHnp/N/826yEagXfwAGbA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F76D7F612B429F468EBD9E4A1DEAD566@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277543ec-77c2-414b-9050-08d82455dd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 22:17:27.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UYbxn9v1EeKVchpSVSOm+OFBDKJKBvbgJGNqU2YiVHLNbsRGYIuQ3vcyPOJ3Hqbp/FzrLMkiarkP0wz3li6pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3874
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkNodW5mZW5nIFl1biB3cm90ZToNCj4gVGhlIG1heGltdW1fc3BlZWQgd2lsbCBiZSBV
U0JfU1BFRURfU1VQRVJfUExVUywgYnV0IHRoZQ0KPiBtYXhpbXVtX3NwZWVkIGNoZWNrIGZvciB1
c2IyLjAtb25seSBjb3JlIGRvZXNuJ3QgY29uc2lkZXIgaXQsDQo+IHNvIGZpeCBpdCwgYW5kIG1v
dmUgdGhlIGNrZWNrIGludG8gZHdjM19jaGVja19wYXJhbXMoKS4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gTm90
ZToNCj4NCj4gV2hlbiBJIGxvb2sgYXQgdGhlIGNvZGUsIGZpbmQgdGhhdCB0aGlzIG1heSBiZSBh
IHByb2JsZW0sIGJ1dCBubw0KPiBwbGF0Zm9ybSB0byB0ZXN0IGl0Lg0KPiAtLS0NCj4gICBkcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDE0ICsrKysrKystLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXgg
MjVjNjg2YTcuLmZmZDVhYjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC05MzAsMTMgKzkzMCw2IEBA
IHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gICAJICovDQo+
ICAgCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVUlELCBMSU5VWF9WRVJTSU9OX0NPREUp
Ow0KPiAgIA0KPiAtCS8qIEhhbmRsZSBVU0IyLjAtb25seSBjb3JlIGNvbmZpZ3VyYXRpb24gKi8N
Cj4gLQlpZiAoRFdDM19HSFdQQVJBTVMzX1NTUEhZX0lGQyhkd2MtPmh3cGFyYW1zLmh3cGFyYW1z
MykgPT0NCj4gLQkJCURXQzNfR0hXUEFSQU1TM19TU1BIWV9JRkNfRElTKSB7DQo+IC0JCWlmIChk
d2MtPm1heGltdW1fc3BlZWQgPT0gVVNCX1NQRUVEX1NVUEVSKQ0KPiAtCQkJZHdjLT5tYXhpbXVt
X3NwZWVkID0gVVNCX1NQRUVEX0hJR0g7DQo+IC0JfQ0KPiAtDQo+ICAgCXJldCA9IGR3YzNfcGh5
X3NldHVwKGR3Yyk7DQo+ICAgCWlmIChyZXQpDQo+ICAgCQlnb3RvIGVycjA7DQo+IEBAIC0xNDI2
LDYgKzE0MTksMTMgQEAgc3RhdGljIHZvaWQgZHdjM19jaGVja19wYXJhbXMoc3RydWN0IGR3YzMg
KmR3YykNCj4gICANCj4gICAJCWJyZWFrOw0KPiAgIAl9DQo+ICsNCj4gKwkvKiBIYW5kbGUgVVNC
Mi4wLW9ubHkgY29yZSBjb25maWd1cmF0aW9uICovDQo+ICsJaWYgKERXQzNfR0hXUEFSQU1TM19T
U1BIWV9JRkMoZHdjLT5od3BhcmFtcy5od3BhcmFtczMpID09DQo+ICsJCQlEV0MzX0dIV1BBUkFN
UzNfU1NQSFlfSUZDX0RJUykgew0KPiArCQlpZiAoZHdjLT5tYXhpbXVtX3NwZWVkID4gVVNCX1NQ
RUVEX0hJR0gpDQo+ICsJCQlkd2MtPm1heGltdW1fc3BlZWQgPSBVU0JfU1BFRURfSElHSDsNCj4g
Kwl9DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KDQpBY3R1YWxseSwgdGhlIGR3Yy0+bWF4aW11bV9zcGVlZCBjYXB0
dXJlcyB0aGUgbWF4aW11bSBzcGVlZCBkZXZpY2UgDQpwcm9wZXJ0eSB2YWx1ZS4gSXQgbWF5YmUg
YmUgc2V0IGJhc2VkIG9uIHRoZSBwaHkncyBjYXBhYmlsaXR5IGlmIHRoZXJlJ3MgDQpubyBwcm9w
ZXJ0eSBzcGVjaWZ5aW5nIGl0IChpLmUuIG1heGltdW1fc3BlZWQgaXMgVVNCX1NQRUVEX1VOS05P
V04pLg0KDQpTbywgdGhpcyBjb2RlIHNob3VsZCBiZSByZW1vdmVkLiBUaGUgZml4IHNob3VsZCBi
ZSBpbiB0aGUgY2hlY2sgb2YgDQpkd2MzX2NoZWNrX3BhcmFtcygpLiBJZiBtYXhpbXVtX3NwZWVk
ID0gVVNCX1NQRUVEX1VOS05PV04gYW5kIHRoZSBwaHkncyANCmNhcGFiaWxpdHkgaXMgb25seSB1
cCB0byBoaWdoc3BlZWQsIHRoZW4gc2V0IHRoZSBtYXhpbXVtX3NwZWVkIHRvIA0KaGlnaHNwZWVk
IG9ubHkuDQoNClRoYW5rcywNClRoaW5oDQo=
