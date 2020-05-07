Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06605C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D869D208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="byZL+6YK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGJ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:29:16 -0400
Received: from mail-db8eur05on2095.outbound.protection.outlook.com ([40.107.20.95]:55237
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGJ3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:29:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNyUHM0m5gTxHWHnZY/RX+MuQ5m1kzgdBEzX2bl9WGVoaNBr0xNgOS2AOuFZ5hKET6tJDVLrlDFVQzu5sOpoHEnNlngwlVyuql84pYk8LvPECOjVSy6k2zArw/j1OMmNhNKL4JBhO8/GsZB8rIBq/+f+JJBxh4mbQR8ALlsSeJ+hfIl1VW67Vn22agXo3SmozUjv4LZnzlVR55I4VqCpVBiC9zqqL1qk9TihFiSd7uBmR1aC7v3REEzAZYtQuIOSg1rmWIajnA+i/azZcNAAkERq3qPi8OEqxHY5TeHxQE3iMBdzpQ3qYco/JhhN3vtcaf6M5Ap9OLBBkJ0DmINiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXM7p5YPzCrYtrQmBcctITv8skIU/S73tOtu84RqL3g=;
 b=XfkzHN5BIwllyxvIsEncO7YjEARAszeCcltvvGGXPiM7nle71Vlxm3joeUTYUeqOrtd4MsRTwbc6L2W96E7uUPY3j6jM0X62flngZ+lGR3PTFfdZrX31dcrGcNuyppYlHNyUqP5VYhw5ZVPISnGzHfoLYjZxda31AetslbY317MQFGMWSdRth7KgmsWupVL3v/t5s4j3mI1QEqsrR1zXB+MHvx7u7NZIX7LkS5dotZCxcng6EChVcDzz6Yu1vXdYO4GEFYSym1LMGJ123nVbtJwK3yscgQQEK55h/hEpynZ5tCI8/vaeTlQrHEY5tgBuZv6Nem9y/WTHaEbtuqWIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXM7p5YPzCrYtrQmBcctITv8skIU/S73tOtu84RqL3g=;
 b=byZL+6YKNB4qlWwiGz4XEqnh04QaeOsKDdkQpFjnLJhav69nFxNHPe7w5OYqjZnXnYOqV5Z9w2RTcQ1tdYrFElO/gBMSfQwdYaQdXTsenBoeuX4Uu/HaVEONt/hAwXvkK/XaP+V7XjMQCf/NnSHrcJdqr3wUg0bvJPEvWLY/SXA=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5521.eurprd05.prod.outlook.com (2603:10a6:20b:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 09:29:13 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::d8d3:ead7:9f42:4289]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::d8d3:ead7:9f42:4289%6]) with mapi id 15.20.2979.030; Thu, 7 May 2020
 09:29:12 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "dillon.minfei@gmail.com" <dillon.minfei@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco
 board
