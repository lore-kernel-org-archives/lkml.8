Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815F0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 03:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550CF20FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 03:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YUP79wwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgFRDJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 23:09:08 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:5518
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbgFRDJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 23:09:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNpfzGSC0nss96TQ+dKNtYS6dsHC6a8A71AaVYFlYlxmtvXvDCSkdULkrS6CVUz5QfFi5DMx2BQM+QwK5zNSugKqOLs34T2HoMvPB2w7JBis5ek7Te+08HkR31PvVdL5P0ghEvi+AEYANvpLPF6Yq6syo5Rla3b7+9rtMzgerf2DIHN96bXF14KRxTAg6MBEETnI6DBHUwdetCFVxIaLYeypPkLbgEQnn7xHwdM+2VMLgX5kxMEgxpxyKnWvkCim24mM5qUIbX9jtPX4f9qb+7EOHa7s6DvLgnZPr1e3SW8n4X3Pic8X5XYHt6zCbhPlAtxKk+Zo1OVdm+z/5P6JUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9N7KL5y5sB/09UbOBaQVac7PGw07PfTmIAtVc9280o=;
 b=f2KXpebcufsEYl5Hgvi5QpS2xaeKl8UFbNOTkGXrn1HxqMg1XOQ70GVOEDymu4ij40W2Qqa2hssw02XmAiwN/mzXD9udo4W2e5CFa+1D5IIviVD6m2wHv6zHZOPPEUmv7iVKqtol+Kp3CQGprZcta6go6/HmaWshaJY1HJDEwRNQN0j3mvsW/T1jA80daFynnt/d4IGUQzPnaRTS59ZcvH27nkvxB+XPAyzMI5aamnmZFs482TtB898rbCX4egRwepRS2pyuza25QhJek02yRUMv2/vRCPNDyJEsmfYfnNadMsn9PzzPckcUHFSDFINt8yuBS2m9cJnXwYnExckdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9N7KL5y5sB/09UbOBaQVac7PGw07PfTmIAtVc9280o=;
 b=YUP79wwAZudW1wQVhg2qYdR/eYqvDb+ujg8f+jy9WxZOCqv7nDMagZs13AKn6HppJNRIopcBYqDkamWw8A4VrnbR9sAxFEyNsGygVUxeAgXxTl1V+TlcS2M4F/OxF4p4MCMJHJI+eTt2HLO4OqWOy5ncxeDNy7QkEn4nYBbZDUg=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4136.eurprd04.prod.outlook.com (2603:10a6:209:4e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 18 Jun
 2020 03:09:00 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 03:09:00 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Abel Vesa <abel.vesa@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/9] ARM: imx: Select MXC_CLK for ARCH_MXC
