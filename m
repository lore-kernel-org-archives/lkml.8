Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE5C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE5A2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="De8FOt0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD2Bss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:48:48 -0400
Received: from mail-am6eur05on2063.outbound.protection.outlook.com ([40.107.22.63]:34784
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgD2Bsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:48:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KotixCFzLJKwN33PGXjFdbfCgPdH32h6lAvBcInoJLMfW0xLd95fiz7Jdas/EV5zvzyVTDT5jQ2CXPCZHYGMfW8BEJ7yrlYlgeAmSawPNS6p8luhyW0jBl5JLDmP8z/NsqmJlm6ovcd7SDzp4WAYZXNQLIGPRzUdg+pDfzvPktuU3mImzzoYMApBtSWQgj1h/jklw472He6NsqggWJJreDQ66f4wta/dROX5IDhI5c80GPkkujk+96/vNircLx2dHwn0vkCzCo8s3HUH0PgGEB5KmSSfWtMRhmAasLcVr9pn3MglO7/Kex4fMnZd7eD6LDCcT9QG6rvmH/BlLOwexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNjQqQ2uLBakTBOtkzQeEn0tcpzNE2iyt5jy0BVsrb0=;
 b=fDeKVPBRGmTOOGkWpKzWQvr/iyXVoRA6iNbLYCKvNRn0bIVLFSqPn/6pTNjYFbnUiA8KEU0uWnRgyX1+e+s4WsN3Yp1QDSlCiHGO3lFhu7n48ngjf5cUwRaXAfsYtbiuI63OTAAob+1G8L5vBMZTlxPxDgLMTDvcaFFWH+ZQi0N9ql0zkJNFSpmJR+VUsO7Jx+YsP0ncaO1zN68eAJW0yp8dAiApmFJ3MmJmpmp8+mFPVClLuPck5yT5YAls58CzHfzT51cyIvPfoBikV+07xuQwlNFUYZmiJbdkw4itCcDhW8Su8bJdcNc2CA6/Bia0qXqGsxwFKyNiQ+vR0r/iaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNjQqQ2uLBakTBOtkzQeEn0tcpzNE2iyt5jy0BVsrb0=;
 b=De8FOt0p4OWFOoZKLzbl3Hl/dI0rzyhIuCXlljiWRGGGPvTWCoy2U767au7gkDVcrM8RmytQnCMLmuGfUmZKo1zxSSvtob86btRHxgvhIssTQ/VwlllbSbHdI/rV7DDe5/ZdJA9SFgXxG3pCBR7uw230FIn5Gy9umrw0bX8uj10=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 01:48:42 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792%7]) with mapi id 15.20.2937.026; Wed, 29 Apr 2020
 01:48:42 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?utf-8?B?TWljaGHFgsKgTWlyb3PFgmF3?= <mirq-linux@rere.qmqm.pl>
CC:     Jason Yan <yanaijie@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: usb2: remove unneeded semicolon
Thread-Topic: [PATCH] usb: chipidea: usb2: remove unneeded semicolon
Thread-Index: AQHWHSchaOtifOWa1UaWw//ChPBLIaiOkQ6AgADFYIA=
Date:   Wed, 29 Apr 2020 01:48:42 +0000
Message-ID: <20200429014907.GA20222@b29397-desktop>
References: <20200428063359.16433-1-yanaijie@huawei.com>
 <20200428140241.GA2762@qmqm.qmqm.pl>
In-Reply-To: <20200428140241.GA2762@qmqm.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rere.qmqm.pl; dkim=none (message not signed)
 header.d=none;rere.qmqm.pl; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 371f0a9d-2cf3-4469-f114-08d7ebdf726e
