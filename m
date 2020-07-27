Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63ECC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3702070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UcF1Zp7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgG0ILQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:11:16 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:63497
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbgG0ILP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:11:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG3ZHALptKWSdTEmoRajtvNW10AehO04w0yKa55wER+h0i/e61YyFsXAnFVAr3KfA5gTudVmV1bq66pxjwkUtRTvcyqkwFMXIGl5x2ON4DReSSLunPc+DlqPwO7Jow3IxI2qjaq0WkpSHBVSgOWFnnduCpR3o7Snn7mBdht4FqQOSHbiZgYtnrQgdir+i1zzU14rlFz9scO8RjK/Vyc98MzutQWXyqK2oP5I37eCU2vB4pyLP+4Fe7Fba1Ha0l/RGqRXGBuvc0Zd4Cgb7D5OXrx7lfIx3J8XKh5VgQEQPENV8MyBFCdL541ec2O+dWYxdhYEEgNwwe3ycSxb9JEXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGN3rth0FYtngFjMY+KcVNEfvR1HUkwKPy3amW4ZcyM=;
 b=B7S9jJ08p7todFnnlyCUzEZJ/yCZY8FFP0wukNL9N0lvZCDgG6XO795wfw0+GQYUVeH0w6WWUb11MBp0bA4Rue6mFjhOwq3ehhzRAJJ8EuZP9tHguhPSdacjiQKwEMkQa2izthdNwbdbaG2pA8MBifvXUOu2EuM8Dn8nIz3Jzg/oWWwnV4yXihI+J4q245dB6ODjTGWVS9EBM7Tdm3fUmouGih/kGyEeFsVQ7TO0HLAmsZ18TYmAmTXPGOz4l2ICmICwNYzT4H320alpK2RvMm7lke/QR8CBzFZG7SuS0j0XbXg+Cf2U4rhXEVcTwAVcMCzOB3uOIlv85VPnQXZkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGN3rth0FYtngFjMY+KcVNEfvR1HUkwKPy3amW4ZcyM=;
 b=UcF1Zp7Bc3uZud7UqjVMLjb/1CMXYSYLiKDklLewD/gYvnaQHMGQ7w01ZAYysdL843vtA4y/7gwjESC/6jfU6dULv0VOZrbNptJr8O5V1f+4RSjjAdk4iwV7vIjD++6ssCTHR7aebHsZqPVPcnMp0hMAxcYWtDEm305s8VkH0qY=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB6026.eurprd04.prod.outlook.com (2603:10a6:10:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 08:11:09 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 08:11:09 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 03/10] remoteproc: imx: use devm_ioremap
Thread-Topic: [PATCH 03/10] remoteproc: imx: use devm_ioremap
Thread-Index: AQHWYY4mj2fkhyJv70m2EtieoGp7X6ka+c2AgAAA2pCAAARBgIAAAZOAgAAOGYCAAAhg0A==
Date:   Mon, 27 Jul 2020 08:11:09 +0000
Message-ID: <DB6PR0402MB2760EFCB8C91680DC719C82C88720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-4-peng.fan@nxp.com>
 <20200727062335.v2pxgu6kr6ao2qmh@pengutronix.de>
 <DB6PR0402MB27601C875FF5F1E02DBF5C6488720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200727064151.767kc7622tcqmqfs@pengutronix.de>
 <DB6PR0402MB276063FBE74FCF222CB00F8588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200727073757.r2vq6djh3a4dyfp6@pengutronix.de>
