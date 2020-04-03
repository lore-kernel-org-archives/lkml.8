Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08331C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33162080C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="daN7DD5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404025AbgDCQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:48:44 -0400
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:20827
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728095AbgDCQso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:48:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmiCaj7LC6mSGvTa7HUfAY+xudGxMuPyQlejH6U0G1NoGmXgxg1YSw6XPxWB45LZ/yUxhjGf4CSNioyy2YicEUb21g4+hJCcJM3PUkT9IVN4FR9SRxkLzE2/QZlKM6/bt/cQWd17kLS3S/BepQhj4SFWTO5YL3O0gF2AF8e97sUIjl8Jev3bip32psARUT66B3J2h+/HwD5yevGX2gPBP5Ve5kysXDsub8M4SQEfwFcpaeQnoD9SllmG6IqxiayJuNPIq9VoJbSkZpO0s51B/6pNEJ4GttMmAoi5MyYs+wKZ/DCPVgz3S8/RMXrgspevqzq6gvdSbXmnBtHf1EZmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4rAZrJ1cZK3xCdo8NLdl5FJ4GiS7fh1ZCOvkqbTQ8w=;
 b=DouUkK1WrvYtyK4eHrmGetcJebneBYXeKtk00yrt9MZOrts+TLgudFZ2UhW+lCs3nSO24zVmKGHRU48+X2ggPeDulRsjggcePoyc+MQ06qvHbIMAq1OPevcF0yJhk6jTBjbaMZWxqMc/PXk8ehQyklvkRUYbiVTK/dmsHIjTRdfiQbLLdV3v+M3/adby5iiCMlP6GczRHTcN/l7ZCoiBJo99Utfc1RBfQNImH8/O3GMa9yJaaVGTNoZsTaoNuLCM5ZyYYs2Jx7cbgk0hKuxwZDAa/+iEfPzFHrfz3eIH3OlUa42isjLJJSWPL9wYVMjWI1oNiV1ZfiGc92Jh+WqTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4rAZrJ1cZK3xCdo8NLdl5FJ4GiS7fh1ZCOvkqbTQ8w=;
 b=daN7DD5Aj6BLT7vvUtLDk7fPaI8WYj9bP5+y/OYuvoZTEGjrBWKir9WT9UfT2YVFDwCPRAhAd6BlrLucri+Zab7i0Q5DQTkFpyKk9tU/gvwiox5ZinsQGQDxZDUNZ7OjdAFQsSkBuykFdEX+/i8B15ceSsAeobC4nN2FV3LBLD8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4149.namprd05.prod.outlook.com (2603:10b6:a02:92::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.13; Fri, 3 Apr
 2020 16:48:35 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331%2]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 16:48:35 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Thread-Topic: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Thread-Index: AQHWCO7USTPzjZYgiU62wH3ltW4496hmfuWAgAD5WQCAAA0fAIAACysAgAAC1oCAAAPdgIAABDQAgAACIAA=
Date:   Fri, 3 Apr 2020 16:48:35 +0000
Message-ID: <FF9F1233-1312-4B98-A476-0C20D92200E3@vmware.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk>
 <20200403143459.GA30424@linux-8ccs>
 <20200403152158.GR20730@hirez.programming.kicks-ass.net>
 <20200403160156.GA2701@linux.intel.com>
 <20200403161205.GT20730@hirez.programming.kicks-ass.net>
 <20200403162555.GB2701@linux.intel.com>
 <20200403164058.GX20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200403164058.GX20730@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4700:9b2:4cb3:3701:a401:9c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f84f1cf7-aa75-4edb-3c75-08d7d7eed9e9
