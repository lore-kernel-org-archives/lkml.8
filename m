Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239D5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1D12076B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="ZJDmJpyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgEaKO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 06:14:29 -0400
Received: from mail-eopbgr20106.outbound.protection.outlook.com ([40.107.2.106]:44869
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbgEaKO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 06:14:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbUMfc08Kaii2Gp96mKddQxjbUnIVnp5wi5JfpYz/8o/t33wHUwlEVb0t/cq7lzQQAY/uuXSZBcqfLtaRhmOLObYxWwOTBNL6qzPlxN3h+7VPR4kwirJ5FfyjJuHDMP/H8ofjMbrKy+XqaYF2goATQ7MY3y72Sbh9/4ddvSwmOCw509eVOUZ4jSg9ckbAIUPBEeLR63OZQURqvhD4n0Dyl+PwYbxUvC8GuJc7iuGIBG1LbMApaYseufRYWDfe6nTee2ccYA4NSWn+KdFdU81SPycoaOZVMC6PztvPAPZLhVTqjjcyW2V946LiLips/FPNcmmEttRSSqnia7utjOj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuNoCyaR0qp0l2isk/kMcanoiVY4KxLpB7D6ZTzeZmk=;
 b=GUiHfAHovx3tulX4w6wwb/vbiaT8B4UTu4NlAYU9kGRG9yGPNrz3MwIlirGTiqFNUiYPBTap0JceUkexD5i55Vc826bLTyprrLHty/NRfPfWoASh6kb0V2xc9CXibT6hLP7q/loVVrWJxREvkeoe4pN8TWZQ2dgXXQGVulxJnU7/D/Jc4FqdIdmsxUZP59WgNIMIrl3WWCKQp4Hmva0uL1jpR3RwXfQZlgTqyuM2auz8EjOwT0OBxNgCTPbEcQ02Td6mYoIs8meePvNOXouZJJSkWyLzh8oyGZ/bEtadpb/hHOy8VbOOJE4+0skjhWPAHrWs2lZjuuz+q5pYCQk9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuNoCyaR0qp0l2isk/kMcanoiVY4KxLpB7D6ZTzeZmk=;
 b=ZJDmJpyEkXZXSunP6QsoXVy84XMs/OgN9Z4S4XPcTOKW2XxngT8kKkPYb6VZzrTOI4a72DYm7YXy4O/KH2jmTQCeux6oTob5McOFZqMFvdh5X2+Pv7pax+0tgbk02N12g6VASpcJzfxfp+60MBhCCCz22USHe4sVsWcCbAj4ZcU=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM0PR02MB4948.eurprd02.prod.outlook.com (2603:10a6:208:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Sun, 31 May
 2020 10:14:24 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e%7]) with mapi id 15.20.3045.022; Sun, 31 May 2020
 10:14:24 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: correctly cast u64 to void*
Thread-Topic: [PATCH] habanalabs: correctly cast u64 to void*
Thread-Index: AQHWNyyDp/9420xzh0SpRG4OtOMZLqjB+S6w
Date:   Sun, 31 May 2020 10:14:24 +0000
Message-ID: <AM0PR02MB552329CB51A9FFD4964F58FCB88D0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200531091547.6868-1-oded.gabbay@gmail.com>
In-Reply-To: <20200531091547.6868-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [141.226.13.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6f5a6b8-6a80-46a5-cbab-08d8054b64e1
x-ms-traffictypediagnostic: AM0PR02MB4948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB494833A52DE8CD9B3D95702BB88D0@AM0PR02MB4948.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0420213CCD
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VWnEaN2ThCRqHBs+PIgebCiJG7fYrtKheUUA+3aQguf3Nw5XPlcrqWnoAjFgHs2J8+lPIzbLmVgvGKcCHFxPzdBr+lwDX+qBMzMO4TVXNiLkOLyyl8DNu2FCSDP8y3uO0HmLaKpkR3qdjkZQds/tfLE1CxaA17toqTrcSXeRidmh6iw5wm5euJ4f2sWsIHeuR7kheNpFHwRRpAGJohqeyNvUfblEsCktXBDhFnAS1dmNblSxyOdEgoiIN5Kytw5MZy0xKXzWpJDY+wZIEQENYyS44YK8GtRCIV3PRDVPE3Nn5bszWQZgqwK1adzwtRvOiNLpfPfdJqq2kaXWijrdpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(376002)(346002)(136003)(366004)(396003)(316002)(5660300002)(26005)(4326008)(86362001)(64756008)(76116006)(66556008)(66446008)(66476007)(6636002)(186003)(71200400001)(110136005)(66946007)(9686003)(558084003)(53546011)(7696005)(478600001)(52536014)(2906002)(55016002)(33656002)(6506007)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KNWKt1Ll6Wj4UTGl8Y5/XDxJ44xoGS/g12tP2akAzQYL/J31xdALXOaOPijY2GoYa4nFMRs5gusn9meDx7N9faAqUvP+R3hZrKfypMmTUG7nv95He+BUnBBXBRiVrBbpDbxKkeDps3YIukjU1BbfLKWIuxHHOJF+Th9xT4Bz+aJtMQ9YW53qaZCcpbc6l9034JYoJnUxE1BsdUlqPA7vc3wqN/C32+CRo5EWKEwky+c7xcLOnGLMnmc/Vrlg4asw2fFK44yggZnXkjBnVbCI+YPzL4nsIpkubCxgB4kz8UHs2oS2CfcdoBIsgtmm7qO21Z/ZBQiy1pNj5We67T9+CVTSiZQk4PhFaAX75oQ7TAPGWnyQwCsdYywKPwD78dl8N7Ru6RZzTHsqdllzoMjJkXFMEaPTc/AETSmEcK0ci/ujsS+GU6Z/uLIsO9Al090W38VnTmEt6/NVC8bwNUkqQzEShv5WBAzLNbtHF/yQI4k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f5a6b8-6a80-46a5-cbab-08d8054b64e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2020 10:14:24.4421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4NQn+VJwnlDmAP0JwkDf7MQi/yC3Qg4K6fohI9rF1LkBzAHWPp1/gOYPK44SS+v0cVz8fTqNhezPU1yQ8YQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBNYXkgMzEsIDIwMjAgYXQgMTI6MTYgUE0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBVc2UgdGhlIHU2NF90b191c2VyX3B0cih4KSBrZXJuZWwg
bWFjcm8gdG8gY29ycmVjdGx5IGNhc3QgdTY0IHRvIHZvaWQqDQo+DQo+IFJlcG9ydGVkLWJ5OiBr
YnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogT2RlZCBH
YWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdl
bG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0KDQo=
