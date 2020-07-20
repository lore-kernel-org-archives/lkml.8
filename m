Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2642AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07602080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oETbVh/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGTI5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:57:54 -0400
Received: from mail-am6eur05on2062.outbound.protection.outlook.com ([40.107.22.62]:56064
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727849AbgGTI5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:57:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGrplbeK1r/LJ3tYZnrdrjYETKOUtVqDFXebzJDtTWifqrVoTTm8N2mz+cpZ8QIl4NKuk+pxVGhMD0hmEZbTQWle/b6YlViHGxrulZv75mLu/GaSAsHt4x5Xg93Z0vWjlD4ch73j0lWTOMctG/Te1IoX6u6wUmeSGUW3ExKw5+C88y28iKwAlg42ixcWD9hm8V3KXGXNmJAFkg5XNNqDQk5uyQ/1y7pDlYOgh7pSso7Rh6AZDFh6IgGo7G8B0g2RSQpbNXy58p8+/xXFC0m04jURxGftuRrcFMyN7tqyx6rz6KzffHC0Byp1ko2v3zkMAbSmPOz9V+uxdCzfpXZA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFJKmSxRTsCECSUSr790C3gHc+aQr2rYWV3gPA0MYdU=;
 b=Ff3WehpMiOy3XCYaCIQMMLiZlgUOCpV5XjXOMgq4H2QGYMcX7XrqUCKFXAcHxxnzFBe2opQEDWsBiGNw+uVEpOErhi5ThyVDFv+tdUQl18a3geTGpJHVMchJ8/OM1mI9YeoLmwBxVO9/Hreb2G54JSNm3SGnTQ+b6moyVCqBhflFGGEK9gPiM/vK/Xn3Zy63zPjj/URnrtKhuTcHr+lHWuOQE58Y6HBS1NmBmoWbZQDNNKBznuKHQEqwGJ2gwMTiUD3Y9ZEzsY2Y+VzbnK6FK9R2EgPHuloXL0UERbIS3dP8wXkNqG0MgdOtc3GNIHP6Vq+wum6IlAtFxNdiF6zc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFJKmSxRTsCECSUSr790C3gHc+aQr2rYWV3gPA0MYdU=;
 b=oETbVh/7as/TDji7w3fow3JZu4ARrCHf7IzXBqdNCylK2Tc2A+UUBNWV4mIBoFuSQJhaUqc93j5T1ghsu2aL4RywZVyD0WpEdSx5uT6RWDuQdJadOfKk5NyecPGoYiI0J8qGimyLzTQBYVM5fRzB4QrdNZtaDZqYe1U0Gj2cqOg=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB6251.eurprd04.prod.outlook.com (2603:10a6:10:cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 08:57:49 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066%9]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:57:48 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 RESEND 2/3] bindings/perf/imx-ddr: update compatible
 string
Thread-Topic: [PATCH V1 RESEND 2/3] bindings/perf/imx-ddr: update compatible
 string
Thread-Index: AQHWKC/LO755BEKmCkS2ni7qgOxph6kI3soAgAe3nRA=
Date:   Mon, 20 Jul 2020 08:57:48 +0000
Message-ID: <DB8PR04MB679528762BB39926FBCDE36EE67B0@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-3-qiangqing.zhang@nxp.com>
 <1f530ea9-c294-64ec-fd10-54129e0b4845@huawei.com>
