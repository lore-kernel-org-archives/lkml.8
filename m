Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3789C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C22208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sm65qofP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIAGHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:07:07 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:2496
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgIAGHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlE9N/XWyp/SLlOeOubUByir6BWz5MQYwR2WoP0UzSBJtpaLM+k5nSDRRynqoh6pvE2hxl8oWFChXL7oxgJj/NF0mkGLKXEc43jPk0fFGrJJnlNjuk1MHJqpNMMSRFl3vg645v4jMHCz9vbig/79p8bAPdgLOXUExHGqQ6wHOlUFyix5+3Q3/4MRG9TwLfDlvuERRJtpX4Z2meWgglNu7gyeqajKTHqbEhvLI7Ry3xUDCO2nRDpyniIBwD66GSncOzo4+uloM5v5Y9rF7cauiMrk65y1osyUnG3y1vesA/6o9sfnnj+N8bVQE3LVTiY1f3PFten9iPeB54oQMld7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNK78HNMAGyhZn/Iq0wFC7F4sYMkqLoXQjSfe8WeJOw=;
 b=Ux/7TEkwTdNSR2Nr43PejFxMl/649qCpNkKIP4c+uPasS6kex1+MtmZfJozE5a4VeqBG+TwtwMj9kTxWlk9/rNLPX6Gxg97rsvj3hCOPBfcLZIzWOvGds4RVjFJg7l5KUT5pQzO6ukCl75JyGasL9/xyOo7+ymLin5XoKvgUpFXDYjLRldX281Iud4YYBuL39VBOxzG6kPVbruMrcdu/+hiWRj6LxMC9PoZBb+VdhImdfTM7TxztC0VJP3roFgxzyUwLabVn619ZB07Yk8CWy5rFtbYK7G5O797MjcOB/acQY1i0clCBSLSbUmxtpJ6e1OimtEZJe/T5ckqNnwNALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNK78HNMAGyhZn/Iq0wFC7F4sYMkqLoXQjSfe8WeJOw=;
 b=sm65qofPR8U/Ad3dYFf71E+Ag5cZtbSS815XKfAKPDgLNS+/LSoPKxCjb++qcM44/Sn+nzcRvCCyyyXeV1WV38/M5I/WMIg2zfMuouuns2NR59ArMlSjm5Zf2qD2mmFFgy+AKrO69p4UUik+5pRzPSIpXjU9WPdHfqNwdRx9yyQ=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5996.eurprd04.prod.outlook.com (2603:10a6:10:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 1 Sep
 2020 06:07:01 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 06:07:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Saravana Kannan <saravanak@google.com>,
        Dong Aisheng <dongas86@gmail.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: RE: Lockdep warning caused by "driver core: Fix sleeping in invalid
 context during device link deletion"
Thread-Topic: Lockdep warning caused by "driver core: Fix sleeping in invalid
 context during device link deletion"
Thread-Index: AQHWd25DMUiRIq7S7EyPspLtfmrMiKlLc8sAgAdlsYCAAIN2YA==
Date:   Tue, 1 Sep 2020 06:07:01 +0000
Message-ID: <DB6PR0402MB2760752E2666D486B40104B3882E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com>
 <CAGETcx8Ums+mkD54BCkCvBtU1qx13VZH=DOPqepyiQz62REfCw@mail.gmail.com>
 <CAGETcx_=Da7hVUCfOFd13Q6YAGPC65VSJD7BiCK_fCegYMCJbQ@mail.gmail.com>
In-Reply-To: <CAGETcx_=Da7hVUCfOFd13Q6YAGPC65VSJD7BiCK_fCegYMCJbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9603f58d-2b10-4c12-6268-08d84e3d3e43
x-ms-traffictypediagnostic: DB7PR04MB5996:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5996AB7705ADE3A9BABCC231882E0@DB7PR04MB5996.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:580;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBDiWilSWz2kGHDZHq4u2eZkg1PN0zQpURwHJ4wnJDWYDQsZyyW0wra/zpo/fsQNizn+0ggRMiSczymTHeBNCdRYvf2PYLc3SUAEpfeWZ79kaYRLjqETwOhGnmbcG9czAO6H8u8Zl6O/s0SsB8Y8PiLcu5w92LVXgxgx22wzlUQS4IuPBmGMZHsB7QoVJIX1gNXD8fL1dqjmvFUSca9a79y8/C+Nrmamt9M+howN5Xir+GmX1g2y9wgJ/cEL7Q0ab+8JjeYYwVH5UdVBSnRAsuQSZR6Pj5p/wvZE/CA5+U0b/Wm/WfmE1BOw0m8rRg4V3E9grJdozyPBwxpsGL4WQA3wW247koywARO/A/Wu8q4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(7696005)(478600001)(54906003)(6506007)(4326008)(53546011)(966005)(44832011)(110136005)(86362001)(26005)(186003)(2906002)(316002)(8936002)(64756008)(66476007)(45080400002)(83380400001)(66946007)(52536014)(7416002)(8676002)(66556008)(9686003)(5660300002)(66446008)(55016002)(76116006)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EO9Fwo16oAXUBybmEaihfRXx0acewwzBMAAq8krw/Q/S6SOkv7sWFco0JSTxMzUVOXzexJJBiLS8rNah2hbi+OexMFtsmSoSC5SgIJVkPDkzZ1yUXTeaYQqYyJvT0rYzxptf93zMAvRIgepzD5uDPU2OykL0Hjets7uscww3I76W1QGxnZ+MvvZqM0rhTYLtIOWfjll+dyTEVV37dQdklfLZlpK7W6VpRgyEyuyqtnPpTa3L1hk3n0M2rGKd7whcdJ/lXD7YFcOVzXQz8vtzkuNZ8F4mp43uEWxl2tgEnCOo6Zlpeu/nmU8t4QYNIKsCokaVJLGuR7HFj9amjbQqr2wP0dYUw7eFAwCFWyc1x773RGKL6oSAIh9jIYU7Blz8YuqA+l0ZOuWazhPk/FuchCSl8lkrcL1ESqX06msB7PC9ZQ2VmCOTum9zWJ1xPs4JRxKFKxrELkHR13gI1WL01alGCe2yF5YaNluPdCC+CCcJmBML3dJ3vhqmrYRtbLL0n5whK47jTHxmySY9TgquyMpVO8nTdeNp3mJXfRsRdj+Ab12nGC0a7xYboc5KfYl5RTmlg4vSF7I6D1EGC7YP1UGpPAkaZ2cwFW13UNJhg8TmX5C0FoUQRs5cTRdZ0YHYgcJGE/5DsNq6LFQekbVgNw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9603f58d-2b10-4c12-6268-08d84e3d3e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 06:07:01.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9RVk79in0/hCNbKC3dYSdRHb/eH1W7ofdQQmQ83bfx2JKpFHjRfy3T+9nnZ77lMU4ihpw3Nu1kmwZKZzXwGhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5996
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogTG9ja2RlcCB3YXJuaW5nIGNhdXNlZCBieSAiZHJpdmVyIGNvcmU6IEZp
eCBzbGVlcGluZyBpbiBpbnZhbGlkDQo+IGNvbnRleHQgZHVyaW5nIGRldmljZSBsaW5rIGRlbGV0
aW9uIg0KPiANCj4gT24gV2VkLCBBdWcgMjYsIDIwMjAgYXQgMTA6MTcgUE0gU2FyYXZhbmEgS2Fu
bmFuDQo+IDxzYXJhdmFuYWtAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIEF1
ZyAyMCwgMjAyMCBhdCA4OjUwIFBNIERvbmcgQWlzaGVuZyA8ZG9uZ2FzODZAZ21haWwuY29tPg0K
PiB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSBBTEwsDQo+ID4gPg0KPiA+ID4gV2UgbWV0IHRoZSBi
ZWxvdyBXQVJOSU5HIGR1cmluZyBzeXN0ZW0gc3VzcGVuZCBvbiBhbiBpTVg2USBTREINCj4gYm9h
cmQNCj4gPiA+IHdpdGggdGhlIGxhdGVzdCBsaW51cy9tYXN0ZXIgYnJhbmNoICh2NS45LXJjMSsp
IGFuZCBuZXh0LTIwMjAwODIwLg0KPiA+ID4gdjUuOCBrZXJuZWwgaXMgb2suIFNvIGkgZGlkIGJp
c2VjdCBhbmQgZmluYWxseSBmb3VuZCBpdCdzIGNhdXNlZCBieQ0KPiA+ID4gdGhlIHBhdGNoIGJl
bG93Lg0KPiA+ID4gUmV2ZXJ0aW5nIGl0IGNhbiBnZXQgcmlkIG9mIHRoZSB3YXJuaW5nLCBidXQg
SSB3b25kZXIgaWYgdGhlcmUgbWF5DQo+ID4gPiBiZSBvdGhlciBwb3RlbnRpYWwgaXNzdWVzLg0K
PiA+ID4gQW55IGlkZWFzPw0KPiA+ID4NCj4gPiA+IERlZmNvbmZpZyB1c2VkIGlzOiBpbXhfdjZf
djdfZGVmY29uZmlnDQo+ID4gPg0KPiA+DQo+ID4gLS0tLS0gODwgLS0tLS0gU25pcHBlZCB0ZXh0
IHRoYXQgd2FzIGEgYml0IG1pc2xlYWRpbmcNCj4gPg0KPiA+ID4NCj4gPiA+IEVycm9yIGxvZzoN
Cj4gPiA+ICMgZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRlDQo+ID4gPiBbICAgMzkuMTExODY1
XSBQTTogc3VzcGVuZCBlbnRyeSAoZGVlcCkNCj4gPiA+IFsgICAzOS4xNDg2NTBdIEZpbGVzeXN0
ZW1zIHN5bmM6IDAuMDMyIHNlY29uZHMNCj4gPiA+IFsgICAzOS4xNTQwMzRdDQo+ID4gPiBbICAg
MzkuMTU1NTM3XQ0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCj4gPiA+IFsgICAzOS4xNjE3MjNdIFdBUk5JTkc6IHBvc3NpYmxlIGNpcmN1
bGFyIGxvY2tpbmcgZGVwZW5kZW5jeSBkZXRlY3RlZA0KPiA+ID4gWyAgIDM5LjE2NzkxMV0gNS45
LjAtcmMxLTAwMTAzLWc3ZWFjNjZkMDQ1NmYgIzM3IE5vdCB0YWludGVkDQo+ID4gPiBbICAgMzku
MTczMzE1XSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gPiA+IFsgICAzOS4xNzk1MDBdIHNoLzY0NyBpcyB0cnlpbmcgdG8gYWNxdWlyZSBs
b2NrOg0KPiA+ID4gWyAgIDM5LjE4Mzg2Ml0gYzE1YTMxMGMgKGRwbV9saXN0X210eCl7Ky4rLn0t
ezM6M30sIGF0Og0KPiA+ID4gZHBtX2Zvcl9lYWNoX2RldisweDIwLzB4NWMNCj4gPiA+IFsgICAz
OS4xOTEyMDBdDQo+ID4gPiBbICAgMzkuMTkxMjAwXSBidXQgdGFzayBpcyBhbHJlYWR5IGhvbGRp
bmcgbG9jazoNCj4gPiA+IFsgICAzOS4xOTcwMzZdIGMxNWEzN2U0IChmd19sb2NrKXsrLisufS17
MzozfSwgYXQ6DQo+IGZ3X3BtX25vdGlmeSsweDkwLzB4ZDQNCj4gPiA+IFsgICAzOS4yMDM1ODJd
DQo+ID4gPiBbICAgMzkuMjAzNTgyXSB3aGljaCBsb2NrIGFscmVhZHkgZGVwZW5kcyBvbiB0aGUg
bmV3IGxvY2suDQo+ID4gPiBbICAgMzkuMjAzNTgyXQ0KPiA+ID4gWyAgIDM5LjIxMTc2M10NCj4g
PiA+IFsgICAzOS4yMTE3NjNdIHRoZSBleGlzdGluZyBkZXBlbmRlbmN5IGNoYWluIChpbiByZXZl
cnNlIG9yZGVyKSBpczoNCj4gPiA+IFsgICAzOS4yMTkyNDldDQo+ID4gPiBbICAgMzkuMjE5MjQ5
XSAtPiAjMiAoZndfbG9jayl7Ky4rLn0tezM6M306DQo+ID4gPiBbICAgMzkuMjI0NjczXSAgICAg
ICAgbXV0ZXhfbG9ja19uZXN0ZWQrMHgxYy8weDI0DQo+ID4gPiBbICAgMzkuMjI5MTI2XSAgICAg
ICAgZmlybXdhcmVfdWV2ZW50KzB4MTgvMHhhMA0KPiA+ID4gWyAgIDM5LjIzMzQxMV0gICAgICAg
IGRldl91ZXZlbnQrMHhjNC8weDFmOA0KPiA+ID4gWyAgIDM5LjIzNzM0M10gICAgICAgIHVldmVu
dF9zaG93KzB4OTgvMHgxMTQNCj4gPiA+IFsgICAzOS4yNDEzNjJdICAgICAgICBkZXZfYXR0cl9z
aG93KzB4MTgvMHg0OA0KPiA+ID4gWyAgIDM5LjI0NTQ3Ml0gICAgICAgIHN5c2ZzX2tmX3NlcV9z
aG93KzB4ODQvMHhlYw0KPiA+ID4gWyAgIDM5LjI0OTkyN10gICAgICAgIHNlcV9yZWFkKzB4MTM4
LzB4NTUwDQo+ID4gPiBbICAgMzkuMjUzNzc0XSAgICAgICAgdmZzX3JlYWQrMHg5NC8weDE2NA0K
PiA+ID4gWyAgIDM5LjI1NzUyOV0gICAgICAgIGtzeXNfcmVhZCsweDYwLzB4ZTgNCj4gPiA+IFsg
ICAzOS4yNjEyODhdICAgICAgICByZXRfZmFzdF9zeXNjYWxsKzB4MC8weDI4DQo+ID4gPiBbICAg
MzkuMjY1NTY0XSAgICAgICAgMHhiZWQ3YzgwOA0KPiA+ID4gWyAgIDM5LjI2ODUzOF0NCj4gPiA+
IFsgICAzOS4yNjg1MzhdIC0+ICMxIChrbi0+YWN0aXZlIzMpeysrKyt9LXswOjB9Og0KPiA+ID4g
WyAgIDM5LjI3NDM5MV0gICAgICAgIGtlcm5mc19yZW1vdmVfYnlfbmFtZV9ucysweDQwLzB4OTQN
Cj4gPiA+IFsgICAzOS4yNzk0NTBdICAgICAgICBkZXZpY2VfZGVsKzB4MTQ0LzB4M2ZjDQo+ID4N
Cj4gPiBSYWZhZWwvR3JlZywNCj4gPg0KPiA+IEknbSBub3QgdmVyeSBmYW1pbGlhciB3aXRoIHRo
ZSAjMCBhbmQgIzIgY2FsbHMgc3RhY2tzLiBCdXQgcG9raW5nDQo+ID4gYXJvdW5kIGEgYml0LCB0
aGV5IGFyZSBOT1QgZHVlIHRvIHRoZSBkZXZpY2UtbGluay1kZXZpY2UuIEJ1dCB0aGUgbmV3DQo+
ID4gc3R1ZmYgaXMgdGhlIGFib3ZlIHR3byBsaW5lcyB0aGF0IGFyZSBkZWxldGluZyB0aGUgZGV2
aWNlLWxpbmstZGV2aWNlDQo+ID4gKHRoYXQncyB1c2VkIHRvIGV4cG9zZSBkZXZpY2UgbGluayBk
ZXRhaWxzIGluIHN5c2ZzKSB3aGVuIHRoZSBkZXZpY2UNCj4gPiBsaW5rIGlzIGRlbGV0ZWQuDQo+
ID4NCj4gPiBLaWNraW5nIG9mZiBhIHdvcmtxdWV1ZSB0byBicmVhayB0aGlzIGN5Y2xlIGlzIGVh
c3ksIGJ1dCB0aGUgcHJvYmxlbQ0KPiA+IGlzIHRoYXQgaWYgSSBxdWV1ZSBhIHdvcmsgdG8gZGVs
ZXRlIHRoZSBkZXZpY2UsIHRoZW4gdGhlIHN5c2ZzIGZvbGRlcg0KPiA+IHdvbid0IGdldCByZW1v
dmVkIGltbWVkaWF0ZWx5LiBBbmQgaWYgdGhlIHNhbWUgbGluayBpcyBjcmVhdGVkIGFnYWluDQo+
ID4gYmVmb3JlIHRoZSB3b3JrIGlzIGNvbXBsZXRlZCwgdGhlbiB0aGVyZSdsbCBiZSBhIHN5c2Zz
IG5hbWUgY29sbGlzaW9uDQo+ID4gYW5kIHdhcm5pbmcuDQo+ID4NCj4gPiBTbywgSSdtIGtpbmRh
IHN0dWNrIGhlcmUuIE9wZW4gdG8gc3VnZ2VzdGlvbnMuIEhvcGluZyB5b3UnbGwgaGF2ZQ0KPiA+
IGJldHRlciBpZGVhcyBmb3IgYnJlYWtpbmcgdGhlIGN5Y2xlLiBPciBwb2ludCBvdXQgaG93IEkn
bQ0KPiA+IG1pc3VuZGVyc3RhbmRpbmcgdGhlIGN5Y2xlIGhlcmUuDQo+ID4NCj4gDQo+IEFpc2hl
bmcsDQo+IA0KPiBTZW50IG91dCBhIGZpeCB0aGF0IEkgdGhpbmsgc2hvdWxkIHdvcmsuDQo+IGh0
dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxvcmUua2UNCj4gcm5lbC5vcmclMkZsa21sJTJGMjAyMDA4MzEyMjEwMDcuMTUwNjQ0
MS0xLXNhcmF2YW5hayU0MGdvb2dsZS5jb20lDQo+IDJGVCUyRiUyM3UmYW1wO2RhdGE9MDIlN0Mw
MSU3Q3BlbmcuZmFuJTQwbnhwLmNvbSU3QzMyNTQ2MDRkNw0KPiA0MWI0ZDFjZTczYjA4ZDg0ZGZi
NjVhZiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMA0KPiAlN0MwJTdDNjM3
MzQ1MDg5NDI4MDc3NjA5JmFtcDtzZGF0YT01bGg4V08lMkJZTWg0QzFzQm41OEZzbQ0KPiBYc2px
alBqJTJCJTJGQjcxJTJGRU5mTUdEdFRrJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBJIHdhc24n
dCBhYmxlIHRvIHJlcHJvZHVjZSBpdCBpbiBteSBoYXJkd2FyZS4gU28sIGlmIHlvdSBjYW4gdGVz
dCB0aGF0IHBhdGNoDQo+IChhbmQgcmVzcG9uZCB0byB0aGF0IHRocmVhZCksIHRoYXQnZCBiZSBn
cmVhdC4NCg0KSSBub3QgZm91bmQgeW91ciBwYXRjaCBpbiBteSBtYWlsYm94LCBidXQgYW55d2F5
IEkgdGVzdGVkIGl0Lg0KDQpUZXN0ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPiAo
aS5NWDdVTFAgRVZLKQ0KDQpSZWdhcmRzLA0KUGVuZy4NCg0KPiANCj4gLVNhcmF2YW5hDQo=
