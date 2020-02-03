Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA09C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126AC2070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l68Uje3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBCJVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:21:08 -0500
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:28580
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbgBCJVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:21:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKTDr3saT3KtlARgDkj93c6lpugtDLnSLCsqUSTzb/PTjX2gD0axyG2+kpgviPk3G3kF3SNnnQO4H5mxftVoRjewrv1aXi3Tm465bk/NgoDoCgsphT+8QQ5Fp5j5mL8xIkAqBA0MEdMGJtsrwzHi97MDCkEokkhCoT9qeWHS0xkq4QDsOu9f1LHyKMquGBHXv2IkyIjQZjG7PUNVU1x6M5ZwDRuLlIE2rtARXDCg79UH42hF60MAWCnfJT0Q4oPfrYGyuucUSYppN5LAl5n/xN/OCTcEOksulRuXh7sn/XEIq9a7sNeUNB1kDDEFnjt4jcvAAEeNCBy7AJDx4gSk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgxXJjFmFaBb1zH2KkVP1dGg32kr6pD3/xdnghcD1Hs=;
 b=MQJPsmtFrZhtw3G3mXKB7CEcuI4Ip1ab/3ARt0FOUkOHEYdKZHRqTFTLOyi9y+nlTjXokVvaVADIq/qwjbW0UXycdsoJn2m9NeTDBAALOosPGgs/lOahFNalpWA2vjsex0LfZBTMTF2U3SL79PAs66Az7JcFQqIzVCxRpFZXfqfsIBJRsovgY+QvV/0+XLimWf/rgrd3fcNMwKrQXtDuM+pY8TLu0isxtOpO+NUcTUJSCbsZwuqH0Qg7fWhcdmGQn3hWZDj77VgXRzbAtdWljciBvoRnYTy3aCu+OU4SeGZ7pprOPdcPJbjeUmsNtjKZbUWTuftV+gIk9A8BM77h5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgxXJjFmFaBb1zH2KkVP1dGg32kr6pD3/xdnghcD1Hs=;
 b=l68Uje3AI7vakih7KP90Jn0mO9U5EwCb9CwZ6SV87GTcv1mfFADx0zRibdpCS0vp/t6famfoq5iEX0wE4LuxUMs+bNQrJyMBEJn8niRNI1v0GUWPYA1blkZUKSDUrl36E0ulLMVv0xy2xGzaK2aKdkYNh3v1hRtPqCMcH9fHmhs=
Received: from AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) by
 AM0PR04MB5410.eurprd04.prod.outlook.com (20.178.114.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 09:21:03 +0000
Received: from AM0PR04MB5636.eurprd04.prod.outlook.com
 ([fe80::1b4:31d2:1485:6e07]) by AM0PR04MB5636.eurprd04.prod.outlook.com
 ([fe80::1b4:31d2:1485:6e07%7]) with mapi id 15.20.2686.028; Mon, 3 Feb 2020
 09:21:03 +0000
From:   "Calvin Johnson (OSS)" <calvin.johnson@oss.nxp.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux.cj@gmail.com" <linux.cj@gmail.com>,
        Jon Nettleton <jon@solid-run.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Rajesh V. Bikkina" <rajesh.bikkina@nxp.com>,
        "Calvin Johnson (OSS)" <calvin.johnson@oss.nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 5/7] device property: Introduce
 fwnode_phy_is_fixed_link()
Thread-Topic: [PATCH v1 5/7] device property: Introduce
 fwnode_phy_is_fixed_link()
Thread-Index: AQHV2nNBOg4A6QPfr0Wlmr89aSmq/w==
Date:   Mon, 3 Feb 2020 09:21:02 +0000
Message-ID: <AM0PR04MB5636A3081D857484A970970493000@AM0PR04MB5636.eurprd04.prod.outlook.com>
References: <20200131153440.20870-1-calvin.johnson@nxp.com>
 <20200131153440.20870-6-calvin.johnson@nxp.com>
 <CAHp75Vf+UVMS1WOQ3KB8DiSB5KD2oFQs5ZmJ5yDPi=3i4uZVRg@mail.gmail.com>
