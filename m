Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E3BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CAE20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NqQ3zNWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgCCNXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:23:24 -0500
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:58981
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728591AbgCCNXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:23:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUWO8VPqa2QMmCafOzbB8wjK/6nnB1ShtlpcjH9k+9YfzPLW22FWLwhmsPwLX0KnLQs4i7ViqyHCWp6tGbLtiKlbPBargdlK+DeY1tM2Uc5SlHQr/du99Sb4GrhwQs+iY3Kfo/uw85840/MxBkfMc7BClN50Ugjq2pRc3+19CRv+7gFw12ggfaDLfF8LaO20/3ax5rd6UlLfBQpNYuqocm4fRjrjWS9v1GSzdcid7iulUklj9Mq4WoBo42SpehUNhZO4DGwMpKTxpcW5ebEXfsniIU58m/DT/nAeZiqlKKiEYcThQbt2CoHlPLuLqeHXbL6qa/0jb0ccxvMNFaMHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOwzm0AxXLInIcX+4YSH+9FOpz9/IOAQbRIe73v2tqs=;
 b=WkB+NwGMjPJVD8S1IAUnGIHmDJsRKn2FRwxZ/U7Nd/DbAGiTez8bxZKSDJiKTmskgrt62aOICpnEJqQkImSrdbibeBucLkjfQc/vAj0st7/E1iiNr8FwYGBdXvYZF9/RXB2M+F+ONWS1ncsdF1fOU1z+OoxNS6mRadYwn81XdDOf8GFFLWKjrcMrmPCk4HigfFrmRyFKFZ1SU4VirRs/bmVBFq61uxeOXu2YrOSbBHPbgy5eL0a8w0uoXUvVRVh8qTHCu63zYH2mEmjJbDA1kZdAhiwFRlXQqGe3s2hTB0yIEyi1OkMO8NW0zweZpL0QqQkWLk2C2ytgjK9hgS4zzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOwzm0AxXLInIcX+4YSH+9FOpz9/IOAQbRIe73v2tqs=;
 b=NqQ3zNWRj9Di+qI9NzN561zGLl/ZDSrae14Hd0hu6sLOJaPAJk7rEBNs54/UlJEZ+DyKf0AK/rAq/f0UUa/yf0l9Eo0ft9glnE5LYeT29DeqIirMqV4+hAnyGUcuXfbuCHpda1TIkJg5XqyutnzvjiBZjwFQ+dQoRWahbeLlIwg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3868.eurprd04.prod.outlook.com (52.134.71.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Tue, 3 Mar 2020 13:23:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 13:23:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] regulator: anatop: Drop error message for -EPROBE_DEFER
Thread-Topic: [PATCH] regulator: anatop: Drop error message for -EPROBE_DEFER
Thread-Index: AQHV8QquCOAMTSU+80CJNiONhxviQ6g2zOAAgAAKHvA=
Date:   Tue, 3 Mar 2020 13:23:19 +0000
Message-ID: <DB3PR0402MB39166725152B1B076E035F8EF5E40@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583205261-1994-1-git-send-email-Anson.Huang@nxp.com>
 <20200303123010.GB3866@sirena.org.uk>
