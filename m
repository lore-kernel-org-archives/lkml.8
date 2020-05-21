Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1225C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0ADA2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M3IvwfRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgEUKvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:51:42 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:35766
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727013AbgEUKvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:51:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eikGNZQFMKguwJar4gBtl48Myfm/XBNi1ijR9U5GD9cKKuNDNPpc44SKdJDHosxWOwShZEgHSQ+PuOA2RSFMXHb+P2KWogFY4SA6/qav5vKkpysL1/aZfbAK4ebmO/1xSXkIU39WKEnOl//gZYztfqSVVdPFkIk9jxBNm7TEGDm4KXoELqOQXqGV87aOw65VZ+ZXZLg5mPlZfKIKXiHD+ztC7gR5cFZIkicK0/e6L5HancPKrmG1x9vRFQqFLjzesyFc5a/oW2ExQJ86++SQ5IPFQAyV/Pg8oHp6HPVbX2itHoGSaku0UiD+AFwoikjbD9R5MRyA4AImepJ1VgPEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeWkf6eAUBtEGcv0/d2oSPrgMHWr/jvGoHLxoyHUAVM=;
 b=fCSzdDe2881+oKcG5FE/8RC+Zj46FsEQd8vLALPWZ6eHy/HHaJlCRPoHDfOcdpdGre7SeYEYNMqPLeaqEl4YA4dc4csQPKnHwAjpbU5Qxy9SSdexiO0GN5CUF7dJNSSSjleCLPRAZtv+gRSNfSew0jqjxm2wyMsQpeR1RyV17872y66eeCX15NAOCIewSf9gD1y/A+wI4grJnshHe7eMxCIAg71YHTia910ZL0G4nsuNOyqsZ/7UTnC/9nxVDhuRBIQqJbress5r6U497jyuz4tw0L+Tjzx9i7FIV+1wl0IAyfRK7EOuzAEDG6PlyoPJVy0LgeWeLU/wges0X7Ccsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeWkf6eAUBtEGcv0/d2oSPrgMHWr/jvGoHLxoyHUAVM=;
 b=M3IvwfRsmUijYHZZm7ULpccZ0neJ53em6XouTSuqArwPTsbFrVIs6tw0AYFzBUywBqScOsCHWf/l9eFSd8QbX1tP+jYvcZ6jm2BsKQWWat6kwjoYr7TwXuCqg1EourEZcJKe6flTV5dMtou/0vJx0RF5AxtYws3XUvXpEWUWRz8=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4454.eurprd04.prod.outlook.com (2603:10a6:20b:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 10:51:37 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 10:51:37 +0000
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
Subject: RE: [PATCH v2 1/2] arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage
 range
Thread-Topic: [PATCH v2 1/2] arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage
 range
Thread-Index: AQHWLzeGuEJZhZiDNE+QlTjmZZ7cNKiyXPsA
Date:   Thu, 21 May 2020 10:51:37 +0000
Message-ID: <AM6PR04MB49666F2BA7A2AEAB6F04994080B70@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1590070674-23027-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1590070674-23027-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 137a89c0-206d-4ce7-c000-08d7fd74efb4
x-ms-traffictypediagnostic: AM6PR04MB4454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4454CF2EC41CF4A3F811797F80B70@AM6PR04MB4454.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUXpcARQjZ18pkvw1IOwCJVA/sNllcZLbLeKuz7OGiE5ATZix0VXlXtoSPuk2FZLWiOvRDxPfrrs2F7aFdnXP38E6jQHszO2zyVtpnZss1nEt5TJUSgrvGHo6EKBBBWJD0eINifWIl1/J8f8+/N31u22MvK9QiHNEynUEL20JHqSnhtZa9+M7SnLIS663czEm6dA1CokolPSwjqUQ6Qb4USDcTnTxCgtAioFQ0NmIuiNBPOL5NnLDIHXKrCMQhowUFbXpv4IJPvJscPW9wD5ztD/MrbVxdZQaSxycPZrcnWYsWjtpF4hLL/PlTaYAwxFuslG8hNdplplZkuCUnfSJgt+EQVzAJSIHoZPXzb4ZOu8wN+w1ysFVGwFpBDZZMuk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(4326008)(9686003)(7696005)(52536014)(8676002)(186003)(8936002)(6506007)(55016002)(110136005)(44832011)(26005)(2906002)(86362001)(316002)(76116006)(66476007)(66946007)(64756008)(66446008)(66556008)(54906003)(71200400001)(5660300002)(478600001)(6636002)(33656002)(4744005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xyYVIDI/BO65G5RfW28efKoJfrObgQFCtDesNSigdBqSR4k+m3BhRnue0WLmNbSgBNz7tKHPZ1eR29x2VeJUFwcZpqhGEXxEtQc70rZnEl3rFNrxwR96JXuFDlTcIuEgANogTaceBm4RYZJhCybb1EWpcjxRGVp/n+8OBO9FtmW8GyF47/81KfTjtDzqstHGEvHkrP1rlYG2mkqct9T6dyo6QDq2ncNpCONnvMENxm1WcwZ2g9KN6s5z/TsgaQdyXNIeVXFyrkxf8i1Qb/IRiqknPQG3uzcp6MeyQZid7D3plOW8d9CZ0hc0v8H+WqDzbcdKGPLUFuGPfiWguwpHmOn8tm8S6u1Hfywe7hA6P3rGGyR3un6AKC1U+UFL4YV/xMsiUJR/P4qyX3wYQ/La9hbVQVmSC5skPXTz6vNiX5zHa1QRKGByJwywcuSwZ7zyRc3boYCJLLOBzL1XKOR+Zc/QlAQZM3ircjV2Uk+6Fp+OjJpnd29rihAFz5zQvC8V
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137a89c0-206d-4ce7-c000-08d7fd74efb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 10:51:37.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl+LKQkhUgwF5QM+ega00kiyswtCYcNiUl0pYMXa2R9nrD7UjMvd3AaEle7t9R8j1TaG/N5tOTS6eBKIZ1WO5Q==
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
Lm14OG1tDQo+IGRhdGFzaGVldCBhcyB0aGUgYmVsb3cgd2FybmluZyBsb2cgaW4ga2VybmVsOg0K
PiANCj4gWyAgICAwLjk5NTUyNF0gTERPMTogQnJpbmdpbmcgMTgwMDAwMHVWIGludG8gMzAwMDAw
MC0zMDAwMDAwdVYNCj4gWyAgICAwLjk5OTE5Nl0gTERPMjogQnJpbmdpbmcgODAwMDAwdVYgaW50
byA5MDAwMDAtOTAwMDAwdVYNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmlu
LmdvbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25n
QG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0K
