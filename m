Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0953C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B3F2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fbk/n8el";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tyRLY0gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgG1I22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:28:28 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:9347 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgG1I22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595924907; x=1627460907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lm+N48S5Uq+yCnUNt9kr34UN4ANy62YN5kFOkfoXbnQ=;
  b=fbk/n8elKHe1ZY2Emj0GTaizy+PbVQFSre65NPUvjMaNJjmPysX0M8Dt
   3PcD2qntjGjr5O1G4JMwSml45ekW0MDdR1L6my5WORbg54B4Vk96vetzX
   7uqtJxp3o3I8PFsbEN7LhgWdb3ksJzYGR2JUWwGh91ER0CCkeS8/63+ch
   pcTX28wpm0x4xDx9NUccKBFzRTuTVpV0ZSaEq3FrS4L6Zwvl0rfHc/sWj
   Nm17RxSaaCdR2CSCSAVUWPF4dcuVouS3U8fRcHhJhE35i+yiCHkj9Lo4M
   wG5t+fy2rqnTbqTtaDCIuavklTpVqkLgExeNDCuoVdpOuabnBD3/Fnlof
   A==;
IronPort-SDR: zcyaraZ92XDdt38sG3yaP2LEC5UPwTOjZD2S4YN80+tcQmolDa2K0sZFMcGF8I3fkFvnZIkEe4
 WMpD4bXgxLf1q7Qc3cVlT3EvUuDpiICwsTIhGv+ogKHh6ZJD07Isj/jyG4ums6AWAMMOZ5gT5R
 KFjEc4kgSxXxgpl6xMzN0p7ePPKlsWh7IGO9QAADjO5Q/0S0Z9UlF06luNyvYJffhOLbYZ2dOM
 sy10YbWtGcutKQdg5v9/zdb8U2LCPvmiIcbKZ8S8pZDGm997UeZsU9IkE2OrPU6YowPhPj3tUc
 K9s=
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="89400873"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2020 01:28:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 01:28:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 28 Jul 2020 01:28:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2duDNWecVN0yhijX/kUKXeMD00139xqAh1swlux2quR65YW/El7yF/fT853Xq94NcJIA7AWMlTe3YK0RrHAWZP/oKRBu2CTjQMUS70ii71XhJLIxp854IPBeXotzbuJe7XkqtwGDX5hXfe61tf4GYSAonBvQzNuzS5d6joCIcUw9Ij2lH5OPx41CZ7meJKMXZYlT7W1uyYfp+KEmwn1g0a06E2Ege9x3Qiksdb+yfdKAMCZFNL55s/0QV68r/72VlM/8iE6NCnEWtmPiHKViKrAPaAZwhjSjG2Dnie+Oixfc0MaUOXF/sSC4TYcZTTaN6JpcrX0VrLnh0kpUpu3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm+N48S5Uq+yCnUNt9kr34UN4ANy62YN5kFOkfoXbnQ=;
 b=CBV1QpI4J2W4/u/Iwb5gHGFww8qjnseoNpA5nyoapcG/SUYUCHl7MkpQ82o727p3tCDfcEdk/MzVoUYkmqSYwQyOIF8mickiXUe2MIpY8FOIISOUm3wb6dE4EwUQVqajSDeuxfZzS2tkePMLfrbfNApxyIVll0QPzjapqAU6nM/yeH/6QacRxJwY+zrex075Tr5DhfvW4Mq93khknT/pd/WcgNQApj+n2m4tuLalNT6bca3Ooc1qR8xt7yJpVgf6y55COXAbStKPeYYSJaJh4Pgkj5P0QWF+X+deJrFFcNPOimIYet8nZ02ZF96XiKfZrSUq4CeE4o4P6k7wd3Th6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm+N48S5Uq+yCnUNt9kr34UN4ANy62YN5kFOkfoXbnQ=;
 b=tyRLY0gisOFJFc72piOn6xs0Uz/5EHeXpcLKZmkyCAEyUFF1I9Z3wwVmlWYN0aDQ1v+y0Nr16orBUZCIb0zVZDSISO6bpmsyTM6hi37FMoRNFh4tPVGl6nJ6qu5/zNV7OqPZsBT6sFgphlhpw13Pi/PdSKdfSSh2E4pdbJ4gO5U=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4121.namprd11.prod.outlook.com (2603:10b6:5:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 08:28:22 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 08:28:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexander.sverdlin@nokia.com>, <luisalberto@google.com>
CC:     <vigneshr@ti.com>, <bbrezillon@kernel.org>, <richard@nod.at>,
        <jethro@fortanix.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mtd: revert "spi-nor: intel: provide a range for
 poll_timout"
Thread-Topic: [PATCH] mtd: revert "spi-nor: intel: provide a range for
 poll_timout"
Thread-Index: AQHWYEoGCAqTB2Up30yP+LHzC/Sy+w==
Date:   Tue, 28 Jul 2020 08:28:22 +0000
Message-ID: <afddc35d-fcef-695c-1522-df871f169a2d@microchip.com>
References: <20200610224652.64336-1-luisalberto@google.com>
 <40ef3da0-56f4-3c78-f875-a750afaf2ec5@nokia.com>
 <df774dcb-edd1-ae7a-0e26-2e7c324406ff@microchip.com>
 <ca4d6a2f-b3c8-2b52-431e-81f3cb956db7@nokia.com>
In-Reply-To: <ca4d6a2f-b3c8-2b52-431e-81f3cb956db7@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25821337-606e-4849-fd97-08d832d030d3
x-ms-traffictypediagnostic: DM6PR11MB4121:
x-microsoft-antispam-prvs: <DM6PR11MB412195EDB4508D8E87F3A552F0730@DM6PR11MB4121.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCNoAUoXA7V6BG8HGBCJEp2VB/Fc0X+kYLPjdx0ZSyeBBZ1wAdWoq9h/S3F7B+2zGN8txJ11KXfMWrHoposU6XGXl4lYbcrdfnr7dhtVGbQbubtMHUjtl2qDv38Ghg0zlYRhe5Sb74kJLtr+0euRfdLuO3yPS2qy/Np/V5rBBhuKj8I26RMtTrCiTkPlkU1yQMq4OK8KYJFH3pJXO5eXnm/Tnard9OIKS9WjBG3ZTkWI6spMhiUefSCilg+pgt2a6kfkrfAuh0cbkxt8LkrMuuwPYdxoA8HLlBjlTc6bWrBpr3ZUGp8PCyL/pv5lnkJJDyKK/07aPlCYmXheyyi43Qv/HtXb4pel167j7JCSF7nx5GfrVzM8t9V7e7amrnkEQilm61qNF9OARgOnC5wqhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(396003)(366004)(39860400002)(8936002)(7416002)(71200400001)(53546011)(478600001)(316002)(296002)(2906002)(6486002)(8676002)(36756003)(4326008)(26005)(31686004)(86362001)(110136005)(5660300002)(6512007)(6506007)(64756008)(66556008)(66476007)(66446008)(66946007)(76116006)(91956017)(186003)(2616005)(54906003)(31696002)(21314003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RFnGQiMN1LocalPeUcCYQbOB7LpJkhLaRRHfGbV5yMENrhcDMW+iRr7cBL2pPwNMO6iLoP5wpPzlCAuuHr6aq0ZGg0TBJi8DlFI57P2VXhBTaW6MCnCxpvA0E3CJn28rCFVAuK+D29UJABscaH7401OLM2OE9q7pvQtc0dQvGOopoMGTuGAxNRyCY64oZo0+HUm9ja6e5ACdMl6Q+VnUGGD1IDEdEvr4rLQ1NCs9wvnipe9GgHXzid4vE1yp1WTntcq9uyCVSZMD45VDK+SchSrUgMpaJRGcnOqfAiqgXyYAVlhrEJb2iT8X8l0jZN6aQ8U3u60YIhp+08EwwswMSpkDkRHAZ0takMhT/SKUynISVeXJfdIIoIjrkAIwjtz5D+0hRLQPInYh+IILFU2n+HtCPmp2ikzLADgI5+a6LNfRLFuIxDjSXJt5kXv5RnwXBZi/SfAyQQwHDu/Pi7XgdKhmIlLdM95ege9Zgun9dHI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8AE6A9B3745D44C88CED34792773CE1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25821337-606e-4849-fd97-08d832d030d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 08:28:22.5241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QP43u4zrH+h8LM/ifXXi3UO1KGO6Oe1qju7WWJPNRJA04qn+O+6Eb6VpXIdVr19/bBX7jhOgKhZ3grB+HtgMxwTSu4CY9AWPSHEXchfMrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1pa2EsDQoNCk9uIDcvMjMvMjAgMTI6MDUgUE0sIEFsZXhhbmRlciBTdmVyZGxpbiB3cm90
ZToNCj4gDQo+IEhlbGxvIFR1ZG9yLA0KPiANCj4gT24gMjIvMDcvMjAyMCAxOTowMywgVHVkb3Iu
QW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gNy8yMi8yMCA3OjM3IFBNLCBBbGV4
YW5kZXIgU3ZlcmRsaW4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+PiBJJ3ZlIHBlcmZvcm1l
ZCBteSB0ZXN0aW5nIGFzIHdlbGwgYW5kIGdvdCB0aGUgZm9sbG93aW5nIHJlc3VsdHM6DQo+Pj4N
Cj4+PiBWYW5pbGxhIExpbnV4IDQuOSAoaS5lLiBiZWZvcmUgdGhlIGludHJvZHVjdGlvbiBvZiB0
aGUgb2ZmZW5kaW5nDQo+Pj4gcGF0Y2gpOg0KPj4+DQo+Pj4gZGQgaWY9L2Rldi9mbGFzaC9ieS1u
YW1lL1hYWCBvZj0vZGV2L251bGwgYnM9NGsNCj4+PiAxMjgwKzAgcmVjb3JkcyBpbg0KPj4+IDEy
ODArMCByZWNvcmRzIG91dA0KPj4+IDUyNDI4ODAgYnl0ZXMgKDUuMiBNQiwgNS4wIE1pQikgY29w
aWVkLCAzLjkxOTgxIHMsIDEuMyBNQi9zDQo+Pj4NCj4+PiBWYW5pbGxhIDQuMTkgKGkuZS4gd2l0
aCBvZmZlbmRpbmcgcGF0Y2gpOg0KPj4+DQo+Pj4gZGQgaWY9L2Rldi9mbGFzaC9ieS1uYW1lL1hY
WCBvZj0vZGV2L251bGwgYnM9NGsNCj4+PiAxMjgwKzAgcmVjb3JkcyBpbg0KPj4+IDEyODArMCBy
ZWNvcmRzIG91dA0KPj4+IDUyNDI4ODAgYnl0ZXMgKDUuMiBNQiwgNS4wIE1pQikgY29waWVkLCA2
LjcwODkxIHMsIDc4MSBrQi9zDQo+Pj4NCj4+PiA0LjE5ICsgcmV2ZXJ0Og0KPj4+DQo+Pj4gZGQg
aWY9L2Rldi9mbGFzaC9ieS1uYW1lL1hYWCBvZj0vZGV2L251bGwgYnM9NGsNCj4+PiAxMjgwKzAg
cmVjb3JkcyBpbg0KPj4+IDEyODArMCByZWNvcmRzIG91dA0KPj4+IDUyNDI4ODAgYnl0ZXMgKDUu
MiBNQiwgNS4wIE1pQikgY29waWVkLCAzLjkwNTAzIHMsIDEuMyBNQi9zDQo+Pj4NCg0KW2N1dF0N
Cg0KPiB3aXRoIDEwdXMgaXQgbG9va3MgbGlrZSB0aGlzOg0KPiANCj4gZGQgaWY9L2Rldi9mbGFz
aC9ieS1uYW1lLy4uLiBvZj0vZGV2L251bGwgYnM9NGsNCj4gMTI4MCswIHJlY29yZHMgaW4NCj4g
MTI4MCswIHJlY29yZHMgb3V0DQo+IDUyNDI4ODAgYnl0ZXMgKDUuMiBNQiwgNS4wIE1pQikgY29w
aWVkLCA0LjMzODE2IHMsIDEuMiBNQi9zDQo+IA0KPiBXaGljaCBtZWFucywgdGhlcmUgaXMgYSBw
ZXJmb3JtYW5jZSByZWdyZXNzaW9uIGFuZCBpdCB3b3VsZCBkZXBlbmQgb24NCj4gdGhlIHRlc3Qg
Y2FzZSwgaG93IGJhZCBpdCB3aWxsIGJlLi4uDQo+IA0KDQpXZSBuZWVkIGEgYml0IG9mIGEgY29u
dGV4dCBoZXJlLiBVc2luZyBhIHRpZ2h0LWxvb3AgZm9yIHBvbGxpbmcgYW5kDQpoYXZpbmcgYSA1
IHNlY3MgdGltZW91dCBpcyBmaXNoeS4gRm9yIGFueXRoaW5nIHRoYXQncyBleHBlY3RlZCB0bw0K
Y29tcGxldGUgbGVzcyB0aGFuIGEgZmV3IHVzZWMsIGl0J3MgdXN1YWxseSBiZXR0ZXIgdG8gcG9s
bCBjb250aW51b3VzbHksDQpidXQgdGhlbiBhIHRpbWVvdXQgb2YgNXMgaXMgd2F5IHRvbyBiaWcu
IENhbiB3ZSBzaHJpbmsgdGhlIHRpbWVvdXQgdG8NCmZldyBtc2Vjcz8NCg0KSSdsbCBxdWV1ZSB0
aGlzIHRvIHNwaS1ub3IvbmV4dCB0byBmaXggdGhlIHBlcmYgcmVncmVzc2lvbiwgYnV0IEkgd291
bGQNCmxpa2UgdG8gY29udGludWUgdGhlIGRpc2N1c3Npb24gYW5kIHRvIGNvbWUgdXAgd2l0aCBh
biBpbmNyZW1lbnRhbCBwYXRjaA0Kb24gdG9wIG9mIHRoaXMgb25lLg0KDQpDaGVlcnMsDQp0YQ0K
