Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBCAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718B820663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GPg8M8ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbgF2Uwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbgF2TN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:26 -0400
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03on061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0a::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC807C006949
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu1fv+Pt3jwO+trrjyVyc5wfa+0QwP3+wn7DxRhHwhDNe+VI9y9uVCrpftym7i3GvdMWIgBeCT9g3B6CwDR7j0DzkARg8e9l6UdgpUi2pvVj9A4lphmZnJXduGbGkWSFoj+1rnjqJnevu3qnp1kmz+a3VeLuaDIoZYLCFriXPkFV5E5h7So4SREmr2JB7hyBxucQBE5uROZDGw2FC2ftirlKKemCv0OnBX9YEBiLaqUjwVMXbcgCTefdLXImVfU3VUY0mwlFDHbt9cNf4mKgYi7/iQ7E6WpP8Z3HxaVovWv5aewjxtpOWvz+8D6jr9iwA6x/TtIjUYIpJZamEG+X2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr1GqtYKj9+krEEsD0d0j5JAZN4oqIk6/eWsD+JhSlo=;
 b=Zk3FTl7SBkB854vs8uz5J7hOzithC6Lt2ejgKorhGeaojDO9UHIijMG35SZ92HUG7o9m1lBk7q5Xx7/WhNUWbIzMuPkwZhsjiJjf6O7kPNAimJz3tPnOC3FDN47QPMQneeVu3h0eEExrERAOzX5j6acp/6PYa4AiuCxNVTvUO9nErh8MPT9HrlBWkeVr2QmlU4cV6e5LhAGg81Q8KVJmtbHOT7e754WXRRNghBpjVuWxJSDWEWpkzaz6oQ2dhahOatrbYfu/18ASx8MDPlZn+rrEipTOVfwir2GCDpRhDC24sZ55e31YYOqvFjJS2SFjUkowxRWcriJBhu1mVV1c3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr1GqtYKj9+krEEsD0d0j5JAZN4oqIk6/eWsD+JhSlo=;
 b=GPg8M8ymlZVe0NsT3IcEpD9z1tHL+s52D4Vk/75Ksfh95Wyl9nT7mX0tewLoeFNJtUQGl7KRhVMLAgqmKMX+AA8fL1U42MTjZZyh6LBWfLf7SHUp40Xz49+jGmojuoZD2Isjd92ZGftF9wv13Fs0fVInBKapTiexVLY7tbmVdVo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB6860.eurprd04.prod.outlook.com (2603:10a6:10:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 11:32:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 11:32:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] reset: imx7: Support module build
Thread-Topic: [PATCH 1/3] reset: imx7: Support module build
Thread-Index: AQHWTf+gVil33+KDPEOiQKx/rvC/xajvZ8CAgAAAWbCAAAylgIAAALfA
Date:   Mon, 29 Jun 2020 11:32:22 +0000
Message-ID: <DB3PR0402MB3916ADD54CB167B8ED10076DF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a1pr8YbZMpSXg6o_UeDvaU=dDqfo45DudTASNcsxeg3kg@mail.gmail.com>
 <DB3PR0402MB3916292FC3FDE4F28AFEB5EBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0Za99-xXTwtHNHO-Dzbo-1uesNC2oO91RA-gZZG3Anmw@mail.gmail.com>
