Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78AD2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CEmV/qNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHJWGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:06:18 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:56385
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbgHJWGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX77QKODOzb0gmn7S7AK5qqq9+l3s+F+22VNQ960E8FFbkkVyjqVYXCZ0vW/ClDahQVkN8tXTKUIs9NAF9AqA7bxO1Unf7hIc6dicYWIwYKYqmlMr+DIyuZjES5JkvVGkq3XF8Fkkqw4Fg3f3zva4AjGq3QihHiuK/HmVLkKTHa+0fj8Hhc+WxJOa/RFIGBDdWrrztAsv4gtn/7KO++iIDOJuTuxsCRD6djLbvhgwzIiv6PHpEyz0UyOu82tCKbmTm8RBP8f0sgX08OPUa8X6qw/wcVafQZ5GWJ575ulPTCQZu8zWNBkjfE1ebzBtRNujAZ6hBpYBEAz14D9UlThzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GC0AWMCYxt8k1qp6KZN4CJzNWD2QbbltQyYFe/r609c=;
 b=gJTYJGGtW4Cq6GhNCHrBBA9dsudT6N663dZeIfpch1mlGvC7PtIiQBbrqFSPOK7Ygexxatb5kn3PGiq99whILyk5/IQulxX31a7a+msgwmxonPKQZAAAVhB7PmdtalTPBx4nhb9TH5WwG2EMDv5f/WdG/ttxUsk1Aa6qenv5+yMZ1fOsRCzM8ab7sVS2lZSv6aeGFLXXJYsAmH2e/5xsvX73PUz+yUKfv49sp51+BW2y+YJuhlnlyTlOCvQDl/wgX8QBAyRQ4ZTuchVakqsGyI8uswBnY400I4un1E3eeVEWhH3mJ/fARJc3URHQEKs1Nhd+fbxrq+8iFOLTgmthhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GC0AWMCYxt8k1qp6KZN4CJzNWD2QbbltQyYFe/r609c=;
 b=CEmV/qNOLDqP4kCuV1zWt6aNyQ7bVMwi3M2n4zQDqtgo/dYp7L1ytQJOtdZD/F+L2zlsdZJiHa21EyBHdHoOUB+WbDs22tyyJn76BY8eJsDMkvrassFNkf+2cAlcAYb7o0p7SuDItb2UhM9h1BAtrrICwJsCITGvnDarm53LsG8=
