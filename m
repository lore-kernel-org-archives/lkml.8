Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E918DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE58520708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B7v/0Dll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgGICjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:39:45 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:34208
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgGICjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:39:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROMghEDv0f1t2iawSpQf4MZIzHMllbbWgZ3D/DaPzK7tembCw51gm5THzt8AI6F02FXLTDw4Suo2bhn+O0A1J6zg1sQGcWYWHt3vyR74UBfhU0tBgUAhMFGhubakzk9N10yQiE2BJmwio1bGdkdQwffH0K3iG7DvyW5mJ1q+Ax8tYDaoSqDBSs3ArNGiyq7oJo+ObVm0FwjmofDBsmBzbmkh43MZWaKQC9i65WUjkKTBm7+yGzoMB8CHjVUFgiDkonzFkBgIJ9KZ5JnCfyLOPXB2D9+CrDwWjr+XWcJy3DBWB3YPYj3ytRGFSsaNdks1hVGwbVuUtmS6xmVTybtGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OC+DHCEexbllwwPtg6EVmMTnTV12TI14aAofoDIRkI=;
 b=EmH1HG8Vx8UKcKqBtviqhlN1NNrBKXZe3OnCDDeWN3AcF/0/qDswKz/3RmVOTQPphXH1rBxRgNjxe3i2R64hi78nQ5Rj2xfOvb64ZwthWIRF7WDGuBSx/MI3zVO6gfVbWgMelF+NWPTTuw99BUO6mzvygoRJXQzAjShC4Y3wlpwXlRz00WgCVR7AM03rf4fMtqD8IryLYN1LkH7nrD7fzFRcjBn62FArO/Lwb1bxnaYx6pYry1d/79UbN767eqBTY8aNkQpPSGyUheyUjVhCfY4LSlD4y7nB/NEwF4H6XiH8RhvSjAr+kXOpB44NolwfLylGVpjm1+05t9LQ8VPoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OC+DHCEexbllwwPtg6EVmMTnTV12TI14aAofoDIRkI=;
 b=B7v/0Dll2883ARHDR1kX4YLetJ4ueTdeh5KpdR42xokXzhsH+tggBKbcnT0vyrKiaLrTM0tzljnlWXa9X4oDBIj3TTSnYw4/GSCHSEOYz4ZAlhGNVNbYXxBkUWoFTTyzNdkRwDJjcsv2W5ZA4wKx/0Y3xKR+Oc5ZOETvItn3ubg=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB4224.eurprd04.prod.outlook.com (2603:10a6:803:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 02:39:40 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f%6]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 02:39:40 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] ARM: dts: imx6qdl: only enable pcie in the pcie
 dts file
Thread-Topic: [EXT] Re: [PATCH] ARM: dts: imx6qdl: only enable pcie in the
 pcie dts file
Thread-Index: AQHWU3Igl6ZQhSqen0CLQpF16fim6aj9+TYAgACTDXA=
Date:   Thu, 9 Jul 2020 02:39:40 +0000
Message-ID: <VI1PR04MB585301AD58A2B68C855EA10F8C640@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1594025081-2353-1-git-send-email-hongxing.zhu@nxp.com>
 <CAOMZO5CGDzzADq6yC1FMStc1ZcuLS5mVahf_EOe1RNfdki9+Jw@mail.gmail.com>
