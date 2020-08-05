Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FE1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4BE22CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jrMhH7Gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHETDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:03:50 -0400
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]:51262
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728541AbgHETB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:01:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0q+rNnVGpn4TN+tiLTcVrRyx+IqtgR797tEDYTYLUxZwzjq1VoYA5JaINJ4DaBGk20jM5OwCQGvU6J1SWOAPgWJldqNd9k3Z8Na1nqd2DsqJJ85ED6fmjrFM/iCCSU1rPBhY/8qdp8UEOMD9Zjdvl7357enbgIyuUxAKIzukbxCqwpiBw4r6NB9MsIYabHDH2f42DNuNUaVYf31ebUq6LuOkJorVBlK+mZwpM8dJ5l5NMcurPFDQcGlTH1Bqgk3z4Lw4iR0ttcAlyjf4LZjBCBbhO8hxKOZNkmIbcmhAxcXGJ+16+2H10c8cjJjFrJ0+YMqT9jhqmCy8hZs6om0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ0UuXA0B/P3jZ0oEItR0+FoOacBoKCh8V4DxqtmpTM=;
 b=g7hzQ1noBgXeDv8Hh+rJl4dWs54/JbqC2cILgJF+vxpP6VlfNUPD7rcWT0IJh2XsKs6hjnybXspLH8xrrZ1Sj4IBj0pGuHRaZF7tou2mQH9YvLwR6UJ8++3h7+bTCxv84+j2+wBF5fgPsUvrWf79YSutGTb/l9cTfKqtMOtD8PxYy0+jGsT8aWvSxifQ6eim7zucB1itgutKKHWgR5DHicRdQgNBPLIC/GAaWLFgsW7JF60ESFSh0iIvKqHEqPUklb86R5W+rPkS8JD5/lo+P8tQKwXfadhVRKXYcauTh8s3kzAiLTuXqZ3XYF0QtQMJUXzszVCZkRzZOT48goiHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ0UuXA0B/P3jZ0oEItR0+FoOacBoKCh8V4DxqtmpTM=;
 b=jrMhH7GzJScEzXR7QM9w/wx+z0ZJ6wsz0wb5WsqCAJ9NSljtUMTHW3b/oN2hB/iCPYXajzo7GM88so6y5uKTUgPQowvYcy5JpVrkvYrOw1AH84H7JHuUUvBY3apbbTHXww1rmBFP1w+XYbTR1EA71AMfrfmztFe+VicfDp9kVzo=
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com (2603:10a6:803:5e::23)
 by VI1PR05MB6591.eurprd05.prod.outlook.com (2603:10a6:803:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 19:01:53 +0000
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::2dde:902e:3a19:4366]) by VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::2dde:902e:3a19:4366%5]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 19:01:53 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     Eli Cohen <eli@mellanox.com>, Jason Gunthorpe <jgg@mellanox.com>,
        "mst@redhat.com" <mst@redhat.com>
CC:     Shahaf Shuler <shahafs@mellanox.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Thread-Topic: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Thread-Index: AQHWantUSBzq7a8TBEiYyqdYt1Lu16kpay6AgAALLACAAAI6AIAAA6kAgAADEwCAAGF3gA==
Date:   Wed, 5 Aug 2020 19:01:52 +0000
Message-ID: <063f66418da235ee459b367c5049948ee6db59ce.camel@mellanox.com>
References: <20200804162048.22587-1-eli@mellanox.com>
         <20200805075856-mutt-send-email-mst@kernel.org>
         <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
         <20200805084604-mutt-send-email-mst@kernel.org>
         <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
         <20200805090304-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200805090304-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4 (3.36.4-1.fc32) 
