Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CDAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9731920872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9upsL9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgEUKv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:51:58 -0400
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:41294
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727844AbgEUKv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:51:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly5rylFm5T3FEQ2H9NZAwO0MpCmvzNDIHL4AodwRzBP6fH0CSxCtQTh93PScRlzykyXWxJ+VN1kog8V5nX4OsNrLdTUPHVueyffS5APkCkrXwlYmXVPs5/TmJ4lkpW0Wh/XCQiSRNVuyZ8RbUfzDAC/WTT+62l1Cv1e3FGH3Y5jjmwLBIGLLqQCF/eg49fBQY6f2o+unrUMmhExL6dMrGDPZXcodlGkxp6dbg3ePUwyVMu5oBLQX06nFDvUVY6IJlpFe6Cvk55ium+e5jehgwEK5P3Q8KzqQkWAcPvroDUqKiYXZdPubCdpufDVO1oNaoSk4a5ltMPvTG4SOPlWZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuRf7bBgjnMEpGLEzVToFRbNj5OSXi8NVqxAFr7BrAA=;
 b=QeIRV41KpNADG4Gm+nyg/8ISKJkQGjgJzFOoWyHTKdNYAWVqcalu+4OY5ihbyPRQ7QcT54XAFpmKAi88pOK3OciGVmDvRiK+p6sFg0wSZ+ch7O5oN5G/dC50OsAWgQ+qHClOgOkb0DcioX2SG8rSQKLzRv0siRanBd0mF3TH0aksHFf2igkiwSRjfysCF1I8VIYxAZXmyRzcwFClmxLkjDSq/gA2JYSATl+rlg0sSV4x8oWT6uITRbOmZiQ9sDksFXe+6Xp4HKthiV8NSrWYuX3oByqJk6wL5mztrF1lFcFoV4SGl7EGnRryXkjEnGFFey8evny681KWgZzwLyuXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuRf7bBgjnMEpGLEzVToFRbNj5OSXi8NVqxAFr7BrAA=;
 b=j9upsL9ZcIg60GY5zPWIFU/e6UCB3PDrulRzJOyrMZ5+s4YFKoim7J3X6pOjQycP8RtdiyqXS8yPeakL1LDOhnJH0L8kHQbFv82uVQoayaT0RPmToA+ARdyCV6nNeLHs2nLtMmIjlzjR350Ge2lYwsm+y7A+Z1PmGXKWvr+vyKM=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4454.eurprd04.prod.outlook.com (2603:10a6:20b:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 10:51:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 10:51:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Robin Gong <yibin.gong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
 voltage range
Thread-Topic: [PATCH v2 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
 voltage range
Thread-Index: AQHWLzeILROxon7P5UGNR8Ds0umXe6iyXSDQ
Date:   Thu, 21 May 2020 10:51:54 +0000
Message-ID: <AM6PR04MB49662AC5F1859E61796A960A80B70@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1590070674-23027-1-git-send-email-yibin.gong@nxp.com>
 <1590070674-23027-2-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1590070674-23027-2-git-send-email-yibin.gong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a340ce2-9c83-46a2-e78f-08d7fd74f9a3
x-ms-traffictypediagnostic: AM6PR04MB4454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4454E188B1ACE711C470A62C80B70@AM6PR04MB4454.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qeOb+qXLMNe8rL7SeK7lNz3wA005MBsonxUJbzA8bGcH1YQ74Oh8HmRPGRBDmR6eyZ5l49CVCL5z4HjIiMeDUT3OvGCM5jfB+YNYqNYF3ZM5UdDicC5KXFRAnDgUeI3D7Bqk2OXKisBN6wNv1XBJAubGzwd+P0lzKUnReGK/yKLVMvfoD8u+zFzEb5tx8dmTLL/89vFyVbUN8vBcgp+dgh867eQib+CSfYNf0i3jP5X/hPjIuquscB4r72RHYTNUlRMGvV71ZCa0JTBofyoXjTmBae4g0jBgFmZBleYCC/y4TtGWXYwh8OJ3MZ4/SOYYEDWCPdatI+6Cy54bYKAe5ukFk6rWpvMzm0l/eRiwM3+8lPhHlmjgYAvFUNeV+LM4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(4326008)(9686003)(7696005)(52536014)(8676002)(186003)(8936002)(6506007)(55016002)(110136005)(44832011)(26005)(2906002)(86362001)(316002)(76116006)(66476007)(66946007)(64756008)(66446008)(66556008)(54906003)(71200400001)(5660300002)(478600001)(6636002)(33656002)(4744005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SqvdRuvH+bhUABTcJKK9FXjtWYW/RQdGITV7J6+8O8YXO+zn8VzQXP6U+ripfUR1bGwFyF1D36MMum/x25qu84+Xf9G3m4ikUAvIWo31AvrJbk0IckJOB3dNKbY36RHt42lrULmncVNfFdN/Vh2up4Oo5i/ttoCkBEutKHlnSk0Csa06vaJEOv+HoeaIzdgzeC9RT6iDzBPuP2VVwPfdPgkUQV1kbdHl52o1e9CUEZB5lAAIsNedyM3QeogHvzvGMlWw5kXcJvLmcU6p/CPf3SZW0Qyjt17g2fGmaFgk0xIzm4O9VeCkjCVoch3LO/afGZgZ9iNx9RWYhxjDrFBp9zMs6+rQi6VAZthSCv35qNcE8XgjVvOJ+xMiveUtJ2God5DUZPrpOxeluqkHjyYLQqKbMk3gC+sOefMmNcyshlVVXdHT5rZuP5N7iBkzhM/hj2zmJbrmYKh85+vtuCzM7qvDk3xuEFrv4yfAb6aRKmXopXGnXtV7gE4I1mlwPnvq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a340ce2-9c83-46a2-e78f-08d7fd74f9a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 10:51:54.1297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHgrYYHUdF9yJKScm/r7yzOBFL2IV9Cs/Yjucp/aIx517lsG80tU0nV+Zocol3xbdZzSh8e6mi/qbt2w5X6/SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBNYXkgMjEsIDIwMjAgMTA6MTggUE0NCj4gDQo+IENvcnJlY3QgbGRvMSB2b2x0YWdlIHJhbmdl
IGZyb20gd3JvbmcgaGlnaCBncm91cCgzLjB2fjMuM3YpIHRvIGxvdyBncm91cA0KPiAoMS42dn4x
Ljl2KSBiZWNhdXNlIHRoZSBsZG8xIHNob3VsZCBiZSAxLjh2LiBBY3R1YWxseSwgdHdvIHZvbHRh
Z2UgZ3JvdXBzIGhhdmUNCj4gYmVlbiBzdXBwb3J0ZWQgYXQgYmQ3MTh4Ny1yZWd1bGF0b3IgZHJp
dmVyLCBoZW5jZSwganVzdCBjb3JycmVjdCB0aGUgdm9sdGFnZQ0KPiByYW5nZSB0byAxLjZ2fjMu
M3YuIEZvciBsZG8yQDAuOHYsIGNvcnJlY3Qgdm9sdGFnZSByYW5nZSB0b28uDQo+IE90aGVyd2lz
ZSwgbGRvMSB3b3VsZCBiZSBrZXB0IEAzLjB2IGFuZCBsZG8yQDAuOXYgd2hpY2ggdmlvbGF0ZSBp
Lm14OG1uDQo+IGRhdGFzaGVldCBhcyB0aGUgYmVsb3cgd2FybmluZyBsb2cgaW4ga2VybmVsOg0K
PiANCj4gWyAgICAwLjk5NTUyNF0gTERPMTogQnJpbmdpbmcgMTgwMDAwMHVWIGludG8gMzAwMDAw
MC0zMDAwMDAwdVYNCj4gWyAgICAwLjk5OTE5Nl0gTERPMjogQnJpbmdpbmcgODAwMDAwdVYgaW50
byA5MDAwMDAtOTAwMDAwdVYNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmlu
LmdvbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25n
QG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