In-Reply-To: <CAOMZO5CGDzzADq6yC1FMStc1ZcuLS5mVahf_EOe1RNfdki9+Jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf78ec8d-f39c-4e1b-7b89-08d823b15456
x-ms-traffictypediagnostic: VI1PR04MB4224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB42242EB809A2E3EA728B158C8C640@VI1PR04MB4224.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qUuvOHa/J+pURBWaQX6rLyuVF8PaqTnT8wh79KmZlJiHacieSZS2EjTvG6zqBXBP/q2A9Qaf9HbIyxMq+xTCe8bNkSGnBSEpZsNhqBokFnJSXYLjpcIBtkvN9rQzurCJs7LuZydkHo+wozK1ymh+zkPX5JTJn8eobPyy1d0MH5DdtG0cIxCByUWA7Kzm6UfztalUxUKDytoGurvZctIobdyq362I0O1GHy3mTttgJIoCYTFKqNVaPUr5T8HDpa1ORDLqIRDW+Cx4Jtzyhb5Z2lYrW7T6VmFl/JfWiPteTYx3p3zqUvFD7VpLGtR+vwzcGHEfbx/ivXsNCaNaoE7fpaOpVPp58YF5VSaKIEbYdJf5bfv29WSxqnlR4/F3HFAARFe+ngKegc5XVlZm3aa3xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(186003)(478600001)(2906002)(55016002)(9686003)(54906003)(6916009)(7696005)(4326008)(316002)(8936002)(71200400001)(4744005)(83380400001)(33656002)(8676002)(26005)(6506007)(53546011)(86362001)(52536014)(5660300002)(66446008)(76116006)(66556008)(66476007)(66946007)(64756008)(32563001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dWO/05Op3i4ZGpqC4J3/zCA7snIw0n0GAgaS9zZKXgYQbWFP5svMM/gFPSwx7i4vzaKzzvwkhqZ/mh/JaBPuevDScS+KIw1BpoiX0EnjGLjPqy6mqy2I8pR489eX48YnR5MmJy8O2V8tGH3XBlBGCJw2l+2XrsrultOfUV0xNINgeMmAwuCskslf4aKlKzC8A6f+OdOICYowMdf/smSSBtb/AVJFAMLh9wksA4hdv/9T1m/5upjdMFKInpvGU/wSdFleDRalR8co25F3BqCmwE79tIT2kdY+eL/myl7nzUnMnOGTpP6GgJzez4soetzL2qeAOOl4CQcmrzU3ckSczEO5JRunbj+32oHhnQKAQpNUbnOH6X/eBQIdUdbB58a+HwvKYTHY3IWGepMYhoJZrVLjP79wG8Rw/oiD8ITJOZRlUib9lZwwyzUOVVTnYwWfeIhGq0LK2GBpYnAe2qw/vsJBFnYKEOLFEkez1BelZok=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf78ec8d-f39c-4e1b-7b89-08d823b15456
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 02:39:40.2813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2n28Vu4OZoCLNDafXGLw7/6ScDE1KEyzf86ES+QolPHGtWgfWlSZGf1KF1485Ubni9ElqIdO6f6pHOvvYipzOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjDlubQ35pyIOeaXpSAxOjQ5DQo+IFRvOiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gbW9kZXJh
dGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRQ0KPiA8bGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgta2VybmVsDQo+IDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IGR0
czogaW14NnFkbDogb25seSBlbmFibGUgcGNpZSBpbiB0aGUgcGNpZSBkdHMNCj4gZmlsZQ0KPiAN
Cj4gSGkgUmljaGFyZCwNCj4gDQo+IE9uIE1vbiwgSnVsIDYsIDIwMjAgYXQgNTo0OSBBTSBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gU2luY2UgaU1Y
NlEvREwgUENJZSBoYXMgdGhlIFBNIGxpbWl0YXRpb24gKEVSUjAwNTcyMyAiUENJZSBQQ0llIGRv
ZXMNCj4gPiBub3Qgc3VwcG9ydCBMMiBQb3dlciBEb3duIikuDQo+ID4gU3lzdGVtIHN1c3BlbmQv
cmVzdW1lIHdvdWxkIGJlIGJyb2tlbiBieSBQQ0llLCBpZiBQQ0llIGlzIGVuYWJsZWQuDQo+ID4g
T25seSBlbmFibGUgUENJZSBpbiB0aGUgeHh4LXBjaWUuZHRzIGZpbGVzIHRvIGF2b2lkIHRoZSBi
cm9rZW5zIHdoZW4NCj4gPiBvdGhlciB4eHguZHRiIGZpbGVzIGFyZSB1c2VkIG9uIHNhYnJlc2Qg
YW5kIHNhYnJlYXV0byBib2FyZHMuDQo+IA0KPiBXZSBoYXZlIHNldmVyYWwgaW14NiBkdHMgZmls
ZXMgdGhhdCBjdXJyZW50bHkgZW5hYmxlIHBjaWUuDQo+IA0KPiBDYW4ndCB3ZSBoYXZlIGEgcHJv
cGVyIHNvZnR3YXJlIHdvcmthcm91bmQgZm9yIHRoaXMgaXNzdWUgaW5zdGVhZD8NCj4gDQpIaSBG
YWJpbzoNClVwIHRvIG5vdywgdW5mb3J0dW5hdGVseSwgdGhlcmUgaXMgbm8gc29saWQgY29uZmlk
ZW50aWFsIFNXIHdvcmthcm91bmQgZm9yIHRoaXMgaXNzdWUuDQoNCkJlc3QgUmVnYXJkcw0KUmlj
aGFyZCBaaHUNCg0KPiBUaGFua3MNCg==
