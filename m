Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A81C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4C82074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ERgyVwfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgCWKQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:16:47 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:6060
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727862AbgCWKQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkd8vE172iiKQPIh7Gta8JZj655Ynvtbed7WQPgCQdBgFEVu1IHElLzbbyBweBOSAE7XUD1inD0rIMyhYBOgUCF+rO09XqJG7er7SV3vTT8HKQ6hUqcQZ11Rb8Dx1AbIhdFc/25mdsA8xX18WLY6RrApOSboMDC4S8QnIgN9p5fXWu0Eg+4R7235wTBijw9lbpoGv7im6OWAC8RX0Oi/QpGEByQjrSirYx/OpVblHpxmSa1/acnuJpc2F+oXxs3jJT/5z3Vbr0HgbcddYu+wLU74iXyESLWvi96+TIz5y1l0QD/d1ALi+sM0S5kLLcrAa91ffsOhpHrrk5VzLnZ8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8tQW8a6NUK1oT/Yn43sYBuKdyxxr27XgbFZq3OTl94=;
 b=DUwygy5e3Hm2TxJPtL97B5FRMZTanTAikQ+0ad56q2J9PT4fGZRudKQ9q8nz0JfBkz8sRTFJWJ9ZleSn+JaTCRhsqHIipV82gcIsiVJrc8rlPJrCrUg957iHwt0ZMan0pwcvPHg+sYITpVXRqv4D3sQUTZcI4fxGiwhmehsFYKhhu//32JctMlokCskdXFPe9xwnKiEdNc+eLtxNI6XII6kL6XagfKBdO5MB0jcDfEb5jWsFsQJq46Wzaf9KM2LBPsouGB+rJWV2us1iNbQfwugBM7jgoP7BNaDeK0eDQDVWrZSpgGLd3Dki/G27kGHHU9j4WweRnV56Gb+QooTdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8tQW8a6NUK1oT/Yn43sYBuKdyxxr27XgbFZq3OTl94=;
 b=ERgyVwfGrhHpG7UNR5/vTUdQXXBVMYdB1daaR/A/FEMGc0b8L/GQJGsi8ucJvl4YhTf78XKS6CBUvjmjrAJbb+8c+Omu0KUx8lV0cVUiehGWB4Dej4KNdygLEDtrljA6mESO3kB6pD3LU35uHma/nex/qDkas8DZlkpqwRD/gEM=
