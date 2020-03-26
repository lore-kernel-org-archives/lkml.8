Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E790DC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACF120722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Pgs86IDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgCZSJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:09:24 -0400
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:49231
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgCZSJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/sXzu5xaKH8PRxM8MXtVZxznmIqbTEoJ2e6TjwwaOMesHrNH1xXDPxR+8YWvWmwQcS97oKFdezP6kV9VDd+ckMxJgD96yVBQyjl4tW7/AQBBTZ+iO5XHjgRPxg8aueRMZ+0WhVh6PXo2FoxNWRjcRsQJ4KtWZO3HDwZwgLX/f/4oOWLJ06+txCmxU4mC53xA4xmm4e8qGtZdRMPtWCDRWGK21p78uBSCGJaDZGccflU5Qnvid9JRRLHuNx4K96vsn4OasieB2zCjPQWWRpbmH6Tqm54WGI36W00hGHoJwCnrw6I1c/JuLFpQ7zQV8XP8vvnGLlz/1KtcQyOc2Ae+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crih+INTUlvGXKOKX9LLynjEU9qA0UPK5Zv/NdtlOTo=;
 b=eD0xT5Dxe8Ea0DHJ97ZcxNEGR0a96VdKsRqTXqVvNBTew+fUk7AisOifdT3q85lbu5xCHgjMS9wexTTPH/nnOMm/IyOACVVD0ZB7Uk/jEnPkA18Ux69Z2x6t+HcX2lM9IfI59hrzVzJDQICKjY1M+yg9nwUbGIZ93tidhYqPU71ERJC2ZeWLGtwZfwDIZh5VT8FR22thCyk/Kx77QrEpdAHlC2UNQtyHH/oJ7qWkKDRS9CxvtDarLILiNRtFrp4SLCUlbMAfhfrV9XWapsDtEyg2guWSlnftHf2/sOR3XykdSkybxKKdkonst1KZx3d/kzaCz8Zfnsgsh0pE4n8SVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crih+INTUlvGXKOKX9LLynjEU9qA0UPK5Zv/NdtlOTo=;
 b=Pgs86IDPrzXiednlP/A5SIwSePRvHLLYwCH+FJRaCck9rvly12mopMPhUWd6TpqiHEWJWJhJWqtU4nERShBfyu2K4JNlOK/m0Fzt1XMFaHhfT37HRyjMnDJjgXeaDYpJmMS5OHu+S9Y90Zm3VKjOO1syvjjb5KEAOulAcUIbkyY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB5224.namprd05.prod.outlook.com (2603:10b6:a03:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 26 Mar
 2020 18:09:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331%2]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 18:09:07 +0000
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
Thread-Index: AQHWAegAhdNiMLofE02jpsU0DrVXFKhbFyMAgAAFbgCAABLlAA==
Date:   Thu, 26 Mar 2020 18:09:07 +0000
Message-ID: <9D47A4CA-39AD-4408-879B-677BE9D891B7@vmware.com>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.632535759@infradead.org>
 <12A30BA0-18DA-4748-B82F-6008179CC88C@vmware.com>
 <20200326170128.GQ20713@hirez.programming.kicks-ass.net>
