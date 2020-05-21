Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA24F20759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jg5L8j4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgEUHsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:48:02 -0400
Received: from mail-db8eur05on2079.outbound.protection.outlook.com ([40.107.20.79]:55296
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728354AbgEUHsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SL70matYZWPPpEbMkRSd4dTAqz5XDS0IheqgMCe7lnUklpc0bx8V5SpJodd86lVldUdRSP4JDdBjEB6iU+KX8kHzOvGQ6jqSx6fYOD922VYg9wIASK+ssFW9PGK3o5AdXMypSM7UnEe6iWhCmwzZWRjZG40QfCy7/21j3gK0oqRvy4Tk4+gMYsUooTkmMcNUSt4Grjv3fHzj6N9mKMDdZLGOwBuIgy0CIhfKe2JG9q5NYF+Zs29eOkD2jLkThWM0prnsLwOjaeJedXD1wSA2DL3PpVz75sV7iju7gN25q2jPtKsqUEFXO42QQHKb/LM3GDSmpo/jUmj/z/ZXeRf7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWMcT6pXGUt3oLCipTO74jXoAwmEut44O68N7zvuWjU=;
 b=AbhZQKZi+Cdlsb7XroLaZZvYTD9M0sCMm4h7D+4xprWlZxJU8tILULilHisxS43iP6j3SulMjP9vEfxncAS1IkfVt5qy45dYQX3smeV+n82PuwGIxoti/C/K1u3bOrEH8DkGWQ81QGSVrC8QJs8X1/JR4gKxLxArg7Zyh8vluA6GasT0nSaAJjg5K+lI+vcZm3UkaGWXOAd9ePIU0+v8zLULHH//F2Fu07YmTumAm+1rFR4Ig/4GpyDSVy4KPTeMIUhcTAJf5F4ZR5OnIpYfPruj9shpc5KDpnlFBbkh7t73yt/GCLBOfzICI/TgmgpfqDd+tmXH85FuMMMhgxwvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWMcT6pXGUt3oLCipTO74jXoAwmEut44O68N7zvuWjU=;
 b=jg5L8j4aC8dz5/ax0n6a+uuEihItHtAqMvbPgDwEVCbwSGZlG2f3tXN8u5yPBviQfPVLr1QrHsflLzfixXUwI16jwuGlrXclzCLI34Zx+pz1QNFT9Et4VQi3wm8rAzfleBBDMWSJy9MqMj6L0Z0pW74WJVM7rRM3t/8Vb/3lyjA=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VE1PR04MB6543.eurprd04.prod.outlook.com (2603:10a6:803:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Thu, 21 May
 2020 07:47:58 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03%7]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 07:47:57 +0000
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
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: RE: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Topic: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Index: AQHWJdlQZJAsekudzECWhic28QWur6io62yAgAAEAECAAPXLAIAAcdqAgAAhu3CAAC3agIADIntQgAE4rYCAAATjgIAACqpAgAK7RQCAAA2agIAASgUAgAAAkICAABP2UA==
Date:   Thu, 21 May 2020 07:47:57 +0000
Message-ID: <VE1PR04MB6528AC4D33F7F921B65AA1B889B70@VE1PR04MB6528.eurprd04.prod.outlook.com>
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
 <87v9kpx0zh.fsf@kernel.org> <87r1vdx0w4.fsf@kernel.org>
In-Reply-To: <87r1vdx0w4.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 031fceac-6a89-4133-ac7e-08d7fd5b4782
x-ms-traffictypediagnostic: VE1PR04MB6543:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6543F25890D218B41FFEAFF089B70@VE1PR04MB6543.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hGBF5z8RXBc8p1bxVeEXYTQCxzW42EqGWLRPc46nHul4pphceESbiCXClV2/VHzSERtRq4BjPmPOfl6yTJ2xT/F45XRJQqE4ZWd2nObLlO3YdB12mxYNZmpczzaH3EnGQpPUF7ffO7cOlOGRQQEALP9UOZ9nYA78TlDaAfjZ/Wvq9gdoOFefFqEtKn/SNOqpHQTlJ/PJ5fjC9UuLBGZiKigdt1Q6x0UNU9aopz4X0IiBNAo4CiJexE6gGRfklTETWUaQgy9WPcaKtwts6hnGsju5eyebokPfkFhZ5LIXK0RQWNoWt9aIzWye4qYN4DsR0bWYT5ekgjFfO0auVPq5FNqprImPXMZtFXqEYNQ9+VX0Q13TKOyVtO9deCr+JugZSCm2Yn4BxguuIxVzul4b7NHmeIzmirThSqIIU/H3xqVVdQTYErxE1DEP2bbldjJO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(26005)(55016002)(8676002)(8936002)(7696005)(9686003)(44832011)(66946007)(7416002)(86362001)(66556008)(64756008)(76116006)(52536014)(66476007)(33656002)(316002)(5660300002)(66446008)(478600001)(6506007)(54906003)(2906002)(71200400001)(4326008)(53546011)(110136005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 13QkfAer4YJgdJkwLk3DzpuGTKbiXven1pREBu5nAjZKpAvT3QbWydqA7oqlIbWuw4Yw5227RphA06fPH3lUf8U6YuBzfhnsg/ySWOx1B77jmitsbJnePNtBSAZOdNlx3MW3sC254LXNsmv2xufbONjbmxrhFUBdcKUrgv66pvjz3xJt944guAzphzTEx7NQy3c09rIQ/ibHzlV17Xh+EtucADerIcsj5jiu26gJPVqeOi3U7pOV3ZNoEtETZMjetlNXhdWIjYgehUD+8KppxOAx2UM1QQ2MGfihZaNuVasAWjVwzpSPU2DanfM30isb1MZ8KyZw9tMtWdfYFAM4gDjZycEq875Cviwjhj0wple42S4Epk6D/AzSGBFP+wJJl9h7B0CeEDEzr06GmfUltUAcfg19mJbZmprtRaE8tDI5597X+qcerxBvug2YkI4+nidIa1UAEbwN+azT7DaWctsduoIvyIVgVOd78S5fRMyFXluiI2wVcTZ9ONSk+kk6
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031fceac-6a89-4133-ac7e-08d7fd5b4782
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 07:47:57.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6OO2g4SMdd+5NQ2cRdp64PDueChNW5tKvWpkyaSMCnMWifAgn7C1JDdsG+rQbUE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVsaXBlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZlbGlw
ZSBCYWxiaSA8YmFsYmlmQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEZlbGlwZSBCYWxiaQ0KPiBT
ZW50OiAyMDIwxOo11MIyMcjVIDE0OjIzDQo+IFRvOiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+OyBKdW4gTGkgPGp1bi5saUBueHAuY29tPjsgSnVuIExpDQo+IDxsaWp1
bi5rZXJuZWxAZ21haWwuY29tPg0KPiBDYzogSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFy
by5vcmc+OyBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgWXUNCj4gQ2hlbiA8
Y2hlbnl1NTZAaHVhd2VpLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+OyBSb2INCj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBS
dXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IFNodUZhbiBMZWUNCj4gPHNodWZhbl9sZWVA
cmljaHRlay5jb20+OyBIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRl
bC5jb20+Ow0KPiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPjsgQ2h1
bmZlbmcgWXVuDQo+IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPjsgSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5keS5zaGV2Y2hlbmtv
QGdtYWlsLmNvbT47IFZhbGVudGluIFNjaG5laWRlciA8dmFsZW50aW4uc2NobmVpZGVyQGFybS5j
b20+Ow0KPiBKYWNrIFBoYW0gPGphY2twQGNvZGVhdXJvcmEub3JnPjsgTGludXggVVNCIExpc3Qg
PGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuDQo+IGxpc3Q6T1BFTiBGSVJNV0FSRSBB
TkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZz47DQo+IFBldGVyIENoZW4gPHBldGVyLmNoZW5AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NCAzLzldIHVzYjogZHdjMzogSW5jcmVhc2UgdGltZW91dCBmb3IgQ21kQWN0IGNs
ZWFyZWQgYnkgZGV2aWNlDQo+IGNvbnRyb2xsZXINCj4gDQo+IA0KPiBIaSBKdW4sDQo+IA0KPiBG
ZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+IHdyaXRlczoNCj4gPj4gSW4gYW55IGNhc2Us
IGluY3JlYXNpbmcgdGhlIHRpbWVvdXQgc2hvdWxkIGJlIGZpbmUgd2l0aCBtZS4gSXQgbWF5YmUN
Cj4gPj4gZGlmZmljdWx0IHRvIGRldGVybWluZSB0aGUgbWF4IHRpbWVvdXQgYmFzZSBvbiB0aGUg
c2xvd2VzdCBjbG9jayByYXRlDQo+ID4+IGFuZCBudW1iZXIgb2YgY3ljbGVzLiBEaWZmZXJlbnQg
Y29udHJvbGxlciBhbmQgY29udHJvbGxlciB2ZXJzaW9ucw0KPiA+PiBiZWhhdmUgZGlmZmVyZW50
bHkgYW5kIG1heSBoYXZlIGRpZmZlcmVudCBudW1iZXIgb2YgY2xvY2sgY3ljbGVzIHRvDQo+ID4+
IGNvbXBsZXRlIGEgY29tbWFuZC4NCj4gPj4NCj4gPj4gVGhlIFJUTCBlbmdpbmVlciByZWNvbW1l
bmRlZCB0aW1lb3V0IHRvIGJlIGF0IGxlYXN0IDFtcyAod2hpY2ggbWF5YmUNCj4gPj4gbW9yZSB0
aGFuIHRoZSBwb2xsaW5nIHJhdGUgb2YgdGhpcyBwYXRjaCkuIEknbSBmaW5lIHdpdGggZWl0aGVy
IHRoZQ0KPiA+PiByYXRlIHByb3ZpZGVkIGJ5IHRoaXMgdGVzdGVkIHBhdGNoIG9yIGhpZ2hlci4N
Cj4gPg0KPiA+IEEgd2hvbGUgbXMgd2FpdGluZyBmb3IgYSBjb21tYW5kIHRvIGNvbXBsZXRlPyBX
b3csIHRoYXQncyBhIGxvdCBvZg0KPiA+IHRpbWUgYmxvY2tpbmcgdGhlIENQVS4gSXQgbG9va3Mg
bGlrZSwgcGVyaGFwcywgd2Ugc2hvdWxkIG1vdmUgdG8NCj4gPiBjb21tYW5kIGNvbXBsZXRpb24g
aW50ZXJydXB0cy4gVGhlIGRpZmZpY3VsdHkgaGVyZSBpcyB0aGF0IHdlIGlzc3VlDQo+ID4gY29t
bWFuZHMgZnJvbSB3aXRoaW4gdGhlIGludGVycnVwdCBoYW5kbGVyIGFuZCwgYXMgc3VjaCwgY2Fu
J3QNCj4gPiB3YWl0X2Zvcl9jb21wbGV0aW9uKCkuDQo+ID4NCj4gPiBNZWFud2hpbGUsIHdlIHdp
bGwgdGFrZSB0aGUgdGltZW91dCBpbmNyZWFzZSBJIGd1ZXNzLCBvdGhlcndpc2UgTlhQDQo+ID4g
d29uJ3QgaGF2ZSBhIHdvcmtpbmcgc2V0dXAuDQo+IA0KPiBwYXRjaCAxIGluIHRoaXMgc2VyaWVz
IGRvZXNuJ3QgYXBwbHkgdG8gdGVzdGluZy9uZXh0LiBDYXJlIHRvIHJlYmFzZSBhbmQgcmVzZW5k
Pw0KDQpTdXJlLCBJIHdpbGwgcmViYXNlIGFuZCByZXNlbmQgdGhpcyBwYXRjaCB3aXRoIHRpbWVv
dXQgbG9vcCA1MDAwLg0KDQpUaGFua3MNCkxpIEp1bg0KPiANCj4gVGhhbmsgeW91DQo+IA0KPiAt
LQ0KPiBiYWxiaQ0K
