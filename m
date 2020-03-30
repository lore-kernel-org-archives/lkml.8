Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79778C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0982220733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="esdpNHNx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DeIuBGzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgC3VSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:18:33 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:41438 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728407AbgC3VS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:18:29 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D601E43B47;
        Mon, 30 Mar 2020 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585603108; bh=w11nOFzhODGImKpvVLVlfICBlG0r3QFveGD4roxtLGk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=esdpNHNxaw/8j0EVAw1F5joINnzHDmoKk9NhSjjic/nMdxJMwUrMGo37spAJpCDPo
         NID29G9mF2sXlrnDntuBxVcHk0hawR4nIMz49V5sqSJJnxiLcx9wMx/dPjgrFh70h9
         yYVbeZP+OHe7ScbTeplgEJ0PTJakAuLe2wFOO2pqvsWnhBtsuOj/5l4XoYkZmUBt9X
         mmWngKc/pJTFP2aeHT8SMerPiicWdgQwD4C318ZydvHGGNsu49wLEYI9Q3J5ckMBDP
         OmIOMpQpzccqO7GDzl4TdIMPGhBorVKen2w4UgknNqQaCOMiwceWlA1gSorMLsQeoA
         l1Lu5EOERt5Pg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A9A33A008A;
        Mon, 30 Mar 2020 21:18:15 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 30 Mar 2020 14:17:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 30 Mar 2020 14:17:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScxVa1oJQWe9WfdH/Ma3kkpMbIEhQyV9U198bw1MQ+b2hZQqJD43h2Gwrt+70OzIzMP1cf5qtZgdiIsc/0JEic3mQY5yZhQmxpyKgtH0+3kYlWUlHXcSFnSBP+XcnM/lPZzTRh9M91NfnziSv2AJ9rdtkX6/1iFSEqG4kBS3CebXJrRgLeVKXOevnAU1Dk1PrVyzCXuV2WZRXwzaJo2QOlAjEHembOoFkGakzv9c7vOHzW6jLUfx9BXp0etzO81hozvznZ1HOkkkFEsyc22ph4LP4OJ15duGsL7PLJSYa4YTdj+sYLITkvFFbx0cf0N9Dacv6JnwIdgXTFAbsSrp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w11nOFzhODGImKpvVLVlfICBlG0r3QFveGD4roxtLGk=;
 b=KWopbTB6kcjHcztB2j7oaPMkmuXRzYWQF+0lUVYUWM09ZIrU7nsUGIUjZ0Wae6ZE3Sz6XuwaBSZNWWVsTzI6SZ6t9phAtwUfh9kgVGEnaoLnv8/9TBUZwdZYWtdfsM6odvLvFxSxBq5ulviX1tHrHbUjRYTZCtZPFmXivyYwBT5zJFddtIyDwCrErWeBRAkudpBu6MbBXszOF8gf5wl6Z+IFbb6BIzI7cI9Hsad+AitI1Xu/htxPj3eSCYfYuUwNrgMvqJtketEBknEHbolmL6T7Ej/yfYrqQib84oLPnWnKt1emE1X8FQPVD8v9EYtGJzSpLYDwBLg0jVdzKaGrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w11nOFzhODGImKpvVLVlfICBlG0r3QFveGD4roxtLGk=;
 b=DeIuBGzEn+OJwb9DzxQhbJ1guDXRLfclmEAyus920pHQHUzCKL/CXek/eZm3BAq6EDAOjiKt/FFVTaK9/L47BSc6MXM8P4BOCWXz4hDwLfKxWD+B1reQbmdqJylrLUL3kjZR99vILCEBMShajLuJNt3fn/2Ni+Y8d1PPsTdU+bA=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB2662.namprd12.prod.outlook.com (2603:10b6:a03:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 30 Mar
 2020 21:17:33 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 21:17:33 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build regressions/improvements in v5.6
Thread-Topic: Build regressions/improvements in v5.6
Thread-Index: AQHWBpcvcUuu+ZudzU+b+A9JmGkSJahhl0cwgAAMygA=
Date:   Mon, 30 Mar 2020 21:17:33 +0000
Message-ID: <c8447243-98c6-d545-9766-e6b3f33f4d13@synopsys.com>
References: <20200330085854.19774-1-geert@linux-m68k.org>
 <CAHp75Vc1gW2FnRpTNm6uu4gY3bSmccSkCFkAKqYraLincK29yA@mail.gmail.com>
 <CAMuHMdXDBtOo_deXsmX=zA9_va0O5j8XydxoigmS35+Tj7xDDA@mail.gmail.com>
 <CAHp75VfsfBD7djyB=S8QtQPdKTkpU5gFzyRYr8FshavoWgT0CA@mail.gmail.com>
 <CY4PR1201MB01204FB968A6661FB8B295ACA1CB0@CY4PR1201MB0120.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB01204FB968A6661FB8B295ACA1CB0@CY4PR1201MB0120.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [24.7.46.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b087d53-7b87-4157-abd8-08d7d4efc374
x-ms-traffictypediagnostic: BYAPR12MB2662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB266296C507D145ADE8BB4223B6CB0@BYAPR12MB2662.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(376002)(346002)(136003)(39860400002)(396003)(66446008)(110136005)(186003)(54906003)(6512007)(66556008)(2906002)(66946007)(26005)(76116006)(316002)(478600001)(64756008)(966005)(66476007)(53546011)(81166006)(6506007)(4326008)(8936002)(31686004)(71200400001)(81156014)(8676002)(6486002)(31696002)(2616005)(5660300002)(36756003)(86362001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MefosHNoBFOZX4sTLVOzji5a24eQbpxAHzFEjocd1eNCtWmLjOm4lkSM+Azi18H/6dZ/6rstCaYs7sKt8xx8ZwRvPQsD/piDN15ZXZN72ahrX7axzn6zujwzMsPC8wnzJ6NGk7lni8Wk1PQ/wGjrv4WiRuEpWnRAujjzrbxUFdQfRUUmEm/9fjruT0Zwnq1DwVqL1nGNfH8V5mWhwB8azd3gKrapAJ5Xj7J38r8X/sa6iUi0VviHWwUrtcXPScFCFui6rzz4aQmir4vw5ckDHOJeH54JYbAqQ2z84olgZaYoFu152/ebPsdc4VLY86qFg9U4vNpTl2Uj7uqMq7RtMyUshuI7v1Wa7svzkfPab0sP/97mm6ZXtNf7KYrKOLCWHnvi8boQk6dg88LO+L+OlV54nsZACvXpFr/SOHoR3jpztoZp79FQ1sUszuPh6A/ssqkRoXtOmaItgfgogqO1YPGQILC4LDmg1Kkg0qlUrkroWcnPm3A5PfLtAujj/f2Agp5o2m+VnGuJoQ+MJN5lyA==
x-ms-exchange-antispam-messagedata: dn2o0802iOFx2X98jgqwAoDy8MSENvPZ6W7ZE+Iuovak7AS+BkFwrir8GiTGfwb6JQb3VdfGJjXm+P1lUZJkK6Cs6YQbRM+HoDrjzhiyYy84+jmFnZzhd9/8vNXYaHmroEQXoF6Lb4xTzP0+HeFSWA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <37B9FEBB70A4894B89C41D78191D95AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b087d53-7b87-4157-abd8-08d7d4efc374
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 21:17:33.6760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZ13Z+ig2srQUDEu+Tlr2Y8y7a+nUMhr46OjP2xuzb2wuaA6kEDJ4Y6bTLYKWqOqqrkNMa2iXeufvuV5ltQtHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2662
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8zMC8yMCAxOjQwIFBNLCBBbGV4ZXkgQnJvZGtpbiB3cm90ZToNCj4gSGkgQW5keSwgR2Vl
cnQsDQo+IA0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IEFuZHkgU2hl
dmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4+IFNlbnQ6IE1vbmRheSwgTWFy
Y2ggMzAsIDIwMjAgNDoyOCBQTQ0KPj4gVG86IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGlu
dXgtbTY4ay5vcmc+OyBBbGV4ZXkgQnJvZGtpbiA8YWJyb2RraW5Ac3lub3BzeXMuY29tPg0KPj4g
Q2M6IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+DQo+PiBTdWJqZWN0OiBSZTogQnVpbGQgcmVncmVzc2lvbnMvaW1wcm92ZW1lbnRzIGluIHY1
LjYNCj4+DQo+PiBPbiBNb24sIE1hciAzMCwgMjAyMCBhdCA0OjI2IFBNIEdlZXJ0IFV5dHRlcmhv
ZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+IHdyb3RlOg0KPj4+DQo+Pj4gSGkgQW5keSwNCj4+
Pg0KPj4+IE9uIE1vbiwgTWFyIDMwLCAyMDIwIGF0IDM6MDggUE0gQW5keSBTaGV2Y2hlbmtvDQo+
Pj4gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0KPj4+PiBPbiBNb24sIE1hciAz
MCwgMjAyMCBhdCAxMjowMCBQTSBHZWVydCBVeXR0ZXJob2V2ZW4NCj4+Pj4gPGdlZXJ0QGxpbnV4
LW02OGsub3JnPiB3cm90ZToNCj4+Pj4+IEJlbG93IGlzIHRoZSBsaXN0IG9mIGJ1aWxkIGVycm9y
L3dhcm5pbmcgcmVncmVzc2lvbnMvaW1wcm92ZW1lbnRzIGluDQo+Pj4+PiB2NS42WzFdIGNvbXBh
cmVkIHRvIHY1LjVbMl0uDQo+Pj4+DQo+Pj4+PiAgICsgL2tpc3NrYi9zcmMvaW5jbHVkZS9saW51
eC9kZXZfcHJpbnRrLmg6IHdhcm5pbmc6IGZvcm1hdCAnJXp1JyBleHBlY3RzIGFyZ3VtZW50IG9m
IHR5cGUNCj4+ICdzaXplX3QnLCBidXQgYXJndW1lbnQgOCBoYXMgdHlwZSAndW5zaWduZWQgaW50
JyBbLVdmb3JtYXQ9XTogID0+IDIzMjoyMw0KPj4+Pg0KPj4+PiBUaGlzIGlzIGludGVyZXN0aW5n
Li4uIEkgY2hlY2tlZCBhbGwgZGV2X1dBUk5fT05DRSgpIGFuZCBkaWRuJ3QgZmluZCBhbiBpc3N1
ZS4NCj4+Pg0KPj4+IGFyY3YyL2F4czEwM19zbXBfZGVmY29uZmlnDQo+Pj4NCj4+PiBJdCdzIHBy
b2JhYmx5IGR1ZSB0byBhIGJyb2tlbiBjb25maWd1cmF0aW9uIGZvciB0aGUgYXJjIHRvb2xjaGFp
bi4NCj4+DQo+PiBBbGV4ZXksIGRvIGhhdmUgYW55IGluc2lnaHQ/DQo+IA0KPiBJIHRoaW5rIEkg
ZG8gaGF2ZSBzb21lIGJ1dCBmaXJzdCBJJ2QgbGlrZSB0byBnZXQgaXQgcmVwcm9kdWNlZCBteXNl
bGYuDQo+IEkganVzdCBidWlsdCB2NS42IHdpdGggaGVscCBvZiBib3RoIEdDQyA4LjMuMS0gJiA5
LjMuMS1iYXNlZCB0b29sY2hhaW5zDQo+IGFuZCBkaWRuJ3Qgc2VlIGEgc2luZ2xlIHdhcm5pbmcu
IFNvIEkgZ3Vlc3MgSSB3YXMgZG9pbmcgc29tZXRoaW5nIHdyb25nLg0KPiANCj4gRldJVw0KPiAN
Cj4gMS4gTXkgR0NDIDguMy4xIHRvb2xjaGFpbiB3YXMgZXhhY3RseSB0aGlzOg0KPiBodHRwczov
L2dpdGh1Yi5jb20vZm9zcy1mb3Itc3lub3BzeXMtZHdjLWFyYy1wcm9jZXNzb3JzL3Rvb2xjaGFp
bi9yZWxlYXNlcy9kb3dubG9hZC9hcmMtMjAxOS4wOS1yZWxlYXNlL2FyY19nbnVfMjAxOS4wOV9w
cmVidWlsdF91Y2xpYmNfbGVfYXJjaHNfbGludXhfaW5zdGFsbC50YXIuZ3oNCj4gDQo+IDIuIExp
bnV4IGtlcm5lbCBpcyB2YW5pbGxhIHY1LjYuMA0KPiANCj4gMy4gQ29uZmlndXJlZCBhbmQgYnVp
bHQgYXMgc2ltcGxlIGFzOg0KPiAgICBtYWtlIGF4czEwM19zbXBfZGVmY29uZmlnICYmIG1ha2UN
Cg0KSXQgc2VlbXMgdGhlIGJ1aWxkIHNlcnZpY2UgaXMgdXNpbmcgYSBhcmMgdG9vbGNoYWluIGJ1
aWx0IGluIDIwMTYgOi0pDQoNCiMgPCAvb3B0L2Nyb3NzL2tpc3NrYi9ici1hcmNsZS1oczM4LWZ1
bGwtMjAxNi4wOC02MTMtZ2U5OGI0ZGQvYmluL2FyYy1saW51eC1nY2MNCg0KQ2FsbCBpdCBNdXJw
aHkncyBsYXcsIHNhbWUgeWVhciBhIGxpdHRsZSBsYXRlciBJJ2QgZml4ZWQgdGhlIHNhbWUgaXNz
dWUgaW4gZ2NjIFsxXQ0KDQpbMV0gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWls
L2xpbnV4LXNucHMtYXJjLzIwMTYtT2N0b2Jlci8wMDE2NjEuaHRtbA0KDQpAR3VlbnRlciBjb3Vs
ZCB5b3UgcGxlYXNlIGNvbnNpZGVyIHVwZGF0aW5nIHRoZSBBUkMgdG9vbHMuIEZXSVcgeW91IGNh
biBidWlsZA0Kc3R1ZmYgb2ZmIHVwc3RyZWFtIGdjYy9iaW51dGlscyB1c2luZyBidWlsZCBzeXN0
ZW0gb2YgeW91ciBjaG9pY2UuDQoNClRoeCwNCi1WaW5lZXQNCg==
