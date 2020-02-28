Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A49EC3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA300246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="GDZKy5wC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgB1QzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:55:20 -0500
Received: from mail-vi1eur05on2090.outbound.protection.outlook.com ([40.107.21.90]:63009
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbgB1QzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:55:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jamKoMxzo1/+8oU29mC2Dz1DJxy5YEWMMNoZizPMyYU9nkz6WUyk5JwxtCdcFg3XzJWzL2rxlcowgJwrGukLermyLu2Nr0ICEc6LN3erP+ISiOQIHgHAmnofCXcQvA6wWelBircbN4x8zrafEDWhF+QcqtInTp6ph6kWpldVW6bgPoO72jWLLzDGgAkBlrMTeLSX6JD7WF2wEmvoYK3rxibcRT5BvALBx3+Ka4hmB0RUWvZaeN0xr1l8elLtl5xzHcLPmyD7fNHE6aaxMB3HwwI3+NZBQCV82xQAWZd3cuzWlZ7czORz82rot/E+NH6hz7hEU01ZuNDzIFNdNmWiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4d71Obl06XQbfQRE3DWlIYF6n75RT+P73/3960kppU=;
 b=AmkFj1udg+yD4xhsTL1zL5pLUpSB6Il2Ph6bJvmhpbnOtKf83YkZc4pW9XLzyG9Aezy8nE/6op2rSME4yTCWLo1JgzRvFC218k0Z6VoywAk+T4VeBsHCez86+WFXA8CgUeMHF/iVBqVcVaCEgMrDU6ll1VD16I3NigwbY7yaRNlQVad69VHKcq5+rZn+MgS+KODgTwRJlHgQiVs8aGBr8nYqlwvnUdnr7cBIra2oIXfRqXvhQDojrhY1CsYfN2MYfl5odpXxB9JAL9z68lqvGAre58CTn5C2y4o4SoSW+Kilold48a0Cc/FI/YiO9KMZVneJm/G8kWjeBDArUyaD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4d71Obl06XQbfQRE3DWlIYF6n75RT+P73/3960kppU=;
 b=GDZKy5wCQHmDt7y50u0r9WxRjJ9KlkXa7qW8stuOg1KXCJJAwypMmE5HaouCJVYWHaFmB1hOlbQcdAAb+rosQNO5Aigr6acjjX9Gmh0okwpemhSE8b9FpAmDrtQN8QiU9CTwP0ylawTLnxxErVSiXwpvoI+md+Yv1OsV0T+jLlg=
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com (10.186.163.80) by
 VI1PR05MB5886.eurprd05.prod.outlook.com (20.178.127.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Fri, 28 Feb 2020 16:55:12 +0000
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb]) by VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb%7]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 16:55:12 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "igor.opaniuk@gmail.com" <igor.opaniuk@gmail.com>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 5/5] arm: dts: vf: toradex: re-license GPL-2.0+ to
 GPL-2.0
Thread-Topic: [PATCH v1 5/5] arm: dts: vf: toradex: re-license GPL-2.0+ to
 GPL-2.0
Thread-Index: AQHV6zhumDbfzaMjgUuB9n2COTwjlqgw2TyA
Date:   Fri, 28 Feb 2020 16:55:12 +0000
Message-ID: <8a775c784ed587617db8829e1a3532a028e202bd.camel@toradex.com>
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
         <1582565548-20627-5-git-send-email-igor.opaniuk@gmail.com>
In-Reply-To: <1582565548-20627-5-git-send-email-igor.opaniuk@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [81.221.74.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9f8cc08-dfe4-4aa9-44c0-08d7bc6ef9f2
x-ms-traffictypediagnostic: VI1PR05MB5886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5886B7A26ABE3D1BFA187742FBE80@VI1PR05MB5886.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(91956017)(7416002)(81166006)(26005)(186003)(8676002)(5660300002)(8936002)(4744005)(66556008)(478600001)(2906002)(54906003)(66446008)(6486002)(110136005)(316002)(6512007)(71200400001)(6506007)(81156014)(4326008)(66946007)(66476007)(64756008)(86362001)(76116006)(44832011)(36756003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5886;H:VI1PR05MB6845.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZkpwCu/fiKkQ8+d5NEKUbELJZOLbDc/yfaJf4J+1eR3nU7yW/Zb/MKAp5iFYqNxVpmpVZHTpBylJkwPdfYczv/JmjJ2w089azPJj4FSmvR+dL6vPRnIqOs0lZe5j+IzcIE79zT1F2/1p5O84ZhNQuo+0Ka46Kf13lfIxTNSLw/6APXXchk3uThweBme7pBkWYYg2VXp8xewgEUKJChiIGMWHELbsu/RQfdE7jHcTSIlyQKmmLcct+vvHn3qDCPT6ZfoOB4Uw8JeSAumXIXFZYeHVijyuKmlPhbgP09qGIJlPQbUC2d1NO7oz1dSYPUtaP+74eTn7mNSuAZSZmX3BCRoCUiV+hRptH799M1sq/se9nxQphrpaUHiiVbah3D/9EYtWPDpcQZyy22SOadDA4v4thlIuB/KzwqBVKVod/GSj0t0KKaqUUlSvK7VXOVvv
x-ms-exchange-antispam-messagedata: MwgZR5oBRRg/KkjwYX6TU8Vw/43I9pXolS3td3rYSYiRRpZESwkDyqgNzbjmsfEOtyE5i5LlYRxI+LBUv6F7FsJKeR1SpiVKkhzHnlPaLye/05Aoja2OsEmFi5dfQgmaRx9pbPjS958XS67/thVmIA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6331F9AE5937AB4F9B3FBCCD1A362453@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f8cc08-dfe4-4aa9-44c0-08d7bc6ef9f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 16:55:12.0410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNGeFQ0PQafn/5ng6JeKec02eiysO5x/w+CC62MuPODzImIoltzt07OIiPvKiW9EuWAmJZVuwbF7vtdxOfqrXGV/TSXcraZTvqa0HPjynGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWdvcg0KDQpPbiBNb24sIDIwMjAtMDItMjQgYXQgMTk6MzIgKzAyMDAsIElnb3IgT3Bhbml1
ayB3cm90ZToNCj4gRnJvbTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+
DQo+IA0KPiBTcGVjaWZ5IGV4cGxpY2l0bHkgdGhhdCBHUEwtMi4wIGxpY2Vuc2UgY2FuIGJlIHVz
ZWQgYW5kIG5vdA0KPiBHUEwtMi4wKyAod2hpY2ggYWxzbyBpbmNsdWRlcyBuZXh0IGxlc3MgcGVy
bWlzc2l2ZSB2ZXJzaW9ucyBvZiBHUEwpDQo+IGluIFRvcmFkZXggVnlicmlkLWJhc2VkIFNvTSBk
ZXZpY2UgdHJlZXMuDQoNCk5BSywgYXMgc3RhdGVkIGJlZm9yZS4NCg0KVGhhbmtzIQ0KDQpDaGVl
cnMNCg0KTWFyY2VsDQo=
