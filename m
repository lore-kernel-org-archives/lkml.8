Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B317C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3242073E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eFYra3M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbgF2VE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbgF2TMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9375C0149DE;
        Mon, 29 Jun 2020 01:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhQBOfTy7By6kbXinX7C/ck4uzFw7VSiiRe7dx6906awmCplIeoL20q9Ic5/1jwDlBXuBk+MDd3yOb22nRWttWetnLFue+06nthQS9WX/z4Ff/DcgYGACU5EweRsLxreDdTZGNgphGeA9U7K1V3fv0MH3bz7HmdfPf9R8Pb/Hm1BEgCnkUa+1+Cmkio//i57eTXahgHmn/kQSbEjfVlivYt6tvgrnZM/KwBUYXmC2HpfbqKd7Sf9LSs7Kll/reXfheV87YN0MJSWgINuCEqxjp7YCtXQGYJ16MxsrMIKqRQuXa9l2JIZVQ3U8UVl0tx+MPT1d+ztXAx6XC9nw8dQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvsE1BPZSFDZhV2i9t4Zift3VtsPgdnijLSL9nQ49vM=;
 b=hjMzo+2Pzy4YQaXhVd36SAKH0OjrIHE0rlVqlJ5vAjwp/hjOifK5vrRL7aaoNyNncvTfYDnggmr1IWRgT80r3qAgBbe0iR/VrflwuG/pmspVao44z8b1WeXA6xYv1T9YC9elzgaEz9YzC67RVCGs2r5xA+qQHHL3kKjizcZ+5QvLWTVHTyopVLu7AkvbWAoMORvbLsfvjktKnAV0hHzU/k2g6I0O7DNJaaSa/HDxh1nt7k8IvkMG6zfx99FAa262AgRU7rxsbSLGmHgccinNbLBZax3NJE7YPPD3XujUxA6MVKJ/6JBYxvyAHniTbgW8HbtjzbzHBVaoGplR+q1CvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvsE1BPZSFDZhV2i9t4Zift3VtsPgdnijLSL9nQ49vM=;
 b=eFYra3M8ZhNQy7th5+kKm032IqohaDgf+Gt4gdgQxECciAIcJw19sXdTVwvxIhFqoz8i4ftan7JOz34DEoce2cJk5RwVioxWa0w3bl26Lj5hdHL9WgFxOeH/Ir/dmsErnv1G9GYhQdCjOMNFeetUME2HhNRje1ASeXo27uheIog=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR0401MB2536.eurprd04.prod.outlook.com (2603:10a6:4:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Mon, 29 Jun
 2020 08:21:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 08:21:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 03/10] ARM: imx: Select MXC_CLK for each SoC
