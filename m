Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C225AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F67920759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QeaPw3RN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgEUHde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:33:34 -0400
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:1441
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728400AbgEUHdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:33:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHalct0y9e78N8ovC/1jSmJjfnWjr5w4mHQR+owzXiVXmNgi6VgXP1GY6xad+lhKVBG4IGZJKA7BZcsVt+G2HEU0naqWjbIMqrubueGPCMB19bZz7kpE3mBk7EippwcjvrDUlZFfrXU51wx+Gbz/0XJL7720izJ/FhG5rpbxDdu4/OCcjNS6rskm8PYdBxgd9yEbd8jDuy6eUyv6bWIYcArFhbedsZ1Juky6zMp/l0ck5abDcVAw8h4FL9Yevfm36Dv2MkDYiP6VUOJj5QRJ993oNKBNsQOG+CC2pchYxIcr3XFodYQzyeDzVgBnxPOl9zk5xtcxCZX79ocgQRhu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEpeP17j3VQtJGYdZh0998bcj6aRk2vitGRtSjMFuN8=;
 b=FA9xk96L4HIOox4EUBB9gveWGq+Vx+5V+k18f5vP5HDSqnBXWj85VJ2hS3Qc5ELOHFdwPyrATlg7iNcmvGyFDBKQrY4EpVSIzBSfLztfuFlWZXty/LDRJrQ6KHiO5Nv2RerALzhvqE6LWAOQtG5IPj5qAmvdLuLPmaTSg7XUE/oMcj44GEVB/JOgYt2M7c5GWUhQoMOIPxtC7CjTIMDbxOXIuh2xa8jYevVZXxgZlR2CS14tN2Vl67AEZrP/Zn9Voz5pybQ37DboSW2fCSEB11pab+G0P7Ocd6U36Y1UXBR9Bko1lmZ6EPUFhOKe+FcE1F10P+HgPBYndmJqOWjo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEpeP17j3VQtJGYdZh0998bcj6aRk2vitGRtSjMFuN8=;
 b=QeaPw3RNF0l6OC8WY9m/ssEeynOb+6CPjOrNMdDsfksWSKzfcCrcTJ7/Z01aWD70PB0hnmRFBQI0MewCgqWyNKf2eav9sT+E0Wk5NzZSRy9VfBUssBLUk6AtEryUD7uiiMjUjyXzONECwggGmGpIaXbFcaj5KjXAYd/gbP69Bc0=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VE1PR04MB6365.eurprd04.prod.outlook.com (2603:10a6:803:120::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Thu, 21 May
 2020 07:33:25 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03%7]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 07:33:25 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Jun Li <lijun.kernel@gmail.com>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: RE: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Topic: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Index: AQHWJdlQZJAsekudzECWhic28QWur6io62yAgAAEAECAAPXLAIAAcdqAgAAhu3CAAC3agIADIntQgAE4rYCAAATjgIAACqpAgAK7RQCAAA2agIAAAwQg
Date:   Thu, 21 May 2020 07:33:25 +0000
Message-ID: <VE1PR04MB652863A8406D25EEF2CE483389B70@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
 <87h7wqmwrv.fsf@kernel.org>
 <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
 <87imgx35pg.fsf@kernel.org>
 <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com>
 <87ftc0xsig.fsf@kernel.org>
 <VE1PR04MB6528AB046FD441A5DDD83CD289BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <87d074xfbq.fsf@kernel.org>
 <VE1PR04MB6528A50EA40BF40E4B09793789B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <db7447c2-a39d-361f-8b35-a1d5c2705c89@synopsys.com>
 <e3b0ff51-70ab-7d16-2c7e-cacac7d97043@synopsys.com>
 <VE1PR04MB65286728B9546B5FAA818A0A89B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <bbfbd3f7-4908-5529-1a4e-29469e794b27@synopsys.com>
 <1c16bdb6-8d8d-1e1b-f08b-b3963f905eb0@synopsys.com>
