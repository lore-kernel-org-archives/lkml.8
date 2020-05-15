Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D3AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E4C2078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J62yZP3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgEOKHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:07:30 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:7431
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728007AbgEOKHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUWHWLEfqjjSycTr2Xhi0T5KCbweidoSuoy3SNCNjtNZyPZMHu/KxMfojsy0jAntMmntTYd0gmgD5TOqGEB1lWw2bLstzSB5PW2/K4N8GuayzKj4BpGJlYUh4dH9lXArY2A1rBQy8I1ywqSWeBZCe/kWZP7ay84MW2yA4aEMqnV3q4vrrchu0mmG79FVM6WhTkrhcDplJm/X/C8cUUaP9JwlLem2jE/JmimFXf9DZbCaHY2H4945K2WTFoKqpGYwOzQ8tHtrPlTdmmulftWlRydR0l1lJ/NATpyEUxiJXYfhqNoa6yoqQLTKfmOlxaxzmaTtRaC5VB/4YV/Pmug/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJe0W2FCQR8knlx57fqZ3mSlEV4FPBeBwmZiyiDJeuk=;
 b=DnomshmGCvXlFW+1d6bDB9a5AstnRhiBN0vWsET4FiP307PZmVLj2PyLtx3ahus9n0y3xN+xI8Ck1slGUht1UheQJWWOX98hpACOMDc21I/WI6B70TUu2xCrW3AeMoUoOMJsN6TsTYVY+mLsdx+5XDJtlELsOhthE+o+mqRSC07fv24vJNefDxwia3N9jT+D3w/2neLD2VYomI8MWn6vQvBgG7vBOhhkGT8dKV4iY4Pf2mwRFRQ/KFtfvB4HXETqBWZyvpSaufkE8hHWjn2PM4B0qe0CQMm9ekvJpyo1BkToazGR/MowP9debqDiHYrRqXPaHyRb6aw46Wp23VJVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJe0W2FCQR8knlx57fqZ3mSlEV4FPBeBwmZiyiDJeuk=;
 b=J62yZP3P16SO5r3urXuXmamiuiLg3zt/ijcHoAChuhvArk2e5TcmjjjL/y8W/8WjUrii+k+fOrSM3VfqzJDx8giMVanTmTq6UnPzYd3FVkWcqeZY+7Jt/LaZg6wg+LfRRwbUVP/rbxapm3GaXSWOlurufiDMX6wvJZ5hjWgfaGc=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VE1PR04MB6541.eurprd04.prod.outlook.com (2603:10a6:803:121::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 10:07:26 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03%7]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 10:07:25 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>, Jun Li <lijun.kernel@gmail.com>
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
Thread-Index: AQHWJdlQZJAsekudzECWhic28QWur6io62yAgAAEAEA=
Date:   Fri, 15 May 2020 10:07:25 +0000
Message-ID: <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
 <87h7wqmwrv.fsf@kernel.org>
 <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
 <87imgx35pg.fsf@kernel.org>
