Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2308BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEA0206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="I/7C9ifK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgFEMHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:07:16 -0400
Received: from mail-eopbgr1400129.outbound.protection.outlook.com ([40.107.140.129]:6162
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgFEMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:07:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwoadoWjzdZAaNpCi6LT4EkX9D5+89+YdHR80JqmJ7ktt2+gVe3VT8A3T14T1FpkdsKO/F3tWanvZfqSy1qgeI+FQjOKJ6wUHGtxnlId7znl8VVb19BNg+nUkKDbVrAfvpGYEf/v2zzq4lkfsBKPl6XlZ/1jMohYsE0eT8YbxI9tQ8uMqK3hl//ZMIaqhKHlWEWYoM8pqFIEWg7bts62ErEH31NUskaHqWWzM7ZmhGp6wMzqIHBV7EBro03dve8qdgjEnzF6QVjLK2cdhwAxL+NLyCiL523SXhV7VQA16joa+CYr95iS5stG4hH3k8qmtyep51vNYgyHm5yd1pkv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eogpcvYuulhMoSV5A7/PjiOap7kPMNnXwz33uriwbrk=;
 b=R7wZjfNHFkarWileTA8jRmIgIO1pmbxW0kpCl5SDJxVZDesPpkz3c4lYau896MG84MnCoMvgMXBep8XQQjo59kCmqhNgsbYKa/jTsXIHti4IcdO33KJ2R4HW7rNz4AOqlnW3zzvrijWeJKLYh1J9BrkEc29KxwljJwxWcOIyv4pOlpHGHh+v+217dk9FxME1GsQSHA4oy+AjYX5WH3oDf93gOKrz7E3F+wonBG4UFTCBNH6AOU3Y7tGsAX4YDJkkbsMo1wbUv+d2qoHQ1zc/4nltmyeGq9zhBiP1IeJeF/nJ4Er1WimlveJqxN3IDoONKvNCQHyLQKe2HJQ8Xj5+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eogpcvYuulhMoSV5A7/PjiOap7kPMNnXwz33uriwbrk=;
 b=I/7C9ifKFecflVaSod/Vy3py5y8+FBc6u4OAzmMr9ZLa4owV5Wzzz1/U0PnfXfS8zBYz8MXOPHcJHX+ZvI656iA2HDfLpBYjUXHW04E8JGF1EP6aWxVRgFFkUghvTR2FFX7R8DIZOe0R3/6zGW0RP2o57Tcbzm3Yqg3osm89GnE=
Received: from TYXPR01MB1503.jpnprd01.prod.outlook.com (2603:1096:403:e::12)
 by TYXPR01MB1728.jpnprd01.prod.outlook.com (2603:1096:403:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Fri, 5 Jun
 2020 12:07:10 +0000
Received: from TYXPR01MB1503.jpnprd01.prod.outlook.com
 ([fe80::6508:8e66:164c:3dbe]) by TYXPR01MB1503.jpnprd01.prod.outlook.com
 ([fe80::6508:8e66:164c:3dbe%7]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 12:07:09 +0000
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
        <pawan.kumar.gupta@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/speculation: Check whether speculation is force
 disabled
Thread-Topic: [PATCH] x86/speculation: Check whether speculation is force
 disabled
Thread-Index: AdY5cwNjHOfD1WXzRFK+VbW3aFu0ZgASi0kAACClRRAAErYHAAApscfA
Date:   Fri, 5 Jun 2020 12:07:09 +0000
Message-ID: <TYXPR01MB150388D14E054374FDB760EDF5860@TYXPR01MB1503.jpnprd01.prod.outlook.com>
References: <TYXPR01MB150318D484EE220452A5085AF5880@TYXPR01MB1503.jpnprd01.prod.outlook.com>
 <d0356d0a-83dd-f3ae-c0ba-82089976c014@redhat.com>
 <TYXPR01MB1503D6F73C6356DED5D2C849F5890@TYXPR01MB1503.jpnprd01.prod.outlook.com>
 <b7242c5d-f667-1cdb-19ff-8f7ee06b9e7d@redhat.com>
In-Reply-To: <b7242c5d-f667-1cdb-19ff-8f7ee06b9e7d@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [211.125.130.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: faf33cc1-463e-4a29-62df-08d80948f955
x-ms-traffictypediagnostic: TYXPR01MB1728:
x-microsoft-antispam-prvs: <TYXPR01MB1728E85A4BD9FC86B3B63185F5860@TYXPR01MB1728.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 60Z0IXdtM/TknaLTEYlh4NuwRIlvvLPgIlGrK3uesdOOj5xwbK/JI5z82IQ65k4CQ9VIImzO/0ZELmAfMX5Zlemw/G6s/TLhiPLfAvGvVQegQvA/12s4bwQMSP8xZrkLaGC/Wg4QR6a3KQMTg9/CPC1AeruOYMNFhdUPY1nPRkvzwSD55CsIwvDVXDELUEh1F+B7nAtHjNKD7lvwBbBsxMzvKNuh04YO3jyuxGLLswkDArm3WuCg29/lEKf1XIyAM0u4LrUbZ15+mgUd9lOzpE9qXwWI/eKaVhrCyDneYnmTeB0T3xqsfuPp8tTSJVhNotg6osRnDuYJW4fUMBjMCT8bNU7Rl8mYaGKAkvc4l08LL8m16jqwZ+ad1j39pQ2OmPVNfM3C+3grlmCQa4crdod7R1OoKplvii4lumxI1HIh10xK3tiXVimLZtV5l8kE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1503.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(53546011)(66476007)(76116006)(66556008)(478600001)(8936002)(66946007)(966005)(110136005)(26005)(71200400001)(316002)(4326008)(7696005)(33656002)(2906002)(52536014)(9686003)(6506007)(66446008)(83380400001)(64756008)(8676002)(86362001)(5660300002)(186003)(55016002)(7416002)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WYy7TntdknVUE5wC+zCt2RMkobiXvBbeOU6C1nCQWHxvdRmxaGeZOElC7AWU+U5LnmpnBzJe3wbRZlTmL9DfKil0aaRa/+sB6IzaoEqAdE1I9Nwjy76xj2MtpxEhH676DR3oqajSFnSxl1zUxoplZdTd/WMPy0XeUeBgN/vsg3W+GLYRpnzNb7GL1Su5Kh61N8YveFVd1wm7Aj1c8v86QZGo6o6EC+WYUpM/k7D1IwYcs+uaZ5wkfAA/YkozKELZhQ4ggSo0CVLuC9gYYPiPOtNFCDS5DqcXyKPPplGTvG9yedG2qZxitQAmV3DLlo03TiTuafw68Ddej+0oSocs3kEvLhOSEugRQ/UtqOdDxRDDPjgQ1tXBYmJO+YeZJkD36GA5CJ0Iz1o9Ta3vOjiLmiOqvfoKENaJJALoG0+SFcoRzIgSNNf7srQdf/Rr1cNIMDBAHuSNjr8y6tld0SZESSjQvjWhQwt//4vRVmZ22YKTOSTJFHQdiSx1zy3p8/f2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf33cc1-463e-4a29-62df-08d80948f955
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 12:07:09.6204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZ49XpLohxgIb3QTYet3lBE/MMztnUF/3ay8kfQonLUIGZDAjUHeJtXsXoF2qvXOpyVOJd457ijcEHeJjgqJzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSdtIHNvcnJ5IGJ1dCBJIGNvdWxkIG5vdCBmaW5kIHRoZSByZWFzb24gb2YgYWJvdmUgY29tbWVu
dHMuDQpJIGludmVzdGlnYXRlZCB0aGUgYmVsb3cgbG9nIGFuZCBJIHRob3VnaHQgaXQgd2FzIHVu
aW50ZW50aW9uYWwNCmFuZCB0aGUganVzdCBidWcgYXQgdGhlIG1vbWVudC4NCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAxODExMjUxODUwMDUuODY2NzgwOTk2QGxpbnV0cm9uaXguZGUv
DQoJDQojZGVmaW5lIFBGQV9TUEVDX0lCX0ZPUkNFX0RJU0FCTEUJNgkvKiBJbmRpcmVjdCBicmFu
Y2ggc3BlY3VsYXRpb24gcGVybWFuZW50bHkgcmVzdHJpY3RlZCAqLw0KDQpCdXQgdGhlIGNvbW1l
bnQgb2YgUEZBX1NQRUNfSUJfRk9SQ0VfRElTQUJMRSBhcHBhcmVudGx5DQpleHBsYWlucyB0aGUg
ZXhwZWN0ZWQgYmVoYXZpb3IuDQpBbmQgaXQgaXMgb25seSBuYXR1cmFsIHRoYXQgdXNlcnMgY2Fu
IGZvcmNlIGRpc2FibGUgdGhlIHNwZWN1bGF0aW9uDQpiZWNhdXNlIG9mIHNlY3VyaXR5Lg0KDQpJ
J2xsIGludmVzdGlnYXRlIG1vcmUgdG8gZXhwbGFpbiB0aGlzIHBhdGNoIGlzIG5lZWRlZC4NClRo
YW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogV2FpbWFuIExvbmcgPGxvbmdtYW5AcmVkaGF0LmNvbT4gDQpTZW50OiBGcmlkYXksIEp1
bmUgNSwgMjAyMCAxOjEwIEFNDQpUbzogVGFkYSwgS2VudGEgKFNvbnkpIDxLZW50YS5UYWRhQHNv
bnkuY29tPjsgeDg2QGtlcm5lbC5vcmc7IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0
LmNvbTsgYnBAYWxpZW44LmRlOyBocGFAenl0b3IuY29tOyBqcG9pbWJvZUByZWRoYXQuY29tOyBw
ZXRlcnpAaW5mcmFkZWFkLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsgcGF3YW4ua3VtYXIuZ3Vw
dGFAbGludXguaW50ZWwuY29tDQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3Vi
amVjdDogUmU6IFtQQVRDSF0geDg2L3NwZWN1bGF0aW9uOiBDaGVjayB3aGV0aGVyIHNwZWN1bGF0
aW9uIGlzIGZvcmNlIGRpc2FibGVkDQoNCk9uIDYvNC8yMCAzOjI5IEFNLCBUYWRhLCBLZW50YSAo
U29ueSkgd3JvdGU6DQo+PiBJdCBjb25mbGljdHMgd2l0aCB5b3VyIG5ldyBjb2RlLiBXZSBjYW4g
aGF2ZSBhbiBhcmd1bWVudCBvbiB3aGV0aGVyIA0KPj4gSUIgc2hvdWxkIGZvbGxvdyBob3cgU1NC
IGlzIGJlaW5nIGhhbmRsZWQuIEJlZm9yZSB0aGF0IGlzIHNldHRsZWQsDQo+IFRoYW5rIHlvdSBm
b3IgdGhlIGluZm9ybWF0aW9uLg0KPiBJdCBjb25mbGljdHMgYnV0IEkgdGhpbmsgdXNlcnMgd2hv
IHJlYWQgdGhlIGJlbG93IGRvY3VtZW50IGdldCBjb25mdXNlZC4NCj4gRG9jdW1lbnRhdGlvbi91
c2Vyc3BhY2UtYXBpL3NwZWNfY3RybC5yc3QuDQo+DQo+IEVzcGVjaWFsbHksIHNlY2NvbXAgdXNl
cnMgbXVzdCBrbm93IHRoZSBkaWZmZXJlbmNlIG9mIHRoaXMgaW1wbGljaXQgDQo+IHNwZWNpZmlj
YXRpb24gYmVjYXVzZSBib3RoIElCIGFuZCBTU0IgYXJlIGZvcmNlIGRpc2FibGVkIA0KPiBzaW11
bHRhbmVvdXNseSB3aGVuIHNlY2NvbXAgaXMgZW5hYmxlZCB3aXRob3V0IFNFQ0NPTVBfRklMVEVS
X0ZMQUdfU1BFQ19BTExPVyBvbiB4ODYuDQoNCldoYXQgSSBhbSBzYXlpbmcgaXMgdGhhdCB5b3Ug
aGF2ZSB0byBtYWtlIHRoZSBhcmd1bWVudCB3aHkgeW91ciBwYXRjaCBpcyB0aGUgcmlnaHQgd2F5
IHRvIGRvIHRoaW5nIGFuZCBhbHNvIG1ha2Ugc3VyZSB0aGF0IHRoZSBjb21tZW50IGlzIGNvbnNp
c3RlbnQuIFlvdXIgY3VycmVudCBwYXRjaCBkb2Vzbid0IGRvIHRoYXQuDQoNCkNoZWVycywNCkxv
bmdtYW4NCg0K
