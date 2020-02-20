Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609B1C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18824206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="B2xgpLxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgBTTDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:03:20 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.4]:56636 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728111AbgBTTDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:03:19 -0500
Received: from [100.112.2.30] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-east-1.aws.symcld.net id 2E/B5-38805-EE7DE4E5; Thu, 20 Feb 2020 19:03:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTe0xTZxTv13v7AFpzKSDfmJCtspdbC8WJdwy
  mk7Bcs0lG9oQ5xmVUWgOF9RYt29SqLHF0Gy8npYgtL+l4DIfZ0IogRToL6HhViIMsTh6Cjpqg
  mAKytdzKtn++/H7nd87vnJOcj4sIqjlBXKlaJVUqyAwh2xuV3b7pI5obiU8OHygIwWcKuwBer
  PsbwTtGIN53d5yDDz9wsPH8ynD8aHUzGy/visZPTjUBvG6oGeCm+2UcfMh8ko1f0S+i+GzXKB
  tvaLuN4KZ6HdiOEef14xzC2JJDLF0CxFnTJmLsehubOGVLIDoqGjnEH9pfmcQF4zyTcLTb2cR
  8S8jbPkksuSI1S53Cki1cKUazDwerq2yxGtC/IR94cwWYhgk7Tv+M0GQWwNryTs6acrbmO5Qm
  SwC2FlhXFYDVInB4tJ2VD7xcxIrCSa1HOAOgdnEeuAmKXUCgyen01Jcw4cjYBJMmfwJYbL0O3
  PVs7HloKC9D3dgf2whtA92IGyOYlQV/0u92Yz8sEXbqxph0ThI8VXrLkx8B+x7Wu3pzXe2egU
  7Lq+4wH0uB1dZFz0o6JnTcM656emEJcLh3CaXnXg8f9jQy6V6B8MaEYRVDDIM1bb8hNA6AM7d
  WPHu+B29c/IZFx5+C5oLznvxgOGjQAhrvgnPXSj21L8Ef7xR7cDTsnjai7jkhFgpXLLl0OAs2
  6L4HhWCz/j9T6F1ZCPYCbDaH0eGn4XHtTY5+dTNfaCubQI0ArQeRqUp5ukyVScozRJLwcJFEE
  iEKF0VIIsXk56JUcQ4lkpKUSiQRk/spMZWb+WlGmlghVbUA142mZTNGz4HKJofYAp7gMoUB/D
  2m+GTButSstFwZSck+UeZkSCkL2MDlCiFfaHdpvkppulS9R57huvTHMuTyhP78I1ddMp/KJjM
  peTot9YBXuIUzFVUId85Z7XovV9RWIQJUkaWQBgXyNW4/zF0gy1Gs2T3+O4MgOMiPDxgMhoCX
  LVVmylX/12dBIBcI/fjjbheeXKFa6+q6Xtcu/nyH31vugVTkv1KQhpl30BBc9kHcobaO/vYPh
  S3H46b7l+OnamOO7Fsu+WHzlhmWfYEZJzgWGDkJqvYWvZx/kUo05+mOtdsnG3Zu/X3f+8vqwV
  iE0aBeqHkn8t3PJg1tW4070sYrh/Z/+fXAcwcMvrzd3vdKbdK/4pL7oqa2nbjTrBlJPLDjlyQ
  yIQE8qbtsSjt68NhXJSEBjKKrXzzK294b8+xUMhFWEaXY+EYpbk1aWXdu57e77sbHak/UTY0Q
  ir1Dy53Xoqx19mleQaTDEdt6uPFMd0xKaPSk/MHpbY+kb4a+1tNb9JGt4z4ZtsWw4vzYYn7Ri
  3cooX+6lWN22i/1rUQk+TDim2rX91dVvm7RlApRSkZKNiFKivwHGfko2bYEAAA=
X-Env-Sender: mpearson@lenovo.com
X-Msg-Ref: server-23.tower-395.messagelabs.com!1582225390!2552236!1
X-Originating-IP: [104.232.225.11]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24718 invoked from network); 20 Feb 2020 19:03:10 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.11)
  by server-23.tower-395.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Feb 2020 19:03:10 -0000
