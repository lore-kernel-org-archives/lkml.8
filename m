Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D01C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102E32074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="T/g2mjMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgCZQms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:42:48 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:34048
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgCZQmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:42:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFbUt3/htjrE34SyS3ButGg4l5Scs4P56pxIJPDhCtOtfn3GauiVCehn1J3NS0FzTT4gXLwgUtLp3mqxsiXsS9rC2vHdL/gF0ciA2VuBzHRsSC93utIUSonfKXVuM2N+iZgXKrNbjBKXzQq3cJgIFwo7nhIhaD+VoNHTfmm0l4pBSzJBUkPiY3HHpoU19mWz/ZzusVo1mdcLqukCMHov0PlFSnInpNiJ2g+zGhoebwkQ9u5tA1Udpph400atJuyYzqbyaajmY3xytT+f9VjNUygGFmLlZFmnzPu7jJPX4/RLYvfq3oIcQGak+WsOE6u7FdPI/n9mvWt9b017Go7hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPbRMeaGIbGTtpxIygSBUzaOBCJmNGV2Zsh0aLYUo78=;
 b=kvI9GFhud5bE8MG6gVk7Q31b3SZa7Ltuy8SVhJHR+NslzJ1pV8dMH1cmIbeHITV2oXw2qhHJOf0qiXGUrSwJKebb3+9/V4jumE7ldShC7ua1a+iNEfVapzXyoktjZ+Obs6LT6ihhDQgEMUlg1zjFVRf2DrK1FhXIBztSMcVpnFqhrVpt4gLEbhGTzhdU6N0tVjlwiLRZNiDky2QovC7sgKqPq09i7Nsx4v8HThmh4+0ytXnHvbqj+J2G+4o75HjmIG8oBUNFxLiXhAlB80j0FWmQuloSMEhP9wFlfyioVuGwH7y8BtOQspeK7b1jaHYd7jC5s4VWneTyH5gTHcJyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPbRMeaGIbGTtpxIygSBUzaOBCJmNGV2Zsh0aLYUo78=;
 b=T/g2mjMrJYRsz6iPWMMy2nFXSY04QgcyNPmupnGHCsUSYdcdWrln+j389fZmSSfpEhUGO0AhogfDsOMJ7QpCfiY5nrJTl0VLC2Ug3VVnPr8hejL2QSlxzdAUDeZQYrXkMnTXJfmvdKNltkVy2huAVW9co7KPUODHBG0U+BPzTL8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB6165.namprd05.prod.outlook.com (2603:10b6:a03:d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.8; Thu, 26 Mar
 2020 16:42:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331%2]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 16:42:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        tglx <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
Subject: Re: [RESEND][PATCH v3 06/17] static_call: Add basic static call
 infrastructure
Thread-Topic: [RESEND][PATCH v3 06/17] static_call: Add basic static call
 infrastructure