Thread-Topic: [PATCH V2 2/9] ARM: imx: Select MXC_CLK for ARCH_MXC
Thread-Index: AQHWPjGjLfNEVvc8HUmhxuTW0pJGcKjcqIMggAAi6gCAAPOSIA==
Date:   Thu, 18 Jun 2020 03:09:00 +0000
Message-ID: <AM6PR04MB496647CBE140DFF73DCBBEED809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-3-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966F4A5E0276AEDB5605260809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39160682846B99E0A3762AF1F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39160682846B99E0A3762AF1F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f3ca449-c087-4494-f462-08d81334f2d7
x-ms-traffictypediagnostic: AM6PR04MB4136:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB41360610BC7A99CD889B5074809B0@AM6PR04MB4136.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DNKYYE1jTP8ri2bNtyQAcME9rM1ClxLQ10aM5q2BbTtrgiScsgZDjKKg2HqNQWuq01KTt53a2TArC2tpQWlWIj+oTtOcEGfxT1amilUE3c01AfCE+YvVnw2cvBvspHoEt/uEnAkc5tCSMFmkd3zuWwI7jBESSmifE+RhoFVsWfsmhMSitcYzrHXTM0WFdIkRIwDB5GIeiPbcd0IuVxA+e5hHLKyHHmBcDd9VtFMK1KUCh7lrcWjAGL5Bg8OQnm0XZENCVBdQGL0E3XSJ/Z9/Hxqbcxemg7gmzmkp7Bx70JYCZvvk9uw/JavDgOdOsyLPc9aOm3992h1kvRl+jc0cByxKrRAlVaJgfcm3ollPRUHehPZhY2YqhKz35FY1cwxP3g35dubUWmaCBhROQtORWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(66556008)(76116006)(66476007)(86362001)(5660300002)(66446008)(186003)(71200400001)(66946007)(7416002)(64756008)(52536014)(6506007)(44832011)(53546011)(9686003)(2906002)(55016002)(110136005)(478600001)(8676002)(4326008)(26005)(83380400001)(33656002)(316002)(8936002)(7696005)(21314003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: P0fT3/EponGUnv8d0C3+UrKHGPBjo7bi+IuWb+iqKYx0VeIdUoFitlnA/4t8h7V/tEJZoD6U6Z3dbFPrB7hukKF6ttLUjMV5WxvNpbrcttFGLcfMY7BowqmutXeT9uK5RrrPatShzQ4GHYh2cXWGL/Qw0XbeFHHaJiO7u1xpjiEcSMMW7IhwDNATOYrpldiHD0POLcl90MkobPBDffL52yhseHG40MnGiW1EFbELtdqVbEvOLAhydN6Unb6cnUeVvIV58YSAFH+xHj2lEnjRyjV6WTkpuMUY4kzJ17zYnW3Rm1AdqIUhy71VnZgwl4bKK+ibLvhKI7avBk918/+Tu2pAMc957/OO0X9aS8yMDCH71wxAtPWw9OtUclRI9QbpqXRUSUrGjjYdqjp1OC4nJS27iKwY0ViN7jczCzpSrD3FMOSeGdgAHl0PJOSgtvyIZYFJ1ENAi9zalbn2tiqlOyhgvKOvSSFtNZ09ZvgJe4L5CUDDMku3PTWtvlRxgFf7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3ca449-c087-4494-f462-08d81334f2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 03:09:00.4512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMlTjhfhZqlaQeGYy9S1XglhPt3nngRme9BE0/9CdkrKOO0Ai50i9/j9QlRX2vskZM7Le/zuUFmnMe4DITwT/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBKdW5lIDE3LCAyMDIwIDg6MzYgUE0NCj4gDQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCBW
MiAyLzldIEFSTTogaW14OiBTZWxlY3QgTVhDX0NMSyBmb3IgQVJDSF9NWEMNCj4gPg0KPiA+ID4g
RnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDksIDIwMjAgMzozMiBQTQ0KPiA+ID4NCj4gPiA+IGkuTVggY29tbW9uIGNsb2Nr
IGRyaXZlcnMgbWF5IHN1cHBvcnQgbW9kdWxlIGJ1aWxkLCBzbyBpdCBpcyBOT1QNCj4gPiA+IHNl
bGVjdGVkIGJ5IGRlZmF1bHQsIGZvciBBUkNIX01YQyBBUk12NyBwbGF0Zm9ybXMsIG5lZWQgdG8g
c2VsZWN0IGl0DQo+ID4gPiBtYW51YWxseSB0byBtYWtlIGJ1aWxkIHBhc3MuDQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4N
Cj4gPiBDYW4ndCB0aGUgb3JpZ2luYWwgZGVmX3h4eCB3b3JrPw0KPiA+DQo+ID4gY29uZmlnIE1Y
Q19DTEsNCj4gPiAgICAgICAgIHRyaXN0YXRlDQo+ID4gICAgICAgICBkZWZfdHJpc3RhdGUgQVJD
SF9NWEMNCj4gDQo+IFN1Y2ggY2hhbmdlIHdpbGwgbWFrZSBNWENfQ0xLPXkgZXZlbiBhbGwgaS5N
WDggU29DcyBjbG9jayBkcml2ZXJzIGFyZSBzZWxlY3RlZA0KPiBhcyBtb2R1bGUsIHNvIGl0IGRv
ZXMgTk9UIG1lZXQgdGhlIHJlcXVpcmVtZW50IG9mIG1vZHVsZSBzdXBwb3J0LiBCZWxvdyBpcw0K
PiBmcm9tIC5jb25maWcgd2hlbiBhbGwNCj4gaS5NWDggU29DcyBjbG9jayBkcml2ZXJzIGFyZSBj
b25maWd1cmVkIHRvIG1vZHVsZS4NCj4gDQo+ICBDT05GSUdfTVhDX0NMSz15DQo+ICBDT05GSUdf
TVhDX0NMS19TQ1U9bQ0KPiAgQ09ORklHX0NMS19JTVg4TU09bQ0KPiAgQ09ORklHX0NMS19JTVg4
TU49bQ0KPiAgQ09ORklHX0NMS19JTVg4TVA9bQ0KPiAgQ09ORklHX0NMS19JTVg4TVE9bQ0KPiAg
Q09ORklHX0NMS19JTVg4UVhQPW0NCj4gDQoNCkl0IHdvcmtzIGF0IG15IHNpZGUuDQpCZWxvdyBp
cyBteSBjaGFuZ2VzIGJhc2VkIG9uIHlvdXIgcGF0Y2hzZXQ6DQokIGdpdCBkaWZmDQpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZyBiL2FyY2gvYXJtL21hY2gtaW14L0tjb25m
aWcNCmluZGV4IDQ3YjEwZDIwZjQxMS4uZTdkN2I5MGUyY2Y4IDEwMDY0NA0KLS0tIGEvYXJjaC9h
cm0vbWFjaC1pbXgvS2NvbmZpZw0KKysrIGIvYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZw0KQEAg
LTQsNyArNCw2IEBAIG1lbnVjb25maWcgQVJDSF9NWEMNCiAgICAgICAgZGVwZW5kcyBvbiBBUkNI
X01VTFRJX1Y0X1Y1IHx8IEFSQ0hfTVVMVElfVjZfVjcgfHwgQVJNX1NJTkdMRV9BUk1WN00NCiAg
ICAgICAgc2VsZWN0IEFSQ0hfU1VQUE9SVFNfQklHX0VORElBTg0KICAgICAgICBzZWxlY3QgQ0xL
U1JDX0lNWF9HUFQNCi0gICAgICAgc2VsZWN0IE1YQ19DTEsNCiAgICAgICAgc2VsZWN0IEdFTkVS
SUNfSVJRX0NISVANCiAgICAgICAgc2VsZWN0IEdQSU9MSUINCiAgICAgICAgc2VsZWN0IFBJTkNU
UkwNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvS2NvbmZpZyBiL2RyaXZlcnMvY2xrL2lt
eC9LY29uZmlnDQppbmRleCAyNmNlZGJmZTM4NmMuLmY3YjNlM2EyY2I5ZiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvY2xrL2lteC9LY29uZmlnDQorKysgYi9kcml2ZXJzL2Nsay9pbXgvS2NvbmZpZw0K
QEAgLTMsNiArMyw3IEBADQogY29uZmlnIE1YQ19DTEsNCiAgICAgICAgdHJpc3RhdGUgIklNWCBj
bG9jayINCiAgICAgICAgZGVwZW5kcyBvbiBBUkNIX01YQw0KKyAgICAgICBkZWZfdHJpc3RhdGUg
QVJDSF9NWEMNCiANCiBjb25maWcgTVhDX0NMS19TQ1UNCiAgICAgICAgdHJpc3RhdGUgIklNWCBT
Q1UgY2xvY2siDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiBBbnNvbg0K
