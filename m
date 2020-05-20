Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A2A207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j1ZRFRcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgETJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:22:54 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:6029
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbgETJWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:22:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOMEmdfHnlUsZnvKCcHQmNrML8g1cJHxQwSDDzbkArpDpIHniUw3Z7N8bbmla7+gmS21zWpfCzAebzqfGr6dcRJlq1dxPOe+ouJZbMkxIuNXZO5hbV1Sr7jhWvPNb44C836484cqKzYjCueflGX0apxC2izRL+pXvrs0QSBTff4lxJgJR/bbs/VdUPZJ5ZtfiQFS5umx+bAsjadYqBdcRKM4f6iJ6rsi7LZ29qsJvr+v7DDdnw3I+sGYi7SkH1S2LSyzYTtXFwFnMkA8r6Dhcbkj8Qy1xZ/vPjgDPJ9euL5gV4gBeSnkuIhOZhJatdRq1mXKqnQLbfT+omaA1OXN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0y5MvQVEDiJ7MEMSHn2a09wJC3gJfWvzcrY4rnINjQ=;
 b=fU1S5UhxeXyd/duGImpQRkTvfysJ7UqcG/UuVCkvF+WyI18SZQd++mFyBsvaMWj5MpP/8QcF4sptDdauhBe/66e0vYyPd19mPovc2xaU+imLCiEDfp0Cr87SZgKtioC19yOEPGfX7KF/iXYBWZLR28qGQyiSiXLFnY8E1grRsWtkSXefvveIXbWzKH5ny3y4i1DX7yJG3iCgSrLSGDTjBkMkjWlA4cvq1zuE4edENa2oSw5tFgBcxsZOah9lAohMUDKVZyXxMiT+0IWjklfhcj5KjxvhVMKSp1nAXTpWtNEmQpc+bqwUQzrvfOLDPZCWmxLHredzo8fa5EoWDxqEgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0y5MvQVEDiJ7MEMSHn2a09wJC3gJfWvzcrY4rnINjQ=;
 b=j1ZRFRcyrAZYN6naY2bdBcGS6UmwcXfYjm4aP/ja0uPBAmhTq4dy3A0Ot8pKwGcFNWQ6QC9R325Lq8e5f3BuKr6P/orZflYY2F6zYH0DeP1Hv+VfSzSWN3ohcmBEV1zqDpt3EmWD7C1duX4CtVu25Y6nnL/DeyES9PrlcqPNeds=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 20 May
 2020 09:22:48 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 09:22:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Thread-Topic: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Thread-Index: AQHWLnGKahSSyBKEm0SO3VgjiRIl16iwl6BQgAABCwCAAASd8IAAAmqAgAATvdA=