Thread-Index: AQHWAegAhdNiMLofE02jpsU0DrVXFKhbFyMA
Date:   Thu, 26 Mar 2020 16:42:07 +0000
Message-ID: <12A30BA0-18DA-4748-B82F-6008179CC88C@vmware.com>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.632535759@infradead.org>
In-Reply-To: <20200324142245.632535759@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:640:10c:52bf:449f:76a2:9994:1eb3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c53d3c5-10d8-4c88-9164-08d7d1a49f3b
x-ms-traffictypediagnostic: BYAPR05MB6165:
x-microsoft-antispam-prvs: <BYAPR05MB616540660D42C00D9B377312D0CF0@BYAPR05MB6165.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(66446008)(66476007)(478600001)(64756008)(7416002)(66556008)(45080400002)(66946007)(71200400001)(33656002)(4326008)(966005)(6512007)(5660300002)(6506007)(316002)(6916009)(2906002)(53546011)(54906003)(6486002)(186003)(76116006)(81156014)(81166006)(8936002)(2616005)(8676002)(36756003)(86362001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hp+X/wanUIsdGUl6OgBgdrslWLgUzXwU9tsta0qfYE0PSoGukRkg2Tn5vbbOYOr9yBzEgt1n9e2nv4xVT4mbMg8MbvF5r+FuSPTsrEldBRCQFKg9hUdAB6WuDAf5ZUvOykPn+E6+s7p/UUYX8QnFdzhFbzNwr5AJze6+/bQxcAlhnjNeBYBILoAkBd8W2cpCPmm8fQShFtSJEp67fwFeMGywJSESHg1VuLKfLjlE72uTK3OvhUd9J3U8AH0ikr1XnK9bREg5t4fHJFs9nHXm00DNxfkZKGohZF6zBdF1VSPxepjAUdKxAEc0x1WObr8I8XuWdcbQQJgpCb+0CW64Rhn4psFvbozwrg/pp4uQzj+MhVX+pUB+Q/9wjrTF+49s2i1bY+XezZ/BXfHkTz86nvMjdvDCW3Z92IuSz8Zqi8TOswjhqdBJAam/P7tUBMotsWxsIPRuWp+GABSHAQsBohg1sIHQQkjtdEDu5tb0MwMaz0b2Zz17nx6Kz/mbRm+A7dJtPQ0LU1+6tzQ12vGnRQ==
x-ms-exchange-antispam-messagedata: 5o9zpni6VTCRqs4rjFOfp7SDosw/41E2ro+hKifVkLX0flGpw4e9DdUInPNqIfmeSaxCtUeXAqD94/A/jnJNkcZ6Bm3aLkkRWK2FMosOw9BcGSK8Q2fMHzGt/0dutEHrosMXnnz7CHsLa64FHqK3wKf6p5w9r/tzi8RFrhijnvI9H+JK2PDuRCXmR6D6FOUDh34uGkKuGc0J9Pm0ysc3mw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <54254916B8A7934E866B22E723350551@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c53d3c5-10d8-4c88-9164-08d7d1a49f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 16:42:07.0488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQSVQdtV3GrW4SHr0wa4TE4QDkUdSkbeZ1i8339FKEk4OpkrLw3sAO0JnizmCnJAQyz2CZYrMdfagKj2PxJKLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1hciAyNCwgMjAyMCwgYXQgNjo1NiBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IFN0YXRpYyBjYWxscyBhcmUgYSByZXBsYWNlbWVu
dCBmb3IgZ2xvYmFsIGZ1bmN0aW9uIHBvaW50ZXJzLiAgVGhleSB1c2UNCj4gY29kZSBwYXRjaGlu
ZyB0byBhbGxvdyBkaXJlY3QgY2FsbHMgdG8gYmUgdXNlZCBpbnN0ZWFkIG9mIGluZGlyZWN0DQo+
IGNhbGxzLiAgVGhleSBnaXZlIHRoZSBmbGV4aWJpbGl0eSBvZiBmdW5jdGlvbiBwb2ludGVycywg
YnV0IHdpdGgNCj4gaW1wcm92ZWQgcGVyZm9ybWFuY2UuICBUaGlzIGlzIGVzcGVjaWFsbHkgaW1w
b3J0YW50IGZvciBjYXNlcyB3aGVyZQ0KPiByZXRwb2xpbmVzIHdvdWxkIG90aGVyd2lzZSBiZSB1
c2VkLCBhcyByZXRwb2xpbmVzIGNhbiBzaWduaWZpY2FudGx5DQo+IGltcGFjdCBwZXJmb3JtYW5j
ZS4NCj4gDQo+IFRoZSBjb25jZXB0IGFuZCBjb2RlIGFyZSBhbiBleHRlbnNpb24gb2YgcHJldmlv
dXMgd29yayBkb25lIGJ5IEFyZA0KPiBCaWVzaGV1dmVsIGFuZCBTdGV2ZW4gUm9zdGVkdDoNCj4g
DQo+ICBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsa21sLmtlcm5lbC5vcmclMkZyJTJGMjAxODEwMDUwODEzMzMuMTUwMTgt
MS1hcmQuYmllc2hldXZlbCU0MGxpbmFyby5vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQw
dm13YXJlLmNvbSU3QzQ4Y2I0OWUzYmQ2NTQ3OWE0NDAwMDhkN2NmZmYyMDdkJTdDYjM5MTM4Y2Ez
Y2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNzIwNjU2NzAwNTY5NzcyNCZhbXA7
c2RhdGE9akxBZGVZRlg4QzY3UUZlWXRpZ3VxOUJmZU44enhqU2E4Z210WSUyRjJuSlE4JTNEJmFt
cDtyZXNlcnZlZD0wDQo+ICBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLmtlcm5lbC5vcmclMkZyJTJGMjAxODEwMDYw
MTUxMTAuNjUzOTQ2MzAwJTQwZ29vZG1pcy5vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQw
dm13YXJlLmNvbSU3QzQ4Y2I0OWUzYmQ2NTQ3OWE0NDAwMDhkN2NmZmYyMDdkJTdDYjM5MTM4Y2Ez
Y2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNzIwNjU2NzAwNTY5NzcyNCZhbXA7
c2RhdGE9S0JWeDdFSm80RWd6S2FDY2NBYU1QN0M0TCUyQllsUTZsaU80d083dnYyN01VJTNEJmFt
cDtyZXNlcnZlZD0wDQo+IA0KPiBUaGVyZSBhcmUgdHdvIGltcGxlbWVudGF0aW9ucywgZGVwZW5k
aW5nIG9uIGFyY2ggc3VwcG9ydDoNCj4gDQo+IDEpIG91dC1vZi1saW5lOiBwYXRjaGVkIHRyYW1w
b2xpbmVzIChDT05GSUdfSEFWRV9TVEFUSUNfQ0FMTCkNCj4gMikgYmFzaWMgZnVuY3Rpb24gcG9p
bnRlcnMNCj4gDQo+IEZvciBtb3JlIGRldGFpbHMsIHNlZSB0aGUgY29tbWVudHMgaW4gaW5jbHVk
ZS9saW51eC9zdGF0aWNfY2FsbC5oLg0KPiANCj4gW3BldGVyejogc2ltcGxpZmllZCBpbnRlcmZh
Y2VdDQo+IFNpZ25lZC1vZmYtYnk6IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFk
ZWFkLm9yZz4NCj4gLS0tDQo+IGFyY2gvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAg
IDMgDQo+IGluY2x1ZGUvbGludXgvc3RhdGljX2NhbGwuaCAgICAgICB8ICAxMzcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gaW5jbHVkZS9saW51eC9zdGF0aWNfY2Fs
bF90eXBlcy5oIHwgICAxNSArKysrDQo+IDMgZmlsZXMgY2hhbmdlZCwgMTU1IGluc2VydGlvbnMo
KykNCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvc3RhdGljX2NhbGwuaA0KPiBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zdGF0aWNfY2FsbF90eXBlcy5oDQo+IA0K
PiAtLS0gYS9hcmNoL0tjb25maWcNCj4gKysrIGIvYXJjaC9LY29uZmlnDQo+IEBAIC05NDEsNiAr
OTQxLDkgQEAgY29uZmlnIEhBVkVfU1BBUlNFX1NZU0NBTExfTlINCj4gCSAgZW50cmllcyBhdCA0
MDAwLCA1MDAwIGFuZCA2MDAwIGxvY2F0aW9ucy4gVGhpcyBvcHRpb24gdHVybnMgb24gc3lzY2Fs
bA0KPiAJICByZWxhdGVkIG9wdGltaXphdGlvbnMgZm9yIGEgZ2l2ZW4gYXJjaGl0ZWN0dXJlLg0K
PiANCj4gK2NvbmZpZyBIQVZFX1NUQVRJQ19DQUxMDQo+ICsJYm9vbA0KPiArDQo+IHNvdXJjZSAi
a2VybmVsL2djb3YvS2NvbmZpZyINCj4gDQo+IHNvdXJjZSAic2NyaXB0cy9nY2MtcGx1Z2lucy9L
Y29uZmlnIg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc3RhdGljX2Nh
bGwuaA0KPiBAQCAtMCwwICsxLDEzNyBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAgKi8NCj4gKyNpZm5kZWYgX0xJTlVYX1NUQVRJQ19DQUxMX0gNCj4gKyNkZWZpbmUg
X0xJTlVYX1NUQVRJQ19DQUxMX0gNCj4gKw0KPiArLyoNCj4gKyAqIFN0YXRpYyBjYWxsIHN1cHBv
cnQNCj4gKyAqDQo+ICsgKiBTdGF0aWMgY2FsbHMgdXNlIGNvZGUgcGF0Y2hpbmcgdG8gaGFyZC1j
b2RlIGZ1bmN0aW9uIHBvaW50ZXJzIGludG8gZGlyZWN0DQo+ICsgKiBicmFuY2ggaW5zdHJ1Y3Rp
b25zLiAgVGhleSBnaXZlIHRoZSBmbGV4aWJpbGl0eSBvZiBmdW5jdGlvbiBwb2ludGVycywgYnV0
DQo+ICsgKiB3aXRoIGltcHJvdmVkIHBlcmZvcm1hbmNlLiAgVGhpcyBpcyBlc3BlY2lhbGx5IGlt
cG9ydGFudCBmb3IgY2FzZXMgd2hlcmUNCj4gKyAqIHJldHBvbGluZXMgd291bGQgb3RoZXJ3aXNl
IGJlIHVzZWQsIGFzIHJldHBvbGluZXMgY2FuIHNpZ25pZmljYW50bHkgaW1wYWN0DQo+ICsgKiBw
ZXJmb3JtYW5jZS4NCj4gKyAqDQo+ICsgKg0KPiArICogQVBJIG92ZXJ2aWV3Og0KPiArICoNCj4g
KyAqICAgREVDTEFSRV9TVEFUSUNfQ0FMTChuYW1lLCBmdW5jKTsNCj4gKyAqICAgREVGSU5FX1NU
QVRJQ19DQUxMKG5hbWUsIGZ1bmMpOw0KPiArICogICBzdGF0aWNfY2FsbChuYW1lKShhcmdzLi4u
KTsNCj4gKyAqICAgc3RhdGljX2NhbGxfdXBkYXRlKG5hbWUsIGZ1bmMpOw0KPiArICoNCj4gKyAq
IFVzYWdlIGV4YW1wbGU6DQo+ICsgKg0KPiArICogICAjIFN0YXJ0IHdpdGggdGhlIGZvbGxvd2lu
ZyBmdW5jdGlvbnMgKHdpdGggaWRlbnRpY2FsIHByb3RvdHlwZXMpOg0KPiArICogICBpbnQgZnVu
Y19hKGludCBhcmcxLCBpbnQgYXJnMik7DQo+ICsgKiAgIGludCBmdW5jX2IoaW50IGFyZzEsIGlu
dCBhcmcyKTsNCj4gKyAqDQo+ICsgKiAgICMgRGVmaW5lIGEgJ215X25hbWUnIHJlZmVyZW5jZSwg
YXNzb2NpYXRlZCB3aXRoIGZ1bmNfYSgpIGJ5IGRlZmF1bHQNCj4gKyAqICAgREVGSU5FX1NUQVRJ
Q19DQUxMKG15X25hbWUsIGZ1bmNfYSk7DQoNCkRvIHlvdSB3YW50IHRvIHN1cHBvcnQgb3B0aW9u
YWwgZnVuY3Rpb24gYXR0cmlidXRlcywgc3VjaCBhcyDigJxwdXJl4oCdIGFuZA0K4oCcY29uc3Ti
gJ0/DQoNCg==