Received: from MWHPR05MB3376.namprd05.prod.outlook.com (2603:10b6:301:3c::19)
 by MWHPR05MB3470.namprd05.prod.outlook.com (2603:10b6:301:42::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11; Mon, 23 Mar
 2020 10:16:44 +0000
Received: from MWHPR05MB3376.namprd05.prod.outlook.com
 ([fe80::884b:8b78:93b:29e0]) by MWHPR05MB3376.namprd05.prod.outlook.com
 ([fe80::884b:8b78:93b:29e0%7]) with mapi id 15.20.2856.015; Mon, 23 Mar 2020
 10:16:44 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Adit Ranadive <aditr@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishnu Dasa <vdasa@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>, Xin Tan <tanxin.ctf@gmail.com>
Subject: RE: [PATCH v2] VMCI: Fix NULL pointer dereference on context ptr
Thread-Topic: [PATCH v2] VMCI: Fix NULL pointer dereference on context ptr
Thread-Index: AQHWAO0PYlOmj4PpzU+IYASut1pHpqhV3viAgAAGvwCAAA2QwA==
Date:   Mon, 23 Mar 2020 10:16:43 +0000
Message-ID: <MWHPR05MB33760A2F7ABC03DB367B09C2DAF00@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <1584951832-120773-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200323085241.GA342330@kroah.com>
 <CAK8P3a3B373YcmZncnE-wJz12B+3A5QC9CUrDd72qSw+65MwQg@mail.gmail.com>
In-Reply-To: <CAK8P3a3B373YcmZncnE-wJz12B+3A5QC9CUrDd72qSw+65MwQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhansen@vmware.com; 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0885fbe5-6acc-4648-892c-08d7cf134977
x-ms-traffictypediagnostic: MWHPR05MB3470:|MWHPR05MB3470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR05MB347038BBC32E61CF9D7D2E99DAF00@MWHPR05MB3470.namprd05.prod.outlook.com>
x-vmwhitelist: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(7696005)(110136005)(316002)(33656002)(4326008)(7416002)(26005)(478600001)(86362001)(55016002)(9686003)(186003)(53546011)(6506007)(54906003)(66476007)(8676002)(81156014)(81166006)(8936002)(5660300002)(66556008)(66946007)(64756008)(66446008)(76116006)(71200400001)(52536014)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR05MB3470;H:MWHPR05MB3376.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQEwi/XYbDzXcZSK548f7UhnMyjG4Bs/tLpOKJnY+dO4eNZHvXNPR1j7oEvkAFGGLzUiVTxWXp1s/S9s3IgwJ8pIXpF68qrky2HrwsPuevh+ZjSun1VMjXi9Hy+OBh3Dn/S3KHAa4SQtxp6yqgJqASyt5nOTLc86CDkh9fxKF6avQ6rFxXER5RXGzNcRIHdvJ86q+fXhnqzzhY9gIb1x+okZW2FTNedw4mC8IhqAXHGX1gyxP+3Xlr8BNCpeB/lJpphh5dB7/NuJy+3WyqyqMYXj0Y9RJVlFbU4x1e6lEyrvJVXhkVN4cVKWY7oHlJaKxaJg5tZ/q2igBO8Cqc7woM/xKFB6VYG4WAOvnzL6O6UFtS67e6/o0vcLEEVHlzhBP/ET8VhFfXZxyLDgwOG8DAm4S7Ds+QpyTed/8kSoPol/mQzrg61VHXEGwkwmUONi
x-ms-exchange-antispam-messagedata: fkNeRYbcDEeiYJGPkAUsJxktjvXPumNdbeFmLHdNJDCNZ7fc9zXfeEzHiG/AJOz4vLyA0BfU4yfQtad6D34VM6AOlT65IhDLrBJJryNRbxzqe4/38EGFIu5+2phrvapckECjgqRIxJ8qK+l1qUFz/Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0885fbe5-6acc-4648-892c-08d7cf134977
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 10:16:43.7764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faHUJViScUWhjWCBJBoSmncp4Y+suDt+ddmvP5A8B9nsb+kn0Am9+H51UyIHf44c6MAxl7NNf/fKz1YCQP18Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWlsdG86YXJuZEBhcm5kYi5kZV0NCj4gU2VudDogTW9u
ZGF5LCBNYXJjaCAyMywgMjAyMCAxMDoxNyBBTQ0KPiBPbiBNb24sIE1hciAyMywgMjAyMCBhdCA5
OjUyIEFNIEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBNYXIgMjMsIDIwMjAgYXQgMDQ6MjI6MzNQTSArMDgw
MCwgWGl5dSBZYW5nIHdyb3RlOg0KPiA+ID4gQSBOVUxMIHZtY2lfY3R4IG9iamVjdCBtYXkgcGFz
cyB0byB2bWNpX2N0eF9wdXQoKSBmcm9tIGl0cyBjYWxsZXJzLg0KPiA+DQo+ID4gQXJlIHlvdSBz
dXJlIHRoaXMgY2FuIGhhcHBlbj8NCj4gPg0KPiA+ID4gQWRkIGEgTlVMTCBjaGVjayB0byBwcmV2
ZW50IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhpcyBj
b3VsZCBoYXBwZW4gaWYgdm1jaV9jdHhfZ2V0KCkgcmV0dXJucyBOVUxMLCB3aGljaCBpcw0KPiBu
b3QgY2hlY2tlZCBmb3IgY29uc2lzdGVudGx5LiBNYXliZSBhZGQgYmV0dGVyIGVycm9yIGhhbmRs
aW5nIHRvIHRoZQ0KPiBjYWxsZXJzIHRoYXQgY3VycmVudGx5IGRvbid0IGNoZWNrIGZvciB0aGF0
LCB0byBjYXRjaCBwcm9ibGVtcyBzdWNoIGFzDQoNCkluIHRoZSBjYXNlcywgd2hlcmUgdGhlIHJl
dHVybiB2YWx1ZSBpc24ndCBjaGVja2VkLCB0aGUgcmV0dXJuIHZhbHVlIG9mDQp2bWNpX2N0eF9n
ZXQoKSB3b24ndCBiZSBOVUxMLCBhcyB0aGUgY29kZSB3b24ndCBiZSByZWFjaGVkIHVubGVzcyB0
aGUNCmNvbnRleHQgSUQgaGFzIGFuIGFzc29jaWF0ZWQgY29udGV4dCBzdHJ1Y3R1cmUuIEluIHRo
ZSBleGFtcGxlIGJlbG93LA0KdGhlIGNhbGxlciBoYXMgb2J0YWluZWQgdGhlIGNvbnRleHRfaWQg
ZnJvbSBhbiBhY3RpdmUgY29udGV4dC4gVGhhdCBzYWlkLA0KaXQgd291bGRuJ3QgaHVydCB0byBh
ZGQgZWl0aGVyIGNoZWNrcyBvciBhdCBsZWFzdCBhIGNvbW1lbnQgYXMgdG8gd2h5DQp0aGUgY29u
dGV4dCB3b24ndCBiZSBOVUxMIGluIHRoZSBjYXNlcywgd2hlcmUgaXQgaXNuJ3QgY2hlY2tlZCB0
b2RheS4NCg0KPiANCj4gdm9pZCB2bWNpX2N0eF9yY3Zfbm90aWZpY2F0aW9uc19yZWxlYXNlKC4u
LikNCj4gew0KPiAgICAgICAgIHN0cnVjdCB2bWNpX2N0eCAqY29udGV4dCA9IHZtY2lfY3R4X2dl
dChjb250ZXh0X2lkKTsgLyogbWF5IGJlIE5VTEwgKi8NCj4gICAgICAgIC4uLg0KPiAgICAgICAg
Y29udGV4dC0+cGVuZGluZ19kb29yYmVsbF9hcnJheSA9IGRiX2hhbmRsZV9hcnJheTsNCj4gICAg
ICAgIC4uLg0KPiAgICAgICAgdm1jaV9jdHhfcHV0KGNvbnRleHQpOw0KPiB9DQo+IA0KPiBDaGVj
a2luZyBvbmx5IGluIHZtY2lfY3R4X3B1dCgpIGlzIHRvbyBsYXRlLg0KPiANCj4gICAgICBBcm5k
DQoNClRoYW5rcywNCkpvcmdlbg0K