Thread-Topic: [PATCH V3 03/10] ARM: imx: Select MXC_CLK for each SoC
Thread-Index: AQHWTdtgkkz4NNv7RUGPqd2huY8+RKjvMd6AgAAOKdA=
Date:   Mon, 29 Jun 2020 08:21:46 +0000
Message-ID: <DB3PR0402MB3916A4DF80C182319F79BB21F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-4-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49662FB8227AEE678F55C116806E0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49662FB8227AEE678F55C116806E0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19265e99-7dca-4b68-5bbb-08d81c05772c
x-ms-traffictypediagnostic: DB6PR0401MB2536:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2536B78F710901C904AEDC11F56E0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++/cJ8aOBRKXpH3ztRGJVAZ09rhX1+zNE3lXAgLGYcBR/567M1+ni5J/8egu9x+aLXXGP2HWvADmovp8KkqML+nspKDbT9/BOzumUKw6KtCf6xo3r7fh2ZvPm3kmTC0uMkO3KE27O76MxGwYAVCWxywtB51aFLWVmBVNPmdQR65LiJM44pz0LErnC+/aINjBQ57XxCgACNJd7TfJOalkKGnicT/I/2ORkbE6AALsLwaxpzSc/0ESTNNCoaWRM9hi830Qj8c+HY9n/amA7l2Uxxju+rFHUIwjQTAAGsHMsoGRyyunDekr0lnt0n2k0AIX9LpxPDURBsy7jSqDt4Kj4l7ZxVo/PuEIuMttPtcpDFbEorSCTuTjxBZnKY9nm+4F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(71200400001)(7416002)(110136005)(76116006)(316002)(44832011)(66946007)(86362001)(66446008)(64756008)(66476007)(66556008)(2906002)(8936002)(186003)(33656002)(4744005)(26005)(6506007)(52536014)(55016002)(478600001)(9686003)(4326008)(5660300002)(83380400001)(8676002)(7696005)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FVGzgr/qCSyTEIo6XHWdAMjwIexbcmYexdU9YrU7Tr5x7XWX6djq/yyqFVdfiDSQYsnSqb3HgfNuiff+ks5a+Umb6n0fd2DL9jN1GO6OHCIdWmIfbQMH1XgDlD0t1FN8UbPNTR96GN5p6JO2fP1xGzX/O0o+7vIKzI1+X417HSfS0dGTxYrX8PfvO7hIZih4dyYKnafCWWm5CM2kBp4hqvWwjbDbcY82puPW7BWKWt4fcRZTWr3MkWQePhT5W0+gJl/GawUpbvwp/26qLYXC13ykmUFBH2thAq9mVX83Db21UYW1DYfJCbHKSXdWo37H6KLgEsuvzrjdXg9k2vH0/tod1kH/JPcs4/BsJiXmDUqr5G6z7J7tapF4y7NyuXPeATFzr9wYc2Hu5iWv7SbzrCbustfiDGMdTHIEIGhQKel9gzSLEp/t7ChALoEGkYjaSdld7sOMlYPJ8GGUsJSJ/vit7RDWZmEpXPrKDbExmHwOk2MzdMt3qho1ViZcGoX8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19265e99-7dca-4b68-5bbb-08d81c05772c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 08:21:47.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2CnRH42qYjqUdw5yde3FKY0NymUb6HRWfCWfkZ+W4ca9CYQ4y3OTSnztELPCfEkOIVhZWfSTKA5+Mki5A9p4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMyAwMy8xMF0gQVJNOiBpbXg6IFNlbGVjdCBNWENf
Q0xLIGZvciBlYWNoIFNvQw0KPiANCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIEp1bmUgMjksIDIwMjAgMTo1NCBQTQ0KPiA+DQo+
ID4gaS5NWCBjb21tb24gY2xvY2sgZHJpdmVycyBtYXkgc3VwcG9ydCBtb2R1bGUgYnVpbGQsIHNv
IGl0IGlzIE5PVA0KPiA+IHNlbGVjdGVkIGJ5IGRlZmF1bHQsIGZvciBBUkNIX01YQyBBUk12NyBw
bGF0Zm9ybXMsIG5lZWQgdG8gc2VsZWN0IGl0DQo+ID4gbWFudWFsbHkgaW4gZWFjaCBTb0MgdG8g
bWFrZSBidWlsZCBwYXNzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFu
c29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBWMjoNCj4gPiAJ
LSBtYW51YWxseSBzZWxlY3QgdGhlIE1YQ19DTEsgaW4gZWFjaCBTb0MgaW5zdGVhZCBvZiBzZWxl
Y3RpbmcgaXQNCj4gPiAJICBmb3IgQVJDSF9NWEMuDQo+IA0KPiBBbnkgcmVhc29uIHRvIGRvIHRo
aXM/DQoNCkZvcm0gdGhlIGRpc2N1c3Npb24sIGxvb2tzIGxpa2Ugc2VsZWN0aW5nIGl0IGZvciBl
YWNoIFNvQyBtYWtlIG1vcmUgc2Vuc2UsIGFzIHRoZXJlIGlzDQpubyBDTEtfSU1YKiBmb3IgaS5N
WDYvNywgb3IgYW0gSSBtaXN1bmRlcnN0YW5kaW5nIFN0ZXBoZW4ncyBjb21tZW50PyBKdXN0IHVz
ZQ0KcHJldmlvdXMgaW1wbGVtZW50YXRpb24gb2Ygc2VsZWN0aW5nIGl0IG9uY2UgaW4gQVJDSF9N
WEM/DQoNCkFuc29uDQo=