Received: from BYAPR02MB5622.namprd02.prod.outlook.com (2603:10b6:a03:9b::32)
 by BYAPR02MB4503.namprd02.prod.outlook.com (2603:10b6:a03:56::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 22:06:14 +0000
Received: from BYAPR02MB5622.namprd02.prod.outlook.com
 ([fe80::d8da:2168:b766:539a]) by BYAPR02MB5622.namprd02.prod.outlook.com
 ([fe80::d8da:2168:b766:539a%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 22:06:14 +0000
From:   Amit Sunil Dhamne <amitsuni@xilinx.com>
To:     Amit Sunil Dhamne <amitsuni@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "m.tretter@pengutronix.de" <m.tretter@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <TEJASP@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/3] clk: zynqmp: Add firmware specific clock flags
Thread-Topic: [PATCH v3 0/3] clk: zynqmp: Add firmware specific clock flags
Thread-Index: AQHWairFarR+Mi/aekCugQ3RZGdA0qkx7/Vw
Date:   Mon, 10 Aug 2020 22:06:13 +0000
Message-ID: <BYAPR02MB562261B10DBF08A58FF066B2A7440@BYAPR02MB5622.namprd02.prod.outlook.com>
References: <1596523457-40465-1-git-send-email-amit.sunil.dhamne@xilinx.com>
In-Reply-To: <1596523457-40465-1-git-send-email-amit.sunil.dhamne@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [24.130.17.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc0cb116-18c0-4315-5052-08d83d799929
x-ms-traffictypediagnostic: BYAPR02MB4503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4503409830600FBF14E290D1A7440@BYAPR02MB4503.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIrKhuK0t51qMfQQyRKIql883jp4il6FsknmA1NRxnSN1xm9fZr13wiTHR1K63JroTHBGiIqdKV4mhUT/6NFPC9RCmYWSrRBsz+dDEYGvsfkPBx6QbuyIflZe+wzB995Iwx7YDaUYPvj1+C5B4kCEJED+TKsPwnqyNvAFTDBpCmhoi8KCa1tExPssFeAbfWVM5JcAj3COVWn2NsXSOMKLfiEBISm8PfC+AEAJLg+/SeLRHqJJKHw+4qDOxtIJMa8ZIrXv4rQiAeWs1inNZGsXGsWxp6sIiMf1yFelHibGMgQsrqZEXBCYufzL+DsPuNNNks4EkAU6emdTU0embwNyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5622.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(8936002)(5660300002)(9686003)(86362001)(55016002)(2906002)(83380400001)(64756008)(76116006)(66946007)(66476007)(66556008)(6506007)(53546011)(33656002)(66446008)(71200400001)(52536014)(110136005)(7696005)(316002)(8676002)(4326008)(478600001)(54906003)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Q6c2M00JSxAxep/s5QMyybbfaf5R+lcjCMWTiFoFM2ZorPmznV/4oa/GtEkLLeggJY8H4LU7vgS0oHiGhcW5Y420EIJtU5pKJeQFbT/cxGGS111leeMEvVSZxsQ5QxxFOBgbO/SLuSTanJ5K1K/qetnIVOhLYq/BITGwhH+wva4YHdCpgN32O7nrBOrYFClERvTOhei/FxTYWcxL5did19Gz4Gm0GLTDA4a903xu28h1FSCDiRYrwZcr+hdyFcF4AUylSsSTAIlHGTFWOo+EwRbjfV2yvfd/nKMFu6xnjkNEKlrFBAOQYPClcN8orS1FriELCNjtNMFyuVvlQanQ5Sph830GdQ7OXQo7Ozg6eoFQw0XBDPAPplszw73MaTT2qEOR5UeH5FbVHTAh1lu/PkPTnPMi9xV9iJbDgmwKQf562OUQM3NvYquuV8A6BEQhvfRk0a48p38/M1sZqtcKUvK6oQCYHqKEcdwaUhQ7LmMS8x6m/ixeJSemK5O0y6faQnSwF7wVuWT/ghFGHLhQInT3W3xDr4GiCYOX/HBrlqSUc2LBlMSW2b2Ko+bUWqD1rigK54jDzRFQMvkpkRV0aXPRctX3EhNpahcPzawG68R+b6ChVhYrDrmghrE0mFATW+sq6nN23xyWq77opqNo2A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5622.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0cb116-18c0-4315-5052-08d83d799929
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 22:06:14.0932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZSkRwJ5Mj9DPyjwiveIAhIRFxpyUPhi0ulMvn/hHfbn/AafpFZcn3YpeJkb63NpPx1x/GMQwJm3g00QlwhJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Reviewers,
I wanted to gently follow up on the review of this patch.

Thanks,
Amit

> -----Original Message-----
> From: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> Sent: Monday, August 3, 2020 11:44 PM
> To: mturquette@baylibre.com; m.tretter@pengutronix.de;
> sboyd@kernel.org; Michal Simek <michals@xilinx.com>;
> mark.rutland@arm.com; linux-clk@vger.kernel.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Tejas
> Patel <TEJASP@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Amit Sunil Dhamne <amitsuni@xilinx.com>
> Subject: [PATCH v3 0/3] clk: zynqmp: Add firmware specific clock flags
>=20
> Currently firmware is maintaining CCF specific flags and provides to CCF =
as it
> is. But CCF flag numbers may change and that shouldn't mean that the
> firmware needs to change. The firmware should have its own 'flag number
> space' that is distinct from the common clk framework's 'flag number spac=
e'.
> So use firmware specific clock flags in ZynqMP clock driver instead of CC=
F
> flags.
>=20
> Changes in v3:
>  - Modify helper function signature to map zynqmp (common)flags with CCF
>  - Add helper function to map zynqmp (mux & divider)flags with CCF flags
>=20
> Changes in v2:
>  - Add helper function to map zynqmp (common)flags with CCF flags.
>  - Mapped zynqmp clock flags with CCF flags from
>    zynqmp_clk_register_*() functions instead of
>    __zynqmp_clock_get_topology() which is changing the flags to struct
>    clk_init_data instead of the struct clock_topology.
>=20
> Rajan Vaja (3):
>   clk: zynqmp: Use firmware specific common clock flags
>   clk: zynqmp: Use firmware specific divider clock flags
>   clk: zynqmp: Use firmware specific mux clock flags
>=20
>  drivers/clk/zynqmp/clk-gate-zynqmp.c |  4 +++-  drivers/clk/zynqmp/clk-
> mux-zynqmp.c  | 26 +++++++++++++++++++++--
>  drivers/clk/zynqmp/clk-zynqmp.h      | 41
> ++++++++++++++++++++++++++++++++++++
>  drivers/clk/zynqmp/clkc.c            | 32 +++++++++++++++++++++++++++-
>  drivers/clk/zynqmp/divider.c         | 29 ++++++++++++++++++++++---
>  drivers/clk/zynqmp/pll.c             |  4 +++-
>  6 files changed, 128 insertions(+), 8 deletions(-)
>=20
> --
> 2.7.4