In-Reply-To: <20200303123010.GB3866@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc27189d-c4b4-416a-11a6-08d7bf760a81
x-ms-traffictypediagnostic: DB3PR0402MB3868:|DB3PR0402MB3868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3868F2F90F6BBCBE8CC1E350F5E40@DB3PR0402MB3868.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(52536014)(5660300002)(54906003)(8936002)(81156014)(81166006)(4326008)(478600001)(2906002)(8676002)(316002)(33656002)(7696005)(66446008)(64756008)(66946007)(71200400001)(15650500001)(186003)(6506007)(76116006)(26005)(86362001)(44832011)(66556008)(9686003)(66476007)(55016002)(4744005)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3868;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvD/CT8kBUe/5kaXKSvZAnUAL1j6wZr/4tAelL3W3zh/6wzy7rWJ8g800oe6Lg+dIr14wcWhcDG7VIDvIoAAOajLxLSqSh/XMV1kXFoVJzueIDH92RyCaZJTVmLQAeMJCeF2+iVRliHwDEO0AM9zJlS54uDGQa4HruOajF6gYhEx4QRHdvTbSlV3Pk84Lk9VJ/7W8IET5P5zuad04IJutoKbXT31QXAhqmhXBf4JHs+9wn/8KXuhG8KhOj+bnvhWtY9V9D2To3zrmmbWjDm6Fl5OfQ1bwHKRq8viGyV5KTw1csh/ddCulZbJFXZ0ndviT9JktleBFjuQs9ppFu4lLJDJ5YzXY9FtRQacWA9cN/tITrPIKW46uQVXP6k8ne6qm9e2gkJuspp8gm30cAxazG3FwYa/rSaJ1MvGEerQ0Njbp1cj5Alpxr15sKhFa8XB
x-ms-exchange-antispam-messagedata: 4u/OF/6aAUNQuGlwqud9ZD5N5qSR0MoIPOjg0MTmY06HiQPzl8peVcAOQjHUj7BXlxr5ODejf/+zvlqEzBmZlqF1cpdbYDucUETV1y+17ADbRUPco492NNUjA/QaYv3KRJY9ZYxzDRPqm7K4YgJ1Rw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc27189d-c4b4-416a-11a6-08d7bf760a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 13:23:19.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M30bR5EPid6zUamXRf3nXcX4NhzBfXxUwjDoUEqNUgWXxOrUKY9r4OnoO1RG2QfFi3bauV6S7c3BJoWaasA+yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmsNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSByZWd1bGF0b3I6IGFuYXRvcDogRHJv
cCBlcnJvciBtZXNzYWdlIGZvciAtDQo+IEVQUk9CRV9ERUZFUg0KPiANCj4gT24gVHVlLCBNYXIg
MDMsIDIwMjAgYXQgMTE6MTQ6MjFBTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gZGV2
bV9yZWd1bGF0b3JfcmVnaXN0ZXIoKSBjb3VsZCByZXR1cm4gLUVQUk9CRV9ERUZFUiB3aGVuIHRy
eWluZyB0bw0KPiA+IGdldCBpbml0IGRhdGEgYW5kIE5PVCBhbGwgcmVzb3VyY2VzIGFyZSBhdmFp
bGFibGUgYXQgdGhhdCB0aW1lLCBmb3INCj4gPiB0aGlzIGNhc2UsIGVycm9yIG1lc3NhZ2Ugc2hv
dWxkIE5PVCBiZSBwcmVzZW50LCB0aGUgZHJpdmVyIHdpbGwgY2FsbA0KPiA+IHByb2JlIGFnYWlu
IGxhdGVyLCBzbyBkcm9wIGVycm9yIG1lc3NhZ2UgZm9yIC1FUFJPQkVfREVGRVIuDQo+IA0KPiBO
bywgdGhpcyBpcyBub3QgZ29vZCAtIGl0IG1lYW5zIHRoYXQgaWYgdGhlcmUgaXMgc29tZSBwcm9i
bGVtIHRoZSB1c2VyIHdpbGwgbm90DQo+IGdldCBhbnkgaW5mb3JtYXRpb24gYWJvdXQgd2h5IHRo
ZSBkcml2ZXIgaXMgbm90IGluc3RhbnRpYXRpbmcgYW5kIGhvdyB0byBmaXggaXQuDQo+IEF0IG1v
c3QgbG93ZXIgdGhlIG1lc3NhZ2UgdG8gZGV2X2RiZygpLg0KDQpNYWtlIHNlbnNlLCB3aWxsIGxv
d2VyIHRoZSBtZXNzYWdlIHRvIGRlYnVnIGxldmVsIGZvciAtRVBST0JFX0RFRkVSLCBpdCBpcyBq
dXN0DQpiZWNhdXNlIHRoYXQgdXNlciBldmVyIGNvbXBsYWluZWQgYWJvdXQgdGhlIGVycm9yIG1l
c3NhZ2UgaW4gbm9ybWFsIGxldmVsIGZvcg0KZGVmZXIgcHJvYmUgc2NlbmFyaW8sIHRoYXQgaXMg
d2h5IEkgZG8gdGhpcyBwYXRjaC4NCg0KVGhhbmtzLA0KQW5zb24NCg==