In-Reply-To: <CAHp75Vf+UVMS1WOQ3KB8DiSB5KD2oFQs5ZmJ5yDPi=3i4uZVRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=calvin.johnson@oss.nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0ce3929-f225-4a67-f74b-08d7a88a63f1
x-ms-traffictypediagnostic: AM0PR04MB5410:|AM0PR04MB5410:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5410F822575D7F807E044D83D2000@AM0PR04MB5410.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(6916009)(478600001)(7416002)(7696005)(64756008)(66446008)(52536014)(2906002)(66476007)(66556008)(5660300002)(86362001)(76116006)(4326008)(71200400001)(33656002)(186003)(54906003)(26005)(316002)(6506007)(53546011)(9686003)(55016002)(81156014)(8676002)(8936002)(81166006)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5410;H:AM0PR04MB5636.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b2zZ7LI/RdEWIK2oR5gBErxx2bku1R0oZjchgbDmlnPxmwSUp/U7kZzrK3hOKwIW67xriRJH+nWQ8eRbHa198hlx53gOnjaJm1Vxliue3xWpy0Pu3CODRe7ipsRSvGvt+LcHHPR3OuB9yPThsOpru+JLAwmReyZQdXPghZNmILw2sCiEWwlTM0BHCmrxEug328qifRm2CrlmOKZxw9K1aIBzaGKCGRczcxYe5g+XWMac8kISevi7FhUFxk5/RQVoBBTq9fb7vYs2N7SUpaWF7E3wDDiUFXNe+IqIR/JE2jeTtQ6b0dFIVn9S4AO2fBqCiTcxoxoPtCIfr1ayJAArNerxFAlu60Ib8x4GJm9/f/g1IH97fWwxEhmMBa/IVAUpY0zNeeSERgLAnL0ytkKBLMyf7BGZKS3+yfamiAMdV7fxn1EtJOKuW47jREmJiUU8
x-ms-exchange-antispam-messagedata: /SCWsc7XTIvuGN4PT4MN5NJwh2CZ4Iv55bQDG80sFxd/V3EH2kscD/VrfCKZiUVODaNyNaDmmPnYCP+LjcsLHYicpIr9yDwFMzBQS9+M0XLvYucmMSWefoUvQ340FrqwbbKn2nHlH6MQ1Rn7x0knwQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ce3929-f225-4a67-f74b-08d7a88a63f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 09:21:03.0640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2KaSrx2d0xiINrmJqCGmes++9SDsFQzdA1U2x45geMpNK+RIBXHfg3V7i7NAnyArg8AaXasP7fG+1yXACVZLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5410
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDUv
N10gZGV2aWNlIHByb3BlcnR5OiBJbnRyb2R1Y2UNCj4gZndub2RlX3BoeV9pc19maXhlZF9saW5r
KCkNCj4gDQo+IE9uIEZyaSwgSmFuIDMxLCAyMDIwIGF0IDU6MzggUE0gQ2FsdmluIEpvaG5zb24g
PGNhbHZpbi5qb2huc29uQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQ2Fsdmlu
IEpvaG5zb24gPGNhbHZpbi5qb2huc29uQG9zcy5ueHAuY29tPg0KPiA+DQo+ID4gSW50cm9kdWNl
IGZ3bm9kZV9waHlfaXNfZml4ZWRfbGluaygpIGZ1bmN0aW9uIHRoYXQgYW4gRXRoZXJuZXQgZHJp
dmVyDQo+ID4gY2FuIGNhbGwgb24gaXRzIFBIWSBwaGFuZGxlIHRvIGZpbmQgb3V0IHdoZXRoZXIg
aXQncyBhIGZpeGVkIGxpbmsgUEhZDQo+ID4gb3Igbm90Lg0KPiANCj4gPiArLyoNCj4gPiArICog
Zndub2RlX3BoeV9pc19maXhlZF9saW5rKCkNCj4gPiArICovDQo+IA0KPiBQbGVhc2UsIGRvIGEg
ZnVsbCBrZXJuZWwgZG9jIGRlc2NyaXB0aW9uLg0KDQpTdXJlIHdpbGwgdGFrZSBjYXJlIGluIHYy
Lg0KDQoNCj4gPiArYm9vbCBmd25vZGVfcGh5X2lzX2ZpeGVkX2xpbmsoc3RydWN0IGZ3bm9kZV9o
YW5kbGUgKmZ3bm9kZSkgew0KPiA+ICsgICAgICAgc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZpeGVk
X25vZGU7DQo+ID4gKyAgICAgICBpbnQgbGVuLCBlcnI7DQo+ID4gKyAgICAgICBjb25zdCBjaGFy
ICptYW5hZ2VkOw0KPiA+ICsNCj4gPiArICAgICAgIGZpeGVkX25vZGUgPSBmd25vZGVfZ2V0X25h
bWVkX2NoaWxkX25vZGUoZndub2RlLCAiZml4ZWQtbGluayIpOw0KPiA+ICsgICAgICAgaWYgKGZp
eGVkX25vZGUpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBmaXhlZF9ub2RlOw0KPiA+ICsN
Cj4gPiArICAgICAgIGVyciA9IGZ3bm9kZV9wcm9wZXJ0eV9yZWFkX3N0cmluZyhmaXhlZF9ub2Rl
LCAibWFuYWdlZCIsDQo+ID4gKyAmbWFuYWdlZCk7DQo+IA0KPiA+ICsgICAgICAgaWYgKGVyciA9
PSAwICYmIHN0cmNtcChtYW5hZ2VkLCAiYXV0byIpICE9IDApDQo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiB0cnVlOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBmYWxzZTsNCj4gDQo+IE1h
eWJlIG90aGVyIHdheSBhcm91bmQ/DQo+IA0KPiAgIGlmIChlcnIpDQo+ICAgICByZXR1cm4gZmFs
c2U7DQo+IA0KPiAgIHJldHVybiAhc3RyY21wKG1hbmFnZWQsICJhdXRvIik7DQo+IA0KPiA/DQo+
IA0KPiBTYW1lIHBhdHRlcm4gcGVyaGFwcyBmb3IgdGhlIHBhdGNoIHdoZXJlIHlvdSBpbnRyb2R1
Y2UNCj4gZndub2RlX2dldF9waHlfbW9kZSgpLg0KDQpUaGFua3MhIFdpbGwgdGFrZSBjYXJlIGlu
IHYyLg0KDQpSZWdhcmRzDQpDYWx2aW4NCg0K