x-ms-traffictypediagnostic: AM7PR04MB6981:
x-microsoft-antispam-prvs: <AM7PR04MB698180AC73428891747995BD8BAD0@AM7PR04MB6981.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(346002)(396003)(366004)(39860400002)(136003)(376002)(186003)(71200400001)(66476007)(4326008)(9686003)(66446008)(64756008)(66556008)(66946007)(26005)(76116006)(91956017)(53546011)(6506007)(6486002)(6916009)(86362001)(478600001)(6512007)(8936002)(8676002)(2906002)(54906003)(316002)(33716001)(5660300002)(66574012)(1076003)(44832011)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4iXh8QOaFUrpssWWMOBdCxxWDN3m3558Mywx9dR82bG3NvtlAVWnLDZd322/8gZ6Pz3grkmWmKjS/WGmH2UrLA+oB/OQOLv1PEjzvpFL/ljvjeqA5XJSyn7Gp/DVqOssCjtIhsIhXJ4VwY/aAn185rH2u67h+NDEGhqKrHMFiHbrNba7duCii1KVDWPEsMDIzqfwci62x/L25u/hm4O7aycB8TS10qGKrczvmDZExFVvTGRslX4P4ZQk/XK860m+GfWflLVyNAY5hR9pS1AzEIMk3zvt4I4N3W0crvVZn6MlxsZMnKzBKzjSnqMCO03jCVT8BDNT5kTOuyTjOoiSOL8jlH+UOiCMfUK+TlGg3MBsdZkgMX2CopG3EZBG9Eukzas+9PKBzcM1HulJRRUNJb8I4rGbNyMz5NHdPliZVnQT+TIyLfuIbBXD1S9FQ5q
x-ms-exchange-antispam-messagedata: a++kkZiQcdooiK2A0/1Te0jnnCjl1wa1eQFuSrXvof28olnRYyg0GDlE2EXZBRgREXdhJIVLTrBiJhV4QPDXR5w/dEfS3J2lElEjA43Xm436RxhKjN9nUsUP/qeVJCX1GPJEtMhlrn3EiYV47ofQG79k7FHEG8Ttcithy7juz4Nqo0Ni9LC92ez++D14Zvv4Muj2rFHvDdAAGqmuvDF5ElqRU1J77ibfh3yQsH8O4HWLhSmryvoNP7RCKotQ5o7q8HgaMsFd9GQwDPNsB7I84AU6nfIlmacSk6JAmB4x31GIwtEkYPdYipfABUlqhiTk1ShS0XuKvlctIsLZ32sbJMMsGfSbyuafXJe3D3ep1yoMeJZ02vUSdQeaGXYzcst6ZyD+p92rmn4G9c/K66/i5uwB9PJuqYz56sjk9DWa07L6+VqYF9RKmL8mE1V4FFyBV90ZKOxDpDpab24HO9+zUi6G/0m6cCnFiTnET+of9COBcvNQPdRqXoyHW/jfVWZ0xrJb+zotsZs5DRSSwICdRxcQ7+qbjejHUluTP9V6faJQwX7YliaZT96wJ27X1hj+AU1kuFNGgm5DxmmAat/dWMOBQlBtpt0Cuepdg5umj1NBmwqpbRu4uHy/bpHNKWGo6Hb31Pk82ZxcbWRFY8hQTkcdd0KmaBkxckwHSTU5md/2XATomF3bsUFmz6LhmMRPaekn4o61IrM6IxOQ4BsOqoQtnaizcgd7UvO04dT1A8B99ERK2tagwyRdfWPtNmURmFpXZO4gUsddmOY+u8JEH7LCny5p09g/nX2O667wFuw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <52A8268B72835147B41A702B7B7AA228@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371f0a9d-2cf3-4469-f114-08d7ebdf726e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 01:48:42.5077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yY/VjBXIstg5sS7HgvrQ/ArAkjvMbjh+avqPg9vRdKEfRQwtZIsqS4UMgKquHpXyoHjETNKXiiQ+v7A9UT26Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAtMDQtMjggMTY6MDI6NDEsIE1pY2hhxYLCoE1pcm9zxYJhdyB3cm90ZToNCj4gT24gVHVl
LCBBcHIgMjgsIDIwMjAgYXQgMDI6MzM6NTlQTSArMDgwMCwgSmFzb24gWWFuIHdyb3RlOg0KPiA+
IEZpeCB0aGUgZm9sbG93aW5nIGNvY2NpY2hlY2sgd2FybmluZzoNCj4gPiANCj4gPiBkcml2ZXJz
L3VzYi9jaGlwaWRlYS9jaV9oZHJjX3VzYjIuYzo3NToyOC0yOTogVW5uZWVkZWQgc2VtaWNvbG9u
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24gWWFuIDx5YW5haWppZUBodWF3ZWkuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9jaGlwaWRlYS9jaV9oZHJjX3VzYjIuYyB8IDIg
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfdXNiMi5j
IGIvZHJpdmVycy91c2IvY2hpcGlkZWEvY2lfaGRyY191c2IyLmMNCj4gPiBpbmRleCA5M2M4NjQ3
NTkxMzUuLjg5ZTFkODJkNzM5YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9jaGlwaWRl
YS9jaV9oZHJjX3VzYjIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNf
dXNiMi5jDQo+ID4gQEAgLTcyLDcgKzcyLDcgQEAgc3RhdGljIGludCBjaV9oZHJjX3VzYjJfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgDQo+ID4gIAlwcml2LT5jbGsg
PSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoZGV2LCBOVUxMKTsNCj4gPiAgCWlmIChJU19FUlIocHJp
di0+Y2xrKSkNCj4gPiAtCQlyZXR1cm4gUFRSX0VSUihwcml2LT5jbGspOzsNCj4gPiArCQlyZXR1
cm4gUFRSX0VSUihwcml2LT5jbGspOw0KPiA+ICANCj4gPiAgCXJldCA9IGNsa19wcmVwYXJlX2Vu
YWJsZShwcml2LT5jbGspOw0KPiA+ICAJaWYgKHJldCkgew0KPiANCj4gRml4ZXM6IGMyZGUzN2Iz
MWYxNyAoInVzYjogY2hpcGlkZWE6IHVzYjI6IG1ha2UgY2xvY2sgb3B0aW9uYWwiKQ0KPiBSZXZp
ZXdlZC1ieTogTWljaGHFgsKgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5wbD4NCg0K
QXBwbGllZCwgdGhhbmtzLg0KDQotLSANCg0KVGhhbmtzLA0KUGV0ZXIgQ2hlbg==
