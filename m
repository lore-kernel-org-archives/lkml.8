Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050F6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D6E207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V0mbvndn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgESHjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:39:36 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:16757
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbgESHjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:39:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2Tkqaim0x1/IFM7hIQVb1geiefuI35uLNgY5yZN5FWZcd+5XeA4pfv2k1bajnbXmcXj5pfLPs3qcSkGkQj7PhcvAdsScKsZY95ietTAURFRxrz/D9++IYb0phA8+57w7/BBnImj6u4AdMO/PO/QWWmicoqURv1nkQ9yymeEl1s/TvdGHh7j/mZr9pXlN1I+b/03iPDc+1ppZjeeOe7Q7w/Mipimw0MrPJOZA+4Py0VwjgX95ycBXMaGZ//pJmH9/jYWxykcMgbEsMDLGvdPj6GMhJBM1WetiAtW0NLLxFCqUW9Mp3pUCFQrO8Z2HT+ED/iuN9qrfCEisEdbt4rs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ+aB928EeErUotT6mlMqinFPcxxgIJFKk1m+eIPJ0o=;
 b=CQFNVdG8548lzsd6C1Bf/z40O7/oG+etmx9GJtbyzQSeBvlr4soPtW3Ld4M+37O4QbjGn5RanuYoyUCV8CpVpRtO2YNmi3wHcid0zA6DvNflCcOi0IqFqyV7Z0kQEVCna9i3C/IDEgBbWx32zTukxrVuzgYI2Jgi1/zaAhV8JFKQO0M9gMC89BrcokrMwvrk519jJ6w8L/tcDlkIHf0quj1IPZzljcMl/RUkduLhG4PECOd803WYndk/Pu2WoZyJrVq9D6FTjfvX3kJYZS7VVfpiHbFHzguJyQrZwZiXlKT1Qa4VkuAPUm2iiwqxFj6NXTrXK4fyo2ynnXhoMR9vGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ+aB928EeErUotT6mlMqinFPcxxgIJFKk1m+eIPJ0o=;
 b=V0mbvndnBa7XWK1b87svrkxo1AETCI6xQWMtn4HmGpWny9wXBo+4C94Cskd1UOdGNT0QMCqjkRakHqNDIxgQA2kQ14/SVntU3MtKOINUtfw07ic8MnYJMje8Bl75xzDun/2CIh/ISKtxEjBxwS/wKZl5ducF1PL1JedSODM1Iyo=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 07:39:29 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 07:39:29 +0000
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
Thread-Index: AQHWJdlQZJAsekudzECWhic28QWur6io62yAgAAEAECAAPXLAIAAcdqAgAAhu3CAAC3agIADIntQgAE4rYCAAATjgIAACqpA
Date:   Tue, 19 May 2020 07:39:29 +0000
Message-ID: <VE1PR04MB65286728B9546B5FAA818A0A89B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
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
In-Reply-To: <e3b0ff51-70ab-7d16-2c7e-cacac7d97043@synopsys.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 435ef20b-5c30-4ff7-e296-08d7fbc7c3d8
x-ms-traffictypediagnostic: VE1PR04MB6589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB658938FB5071BC876F7A47A289B90@VE1PR04MB6589.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDM62GeuDMJxAZ17NitfP/IXgYtyBgZcbDIjpLFu+TJb57bQu/5MUzm/kMfboaCEZhnQ/Vqwj4Bke1JbepC6LQDyElJTTi5HEtYYOTJKXn8sNafFjM1eTyaIusiu7R74yQ5FVm6/9tMGcvrauEM86YhzhIbe/lyhBrPmYyOAW8T3rZsakvbmKgJKnzGTRfeZL4I5MLpO2atVSY6CQqfsnA7IFAkaffzqnWms383VNzl0BhpP9GKUJkU10yCBS2imDzndNsdx7dgJYY9hyQXPWdy9SU9ZnDSto2IRkSfEKQgcgPDYpWHGlfnKQarjqdLqpoqPT6yhzHKve/pCME/urBYI//qdoeV/VJj+cojmcXYYrYC4lvgk24jF48gTBPfW0dPAHYmu5hEaBkf9euZwf65cqyoIkCQHEuF/QTS05z/VIEzs/dM3ESA+koenxjgN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(5660300002)(4326008)(53546011)(6506007)(86362001)(7696005)(8936002)(7416002)(2906002)(44832011)(8676002)(26005)(186003)(478600001)(71200400001)(9686003)(76116006)(110136005)(54906003)(66946007)(66556008)(66476007)(64756008)(55016002)(33656002)(66446008)(52536014)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fFuqRf8K2GPBDAwxK1eg5LHm7ukewBQ1RdI11UP+dkQvOLyYih82TXqECjzwyLo2HBoCVnIk7Ytb90JGIal5TgyCxjz6aGc18JENZa17xbxKXmr12A4v9NSqYRsrNrErm1Mz8jDbmUSoVpCd8igyRdTjw70IyEn7FFp7Vd65pk6N8PeIpegM9cVzXsmTUms49gxw0nR+oYAB2SiPTL360FVV7XCT23r0MDn5lPViPxMgbEa2ph7F/y8CPP/saYOACjtsFS0B8nOOVDggqybgvYcPRSpJqTnoxAXbzRbUuVih1tkV8xO+x9uyHh0XXOvV35BhozoWMNwyDORMtwojynVsqQ1KvjkxEhI2WEgQzj8ZQANXJ6FyuUFezlUYhXyCgvNNRfc7mp8jC5m6R8qFULcE4Fc+ClqpGApR5sZtelOk8JA/gqVPN7ATiKCVNI7HqAozUAdth1Iv7ERzuANtrxbxMC5pvDNBuNrYLErGsuQfNqnSez3tPSSX2Ml+3PW+
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435ef20b-5c30-4ff7-e296-08d7fbc7c3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 07:39:29.7939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdj7r8O646rzyos9iRKZN6xrlHkr4M4YLIP8MTQdpd9CTgLAJs8DkaFI6RIdMx4z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaGluaCBOZ3V5ZW4g
PFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IFNlbnQ6IDIwMjDE6jXUwjE5yNUgMTQ6NDYN
Cj4gVG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+OyBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5l
bC5vcmc+OyBKdW4gTGkNCj4gPGxpanVuLmtlcm5lbEBnbWFpbC5jb20+DQo+IENjOiBKb2huIFN0
dWx0eiA8am9obi5zdHVsdHpAbGluYXJvLm9yZz47IGxrbWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBZdQ0KPiBDaGVuIDxjaGVueXU1NkBodWF3ZWkuY29tPjsgR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IFJvYg0KPiBIZXJyaW5nIDxyb2Jo
K2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgU2h1
RmFuIExlZQ0KPiA8c2h1ZmFuX2xlZUByaWNodGVrLmNvbT47IEhlaWtraSBLcm9nZXJ1cyA8aGVp
a2tpLmtyb2dlcnVzQGxpbnV4LmludGVsLmNvbT47DQo+IFN1enVraSBLIFBvdWxvc2UgPHN1enVr
aS5wb3Vsb3NlQGFybS5jb20+OyBDaHVuZmVuZyBZdW4NCj4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+OyBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsgQW5keSBTaGV2Y2hl
bmtvDQo+IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgVmFsZW50aW4gU2NobmVpZGVyIDx2
YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbT47DQo+IEphY2sgUGhhbSA8amFja3BAY29kZWF1cm9y
YS5vcmc+OyBMaW51eCBVU0IgTGlzdCA8bGludXgtdXNiQHZnZXIua2VybmVsLm9yZz47IG9wZW4N
Cj4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQgREVWSUNFIFRSRUUgQklORElOR1Mg
PGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsNCj4gUGV0ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBu
eHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvOV0gdXNiOiBkd2MzOiBJbmNyZWFz
ZSB0aW1lb3V0IGZvciBDbWRBY3QgY2xlYXJlZCBieSBkZXZpY2UNCj4gY29udHJvbGxlcg0KPiAN
Cj4gVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEp1biBMaSB3cm90ZToNCj4gPj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBGZWxpcGUgQmFsYmkgPGJhbGJpZkBnbWFp
bC5jb20+IE9uIEJlaGFsZiBPZiBGZWxpcGUgQmFsYmkNCj4gPj4+IFNlbnQ6IDIwMjDE6jXUwjE2
yNUgMTk6NTcNCj4gPj4+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPjsgVGhpbmggTmd1eWVu
DQo+ID4+PiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT47IEp1biBMaSA8bGlqdW4ua2VybmVs
QGdtYWlsLmNvbT4NCj4gPj4+IENjOiBKb2huIFN0dWx0eiA8am9obi5zdHVsdHpAbGluYXJvLm9y
Zz47IGxrbWwNCj4gPj4+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgWXUgQ2hlbiA8
Y2hlbnl1NTZAaHVhd2VpLmNvbT47IEdyZWcNCj4gPj4+IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPjsgUm9iIEhlcnJpbmcNCj4gPj4+IDxyb2JoK2R0QGtlcm5lbC5v
cmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgU2h1RmFuDQo+ID4+PiBM
ZWUgPHNodWZhbl9sZWVAcmljaHRlay5jb20+OyBIZWlra2kgS3JvZ2VydXMNCj4gPj4+IDxoZWlr
a2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPjsNCj4gPj4+IFN1enVraSBLIFBvdWxvc2UgPHN1
enVraS5wb3Vsb3NlQGFybS5jb20+OyBDaHVuZmVuZyBZdW4NCj4gPj4+IDxjaHVuZmVuZy55dW5A
bWVkaWF0ZWsuY29tPjsgSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT47DQo+ID4+
PiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+OyBWYWxlbnRpbiBT
Y2huZWlkZXINCj4gPj4+IDx2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbT47IEphY2sgUGhhbSA8
amFja3BAY29kZWF1cm9yYS5vcmc+Ow0KPiA+Pj4gTGludXggVVNCIExpc3QgPGxpbnV4LXVzYkB2
Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRQ0KPiA+Pj4gQU5EIEZMQVRU
RU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0K
PiA+Pj4gUGV0ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29tPjsgVGhpbmggTmd1eWVuDQo+ID4+
PiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gPj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0gg
djQgMy85XSB1c2I6IGR3YzM6IEluY3JlYXNlIHRpbWVvdXQgZm9yIENtZEFjdA0KPiA+Pj4gY2xl
YXJlZCBieSBkZXZpY2UgY29udHJvbGxlcg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBIaSwNCj4gPj4+
DQo+ID4+PiBKdW4gTGkgPGp1bi5saUBueHAuY29tPiB3cml0ZXM6DQo+ID4+Pj4+Pj4gSGkgVGhp
bmgsIGNvdWxkIHlvdSBjb21tZW50IHRoaXM/DQo+ID4+Pj4+PiBZb3Ugb25seSBuZWVkIHRvIHdh
a2UgdXAgdGhlIHVzYjIgcGh5IHdoZW4gaXNzdWluZyB0aGUgY29tbWFuZA0KPiA+Pj4+Pj4gd2hp
bGUgcnVubmluZyBpbiBoaWdoc3BlZWQgb3IgYmVsb3cuIElmIHlvdSdyZSBydW5uaW5nIGluIFNT
IG9yDQo+ID4+Pj4+PiBoaWdoZXIsIGludGVybmFsbHkgdGhlIGNvbnRyb2xsZXIgZG9lcyBpdCBm
b3IgeW91IGZvciB1c2IzIHBoeS4NCj4gPj4+Pj4+IEluIEp1bidzIGNhc2UsIGl0IHNlZW1zIGxp
a2UgaXQgdGFrZXMgbG9uZ2VyIGZvciBoaXMgcGh5IHRvIHdha2UgdXAuDQo+ID4+Pj4+Pg0KPiA+
Pj4+Pj4gSU1PLCBpbiB0aGlzIGNhc2UsIEkgdGhpbmsgaXQncyBmaW5lIHRvIGluY3JlYXNlIHRo
ZSBjb21tYW5kIHRpbWVvdXQuDQo+ID4+Pj4+IElzIHRoZXJlIGFuIHVwcGVyIGxpbWl0IHRvIHRo
aXM/IElzIDMyayBjbG9jayB0aGUgc2xvd2VzdCB0aGF0IGNhbg0KPiA+Pj4+PiBiZSBmZWQgdG8g
dGhlIFBIWSBhcyBhIHN1c3BlbmQgY2xvY2s/DQo+ID4+Pj4gWWVzLCAzMksgY2xvY2sgaXMgdGhl
IHNsb3dlc3QsIFBlciBEV0MzIGRvY3VtZW50IG9uIFBvd2VyIERvd24NCj4gPj4+PiBTY2FsZSAo
Yml0cyAzMToxOSBvZiBHQ1RMKToNCj4gPj4+Pg0KPiA+Pj4+ICJQb3dlciBEb3duIFNjYWxlIChQ
d3JEblNjYWxlKQ0KPiA+Pj4+IFRoZSBVU0IzIHN1c3BlbmRfY2xrIGlucHV0IHJlcGxhY2VzIHBp
cGUzX3J4X3BjbGsgYXMgYSBjbG9jayBzb3VyY2UNCj4gPj4+PiB0byBhIHNtYWxsIHBhcnQgb2Yg
dGhlIFVTQjMgY29udHJvbGxlciB0aGF0IG9wZXJhdGVzIHdoZW4gdGhlIFNTDQo+ID4+Pj4gUEhZ
IGlzIGluIGl0cyBsb3dlc3QgcG93ZXIgKFAzKSBzdGF0ZSwgYW5kIHRoZXJlZm9yZSBkb2VzIG5v
dCBwcm92aWRlIGEgY2xvY2suDQo+ID4+Pj4gVGhlIFBvd2VyIERvd24gU2NhbGUgZmllbGQgc3Bl
Y2lmaWVzIGhvdyBtYW55IHN1c3BlbmRfY2xrIHBlcmlvZHMNCj4gPj4+PiBmaXQgaW50byBhIDE2
IGtIeiBjbG9jayBwZXJpb2QuIFdoZW4gcGVyZm9ybWluZyB0aGUgZGl2aXNpb24sIHJvdW5kDQo+
ID4+Pj4gdXAgdGhlIHJlbWFpbmRlci4NCj4gPj4+PiBGb3IgZXhhbXBsZSwgd2hlbiB1c2luZyBh
biA4LWJpdC8xNi1iaXQvMzItYml0IFBIWSBhbmQgMjUtTUh6DQo+ID4+Pj4gU3VzcGVuZCBjbG9j
aywgUG93ZXIgRG93biBTY2FsZSA9IDI1MDAwIGtIei8xNiBrSHogPSAxMydkMTU2Mw0KPiA+Pj4+
IChyb3VuZGVyIHVwKQ0KPiA+Pj4+IE5vdGU6DQo+ID4+Pj4gLSBNaW5pbXVtIFN1c3BlbmQgY2xv
Y2sgZnJlcXVlbmN5IGlzIDMyIGtIeg0KPiA+Pj4+IC0gTWF4aW11bSBTdXNwZW5kIGNsb2NrIGZy
ZXF1ZW5jeSBpcyAxMjUgTUh6Ig0KPiA+Pj4gQ29vbCwgbm93IGRvIHdlIGhhdmUgYW4gdXBwZXIg
Ym91bmQgZm9yIGhvdyBtYW55IGNsb2NrIGN5Y2xlcyBpdA0KPiA+Pj4gdGFrZXMgdG8gd2FrZSB1
cCB0aGUgUEhZPw0KPiA+PiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoaXMgZXAgY29tbWFuZCBkb2Vz
IG5vdCB3YWtlIHVwIHRoZSBTUyBQSFksIHRoZQ0KPiA+PiBTUyBQSFkgc3RpbGwgc3RheXMgYXQg
UDMgd2hlbiBleGVjdXRlIHRoaXMgZXAgY29tbWFuZC4gVGhlIHRpbWUNCj4gPj4gcmVxdWlyZWQg
aGVyZSBpcyB0byB3YWl0IGNvbnRyb2xsZXIgY29tcGxldGUgc29tZXRoaW5nIGZvciB0aGlzIGVw
DQo+ID4+IGNvbW1hbmQgd2l0aCAzMksgY2xvY2suDQo+ID4gU29ycnkgSSBtYWRlIGEgbWlzdGFr
ZS4gWW91J3JlIHJpZ2h0LiBKdXN0IGNoZWNrZWQgd2l0aCBvbmUgb2YgdGhlIFJUTA0KPiA+IGVu
Z2luZWVycywgYW5kIGl0IGRvZXNuJ3QgbmVlZCB0byB3YWtlIHVwIHRoZSBwaHkuIEhvd2V2ZXIs
IGlmIGl0IGlzDQo+ID4gZVNTIHNwZWVkLCBpdCBtYXkgdGFrZSBsb25nZXIgdGltZSBhcyB0aGUg
Y29tbWFuZCBtYXkgYmUgY29tcGxldGluZw0KPiA+IHdpdGggdGhlIHN1c3BlbmQgY2xvY2suDQo+
ID4NCj4gDQo+IFdoYXQncyB0aGUgdmFsdWUgZm9yIEdDVExbNzo2XT8NCg0KMidiMDANCg0KVGhh
bmtzDQpMaSBKdW4NCj4gDQo+IEJSLA0KPiBUaGluaA0K
