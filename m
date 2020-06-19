Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9B9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B00520739
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YH3+lvCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgFSHkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:40:04 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:17269
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729548AbgFSHkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:40:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/Zm+7dbOrWc4hyv+iwBpTrPxwksc7zK/6oOtTiNrBaKMXX6yAAyBysmn3r5WcA9E2mYXB8zaY9lzzf7xVxyjrtvo/CMI/isCmkJwc90PRud6aRoPCk52R/1ZIgjh/Zoqe7LdYoO6fBL145+uTLZGd1DsLC8Da/ZEAwi4/2KoMG7tjDeKPnYEpgsfkL1p0E6vq35HOXBnUskCslqEzR2knqI9KrAuTzVwvTzInpMe2BqlfxXSCW54+9PE681LC8hzqyc+v2Hvx8UDFLm9aGp4jzy2RXcI87SfE3eZfHZb1qWmLjuFz9Dv+PUkwrdOqkRJcsgZyOVFgJICzc1vc7B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ru+lPOdu4sH3L0uWM0NzIfLJxps5sm9kwvUoDZhfX4=;
 b=fTsGTBk5rgT83pOckzLAm5oV94AqOU2A4s+A7j+905HtMCjgvOyN/5852EhK4VAgorVNUurnTXB4i9cIU2qVymlGhj2NOnYmMHzVCcXh9RmjO4eQQBBnIqS7wHTIvVPj5FSSHT9pJi3LriTT5aeNeXrEdzi0+3mO/CKwEnJuKT6URtuEmWJqUivq/Yda9K/lxzOtgKHOg6aaftjx0pHhUDrDqmiLvY/SjYF7zHre8YT0688Tnsik4M6YwvCsumwO5EtxosEa5l1eeql9Ies7qzMA9X4iNhGPvUqsCiHP0Xg+3O7lAMuOU/DUa3vFhEBXqKNDk2Id/ELIJflhX2XtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ru+lPOdu4sH3L0uWM0NzIfLJxps5sm9kwvUoDZhfX4=;
 b=YH3+lvCuuS0lU0XiP2rBeO1hlUEWW/MSEbEAcjcLgPVhkkug5e+a4rj4xqSqwQDtnNYijnVGKappNGAlwn0dPoU8XK4SOX8brYfMRaTpnqD1uzJSkiq/FF1EZZXwC+3kCXjPXDCcG1RzsKNi7ScVbF1kTWXpnAPie8gzu8Q1xhs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3724.eurprd04.prod.outlook.com (2603:10a6:8:5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 07:39:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 07:39:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>, Arnd Bergmann <arnd@arndb.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx-scu: Support module build
Thread-Topic: [PATCH] soc: imx-scu: Support module build
Thread-Index: AQHWRGTWiz8NXUZ+xUGFBcoJjUMmmqjccS8AgAAAf6CAABnooIABbZ8AgAGBgwCAABR3MA==
Date:   Fri, 19 Jun 2020 07:39:57 +0000
Message-ID: <DB3PR0402MB3916B7B5E730E2D2B93C5ECCF5980@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1592369623-10723-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49667E1B41DC2A77B3E2FEBF809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <AM6PR0402MB3911B852B49E194E5FE84505F59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167727A8B7CEDAC531D94EF59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3zHBRqSg1VeuKcmyQquE7n5wrEViw5KFbDGJNaMjtZRw@mail.gmail.com>
 <AM6PR04MB496696A8695FA85D1EEE276B80980@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB496696A8695FA85D1EEE276B80980@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 004f321b-2a8c-425c-e01c-08d81423f749
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3724BD59AB9878B6BED7F595F5980@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lUrzTJFiyF9f1smCBW9Q241dc6nULxiqm1NsXMSD6uHAmwlWXqTVR/ZL5TwZm9H+39dmQOhzdqt3WPN09wY4/KRB6QzP8/2ekKxIRtKi15THd/e2pbM2Iclp01crbbDz68nRFLDHbXfMMXpDmOOvYpMBZMrilUcTQ6UlavSvEKaZtNNcjimEMCqaHI11t3Qsk8C2YFLZSBREvV0x7SB/onhM8sBuetrR20NAJdPhwjWyEXWMvCyuZ4pjzNvK/NmAzMmmynoAkO96zgm9OnoDBa9kGY6681XXf9MUnHbxUMdU+GAXvdwYWE9BLI8GWIo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(316002)(54906003)(71200400001)(66446008)(76116006)(66476007)(66946007)(66556008)(64756008)(86362001)(110136005)(55016002)(9686003)(7696005)(6506007)(83380400001)(186003)(26005)(478600001)(33656002)(2906002)(5660300002)(8936002)(44832011)(52536014)(8676002)(53546011)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cI/Tc+SJjsJo4r+bR2ZNyE/SOSsLM/MMY87bdMeatrCyC+0B25yD1ayGMnwXdxpwxKJB0cwhMOGYIDdH5m6KbKBZby6aNFUuiCnUTL+H0b80/Idhz7C5DVl8mWCZ3fVyVm/kmbc4NDokBpFkRLIe7Jg8iUpr10nbwmrjhsstWlp2DecRVO9qTFFX1m4xXNhwTfB1pb9LfDdYgTiYZUNn7a1MDIoqLpQ+iSMJp8djSrsFUnafqR/u7kZ4QlBRwieFikED9xx7eo2JMOwSuKfCgORbquf3Fadu6xTe2Qx17OT1iuNLsJRpdmM5M8jy0rK1l2seQ+bBiIBnEggNzDogqzsoBMJtIyhUnaRBxrarjCs0XPCqbU9yJZ84rGOEWg1fRek0gDr7BfCNOtEZtR8gQkNNTToreSfhIFhzicw6SEXIA1+3a4JxZhmgJ1QDDOjVl5fSEACjhhI03Hccw6wQ72v6mn7TUAdJYkhGX2lApErsytEOtGnB80MXearnGxaL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004f321b-2a8c-425c-e01c-08d81423f749
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 07:39:57.7530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbkC6FSPZtph8UJfkG6P1p1KKVjV+WvelerzipmIQ+/H04HtIS2+W4VkRQL2bsPzatZQsHfGKd5UX+zlYr+GjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gc29jOiBpbXgtc2N1OiBTdXBwb3J0IG1vZHVsZSBi
dWlsZA0KPiANCj4gPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+IFNl
bnQ6IFRodXJzZGF5LCBKdW5lIDE4LCAyMDIwIDM6MjEgUE0NCj4gPg0KPiA+IE9uIFdlZCwgSnVu
IDE3LCAyMDIwIGF0IDExOjQxIEFNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0K
PiA+IHdyb3RlOg0KPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJJ20gb2sgd2l0aCB0aGUgY2hh
bmdlLiBCdXQgSSdtIGN1cmlvdXMgaG93IGNhbiB0aGlzIG1vZHVsZSBiZQ0KPiA+ID4gPiA+IGF1
dG9sb2FkZWQgd2l0aG91dCBNT0RVTEVfREVWSUNFX1RBQkxFLg0KPiA+ID4gPiA+IEhhdmUgeW91
IHRlc3RlZCBpZiBpdCBjYW4gd29yaz8NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBJIE9O
TFkgdGVzdGVkIHRoZSBtYW51YWwgaW5zbW9kLCBpZiB3YW50IHRvIHN1cHBvcnQgYXV0byBsb2Fk
LCBtYXkNCj4gPiA+ID4gbmVlZCBzb21lIG1vcmUgY2hhbmdlLCB3aWxsIHRyeSBpdCBsYXRlciBh
bmQgc2VuZCBvdXQgYSBWMiBpZiBuZWVkZWQuDQo+ID4gPg0KPiA+ID4gVGhlIGZ1cnRoZXIgY2hl
Y2sgc2hvd3MgdGhhdCwgaWYgd2FudCB0byBzdXBwb3J0IGF1dG8gbG9hZCwgdGhlDQo+ID4gPiBw
bGF0Zm9ybSBkZXZpY2UgcmVnaXN0ZXIgbmVlZHMgdG8gYmUgZG9uZSBpbiBzb21ld2hlcmUgZWxz
ZSB3aGljaCBpcw0KPiA+ID4gYnVpbHQtaW4gKGluIG15IHRlc3QsIEkgbW92ZSBpdCB0byBjbGst
aW14OHF4cC5jJ3MgcHJvYmUpLCBhbmQgYWxzbw0KPiA+ID4gbmVlZCB0byBhZGQgYmVsb3cgbW9k
dWxlIGFsaWFzIGluIHRoaXMgZHJpdmVyLCBiZWNhdXNlIGl0IGhhcyBubw0KPiA+ID4gZGV2aWNl
IG5vZGUgaW4NCj4gPiBEVCBhbmQgbm8gZGV2aWNlIHRhYmxlIGluIGRyaXZlci4NCj4gPiA+DQo+
ID4gPiArTU9EVUxFX0FMSUFTKCJwbGF0Zm9ybTppbXgtc2N1LXNvYyIpOw0KPiA+ID4NCj4gPiA+
IFNpbmNlIHRoaXMgZHJpdmVyIGhhcyBubyBkZXZpY2Ugbm9kZSBpbiBEVCwgYW5kIHRoZSB0YXJn
ZXQgaXMgdG8NCj4gPiA+IGJ1aWxkIGFsbCBTb0Mgc3BlY2lmaWMgZHJpdmVycyBhcyBtb2R1bGUs
IHNvIHRoZSBiZXN0IHdheSBpcyB0byBhZGQNCj4gPiA+IGEgdmlydHVhbCBkZXZpY2Ugbm9kZSBp
biBEVCBpbiBvcmRlciB0byBzdXBwb3J0IGF1dG8gbG9hZD8NCj4gPg0KPiA+IEkgc2VlIHRoYXQg
dGhlcmUgaXMgaW5kZWVkIGEgZHJpdmVyIGZvciB0aGUgZGV2aWNlIG5vZGUgaW4NCj4gPiBkcml2
ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMsIHRoZSBvbmx5IHJlYXNvbiBmb3IgdGhpcyBtb2R1
bGUgdXNpbmcNCj4gPiBkZXZpY2VfaW5pdGNhbGwoKSB3aXRoIGEgbWFudWFsDQo+ID4gcGxhdGZv
cm1fZGV2aWNlX3JlZ2lzdGVyX3NpbXBsZSgpIHNlZW1zIHRvIGJlIHRoYXQgd2UgY2Fubm90IGhh
dmUgdHdvDQo+ID4gcGxhdGZvcm0gZHJpdmVycyBiaW5kIHRvIHRoZSBzYW1lIGRldmljZSBub2Rl
Lg0KPiA+DQo+ID4gSSB0aGluayBhIGNsZWFuZXIgd2F5IHRvIGhhbmRsZSB0aGlzIHdvdWxkIGJl
IHRvIGp1c3QgbW92ZSB0aGUgZW50aXJlDQo+ID4gc29jIGRyaXZlciBpbnRvIHRoZSBmaXJtd2Fy
ZSBkcml2ZXIgYW5kIHRoZW4gcmVtb3ZlIHRoZSBkdXBsaWNhdGlvbi4NCj4gPg0KPiANCj4gWWVz
LCBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYSB0byBtZS4NCg0KU28gdGhlIGlkZWEgaXMgdG8gcmVt
b3ZlIHRoaXMgZHJpdmVyIGFuZCBpbXBsZW1lbnQgdGhlIHNvYyBpZC9yZXZpc2lvbi9zZXJpYWxf
bnVtYmVyIGV0Yy4NCmluIGRyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UuYywgcmlnaHQ/DQoN
CkFuc29uDQo=
