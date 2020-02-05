Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEE5C3524B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE99E2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxWtPX/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgBEDHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:07:12 -0500
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:39033
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727746AbgBEDHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:07:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTpvX75eMP89GGv8HLuvP7IKCh6x0v+5RpYg+jzxLI+RpAHi20LMz/f6JNAIjihPvs300q3dTpX3f4obJi3WrX7ZSrWcUGR10DNSvVWCGxgo2XJfEb53C8XLtJQ/AJiWO7P0vIHUpgHO0va+B1ByYig6kqBBC9OdVHqH3+1v8D0RLbamUPDSX6XYCAb/6TXouCJSXX2v6UZ9adIPFSnW7wR7+sQKorbaY4Gc3CMtcPjtvI9FOygr1QWhkq7A7vX319B+WFd/jGBUAS4DxjmuWIrsBrSpjV/uEBqFZVYmPJMASxSWpSE4PAbRMVV8OECur0klrCV6DNXCiFDWP9qSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11rOZ6ub1Ypt7xsleDLGkDFWVYHUW2rojAmRp2oYkoo=;
 b=l5y5cTpM0uFxvQlZMQNE6q0IjCfkwmIHcWwtJgNzgmQeQwZzJ4xtVn/YZIJtSHqmjl2+DRkHDVe44VYnw31DRBJxa6Rqj1mSN4Bmr1KCCM+OlW9zgMGLmY5NVJo5hEnzBsklbP8psxNv3MeFp+xA60KaEBPS5Uw94Gij3Eb7sK2CW9gc7p7WpYYkVm99CEe8FM/Cnr/TrPEMuJqw38dKL9MI2kDAWntBXSGbWBtM6QGmuZyC4yONaal3BAWws8FZFYSitnMB8wCHxHUMwTyOrb3RoPm1cV9dn59AqcrwbbQOJKJFVFbNb4oC9JYtkU0hor/1+YnCfSi8jcO8gStnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11rOZ6ub1Ypt7xsleDLGkDFWVYHUW2rojAmRp2oYkoo=;
 b=kxWtPX/KECd0qQhvm6wDW4C2YEh4snD6Fu9BaDkT4xSgnBiAZH0NrP+XPTwaKIPi78JvkepDaC/tLIxRgTEW9fB0G+TUWhr09jhr2coPWR+fR9QtH9Bt5T8Um1YJu47yK5h1OizxPo4cCMnq7+qQ9+1NanY94W63+5BAzLXBe7A=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4474.eurprd04.prod.outlook.com (52.135.141.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Wed, 5 Feb 2020 03:07:08 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0%7]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 03:07:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 0/7] ARM: imx: imx7ulp: add cpufreq support
Thread-Topic: [PATCH 0/7] ARM: imx: imx7ulp: add cpufreq support
Thread-Index: AQHV22DB4Jio1GYHq0SGCvfmhvaRDKgLDAqAgADebCA=
Date:   Wed, 5 Feb 2020 03:07:08 +0000
Message-ID: <DB7PR04MB44904E50D1B0AC71D999D1C288020@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
 <CAOMZO5Avbrzf8jNQ301mNN3YXXPjEGYWkooae_uw=wLykMgt+A@mail.gmail.com>
