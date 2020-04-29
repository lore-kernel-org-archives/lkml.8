Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B67C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25C620661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Hpn0XyXb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uO7SxALQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgD2Su3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:50:29 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:32864 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgD2Su2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:50:28 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C3D1C0339;
        Wed, 29 Apr 2020 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588186227; bh=qLWQYB5ahkf0diSWYt4jg4tbzMRycRYpDomxN6jfWnw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Hpn0XyXb1Z9KUfRjim5gyecUQS1kZpuF5iMcZntFVj8zRQACjcNX70Z0sp2Mri5Gx
         wz0W89z1cXicO6A+P7hePFJLfoi58Kh12pGmdqbUWVnZOoDgad7axTgAxEwC7QiaFQ
         /OkMSYGcuQJGj88uCtRA/N/1xLnF+fcCBp2BCWent5EuwNh7fI4aFhcyYMOFniZclE
         sXabh/mF+v4n7GGfPuCZIpn8D37mX0FMsvWbE0sIAqghCsiAV1jxPTppeCdQph463A
         OBIOVJVb5X5hp4bqebbgoQYhz9cDvqq5DMLWdITvu3NlGKVnpQVwU0RjenGXsRyC+x
         Burt68mvN2qVg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7AEF4A0083;
        Wed, 29 Apr 2020 18:50:24 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 Apr 2020 11:50:24 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 29 Apr 2020 11:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCTyaRuVf4//8wSSLu0tI4lZRUHB6mUiD2KDAbvsq9Ns6I3XSDJa/Xn/geKxG868ZWJxfj+85ccWdJfFSDgaw+dQSiMqfTX2MY76vbzBd3Kfwu7SxvxqXaH1kYy0tZJ5y/voMUYUTIVdPFts5Sj1NlxPLd9wi70xmO4sV7eddkU4ejMo4gjJU7pvP8ppSaPTSpCuQQYqaE19p5XAk5GJB1yJU9+cKrOqTGD/+ruHa3czIYSWCUgRwRp7vxD68o40w9qpccNOjysr629aO4noINLYLDeWsmQlDeBe+40s67uwDgHsMSybSQ3knV7u13A5Md7OyW3BkCmARUevRQCKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLWQYB5ahkf0diSWYt4jg4tbzMRycRYpDomxN6jfWnw=;
 b=RjNsyejU2D9Njk6TnAvPvHQdXgyoLTPjeMGR7Ob77z0X2684qa69FyWL+OFrQ4WtFl0OaPCoukMeuQ3eW63lvtwkGA1Vth8Nv7k3l5GR5kILbGnjIZCnqxY53J4D/UyJXAQzdfpejpNU+QywBoCOLKL1sIH4bnnmZasAI5l7SKGzBA9ZrBW2Wa7lvfP14helSRl3xQ0CaT6VHm7g/S+jME5OmpaWx7vgSwCivCI568VKLCC8frEKsDR80CWnbXLkRAUlql5TizlIORcuU3nSfGuQMBgM+K0E3vta8Q9ASjsoZ9SHMWcskdbK83xk5CrEUtGTV+PeWyitiQEDN8ho6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLWQYB5ahkf0diSWYt4jg4tbzMRycRYpDomxN6jfWnw=;
 b=uO7SxALQxpcyHN1PPuG7XVC0Jsqw1Damoq7n4COLn0EB2GW9AmLnd+lwh3q4/l6lwze4tiShjsTwuiQbVs2Qu14YYB5sqo4l9T7vlF2U1yejg5Jnnt0J6Z9wGElxs9rVUB/d3zCDT1nHcSuv9KA0Lb2XSCvo24yKcQD+Ob3JpU0=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2598.namprd12.prod.outlook.com (2603:10b6:a03:6a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 18:50:22 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af%6]) with mapi id 15.20.2958.020; Wed, 29 Apr 2020
 18:50:21 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Topic: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Index: AQHWHY4Y/rFoWc1Ys0qE7xdv+GRYS6iO8C2AgAFnjQCAABszgA==