Date:   Wed, 20 May 2020 09:22:48 +0000
Message-ID: <AM6PR04MB49665F56FA9FD8331F90D5B980B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589956216-22499-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49663B517C218072B2845DBF80B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167A0961963B73758F6CA9F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496661BDF6B5F966A218092380B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39161EA7B95886D56EB91E8BF5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39161EA7B95886D56EB91E8BF5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 021d004d-403e-4089-b2fa-08d7fc9f5d00
x-ms-traffictypediagnostic: AM6PR04MB6662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB66627920669990E89D2113BA80B60@AM6PR04MB6662.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BwJnJbmLSYVbpBwASvSsGEWWDv8Kj+xZyVk5N1Hlt3DPlM623uccc+Kc3bxdKpnT4XNboT7ox+JIy9Hu12bi3//2xBEbEb1wZycYgCJPQvvAzZYHKUzJq4LH+1RDoKDjym5ZbNYhZI85odKOiJMCzC9unxGPKZ7S74qKBH5vDaMR8Z5CS0P3DjhMFHXuAc8jzWoQJh/XdQAkT4lQpLxkNB/nph10007mTU3xkw66fBntMTE5PCVx9xOIIa/6+nwXOiV88YarBSa90X2xe0qwJOJApH2l9Rxlza7/Gg9M6K30Zs7L7Z4DJTPS4+KFOD3e28sNdtHU9RuK/RgDS2wHKotU2UICCij7BTyH5JF2rMTJaqUCxNv0hww0JIFP6shmFgjFDQcS3oYg1Uckgl3NfTxmh8b0lLNIxXEgj9WvK7khB+fuvHPpysfYOyFdWORv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(64756008)(2906002)(4326008)(8936002)(33656002)(52536014)(66446008)(8676002)(66556008)(66476007)(76116006)(55016002)(44832011)(9686003)(66946007)(6506007)(7696005)(71200400001)(26005)(86362001)(316002)(110136005)(53546011)(186003)(5660300002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NshwA9a/4UpX0obX/bKAVk+jOG6QuWr/QktCNKKaH8KXPpWRiYXTdggMvSfQUEN0L6Hy/xHu2xmDxSrmR3tdGswqiglRMpGYbz5jaT2ypKc6dpEGOquFarOEkKxoAdp8ftlgkltc+UfqjJe+aRRvd7iec5KwoZidAR8t+APPWhs0tSRZYlm3o2cxVEJBTH4jZbvllMcAbS00CPRPxmd9eIT+tIMXJfo4NKxoosKlB+VUjy/F/VFWU1RA5cdDfocjrS15yUcyo1qQoerkQhKKPL63pePGnSE6FPxgVekAPxDaOg/N3vk5TMDq6BwXAtKxcbUnk5LH0f4m6R7GScid4obqOsSMob/XxU2fIQECE1QlpjF80ksxHDBJRiP3+E6iVMn1pbWVy1zq3pGEy1YuDhzO2MaYUjP5/u/E3AJTlh31wOM9zyu3RIkTtZf1xWnsWERXXkYasXLIjXFuhS4JwSzqa2s3Tp7IBthEacty04WmW86N8YEb2Lsz6rGFbiFy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021d004d-403e-4089-b2fa-08d7fc9f5d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 09:22:48.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIppbuPyuDnSPQaCzN6aikAI/8tvJMG+SSISLt3N+m3vt2bglI/69dJKi0vIWnsalPxkxpKLpEA8KtPpkCw83A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXkgMjAsIDIwMjAgNDoxMiBQTQ0KPiANCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBB
Uk06IGR0czogaW14OiBNYWtlIHRlbXBtb24gbm9kZSBhcyBjaGlsZCBvZg0KPiA+IGFuYXRvcCBu
b2RlDQo+ID4NCj4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0K
PiA+ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjAsIDIwMjAgMzo0NyBQTQ0KPiA+ID4NCj4gPiA+
ID4gU3ViamVjdDogUkU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDogTWFrZSB0ZW1wbW9uIG5vZGUg
YXMgY2hpbGQgb2YNCj4gPiA+ID4gYW5hdG9wIG5vZGUNCj4gPiA+ID4NCj4gPiA+ID4gPiBGcm9t
OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4gPiBTZW50OiBXZWRu
ZXNkYXksIE1heSAyMCwgMjAyMCAyOjMwIFBNDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBpLk1YNi83
IFNvQ3MnIHRlbXBlcmF0dXJlIHNlbnNvciBpcyBpbnNpZGUgYW5hdG9wIG1vZHVsZSBmcm9tIEhX
DQo+ID4gPiA+ID4gcGVyc3BlY3RpdmUsIHNvIGl0IHNob3VsZCBiZSBhIGNoaWxkIG5vZGUgb2Yg
YW5hdG9wLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcg
PEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBEb25n
IEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBCVFcsIEkg
dGhpbmsgeW91IGFsc28gbmVlZCBhIGJpbmRpbmcgZG9jIGZvciB0aGlzIGNoYW5nZS4NCj4gPiA+
DQo+ID4gPiBUaGUgYmluZGluZyBkb2MgaXMgdGhlIGlteC10aGVybWFsLnlhbWwgSSBzZW50IG91
dCwgaXQgaXMgc3VnZ2VzdGVkDQo+ID4gPiBieSBSb2IgdG8gbW92ZSB0ZW1wbW9uIGludG8gYW5h
dG9wIG5vZGUsIHRoYXQgaXMgd2h5IEkgZGlkIHRoaXMNCj4gPiA+IHBhdGNoIHRvIGFsaWduIHdp
dGggdGhlIGJpbmRpbmcgZG9jLg0KPiA+DQo+ID4gVGhhdCdzIHRoZXJtYWwgYmluZGluZyBkb2Mu
DQo+ID4gV2UgbmVlZCBhIGJpbmRpbmcgZG9jIHRvIGRlc2NyaWJlIHRoZSBjb25zdHJhaW50cyBm
b3IgYW5hdG9wIGFzIHdlbGwuDQo+IA0KPiBhbmF0b3AgaW5jbHVkZXMgUE1VLCB0aGVybWFsIGV0
Yy4sIG5lZWQgdG8gdGhpbmsgYWJvdXQgaG93IHRvIGFkZCBpdCBhbmQNCj4gd2hlcmUgdG8gcHV0
IGl0LCB3aWxsIHRoaW5rIGFib3V0IGl0IGxhdGVyLg0KDQpXZSBjYW4gY29tYmluZSB0aGVtIGlu
dG8gb25lLg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo+IA0KPiBBbnNvbg0K
