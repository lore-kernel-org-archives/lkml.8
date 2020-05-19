Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2002A20708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DjeBemur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgESCYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:24:11 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:22474
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727917AbgESCYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4URs6nwc2Kwq0E5zi6COOshjIiAwDD+/bSwiyJVcckZf3/umZl5mq0MBx2hQXji6lMVUSj15uD9dLI2sG6JSlQRY2tSXTKN3NlSUlGTCxly/v1NIBudqTLpMfYu4xoFF0CfP9T6YG11KSsAYe3Qhk/zkoY5l2gE7fCCwlCNoSPSTuDhaAx3VQK4LStKADoIjWuys8EBbNUFViQjcFJGvfIpJ1Hg4qBm6W1o6oZuA1DdpfF5ZOqmkBgHey/1FG21+7H/9By8KTsoJfxKQm+S5/s0g/dVTytDNImxnoxCN/GMoDzpVsItYzTf62ghIIW2tZtWEJ2yoz2tQZWcjG2NdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFzRbQFEEsgpRSNo8H/DVCOfnI5ViCx+X/fBSHHCgz4=;
 b=NlOuRLcy36gZW/XIyTnsvkc12SVKFJDxSu0ipRqREt+qpdmgluCgaG8rh/R7i7bNN7oN8lP2MDuS+5FqcnE5ZS74XwGDiG/4aEhOtcJFufUUeEZfAOzS8ZZb1ejrt7ARtayEFGF7c3Lo6FQdtfLdADzBtSPbmTGw3RL7h25q4+l+fGMAUKl6OegX1UsXxbOx98Hob2gB+OVGr23ewYmG/4sahHBCOLeQId8ZW6zAO5pDgH8dSIPZUSzoTuXzymPrK7CexF8hK/4LrPO1LJahKjLJC3kWbqqbu/hnt57ObQNwTxKTXvG7z/o95RJtfgwimyANaJae5JuD26kWYhlvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFzRbQFEEsgpRSNo8H/DVCOfnI5ViCx+X/fBSHHCgz4=;
 b=DjeBemurnfiAJS02F67iLWzxsOeXa6dOI9X4T++p2oxAookX5pWl/fUwgZc+Kf7BeX4AOOj6j2WoTNQILPJY58xpGWWd/5WF6mc2WvCmUzdacp4hmfOuyQLWl76Fr7VCx1YyZbVMemsQ3jXHyMG913hHEKBEeQlyA5UqegKTC3s=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VE1PR04MB6685.eurprd04.prod.outlook.com (2603:10a6:803:120::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 02:24:06 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 02:24:06 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: RE: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Topic: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Index: AQHWJdlQZJAsekudzECWhic28QWur6io62yAgAAEAECAAPXLAIAAcdqAgAAhu3CAAC3agIADIntQ
Date:   Tue, 19 May 2020 02:24:06 +0000
Message-ID: <VE1PR04MB6528A50EA40BF40E4B09793789B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
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
In-Reply-To: <87d074xfbq.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53917b7d-f096-4b7a-7daf-08d7fb9bb498
x-ms-traffictypediagnostic: VE1PR04MB6685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6685D4238EE40CEEA9F157FC89B90@VE1PR04MB6685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TDPVaNohmIGxgpaeGzcEKHgWM/NuPOMg7xSHNgyH9e91XIMliLABYacQvkNRlZf977AYYSeZUMkBWY73mF8l6zKNMkAfOxJVZZWAzHZjyCoY4U16S7xPFslO5AKpBmvIqdsVPZWQbMvpNA6B3F54MCBR8O1itdl6xGTtgE4Pjzy8+CMrvTy9ZukMIBGa5NvbR5mnXOQBvcXT07jR6LRCYQL5PyX0COtg5U+41Ihvfj6lKlGMlBxSJuhWcdJDwj6sB0b82/IM/22+QBmbc7hr1Dcu+I7sBDuFpsNvpYosgvB6/oSZDtwMI8PL30/9quxHzq+TOZZ2rfAIrMCmZmMmrhDZjkduN1mHJDdukfCAUTUwmtRB3a9Me06rtzI3ZOQXfdvU6RxD96DqYsdOEWkOVw69OkvThERlbazrGr7RUG8YLRRQhW22K5POLSrTScBx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(186003)(6506007)(478600001)(9686003)(53546011)(110136005)(64756008)(66446008)(52536014)(44832011)(66556008)(26005)(66476007)(8936002)(33656002)(8676002)(86362001)(55016002)(66946007)(5660300002)(54906003)(4326008)(7696005)(2906002)(316002)(71200400001)(7416002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: X99rSXjyxNTpKRbBVeK8wnMuBIYPKgwpKUTaZmAVaberYdL6L8yg3O0wr9WJlXJuUb8mnSiywFNx0nBDkXGjTHlb7LwNPvPefMSPDDW7Xf8v34b8OzbkJy4NzyPH4+ffTRpnalUBti9JClIl+Cn6PpEHlcb/tocshkXM/C71sQnEKiOBrzQjMokEIb/Hhruk/od5nJfI25/zOcMGqkMiSLmzocRicmhH3fTic4X9p1hmd6hWu2/q+lPjxfa8vHk4XyAWBwgRFiaY1MyBv6V1TgSxr6gCy72PGuY7PU1vNcHBON6Ecf2nQMLQvycGsORR9agNGBFXxmWMRJQ/Yv0V0u8f1PVpm/x5Rm3WynfOWPEL/pja/Uqurt5JkbvzDXtpQct8DDUy4x0ATtJ08dSIMAhGCzoZ++yfIxgpdX0J3IuAkjnzeBkPE7NHFMRQNEYL8ei2SwkLCm/MMT6t0d2ssVOuT3X4pvfJpbLpEUDgExI9VVe2vBAOv3eT4ZhLVVl2
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53917b7d-f096-4b7a-7daf-08d7fb9bb498
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 02:24:06.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8LcDzU0Gd4T+zXEGdggLUpvPE3rlxy88QPnK/N1gIhWaYBfAANZhGjdsbt9k0k8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmVsaXBlIEJhbGJpIDxi
YWxiaWZAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgRmVsaXBlIEJhbGJpDQo+IFNlbnQ6IDIwMjDE
6jXUwjE2yNUgMTk6NTcNCj4gVG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+OyBUaGluaCBOZ3V5
ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+OyBKdW4gTGkNCj4gPGxpanVuLmtlcm5lbEBn
bWFpbC5jb20+DQo+IENjOiBKb2huIFN0dWx0eiA8am9obi5zdHVsdHpAbGluYXJvLm9yZz47IGxr
bWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBZdQ0KPiBDaGVuIDxjaGVueXU1NkBo
dWF3ZWkuY29tPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz47IFJvYg0KPiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1h
cmsucnV0bGFuZEBhcm0uY29tPjsgU2h1RmFuIExlZQ0KPiA8c2h1ZmFuX2xlZUByaWNodGVrLmNv
bT47IEhlaWtraSBLcm9nZXJ1cyA8aGVpa2tpLmtyb2dlcnVzQGxpbnV4LmludGVsLmNvbT47DQo+
IFN1enVraSBLIFBvdWxvc2UgPHN1enVraS5wb3Vsb3NlQGFybS5jb20+OyBDaHVuZmVuZyBZdW4N
Cj4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+OyBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUBy
ZWRoYXQuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29t
PjsgVmFsZW50aW4gU2NobmVpZGVyIDx2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbT47DQo+IEph
Y2sgUGhhbSA8amFja3BAY29kZWF1cm9yYS5vcmc+OyBMaW51eCBVU0IgTGlzdCA8bGludXgtdXNi
QHZnZXIua2VybmVsLm9yZz47IG9wZW4NCj4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVO
RUQgREVWSUNFIFRSRUUgQklORElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsNCj4g
UGV0ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29tPjsgVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5
ZW5Ac3lub3BzeXMuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY0IDMvOV0gdXNiOiBkd2Mz
OiBJbmNyZWFzZSB0aW1lb3V0IGZvciBDbWRBY3QgY2xlYXJlZCBieSBkZXZpY2UNCj4gY29udHJv
bGxlcg0KPiANCj4gDQo+IEhpLA0KPiANCj4gSnVuIExpIDxqdW4ubGlAbnhwLmNvbT4gd3JpdGVz
Og0KPiA+PiA+PiBIaSBUaGluaCwgY291bGQgeW91IGNvbW1lbnQgdGhpcz8NCj4gPj4gPg0KPiA+
PiA+IFlvdSBvbmx5IG5lZWQgdG8gd2FrZSB1cCB0aGUgdXNiMiBwaHkgd2hlbiBpc3N1aW5nIHRo
ZSBjb21tYW5kDQo+ID4+ID4gd2hpbGUgcnVubmluZyBpbiBoaWdoc3BlZWQgb3IgYmVsb3cuIElm
IHlvdSdyZSBydW5uaW5nIGluIFNTIG9yDQo+ID4+ID4gaGlnaGVyLCBpbnRlcm5hbGx5IHRoZSBj
b250cm9sbGVyIGRvZXMgaXQgZm9yIHlvdSBmb3IgdXNiMyBwaHkuIEluDQo+ID4+ID4gSnVuJ3Mg
Y2FzZSwgaXQgc2VlbXMgbGlrZSBpdCB0YWtlcyBsb25nZXIgZm9yIGhpcyBwaHkgdG8gd2FrZSB1
cC4NCj4gPj4gPg0KPiA+PiA+IElNTywgaW4gdGhpcyBjYXNlLCBJIHRoaW5rIGl0J3MgZmluZSB0
byBpbmNyZWFzZSB0aGUgY29tbWFuZCB0aW1lb3V0Lg0KPiA+Pg0KPiA+PiBJcyB0aGVyZSBhbiB1
cHBlciBsaW1pdCB0byB0aGlzPyBJcyAzMmsgY2xvY2sgdGhlIHNsb3dlc3QgdGhhdCBjYW4gYmUN
Cj4gPj4gZmVkIHRvIHRoZSBQSFkgYXMgYSBzdXNwZW5kIGNsb2NrPw0KPiA+DQo+ID4gWWVzLCAz
MksgY2xvY2sgaXMgdGhlIHNsb3dlc3QsIFBlciBEV0MzIGRvY3VtZW50IG9uIFBvd2VyIERvd24g
U2NhbGUNCj4gPiAoYml0cyAzMToxOSBvZiBHQ1RMKToNCj4gPg0KPiA+ICJQb3dlciBEb3duIFNj
YWxlIChQd3JEblNjYWxlKQ0KPiA+IFRoZSBVU0IzIHN1c3BlbmRfY2xrIGlucHV0IHJlcGxhY2Vz
IHBpcGUzX3J4X3BjbGsgYXMgYSBjbG9jayBzb3VyY2UgdG8NCj4gPiBhIHNtYWxsIHBhcnQgb2Yg
dGhlIFVTQjMgY29udHJvbGxlciB0aGF0IG9wZXJhdGVzIHdoZW4gdGhlIFNTIFBIWSBpcw0KPiA+
IGluIGl0cyBsb3dlc3QgcG93ZXIgKFAzKSBzdGF0ZSwgYW5kIHRoZXJlZm9yZSBkb2VzIG5vdCBw
cm92aWRlIGEgY2xvY2suDQo+ID4gVGhlIFBvd2VyIERvd24gU2NhbGUgZmllbGQgc3BlY2lmaWVz
IGhvdyBtYW55IHN1c3BlbmRfY2xrIHBlcmlvZHMgZml0DQo+ID4gaW50byBhIDE2IGtIeiBjbG9j
ayBwZXJpb2QuIFdoZW4gcGVyZm9ybWluZyB0aGUgZGl2aXNpb24sIHJvdW5kIHVwIHRoZQ0KPiA+
IHJlbWFpbmRlci4NCj4gPiBGb3IgZXhhbXBsZSwgd2hlbiB1c2luZyBhbiA4LWJpdC8xNi1iaXQv
MzItYml0IFBIWSBhbmQgMjUtTUh6IFN1c3BlbmQNCj4gPiBjbG9jaywgUG93ZXIgRG93biBTY2Fs
ZSA9IDI1MDAwIGtIei8xNiBrSHogPSAxMydkMTU2MyAocm91bmRlciB1cCkNCj4gPiBOb3RlOg0K
PiA+IC0gTWluaW11bSBTdXNwZW5kIGNsb2NrIGZyZXF1ZW5jeSBpcyAzMiBrSHoNCj4gPiAtIE1h
eGltdW0gU3VzcGVuZCBjbG9jayBmcmVxdWVuY3kgaXMgMTI1IE1IeiINCj4gDQo+IENvb2wsIG5v
dyBkbyB3ZSBoYXZlIGFuIHVwcGVyIGJvdW5kIGZvciBob3cgbWFueSBjbG9jayBjeWNsZXMgaXQg
dGFrZXMgdG8gd2FrZSB1cA0KPiB0aGUgUEhZPyANCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhpcyBl
cCBjb21tYW5kIGRvZXMgbm90IHdha2UgdXAgdGhlIFNTIFBIWSwNCnRoZSBTUyBQSFkgc3RpbGwg
c3RheXMgYXQgUDMgd2hlbiBleGVjdXRlIHRoaXMgZXAgY29tbWFuZC4gVGhlIHRpbWUNCnJlcXVp
cmVkIGhlcmUgaXMgdG8gd2FpdCBjb250cm9sbGVyIGNvbXBsZXRlIHNvbWV0aGluZyBmb3IgdGhp
cyBlcA0KY29tbWFuZCB3aXRoIDMySyBjbG9jay4NCg0KPiBUaGVuIHdlIGNhbiBqdXN0IHNldCB0
aGUgdGltZSB0byB0aGF0IHVwcGVyIGJvdW5kLg0KUGVyIG15IHRlc3Qgd2l0aCB0cmFjZSwgdGhl
IHRpbWUgaXMgYWJvdXQgNDAwdXMofjEzIGN5Y2xlcykuDQoNClRoYW5rcw0KTGkgSnVuDQo+IA0K
PiAtLQ0KPiBiYWxiaQ0K
