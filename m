Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29745C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0039120706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=osportal.onmicrosoft.com header.i=@osportal.onmicrosoft.com header.b="Bej8Rv3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgHYQl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:41:57 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:3808
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbgHYQly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:41:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHkb1MYgpFiK/wdp/zrdfiT2pKz8oj3AWINYCfJk1Rqu9J5Xq6bW+ng68BWoqnWGlEa8cTUt6rO/zNbVJRlzkmM4yp3Caz8PuYsGLGPMmAN37mMSVGIzJMZJz4UDRTQv+BIzEM9x7kPfSCnVkJOSCsvyVjhOKMZiRfvp5zYXkpVGSDBIa2yJ+3qGvxE7y2nmgjJEvi0tIo4Ym9ClYjt2Z3EW9RETQC20Xb7bDggIJR38Vn3bsezvfLa+/Li+93L/T1RAo1b7oS4khAVRHpXd/laVvvRDASafTOo+8WMaOQA6JAD5QAlTYiZ/qW0m/lXLiC+YQYLD4ZEO7SI+0FabYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGJ3qj0AdicAXz80DBZOO08NI4PFKjgtEE9nM3/hRUA=;
 b=Mf2rmv5Z+OWFn/2eJm33zVaEokNiwWij5iqnouEPS/0ivh8C7H4Im2Buj6QBzbmLJ6DM30Zwmw3kVTz375M4Bpl9+2f52QloZpoSSaJ7MSuUjlwJkiq79ZjFFSdguiAvl7zR+iev6usRIK2z0ZkKqKH59GHD55B3z6/DeHvu18V+Zan2u+lw/w08U+JEcs2TGlXwjN85Ln+vpa87ud43Hd6D6hXArUKZdCi0nWNHPPDmPEpZM98LMpgVr4fyfXp4oWV0xkhawl/QUCr1FILc6/fkE3HB0hKuqJGNEpIoSyHFKUjXj4NSch1Nvlq70Kniljv+tOnQEd5ewk9DJUhfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGJ3qj0AdicAXz80DBZOO08NI4PFKjgtEE9nM3/hRUA=;
 b=Bej8Rv3FAVQ0IIVUTkFWzKGgf9kH7xb93YySj4zYgpjADTuCKnhPlHf7wJFwAPjPjQalC37NqjdcoF07erVBpx/V92d6tAeUR2vNQiHSKYhEFlz3qjO5eRof50JYwhNx8lscuxBlf9pYe2nzO+sIEkDWd10ualLpCzKzG9LShiI=
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR13MB1420.namprd13.prod.outlook.com (2603:10b6:3:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10; Tue, 25 Aug
 2020 16:41:51 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078%7]) with mapi id 15.20.3326.019; Tue, 25 Aug 2020
 16:41:51 +0000
From:   Sagar Kadam <sagar.kadam@openfive.com>
To:     Rob Herring <robh@kernel.org>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@openfive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 1/1] dt-bindings: riscv: sifive-l2-cache: convert bindings
 to json-schema
Thread-Topic: [PATCH 1/1] dt-bindings: riscv: sifive-l2-cache: convert
 bindings to json-schema
