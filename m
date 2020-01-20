Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC7BC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026DE20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="dHjbUSHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgATJ5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:57:22 -0500
Received: from mail-am6eur05on2109.outbound.protection.outlook.com ([40.107.22.109]:59361
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgATJ5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:57:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkoFKrTogMWxy0Lk2yo7zzyYfmH3F861Q5o8eKTDhYtC+QhcmWOwWDd0uvn12gNo3DIr+LlXYAkg/fIoJNuqZdem2GnRMugk09cUfoKT0LB3VGGXTUq759NxjoqhjiMbAi16GEQuUKYrF9jRzPdwdoo14JM2Hv5YT4iKe6RIEJtdmF19VvQBbSvnj3wnQ0NJhULCGj61DZqGUeNRrDORcwA921UVuQt8SwyPBAK189mYHP7Gt545UZthK/ty0NvaSB8rHTN+H5xa4UPzVKg8F/d1StuxpVEzWqKZht1HNBLxFUB0cOsh0d6AUMA5HKDzcxb04eyBDQALqclW72nZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ssr32v6LCTK3JIU9ynN3fRim3VjdRpU7xkb5zM7VyjY=;
 b=O9rmq9mjmBS7IrCnJD4Avbl6zU9+mlfmymYD+x5ts/5Yqa8Ksz8Ac0rAZfVprtIMfQkjT8qjQCmJFm8qwm+YfF2vx+4N/gEQv0vh6hM4JhE3WCxe8AVf9GbPDfCG/Ob5V8DCNhIbTIK4Md20Hq7Qognfi9ch9g9qF2JR/Nm/Er9OFXmJoFVvF/Du2UpyyRqgmQ6I9ZeYt7SO6jkD8wUFy+2rY7Z812iqAMxFDKKFpQX3iZ7rxyst2LCBfCqIlWr63XGWSqJtTsq1h8RsYqDzESnkXje1fCScFAEftmk0amzCVj9ANJJ0dLgeL9MknvUTD1tR9WepO1RPGpISCoIRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ssr32v6LCTK3JIU9ynN3fRim3VjdRpU7xkb5zM7VyjY=;
 b=dHjbUSHenfx6O+TuW3jpKUrf6Bkpmk5BfLkXdm2LnxVQgN8GfDpbKdbzp67QC+tV3vVMYYtdPkW31o3RLGPxKK/MDAMr4zRq6WAUMyMD2/AKyT0diqh1aDtON3EsbLOpW66QPNNgplWf/4s8CMu3osGYKRQIOoB355LOtcDUej0=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB4877.eurprd05.prod.outlook.com (20.177.49.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 09:57:17 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:57:17 +0000
Received: from mail-qv1-f54.google.com (209.85.219.54) by MN2PR20CA0001.namprd20.prod.outlook.com (2603:10b6:208:e8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:57:17 +0000
Received: by mail-qv1-f54.google.com with SMTP id m14so13721854qvl.3        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 01:57:17 -0800 (PST)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/panel: make LVDS panel driver DPI capable
Thread-Topic: [PATCH 1/3] drm/panel: make LVDS panel driver DPI capable
Thread-Index: AQHVy6AaSAxSVrzF8Em1sZu2z5QUEqfwaFUAgALwVwA=
Date:   Mon, 20 Jan 2020 09:57:17 +0000
Message-ID: <CAGgjyvHVg9OBWqpBd9k1hf561VjFQwh3o9QUFcy1A=_KNnK2Gg@mail.gmail.com>
References: <20200115123401.2264293-1-oleksandr.suvorov@toradex.com>
 <20200115123401.2264293-2-oleksandr.suvorov@toradex.com>
 <20200118130418.GA13417@ravnborg.org>
In-Reply-To: <20200118130418.GA13417@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:208:e8::14) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAVygnmVX5AYN5obHQJVi67bvNnVlmJkT0gJi2WFqnNdV33iDd/P
        oYu/GWBSjmtajn/hL6oAEn6tCW8LARy5BhJrCbY=
x-google-smtp-source: APXvYqx2o8Lt8nu/EioDnGjd8lcoS/06Zua8BfW+k3MuK6WuhLmFV+oXJs4g/YNYy3olQ9F8M+HdORYmNZ3gI3iAv/s=
x-received: by 2002:a0c:c389:: with SMTP id o9mr20107719qvi.232.1579514233336;
 Mon, 20 Jan 2020 01:57:13 -0800 (PST)
x-gmail-original-message-id: <CAGgjyvHVg9OBWqpBd9k1hf561VjFQwh3o9QUFcy1A=_KNnK2Gg@mail.gmail.com>
x-originating-ip: [209.85.219.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7298c17-dfdd-41f7-7ca8-08d79d8f21ea
x-ms-traffictypediagnostic: VI1PR05MB4877:
x-microsoft-antispam-prvs: <VI1PR05MB487769A234B46233252B3CA9F9320@VI1PR05MB4877.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(199004)(189003)(316002)(42186006)(2906002)(44832011)(54906003)(4326008)(52116002)(81166006)(8936002)(81156014)(478600001)(6862004)(55236004)(53546011)(8676002)(66946007)(66476007)(64756008)(66556008)(186003)(55446002)(66446008)(9686003)(26005)(107886003)(86362001)(5660300002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4877;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wxBUJSioBNBxwuSjSlJ2V0wcXu2JhLkq8spulN8uH7jvK1jHW2/sI6C3VfpHZxzTA9tiEnw/Emh6nGXcwXdx6/EOB8hx+74u6XoIlOlmDSUKebNG8IiUdBL/kkgcgyHsJvcOvYk3xFpwKkt6EPw2IfTNARawmiaLrBRH8G3krF24VuG1g+zT15w1BZVQgdGFmdZoOjjOtpBqQz7Mt1Rq1WuElJCWk0EwrGXu27r+XprV8xXqjznrT/oalBAqSi1BNb3/l+W7MwSZklyLaBktZC32KzUSmoNttPzYLA0V6EktqDhB+PnAuwvHBqGRpZaC+mR8B0RRcyHBBba+Htono27tOBRU6ZuSLId6OpbO525OZZWleHoAsiZZMkEbgpAxgz9HizT24KxK5JbRqY9jjCGmRk7DaBeCibUd8ejWAO7uJSSOW+a6AAyNosVrNdQc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0852F0536A5D6D45AAF7B66D37C4F2B3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7298c17-dfdd-41f7-7ca8-08d79d8f21ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 09:57:17.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8j1GoT5kSj8c2fOfIKSDLNC6h/D7+NJCLBcIT5xqiboEn3YBAY4B1ltivqnOogM76B1dXzmtlnZnrss71sLhSQihT093OVTG1bxzzBYMXXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2FtLA0KDQpPbiBTYXQsIEphbiAxOCwgMjAyMCBhdCAzOjA0IFBNIFNhbSBSYXZuYm9yZyA8
c2FtQHJhdm5ib3JnLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgTFZEUyBwYW5lbCBkcml2ZXIg
aGFzIGFsbW9zdCBldmVyeXRoaW5nIHdoaWNoIGlzIHJlcXVpcmVkIHRvDQo+ID4gZGVzY3JpYmUg
YSBzaW1wbGUgcGFyYWxsZWwgUkdCIHBhbmVsIChhbHNvIGtub3duIGFzIERQSSwgRGlzcGxheQ0K
PiA+IFBpeGVsIEludGVyZmFjZSkuDQo+ID4NCj4gPiAtLS0NCj4NCj4gVGhlcmUgYXJlIGEgZmV3
IGhpZ2gtbGV2ZWwgdGhpbmdzIHdlIG5lZWQgdG8gaGF2ZSBzb3J0ZWQgb3V0Lg0KPg0KPiBUaGUg
ZHJpdmVyLCB3aGVuIHRoaXMgcGF0Y2ggaXMgYWRkZWQsIGFzc3VtZXMgdGhhdCBjZXJ0YWluIHBy
b3BlcnRpZXMNCj4gYXJlIG5vdyBtYW5kYXRvcnkgd2hlbiB1c2luZyB0aGUgcGFuZWwtZHBpIGNv
bXBhdGlibGUuDQo+ICAgLSBkYXRhLW1hcHBpbmcNCj4gICAtIHdpZHRoLW1tDQo+ICAgLSBoZWln
aHQtbW0NCj4gICAtIHBhbmVsLXRpbWluZw0KPg0KPiBCdXQgdGhpcyBkb2VzIG5vdCBtYXRjaCB0
aGUgcGFuZWwtZHBpIGJpbmRpbmcuDQo+IFNvIHdlIG5lZWQgdGhlIHBhbmVsLWRwaSBiaW5kaW5n
IHVwZGF0ZWQgZmlyc3QuDQo+DQo+DQo+IFRoZSBjdXJyZW50IGRyaXZlciBzcGVjaWZ5IHRoZSBj
b25uZWN0b3IgdHlwZSBpbiBkcm1fcGFuZWxfaW5pdCgpLg0KPiBCdXQgYSBEUEkgcGFuZWwgaXMg
YXNzdW1lZCB0byB1c2UgYSBEUk1fTU9ERV9DT05ORUNUT1JfRFBJLA0KPiBhbmQgbm90IGEgRFJN
X01PREVfQ09OTkVDVE9SX0xWRFMuDQo+IFNvIHRoZSBkcm1fcGFuZWxfaW5pdCgpIGNhbGwgbmVl
ZHMgdG8gdGFrZSBpbnRvIGFjY291bnQgdGhlIHR5cGUNCj4gb2YgYmluZGluZy4NCj4NClRoYW5r
cywgSSdsbCBmaXggaXQgaW4gMm5kIHZlcnNpb24uDQo+DQo+ID4gQEAgLTI1Nyw3ICsyNzksNyBA
QCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBwYW5lbF9sdmRzX2RyaXZlciA9IHsNCj4g
PiAgICAgICAucHJvYmUgICAgICAgICAgPSBwYW5lbF9sdmRzX3Byb2JlLA0KPiA+ICAgICAgIC5y
ZW1vdmUgICAgICAgICA9IHBhbmVsX2x2ZHNfcmVtb3ZlLA0KPiA+ICAgICAgIC5kcml2ZXIgICAg
ICAgICA9IHsNCj4gPiAtICAgICAgICAgICAgIC5uYW1lICAgPSAicGFuZWwtbHZkcyIsDQo+ID4g
KyAgICAgICAgICAgICAubmFtZSAgID0gInBhbmVsLWdlbmVyaWMiLA0KPg0KPiBJIHRoaW5rIGNo
YW5naW5nIHRoZSBuYW1lIG9mIHRoZSBkcml2ZXIgbGlrZSB0aGlzIGlzIGFuIFVBUEkgY2hhbmdl
LA0KPiB3aGljaCBpcyBub3QgT0sNCg0KSSBzZWUgMiBzaW1wbGUgd2F5cyB0aGVyZToNCi0ga2Vl
cCB0aGUgb3JpZ2luYWwgcGxhdGZvcm0gZHJpdmVyIG5hbWU7DQotIGZvcmsgcGFuZWwtbHZkcyBk
cml2ZXIgYXMgcGFuZWwtZ2VuZXJpYyBkcml2ZXIgd2l0aCBkcGkgc3VwcG9ydC4NCg0KV2hhdCBz
b2x1dGlvbiBkbyB5b3UgcHJlZmVyPw0KDQo+ID4gICAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFi
bGUgPSBwYW5lbF9sdmRzX29mX3RhYmxlLA0KPiA+ICAgICAgIH0sDQo+ID4gIH07DQo+DQo+ICAg
ICAgICAgU2FtDQoNCi0tDQpCZXN0IHJlZ2FyZHMNCk9sZWtzYW5kciBTdXZvcm92DQoNClRvcmFk
ZXggQUcNCkFsdHNhZ2Vuc3RyYXNzZSA1IHwgNjA0OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5k
IHwgVDogKzQxIDQxIDUwMA0KNDgwMCAobWFpbiBsaW5lKQ0K