Thread-Topic: [PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco
 board
Thread-Index: AQHWJFAw2k3Ods8/jU2+K0HVpP++Y6icW04A
Date:   Thu, 7 May 2020 09:29:12 +0000
Message-ID: <e7002d31d1392cf8969e56aba060ed3cc1c12ed9.camel@toradex.com>
References: <philippe.schenker@toradex.com>
         <1588842971-20495-1-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1588842971-20495-1-git-send-email-dillon.minfei@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.2 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [51.154.7.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 553d7c32-7a7b-413e-f6f0-08d7f2691ab0
x-ms-traffictypediagnostic: AM6PR05MB5521:
x-microsoft-antispam-prvs: <AM6PR05MB552121AC7729CDEA9C7A1231F4A50@AM6PR05MB5521.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ol4llQ0pAI7EOUU7QOKRmwkBhiy/ptSXcOfyoXnCCY3Zl9at1HS2fZN2JA5gOd8FnqOOlIOjOJRi/MczR0b/N0mv3GA47QLtnCqRPvjEFyimkmAN5Pe7D0CKPVqcoFyN/M4Y515AtbfJ7s4MY0u32Yzi8p8Z1laAbW7XCZtXWbMwKFKhq0nGRAtdRYavYpOqCzoyNW0fdKiUugUPAgvbBN3JQxZdcsZ4TzYQ1h9bfarpZeo9FrULOJz048sHcFCayHMvVDWM4GooQHlU23MwHsw6Nw4/eYkaMx3r9bL0fJ3CGoA63cuhv92idLKSnyamo266X7iyfWXE9vkMlo5PqLaaIQIIWv8V+CJr2Hrlfv6mnAQMyxEmBDowjNTcZi+4+zp7cj4Tpqxks4dXuTk25V4DH7uHiQtZH5bh8AyIFyOI9ODy0nuIXWK0tbnM0PN8YbAd4oR76HVtywktBRwpRuXPMCcLZdEYKRdUaYJPihKyRJunVs9K/2OxDzfZQ9gteY1QzhxRGo9y5hmUoqsmCzUsy8yAoPJbjzy7quj0XON7jw0cligYUe5zahv3KyJ37GhIRiKmxQ9Spq3OWQpLTJpq8MlmziSGb5csSamjD+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(366004)(39850400004)(396003)(33430700001)(186003)(26005)(2616005)(66946007)(91956017)(110136005)(86362001)(6512007)(54906003)(33440700001)(316002)(6486002)(66446008)(64756008)(66556008)(66476007)(6506007)(44832011)(966005)(4326008)(478600001)(4744005)(8676002)(71200400001)(76116006)(36756003)(83320400001)(83280400001)(2906002)(83310400001)(8936002)(5660300002)(83300400001)(83290400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CjuZXDkShw/FWNcXi9vIelDkKCvtXPaK7E0l0U+B2V4zhyXlvakZRqdZaJCNPlD7KKbl1H08A2kWG8DTEbw8hyM3jpyj8BPC7JXQGo8eA0C+nBrvt4ug6T1+wwMV5i0jWeYpG1PMcrRMmpI4jVW2l4D0T0/4Mcsg5Ac1jYNYPW8FmvoCUdNtA4/yY18G+Oq4cFyDgDN9/UnozCUhseasRWruzu78grrwHcvzis/09Xu+i84Lls2BAjBVTWFFkpr7FB7I558RqEltL6CEn/UABKrUt2FCYa1ld2qcUrEkkW+/MPojDadTzjnySZbpK+S/3C/N4+btZ6QaXXXaE31tjNcOW6A7Vl3XuQZeG8/ZXefkY4zwlUvU2X6PAz6+Kc3vBodH1/dL1xqME/UQXE0d+GRPGBKVfubp9XjbwqknHfJLydA/PdfYMJbldlRZLOCfmPIJ4Ue4PV9W1v1mgFSKjyixiVODpJGWoCuD+B/JdCPZ/69ZGOwx2l86bkvREgA0UK+uCN6HQBSca8ZizUAAX0upwiJcxfcmFoyx9ILyQC2d9E1siInmawn95SsgP6a6YAgnA6YfazdSmtVtJtC5Pe6/U0JWUKIUUTDRG6X2JAXORP8gezDI9VBcnxoK2DqM+62ErzNHhSu/NVpuhTc8y4fzqVXSYd45o1Bp/6+ES1zBsxz4o7YADlXXrJjdHeWtSeRwM7SSKVK0KesB3q+giVERbsz1z4HHck3DbCACtvKnY/K8AQNWO2lkPnnhAGYp87t/E/ICN7TN0KZFEmSz4G6SUP/imvYB/MPrKYbeMn8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C8175B59EDE444786D2E10D974A5359@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553d7c32-7a7b-413e-f6f0-08d7f2691ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 09:29:12.8668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OieHTxGQi5bwKiPCyiMVaHUa+gzIR4JNH7vALDGhPkIyUmFmMumM4i8SINuhlByj2P66NTUHGa/Q6+GefUc4caKnaLhfiDcQeSMiKogcFpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZGlsbG9uDQoNCklmIHlvdSBjaGFuZ2Ugc29tZXRoaW5nIGluIHlvdXIgcGF0Y2hzZXQgcGxl
YXNlIG1ha2Ugc3VyZSB0byBhZGQgdmVyc2lvbg0KdG8gcGF0Y2ggKGUuZy4gW1BBVENIIHYyIDMv
NF0gQVJNOiBkdC4uLi4pIGFuZCBhbHNvIG1lbnRpb24gaW4gY29tbWl0DQptZXNzYWdlIGJlbG93
IFNpZ25lZC1vZmYtYnkgd2hhdCB5b3UgY2hhbmdlZC4NCg0KQWxzbyBtYWtlIHN1cmUgdG8gc2V0
IHlvdXINCmVtYWlsIGNsaWVudCB0byB0ZXh0IG1vZGUgYWxzbyBmb3IgcmVwbGllcywgdGhhdCBt
YWtlcyBsaWZlIGVhc2llciBmb3INCmV2ZXJ5b25lLg0KDQpSZWZlciB0byB0aGVzZSBpbnN0cnVj
dGlvbnM6DQoNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mv
c3VibWl0dGluZy1wYXRjaGVzLmh0bWwNCg0KQmVzdCBSZWdhcmRzLA0KUGhpbGlwcGUNCg0KT24g
VGh1LCAyMDIwLTA1LTA3IGF0IDE3OjE2ICswODAwLCBkaWxsb24ubWluZmVpQGdtYWlsLmNvbSB3
cm90ZToNCj4gW1BBVENIIDMvNF0gQVJNOiBkdHM6IHN0bTMyOiBlbmFibGUgc3RtcGU4MTEgb24g
c3RtMzI0MjktZGlzY28gYm9hcmQNCj4gDQo+IHJlbW92ZSBpZCwgYmxvY2tzLCBpcnEtdHJpZ2dl
ciBmcm9tIHRoZSBzdG1wZSBtZmQgZHRzIG5vZGUuDQo=
