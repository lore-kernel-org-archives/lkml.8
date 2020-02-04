Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005CCC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B626120674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kdS8Hdeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBDTIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:08:39 -0500
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:6126
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727494AbgBDTIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:08:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPkzUghNOWEg5VPXEwtNBi1CaBKVVSvP6XgR0WblZEe4/Yi9qohELrCsVbDmJWCamilzeBFERAyVMyQvkKTWl2ICXScjNyLsOr9usW5sqIjA607Y6tnl2rtHS1iNo0ZHGP+GOyl/OWm04thEPawJHLKapRPwA9oy9XbiCECtPa4RHJsogyfUuvt/KhAeASCP+LsJulbPnR7Fzq/U4MqN2azxKJ8YDzFJTVoC5Oe09WF6oP6dJ1wZhiewRpjha2bZgLHTWk1RR55CuoWcWELEm6llGAtNt7nr/ii9dzu99VafM9ekxSDilM3iQnrAcDo2YslqZfzoyJNadog9D92XNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z2WeSN6w+/+6yi8SsUJmbXmRagu9aJzbUdGY+2+m3Q=;
 b=Be2qB7w1fx7g/IZAWyWVWs18B0DNmYCZFbhpO+tEeTbNAy57jQAonj/a1mPxZHHXDz7cK0KEBysG15zsGphq5X/7gbbU4Md2hnt/D4FvhkaaHaRqgUHHk+z086eTljDtPe6qwBobeK5iy7FKNqZZtgwpdmLSYu+XVFva/4xnlhdDrr+NSkB2UaciGak+wQiiBwM0PQBQ60wG+2Qvu3o8e8I0mVvh6nH9AOEagSp1F8ArOUlB7TBaAOWm6puziyhzs+0ybEQwZqqDLfek9SeLeeBHoTcNjtt41263FmUDA/O2XnhR3s035d2IgVUBsQi5/R0MGJcJZqKtkoaY9tNCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z2WeSN6w+/+6yi8SsUJmbXmRagu9aJzbUdGY+2+m3Q=;
 b=kdS8Hdebzv2979Egke08o/VzVrwZv4pvkd5qviLwJulDnNqLrKYYBGbEXkhacyi8q4V7zKkXbfHTmNexpcUSTXfH5EGk4+hXV5doYXTZJDYsPTn7b0s/NOy6jK3QvEzaXUZc4FT/yc+UDRgeTx378XXfISM5QWAZ5Fn7/cVIuBs=
Received: from MN2PR02MB5727.namprd02.prod.outlook.com (20.179.85.153) by
 MN2PR02MB6240.namprd02.prod.outlook.com (52.132.174.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 19:08:36 +0000
Received: from MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::e09d:a160:5349:8ed0]) by MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::e09d:a160:5349:8ed0%6]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 19:08:36 +0000
From:   Mubin Usman Sayyed <MUBINUSM@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>
Subject: RE: [PATCH] irqchip: xilinx: Add support for multiple instances
Thread-Topic: [PATCH] irqchip: xilinx: Add support for multiple instances
Thread-Index: AQHV2EFy1wtnp2eJaEKfI1gB9M0udKgE1vsAgAaUMeA=
Date:   Tue, 4 Feb 2020 19:08:36 +0000
Message-ID: <MN2PR02MB5727F3B9694669B10D25E841A1030@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <1580480338-3361-1-git-send-email-mubin.usman.sayyed@xilinx.com>
 <28c517f7-9cff-f897-c5a9-2216dd769c64@xilinx.com>