In-Reply-To: <20200326170128.GQ20713@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4700:9b2:857a:d913:34b7:2afa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 304fb010-6079-4b2a-9c8e-08d7d1b0c6ee
x-ms-traffictypediagnostic: BYAPR05MB5224:
x-microsoft-antispam-prvs: <BYAPR05MB5224066F0030207FBB8F011ED0CF0@BYAPR05MB5224.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(6486002)(186003)(2906002)(86362001)(5660300002)(81166006)(8676002)(6512007)(81156014)(71200400001)(6506007)(76116006)(8936002)(66946007)(66446008)(2616005)(36756003)(64756008)(66556008)(33656002)(478600001)(54906003)(66476007)(316002)(7416002)(53546011)(4326008)(6916009)(21314003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7hUKZugMTc0MNS8K9TRKT3jzAZEAVlmzL0B8VROHIWi3PsFryAv8bS2nn7YJbKHYct2VevrjuTMY1kfrKNiA053poeFaGx2pwYPSDJzT7smHoyciUSrXGIR6DxstZuS82g/ae6Bou469cb3uBaFKzk+vg87+3qEanpYYFO0wlgLAK/WIjoqgYj6S5LxNt+0d9/DbqNeWVesWqjqhk7DPCiinVM7TNfq53R4t/YjqrcAsW2sudndlQbJ67HT3U91hY1Jrc3FtJHtUeHAUwi3EWZ5pwwpe1/9ULldcrQT37X5jHIfBydBnc889z1gAW6FF8WY+hQoQPpnQfhnAYFSQVJWFj/fJUsjQVSS33GekkDBZ8oysu406szeuC9heNPh76qdLRjUrUl+eS/P3zD1mdtgrAiHqOUAYpJWnAZt2PHbgVmIb39gyrlcDQY722GEZ1lX8+3DTgDpGKBYPPVA+qyYYciY3EtwwpF9yci3brdwa7vkIObJO11VZk8NWvAo
x-ms-exchange-antispam-messagedata: +ENVhbKaOuKnwMUwb9/dEHzMk4CihzLtzqwUmGiErMas69Ki5ttAB/XcrRsfQctjG8jHEtR0Sx4mrGL4g0lN6CXFnzEYYMTwHQIKBappTh0bKQW7VDrYxeosMlN57cIplFpnNZoUnEWiZtx4cM9pgY1rBWMUht8M2rcRn1UYwhTg+nNR4oPSqYU/l2vLpUAxmtTT72kVlZuHuI3VqzjDng==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C23DD4052446044D9B1453F6582AFB3A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304fb010-6079-4b2a-9c8e-08d7d1b0c6ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 18:09:07.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Szux5/jE5KbaZ26R2Yo5oOt4PW3ZzQ0l32bDOGfjnlUwQLezh7zUDEkPeB1cooqdv/9Ji1u6e4f8WXb84J1Dxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXIgMjYsIDIwMjAsIGF0IDEwOjAxIEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBNYXIgMjYsIDIwMjAgYXQgMDQ6NDI6
MDdQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+PiBPbiBNYXIgMjQsIDIwMjAsIGF0IDY6
NTYgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0K
Pj4+ICsgKiBBUEkgb3ZlcnZpZXc6DQo+Pj4gKyAqDQo+Pj4gKyAqICAgREVDTEFSRV9TVEFUSUNf
Q0FMTChuYW1lLCBmdW5jKTsNCj4+PiArICogICBERUZJTkVfU1RBVElDX0NBTEwobmFtZSwgZnVu
Yyk7DQo+Pj4gKyAqICAgc3RhdGljX2NhbGwobmFtZSkoYXJncy4uLik7DQo+Pj4gKyAqICAgc3Rh
dGljX2NhbGxfdXBkYXRlKG5hbWUsIGZ1bmMpOw0KPj4+ICsgKg0KPj4+ICsgKiBVc2FnZSBleGFt
cGxlOg0KPj4+ICsgKg0KPj4+ICsgKiAgICMgU3RhcnQgd2l0aCB0aGUgZm9sbG93aW5nIGZ1bmN0
aW9ucyAod2l0aCBpZGVudGljYWwgcHJvdG90eXBlcyk6DQo+Pj4gKyAqICAgaW50IGZ1bmNfYShp
bnQgYXJnMSwgaW50IGFyZzIpOw0KPj4+ICsgKiAgIGludCBmdW5jX2IoaW50IGFyZzEsIGludCBh
cmcyKTsNCj4+PiArICoNCj4+PiArICogICAjIERlZmluZSBhICdteV9uYW1lJyByZWZlcmVuY2Us
IGFzc29jaWF0ZWQgd2l0aCBmdW5jX2EoKSBieSBkZWZhdWx0DQo+Pj4gKyAqICAgREVGSU5FX1NU
QVRJQ19DQUxMKG15X25hbWUsIGZ1bmNfYSk7DQo+PiANCj4+IERvIHlvdSB3YW50IHRvIHN1cHBv
cnQgb3B0aW9uYWwgZnVuY3Rpb24gYXR0cmlidXRlcywgc3VjaCBhcyDigJxwdXJl4oCdIGFuZA0K
Pj4g4oCcY29uc3TigJ0/DQo+IA0KPiBEbyB5b3Ugc2VlIGEgbmVlZCBmb3IgdGhhdD8gQW5kIHdo
YXQgaXMgdGhlIHN5bnRheCBmb3IgYSBwb2ludGVyIHRvIGENCj4gcHVyZSBmdW5jdGlvbj8NCg0K
SSB0aGluayB0aGF0IHRoZSBrZXJuZWwgdW5kZXJ1dGlsaXplcyB0aGUgcHVyZSBhdHRyaWJ1dGUg
aW4gZ2VuZXJhbC4NCkJ1aWxkaW5nIGl0IHdpdGggIi1Xc3VnZ2VzdC1hdHRyaWJ1dGU9cHVyZeKA
nSByZXN1bHRzIGluIG1hbnkgd2FybmluZ3MuDQpGdW5jdGlvbiBwb2ludGVycyBzdWNoIGt2bV94
ODZfb3BzLmdldF9YWFgoKSBjb3VsZCBoYXZlIGJlZW4gY2FuZGlkYXRlcyB0bw0KdXNlIHRoZSDi
gJxwdXJl4oCdIGF0dHJpYnV0ZS4NCg0KVGhlIHN5bnRheCBpcyB3aGF0IHlvdSB3b3VsZCBleHBl
Y3Q6DQoNCiAgc3RhdGljIHZvaWQgX19hdHRyaWJ1dGVfXygocHVyZSkpKCpwdHIpKHZvaWQpOw0K
DQpIb3dldmVyLCB5b3UgaGF2ZSBhIHBvaW50LCBnY2MgZG9lcyBub3QgYXBwZWFyIHRvIHJlc3Bl
Y3Qg4oCccHVyZeKAnSBmb3INCmZ1bmN0aW9uIHBvaW50ZXJzIGFuZCBlbWl0cyBhIHdhcm5pbmcg
aXQgaXMgaWdub3JlZC4gR0NDIGFwcGFyZW50bHkgb25seQ0KcmVzcGVjdHMg4oCcY29uc3TigJ0u
IEluIGNvbnRyYXN0IGNsYW5nIGFwcGVhcnMgdG8gcmVzcGVjdCB0aGUgcHVyZSBhdHRyaWJ1dGUN
CmZvciBmdW5jdGlvbiBwb2ludGVycy4NCg0K