Date:   Wed, 29 Apr 2020 18:50:21 +0000
Message-ID: <594bf4ba-983e-4cd1-1b92-84c517a82147@synopsys.com>
References: <20200428185024.5168-1-Eugeniy.Paltsev@synopsys.com>
 <08a295ba-e6f0-65d2-cb64-3ea463797f6d@synopsys.com>
 <CY4PR1201MB013604A65801D2028225B20BDEAD0@CY4PR1201MB0136.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB013604A65801D2028225B20BDEAD0@CY4PR1201MB0136.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [73.222.250.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a0ab30d-87da-4ce8-2e9e-08d7ec6e2b9a
x-ms-traffictypediagnostic: BYAPR12MB2598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB25986B47D602134E40CBA3D2B6AD0@BYAPR12MB2598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(396003)(39860400002)(136003)(376002)(6512007)(6636002)(54906003)(2906002)(31696002)(31686004)(8676002)(478600001)(8936002)(37006003)(316002)(53546011)(6506007)(26005)(64756008)(2616005)(86362001)(186003)(66446008)(36756003)(5660300002)(76116006)(6486002)(6862004)(4326008)(66476007)(66556008)(66946007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +d5Y65Mh5wJD1caO+haQ+hO5SlOQvSQ2G2qMYsNFjobIpBL6BPZhSjUwD9ENaJu6W2hHFkaYNy5WzQl56bt3tHi8Bjbb3GYh3lyPfWhj3r49XA8O60p/OfHCgxn7JkeKkE13YNuBYJlYk3IcuqbQowjnJ9eNRW38Hp6PA5o1s1q+TALKd0/UX6LzaVqg1JGKEOSmDfpMWLj0cQdw43rZBA4Mk3BByJBR4bo8sNXwSxRcMWxqxoxfqgAXL+GkLmfKE0UVulWqXB0K1/1R6Hcogm5EQu8RuWWNN6y3aDpbcxcfa3ujmT/1XeER+20ZEKDaLC0YYT1i7/163C/fswxguhff4fIDTLK/UHU28whYGUpVUTiBGeVevBUxiVUGGflU2cCLDL5Ys1DAg9pXQl7k5r6sANpI1OZMguEay1WuyZdB2EG2KGIMQNH5sNISOzzE
x-ms-exchange-antispam-messagedata: ozUZvQZK825Q4GEwY/Lt1wxe1AwhTpwpT6FSPjaUvvKVVLAurTKlb2paSgyEbtyFOKuiX3ry2kVF1RRs1X/pAuB/09W8kcrfPnH27s08hL2+b5ipUnHHm3qd37P4io2uJkw7hXrYRoovgLbCRVO2hM0Crug9NlxIJed6CXO8f+IVC5MamigZDeZNTtqqJ44F5KBm4sePFxhfT6GBi5LyxDAY9gaTjxWJpCgzgAZXsCvTj3TGq8K/IeDruMG3opcmitiEmbzrHcC4dLzogKZtKyFkEkwqxDjfA9cX1Agr2B+tAhqWZp29DqrwPIDR+qX20WRkC1hzvlAvCrkjGmXhaGmbsBie/anRPgu/f5nttpDpT/7ox057H0aL1qnIZf8XGIQWW2ME3hiVuAZ43jnahQ9/DrLx/uR2oMAPey1bdK1mmoldGnnjk9yOmr3NJL4/alwxNrdg9ENNvZPAM+2w6CG26pRcFrK1NpCXqDgkPJ11bsMZ3tVyErCr+7iwt7rcXDmnU/xFpy6HC5JyD+OgA7LETttiZB5wS6r2v/AZr9HWqrfSeC3tLtwwEPN4SRf4/R4piICh2jU8aS0NbDinQbIWm6kYQ/RMzv4m+E5jM86cjVDMjOIAPv9v7rwkMosIEkpR+4ZTWBlLxTCdZ2xItcGASmelJDBj6Fk464sIPpbgolGKtk7f/Q2joz4qZljgsXvFwzxABVpnYC5mEXr30ZaUqglFZ7H5blTD0nwVV8/AP6mM5ml+w7uu/dYymclQN1ijxCatNTfZxRyDZx2pNABSVfsCsyPPDliQ0UaZhrI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F120BFDA91BFB43B5C485DCCE5B1499@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0ab30d-87da-4ce8-2e9e-08d7ec6e2b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 18:50:21.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoJAzra432S+dPZNfzgumkKgoeSS3G7ULm7xIx7b/lERscSL/SDYwoGcjZF5NJwLyacVFavkx6yDKw5LKZu5qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2598
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOS8yMCAxMDoxMiBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPiBIaSBWaW5lZXQs
IA0KPg0KPj4gRnJvbTogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KPj4gU2Vu
dDogVHVlc2RheSwgQXByaWwgMjgsIDIwMjAgMjI6NDYNCj4+IFRvOiBFdWdlbml5IFBhbHRzZXY7
IGxpbnV4LXNucHMtYXJjQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+IENjOiBBbGV4ZXkgQnJvZGtp
bjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
QVJDOiBndWFyZCBkc3AgZWFybHkgaW5pdCBhZ2FpbnN0IG5vbiBBUkN2Mg0KPj4NCj4+IE9uIDQv
MjgvMjAgMTE6NTAgQU0sIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4+PiBBcyBvZiB0b2RheSB3
ZSBndWFyZCBlYXJseSBEU1AgaW5pdCBjb2RlIHdpdGgNCj4+PiBBUkNfQVVYX0RTUF9CVUlMRCAo
MHg3QSkgQkNSIGNoZWNrIHRvIHZlcmlmeSB0aGF0IHdlIGhhdmUNCj4+PiBDUFUgd2l0aCBEU1Ag
Y29uZmlndXJlZC4gSG93ZXZlciB0aGF0J3Mgbm90IGVub3VnaCBhcyBpbg0KPj4+IEFSQ3YxIENQ
VSB0aGUgc2FtZSBCQ1IgKDB4N0EpIGlzIHVzZWQgZm9yIGNoZWNraW5nIE1VTC9NQUMNCj4+PiBp
bnN0cnVjdGlvbnMgcHJlc2VuY2UuDQo+Pj4NCj4+PiBTbywgbGV0J3MgZ3VhcmQgRFNQIGVhcmx5
IGluaXQgYWdhaW5zdCBub24gQVJDdjIuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5
IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+DQo+Pj4gLS0tDQo+Pj4gIGFy
Y2gvYXJjL2luY2x1ZGUvYXNtL2RzcC1pbXBsLmggfCAyICsrDQo+Pj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9pbmNsdWRl
L2FzbS9kc3AtaW1wbC5oIGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vZHNwLWltcGwuaA0KPj4+IGlu
ZGV4IGUxYWEyMTJjYTZlYi4uZTY0ZDk0NWFlN2RmIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvYXJj
L2luY2x1ZGUvYXNtL2RzcC1pbXBsLmgNCj4+PiArKysgYi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9k
c3AtaW1wbC5oDQo+Pj4gQEAgLTE1LDEyICsxNSwxNCBAQA0KPj4+DQo+Pj4gIC8qIGNsb2JiZXJz
IHI1IHJlZ2lzdGVyICovDQo+Pj4gIC5tYWNybyBEU1BfRUFSTFlfSU5JVA0KPj4+ICsjaWYgZGVm
aW5lZChDT05GSUdfSVNBX0FSQ1YyKQ0KPj4gaWZkZWYgaXMgdGhlIGNhbm9uaWNhbCB3YXkgZm9y
IGEgc2luZ2xlIG1hY3JvIHRvIGNoZWNrLg0KPj4NCj4+IEFsc28sIHRoaXMgbmVlZHMgdG8gYmUg
ZmluZXIgZ3JhaW5lZCwgaS5lLiBDT05GSUdfQVJDX0RTUF9LRVJORUwgd2hpY2ggaXMgYWxyZWFk
eQ0KPj4gdGllZCB0byBBUkNWMiBvbmx5IGNvbmZpZ3MuDQo+IFdlIHNob3VsZG4ndCBsaW1pdCB0
aGUgc2NvcGUgb2YgdGhpcyBjb2RlIHBhcnQgW2RzcCBlYXJseSBpbml0XSB0byB0aGUgY2FzZXMN
Cj4gd2VyZSBEU1Agc3VwcG9ydCBpcyBlbmFibGVkIGluIGtjb25maWcgLSBhbmQgdGhhdCBpcyB0
aGUgcmVhc29uIHdoeSB0aGlzIGNvZGUNCj4gaW5pdGlhbGx5IHdhcyBndWFyZGVkIHdpdGggQkNS
IGNoZWNrIG9ubHkuDQo+DQo+IFNvLCBJIGNoYW5nZSB0aGUgY2hlY2sgdG8NCj4NCj4gI2lmIGRl
ZmluZWQoQ09ORklHX0FSQ19EU1BfSEFORExFRCkgfHwgZGVmaW5lZChDT05GSUdfQVJDX0RTUF9O
T05FKQ0KDQpZb3UgYXJlIHJpZ2h0LiBJdCBuZWVkcyB0byBiZSBkaXNhYmxlZCBpZiB0aGUgaGFy
ZHdhcmUgZXhpc3RzIGluZGVwZW5kZW50IG9mIEtjb25maWcuDQoNCj4gd2hpY2ggaXMgYWN0dWFs
bHkgdGhlIGVxdWl2YWxlbnQgdG8NCj4NCj4gI2lmIGRlZmluZWQoQ09ORklHX0lTQV9BUkNWMikN
Cj4NCj4gYnV0IEkgZG9uJ3QgdGhpbmsgaXQncyB3b3J0aCB0aGluZyB0byBkby4NCg0KQWdyZWUu
DQoNCi1WaW5lZXQNCg==
