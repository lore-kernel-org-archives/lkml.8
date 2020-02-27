Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30288C76567
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E320224656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=camlinlimited.onmicrosoft.com header.i=@camlinlimited.onmicrosoft.com header.b="Q6sgjNd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbgB0O1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:27:48 -0500
Received: from mail-eopbgr100057.outbound.protection.outlook.com ([40.107.10.57]:39214
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388270AbgB0OIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:08:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN3VLAhcYT83dZYB4fWmpVbCmUeB0ue0HaDRTAbvxn6v0QUUibU/4xQktIGfEv1xblS49bXcHeP2Ztr4dFrODqaNzGwjrkAl54ArAn0yosuincxWgXjUbhk1WjB4ZC9HtSrNnPnv3Orjt8dz0iExV6roFEWbEz7/Vkx6bML3BWm8qVWtGscGBjoMTQqkVBydqU/r905SvziMvQyAJFbV/bNlUAFJWYUuFT2106PXtiAEJgZzfoRVoGgknR54du5R5OpL6OWvNjHLrpmNySuvX833xKMVmjOJH5e02KaK0b7mVGA13HLeYZJBbXUkPTNpUtM77wHIC29zWFVVblfuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8amRuiXtoHRHyQEhiNy57KeSaBnAezVT68vEjITzhQ=;
 b=HHQ9dEwglK6q5zng178pptdArK61Kr+i7tf0gfvBwp0NBRgbQnFwnjwcRhdwbk9vx2ZDgz3vTnwq3PtQAlAfSyRPcEtFJSZrDqYo9gs4bv/owb3W9kAifkDZDOaPY76y9r8RoA05SWGLpzjlRwGh1P4A7aFdfyaUuuTEoScZpXHRrUvhmAkNu6+pGqWDBDqSuX7gGxd2+umfvtuIrLGvH5PeUV9o7oG+6ikLJVAUk4WZ365F9HQOTu7HWc7Ot55/2Kh8lXlMQvaHeEkjpfJMDlku+V1d1tsNOusaBRf8qAfDJTRLkIJn0gRi+QsEBUSOofIgBOo/FWbAjr1pWSd9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=camlintechnologies.com; dmarc=pass action=none
 header.from=camlintechnologies.com; dkim=pass
 header.d=camlintechnologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=camlinlimited.onmicrosoft.com; s=selector2-camlinlimited-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8amRuiXtoHRHyQEhiNy57KeSaBnAezVT68vEjITzhQ=;
 b=Q6sgjNd/ADOcU/mL7EZ+gERNGYyquv++FFl1++FgYZ7tbFeXxHGW0MDKSh8te8fSUH4gM5Xa5vMyQHuK2toWGem5VhJhVAFTpfKNLaivy1Dj08r6sk3dzua9qbmTVhUtiUaIJpmQYjmg0PyRlrn31M/7QCKIG4a7MShyccKMUeY=
Received: from CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM (20.176.61.151) by
 CWLP123MB2596.GBRP123.PROD.OUTLOOK.COM (20.176.62.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 14:08:34 +0000
Received: from CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM
 ([fe80::fc9c:3a7e:f857:3c78]) by CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM
 ([fe80::fc9c:3a7e:f857:3c78%3]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 14:08:34 +0000
Received: from [192.168.10.194] (95.143.242.242) by AM4PR0701CA0029.eurprd07.prod.outlook.com (2603:10a6:200:42::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend Transport; Thu, 27 Feb 2020 14:08:33 +0000
From:   Lech Perczak <l.perczak@camlintechnologies.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?S3J6eXN6dG9mIERyb2JpxYRza2k=?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Thread-Topic: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Thread-Index: AQHV7V5t8S4uzrFtj0WCWsMdVjN9Yqgu+liAgAARmQCAAAgbAA==
Date:   Thu, 27 Feb 2020 14:08:34 +0000
Message-ID: <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
References: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
 <20200227123633.GB962932@kroah.com>
 <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
In-Reply-To: <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0701CA0029.eurprd07.prod.outlook.com
 (2603:10a6:200:42::39) To CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:6d::23)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=l.perczak@camlintechnologies.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [95.143.242.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8920b67e-75e6-4e45-4954-08d7bb8e8827
x-ms-traffictypediagnostic: CWLP123MB2596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP123MB259698D308924DCA263DBDB787EB0@CWLP123MB2596.GBRP123.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39850400004)(396003)(376002)(189003)(199004)(16526019)(54906003)(186003)(16576012)(26005)(8676002)(5660300002)(66556008)(66446008)(81166006)(81156014)(8936002)(31686004)(6486002)(316002)(2906002)(52116002)(478600001)(71200400001)(31696002)(66476007)(66946007)(4326008)(956004)(36756003)(64756008)(6916009)(2616005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CWLP123MB2596;H:CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: camlintechnologies.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24iP04BIA1dxEWHWIVv2ilLImfDqhtk2vUiCIVhZwH7mrrljn89tGi2I/pXyG3wYTus2gbbM4wdtflgf+YGlWL/lS0wv/mBlvyunjx3lPaYww9qyFxyk4CzfjPa1om7s+V6DNlGXmKSU0BT6Z9QbEKeabtSzx16oDETUsblOauOWkwMU8wQk7tEtjy8dAv2GRLAy9v27FJ+XMIVAQX/frgtZb12YDoQ4+2d9QKgBQ2PlsijelB1OhJStdHubrGDzOtdjREODUk5Er+6jT6cMrA5JJlEhkrFPMni9ajbn9+1hca12/hfefpzzbNI59kqoxsu0Cm0muiEr0YrG4njB6phRfuy1pTSJwgSbSpjL/MlCArwtUD8dF9Nu1FdT1zaHiSGjBZWR+xw+QmcI1f3yod/4WSw4UUDtFHSb5n6UfGWpifLPjZEFIyosg/S0bLFz
x-ms-exchange-antispam-messagedata: /1z10+v+nDNGojusoz4wA2DyD1l9Ar6sYPOcPQtzjLiSbLbbJ3O1py6dpPla9+SxmfuxtcpliQ4DaKRT1rGxnJ45yRNz5yLM/7ckJVyWcShSGuZVOQyQWBdjyzDKQH+uA/D1n4e9d7qAGWXolSDlPQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E3C997D73ABB244A3E91AD41E1E6D04@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: camlintechnologies.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8920b67e-75e6-4e45-4954-08d7bb8e8827
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 14:08:34.3109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IagRPjRqUB3NU8NlAV/iliMopAhWTE4IcTJO6P+Z8gyT3c7Ia/KTV3xopMh4Vzt3lGvEmza7Me2va07XD7AQg7FsN2WvHoQi0Ni9nlNh8CFQzPFsclv8LCmi1wWERTa9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VyBkbml1IDI3LjAyLjIwMjAgb8KgMTM6MzksIExlY2ggUGVyY3phayBwaXN6ZToNCj4gVyBkbml1
IDI3LjAyLjIwMjAgb8KgMTM6MzYsIEdyZWcgS3JvYWgtSGFydG1hbiBwaXN6ZToNCj4+IE9uIFRo
dSwgRmViIDI3LCAyMDIwIGF0IDExOjA5OjQ5QU0gKzAwMDAsIExlY2ggUGVyY3phayB3cm90ZToN
Cj4+PiBIZWxsbywNCj4+Pg0KPj4+IEFmdGVyIHVwZ3JhZGluZyBrZXJuZWwgb24gb3VyIGJvYXJk
cyBmcm9tIHY0LjE5LjEwNSB0byB2NC4xOS4xMDYgd2UgZm91bmQgb3V0IHRoYXQgc3lzbG9nIGZh
aWxzIHRvIHJlYWQgdGhlIG1lc3NhZ2VzIGFmdGVyIG9uZXMgcmVhZCBpbml0aWFsbHkgYWZ0ZXIg
b3BlbmluZyAvcHJvYy9rbXNnIGp1c3QgYWZ0ZXIgYm9vdGluZy4NCj4+PiBJIGFsc28gZm91bmQg
b3V0LCB0aGF0IG91dHB1dCBvZiAnZG1lc2cgLS1mb2xsb3cnIGFsc28gZG9lc24ndCByZWFjdCBv
biBuZXcgcHJpbnRrcyBhcHBlYXJpbmcgZm9yIHdoYXRldmVyIHJlYXNvbiAtIHRvIHJlYWQgbmV3
IG1lc3NhZ2VzLCByZW9wZW5pbmcgL3Byb2Mva21zZyBvciAvZGV2L2ttc2cgd2FzIG5lZWRlZC4N
Cj4+PiBJIGJpc2VjdGVkIHRoaXMgZG93biB0byBjb21taXQgMTUzNDFiMWRkNDA5NzQ5ZmE1NjI1
ZTRiNjMyMDEzYjZiYTgxNjA5YiAoImNoYXIvcmFuZG9tOiBzaWxlbmNlIGEgbG9ja2RlcCBzcGxh
dCB3aXRoIHByaW50aygpIiksIGFuZCByZXZlcnRpbmcgaXQgb24gdG9wIG9mIHY0LjE5LjEwNiBy
ZXN0b3JlZCBjb3JyZWN0IGJlaGF2aW91ci4NCj4+IFRoYXQgaXMgcmVhbGx5IHJlYWxseSBvZGQu
DQo+IFZlcnkgb2RkIGl0IGlzIGluZGVlZC4NCj4+PiBNeSB0ZXN0IHNjZW5hcmlvIGZvciBiaXNl
Y3Rpbmcgd2FzOg0KPj4+IDEuIHJ1biAnZG1lc2cgLS1mb2xsb3cnIGFzIHJvb3QNCj4+PiAyLiBy
dW4gJ2VjaG8gdCA+IC9wcm9jL3N5c3JxLXRyaWdnZXInDQo+Pj4gMy4gSWYgdHJhY2UgYXBwZWFy
cyBpbiBkbWVzZyBvdXRwdXQgLT4gZ29vZCwgb3RoZXJ3aXNlLCBiYWQuIElmIHRyYWNlIGRvZXNu
J3QgYXBwZWFyIGluIG91dHB1dCBvZiAnZG1lc2cgLS1mb2xsb3cnLCByZS1ydW5uaW5nIGl0IHdp
bGwgc2hvdyB0aGUgdHJhY2UuDQo+Pj4NCj4+PiBJIHJhbiBteSB0ZXN0cyBvbiBEZWJpYW4gMTAu
MyB3aXRoIGNvbmZpZ3VyYXRpb24gYmFzZWQgZGlyZWN0bHkgb24gb25lIGZyb20gNC4xOS4wLTgt
YW1kNjQgKDQuMTkuOTgtMSkgaW4gUWVtdS4NCj4+PiBJIGNvdWxkIHJlcHJvZHVjZSB0aGUgc2Ft
ZSBpc3N1ZSBvbiBzZXZlcmFsIGJvYXJkcyB3aXRoIHg4NiBhbmQgQVJNdjcgQ1BVcyBhbGlrZSwg
d2l0aCAxMDAlIHJlcHJvZHVjaWJpbGl0eS4NCj4+Pg0KPj4+IEkgaGF2ZW4ndCB5ZXQgZGlnZ2Vk
IGludG8gd2h5IGV4YWN0bHkgdGhpcyBjb21taXQgYnJlYWtzIG5vdGlmaWNhdGlvbnMgZm9yIHJl
YWRlcnMgb2YgL3Byb2Mva21zZyBhbmQgL2Rldi9rbXNnLCBidXQgYXMgcmV2ZXJ0aW5nIGl0IGZp
eGVkIHRoZSBpc3N1ZSwgSSdtIHByZXR0eSBzdXJlIHRoaXMgaXMgdGhlIG9uZS4gSXQgaXMgcG9z
c2libGUgdGhhdCB0aGUgc2FtZSBoYXBwZW5lZCBpbiA1LjQgbGluZSwgYnUgSSBoYWRuJ3QgaGFk
IGEgY2hhbmNlIHRvIHRlc3QgdGhpcyBhcyB3ZWxsIHlldC4NCj4+IEkgY2FuIHJldmVydCB0aGlz
LCBidXQgaXQgZmVlbHMgbGlrZSB0aGVyZSBpcyBzb21ldGhpbmcgZWxzZSBnb2luZyB3cm9uZw0K
Pj4gaGVyZS4gIENhbiB5b3UgdHJ5IHRoZSA1LjQgdHJlZSB0byBzZWUgaWYgdGhhdCB0b28gaGFz
IHlvdXIgc2FtZQ0KPj4gcHJvYmxlbT8NCj4gWWVzLCBJJ2xsIGNoZWNrIGl0IGluIGEgc2hvcnQg
d2hpbGUuDQpJIGNoZWNrZWQgdjUuNC4yMiBqdXN0IG5vdyBhbmQgZGlkbid0IG9ic2VydmUgdGhl
IGlzc3VlLiBNYXliZSB0aGlzIGNvbW1pdCB3YXNuJ3QgZGVzdGluZWQgZm9yIDQuMTkueSBkdWUg
dG8gaW50cmljYWNpZXMgb2YgbG9ja2luZyBpbnNpZGUgcHJpbnRrKCkgOi0pDQoNCkZyb20gbXkg
c2lkZSwgdGhlcmUgaXMgbm8gbmVlZCB0byBydXNoIHdpdGggdGhlIHJldmVydCwgYXMgSSBjYW4g
ZG8gdGhpcyBsb2NhbGx5IGFuZCBkcm9wIHRoZSByZXZlcnQgd2l0aCBuZXh0IHJlYmFzZS10by11
cHN0cmVhbSwgd2hpY2ggd2UgZG8gdmVyeSBvZnRlbi4NCk9UT0gsIHRoZSBpc3N1ZSBpcyBsaWtl
bHkgdG8gYWZmZWN0IGEgbG90IG9mIHVzZXJzLCBlc3BlY2lhbGx5IG9uZXMgdXNpbmcgZGlzdHJv
cyB0cmFja2luZyB0aGlzIGJyYW5jaCBsaWtlIERlYmlhbiAxMCBtZW50aW9uZWQgZWFybGllciwN
Cm9uY2UgdGhleSBwaWNrIGl0IHVwIHRoZSBjaGFuZ2UsIGFzIHRoZSBrZXJuZWwgbG9nIGNvbnRl
bnQgcmVjb3JkZWQgYnkgc3lzbG9nIHdpbGwgYmUgYWZmZWN0ZWQsIGFuZCAnZG1lc2cgLS1mb2xs
b3cnIGJlaGF2aW91ciB3aWxsIGJlIHF1aXRlIHN1cnByaXNpbmcuDQo+PiB0aGFua3MsDQo+Pg0K
Pj4gZ3JlZyBrLWgNCkFsc28gQ0MnZWQgU2VyZ2V5LCBtYXliZSBoZSB3aWxsIGhhdmUgYSBjbHVl
IGFib3V0IHRoaXMuDQoNCi0tIA0KUG96ZHJhd2lhbS9XaXRoIGtpbmQgcmVnYXJkcywNCkxlY2gg
UGVyY3phaw0KDQpTci4gU29mdHdhcmUgRW5naW5lZXINCkNhbWxpbiBUZWNobm9sb2dpZXMgUG9s
YW5kIExpbWl0ZWQgU3AuIHogby5vLg0KDQo=