In-Reply-To: <CAOMZO5Avbrzf8jNQ301mNN3YXXPjEGYWkooae_uw=wLykMgt+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2f55fa6-6fe4-4e46-2da0-08d7a9e87cd2
x-ms-traffictypediagnostic: DB7PR04MB4474:|DB7PR04MB4474:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4474C7918F90B3ADE631B07188020@DB7PR04MB4474.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(26005)(44832011)(55016002)(5660300002)(81156014)(86362001)(478600001)(76116006)(316002)(66446008)(64756008)(66476007)(66946007)(66556008)(186003)(54906003)(4744005)(4326008)(8676002)(6506007)(52536014)(53546011)(33656002)(81166006)(71200400001)(7696005)(2906002)(8936002)(9686003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4474;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ftqWxKkoMiR9U2WhCZo3NFRkdDNX9pmBfeKBqYx3TxxRClXJjIlJwTzkN1lZCTCMwZnjvuCTZVLmJ8jj7p6jMAOB3dD6uqyXEhj0GNfXyXltSA+b8GKHrDl/MqMnKgBMKFZSytuACAjOjGsR32W15tSc2WnMkEE7QRo7s+gZOxs/dFAP+qNeOOsu8MA9zvlmrUR9TfTgO1OCZDZSRG3c8Lna7YSnoUDum8Kch1NLoibsfNx61QvpDP/f6EA6UZt2EFC38xnWYEhGLdBGrQ3dAxTszYva98ekaV6IKSZPMxuV6eaOGIB5pzYJXIg5N3Lra4QRgNzsgyIQ0D8vdd/pK9FfnBkRDLXQlCPw5+wBiBpr6P5Ugv2VEGcD/st+FRjrfnyo4ZXxapOQMZo2pRpd9Hw2WfaYiybaMiCNaEldjPm3mE0vKWgPcQ4u911p4gRX
x-ms-exchange-antispam-messagedata: vxKE5273B2zgZPjiQPbu2D7CAzjN0ttqspnWod4mvWyXjUuzm/NqgfLAyT41uF5mJ7Vjn9OtMIDwTLgBfGaVka4XHKUzaNut/zGpRm9FeTrSACXAYJMErUkKKRskuh97TqozhBlMULixpEencJC5cg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f55fa6-6fe4-4e46-2da0-08d7a9e87cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 03:07:08.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+v2lkvwflzhTjO40sRAUj54LY/Iqcw1E0tn+JLj1KGuJlF+NttxRLbifw4Uv3qTkabaygS0JXv+AcGcdmswyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvN10gQVJNOiBpbXg6IGlteDd1bHA6IGFkZCBjcHVmcmVx
IHN1cHBvcnQNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBUdWUsIEZlYiA0LCAyMDIwIGF0IDEw
OjQxIEFNIDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gSSBub3QgaW5jbHVkZSB0
aGUgdm9sdGFnZSBjb25maWd1cmF0aW9uLCBiZWNhdXNlIGlteC1ycG1zZyBhbmQgcGYxNTUwDQo+
ID4gcnBtc2cgZHJpdmVyIHN0aWxsIG5vdCB1cHN0cmVhbWVkLg0KPiANCj4gQW55IHBsYW5zIGZv
ciB1cHN0cmVhbWluZyBpbXgtcnBtc2c/IEkgYXNzdW1lIHRoaXMgd2lsbCBnbyBpbnRvIHRoZQ0K
PiByZW1vdGVwcm9jIGZyYW1ld29yay4NCg0KSSBuZWVkIGNoZWNrIHdpdGggUmljaGFyZCBmaXJz
dCwgaWYgbm8gcGxhbiwgSSdsbCB0YWtlIGl0Lg0KDQo+IA0KPiBXaXRob3V0IHRoaXMgZHJpdmVy
LCB0aGUgaS5NWDdVTFAgc3VwcG9ydCBpbiBtYWlubGluZSBpcyB2ZXJ5IGxpbWl0ZWQgaW4NCj4g
ZnVuY3Rpb25hbGl0eS4NCg0KVG8gdGVzdCBvbmx5IGNsayBjaGFuZ2UsIHJwbXNnIGRyaXZlciBp
cyBub3QgYSBtdXN0LiBJIGhhdmUgdGVzdGVkIHRoYXQsDQptaHogY291bGQgY29ycmVjdGx5IHNo
b3cgNTAwTUh6IGFuZCA3MjBNaHogd2l0aCB0aGUgZGlmZiBhcHBsaWVkDQppbiBjb3ZlciBsZXR0
ZXIuDQoNCkknbGwgdHJ5IHRvIHB1c2ggZm9yd2FyZCB3aXRoIHJwbXNnIGFuZCByZWd1bGF0b3Ig
cGFydCwgYnV0IGJvdGggbm90DQpnbyB0aHJvdWdoIHNoYXduJ3MgdHJlZS4gVGhpcyBwYXRjaHNl
dCB3aXRob3V0IHRoZSBkdHMgcGFydCwgY3B1ZnJlcQ0KYWxzbyBub3QgdGFrZSBlZmZlY3QsIHNv
IGl0IGlzIHNhZmUgdG8gYmUgaW4gaWYgZ290IHJldmlld2VkLiBBZnRlcg0KdGhlIHJwbXNnL3Jl
Z3VsYXRvciBwYXJ0IGdvdCBpbiwgd2UgY291bGQgYWRkIHRoZSBkdHMgcGF0Y2ggdG8NCnN3aXRj
aCBvbiBjcHVmcmVxIGZvciBpLk1YN1VMUC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gVGhh
bmtzDQo=
