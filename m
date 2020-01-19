Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F496C33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9F320678
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="oAa7nXvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgASV1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 16:27:38 -0500
Received: from mail-eopbgr150137.outbound.protection.outlook.com ([40.107.15.137]:48105
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728721AbgASV1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 16:27:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g76VSn7ayUHyc+rYTf8PSXmR93Xs89ISOyVhaMqah65MxxS57TKyvy6r0px4qWm+p2Psu8WQQqmBjEku6ZLvWexupH9L4d4hLwR+dcH1mjHn/KNEh7/hLX9RJHDnlHxwJWAI1DCglcCPfLd5al7RQLtgr22bmztyfLj/tRBD33lN0234zZ0lTbaqlYS/Rk1Z6EDOsS9qZVTSJ1BUaUo+KnxcGJNIe2OLgV0Fjy5iVBb2uOATORXN6pITd32SifGF7KQMOQ9y7jgXYAZzYwqwBdPsva9m3q1NwQ/czmRLBjMSG6exzSr2b9qKYjudegygbNkoXYj407ARobbYIi2Vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcQjn/IMLieVVfiZOaCwmeErIV6abILgivBFrT4Hm+k=;
 b=Nqmt94iCOmh2ABQRvlBj8OSZR7GHjDcXhC/dkbifWC9T+0sosjQ4MRrOduZo17OlZHbXRWRb0RCpElfGiJJAmhaGwOOrGXOJjyux/UNmVI6V4Od8glZaJg7Xdp+81ot90ahwRHT9SRWwTcTNLjvKbstW7y3kRXVUTlSggyPFwwxmiSiYmvv7wIulxeCEtHQArPqR3AeXQ0r7jYIZswFHSr/jfkAnblk+QnF+hNRBzXOMJebeoEkhyFzCVoSbA3jy7Fzv0yoMPvzkrQXqwuF3hlTo1sdl8IFBghJcOPA064zCQiY4fr0+rirPl9cWY11LbsGU9SudfAoyK4ARgv+sXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcQjn/IMLieVVfiZOaCwmeErIV6abILgivBFrT4Hm+k=;
 b=oAa7nXvMSvPFfylXQQ1D4C0GkaGtwFu09o9zCUZCIwgG3AvfdFiTrMfIAzIoIHS4n1xF76cpmAUqXdKJ2PzlPh99Y72+BOJAQzI+ytzAelu1kZxWOhYEf3W4uRIm6WJigkFAblcwZ8aHkddPCDMQc0c9Co8N3+jJLj3D3Z91Y4g=
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com (10.186.163.80) by
 VI1PR05MB5375.eurprd05.prod.outlook.com (20.178.10.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Sun, 19 Jan 2020 21:27:35 +0000
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::9192:77a8:62cf:c098]) by VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::9192:77a8:62cf:c098%3]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020
 21:27:35 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "info@logictechno.com" <info@logictechno.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "j.bauer@endrich.com" <j.bauer@endrich.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: [PATCH v2 3/3] dt-bindings: display: panel: add bindings for
 logic technologies displays
Thread-Topic: [PATCH v2 3/3] dt-bindings: display: panel: add bindings for
 logic technologies displays
Thread-Index: AQHVjNKZdd5XHtZGzk6i73CvPQ4gHKdzQ1YAgH/BiwA=
Date:   Sun, 19 Jan 2020 21:27:35 +0000
Message-ID: <ef61eb4e34e5fe4c8540ea82cb2c4de61086e21c.camel@toradex.com>
References: <20191027142609.12754-1-marcel@ziswiler.com>
         <20191027142609.12754-3-marcel@ziswiler.com> <20191030142952.GB31293@bogus>
