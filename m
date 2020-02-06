Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB040C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7742020720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZevkhdQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBFIHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:07:09 -0500
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:19841
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbgBFIHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:07:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTD+MRzqHbuE3BeXuNA2b05scDfp1ALkt/RCAfRDGjcGlgNrvfGAsVdD5+M/tGbE6rKpNcDEGUr5lP7dS0ynxegeEPr82/nZF5nPzNrcMluco7rEGP0E1IOsv7bPfTt7gUbv59T2/2ns71KZdKUzkMpmbiXnM9xGsCKJhjVqLG4NltNy4ynMGLLcHEEPUZDpvb2zdEn1t6obaKw1UYAMeijJR5hm5u3qM0AFs1XVw1nFtBsGXak/Z20Eka8uPeJ5GgbiTlCqXaKywZKB/otlDEqn+wsQbarqqDB/yuOKyeEIioqLV1rQsHEnoFrzhHEhUIo+sf+SEsB5kO1A2gJmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqRw5X/KuYMAxZMNY2EF0oSUTXRToiN4F8o+Bl239JY=;
 b=NF2yQIZk15jcuXPLUSqqukCk/oTP41EjlqXIODXoP2RU5hOINiAaVtObI6FDHCHP+5CbjcRoMf+VHwY4FJ2zHSACggbv8iMDE+xfAj3IKnDOZDdbae46FR2Vm9X4yqwcaOqiF3lSZoGaBPFvUrhme+m/VEDo0PsROMyPdxRgJAYAdSFdrPtlMF/L9G8t461LA1B9loFjJH3m7Z8jkBbCVi07tGNoEn9kgQ/c+92SzR0o8w0WT9kClDAnh7mMvkhY/d2DEZVi4qfmytdw/iAl1ZYCBqtu45nquU+uM5h0txIy4Fk2DT2cYmgf9CvJxBSrD/lVXAoLW4TPKNFikRIdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqRw5X/KuYMAxZMNY2EF0oSUTXRToiN4F8o+Bl239JY=;
 b=ZevkhdQ74J5pzv9M9kmHyHwNPt4YaufcjeKNSJ8fln41uJsoHx+ngGGRHL7UeWGUcfQWX5ArjC58KeRxQf71UHFToppc/c2Ecrw9poSL+C5Pq7f/xenxJht8OvWxzhNOCarKt/um9p1gL3KJWeaWiDA1BsabUnJSQcBY2ISUs3Q=
Received: from MN2PR02MB5727.namprd02.prod.outlook.com (20.179.85.153) by
 MN2PR02MB5935.namprd02.prod.outlook.com (20.179.86.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34; Thu, 6 Feb 2020 08:07:06 +0000
Received: from MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::e09d:a160:5349:8ed0]) by MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::e09d:a160:5349:8ed0%6]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 08:07:05 +0000
From:   Mubin Usman Sayyed <MUBINUSM@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>
Subject: RE: [PATCH v2] irqchip: xilinx: Add support for multiple instances
Thread-Topic: [PATCH v2] irqchip: xilinx: Add support for multiple instances
Thread-Index: AQHV3C2hje5zExnZvkGSFN2foWGvfagMpPiAgAAK8gCAAR9x8A==
Date:   Thu, 6 Feb 2020 08:07:05 +0000
Message-ID: <MN2PR02MB5727F7A38A05B58C84672623A11D0@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <1580911535-19415-1-git-send-email-mubin.usman.sayyed@xilinx.com>
 <e0d01341ac5c417982da48074972f470@AcuMS.aculab.com>
 <06caee69-38a2-13d2-d7b1-d882e7438057@xilinx.com>