In-Reply-To: <1c16bdb6-8d8d-1e1b-f08b-b3963f905eb0@synopsys.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7810d263-ee7d-4898-c434-08d7fd593fb5
x-ms-traffictypediagnostic: VE1PR04MB6365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB63658ECA2332B38F5F41C52289B70@VE1PR04MB6365.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9Imi0uHm6ujzcrdF+z5GWQVPZ4AF/WZjHgkasOnCRXOS/fODaO1Wuv058JRnFHtccOZY5UgSYbTlz6Oso3T3Cg7MlIJZpCk/FwkQqmHrML585I+a2hwJDnNnULZbQ4YsPURieVhGBRrS4o+M/LYZlrIiItH7wbEkBV8Oh05ySOKg1X0MsFmtoYhSkUB9qN9Pyu4JqOIUGzZzQl7wAo0M0YQl00a1Dfe67ekgiIoQ6+eAvAcoFXkhC7ZOFLex1FyvUm9WTozefyMHSn+5bmdH8zE3d+Z+kL1NPy3f+boKZl3qG7hMHDjQR93KnpjzW5IqqzOmNhLbEmWaYKsi6Gly5Tb4YOaTj/YCDSFHSxp6mPvyfmmDsj+qHpmR+F9eSYqKDWXhmHGKqweV+ctsUyGWvoMyspJ0RpLuyjEYsxLb1mZVyo4egpmpcPX/qQIA9Qc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(52536014)(26005)(8936002)(5660300002)(110136005)(71200400001)(186003)(66446008)(54906003)(64756008)(86362001)(66556008)(66476007)(316002)(478600001)(66946007)(76116006)(53546011)(4326008)(6506007)(55016002)(8676002)(44832011)(7416002)(7696005)(2906002)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BAkAD/IoSE/2Ffy8ZRA9nD67bz7NZfv75LyAHQOmWjkuy03mHt/KeFVvI9oIHJiWlZ6OloDHbgSyrPHQYEkc397keruERKqNaDT7t+YJ3j33QIndf9lRVMmuUGFR618ceZuUU4lnMYt+sOqnlSN7oXwmfc+CEgCMzJEo2n96gv5Ffl4dzEdvjH2xvZ0bWwwO2TpPUeCCjOtstlCDjFgpV3HzE1vIbflPP1brQaNEA39iALf70pD04f9KwOhcIiTQ7MTItyCNI5awbUngGF78bZYRITm6Tm9m7N1r7ccsZhWoAkSVtPmIaZqOm0stA0uZxsxSCcO0dOo+ZVesTPqMn0Azjl/sZdbQJQSPqC/8kE5xqSL4SRDrgTjq6a+jHJ91ZgA2QaNBgazf/ac4T4f3XQ+O6SWbtjShniyBE3kFrpJRHhxupIt9StBj50IsAlk4FbmmLMwPfmJ/2nYe7He7eiJtLN8LHOcfEvcqvwRTth2WFH1IjuP3Lr4BBapRTRXF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7810d263-ee7d-4898-c434-08d7fd593fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 07:33:25.7888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AASTPWggbngdzZfloPLE0vJtLUjJa8x+ZwLO7y+C8itSSBCQPn9ionZ61iNn7HB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRoaW5oIE5n
dXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gU2VudDogMjAyMOW5tDXmnIgyMeaX
pSA5OjU2DQo+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPjsgRmVsaXBlIEJhbGJpIDxiYWxi
aUBrZXJuZWwub3JnPjsgSnVuIExpDQo+IDxsaWp1bi5rZXJuZWxAZ21haWwuY29tPg0KPiBDYzog
Sm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+OyBsa21sIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgWXUNCj4gQ2hlbiA8Y2hlbnl1NTZAaHVhd2VpLmNvbT47IEdyZWcg
S3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBSb2INCj4gSGVycmlu
ZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNv
bT47IFNodUZhbiBMZWUNCj4gPHNodWZhbl9sZWVAcmljaHRlay5jb20+OyBIZWlra2kgS3JvZ2Vy
dXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+Ow0KPiBTdXp1a2kgSyBQb3Vsb3Nl
IDxzdXp1a2kucG91bG9zZUBhcm0uY29tPjsgQ2h1bmZlbmcgWXVuDQo+IDxjaHVuZmVuZy55dW5A
bWVkaWF0ZWsuY29tPjsgSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT47IEFuZHkg
U2hldmNoZW5rbw0KPiA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IFZhbGVudGluIFNjaG5l
aWRlciA8dmFsZW50aW4uc2NobmVpZGVyQGFybS5jb20+Ow0KPiBKYWNrIFBoYW0gPGphY2twQGNv
ZGVhdXJvcmEub3JnPjsgTGludXggVVNCIExpc3QgPGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc+
OyBvcGVuDQo+IGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJ
TkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47DQo+IFBldGVyIENoZW4gPHBldGVy
LmNoZW5AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAzLzldIHVzYjogZHdjMzog
SW5jcmVhc2UgdGltZW91dCBmb3IgQ21kQWN0IGNsZWFyZWQgYnkgZGV2aWNlDQo+IGNvbnRyb2xs
ZXINCj4gDQo+IFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBKdW4gTGkgd3JvdGU6DQo+ID4+IEhp
DQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogVGhp
bmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+Pj4gU2VudDogMjAyMOW5
tDXmnIgxOeaXpSAxNDo0Ng0KPiA+Pj4gVG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+OyBGZWxp
cGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+OyBKdW4gTGkNCj4gPj4+IDxsaWp1bi5rZXJuZWxA
Z21haWwuY29tPg0KPiA+Pj4gQ2M6IEpvaG4gU3R1bHR6IDxqb2huLnN0dWx0ekBsaW5hcm8ub3Jn
PjsgbGttbA0KPiA+Pj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBZdSBDaGVuIDxj
aGVueXU1NkBodWF3ZWkuY29tPjsgR3JlZw0KPiA+Pj4gS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+OyBSb2IgSGVycmluZw0KPiA+Pj4gPHJvYmgrZHRAa2VybmVsLm9y
Zz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBTaHVGYW4NCj4gPj4+IExl
ZSA8c2h1ZmFuX2xlZUByaWNodGVrLmNvbT47IEhlaWtraSBLcm9nZXJ1cw0KPiA+Pj4gPGhlaWtr
aS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+Ow0KPiA+Pj4gU3V6dWtpIEsgUG91bG9zZSA8c3V6
dWtpLnBvdWxvc2VAYXJtLmNvbT47IENodW5mZW5nIFl1bg0KPiA+Pj4gPGNodW5mZW5nLnl1bkBt
ZWRpYXRlay5jb20+OyBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsNCj4gPj4+
IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IFZhbGVudGluIFNj
aG5laWRlcg0KPiA+Pj4gPHZhbGVudGluLnNjaG5laWRlckBhcm0uY29tPjsgSmFjayBQaGFtIDxq
YWNrcEBjb2RlYXVyb3JhLm9yZz47DQo+ID4+PiBMaW51eCBVU0IgTGlzdCA8bGludXgtdXNiQHZn
ZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFDQo+ID4+PiBBTkQgRkxBVFRF
TkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47DQo+
ID4+PiBQZXRlciBDaGVuIDxwZXRlci5jaGVuQG54cC5jb20+DQo+ID4+PiBTdWJqZWN0OiBSZTog
W1BBVENIIHY0IDMvOV0gdXNiOiBkd2MzOiBJbmNyZWFzZSB0aW1lb3V0IGZvciBDbWRBY3QNCj4g
Pj4+IGNsZWFyZWQgYnkgZGV2aWNlIGNvbnRyb2xsZXINCj4gPj4+DQo+ID4+PiBUaGluaCBOZ3V5
ZW4gd3JvdGU6DQo+ID4+Pj4gSnVuIExpIHdyb3RlOg0KPiA+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4+Pj4+IEZyb206IEZlbGlwZSBCYWxiaSA8YmFsYmlmQGdtYWlsLmNv
bT4gT24gQmVoYWxmIE9mIEZlbGlwZSBCYWxiaQ0KPiA+Pj4+Pj4gU2VudDogMjAyMOW5tDXmnIgx
NuaXpSAxOTo1Nw0KPiA+Pj4+Pj4gVG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+OyBUaGluaCBO
Z3V5ZW4NCj4gPj4+Pj4+IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPjsgSnVuIExpIDxsaWp1
bi5rZXJuZWxAZ21haWwuY29tPg0KPiA+Pj4+Pj4gQ2M6IEpvaG4gU3R1bHR6IDxqb2huLnN0dWx0
ekBsaW5hcm8ub3JnPjsgbGttbA0KPiA+Pj4+Pj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBZdSBDaGVuIDxjaGVueXU1NkBodWF3ZWkuY29tPjsNCj4gPj4+Pj4+IEdyZWcgS3JvYWgt
SGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBSb2IgSGVycmluZw0KPiA+Pj4+
Pj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5j
b20+OyBTaHVGYW4NCj4gPj4+Pj4+IExlZSA8c2h1ZmFuX2xlZUByaWNodGVrLmNvbT47IEhlaWtr
aSBLcm9nZXJ1cw0KPiA+Pj4+Pj4gPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+Ow0K
PiA+Pj4+Pj4gU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT47IENodW5m
ZW5nIFl1bg0KPiA+Pj4+Pj4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+OyBIYW5zIGRlIEdv
ZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsNCj4gPj4+Pj4+IEFuZHkgU2hldmNoZW5rbyA8YW5k
eS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IFZhbGVudGluIFNjaG5laWRlcg0KPiA+Pj4+Pj4gPHZh
bGVudGluLnNjaG5laWRlckBhcm0uY29tPjsgSmFjayBQaGFtIDxqYWNrcEBjb2RlYXVyb3JhLm9y
Zz47DQo+ID4+Pj4+PiBMaW51eCBVU0IgTGlzdCA8bGludXgtdXNiQHZnZXIua2VybmVsLm9yZz47
IG9wZW4gbGlzdDpPUEVODQo+ID4+Pj4+PiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBU
UkVFIEJJTkRJTkdTDQo+ID4+Pj4+PiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBQZXRl
ciBDaGVuIDxwZXRlci5jaGVuQG54cC5jb20+Ow0KPiA+Pj4+Pj4gVGhpbmggTmd1eWVuIDxUaGlu
aC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+Pj4+Pj4gU3ViamVjdDogUkU6IFtQQVRDSCB2NCAz
LzldIHVzYjogZHdjMzogSW5jcmVhc2UgdGltZW91dCBmb3INCj4gPj4+Pj4+IENtZEFjdCBjbGVh
cmVkIGJ5IGRldmljZSBjb250cm9sbGVyDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEhp
LA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEp1biBMaSA8anVuLmxpQG54cC5jb20+IHdyaXRlczoNCj4g
Pj4+Pj4+Pj4+PiBIaSBUaGluaCwgY291bGQgeW91IGNvbW1lbnQgdGhpcz8NCj4gPj4+Pj4+Pj4+
IFlvdSBvbmx5IG5lZWQgdG8gd2FrZSB1cCB0aGUgdXNiMiBwaHkgd2hlbiBpc3N1aW5nIHRoZSBj
b21tYW5kDQo+ID4+Pj4+Pj4+PiB3aGlsZSBydW5uaW5nIGluIGhpZ2hzcGVlZCBvciBiZWxvdy4g
SWYgeW91J3JlIHJ1bm5pbmcgaW4gU1MNCj4gPj4+Pj4+Pj4+IG9yIGhpZ2hlciwgaW50ZXJuYWxs
eSB0aGUgY29udHJvbGxlciBkb2VzIGl0IGZvciB5b3UgZm9yIHVzYjMgcGh5Lg0KPiA+Pj4+Pj4+
Pj4gSW4gSnVuJ3MgY2FzZSwgaXQgc2VlbXMgbGlrZSBpdCB0YWtlcyBsb25nZXIgZm9yIGhpcyBw
aHkgdG8gd2FrZSB1cC4NCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiBJTU8sIGluIHRoaXMgY2Fz
ZSwgSSB0aGluayBpdCdzIGZpbmUgdG8gaW5jcmVhc2UgdGhlIGNvbW1hbmQgdGltZW91dC4NCj4g
Pj4+Pj4+Pj4gSXMgdGhlcmUgYW4gdXBwZXIgbGltaXQgdG8gdGhpcz8gSXMgMzJrIGNsb2NrIHRo
ZSBzbG93ZXN0IHRoYXQNCj4gPj4+Pj4+Pj4gY2FuIGJlIGZlZCB0byB0aGUgUEhZIGFzIGEgc3Vz
cGVuZCBjbG9jaz8NCj4gPj4+Pj4+PiBZZXMsIDMySyBjbG9jayBpcyB0aGUgc2xvd2VzdCwgUGVy
IERXQzMgZG9jdW1lbnQgb24gUG93ZXIgRG93bg0KPiA+Pj4+Pj4+IFNjYWxlIChiaXRzIDMxOjE5
IG9mIEdDVEwpOg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gIlBvd2VyIERvd24gU2NhbGUgKFB3ckRu
U2NhbGUpDQo+ID4+Pj4+Pj4gVGhlIFVTQjMgc3VzcGVuZF9jbGsgaW5wdXQgcmVwbGFjZXMgcGlw
ZTNfcnhfcGNsayBhcyBhIGNsb2NrDQo+ID4+Pj4+Pj4gc291cmNlIHRvIGEgc21hbGwgcGFydCBv
ZiB0aGUgVVNCMyBjb250cm9sbGVyIHRoYXQgb3BlcmF0ZXMgd2hlbg0KPiA+Pj4+Pj4+IHRoZSBT
UyBQSFkgaXMgaW4gaXRzIGxvd2VzdCBwb3dlciAoUDMpIHN0YXRlLCBhbmQgdGhlcmVmb3JlIGRv
ZXMgbm90IHByb3ZpZGUNCj4gYSBjbG9jay4NCj4gPj4+Pj4+PiBUaGUgUG93ZXIgRG93biBTY2Fs
ZSBmaWVsZCBzcGVjaWZpZXMgaG93IG1hbnkgc3VzcGVuZF9jbGsNCj4gPj4+Pj4+PiBwZXJpb2Rz
IGZpdCBpbnRvIGEgMTYga0h6IGNsb2NrIHBlcmlvZC4gV2hlbiBwZXJmb3JtaW5nIHRoZQ0KPiA+
Pj4+Pj4+IGRpdmlzaW9uLCByb3VuZCB1cCB0aGUgcmVtYWluZGVyLg0KPiA+Pj4+Pj4+IEZvciBl
eGFtcGxlLCB3aGVuIHVzaW5nIGFuIDgtYml0LzE2LWJpdC8zMi1iaXQgUEhZIGFuZCAyNS1NSHoN
Cj4gPj4+Pj4+PiBTdXNwZW5kIGNsb2NrLCBQb3dlciBEb3duIFNjYWxlID0gMjUwMDAga0h6LzE2
IGtIeiA9IDEzJ2QxNTYzDQo+ID4+Pj4+Pj4gKHJvdW5kZXIgdXApDQo+ID4+Pj4+Pj4gTm90ZToN
Cj4gPj4+Pj4+PiAtIE1pbmltdW0gU3VzcGVuZCBjbG9jayBmcmVxdWVuY3kgaXMgMzIga0h6DQo+
ID4+Pj4+Pj4gLSBNYXhpbXVtIFN1c3BlbmQgY2xvY2sgZnJlcXVlbmN5IGlzIDEyNSBNSHoiDQo+
ID4+Pj4+PiBDb29sLCBub3cgZG8gd2UgaGF2ZSBhbiB1cHBlciBib3VuZCBmb3IgaG93IG1hbnkg
Y2xvY2sgY3ljbGVzIGl0DQo+ID4+Pj4+PiB0YWtlcyB0byB3YWtlIHVwIHRoZSBQSFk/DQo+ID4+
Pj4+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhpcyBlcCBjb21tYW5kIGRvZXMgbm90IHdha2UgdXAg
dGhlIFNTIFBIWSwNCj4gPj4+Pj4gdGhlIFNTIFBIWSBzdGlsbCBzdGF5cyBhdCBQMyB3aGVuIGV4
ZWN1dGUgdGhpcyBlcCBjb21tYW5kLiBUaGUNCj4gPj4+Pj4gdGltZSByZXF1aXJlZCBoZXJlIGlz
IHRvIHdhaXQgY29udHJvbGxlciBjb21wbGV0ZSBzb21ldGhpbmcgZm9yDQo+ID4+Pj4+IHRoaXMg
ZXAgY29tbWFuZCB3aXRoIDMySyBjbG9jay4NCj4gPj4+PiBTb3JyeSBJIG1hZGUgYSBtaXN0YWtl
LiBZb3UncmUgcmlnaHQuIEp1c3QgY2hlY2tlZCB3aXRoIG9uZSBvZiB0aGUNCj4gPj4+PiBSVEwg
ZW5naW5lZXJzLCBhbmQgaXQgZG9lc24ndCBuZWVkIHRvIHdha2UgdXAgdGhlIHBoeS4gSG93ZXZl
ciwgaWYNCj4gPj4+PiBpdCBpcyBlU1Mgc3BlZWQsIGl0IG1heSB0YWtlIGxvbmdlciB0aW1lIGFz
IHRoZSBjb21tYW5kIG1heSBiZQ0KPiA+Pj4+IGNvbXBsZXRpbmcgd2l0aCB0aGUgc3VzcGVuZCBj
bG9jay4NCj4gPj4+Pg0KPiA+Pj4gV2hhdCdzIHRoZSB2YWx1ZSBmb3IgR0NUTFs3OjZdPw0KPiA+
PiAyJ2IwMA0KPiA+Pg0KPiA+PiBUaGFua3MNCj4gPj4gTGkgSnVuDQo+ID4gKFNvcnJ5IGZvciB0
aGUgZGVsYXkgcmVwbHkpDQo+ID4NCj4gPiBJZiBpdCdzIDAsIHRoZW4gdGhlIHJhbSBjbG9jayBz
aG91bGQgYmUgdGhlIHNhbWUgYXMgdGhlIGJ1c19jbGssIHdoaWNoDQo+ID4gaXMgb2RkIHNpbmNl
IHlvdSBtZW50aW9uZWQgdGhhdCB0aGUgc3VzcGVuZF9jbGsgaXMgdXNlZCBpbnN0ZWFkIHdoaWxl
IGluIFAzLg0KPiANCj4gSnVzdCBjaGVja2VkIHdpdGggdGhlIFJUTCBlbmdpbmVlciwgZXZlbiBp
ZiBHQ1RMWzc6Nl0gaXMgc2V0IHRvIDAsIGludGVybmFsbHkgaXQNCj4gY2FuIHN0aWxsIHJ1biB3
aXRoIHN1c3BlbmQgY2xvY2sgZHVyaW5nIFAzLg0KDQpUaGFua3MgZm9yIHlvdXIgY2hlY2suDQo+
IA0KPiA+IEFueXdheSwgSSB3YXMgbG9va2luZyBmb3IgYSB3YXkgbWF5YmUgdG8gaW1wcm92ZSB0
aGUgc3BlZWQgZHVyaW5nDQo+ID4gaXNzdWluZyBhIGNvbW1hbmQuIE9uZSB3YXkgaXMgdG8gc2V0
IEdVU0IzUElQRUNUTFsxN109MCwgYW5kIGl0IHNob3VsZA0KPiA+IHdha2V1cCB0aGUgcGh5IGFu
eXRpbWUuIEkgdGhpbmsgRmVsaXBlIHN1Z2dlc3RlZCBpdC4gSXQncyBvZGQgdGhhdCBpdA0KPiA+
IGRvZXNuJ3Qgd29yayBmb3IgeW91LiBJIGRvbid0IGhhdmUgb3RoZXIgaWRlYXMgYmVzaWRlIGlu
Y3JlYXNpbmcgdGhlDQo+ID4gY29tbWFuZCB0aW1lb3V0Lg0KPiA+DQo+IA0KPiBJbiBhbnkgY2Fz
ZSwgaW5jcmVhc2luZyB0aGUgdGltZW91dCBzaG91bGQgYmUgZmluZSB3aXRoIG1lLiBJdCBtYXli
ZSBkaWZmaWN1bHQgdG8NCj4gZGV0ZXJtaW5lIHRoZSBtYXggdGltZW91dCBiYXNlIG9uIHRoZSBz
bG93ZXN0IGNsb2NrIHJhdGUgYW5kIG51bWJlciBvZiBjeWNsZXMuDQo+IERpZmZlcmVudCBjb250
cm9sbGVyIGFuZCBjb250cm9sbGVyIHZlcnNpb25zIGJlaGF2ZSBkaWZmZXJlbnRseSBhbmQgbWF5
IGhhdmUNCj4gZGlmZmVyZW50IG51bWJlciBvZiBjbG9jayBjeWNsZXMgdG8gY29tcGxldGUgYSBj
b21tYW5kLg0KPiANCj4gVGhlIFJUTCBlbmdpbmVlciByZWNvbW1lbmRlZCB0aW1lb3V0IHRvIGJl
IGF0IGxlYXN0IDFtcyAod2hpY2ggbWF5YmUgbW9yZSB0aGFuIHRoZQ0KPiBwb2xsaW5nIHJhdGUg
b2YgdGhpcyBwYXRjaCkuIEknbSBmaW5lIHdpdGggZWl0aGVyIHRoZSByYXRlIHByb3ZpZGVkIGJ5
IHRoaXMgdGVzdGVkDQo+IHBhdGNoIG9yIGhpZ2hlci4NCg0KT0ssIEkgd2lsbCBjaGFuZ2UgdGhl
IHRpbWVvdXQgdG8gYmUgMW1zIGlmIG5vIG9iamVjdCBmcm9tIEZlbGlwZS4NCg0KdGhhbmtzDQpM
aSBKdW4NCj4gDQo+IEJSLA0KPiBUaGluaA0K