In-Reply-To: <CAK8P3a0Za99-xXTwtHNHO-Dzbo-1uesNC2oO91RA-gZZG3Anmw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0403bcad-2e68-4bd7-47d7-08d81c201757
x-ms-traffictypediagnostic: DB8PR04MB6860:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB686070E5B51D7C7E31AA99E3F56E0@DB8PR04MB6860.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0KZpRCzWfGjz7BA8GN8et2uuwZPpmd5HjL/GetXk9Xwrp5uumufX5q+LbmOLErcstxqSxmqrZQhS+DRKM6xFgV8bFiigAnq4Q/zjVZ9jdtCIWD6WO0PQZ3oy3c5nmJMqmaBL0Aksjbzqc/ly/8C2oKbHcBF34PABVc13jbiEpF8w3D3/OfKn8maFSAcPuE1oy4DcT7f2+WhZnwhKcISorQ3PwywNti+F3G8f9qKBaUxIFKe88Su35RY0RsxSqlX14lWsmXhOWHFOAH3ZI73iNdDt3a/dtxI1pyLzSXNUyDq373asaQ7ndcMpbokeZ3s2FhEKlbFny2H3+PCZ05ORg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(316002)(9686003)(7416002)(44832011)(4326008)(33656002)(54906003)(26005)(4744005)(53546011)(5660300002)(52536014)(71200400001)(6916009)(8676002)(7696005)(55016002)(186003)(76116006)(6506007)(86362001)(66946007)(2906002)(64756008)(66556008)(8936002)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1LKT9Tap72SVctty3x/2aup1X8mU29wmC+9MJfyx/VGJ0dqqHr9L7H1vMX9SdfPqRxHQeWD3q938qSr0vElsJI2BjgIJ0Yn5GXKFj57Cfa+kP7enGa4Eau7k30wTHLieavnX8hxuT0ooE3XtDO1knKFFDfbohMozLBGONAN8C+00DG98trQ87BPmPCAKRviCl2c7go4/0pcgVjJDqspyqLI38HD/YLDOVOyzqIVzjGNsDRxhcwTd3cJdjE1U01JeVxpyzvWTsamsRcr0f7sMyePTbMiYhlbzKdPhgjIgigC+o0eNlkOQJQ8MCZGoQxiwmlWlBdlupWnZGYfC75772LjraI1uKQEux3gWrPzeNCc4U+bC9nDH6zEOuT/Jf3ljcAiFyUaX2eIOhtow8OWZAe5kQeLP4OIRTTyHg8T8VWARW2B4IclFInP4lcIBabOppeZqcYLF2sarZ/hpV3TSkr/uiVecUHT4NK2K8CBizLsafd6SgyFi1lIm5N/JgGzO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0403bcad-2e68-4bd7-47d7-08d81c201757
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:32:22.7663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmxE7VCd5E02rqf4iPn2hID9kLerE10KvekBpHOVUspnJKvQiBW13e+4Z4NPFduGwFvMKay7Eidhdbt5edJ9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSByZXNldDogaW14NzogU3Vw
cG9ydCBtb2R1bGUgYnVpbGQNCj4gDQo+IE9uIE1vbiwgSnVuIDI5LCAyMDIwIGF0IDEyOjQ1IFBN
IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS8zXSByZXNldDogaW14NzogU3VwcG9ydCBtb2R1bGUgYnVpbGQgT24g
TW9uLA0KPiA+ID4gSnVuIDI5LCAyMDIwIGF0IDEyOjI1IFBNIEFuc29uIEh1YW5nIDxBbnNvbi5I
dWFuZ0BueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSByZXNldCBkcml2ZXIgbm9ybWFsbHkg
d29uJ3QgYmUgcmVtb3ZlZCBzaW5jZSBpdCBpcyBuZWNlc3NhcnkgZm9yDQo+ID4gZHJpdmVycyB3
aGljaCBuZWVkIGl0LCBpdCBpcyBqdXN0IGZvciBBbmRyb2lkIEdLSSBzdXBwb3J0LCBpbiB0aGlz
DQo+ID4gY2FzZSwgZG8gd2UgbmVlZCB0byBjaGFuZ2UgaXQgdG8gbW9kdWxlX3BsYXRmb3JtX2Ry
aXZlcigpPw0KPiANCj4gUGxlYXNlIGF0IGxlYXN0IHRyeSB0byBkbyBpdCwgb3IgZXhwbGFpbiBp
biB0aGUgY2hhbmdlbG9nIHdoYXQgd2VudCB3cm9uZyBpZiBpdA0KPiBkb2Vzbid0IHdvcmsuDQo+
IA0KPiBJIGRvbid0IHRoaW5rICJiZWNhdXNlIEFuZHJvaWQgR0tJIiBzaG91bGQgZXZlciBiZSB0
aGUgc29sZSBqdXN0aWZpY2F0aW9uIGZvciBhDQo+IHBhdGNoLiBNYWtpbmcgZHJpdmVycyBsb2Fk
YWJsZSBtb2R1bGUgaXMgYSBnb29kIGlkZWEgcmVnYXJkbGVzcyBvZiBHS0ksIGFuZCBpZg0KPiB5
b3UgZG8gdGhhdCwgdGhlbiBtYWtlIGl0IGJlaGF2ZSBsaWtlIGFueSBvdGhlciBsb2FkYWJsZSBt
b2R1bGUuDQo+IA0KDQpPSywgd2lsbCBkbyBpdCBpbiBWMiwgQlRXLCBJIHRoaW5rIHRoZXJlIGlz
IG5vdGhpbmcgbmVlZCB0byBiZSBkb25lIGZvciAucmVtb3ZlKCkgY2FsbGJhY2ssDQpjYW4gSSBq
dXN0IHNraXAgaXQgb3IgbmVlZCB0byBhZGQgYSBibGFuayBjYWxsYmFjayBhbnl3YXk/DQoNClRo
YW5rcywNCkFuc29uDQo=