In-Reply-To: <1f530ea9-c294-64ec-fd10-54129e0b4845@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ad86501-db6f-4c4b-2c00-08d82c8afa4f
x-ms-traffictypediagnostic: DBBPR04MB6251:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB62519BCB44C6CD3461F7F2DBE67B0@DBBPR04MB6251.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nit/KQXoKEeykgKXSNO/thi1pcYOjiA5jbORI+n4knecXhJ1bxveODuCtBUI8sEUWKrBkZ69RAsmgDIhzAVuAwCBEs/wQm3vNLXWcwZtENFBqBvQuQl2sUoECbRS4EaqJZzNtAltpcDAod6TCTcDhZ9w4UImpAWlmc5wE0X3L7NB9+uA1ElivDG+5++mYkw8weHMS+mO7mpCW9cLcr6ZO8odiAQvp2i1SxGexvn6FS1InK/ixyqtudhvUgxdhHmkEmYfBl+Jk0rl9xpk/UZZXWRsOi3OBX7rxgxdx7V7tqtqGu3nqAOIQstImMhKe2s6CzQkyfKevub5UZY8sx7N5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(15650500001)(9686003)(52536014)(478600001)(54906003)(6506007)(53546011)(83380400001)(316002)(4326008)(5660300002)(71200400001)(110136005)(7696005)(55016002)(66446008)(64756008)(66556008)(66476007)(66946007)(8936002)(8676002)(2906002)(86362001)(33656002)(186003)(26005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9g1ywMGNux3Emxhn9/mtj1u1JWdn0PCHRNo6I5CGBHVDOSuDFvu1mT/qtjM3oqEbEdKa8kL3xHfZ5F4EtlvRQkL7L1m+XyJhseByimVZ/0JOj5Rd2HnvslZv1otin9x0BbhMV81QBX+Mxe6a147rXK47SlSD3v9DgppkzqtCkBG3aUZOkqcSkE1YFYikaZqWLJfbEW09FwOTw9REvv1cJ32rLXvgcg22ERrbEUnKQeO3zcH9tLfL6bCwlmnDbSoWNtJ+/W5tWOtojKx11zyWyQ4dPKgvWVQclvPIWk5jwNdYiyXKTRrDVXRoywNArHbq3FmTO3V3KOGqzSulNsiyJrRVWirOseSbBHMpLB421gyLvTRLcWV2g4ws0TSxSt6IZ9beyN/pDu+X8iM0ZV8KhgxgR0X2wBsv3i5TvbU93YsY8SCMdV2LXYz1qq07j+3nm8bhwzjIHNZXP5ubuMDvMG/Kr0Rxh/DVOnG/gQBOuOY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad86501-db6f-4c4b-2c00-08d82c8afa4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:57:48.7864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+BjRcYwAGgx9N+1nJWWVbRRPMW/0pLt9IkvOr0v1KU7oq3Zr+6xhRXHJE9HS1dHyz8d7uuM+fMgNZHR7atWNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6251
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMOW5tDfmnIgxNeaXpSAxOTowNA0KPiBUbzog
Sm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IHdpbGxAa2VybmVsLm9yZzsN
Cj4gbWFyay5ydXRsYW5kQGFybS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2Vy
bmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
MSBSRVNFTkQgMi8zXSBiaW5kaW5ncy9wZXJmL2lteC1kZHI6IHVwZGF0ZSBjb21wYXRpYmxlDQo+
IHN0cmluZw0KPiANCj4gT24gMTIvMDUvMjAyMCAwODozMSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0K
PiA+IFVwZGF0ZSBjb21wYXRpYmxlIHN0cmluZyBhY2NvcmRpbmcgdG8gZHJpdmVyIGNoYW5nZS5g
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0Bu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BlcmYvZnNsLWlteC1kZHIudHh0IHwgNCArKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BlcmYvZnNsLWlteC1kZHIudHh0DQo+ID4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGVyZi9mc2wtaW14LWRkci50eHQNCj4g
PiBpbmRleCA3ODIyYTgwNmVhMGEuLmIyN2ExZDRmZWM3OCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGVyZi9mc2wtaW14LWRkci50eHQNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGVyZi9mc2wtaW14LWRkci50
eHQNCj4gPiBAQCAtNCw3ICs0LDkgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPg0KPiANCj4g
SGkgSm9ha2ltLA0KPiANCj4gPiAgIC0gY29tcGF0aWJsZTogc2hvdWxkIGJlIG9uZSBvZjoNCj4g
PiAgIAkiZnNsLGlteDgtZGRyLXBtdSINCj4gPiAtCSJmc2wsaW14OG0tZGRyLXBtdSINCj4gPiAr
CSJmc2wsaW14OG1xLWRkci1wbXUiDQo+ID4gKwkiZnNsLGlteDhtbS1kZHItcG11Ig0KPiANCj4g
SSBub3RpY2VkIHRoYXQgc29tZSBvZiB0aGUgY29tcGF0IHN0cmluZ3MgYmVpbmcgYWRkZWQgYXJl
IHVzZWQgaW4gaW14IGR0c2kgZmlsZXMNCj4gdG9kYXk6DQo+IA0KPiBqb2huQGxvY2FsaG9zdDp+
L2xpbnV4PiBnaXQgZ3JlcCAiZnNsLGlteDhtbS1kZHItcG11Ig0KPiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaTogIGNvbXBhdGlibGUgPQ0KPiAiZnNsLGlteDhtbS1k
ZHItcG11IiwgImZzbCxpbXg4bS1kZHItcG11IjsNCj4gDQo+IEFueSBzcGVjaWZpYyByZWFzb24g
d2h5IHRoZXkgYXJlIG5vdCBkZXNjcmliZWQgaW4gdGhlIGR0IGJpbmRpbmdzIGFscmVhZHk/DQo+
IA0KPiBJIGRvbid0IGZvbGxvdyBkdCBzbyBtdWNoIGFueW1vcmUsIHNvIGRvbid0IGtub3cgdGhl
IHBvbGljaWVzLg0KDQpIaSBKb2huLA0KDQpXaGF0IEkgZGlkIGlzIG5vdCBzdGFuZGFyZCwgYW55
IGNvbXBhdCBzdHJpbmcgaW4gZHRzIGZpbGUgc2hvdWxkIGJlIGRlc2NyaWJlZCBpbiB0aGUgZHQg
YmluZGluZ3MuIEkgd2lsbCBrZWVwIGluIG1pbmQuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBa
aGFuZw0KPiA+ICsJImZzbCxpbXg4bW4tZGRyLXBtdSINCj4gDQo+IFRoYW5rcywNCj4gSm9obg0K
DQo=