In-Reply-To: <20200727073757.r2vq6djh3a4dyfp6@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7276eaf3-d69f-4ad5-f90d-08d832049ec9
x-ms-traffictypediagnostic: DBBPR04MB6026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB602654584962C742E5B4804E88720@DBBPR04MB6026.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vspR35b8FwcQPVY/OQuIpD/2ot5YWNQeR+uC/We0lgc4U33FP+krYjxUFNtf28t0hB55PWN5zz07JKgL6RAx9lHV+Qbyu3BsUE1MdtoFgdAMrbMg2ybGr+V7zAO+B/ttNtqhM40lrI+O7tKFi3z1v7AJ04R1VXO5lc/kkHbFPA2iJ8h5XVBdTOmrmru9KF44kKJPp6d+BGG7vkYi7SORErrl8UQwoZT+Y3Wa/M43JZ3+pX+Mm/MV41ehO46ylX/ZyKsS3lLCGlpxg61A7rxekjl1N3/t5JQ9odSFPEHfEEaG7pksQCVAe/BvWQ4Hnx8GalSj9qIvCI+ChOy0fDKabkFMTS//k5BMfCe74H2VwrR4KYWorsOINlyNeooWMLDpzyKt4YwCCvEXA7cXs0sCwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(478600001)(26005)(6916009)(66946007)(5660300002)(186003)(44832011)(316002)(2906002)(9686003)(52536014)(54906003)(4326008)(76116006)(7696005)(83080400001)(6506007)(7416002)(33656002)(66446008)(8676002)(66556008)(64756008)(86362001)(71200400001)(55016002)(66476007)(966005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: S1Pg0rW8FiSBi5FqAvVk+HZd27Tt14y/zi2LUBg29GuAyvB7/2o1TQPiLANUWnUygYLsxWFQSTM7Zx8t3AFUZYsL1PJKGhLfJqOidnV4+Xb+AGrLdHCw0IdFVeohFQR9QjkQFBLuAVYbPY//nTYN97f8YnGAmw2yVgkeP+nV7xgCZvOB3IZysISMINbMxNuV+bCouDh1BS6+9xJoWw2+Znpv9fjWGh0eUXRZxeeqq35d3HscvtgimFJyMH8i916TvNRv6s5q/nUC280S5uyHmSrLx+IybC0uDQ96y7j09xQlcJT+ebdM8lz2zOrTxcBgdyQ8NrJgocusa5HCreoVlNgJMCwOH8OKmlHec2aSCi6TimhhGJ4lqR+HYBscQw8CPRioW5P4WtuhlxWqEClrNgMO0rE9K8l8+eAzNtwUbMfWsDUCWj4BxxwU7gLYYxC9A20+U4Px1cIJZ5HV64MS2C1+/hAaqHkMtPeq6HbWkOY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7276eaf3-d69f-4ad5-f90d-08d832049ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 08:11:09.5990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdovqEXkHA9+VuboaofHMbqN1Ub0IOFQcKxJQL5jLiuCB64rzwGRODEpfDaxXCxTvLAGJjFrtrOrats59ql39w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAzLzEwXSByZW1vdGVwcm9jOiBpbXg6IHVzZSBkZXZtX2lv
cmVtYXANCj4gDQo+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0IDA2OjUxOjAwQU0gKzAwMDAsIFBl
bmcgRmFuIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAwMy8xMF0gcmVtb3RlcHJv
YzogaW14OiB1c2UgZGV2bV9pb3JlbWFwDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBKdWwgMjcsIDIw
MjAgYXQgMDY6Mjg6MjBBTSArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gPiA+IEhpIE9sZWtz
aWosDQo+ID4gPiA+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAwMy8xMF0gcmVtb3Rl
cHJvYzogaW14OiB1c2UgZGV2bV9pb3JlbWFwDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBGcmks
IEp1bCAyNCwgMjAyMCBhdCAwNDowODowNlBNICswODAwLCBQZW5nIEZhbiB3cm90ZToNCj4gPiA+
ID4gPiA+IFdlIG1pZ2h0IG5lZWQgdG8gbWFwIGFuIHJlZ2lvbiBtdWx0aXBsZSB0aW1lcywgYmVj
YXVlIHRoZQ0KPiA+ID4gPiA+ID4gcmVnaW9uIG1pZ2h0IGJlIHNoYXJlZCBiZXR3ZWVuIHJlbW90
ZSBwcm9jZXNzb3JzLCBzdWNoIGkuTVg4UU0NCj4gPiA+ID4gPiA+IHdpdGggZHVhbA0KPiA+ID4g
TTQgY29yZXMuDQo+ID4gPiA+ID4gPiBTbyB1c2UgZGV2bV9pb3JlbWFwLCBub3QgZGV2bV9pb3Jl
bWFwX3Jlc291cmNlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQ2FuIHlvdSBwbGVhc2UgZ2l2ZSBh
biBleGFtcGxlIG9mIHRoaXMga2luZCBvZiBzaGFyZWQgcmVzb3VyY2VzDQo+ID4gPiA+ID4gYW5k
IGhvdyB0aGV5IHNob3VsZCBiZSBoYW5kbGVkIGJ5IHR3byBzZXBhcmF0ZSBkZXZpY2VzPw0KPiA+
ID4gPg0KPiA+ID4gPiBUaGlzIGlzIHRvIHNoYXJlIHZkZXZidWZmZXIgc3BhY2UsIHRoZXJlIGlz
IGEgdmRldmJ1ZmZlciBpbiBkZXZpY2UNCj4gPiA+ID4gdHJlZSwgaXQgd2lsbCBiZSBzaGFyZWQg
YmV0d2VlbiBNNF8wIGFuZCBNNF8xLg0KPiA+ID4gPg0KPiA+ID4gPiBGb3IgdGhlIGJ1ZmZlciwg
aXQgaXMgTGludXggRE1BIEFQSSB3aWxsIGhhbmRsZSB0aGUgc3BhY2UuDQo+ID4gPg0KPiA+ID4g
V2h5IHJlbW90ZXByb2MgbmVlZCB0byBjYXJlIGFib3V0IGl0PyBJZiBJIHNlZSBpdCBjb3JyZWN0
bHksIGZyb20NCj4gPiA+IHRoZSBsaW51eCBwZXJzcGVjdGl2ZSwgaXQgaXMgb25lIGJ1ZmZlciBh
bmQgb25lIGRyaXZlciBpcw0KPiA+ID4gcmVzcG9uc2libGUgZm9yIGl0LiBPciBkbyBJIG1pc3Np
bmcgc29tZSB0aGluZz8NCj4gPg0KPiA+IFdlIG5vdCBoYXZlIHRoZSB2ZGV2IGJ1ZmZlciBpbiBy
ZXNvdXJjZSB0YWJsZSwgc28gSSBhZGRlZCBpbiBkZXZpY2UgdHJlZSwgc2VlDQo+IGJlbG93Og0K
PiANCj4gSG0uLiBpZiB2ZGV2IGlzIG5vdCBpbiByZXNvdXJjZSB0YWJsZSBhbmQgc2hvdWxkIG5v
dCBiZSBjb250cm9sbGVkIGJ5DQo+IHJlbW90ZXByb2MsIHdoeSBkbyB3ZSBuZWVkIHJlbW90ZXBy
b2M/DQoNCkkgdXNlIHNhbWUgYXBwcm9hY2ggYXMgc3RtMzIgcnByb2MgZHJpdmVyLg0KDQpUaGUg
cmVzb3VyY2UgdGFibGUgaGVyZSBvbmx5IHB1Ymxpc2ggdnJpbmcgYWRkcmVzcy4NCg0KPiANCj4g
PiAgICAgICAgIGlteDhxbV9jbTQwOiBpbXg4cW1fY200QDAgew0KPiA+ICAgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImZzbCxpbXg4cW0tY200IjsNCj4gPiAgICAgICAgICAgICAgICAgcnNj
LWRhID0gPDB4OTAwMDAwMDA+Ow0KPiA+ICAgICAgICAgICAgICAgICBtYm94LW5hbWVzID0gInR4
IiwgInJ4IiwgInJ4ZGIiOw0KPiA+ICAgICAgICAgICAgICAgICBtYm94ZXMgPSA8JmxzaW9fbXU1
IDAgMQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgJmxzaW9fbXU1IDEgMQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmxzaW9fbXU1IDMgMT47DQo+ID4gICAgICAgICAgICAg
ICAgIG11Yi1wYXJ0aXRpb24gPSA8Mz47DQo+ID4gICAgICAgICAgICAgICAgIG1lbW9yeS1yZWdp
b24gPSA8JnZkZXYwdnJpbmcwPiwgPCZ2ZGV2MHZyaW5nMT4sDQo+IDwmdmRldmJ1ZmZlcj4sDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnZkZXYxdnJpbmcwPiwgPCZ2ZGV2
MXZyaW5nMT47DQo+ID4gICAgICAgICAgICAgICAgIGNvcmUtaW5kZXggPSA8MD47DQo+ID4gICAg
ICAgICAgICAgICAgIGNvcmUtaWQgPSA8SU1YX1NDX1JfTTRfMF9QSUQwPjsNCj4gPiAgICAgICAg
ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICAgICAgICAgICAgICAgICBwb3dlci1kb21h
aW5zID0gPCZwZCBJTVhfU0NfUl9NNF8wX1BJRDA+LA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPCZwZCBJTVhfU0NfUl9NNF8wX01VXzFBPjsNCj4gPiAgICAgICAgIH07DQo+
ID4NCj4gPiAgICAgICAgIGlteDhxbV9jbTQxOiBpbXg4eF9jbTRAMSB7DQo+ID4gICAgICAgICAg
ICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhxbS1jbTQiOw0KPiA+ICAgICAgICAgICAgICAg
ICByc2MtZGEgPSA8MHg5MDEwMDAwMD47DQo+ID4gICAgICAgICAgICAgICAgIG1ib3gtbmFtZXMg
PSAidHgiLCAicngiLCAicnhkYiI7DQo+ID4gICAgICAgICAgICAgICAgIG1ib3hlcyA9IDwmbHNp
b19tdTYgMCAxDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAmbHNpb19tdTYgMSAxDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAmbHNpb19tdTYgMyAxPjsNCj4gPiAgICAgICAg
ICAgICAgICAgbXViLXBhcnRpdGlvbiA9IDw0PjsNCj4gPiAgICAgICAgICAgICAgICAgbWVtb3J5
LXJlZ2lvbiA9IDwmdmRldjJ2cmluZzA+LCA8JnZkZXYydnJpbmcxPiwNCj4gPCZ2ZGV2YnVmZmVy
PiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmdmRldjN2cmluZzA+LCA8
JnZkZXYzdnJpbmcxPjsNCj4gPiAgICAgICAgICAgICAgICAgY29yZS1pbmRleCA9IDwxPjsNCj4g
PiAgICAgICAgICAgICAgICAgY29yZS1pZCA9IDxJTVhfU0NfUl9NNF8xX1BJRDA+Ow0KPiA+ICAg
ICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gICAgICAgICAgICAgICAgIHBvd2Vy
LWRvbWFpbnMgPSA8JnBkIElNWF9TQ19SX000XzFfUElEMD4sDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8JnBkIElNWF9TQ19SX000XzFfTVVfMUE+Ow0KPiA+ICAgICAgICAg
fTsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICB2ZGV2YnVmZmVyOiB2ZGV2YnVmZmVyIHsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNoYXJlZC1kbWEtcG9vbCI7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDAgMHg5MDQwMDAwMCAwIDB4MTAw
MDAwPjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBuby1tYXA7DQo+ID4gICAgICAgICAg
ICAgICAgIH07DQo+ID4NCj4gPiBJIGhhdmUgdGhlIHVwcGVyIHZkZXZidWZmZXIgbm9kZSBzaGFy
ZWQgYmV0d2VlbiBNNDAgYW5kIE00MSBub2RlLg0KPiA+IFRoZSB2ZGV2YnVmZmVyIHdpbGwgYmUg
dXNlZCBhcyB2aXJ0aW8gZGF0YSBidWZmZXIuDQo+ID4NCj4gPiBBbmQgSSBoYXZlIHRoZSBmb2xs
b3dpbmcgaW4gcnByb2NfYWRkX3ZpcnRpb19kZXYgdG8gc2hhcmUgdmRldmJ1ZmZlcjoNCj4gPiAg
ICAgICAgIC8qIFRyeSB0byBmaW5kIGRlZGljYXRlZCB2ZGV2IGJ1ZmZlciBjYXJ2ZW91dCAqLw0K
PiA+ICAgICAgICAgbWVtID0gcnByb2NfZmluZF9jYXJ2ZW91dF9ieV9uYW1lKHJwcm9jLCAidmRl
diVkYnVmZmVyIiwNCj4gcnZkZXYtPmluZGV4KTsNCj4gPiAgICAgICAgIGlmICghbWVtKQ0KPiA+
ICAgICAgICAgICAgICAgICBtZW0gPSBycHJvY19maW5kX2NhcnZlb3V0X2J5X25hbWUocnByb2Ms
DQo+ID4gInZkZXZidWZmZXIiKTsNCj4gDQo+IFdpdGgga2VybmVsIHY1LjgtcmM3IGkgZ2V0IGZv
bGxvd2luZyBjYWxsIGNoYWluOg0KDQpQbGVhc2UgdXNlIExpbnV4LW5leHQgd2hpY2ggaGFzIHN1
cHBvcnQgb2YgTTQgYm9vdGVkIGJlZm9yZSBMaW51eCBpbg0KaW4gcmVtb3RlcHJvYy4NCg0KPiBy
cHJvY19ib290KCkNCj4gICBycHJvY19md19ib290KCkNCj4gICAgIHJwcm9jX2hhbmRsZV92ZGV2
DQo+ICAgICAgIHJwcm9jX3ZkZXZfZG9fc3RhcnQoKQ0KPiAgICAgICAgIHJwcm9jX2FkZF92aXJ0
aW9fZGV2KCkNCj4gDQo+IA0KPiBTbywgYXQgdGhlIGVuZCwgd2Ugd2lsbCBjYWxsIHJwcm9jX2Fk
ZF92aXJ0aW9fZGV2KCkgb25seSBpZiB3ZSBib290IGZpcm13YXJlIGJ5DQo+IGxpbnV4LCBvciBp
ZiB3ZSBnZXQgYXQgbGVhc3QgdGhlIHJlc291cmNlIHRhYmxlLg0KDQoNClJlc291cmNlIHRhYmxl
IGNvdWxkIGJlIGdvdCBmcm9tIGVsZiBmaWxlIGlmIGl0IGlzIGJvb3RlZCBieSBMaW51eCwgb3Ig
Z290IGZyb20NCmFuIGFkZHJlc3MgaWYgTTQgaXMgYm9vdGVkIGJlZm9yZSBMaW51eC4NCg0KVGhh
bmtzLA0KUGVuZy4NCg0KPiANCj4gU2luY2Ugbm9uZSBvZiB0aGlzIHNlZW1zIHRvIGJlIHRoZSBj
YXNlLCBpIHN0aWxsIGRvIG5vdCB1bmRlcnN0YW5kIGhvdyBpdCBzaG91bGQNCj4gd29yay4NCj4g
DQo+ID4gSG9wZSB0aGlzIGlzIGNsZWFyLg0KPiANCj4gOikgaSBzdGlsbCBuZWVkIHNvbWUgdGlt
ZSB0byB1bmRlcnN0YW5kIGl0Lg0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwNCj4gfA0KPiBTdGV1ZXJ3YWxkZXIgU3RyLiAyMSAgICAgICAg
ICAgICAgICAgICAgICAgfA0KPiBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlLyAgfA0KPiAzMTEz
NyBIaWxkZXNoZWltLCBHZXJtYW55ICAgICAgICAgICAgICAgICAgfCBQaG9uZToNCj4gKzQ5LTUx
MjEtMjA2OTE3LTAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAg
ICAgICAgfCBGYXg6DQo+ICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCg==