Thread-Index: AQHWeetFYcQYSaG/+EK5zgQ5BKIJhalHhiCAgADfjACAAJ3xgIAAAzDA
Date:   Tue, 25 Aug 2020 16:41:51 +0000
Message-ID: <DM6PR13MB3451470F2D9FC2C87317C4EB97570@DM6PR13MB3451.namprd13.prod.outlook.com>
References: <1598255421-8274-1-git-send-email-sagar.kadam@sifive.com>
 <1598255421-8274-2-git-send-email-sagar.kadam@sifive.com>
 <20200824173539.GA2939042@bogus>
 <DM6PR13MB3451089239FDA8F87BA6410497570@DM6PR13MB3451.namprd13.prod.outlook.com>
 <CAL_Jsq+AfvgpXDt4vQmg2UcV7ARYKPw6hxJvuLotJH5xApz6cw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+AfvgpXDt4vQmg2UcV7ARYKPw6hxJvuLotJH5xApz6cw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [116.74.148.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01118a87-c0a5-4da3-9e5b-08d84915c487
x-ms-traffictypediagnostic: DM5PR13MB1420:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR13MB1420C7A5C9C54E968B166C3A97570@DM5PR13MB1420.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2BH0E+TLDDoetVk5ZV7Pg17P5MdK/DqB/LQhbTZkizyolVciZU1dFXbO1gGBud3Ff02OIa6TxgnoldGD6ym+2sKWK5JKU9dgDgTztjNXZFh2aDaMl7hZ9/rxJSpI8itCXaEZPkgOcu5A7yHn2DRujo/oO5CQ/2eEpJUkRtDNTUk+G6rgh7ap21KMHrnui2tGpC+7OqrDMlFFtLp1DExiGx5e6Oo+6WBKFW8b3Lg/0p2y77vUHXwUYbm+MvgHogycfgY4PEgUUISvYJWO/DlwuIpllMbiOK8awtgao85t/cP2EGlgZg3UJvjM8FLmeLVRmleRAwYJcVdykG8EPnprg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39830400003)(346002)(396003)(44832011)(5660300002)(4326008)(26005)(316002)(2906002)(54906003)(86362001)(478600001)(83380400001)(66556008)(66946007)(52536014)(66446008)(64756008)(76116006)(66476007)(71200400001)(9686003)(8676002)(186003)(8936002)(53546011)(55236004)(7696005)(33656002)(55016002)(6506007)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IRRWh8ONUJps7Zax/qGIdNkWUcoSzPZiQeorxtH04ljjOkF2vskINXaFuKRjW9x00D3tPbpP/73DYATTmDz/oLUZEpM+AbPKEhoKX5cM37/txkjFBZxUFt6u6+vZmvubSSRU5yPlVlu606fRFvbPYh9Rgdodoj5eRIKJqBgEHWNTZezwUvxGrAcSJJFB5gK+Owk6XQwrhhTp9Luy4jSQf/NXYvSFV9OTJB3K65y2Zns4W0cwrfrJVNxttjoKkpl7lynauLBGLscFjoteAuzwO9EFTWEuLzdUzaTgWaHby9xXFVvqI/jpjZ5SmN0bcWXhv0IA9rIcJy1466oW0G+wh+WJp8L8cnqhlwSTTmCTTKwb8X/skAM17D6XE7M5/NgXap/9evgeqrYe3CvQmUlAAhBJEOOe7hfMowMY1K5+DwdqFBq+JEObUZ//xVAJynPN63Xl8X6unckuEkcSxLxIrcSV70aWj3gLkTCGuL6mRLLDdfnj8sI2Vadn2Q714bmN8WJ8RGInAHqJXBzbZRJRvzRbWOExGSCP4owNY4XFddmfY7namwEcXnZ/g+dB4WRdtTBNI9o8jR8ReH+1NqV1269H7ehgKtTuzKVoCbZq31jHXLWSxGN+pD32nAkyRhHmojXQCNhvz1knQdflUxtY5w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01118a87-c0a5-4da3-9e5b-08d84915c487
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 16:41:51.1059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GcFZOXJ1NLJsHhhByqNJtiO4WkqEtWrcEpQvgpMY7S/hIj+Xa2riXltq07MnigmkVxfDogVIgkloZQSwHLYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1420
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNSwgMjAyMCA5
OjUxIFBNDQo+IFRvOiBTYWdhciBLYWRhbSA8c2FnYXIua2FkYW1Ab3BlbmZpdmUuY29tPg0KPiBD
YzogYW91QGVlY3MuYmVya2VsZXkuZWR1OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgUGF1
bCBXYWxtc2xleSAoDQo+IFNpZml2ZSkgPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbT47IFlhc2gg
U2hhaCA8eWFzaC5zaGFoQG9wZW5maXZlLmNvbT47DQo+IHBhbG1lckBkYWJiZWx0LmNvbTsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJpc2N2QGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGR0LWJpbmRpbmdzOiByaXNjdjogc2lm
aXZlLWwyLWNhY2hlOiBjb252ZXJ0IGJpbmRpbmdzDQo+IHRvIGpzb24tc2NoZW1hDQo+IA0KPiBb
RXh0ZXJuYWwgRW1haWxdIERvIG5vdCBjbGljayBsaW5rcyBvciBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUNCj4gc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4gDQo+IE9uIFR1ZSwgQXVnIDI1LCAyMDIwIGF0IDI6NDcgQU0gU2FnYXIgS2FkYW0NCj4gPHNh
Z2FyLmthZGFtQG9wZW5maXZlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIZWxsbyBSb2IsDQo+ID4N
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjQsIDIwMjAg
MTE6MDYgUE0NCj4gPiA+IFRvOiBTYWdhciBLYWRhbSA8c2FnYXIua2FkYW1Ab3BlbmZpdmUuY29t
Pg0KPiA+ID4gQ2M6IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IFBhdWwgV2FsbXNsZXkNCj4gPiA+ICgNCj4gPiA+IFNpZml2ZSkgPHBhdWwud2FsbXNs
ZXlAc2lmaXZlLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgWWFzaCBTaGFoDQo+ID4gPiA8eWFz
aC5zaGFoQG9wZW5maXZlLmNvbT47IHBhbG1lckBkYWJiZWx0LmNvbTsgbGludXgtDQo+ID4gPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gZHQtYmluZGluZ3M6IHJpc2N2OiBzaWZpdmUt
bDItY2FjaGU6DQo+ID4gPiBjb252ZXJ0IGJpbmRpbmdzIHRvIGpzb24tc2NoZW1hDQo+ID4gPg0K
PiA+ID4gW0V4dGVybmFsIEVtYWlsXSBEbyBub3QgY2xpY2sgbGlua3Mgb3IgYXR0YWNobWVudHMg
dW5sZXNzIHlvdQ0KPiA+ID4gcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgMjQgQXVnIDIwMjAgMTM6MjA6MjEgKzA1
MzAsIFNhZ2FyIEthZGFtIHdyb3RlOg0KPiA+ID4gPiBDb252ZXJ0IHRoZSBkZXZpY2UgdHJlZSBi
aW5kaW5ncyBmb3IgdGhlIFNpRml2ZSdzIEZVNTQwLUMwMDAgU29DJ3MNCj4gPiA+ID4gTDIgQ2Fj
aGUgY29udHJvbGxlciB0byBZQU1MIGZvcm1hdC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogU2FnYXIgS2FkYW0gPHNhZ2FyLmthZGFtQHNpZml2ZS5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3Yvc2lmaXZlLWwyLWNhY2hlLnR4
dCAgfCA1MQ0KPiA+ID4gPiAtLS0tLS0tLS0tLS0gLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvcmlz
Y3Yvc2lmaXZlLWwyLWNhY2hlLnlhbWwgfA0KPiA+ID4gPiA5Mw0KPiA+ID4gPiArKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKyks
IDUxIGRlbGV0aW9ucygtKSAgZGVsZXRlIG1vZGUNCj4gPiA+ID4gMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zaWZpdmUtbDItY2FjaGUudHh0DQo+ID4gPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3Jpc2N2L3NpZml2ZS1sMi1jYWNoZS55YW1sDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4N
Cj4gPiA+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmluZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNr
JyBvbiB5b3VyIHBhdGNoOg0KPiA+ID4NCj4gPg0KPiA+IEkgaGFkIGNoZWNrZWQgdXNpbmcgRFRf
U0NIRU1BX0ZJTEVTIG9wdGlvbiBkdWUgdG8gd2hpY2ggaXQgZGlkbid0DQo+ID4gY2F0Y2ggYW55
IGVycm9yIG9uIG90aGVyIHNjaGVtYXMuIFdpdGhvdXQgdGhpcyBJIGNvdWxkIHJlZ2VuZXJhdGUg
dGhlDQo+IGVycm9yIHlvdSBtZW50aW9uZWQuDQo+ID4gSSB3aWxsIGZpeCBpdCBhbmQgdXBkYXRl
LiBTb3JyeSBmb3IgdGhlIGVycm9yLg0KPiANCj4gVXBkYXRlIHlvdXIga2VybmVsLiBEVF9TQ0hF
TUFfRklMRVMgc2V0dGluZyBubyBsb25nZXIgbWF0dGVycyBvbiBjdXJyZW50DQo+IHRyZWUuIEl0
IG9ubHkgYWZmZWN0cyAnZHRic19jaGVjaycgbm93Lg0KPiANCg0KVGhhbmtzIGZvciB0aGUgaW5w
dXQuDQpTdXJlLCBJIHNlZSB2NS45LXJjMiBhcyBsYXRlc3QgdGFnIG9uIG1haW5saW5lLCBJIHdp
bGwgYmFzZSBhbmQgZml4IG15IHBhdGNoIGFib3ZlIGl0Lg0KDQpCUiwNClNhZ2FyDQoNCj4gUm9i
DQo=