authentication-results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [73.15.39.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16e148a5-ea84-4e8e-0ccb-08d839720427
x-ms-traffictypediagnostic: VI1PR05MB6591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6591BDF2ACB4C00C7E790B06BE4B0@VI1PR05MB6591.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FuuKhSwQCfM+HxFXK1uzvM3UIh/fOoZjxOXSvK4UcYULlQXRo1yFUSEORb5FSGrZt/edEuogPKqbhQPqtL8Nrusv6+hFYQ2XA5yCurP8MJaBPJd3NGP/Pkg0KB5O1TQkSRVx7RpC25LW3rgW2mTKaZS5u44M2rxhF27PjxzG7ZhdWNCJEBSEj9MFzLd3z6xWeRa+UGRmOAhdomK+/Zv9m2dG1o/pCX0UlPITjp8ILB+f+AX/h28DhJJJY2FeANHW2pItCW1+hHtm9nE4r1KopYsTg3CYehDnRCfHU0Uceh4fNP0BsUxDvWqzbOuUgxIaXL1+KIHx8qiBslCLTHXZqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB5102.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(478600001)(64756008)(66476007)(91956017)(6506007)(66446008)(5660300002)(8936002)(4326008)(76116006)(66946007)(66556008)(26005)(71200400001)(186003)(6486002)(8676002)(6512007)(36756003)(83380400001)(2906002)(2616005)(107886003)(110136005)(54906003)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fxHluJ0U8KLREBEwZfrzzrYnAUE26jA5r+0yECv0guvTRdbeK0VD0PChAJXHIi9PThJ2XadFOq4byrhxRC8zi+T0xFsNZkgqQxcc4QXldfESiYYFqNZ0z/kW+dmDmWl9RKyx+Ye3IqV1bYXsMs28Lpgqp1iCcYR8tnPA3iPqoiVK7hxiVSJ40+wGKIZ4KjJe3RHxzBiH4cdJuTDLxrqqQJDuz2viy4fx7DLHfWOE0NmbzeFV6fMc/cvHwkRjnNhZKfNxyqgcwQPOem/jkgTTBDHUGELoVyL7COx8vXzhyFReTCWp4GCXR0PQI14pRgAfLqQx1TO4LLQrEhKdex/HNrPgoGQwm49VnPLpQdbmlfx6NBnuaX53ELF0QAjh4Fpdc/v8gO6Q7PBIAAy0RTL9VyG2WUIEdjS3v9Mz1PVTfv81DYh8qmQlyHs2eGxX0z93fJbYkUBjMWQms+JbHL5GLW/psCB6OQdX3jQF4dVZfUAH3slz765luNZLnZF5C6N2ZNfobRx8lxMpBA5z9ZBl2IqUqWz9fWFyXkNsBSCjUaKYkPidw6+Y7mouFmHu4pJpt2QlLfs5XH6wg8HvKsPKw4MMuYJj2Y/H0uqYyRqvothCHmIubj5WiQREhGIt1fM9mLSBmkvT+Hr2zuraTKR0nQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7847450D4DD7E47AA98320776D669ED@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB5102.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e148a5-ea84-4e8e-0ccb-08d839720427
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 19:01:53.0488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPOuybNTsM+rV1urIpyoYHy9P6xRWUMB3D+AmM3+Qj+5hzfCtQk/W6olb1sGYprxQlnUoS51q5dJ4YW3+fqt9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6591
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA4LTA1IGF0IDA5OjEyIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIFdlZCwgQXVnIDA1LCAyMDIwIGF0IDA0OjAxOjU4UE0gKzAzMDAsIEVsaSBDb2hl
biB3cm90ZToNCj4gPiBPbiBXZWQsIEF1ZyAwNSwgMjAyMCBhdCAwODo0ODo1MkFNIC0wNDAwLCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ID4gPiA+IERpZCB5b3UgbWVyZ2UgdGhpcz86DQo+
ID4gPiA+IGdpdCBwdWxsDQo+ID4gPiA+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9tZWxsYW5veC9saW51eC5naQ0KPiA+ID4gPiB0IG1seDUtbmV4dA0KPiA+
ID4gDQo+ID4gPiBJIGNhbiBvbmx5IG1lcmdlIHRoaXMgdHJlZSBpZiBubyBvbmUgZWxzZSB3aWxs
LiBMaW51cyBkb2VzIG5vdA0KPiA+ID4gbGlrZQ0KPiA+ID4gZ2V0dGluZyBzYW1lIHBhdGNoZXMg
dGhyb3VnaCB0d28gdHJlZXMuDQo+ID4gPiANCj4gPiA+IElzIHRoaXMgdGhlIGNhc2U/IElzIG1s
eDUtbmV4dCBnb2luZyB0byBiZSBtZXJnZWQgdGhyb3VnaA0KPiA+ID4gbXkgdHJlZSBpbiB0aGlz
IGN5Y2xlPw0KPiA+ID4gDQo+ID4gDQo+ID4gU2FlZWQgTWFoYW1lZWQgZnJvbSBNZWxsYW5veCAo
bG9jYXRlZCBpbiBDYWxpZm9ybmlhKSB1c3VhYWxseSBzZW5kcw0KPiA+IG91dA0KPiA+IG5ldCBw
YXRjaGVzLiBTbyBoZSdzIHN1cHBvc2VkIHRvIHNlbmQgdGhhdCB0byBEYXZlIE1pbGxlci4NCj4g
PiANCj4gPiBJIHRoaW5rIFNhZWVkIHNob3VsZCBhbnN3ZXIgdGhpcy4gTGV0J3Mgd2FpdCBhIGZl
dyBtb3JlIGhvdXJzIHRpbGwNCj4gPiBoZQ0KPiA+IHdha2VzIHVwLg0KPiANCj4gQWx0ZXJuYXRp
dmVzOg0KPiAtIG1lcmdlIHZkcGEgdGhyb3VnaCBTYWVlZCdzIHRyZWUuIEkgY2FuIGFjayB0aGF0
LCB3ZSdsbCBuZWVkIHRvDQo+ICAgcmVzb2x2ZSBhbnkgY29uZmxpY3RzIGJ5IG1lcmdpbmcgdGhl
IHR3byB0cmVlcyBhbmQgc2hvdyB0aGUNCj4gICByZXN1bHQgdG8gTGludXMgc28gaGUgY2FuIHJl
c29sdmUgdGhlIG1lcmdlIGluIHRoZSBzYW1lIHdheS4NCj4gLSBleHRyYWN0IGp1c3QgdGhlIG5l
Y2Vzc2FyeSBwYXRjaGVzIHRoYXQgYXJlIG5lZWRlZCBmb3IgdmRwYSBhbmQNCj4gICBtZXJnZSB0
aHJvdWdoIG15IHRyZWUuDQo+IC0gaWYgU2FlZWQgc2VuZHMgaGlzIHB1bGwgdG9kYXksIGl0J3Mg
bGlrZWx5IGl0IHdpbGwgYmUgbWVyZ2VkDQo+ICAgZWFybHkgbmV4dCB3ZWVrLiBUaGVuIEkgY2Fu
IHJlYmFzZSBhbmQgc2VuZCBhIHB1bGwgd2l0aCB5b3VyDQo+IHBhdGNoZXMNCj4gICBvbiB0b3Au
IEEgYml0IHJpc2t5Lg0KPiAtIGRvIHNvbWUgdHJpY2tzIHdpdGggYnVpbGQuIEUuZy4gZGlzYWJs
ZSBidWlsZCBvZiB5b3VyIGNvZGUsDQo+ICAgYW5kIGVuYWJsZSBpbiBTYWVlZCdzIHRyZWUgd2hl
biBldmVyeXRoaW5nIGlzIG1lcmdlZCB0b2dldGhlci4NCj4gICBDYW4gYmUgc29tZXdoYXQgaGFy
ZC4NCj4gDQoNCkhpIE1pY2hhZWwsDQoNCldlIGRvIHRoaXMgYWxsIHRoZSB0aW1lIHdpdGggbmV0
LW5leHQgYW5kIHJkbWEsDQptbHg1LW5leHQgaXMgYSB2ZXJ5IHNtYWxsIGJyYW5jaCBiYXNlZCBv
biBhIHZlcnkgZWFybHkgcmMgdGhhdCBpbmNsdWRlcw0KbWx4NSBzaGFyZWQgc3R1ZmYgYmV0d2Vl
biByZG1hIGFuZCBuZXQtbmV4dCwgYW5kIG5vdyB2aXJ0aW8gYXMgd2VsbC4NCg0Kd2Ugc2VuZCBw
dWxsIHJlcXVlc3RzIG9mIG1seDUtbmV4dCB0byBib3RoIHJkbWEgYW5kIG5ldC1uZXh0IHdpdGgg
dGhlDQpyZXNwZWN0aXZlIGZlYXR1cmVzLCBleGFjdGx5IGFzIHdlIGRpZCBoZXJlLCBhbmQgaXQg
d29ya3MgbmljZWx5LCBzaW5jZQ0Kd2UgcmVkdWNlIHRoZSBudW1iZXIgb2YgY29uZmxpY3RzIHRv
IDAgYmV0d2VlbiBkaWZmZXJlbnQgc3Vic3lzdGVtcw0KdGhhdCByZWx5IG9uIG1seDUgY29yZS4N
Cg0KYWxsIHRoZSBhbHRlcm5hdGl2ZSB5b3Ugc3VnZ2VzdGVkIGhhdmUgbmV2ZXIgYmVlbiB0cmll
ZCBiZWZvcmUgOiksDQpuZXQtbmV4dCBpcyBDbG9zZWQsIHNvIGkgY2FuJ3QgZG8gZnVydGhlciBz
dWJtaXNzaW9ucy4NCg0KDQo=