In-Reply-To: <87imgx35pg.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 272783eb-b259-4e34-b8d2-08d7f8b7c4b9
x-ms-traffictypediagnostic: VE1PR04MB6541:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6541D4CD3A0A4B3D70CD708A89BD0@VE1PR04MB6541.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EP36lxspnFdOlgke6Bkt+biq0CoHj3fgRoMtiZ7i0Xcj+uJwN4GabtoaVdGVWYKLgvJq1fwxBuUKyEIPO79osw2d4s+o8/UGBolkj3nh0H1VlWStBjGSZTS9wXfj1cgyB4twVO4RQTAJGvZB6YErtMreuZ919QKQ/gYbZ1iCNmI/heR1B1jwHT51MMfawz0MUr0fidRzxMvDUMHCGRBrPhujZBXScKefINVeAitSC8yKedO2QLZ6r6hjIwOQSCbOVhgVbw9GORH4aamjZbrazTGZOPYbZDdAMe7j5ZvU5Mk8s7FZCQFQz/PNiXpYjk+Br51LAo3p/MQSi4z12iLkZrMHEJHCaCbnyvXorxRp2QHRCpph+LrVcCBqNRH6jEf3rgUwxmLfota3axtkeBjEVBgAmiGbpi+wZtAiv4pnvhA75v4Kdcs8E/CKf7Xgh8UK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(54906003)(44832011)(26005)(71200400001)(316002)(9686003)(55016002)(110136005)(186003)(478600001)(8936002)(8676002)(86362001)(33656002)(66556008)(7416002)(2906002)(6506007)(66476007)(64756008)(66446008)(53546011)(5660300002)(66946007)(76116006)(52536014)(4326008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3qBwXqAv8tX5riHZlq3/yWyQ17yuYLI/pEbSM90KnvEDMwsu3pzCvDx5oTeKjmckkAuyedrK69cKfz81RW9oCkBb0HuRXDX2xuKb04fk3OYwLtor7h7QyRnBCGpcVpUW1c82ftWy2WzLj+q9f06kVYDx/fYALvW1zUlCSkcPextS9rxcQu6Ugb7nQaHCIAWLwjO+eE+79F9ny24L9GlB3PmXn/XfgReYGkOAUlTG2tUsIx9crhMjFMxbAiowt4hk9GIEqrjCi3zIQbe4XlQZZoTnjy8/c9IsGO7jjHgGraJwROC6qKh1eZ5+dID0codwMc4Hgl+Iu0mhf2CnFMqYosF6/c3BrCLd8Vip7ttv6nUaBVKYIxaHPhlrRocex8FgKDaO4gzdKK4hm5bORi6f8iIt4iU2/gommSL9P/c3U2iLwo0+rorqbGUbKFfDMPMoEYSj8uORepERH2ISUgXeYaWxB9aTxtTYBhvB+nR9Zt4=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272783eb-b259-4e34-b8d2-08d7f8b7c4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 10:07:25.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jCSEFaYkY5tUmzk9ZYq4Yy+Zn9OiHx9ZfI29iRoYi/A7/66jS1C0WLvUSldGEX9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6541
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmVsaXBlIEJhbGJpIDxi
YWxiaWZAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgRmVsaXBlIEJhbGJpDQo+IFNlbnQ6IDIwMjDE
6jXUwjE1yNUgMTc6MzENCj4gVG86IEp1biBMaSA8bGlqdW4ua2VybmVsQGdtYWlsLmNvbT4NCj4g
Q2M6IEpvaG4gU3R1bHR6IDxqb2huLnN0dWx0ekBsaW5hcm8ub3JnPjsgbGttbCA8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz47IFl1DQo+IENoZW4gPGNoZW55dTU2QGh1YXdlaS5jb20+OyBH
cmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgUm9iDQo+IEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFy
bS5jb20+OyBTaHVGYW4gTGVlDQo+IDxzaHVmYW5fbGVlQHJpY2h0ZWsuY29tPjsgSGVpa2tpIEty
b2dlcnVzIDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPjsNCj4gU3V6dWtpIEsgUG91
bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT47IENodW5mZW5nIFl1bg0KPiA8Y2h1bmZlbmcu
eXVuQG1lZGlhdGVrLmNvbT47IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBB
bmR5IFNoZXZjaGVua28NCj4gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+OyBWYWxlbnRpbiBT
Y2huZWlkZXIgPHZhbGVudGluLnNjaG5laWRlckBhcm0uY29tPjsNCj4gSmFjayBQaGFtIDxqYWNr
cEBjb2RlYXVyb3JhLm9yZz47IExpbnV4IFVTQiBMaXN0IDxsaW51eC11c2JAdmdlci5rZXJuZWwu
b3JnPjsgb3Blbg0KPiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJQ0UgVFJF
RSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBQZXRlciBDaGVuIDxw
ZXRlci5jaGVuQG54cC5jb20+OyBKdW4gTGkgPGp1bi5saUBueHAuY29tPjsgVGhpbmggTmd1eWVu
DQo+IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0
IDMvOV0gdXNiOiBkd2MzOiBJbmNyZWFzZSB0aW1lb3V0IGZvciBDbWRBY3QgY2xlYXJlZCBieSBk
ZXZpY2UNCj4gY29udHJvbGxlcg0KPiANCj4gDQo+IEhpLA0KPiANCj4gSnVuIExpIDxsaWp1bi5r
ZXJuZWxAZ21haWwuY29tPiB3cml0ZXM6DQo+ID4+IEBAIC0zOTcsMTIgKzQwNywxOCBAQCBpbnQg
ZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQNCj4g
Y21kLA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICBkd2MzX2dhZGdldF9lcF9nZXRfdHJh
bnNmZXJfaW5kZXgoZGVwKTsNCj4gPj4gICAgICAgICB9DQo+ID4+DQo+ID4+IC0gICAgICAgaWYg
KHNhdmVkX2NvbmZpZykgew0KPiA+PiArICAgICAgIGlmIChzYXZlZF9oc19jb25maWcpIHsNCj4g
Pj4gICAgICAgICAgICAgICAgIHJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0Iy
UEhZQ0ZHKDApKTsNCj4gPj4gLSAgICAgICAgICAgICAgIHJlZyB8PSBzYXZlZF9jb25maWc7DQo+
ID4+ICsgICAgICAgICAgICAgICByZWcgfD0gc2F2ZWRfaHNfY29uZmlnOw0KPiA+PiAgICAgICAg
ICAgICAgICAgZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApLCByZWcp
Ow0KPiA+PiAgICAgICAgIH0NCj4gPj4NCj4gPj4gKyAgICAgICBpZiAoc2F2ZWRfc3NfY29uZmln
KSB7DQo+ID4+ICsgICAgICAgICAgICAgICByZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdD
M19HVVNCM1BJUEVDVEwoMCkpOw0KPiA+PiArICAgICAgICAgICAgICAgcmVnIHw9IHNhdmVkX3Nz
X2NvbmZpZzsNCj4gPj4gKyAgICAgICAgICAgICAgIGR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdD
M19HVVNCM1BJUEVDVEwoMCksIHJlZyk7DQo+ID4+ICsgICAgICAgfQ0KPiA+PiArDQo+ID4+ICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gPj4gIH0NCj4gPg0KPiA+IFVuZm9ydHVuYXRlbHkgdGhpcyB3
YXkgY2FuJ3Qgd29yaywgb25jZSB0aGUgU1MgUEhZIGVudGVycyBQMywgZGlzYWJsZQ0KPiA+IHN1
c3BlbmRfZW4gY2FuJ3QgZm9yY2UgU1MgUEhZIGV4aXQgUDMsIHVubGVzcyBkbyB0aGlzIGF0IHRo
ZSB2ZXJ5DQo+ID4gYmVnaW5uaW5nIHRvIHByZXZlbnQgU1MgUEhZIGVudGVyaW5nIFAzKGUuZy4g
YWRkICJzbnBzLGRpc191M19zdXNwaHlfcXVpcmsiIGZvcg0KPiB0ZXN0KS4NCj4gDQo+IEl0IHNv
dW5kcyBsaWtlIHlvdSBoYXZlIGEgcXVpcmt5IFBIWS4gDQoNCkZyb20gd2hhdCBJIGdvdCBmcm9t
IHRoZSBJQyBkZXNpZ24sIHRoZSBiZWhhdmlvciBvZiBEV0MzX0dVU0IzUElQRUNUTF9TVVNQSFkN
CmJpdCBzaG91bGQgYmUgYXMgd2hhdCBJIHNhaWQsIG5vdCBhIHF1aXJreS4NCg0KSGkgVGhpbmgs
IGNvdWxkIHlvdSBjb21tZW50IHRoaXM/DQoNCj4gSWYgdGhhdCdzIHRoZSBjYXNlLCB0aGVuIHlv
dSBwcm9iYWJseSBuZWVkDQo+IHRvIHVzZSB0aGUgZmxhZyB5b3UgbWVudGlvbmVkIGFib3ZlLiBQ
bGVhc2UgdmVyaWZ5IHdpdGggdGhhdC4NCg0KV2l0aCBxdWlyayBvZiAic25wcyxkaXNfdTNfc3Vz
cGh5X3F1aXJrIiwgSSBoYWQgdmVyaWZpZWQgaXQgY2FuDQpyZXNvbHZlIHRoZSBwcm9ibGVtLCBi
dXQgdGhpcyB3aWxsIG1ha2UgVVNCMyBTdXBlciBTcGVlZCBQSFkNCm5ldmVyIGVudGVyIFAzLCB0
aGlzIGlzIGEgaHVnZSBpbXBhY3Qgb24gVVNCIHBvd2VyIGNvbnN1bXB0aW9uLg0KDQpUaGUgdGlt
ZW91dCBpbmNyZWFzZSBoYXMgbm8gaW1wYWN0IG9uIHRob3NlIHBsYXRmb3JtcyB3aGljaCBoYXZl
DQpubyB0aGlzIHByb2JsZW0sIGJ1dCBjYW4gZ2l2ZSBjaGFuY2UgZm9yIHBsYXRmb3JtIHdpdGgg
dmVyeSBsb3cNCnN1cHNwZW5kIGNsayhsaWtlIG15IGNhc2UgMzJrKSB0byB3b3JrLg0KDQpUaGFu
a3MNCkxpIEp1bg0KPiANCj4gLS0NCj4gYmFsYmkNCg==
