Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D762082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="K6LWcEU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFQAPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:15:35 -0400
Received: from mail-eopbgr1410099.outbound.protection.outlook.com ([40.107.141.99]:6320
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgFQAPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3ZWcGKnVZOoJm0LkPwx92hGz7NzUtzCOul98BJdRekrBM8cicQEpaEcvDtXfNmRyaqK65uXmBTC/Vsa3Nyj+vRosO9O5GQwLAOxEnphjfQRrA84IUf+b2N9C5+BFAP6k/lOCxfiEnHUYiSJroXqztp8m5hraPffNRF5QNA9CAgJtihbLLas5nTP3AJ7M64KTm7LTf8kigxmUCdTYEZpSbNrY86a/kh3EexhbyDYddR/o4H4CJquQ/Erw8Vrbu+jDLLr2RSMRRmE3ssGlDNPNTZ9G6ZG03wdwQCRSNeXSr7Pv2tN0d6RQRAn7KlXHl7kU86Udal4z+KN8kT71VCAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7VqjXBouL0QsBle2LCVDmMjRtXjanxNMZi2XzINDps=;
 b=MoLtzC0USdC/Z+bAjfyk/8Ou2lSIctfo9vhD+CUwRPqJt8GZJRnNGtEtcaXk8u4FGle1jq4NMB/aOPd5C5krX4QtOXtkvsDBSKbjJ6TPZUkhTpbtIi9uSzMUvaxOLqitdgdTw+6jWopqoU3OU5LPaibDMSoyzKd1yi5Y4WuXAAbf2Unz52i5G6l3B+04ZdDmeEVcggKEZNfV8egdWcn9DXzgGUcL/HDZwyO/LXXptcAQMVvltm4hbXq4dmVmtxGMSJy+1R1ZtNdUmYRxXCVnJtcMgPvo9SrhlJfOsZ4V8sA2LD2G/LdjVk0E+xn+xlMrGYa4yfYSu2QhwQD837tcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7VqjXBouL0QsBle2LCVDmMjRtXjanxNMZi2XzINDps=;
 b=K6LWcEU7bEl9Hf4538jr4hRsMNUYyVGkgMQNsXpxMLrb9z9JSacpLNtZ6LUVencQ+gGZwpfs6p5f0qzHAyvrpFJW934vRhW/js2GYjEK9viRFTTcy6fQ+r/Ett+BqK9tg2/FYxuLTXezfuuvC3U1WjhaeIw4U2zlPuXO/ZRmBe4=
Received: from TYXPR01MB1503.jpnprd01.prod.outlook.com (2603:1096:403:e::12)
 by TYXPR01MB1630.jpnprd01.prod.outlook.com (2603:1096:403:c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Wed, 17 Jun
 2020 00:15:15 +0000
Received: from TYXPR01MB1503.jpnprd01.prod.outlook.com
 ([fe80::6508:8e66:164c:3dbe]) by TYXPR01MB1503.jpnprd01.prod.outlook.com
 ([fe80::6508:8e66:164c:3dbe%7]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 00:15:15 +0000
From:   "Tada, Kenta (Sony)" <Kenta.Tada@sony.com>
To:     Waiman Long <longman@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "asteinhauser@google.com" <asteinhauser@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "Tada, Kenta (Sony)" <Kenta.Tada@sony.com>
Subject: RE: [PATCH] x86/speculation: Check whether speculation is force
 disabled
Thread-Topic: [PATCH] x86/speculation: Check whether speculation is force
 disabled
Thread-Index: AdY5cwNjHOfD1WXzRFK+VbW3aFu0ZgASi0kAACClRRAAErYHAAApscfAAkJ7FbA=
Date:   Wed, 17 Jun 2020 00:15:15 +0000
Message-ID: <TYXPR01MB1503B0B707C7FB39E25D746AF59A0@TYXPR01MB1503.jpnprd01.prod.outlook.com>
References: <TYXPR01MB150318D484EE220452A5085AF5880@TYXPR01MB1503.jpnprd01.prod.outlook.com>
 <d0356d0a-83dd-f3ae-c0ba-82089976c014@redhat.com>
 <TYXPR01MB1503D6F73C6356DED5D2C849F5890@TYXPR01MB1503.jpnprd01.prod.outlook.com>
 <b7242c5d-f667-1cdb-19ff-8f7ee06b9e7d@redhat.com>
 <TYXPR01MB150388D14E054374FDB760EDF5860@TYXPR01MB1503.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB150388D14E054374FDB760EDF5860@TYXPR01MB1503.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [211.125.130.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c3dc858-15cb-4630-3fc8-08d8125382c5
x-ms-traffictypediagnostic: TYXPR01MB1630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYXPR01MB1630840B9C13F6898CAD35EEF59A0@TYXPR01MB1630.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYLxlKGmjBD6ZvsydHb4kWVF9Y22IP1lJcTpnbQW2xzrC78GBxc8sLjnSTLHzfud5B1wIxA9rbNDGYVCPqeQKHue3yj5AB3DrFy6I9+MWB136BssYb7L5LcSTPjoVpl0l3VW8RGAYh+q41Ip6THeMHD+Y/GVOs1gBEqZEXkM5Rm5Yh7CiLS0/vQD9cfOtyLsQhhVqxsnyogJhK5l4G9TjH6DYuCA0tMLg2g/OufYq0xuuGsl4fQTRXwl5bvAcv+YFZSBIBsnwqCMuUcph6upedDHNILG8AEUXdG+2qIM+5vU99BKxm+LqyVe/f0q4G3cL3ir9YBjtH6Z10fPhC74IDe2XK3vIqPw+jh2+YVMdeiJR49ZRz8w8SYN0CGKPzS0nqUyxm6Gl36IZTGaSUKkzdUrsA9qEJyurhtdLzrwzVeertMga9rp0kT5mO+BCeoH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1503.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(66446008)(5660300002)(86362001)(53546011)(2906002)(33656002)(52536014)(26005)(7416002)(6506007)(186003)(64756008)(7696005)(71200400001)(8936002)(83380400001)(55016002)(107886003)(54906003)(8676002)(110136005)(966005)(4326008)(66946007)(66556008)(498600001)(76116006)(66476007)(9686003)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0emMSvh3HjDFrzIIwYukqOy0IDO0+jzmW6cwYL9++vKTdcrbHsiYoMp52yoauE//XmyTgzgNHO2CsK3YqpFgyGmkdEdxp2NhlNaMOdeyw6uWMT+fick3YmthsWKe8n5L1RMGuLt4988/UGtOJzyv4n1td8BKpZCvDAi8l424sWWIaJt9T2H/zhjP46h3H1Znm31vmpLfoZuMZiuekMSXPAg/xzRs/e8N4kQRhpYNunDKOyHQDF555gx2ZztfGy7luPSf34xyJgo3A1nyRXFtEmjGObIssbGx9F2bSpGJBY09Krolc48f7+8CftKEOvqP++7ikT0MDeetn89r59Hv6PxFawQg5WY7/ePJ7v9GRjYvOn3Tn8cS2PbRKd8/8Sj2sQdPgBslx+1keXorglMOc5baa6tm7PFgdbzSlB4InieXdd5BvqxUs318u/muqLi5HDYyRzf50wj1dGd8+h0ImWkCfmxA+RAOwuq4HKmmuku9gK71IDvN2FXcZ/PRoQfG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3dc858-15cb-4630-3fc8-08d8125382c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 00:15:15.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mAfxluGKiyqowulGei6Zmxno2p0AJxCn46kWAkalZ2eN6llYlh/fD39ve+dZ3hE5my61AsZ5WGlGIGh3s4uKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBjb25maXJtZWQgdGhhdCB0aGlzIGlzc3VlIHdhcyBmaXhlZCBpbiB0aGUgYmVsb3cgbmV3IHBh
dGNoDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTI1Mzc5OS8NCg0K
VGhhbmtzLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVGFkYSwgS2VudGEg
KFNvbnkpIA0KU2VudDogRnJpZGF5LCBKdW5lIDUsIDIwMjAgOTowNyBQTQ0KVG86IFdhaW1hbiBM
b25nIDxsb25nbWFuQHJlZGhhdC5jb20+OyB4ODZAa2VybmVsLm9yZzsgdGdseEBsaW51dHJvbml4
LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7IGhwYUB6eXRvci5jb207IGpwb2lt
Ym9lQHJlZGhhdC5jb207IHBldGVyekBpbmZyYWRlYWQub3JnOyB0b255Lmx1Y2tAaW50ZWwuY29t
OyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20NCkNjOiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSRTogW1BBVENIXSB4ODYvc3BlY3VsYXRpb246IENoZWNr
IHdoZXRoZXIgc3BlY3VsYXRpb24gaXMgZm9yY2UgZGlzYWJsZWQNCg0KSSdtIHNvcnJ5IGJ1dCBJ
IGNvdWxkIG5vdCBmaW5kIHRoZSByZWFzb24gb2YgYWJvdmUgY29tbWVudHMuDQpJIGludmVzdGln
YXRlZCB0aGUgYmVsb3cgbG9nIGFuZCBJIHRob3VnaHQgaXQgd2FzIHVuaW50ZW50aW9uYWwgYW5k
IHRoZSBqdXN0IGJ1ZyBhdCB0aGUgbW9tZW50Lg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDE4MTEyNTE4NTAwNS44NjY3ODA5OTZAbGludXRyb25peC5kZS8NCgkNCiNkZWZpbmUgUEZB
X1NQRUNfSUJfRk9SQ0VfRElTQUJMRQk2CS8qIEluZGlyZWN0IGJyYW5jaCBzcGVjdWxhdGlvbiBw
ZXJtYW5lbnRseSByZXN0cmljdGVkICovDQoNCkJ1dCB0aGUgY29tbWVudCBvZiBQRkFfU1BFQ19J
Ql9GT1JDRV9ESVNBQkxFIGFwcGFyZW50bHkgZXhwbGFpbnMgdGhlIGV4cGVjdGVkIGJlaGF2aW9y
Lg0KQW5kIGl0IGlzIG9ubHkgbmF0dXJhbCB0aGF0IHVzZXJzIGNhbiBmb3JjZSBkaXNhYmxlIHRo
ZSBzcGVjdWxhdGlvbiBiZWNhdXNlIG9mIHNlY3VyaXR5Lg0KDQpJJ2xsIGludmVzdGlnYXRlIG1v
cmUgdG8gZXhwbGFpbiB0aGlzIHBhdGNoIGlzIG5lZWRlZC4NClRoYW5rIHlvdSBmb3IgdGhlIHJl
dmlldy4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV2FpbWFuIExvbmcg
PGxvbmdtYW5AcmVkaGF0LmNvbT4NClNlbnQ6IEZyaWRheSwgSnVuZSA1LCAyMDIwIDE6MTAgQU0N
ClRvOiBUYWRhLCBLZW50YSAoU29ueSkgPEtlbnRhLlRhZGFAc29ueS5jb20+OyB4ODZAa2VybmVs
Lm9yZzsgdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7
IGhwYUB6eXRvci5jb207IGpwb2ltYm9lQHJlZGhhdC5jb207IHBldGVyekBpbmZyYWRlYWQub3Jn
OyB0b255Lmx1Y2tAaW50ZWwuY29tOyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20N
CkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSB4
ODYvc3BlY3VsYXRpb246IENoZWNrIHdoZXRoZXIgc3BlY3VsYXRpb24gaXMgZm9yY2UgZGlzYWJs
ZWQNCg0KT24gNi80LzIwIDM6MjkgQU0sIFRhZGEsIEtlbnRhIChTb255KSB3cm90ZToNCj4+IEl0
IGNvbmZsaWN0cyB3aXRoIHlvdXIgbmV3IGNvZGUuIFdlIGNhbiBoYXZlIGFuIGFyZ3VtZW50IG9u
IHdoZXRoZXIgDQo+PiBJQiBzaG91bGQgZm9sbG93IGhvdyBTU0IgaXMgYmVpbmcgaGFuZGxlZC4g
QmVmb3JlIHRoYXQgaXMgc2V0dGxlZCwNCj4gVGhhbmsgeW91IGZvciB0aGUgaW5mb3JtYXRpb24u
DQo+IEl0IGNvbmZsaWN0cyBidXQgSSB0aGluayB1c2VycyB3aG8gcmVhZCB0aGUgYmVsb3cgZG9j
dW1lbnQgZ2V0IGNvbmZ1c2VkLg0KPiBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvc3BlY19j
dHJsLnJzdC4NCj4NCj4gRXNwZWNpYWxseSwgc2VjY29tcCB1c2VycyBtdXN0IGtub3cgdGhlIGRp
ZmZlcmVuY2Ugb2YgdGhpcyBpbXBsaWNpdCANCj4gc3BlY2lmaWNhdGlvbiBiZWNhdXNlIGJvdGgg
SUIgYW5kIFNTQiBhcmUgZm9yY2UgZGlzYWJsZWQgDQo+IHNpbXVsdGFuZW91c2x5IHdoZW4gc2Vj
Y29tcCBpcyBlbmFibGVkIHdpdGhvdXQgU0VDQ09NUF9GSUxURVJfRkxBR19TUEVDX0FMTE9XIG9u
IHg4Ni4NCg0KV2hhdCBJIGFtIHNheWluZyBpcyB0aGF0IHlvdSBoYXZlIHRvIG1ha2UgdGhlIGFy
Z3VtZW50IHdoeSB5b3VyIHBhdGNoIGlzIHRoZSByaWdodCB3YXkgdG8gZG8gdGhpbmcgYW5kIGFs
c28gbWFrZSBzdXJlIHRoYXQgdGhlIGNvbW1lbnQgaXMgY29uc2lzdGVudC4gWW91ciBjdXJyZW50
IHBhdGNoIGRvZXNuJ3QgZG8gdGhhdC4NCg0KQ2hlZXJzLA0KTG9uZ21hbg0KDQo=
