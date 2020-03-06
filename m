Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D28C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C306F2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="uRIBqHF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFMQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:16:54 -0500
Received: from mail-eopbgr50128.outbound.protection.outlook.com ([40.107.5.128]:7070
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbgCFMQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:16:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlUiXieJ2mpaPBKIVrRIKlWwSfqe05vM3xlxOrfbXntnBiLY8ZPusaFbrkcTTY/IrhWocFqMsZ4OKmpu+L73uYQ+tBlcc3GvE5xjlgkAC2LoAGfMTny/0n9zbI6FZMmMABsAYZ/KIMspzbkL0UH7WSJf+nXYtFPHZ/TPJZPgFn17GiRTEo+BXSCMCFI7sf0bhY0XK8HEp9ChPsSqYB/6mgsTtXfiDIGFsZdd8SDD4VxeQjK8xVzs7y/xCreCW03fR8nEbLlr4v2FOghyrNI9bbfghelw1V/99r28VbOfUJJtga9KpobkAo2l+ETMW4NcH5MRw6XVz1gm+SciPUBLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E09GbmJqS9ei2PnP7pEqRYGj6enrrTw4hH06mXQHiw=;
 b=SkSDaP8jGJMzcnAvJoMT0KVs8gP0WC7pewIREO+BCrGj9Nf2uoQAbedzNRZ275S8FDnaTm7TAZuu+JqFgih01nvihbGNE441VRjXh7kMWNjuZGTb/4i83DR3ILDjfyOrBOEKYmNEwTxzQUpgiibj3zr2hVfASAbjO7OcRZOzjXzbjYDOeOfNssMZ3YvHbMuvx9aXNPTwikQfup8NtZItvu27lHHQT/S0TFnjJO0wffop3a+Wu2WNYyvRl558og9gTKxQZPqCrp1cXHRbVm/2uH/axZfiWKoZHJ4eWkmSXEa2kbdALfDLZVgXYbRb7yP1pjgfKEZTgurPloXrWwpboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E09GbmJqS9ei2PnP7pEqRYGj6enrrTw4hH06mXQHiw=;
 b=uRIBqHF7tp2mn7JKI6reelxZlXqtzQU/eVPQVWxL13MIOvtiVGu5xhMGQu9nRZPRg5GYKje4/js4M1r+XS/H6F7I6433HRcNR43gfK/qmaC0P0YMIcGfi7pyuIFHdWeKJqSFRSNWMM1o/D8bOwFKbM8WB5wjUhD+Sp+4TIax/dg=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (20.179.1.217) by
 AM6PR05MB4197.eurprd05.prod.outlook.com (52.135.164.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Fri, 6 Mar 2020 12:16:49 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e%4]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 12:16:49 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Topic: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Index: AQHV8vTsfP1BktnxKEy+q0EhrXMNZqg6EXKAgAAlWYCAAPjzgIAAIqIAgAAYeQCAABF0AA==
Date:   Fri, 6 Mar 2020 12:16:49 +0000
Message-ID: <e8ab2b1953dfd27fa38a15b2a3481584c7b53545.camel@toradex.com>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
         <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
         <20200305165145.GA25183@lunn.ch>
         <7191ffe6-642a-477c-ec37-e37dc9be4bf8@pengutronix.de>
         <4e48d56f184ed56d15d2ae6706fdb29e4c849132.camel@toradex.com>
         <f47a46b9-6d6a-e257-4309-7e49852bc88e@pengutronix.de>
In-Reply-To: <f47a46b9-6d6a-e257-4309-7e49852bc88e@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0b4b8e1-0f8b-4ebd-e175-08d7c1c83f27
x-ms-traffictypediagnostic: AM6PR05MB4197:
x-microsoft-antispam-prvs: <AM6PR05MB4197B66E2EF1EFCB41BAD188F4E30@AM6PR05MB4197.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(136003)(39850400004)(346002)(366004)(199004)(189003)(6486002)(66946007)(6512007)(44832011)(7416002)(36756003)(91956017)(2616005)(71200400001)(76116006)(5660300002)(66476007)(64756008)(54906003)(66556008)(8676002)(478600001)(316002)(110136005)(66446008)(6506007)(81166006)(86362001)(81156014)(53546011)(26005)(186003)(2906002)(4326008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB4197;H:AM6PR05MB6120.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MWQtueJcWhPLefsSkmcRwdXVdKaE+4SvxR8K5TxQLMkz8sBgOUT6xGyj7R4yQsFqjnbHr5q0ntUBFIA0uvHgXqZveJQNK4iDctAwKIb52DggseXKqK2wbfzDjlfbnwPFhzSAdey0fOSphjx2hMZOoj4UrVBjOYn+ULDxM1lW1uEBNV2ldUsjIggkmqYc/w4NB/BzGpKAU+5NYAqcbku3/RiKDfBDBIru9h9INq+/s3GV7VKDjfeREmQ2QixuUN3VKD1d6zxlGJYXnOu8V/iIm0jjpiDjfpkznht5JU2Rt4aLyaKKmSjupOo+dXMZoJROme11fXTicRhtrs4S1cl9b5Fc2OjcT9fAH02aQyFIphXU8HkmAWjLu9RCnKi0tu2UhfRPYG4ivmyvm7DMb2ovC2XrAViuVtcZkYPflcsMR/DOGtsVDJIqpWqUlIPiKCDy
x-ms-exchange-antispam-messagedata: MU/JIAr4Xls1bQfTaMmlS6AzduJre3Dnbzep7Hn1csKwwoeaHAQUueqdvO4mqWBDzC4vM0EHisNy/T6JejL4WHVmKQjK6rkcX7hdobbdjOiTuQQvTN9jlmvYHCYspffi3+p9NOXicCjQgXy4+MMLlw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <67C1775E882C2F4495C3ADF89349F3E7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b4b8e1-0f8b-4ebd-e175-08d7c1c83f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 12:16:49.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10/42m/d7SNKQoXDVl0UrTx0/R3VI0aVWoJbqJuZ2p3yfKB+ko1tiSk/WLq69jVn+Q3AfUeM/HnZwuAgxg63dXRpVDBLWzO6cx+ZYCjy6ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTA2IGF0IDEyOjE0ICswMTAwLCBBaG1hZCBGYXRvdW0gd3JvdGU6DQo+
IEhlbGxvIFBoaWxpcHBlLA0KPiANCj4gT24gMy82LzIwIDEwOjQ2IEFNLCBQaGlsaXBwZSBTY2hl
bmtlciB3cm90ZToNCj4gPiBIaSBBbmRyZXcgYW5kIEFobWFkLCB0aGFua3MgZm9yIHlvdXIgY29t
bWVudHMuIEkgdG90YWxseSBmb3Jnb3QNCj4gPiBhYm91dA0KPiA+IHRob3NlIG1vcmUgc3BlY2lm
aWMgcGh5LW1vZGVzLiBCdXQganVzdCBiZWNhdXNlIG5vbmUgb2Ygb3VyIGRyaXZlcg0KPiA+IHN1
cHBvcnRzIHRoYXQuIEVpdGhlciB0aGUgaS5NWDYgZmVjLWRyaXZlciBhcyB3ZWxsIGFzIHRoZSBt
aWNyZWwuYw0KPiA+IFBIWQ0KPiA+IGRyaXZlciBzdXBwb3J0cyB0aGlzIHRhZ3MuDQo+ID4gV2hh
dCBkbyB5b3UgZ3V5cyBzdWdnZXN0IHRoZW4gaG93IEkgc2hvdWxkIGltcGxlbWVudCB0aGF0IHNr
ZXcNCj4gPiBzdHVmZj8NCj4gDQo+IEkgdGhpbmsgaW1wbGVtZW50aW5nIHRoZW0gaW4gdGhlIE1p
Y3JlbCBkcml2ZXIgd291bGQgbWFrZSBzZW5zZS4NCj4gV2hlbiBtb3JlIHNwZWNpZmljIHNrZXdz
IGFyZSBzdXBwbGllZCwgdGhlc2UgYXJlIHVzZWQuDQo+IElmIG5vdCwgdGhlIHJnbWlpX1t0eF0/
aWQgYXBwbGllcyB0aGUgYXBwcm9wcmlhdGUgdGltaW5ncyBmb3IgbGVuZ3RoDQo+IG1hdGNoZWQN
Cj4gbGluZXMuIERldmljZSB0cmVlcyBtYXRjaGluZyB5b3VyIHVzZSBjYXNlIHdpbGwgdGhlbiBv
bmx5IGhhdmUgdG8NCj4gc3BlY2lmeQ0KPiByZ21paS10eGlkLiANCj4gDQo+ID4gVGhlIHByb2Js
ZW0gaXMgdGhhdCBpLk1YNiBoYXMgYW4gYXN5bmNocm9uaWMgc2tldyBvZiAtMTAwIHRvIDkwMHBz
DQo+ID4gb25seQ0KPiA+IGVuYWJsaW5nIHRoZSBQSFktZGVsYXkgb24gVFhDIGFuZCBSWEMgaXMg
bm90IGluIGFsbCBjYXNlcyB3aXRoaW4gdGhlDQo+ID4gUkdNSUkgdGltaW5nIHNwZWNzLiBUaGF0
J3Mgd2h5IEkgaW1wbGVtZW50ZWQgdGhpcyAnd2VpcmQnIG51bWJlcnMuDQo+IA0KPiBJIGFtIG5v
dCB0b28gd2VsbC12ZXJzZWQgd2l0aCB0aGlzLiBXaGF0J3MgYW4gYXN5bmNocm9uaWMgc2tldz8N
Cj4gQSBub24tZGV0ZXJtaW5pc3RpYyBpbnRlcm5hbCBkZWxheS4uPyBTbywgeW91IHRyeSB0byBi
ZSBhcyBhY2N1cmF0ZSBhcw0KPiBwb3NzaWJsZSwgc28gdGhlIHNrZXcgaXMgd2l0aGluIHRoZSBh
Y2NlcHRhYmxlIG1hcmdpbj8NCg0KQXN5bmNocm9uaWMgd2FzIGEgdGVybSBJIGludHJvZHVjZWQg
YmVjYXVzZSBpbiBSR01JSSBzcGVjLCBUWEMgb2YgYSBNQUMNCnNob3VsZCBoYXZlIC01MDAgdG8g
NTAwcHMgc2tldy4gSG93ZXZlciB0aGUgaS5NWDYgaGFzICJhc3luY2hyb25pYyIgLTEwMA0KdG8g
OTAwcHMuDQoNCkkgZGlkIGEgd29yc3QtY2FzZSBzdHVkeSBvZiB0aG9zZSB0aW1pbmcgdmFsdWVz
LiBJZiBJIG9ubHkgZW5hYmxlIHRoZQ0KMm5zIGRlbGF5IG9uIHRoZSBLU1o5MTMxIFBIWSB0aGlz
IGlzIHJlc3VsdGluZyBpbiBhIFRfc2V0dXBfVCBvZiAxLjktDQoyLjRucyAobWluLW1heCkuIFVu
ZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGN5YyAoY3ljbGUgdGltZSBvZiB0aGUNCmNsb2NrKSBo
YXMgbWluLW1heCBvZiA3LjItOC44bnMgdGhpcyByZXN1bHRzIGluIFRfaG9sZF9UIHZhbHVlcyBv
ZiBtaW4tDQptYXggMC43LTIuNW5zLiBUaGUgMC43bnMgc2hvdWxkIGJlIGF0IGxlYXN0IDFucyBh
Y2NvcmRpbmcgdG8gc3BlYy4NCg0KSWYgSSBmaW5lIHR1bmUgdGhlc2UgdmFsdWVzIHdpdGggdGhl
IG90aGVyIHJlZ2lzdGVycyBJIGNhbiAibWlkZGxlLW91dCINCnRoZSBjbG9jay1lZGdlcyBpbiBy
ZWxhdGlvbiB0byBkYXRhIHNpZ25hbHMgYW5kIHRoZXJlZm9yZSBJIGdldCBhbGwNCnZhbHVlcyB0
byBiZSB3aXRoaW4gUkdNSUkgdGltaW5nIHNwZWNzLg0KPiANCj4gQ2hlZXJzDQo+IEFobWFkDQo+
IA0KPiANCj4gPiBQaGlsaXBwZQ0KPiA+IA0K