In-Reply-To: <06caee69-38a2-13d2-d7b1-d882e7438057@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MUBINUSM@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fa8e24d-8c2c-49a7-2163-08d7aadb8e67
x-ms-traffictypediagnostic: MN2PR02MB5935:|MN2PR02MB5935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB593529B8BB7A2FEE4989A976A11D0@MN2PR02MB5935.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(189003)(199004)(5660300002)(52536014)(76116006)(107886003)(4326008)(33656002)(71200400001)(478600001)(66946007)(66476007)(66556008)(186003)(64756008)(66446008)(316002)(53546011)(26005)(7696005)(6506007)(81166006)(8676002)(81156014)(8936002)(86362001)(110136005)(54906003)(55016002)(2906002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB5935;H:MN2PR02MB5727.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MK5UQM/XKYvke1UdBu1ziNh9CyLgH7+L0jh0j4lEej8aycrPagDTWQAHXKJt2a+6y/ejf2P1EX2ZCqRBO2cf/ceaB9WqYw3lQ8w5SKtzPqXMaBWxaocC1RELFWe8/D2zJooM/tUvm3SaZ7gBqTw4XSuWCsGqC6BNt3Z+0WOFTW3XX2uNfXvYuSBUVwmfeV+NY0rIY6rnZ/gE0OMQDPcWxvQyJm/jBeKoAqkZ7qaovVNusD01GudgeW6MEf/E5Nd7q/jiQrTL8r8P/9SBENJrGNkluo+7KZ74L27QgFwnMvkcMX3L/wFpJETwMzZ+lHVlYZrgxMUEgrzukIu/XaB3Ci3lNNcsDlzYj4EgbhTODMnWqSIsg93E8CcAPJSWiz5Ycgyswh7zZAvROwicVKPLLPn14tpZ07QV1lTMwLpRUiAM7Qqc++S4/46PKnQoZi46
x-ms-exchange-antispam-messagedata: LAeYgdbg8NH3nUSsgSpz1XyPLdGn76iILfGjaEKL8TLG0Op7G6pTM+/yjQxGzANw37igHzklsI16LHzy/47cbQQXkobsscXtKN2JGRmm7SyL0soMDGkIP/wALv2Cbt3nsqLZ3flKJ14aKMAVA7yvIA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa8e24d-8c2c-49a7-2163-08d7aadb8e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 08:07:05.6249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdtnjIwG6XSIYNlEpnhFpdgy87RM+IYOhjDS5ClTe8Lg3CTUkONfnxcIHUaW4VEUt+LdX9XqU7xMKqp6NvTxrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWwgU2lt
ZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5
IDUsIDIwMjAgODoyNCBQTQ0KPiBUbzogRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAQUNVTEFC
LkNPTT47IE11YmluIFVzbWFuIFNheXllZA0KPiA8TVVCSU5VU01AeGlsaW54LmNvbT47IHRnbHhA
bGludXRyb25peC5kZTsgamFzb25AbGFrZWRhZW1vbi5uZXQ7DQo+IG1hekBrZXJuZWwub3JnOyBN
aWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNp
dmEgRHVyZ2EgUHJhc2FkIFBhbGFkdWd1DQo+IDxzaXZhZHVyQHhpbGlueC5jb20+OyBBbmlydWRo
YSBTYXJhbmdpIDxhbmlydWRoQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJd
IGlycWNoaXA6IHhpbGlueDogQWRkIHN1cHBvcnQgZm9yIG11bHRpcGxlIGluc3RhbmNlcw0KPiAN
Cj4gT24gMDUuIDAyLiAyMCAxNToxNSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+PiBUaGlzIGVt
YWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGludGVuZGVkIGZvciB0aGUgc29sZSB1c2Ugb2Yg
dGhlDQo+ID4+IG5hbWVkIHJlY2lwaWVudChzKSBhbmQgY29udGFpbihzKSBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24gdGhhdCBtYXkNCj4gPj4gYmUgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQgb3Ig
Y29weXJpZ2h0ZWQgdW5kZXIgYXBwbGljYWJsZSBsYXcuIElmDQo+ID4+IHlvdSBhcmUgbm90IHRo
ZSBpbnRlbmRlZCByZWNpcGllbnQsIGRvIG5vdCByZWFkLCBjb3B5LCBvciBmb3J3YXJkIHRoaXMN
Cj4gZW1haWwgbWVzc2FnZSBvciBhbnkgYXR0YWNobWVudHMuIERlbGV0ZSB0aGlzIGVtYWlsIG1l
c3NhZ2UgYW5kIGFueQ0KPiBhdHRhY2htZW50cyBpbW1lZGlhdGVseS4NCj4gPg0KPiA+IERlbGV0
ZWQuLi4uLg0KPiANCj4gOi0pIEkgZ290IHR3byBjb3BpZXMuIE9uZSB3aXRob3V0IGl0IDotKQ0K
PiANCj4gTXViaW46IFBsZWFzZSBmaXggaXQuDQoNClNvcnJ5LCBJIG1pc3NlZCB0byAgZml4IHRo
YXQgZm9vdGVyLCAgd2lsbCBkbyBpdCBmcm9tIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KTXVi
aW4gDQo+IA0KPiBUaGFua3MsDQo+IE1pY2hhbA0K