x-ms-traffictypediagnostic: BYAPR05MB4149:|BYAPR05MB4149:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4149CCBC3F2FB473A80D1AF3D0C70@BYAPR05MB4149.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(7416002)(81166006)(8676002)(478600001)(316002)(36756003)(86362001)(6512007)(81156014)(8936002)(2616005)(54906003)(6506007)(2906002)(53546011)(4326008)(66946007)(186003)(6916009)(66446008)(6486002)(71200400001)(33656002)(5660300002)(66476007)(76116006)(66556008)(64756008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lp0PZGwzo5iwfliScncRAFZACMj1aNuz7qt+kpanu0l6jjHpmnDiHgwjdG+6prBk/KYkjef4wcQ0lCJSqCbzOllVwQh9DVz86jFIr7whxgNabKb8PiytKKLw43gTueUd9JT1pWuzOOshn45KmG1R5maV2ZHvsL/1pd7PHjH5KhlsmyP1YC0CRHa3jry65aJGngGvZq72FIc8f2xupUCfRSZjMYrl4YA093xenn+8xMzNUdvO4X45SNzCX0BYYwYXuj57yZUWtL0lTP9F6kyw4QIYBkQYuzHrHfV5YSzT80FPJDjmgbLa5TlTu51SCEGMg8dS8Zxdw2oH5tubA/xMZOzsQKXylVMBpb5IMduhDBHb0fTdDRiHipH2qPFqVgWiXZOlZAWsLcRp5U1uh2KFHjD5wdxcqTkYcRe6B9Cn7n1uLS5R0wtjp2SvS2Ptvp3F
x-ms-exchange-antispam-messagedata: xwoNGRCdiU2fFt5NyhmhyfHz5DXFuZ1FqG9TGdkJENYzDWVY+uzrNWbQTcasFml/onVQ3CgT1A1VZto2CTWi5N48t7yw0YejcKJr0m5nj5/ogcfrhGHwOedEHmtuUcDcf9YOkR4yKDoagnkH/HL9bEkHEHpMLJQvhfi1MzWwK5LxYFRvI/yCG1jmvATfdA1um1C4lNxxoe/AsAVRTQFlfQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A19451ADEBF8D341A751BB6D578C79EE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84f1cf7-aa75-4edb-3c75-08d7d7eed9e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 16:48:35.2275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +k1Y5q3X0BIaW8FL4skOPnth/8fRU6l4MhVtJcsQDapEJIRcBr/Vkm9LfM3rwdIEJWyqfgVYXb/SPsnpAyZMUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBcHIgMywgMjAyMCwgYXQgOTo0MCBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgQXByIDAzLCAyMDIwIGF0IDA5OjI1OjU1
QU0gLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+PiBPbiBGcmksIEFwciAwMywg
MjAyMCBhdCAwNjoxMjowNVBNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+PiBPbiBG
cmksIEFwciAwMywgMjAyMCBhdCAwOTowMTo1NkFNIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29u
IHdyb3RlOg0KPj4+PiBPbiBGcmksIEFwciAwMywgMjAyMCBhdCAwNToyMTo1OFBNICswMjAwLCBQ
ZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+Pj4+IE9uIEZyaSwgQXByIDAzLCAyMDIwIGF0IDA0OjM1
OjAwUE0gKzAyMDAsIEplc3NpY2EgWXUgd3JvdGU6DQo+Pj4gDQo+Pj4+Pj4gSSB3b25kZXIgaWYg
aXQgd291bGQgbWFrZSBzZW5zZSB0aGVuIHRvIGxpbWl0IHRoZSB0ZXh0IHNjYW5zIHRvIGp1c3QN
Cj4+Pj4+PiBvdXQtb2YtdHJlZSBtb2R1bGVzIChpLmUuLCBtaXNzaW5nIHRoZSBpbnRyZWUgbW9k
aW5mbyBmbGFnKT8NCj4+Pj4+IA0KPj4+Pj4gSXQgd291bGQ7IGRpZG4ndCBrbm93IHRoZXJlIHdh
cyBvbmUuDQo+Pj4+IA0KPj4+PiBSYXRoZXIgdGhhbiBzY2FubmluZyBtb2R1bGVzIGF0IGFsbCwg
d2hhdCBhYm91dCBob29raW5nIG5hdGl2ZV93cml0ZV9jcjQoKQ0KPj4+PiB0byBraWxsIFNMRCBp
ZiBDUjQuVk1YRSBpcyB0b2dnbGVkIG9uIGFuZCB0aGUgY2FsbGVyIGRpZG4ndCBpbmNyZW1lbnQg
YQ0KPj4+PiAic2xkIHNhZmUiIGNvdW50ZXI/DQo+Pj4gDQo+Pj4gQW5kIHRoZW4geW91J3JlIGhv
cGluZyB0aGF0IHRoZSBtb2R1bGUgdXNlcyB0aGF0IGFuZCBub3Q6DQo+Pj4gDQo+Pj4gIGFzbSB2
b2xhdGlsZSAoIm1vdiAlMCwgY3I0IiA6OiAiciIgKHZhbCkpOw0KPj4+IA0KPj4+IEkgdGhpbmsg
SSBmZWVsIHNhZmVyIHdpdGggdGhlIHNjYW5uaW5nIHRvIGJlIGZhaXIuIEFsc28gd2l0aCB0aGUg
aW50cmVlDQo+Pj4gaGludCBvbiwgd2UgY2FuIGV4dGVuZCB0aGUgc2Nhbm5pbmcgZm9yIG91dC1v
Zi10cmVlIG1vZHVsZXMgZm9yIG1vcmUNCj4+PiBkb2RneSBjcmFwIHdlIHJlYWxseSBkb24ndCB3
YW50IG1vZHVsZXMgdG8gZG8sIGxpa2UgZm9yIGV4YW1wbGUgdGhlDQo+Pj4gYWJvdmUuDQo+PiAN
Cj4+IFlhLCB0aGF0J3MgdGhlIGJpZyB1a25vd24uICBCdXQgd291bGRuJ3QgdGhleSdkIGFscmVh
ZHkgYmUgYnJva2VuIGluIHRoZQ0KPj4gc2Vuc2UgdGhhdCB0aGV5J2QgY29ycnVwdCB0aGUgQ1I0
IHNoYWRvdz8gIEUuZy4gc2V0dGluZyBWTVhFIHdpdGhvdXQNCj4+IHVwZGF0aW5nIGNwdV90bGJz
dGF0ZS5jcjQgd291bGQgcmVzdWx0IGluIGZ1dHVyZSBpbi1rZXJuZWwgd3JpdGVzIHRvIENSNA0K
Pj4gYXR0ZW1wdGluZyB0byBjbGVhciBDUjQuVk1YRSBwb3N0LVZNWE9OLCB3aGljaCB3b3VsZCAj
R1AuDQo+IA0KPiBTYWRseSB0aGUgQ1I0IHNoYWRvdyBpcyBleHBvcnRlZCwgc28gdGhleSBjYW4g
YWN0dWFsbHkgZml4IHRoYXQgdXAgOi8NCg0KSSBkbyBub3QgdGhpbmsgdGhhdCBTZWFu4oCZcyBp
ZGVhIHdvdWxkIHdvcmsgZm9yIFZNd2FyZS4NCg0K