Received: from HKGWPEMAIL01.lenovo.com (unknown [10.128.3.69])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 153958657650C5ABA2B7;
        Thu, 20 Feb 2020 14:03:06 -0500 (EST)
Received: from HKGWPEMAIL04.lenovo.com (10.128.3.72) by
 HKGWPEMAIL01.lenovo.com (10.128.3.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1779.2; Fri, 21 Feb 2020 03:03:12 +0800
Received: from HKEXEDGE02.lenovo.com (10.128.62.72) by HKGWPEMAIL04.lenovo.com
 (10.128.3.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2 via Frontend
 Transport; Fri, 21 Feb 2020 03:03:12 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.52)
 by mail.lenovo.com (10.128.62.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2; Fri, 21 Feb
 2020 03:03:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUIOr0lQMRbalXvgPU1a+U8PRSBOTJi2PBXr1rEHfOSqk3UQv4xEERrHQGniVrvHC96V973c5qDpkf3680/lCqFvYL1mc/SdLmSn5SdfKiNo3+nZ5nK3XktudtyGVX3c32Eyz8OFT6KAO5VuZDNo8fDnmuF8r1XkBAy1cKYN1C3doPvF3Gn4NH57xFgYCYf9T45bA1b7BK+ioe6MGt5APBu0ij+X5wb1xMw7N6FxwOkDb70ltdpv2wq7t43hK4tCyVVWobp8Hw1TAGEyCWtn8o53o9YSMoJoPIK42OwoGCs5CZtbnOYSZdiHexIOU2NVjghTy/KuHN82OQ817gi/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxW/XJpXtjFvOrAy1Q2dLR6xDZFJP8iWKzdakHj5oMg=;
 b=N4ymj/syq8LB3joa3S9ShClb91S03dqIPkcW7mWyzhbDdsCxF3fDSVxjsQx1gxZJR9x110nyHynhxZThiAX1kiLJpsi5Pkj2rmMIujGMt9mdzcvp6IpskhrrI6O5f8SX4bkdiRah/fbqjBBJdfOs2xY1VVg7ljKnaGPy/pF1EWn4skayZ/G5Mo58vVIVtv9W8vTsMgq88E+mWXemr4wX05py2gY/sJEVnV3b8wkmVbQi/Ipc+OWIWkSPFeCJEOwNFQGsGW3S/ZVUgwOhqxDbcEVjXZ8fO/InjICj6wJJ5rAtGlTk94NiUL8bzejp4+bT6mByK1KiOd0FzLe9IFgRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxW/XJpXtjFvOrAy1Q2dLR6xDZFJP8iWKzdakHj5oMg=;
 b=B2xgpLxNJlTxrk5jCAzGWGWgVRvlav0Jk20z7OhHllNaFuytxyMW/AFKKeQcTl4q+JNyQ5YLV1SezJ4wUHAXneEP0OjeBNVjmuOVEnsrfnrmfWDzTKVurRqaewfZ87AZM5zgJqZSCDMDc15JASiMFvgYnhr7oWLwRdXQfETE+Vg=
Received: from PS1PR0302MB2604.apcprd03.prod.outlook.com (10.170.180.15) by
 PS1PR0302MB2571.apcprd03.prod.outlook.com (10.170.183.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.8; Thu, 20 Feb 2020 19:03:00 +0000
Received: from PS1PR0302MB2604.apcprd03.prod.outlook.com
 ([fe80::f195:23a8:c12b:5be]) by PS1PR0302MB2604.apcprd03.prod.outlook.com
 ([fe80::f195:23a8:c12b:5be%12]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 19:03:00 +0000
From:   Mark Pearson <mpearson@lenovo.com>
To:     Rajat Jain <rajatja@google.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nitin Joshi <nitjoshi@gmail.com>,
        Mat King <mathewk@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Benjamin Berg <bberg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [External] Re: [PATCH] thinkpad_acpi: Add sysfs entry for
 lcdshadow feature
Thread-Topic: [External] Re: [PATCH] thinkpad_acpi: Add sysfs entry for
 lcdshadow feature
Thread-Index: AQHV6B0j3nBIaF9kb0aMAt2+jGCbwKgkbFcA
Date:   Thu, 20 Feb 2020 19:03:00 +0000
Message-ID: <PS1PR0302MB260492DDE243BE0A64A39AA7BD130@PS1PR0302MB2604.apcprd03.prod.outlook.com>
References: <20200220074637.7578-1-njoshi1@lenovo.com>
 <CAHp75VcJmEOu1-b7F2UAsv=Gujb=pPLzjz2ye9t4=Q68+ors-w@mail.gmail.com>
 <HK2PR0302MB25937E2946BF38583B3A905DBD130@HK2PR0302MB2593.apcprd03.prod.outlook.com>
 <CACK8Z6GwuOnJUUscriGwKWGBp5PFKyuqUkFYC8tEXa0UEuEZww@mail.gmail.com>
In-Reply-To: <CACK8Z6GwuOnJUUscriGwKWGBp5PFKyuqUkFYC8tEXa0UEuEZww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.48.229.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8a379d1-32f0-47dd-6ad3-08d7b6378137
x-ms-traffictypediagnostic: PS1PR0302MB2571:
x-ld-processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PS1PR0302MB25715E384BAECBFE19D96225BD130@PS1PR0302MB2571.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(71200400001)(54906003)(52536014)(5660300002)(55016002)(33656002)(316002)(478600001)(7416002)(66946007)(66476007)(9686003)(4326008)(2906002)(86362001)(6916009)(7696005)(966005)(81166006)(8936002)(81156014)(8676002)(76116006)(6506007)(26005)(66556008)(66446008)(186003)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:PS1PR0302MB2571;H:PS1PR0302MB2604.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1e2oNBN73FsA97Faw1fyJFWVkZlTCsGWnca8Q6zltQhbzdhRacHz47jR6v0/pplmkGyo9iUJIMN3T6vRTnDBdjkhFFezvImtFgr4b7EBdLbQnsSv9LtsIesIBo86zx+Uj6lqk/+obEwUYTTYuQ05WYlbNQocZSk4XlVXlaUEYzi6G1Ro11VfHZk1SQ+pXmkFxR7AM0EWLzBSbNMnq+L/H0t5q2ewHJaxDAcGdRlSVfixPYAjotaAicJsww6ome+Q2vhlSSxKjxOF2CqJ4DqWL92gZj0BZGyEN8NEzVjh/SFEGTjwSFq69P8ZJ5ny71Tog/z/duPpNY4Nmbr+g60esiZRJU70cCafp7+fBVWfTpWMXUHti8bWsNCZDM9YJ4/dNujV2nixMTf5xlHp/Munc3tZi2L1s6v1Kf08iOc+Og+Q3gGDnad9uFFwYP8j0tHxfxXApRHYBSP8zp4enY0MXki+x5+j5/aOGUOxjkH0vyBT32ee1w9lencKw21Rodvp+XZvefOL3yegPlDsl86jLA==
x-ms-exchange-antispam-messagedata: lIu4BOuhcB9MvSKTOfStLmoZbsgr+XzZqHQW0daUfR4kaHYztIDfNJmF/xJDJkFF4zpSLnrVcY27tTfTDiKDH2EdFKVAk5wMltJvA0l1NoFPV++todnxOH34PzCCyu84GEhoxO21gM4rSnKINVCYtQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a379d1-32f0-47dd-6ad3-08d7b6378137
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 19:03:00.0934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygTGUFPqpwF2EgoMAZXebUOIK1sdk8CmUJ7qTYcYIpxk/g29azrOEM/+8X0aRQfgpzlZkjkL41sLMDLUKUGBnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0302MB2571
X-OriginatorOrg: lenovo.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFqYXQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFqYXQg
SmFpbiA8cmFqYXRqYUBnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjAs
IDIwMjAgMTozOSBQTQ0KPiA+DQo+ID4gRm9yIHRoaXMgcGFydGljdWxhciBpc3N1ZSB3aGF0IGlz
IHRoZSBiZXN0IHdheSB0byBjb250cmlidXRlIGFuZCBnZXQNCj4gPiBpbnZvbHZlZD8gV2UnZCBs
aWtlIHRvIG1ha2UgaXQgc28gZVByaXZhY3kgY2FuIGJlIHVzZWQgbW9yZSBlYXNpbHkgZnJvbQ0K
PiA+IExpbnV4LiBJIGFncmVlIGEgbW9yZSBnZW5lcmljIHdheSBvZiBjb250cm9sbGluZyBpdCB3
b3VsZCBiZSBnb29kLg0KPiA+IEkgbG9va2VkIGF0IHRoZSBwcm9wb3NlZCBwYXRjaCBmcm9tIFJh
amF0DQo+ID4gKGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzEwLzIyLzk2NykgLSBpdCBzZWVt
cyBsaWtlIGEgZ29vZCBzb2x1dGlvbiB0byBtZS4NCj4gPiBXZSBjYW4gaGVscCB3aXRoIHRlc3Rp
bmcgdGhhdCBvbiBvdXIgcGxhdGZvcm1zIGlmIHRoYXQgd291bGQgYmUgdXNlZnVsLg0KPiANCj4g
VGhhbmtzIHlvdSwganVzdCBzbyB0aGF0IHlvdSBrbm93LCB0aGUgbGF0ZXN0IHBhdGNoc2V0IGlz
IGF0Og0KPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS8xMi8yMC83OTQNCj4gDQo+IEl0IHdv
dWxkIGJlIGdyZWF0IHRvIGdldCBzb21lIGFkZGl0aW9uYWwgdGVzdGluZyBpZiBwb3NzaWJsZS4g
SSBjYW4NCj4gc2VuZCBhIHNhbXBsZSBBQ1BJIChmb3Igb3VyIHBsYXRmb3JtKSBpbiBjYXNlIGl0
IGhlbHBzLg0KPiANClNvdW5kcyBnb29kIC0gd2UnbGwgZGVmaW5pdGVseSB0cnkgdGhpcyBvdXQg
YW5kIHNlZSBob3cgaXQgZ29lcy4gSSBzdXNwZWN0IHdlJ2xsIGhhdmUgc29tZSBxdWVzdGlvbnMg
b25jZSB3ZSB0cnkgaXQgb3V0IGFuZCBnZXQgbW9yZSBmYW1pbGlhci4NCg0KPiA+DQo+ID4gSSBu
ZWVkIHRvIHVuZGVyc3RhbmQgaG93IHdlIGNvbm5lY3QgdGhhdCBpbXBsZW1lbnRhdGlvbiB3aXRo
IHRoZSBBQ1BJDQo+ID4gY29udHJvbHMgd2UgaGF2ZSAoYXMgSSBiZWxpZXZlIHdoYXQgd2UgaGF2
ZSBhcmUgdGhpbmtwYWQgc3BlY2lmaWMgYW5kIG5vdCB0bw0KPiA+IGEgZHJtIHNwZWM7IHdlIG5l
ZWQgdG8gY29uZmlybSB0aGF0KS4gV2UgYWxzbyBoYXZlIHRoZSBBQ1BJIGV2ZW50cyB0aGF0DQo+
ID4gbm90aWZ5IGlmIGVQcml2YWN5IHdhcyBjaGFuZ2VkIGJ5IHRoZSBob3RrZXlzIGFuZCB0aGF0
IHNlZW1zIGxpa2Ugc29tZXRoaW5nDQo+ID4gdGhhdCBzaG91bGQgYmUgZG9uZSBpbiB0aGlua3Bh
ZF9hY3BpLmMgYW5kIG5vdCB0aGUgZHJtIGNvZGUuDQo+ID4gDQo+ID4gTm90IHN1cmUgaWYgdGhl
IHR3byBuZWVkIHRvIGJlIGNvbm5lY3RlZCBzb21laG93IChvciBpZiBoYW5kbGluZyB0aGUNCj4g
PiBldmVudCBpcyBhY3R1YWxseSBub3QgaW1wb3J0YW50IGFuZCBwb2xsaW5nIGlzIGFjY2VwdGFi
bGUpPw0KPiANCj4gU28gdGhlcmUgd2FzIHNvbWUgYnJpZWYgZGlzY3Vzc2lvbiBhYm91dCB0aGlz
IG9uIG15IHBhdGNoZXMgLSBidXQNCj4gYXRsZWFzdCBvbiAgdGhlIHBsYXRmb3JtcyBJIGhhdmUg
c2VlbiwgdGhlcmUgd2FzIG5vIHdheSB0byBjaGFuZ2UgdGhlDQo+IHByaXZhY3kgc2NyZWVuIG91
dCBvZiBzb2Z0d2FyZSAvIGtlcm5lbCBjb250cm9sLiBFc3NlbnRpYWxseSwgaWYgdGhlcmUNCj4g
YXJlIGhvdGtleXMsIHRoZXkgd291bGQgc2VuZCBhbiBpbnB1dCBldmVudCB0byB0aGUga2VybmVs
LCB3aG8nZCBzZW5kDQo+IHRoZW0gdG8gdXNlcnNwYWNlLCB3aG8nZCB1c2UgdGhlIERSTSBtZXRo
b2QgdG8gdG9nZ2xlIHRoZSBwcml2YWN5DQo+IHNjcmVlbi4gVGh1cyB0aGUgY3VycmVudCB2ZXJz
aW9uIG9mIHRoZSBwYXRjaCBvbmx5IHN1cHBvcnRzDQo+IGNvbnRyb2xsaW5nIHRoZSBwcml2YWN5
IHNjcmVlbiB2aWEgc2V0KCkgbWV0aG9kLiBUaGUgZ2V0KCkgbWV0aG9kIGp1c3QNCj4gcmV0dXJu
cyB0aGUgY2FjaGVkIHZhbHVlLkkgaG9wZSB0aGF0IHdvcmtzIGZvciB5b3UuDQo+IA0KT0sgLSBv
biB0aGUgdGhpbmtwYWRzIHdlIGhhdmUgZnVuY3Rpb24rRCBhcyBhICdob3RrZXknIHRvIGNvbnRy
b2wgdGhlIGZlYXR1cmUuLi5hbmQgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGJ5cGFzc2VzIGV2
ZXJ5dGhpbmcgYW5kIGdvZXMgc3RyYWlnaHQgdG8gdGhlIGZpcm13YXJlLg0KDQpUaGUgY2hhbmdl
cyBOaXRpbiBoYWQgYmVlbiB3b3JraW5nIG9uIGluIHRoaW5rcGFkX2FjcGkuYyB3YXMgdG8gbWFr
ZSB0aGlzIG1vcmUgTGludXggYW5kIGZyaWVuZGx5IC0gcHJvdmlkZSBhIHN5c2ZzIGhvb2sgZm9y
IHVzZXIgc3BhY2UgdG8gY29ubmVjdCB0byB3aXRoIHRoZSBhaW0gb2YgYWxsb3dpbmcgaXQgdG8g
YmUgY29uZmlndXJlZCBmcm9tIHVzZXIgc3BhY2UgYW5kIGhhdmUgb24gc2NyZWVuIGRpc3BsYXkg
d2hlbiBpdCB3YXMgdHJpZ2dlcmVkIGV0Yy4NCg0KSSdtIHBlcnNvbmFsbHkgbm90IHN1cmUgeWV0
IGhvdyB0aGlzIHRpZXMgdXAgd2l0aCB0aGUgRFJNIG1ldGhvZCAtIG1vcmUgZGlnZ2luZyByZXF1
aXJlZC4gSSdtIGludHJpZ3VlZCB0byBzZWUgaWYgaXQgd29ya3Mgb24gb3VyIHN5c3RlbXMgKHNh
ZGx5IEkgZG9uJ3QgaGF2ZSBhbnl0aGluZyB3aXRoIHRoYXQgZmVhdHVyZSBhdmFpbGFibGUgb24g
bXkgZGVzayByaWdodCBub3cuLi5JIG5lZWQgdG8gZ2V0IG15IGhhbmRzIG9uIG9uZSkNCg0KVGhh
bmtzDQpNYXJrDQo=