In-Reply-To: <28c517f7-9cff-f897-c5a9-2216dd769c64@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MUBINUSM@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcdf5ac3-818f-4f87-1d95-08d7a9a5a303
x-ms-traffictypediagnostic: MN2PR02MB6240:|MN2PR02MB6240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB62403AEFF357BA78358997E7A1030@MN2PR02MB6240.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(81166006)(33656002)(8936002)(81156014)(8676002)(66476007)(66446008)(5660300002)(66556008)(66946007)(76116006)(7696005)(316002)(64756008)(110136005)(54906003)(478600001)(4326008)(6506007)(53546011)(86362001)(107886003)(55016002)(26005)(52536014)(2906002)(186003)(71200400001)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6240;H:MN2PR02MB5727.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFsBdaKuDeAXK+R4zowpCkLgXZ0YkLebeb+ixWMs9WU+k/6LwADmpc/UUe9sBPVtafkWCa+AmdXYnH1q1XBQEGvg16FYQAEOI11G/S/vgBGxas1kqU45HxSkEtxrfz82p0NEWHnMYoKPQdupSL6R1E4kOhfi/LoiZ9ZqrfOtYNWeoQf/afa0lbt+HdeKQuE9sncADrWnNgz44UjoqTQCMse+ywwTPnsENVkpYCXUJn65D4wL+FHAs8GW/KXwxWRpNB+C9Ov1mmcx4o17A/Ron6UDjhlH22EjIT8L2f1klrTSycMJLbBGgLXp9USiRGd9Fw2phCACqKoB83gyGNDgMkcr4jEY71tMAslzfQRfQPChlElYNHXYf7bP6Ex8o/nHn3woR4XL8IMS8Y6YrsnghuAk9DiG9XY+ctHMUxceRdDquVw/F/rUVOrzDGJ7yqw6
x-ms-exchange-antispam-messagedata: s+C8IPZ8tWI52aNkFl6fRv8R4iD0WzMSdpVMLn0QY83SPjXgnAFKvwLR1fv8uB1Trcf7XYNjySktCjOc55gbWRxJI0r2SjUvxdPVLuFu7DaV6GWBB60dIPCjNwDeeSitvWr0KUyNIoQd8DCOiVd9Fw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdf5ac3-818f-4f87-1d95-08d7a9a5a303
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 19:08:36.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJ43KNy15s56xFVC21Rn6CcBUbXcZBmIIgggW5WL9ViOWHPAQEtUVs7f4/qSo2jjDiCODo8kGlRfzT1GEigEUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hh
bCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFy
eSAzMSwgMjAyMCA4OjA2IFBNDQo+IFRvOiBNdWJpbiBVc21hbiBTYXl5ZWQgPE1VQklOVVNNQHhp
bGlueC5jb20+OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IGphc29uQGxha2VkYWVtb24ubmV0OyBt
YXpAa2VybmVsLm9yZzsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IFNpdmEgRHVyZ2EgUHJhc2FkIFBhbGFkdWd1DQo+IDxzaXZhZHVyQHhpbGlu
eC5jb20+OyBBbmlydWRoYSBTYXJhbmdpIDxhbmlydWRoQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGlycWNoaXA6IHhpbGlueDogQWRkIHN1cHBvcnQgZm9yIG11bHRpcGxlIGlu
c3RhbmNlcw0KPiANCj4gT24gMzEuIDAxLiAyMCAxNToxOCwgTXViaW4gVXNtYW4gU2F5eWVkIHdy
b3RlOg0KPiA+IEZyb206IE11YmluIFNheXllZCA8bXViaW4udXNtYW4uc2F5eWVkQHhpbGlueC5j
b20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgbXVsdGlwbGUgaW5zdGFu
Y2VzIG9mIHhpbGlueCBpbnRlcnJ1cHQNCj4gPiBjb250cm9sbGVyLiBCZWxvdyBjb25maWd1cmF0
aW9ucyBhcmUgc3VwcG9ydGVkIGJ5IGRyaXZlciwNCj4gPg0KPiA+IC0gcGVyaXBoZXJhbC0+eGls
aW54LWludGMtPnhpbGlueC1pbnRjLT5naWMNCj4gPiAtIHBlcmlwaGVyYWwtPnhpbGlueC1pbnRj
LT54aWxpbngtaW50Yw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5pcnVkaGEgU2FyYW5naSA8
YW5pcnVkaGEuc2FyYW5naUB4aWxpbnguY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE11YmluIFNh
eXllZCA8bXViaW4udXNtYW4uc2F5eWVkQHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvaXJxY2hpcC9pcnEteGlsaW54LWludGMuYyB8IDE0Mw0KPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4NyBpbnNlcnRpb25z
KCspLCA1NiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNo
aXAvaXJxLXhpbGlueC1pbnRjLmMNCj4gPiBiL2RyaXZlcnMvaXJxY2hpcC9pcnEteGlsaW54LWlu
dGMuYw0KPiA+IGluZGV4IGUzMDQzZGUuLjQzZDZlNGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9pcnFjaGlwL2lycS14aWxpbngtaW50Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2ly
cS14aWxpbngtaW50Yy5jDQo+ID4gQEAgLTE1LDEwICsxNSwxMSBAQA0KPiA+ICAjaW5jbHVkZSA8
bGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oPiAgI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3Mu
aD4NCj4gPiAjaW5jbHVkZSA8bGludXgvaW8uaD4gLSNpbmNsdWRlIDxsaW51eC9qdW1wX2xhYmVs
Lmg+ICAjaW5jbHVkZQ0KPiA+IDxsaW51eC9idWcuaD4gICNpbmNsdWRlIDxsaW51eC9vZl9pcnEu
aD4NCj4gPg0KPiA+ICtzdGF0aWMgc3RydWN0IHhpbnRjX2lycV9jaGlwICpwcmltYXJ5X2ludGM7
DQo+IA0KPiBuaXQ6IHBsZWFzZSBwbGFjZSBpdCBiZWxvdyB4aW50Y19pcnFfY2hpcC4NCltNdWJp
bl06ICBJIHdpbGwgZml4IGl0IGluIHYyLg0KPiANCj4gPiArDQo+ID4gIC8qIE5vIG9uZSBlbHNl
IHNob3VsZCByZXF1aXJlIHRoZXNlIGNvbnN0YW50cywgc28gZGVmaW5lIHRoZW0gbG9jYWxseQ0K
PiBoZXJlLiAqLw0KPiA+ICAjZGVmaW5lIElTUiAweDAwCQkJLyogSW50ZXJydXB0IFN0YXR1cyBS
ZWdpc3RlciAqLw0KPiA+ICAjZGVmaW5lIElQUiAweDA0CQkJLyogSW50ZXJydXB0IFBlbmRpbmcg
UmVnaXN0ZXIgKi8NCj4gPiBAQCAtMzIsMzUgKzMzLDQwIEBADQo+ID4gICNkZWZpbmUgTUVSX01F
ICgxPDwwKQ0KPiA+ICAjZGVmaW5lIE1FUl9ISUUgKDE8PDEpDQo+ID4NCj4gPiAtc3RhdGljIERF
RklORV9TVEFUSUNfS0VZX0ZBTFNFKHhpbnRjX2lzX2JlKTsNCj4gDQo+IEkgYW0gcGxheWluZyB3
aXRoIHRoaXMgZHJpdmVyIGEgbGl0dGxlIGJpdCBub3cgYW5kIEkgcHJldHR5IG11Y2ggZGlzbGlr
ZSByZW1vdmUNCj4gdGhpcy4gSSBoYXZlbid0IHNlZSBhbnkgY29uZmlndXJhdGlvbiB3aGljaCBt
aXhlcyBsaXR0bGUgYW5kIGJpZyBlbmRpYW4NCj4gdG9nZXRoZXIuIFRoYXQncyB3aHkgSSBwcmVm
ZXIgbm90IHRvIGNyZWF0ZSByZWFkX2ZuL3dyaXRlX2ZuIGhvb2tzLg0KW011YmluXTogIEFncmVl
ZCwgIEkgd2lsbCByZW1vdmUgcmVhZF9mbi93cml0ZV9mbiBhbmQgdXNlIHhpbnRjX2lzX2JlIGlu
IHYyLg0KDQpUaGFua3MsDQpNdWJpbg0KPiANCj4gVGhhbmtzLA0KPiBNaWNoYWwNCg==
