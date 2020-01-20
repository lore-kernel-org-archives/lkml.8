Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F238C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0F9206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KtAfen0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgATBmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 20:42:07 -0500
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com ([40.107.237.125]:53472
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728909AbgATBmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 20:42:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ1q7uEjkq/q74cfpjfASVXntSwHWvNzUGlqdpD/cC3IOoE9jjQ0MEtoOBM6nEnj1aC+I462DMPWaZeBYPm3b2F8Y1dEwQnG9mz5CL5nB8Y5uha8tmI5yfA3NJdxQwiFd6YcKUBQ13d7LKQGQQIi9hKCx9vmKxEvlnvsJHqbY2qGBVi6vS2ieL45bC9Pp7zqD1AYzTA4rzhp8cPo/it3qQkWvSUGNgqmuDDlzgO9ww6O6kQS0OTMHC4RCk29aQCd4bcQnAPOpIn0345OdRFviCbg3OzbizzhohjFvziFc6+a50fSSWWty4VC+5QFg+EGnFp6p5oPDyJ8huvsKfDjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KJOqd9gmHDpWncrhQ0ZQIy67SOpTkLEof4bs5yDLX0=;
 b=Qho6PJjHhx0pJMOOmHRm0zjgE/zo2Xu3qYpDXEE1IVODVEyxjQZ5DgjeWytoCnni9ftRV1AZs/XBstcj1naUIlZL+NFXtUvlrqhc+w1ZXTkFnDnhyb/I/gg3d6EYbNQ4Bw3VhQEvAFbtqb5b2a89H4UwP+3pATvrAi1amTngYHESHyxePT5+WoxTWi51BWMHXhPbr9J2UXLbxg0RWMt4iJQq1k2DWJ+heO7E3fqZ7SSOZK18uQsvA4nW6DmMLOg+Nl4g4CxEQMZ4vInR+grytcq26mBualhXyXyA2FGmMG8kZuXkG93V9nPCBQiFgN8wQSnU9cCGttS+iD8QFmNJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KJOqd9gmHDpWncrhQ0ZQIy67SOpTkLEof4bs5yDLX0=;
 b=KtAfen0pAi5SXjHR0Yunckegusr1HhJjG2YzSFITBzSKuUwhwpDN6iOLOf1YWs22cmW6iCXeAOojiKtLIHwEmoFAtINMPHUWCV5T6Kc+iabjGKGg7sgoxlH9Gow4V5BOpaP4+qFgPId3ZgbAH2l1H/Ob+j430ZcVCVYJXP3R9pE=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB1017.namprd21.prod.outlook.com (52.132.146.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.5; Mon, 20 Jan 2020 01:42:04 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f%6]) with mapi id 15.20.2644.015; Mon, 20 Jan 2020
 01:42:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: RE: [patch 08/15] x86/vdso: Move VDSO clocksource state tracking to
 callback
Thread-Topic: [patch 08/15] x86/vdso: Move VDSO clocksource state tracking to
 callback
Thread-Index: AQHVyxPAqKi3aGjmm0+2z7GmU3ntJ6fyzsyA
Date:   Mon, 20 Jan 2020 01:42:03 +0000
Message-ID: <MW2PR2101MB10523289FF15A7EA2599274BD7320@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200114185237.273005683@linutronix.de>
 <20200114185947.406096630@linutronix.de>
In-Reply-To: <20200114185947.406096630@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-20T01:42:01.6598749Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d4a120c8-9c16-4fa7-843a-ad0d932d322e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8116c15a-7135-457e-0273-08d79d49f399
x-ms-traffictypediagnostic: MW2PR2101MB1017:|MW2PR2101MB1017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1017D6E8F1DAE72C1E43E8C9D7320@MW2PR2101MB1017.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(55016002)(52536014)(76116006)(33656002)(9686003)(66446008)(66476007)(66946007)(64756008)(66556008)(8990500004)(7696005)(26005)(2906002)(6506007)(71200400001)(186003)(316002)(8936002)(8676002)(54906003)(7416002)(81166006)(81156014)(4744005)(5660300002)(110136005)(478600001)(10290500003)(86362001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1017;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6c8uTutQgepaSSuqqWTWD54Fvcwt4feyFKlJMi0zDC93CfK2bbDgUmoL1fxn4+3tLB6qTaauf2xoSNyjFk6d73valmIU4+yZl7nM9hRghEjczN4vESTQ7u5im9sJ2kYHeGK0f10yRf/OAI9wCx9fcrirek1u1QrBZH9rGZ+M54ear/w/DJu7YyjStDuwTw6aUwxgrNC76TiCUF9G6wZCApYnEHQIeBP17Vh1JcDg8RR8/AkcMDy5k/LVFGY/kkWwhi8ze5KVlwj9mUkFAJuas9Vu/RTL0JJeR8m9lAIKxsB8wIVHLKz3NbzbNSFWIEHRG9Xw2bUMkLIdwQh/0j0aUGlaW2uETO8MFuz8Yedji0bxisatA/4XMlA82MP/4yRFXuHuzjWotdpB6ogmebgPtzxUAOu4vYxqcdlkKN+WwjsB3u+9KW1GX2FA9p9V9CBI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8116c15a-7135-457e-0273-08d79d49f399
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 01:42:04.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPoQHrgj9ENltiiMmMV51VIxrbMb/9RqO8v+ahgSGw3c0ioW5WiUs2ajMlhndhSuR4qNtQKQMxBW6pPpmV9ZESSSZLQ7KVjbcB/3ArA0+EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IFNlbnQ6IFR1ZXNkYXks
IEphbnVhcnkgMTQsIDIwMjAgMTA6NTMgQU0NCj4gDQo+IEFsbCBhcmNoaXRlY3R1cmVzIHdoaWNo
IHVzZSB0aGUgZ2VuZXJpYyBWRFNPIGNvZGUgaGF2ZSB0aGVpciBvd24gc3RvcmFnZQ0KPiBmb3Ig
dGhlIFZEU08gY2xvY2sgbW9kZS4gVGhhdCdzIHBvaW50bGVzcyBhbmQganVzdCByZXF1aXJlcyBk
dXBsaWNhdGUgY29kZS4NCj4gDQo+IFg4NiBhYnVzZXMgdGhlIGZ1bmN0aW9uIHdoaWNoIHJldHJp
ZXZlcyB0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNsb2NrDQo+IG1vZGUgc3RvcmFnZSB0byBt
YXJrIHRoZSBjbG9ja3NvdXJjZSBhcyB1c2VkIGluIHRoZSBWRFNPLiBUaGF0J3Mgc2lsbHkNCj4g
YmVjYXVzZSB0aGlzIGlzIGludm9rZWQgb24gZXZlcnkgdGljayB3aGVuIHRoZSBWRFNPIGRhdGEg
aXMgdXBkYXRlZC4NCj4gDQo+IE1vdmUgdGhpcyBmdW5jdGlvbmFsaXR5IHRvIHRoZSBjbG9ja3Nv
dXJjZTo6ZW5hYmxlKCkgY2FsbGJhY2sgc28gaXQgZ2V0cw0KPiBpbnZva2VkIG9uY2Ugd2hlbiB0
aGUgY2xvY2tzb3VyY2UgaXMgaW5zdGFsbGVkLiBUaGlzIGFsbG93cyB0byBtYWtlIHRoZQ0KPiBj
bG9jayBtb2RlIHN0b3JhZ2UgZ2VuZXJpYy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBH
bGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KDQpSZXZpZXdlZC1ieTogTWljaGFlbCBLZWxs
ZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+ICAoSHlwZXItViBwYXJ0cykNCg==