In-Reply-To: <20191030142952.GB31293@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [81.221.128.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 150fbf4f-c52e-466e-997f-08d79d2666cc
x-ms-traffictypediagnostic: VI1PR05MB5375:
x-microsoft-antispam-prvs: <VI1PR05MB537540DFBE3F3AE3A60AB20AFB330@VI1PR05MB5375.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(39830400003)(396003)(376002)(199004)(189003)(66556008)(91956017)(66476007)(66946007)(76116006)(4326008)(478600001)(6916009)(66446008)(2906002)(316002)(2616005)(36756003)(64756008)(6506007)(5660300002)(71200400001)(4001150100001)(54906003)(7416002)(6486002)(81166006)(6512007)(44832011)(186003)(81156014)(86362001)(8936002)(966005)(8676002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5375;H:VI1PR05MB6845.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TbtcDC0WMngEfqWJ1XUZYINB1OtiF9zgRvbIFnxgBcSSz0b8CloU2OW6ppRw1bJK20By5ibjHyyc0R7xhI16UzTo1OsT0IPlr3auQ5X7W0A7deEHMccyhpMw74Kuivj5paCN+f6va7hJU2XpJS2MguvxMqJKOB0uYqeXjFlYTw+hdnV/d/bjFUkxQ6maALrC7rDd4ibrvbswgBpW4SEOs5VwqWFExrGqzFiP29URfWqHA4HxKSGhawfZzVnGeWRDIAmnssL97S9GYN9773FcwXUtqeQN5WETplC7kUFUVm1lFGWL2/NS/FhxLIL3gIKOAdvT/z6s0JlL0Z/BZmOFus3f6oeg6FfT6jFGoDo3ruPAwRFcxuOGxyuomCcycqvYbVe8VAp1IxV09abONup79Lo0W6kRamBqKmpMRRNhVbtlQOCoAKJp72nsBAfXNhuoG4eQZSjdpLoCyPohx+4OJu2DPoo0jgyWySoDs0NP0nO7K3AtesyK5wRZgzr1BQ668eP35ZSRQ9kf2DlttPPnVg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E0087ACC9050C4EBAA050500C087FD2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150fbf4f-c52e-466e-997f-08d79d2666cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 21:27:35.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jv9vIfhjZ+K7DN7I1RJgCQ4hnNwYEtVUYu5grdCDf5dIUiIm0sislmvHklen3I6QADWTkAw8es9QJlwg9SxZP4adJuESmy+1iQkItovbYBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTMwIGF0IDA5OjI5IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU3VuLCBPY3QgMjcsIDIwMTkgYXQgMDM6MjY6MDlQTSArMDEwMCwgTWFyY2VsIFppc3dpbGVy
IHdyb3RlOg0KPiA+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFk
ZXguY29tPg0KPiA+IA0KPiA+IEFkZCBiaW5kaW5ncyBmb3IgdGhlIGZvbGxvd2luZyAzIHByZXZp
b3VzbHkgYWRkZWQgZGlzcGxheSBwYW5lbHMNCj4gPiBtYW51ZmFjdHVyZWQgYnkgTG9naWMgVGVj
aG5vbG9naWVzIExpbWl0ZWQ6DQo+ID4gDQo+ID4gLSBMVDE2MTAxMC0yTkhDIGUuZy4gYXMgZm91
bmQgaW4gdGhlIFRvcmFkZXggQ2FwYWNpdGl2ZSBUb3VjaA0KPiA+IERpc3BsYXkNCj4gPiA3IiBQ
YXJhbGxlbCBbMV0NCj4gPiAtIExUMTYxMDEwLTJOSFIgZS5nLiBhcyBmb3VuZCBpbiB0aGUgVG9y
YWRleCBSZXNpc3RpdmUgVG91Y2gNCj4gPiBEaXNwbGF5IDciDQo+ID4gUGFyYWxsZWwgWzJdDQo+
ID4gLSBMVDE3MDQxMC0yV0hDIGUuZy4gYXMgZm91bmQgaW4gdGhlIFRvcmFkZXggQ2FwYWNpdGl2
ZSBUb3VjaA0KPiA+IERpc3BsYXkNCj4gPiAxMC4xIiBMVkRTIFszXQ0KPiA+IA0KPiA+IFRob3Nl
IHBhbmVscyBtYXkgYWxzbyBiZSBkaXN0cmlidXRlZCBieSBFbmRyaWNoIEJhdWVsZW1lbnRlDQo+
ID4gVmVydHJpZWJzDQo+ID4gR21iSCBbNF0uDQo+ID4gDQo+ID4gWzFdIA0KPiA+IGh0dHBzOi8v
ZG9jcy50b3JhZGV4LmNvbS8xMDQ0OTctNy1pbmNoLXBhcmFsbGVsLWNhcGFjaXRpdmUtdG91Y2gt
ZGlzcGxheS04MDB4NDgwLWRhdGFzaGVldC5wZGYNCj4gPiBbMl0gDQo+ID4gaHR0cHM6Ly9kb2Nz
LnRvcmFkZXguY29tLzEwNDQ5OC03LWluY2gtcGFyYWxsZWwtcmVzaXN0aXZlLXRvdWNoLWRpc3Bs
YXktODAweDQ4MC5wZGYNCj4gPiBbM10gDQo+ID4gaHR0cHM6Ly9kb2NzLnRvcmFkZXguY29tLzEw
NTk1Mi0xMC0xLWluY2gtbHZkcy1jYXBhY2l0aXZlLXRvdWNoLWRpc3BsYXktMTI4MHg4MDAtZGF0
YXNoZWV0LnBkZg0KPiA+IFs0XSANCj4gPiBodHRwczovL3d3dy5lbmRyaWNoLmNvbS9pc2k1MF9p
c2kzMF90ZnQtZGlzcGxheXMvbHQxNzA0MTAtMXdoY19pc2kzMA0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+
IA0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBOZXcgcGF0Y2ggYWRk
aW5nIGRpc3BsYXkgcGFuZWwgYmluZGluZ3MgYXMgd2VsbCBhcyBzdWdnZXN0ZWQgYnkNCj4gPiBS
b2IuDQo+ID4gDQo+ID4gIC4uLi9wYW5lbC9sb2dpY3RlY2hubyxsdDE2MTAxMC0ybmhjLnlhbWwg
ICAgICB8IDQ0DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAuLi4vcGFuZWwvbG9naWN0
ZWNobm8sbHQxNjEwMTAtMm5oci55YW1sICAgICAgfCA0NA0KPiA+ICsrKysrKysrKysrKysrKysr
KysNCj4gPiAgLi4uL3BhbmVsL2xvZ2ljdGVjaG5vLGx0MTcwNDEwLTJ3aGMueWFtbCAgICAgIHwg
NDQNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTMyIGlu
c2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvbG9naWN0ZWNobm8sbHQxNjEwMQ0KPiA+
IDAtMm5oYy55YW1sDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL2xvZ2ljdGVjaG5vLGx0MTYxMDENCj4g
PiAwLTJuaHIueWFtbA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9sb2dpY3RlY2hubyxsdDE3MDQxDQo+
ID4gMC0yd2hjLnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9sb2dpY3RlY2hubyxsdDE2MQ0KPiA+
IDAxMC0ybmhjLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L3BhbmVsL2xvZ2ljdGVjaG5vLGx0MTYxDQo+ID4gMDEwLTJuaGMueWFtbA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4wZGZlOTRkMzhhNDcN
Cj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9sb2dpY3RlY2hubyxsdDE2MQ0KPiA+IDAxMC0ybmhj
LnlhbWwNCj4gPiBAQCAtMCwwICsxLDQ0IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjANCj4gDQo+IEV4Y2VwdCB0aGUgbGljZW5zZSBmb3IgbmV3IGJpbmRpbmdzIHNo
b3VsZCBiZTogDQo+IA0KPiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCg0KT0ssIHdp
bGwgc2VuZCBhIHYzIHNob3J0bHkuDQoNCj4gUm9iDQo=
