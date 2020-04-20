Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74159C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D9020775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dlwWmuA1";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="J1REPUv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgDTPqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:05 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7814 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgDTPqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587397564; x=1618933564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IeixYrnq8WBuQaD8WkLO6TuYgYWiEAIkJmmt0/8ojTs=;
  b=dlwWmuA1fAQAg+C1CoDeJavmnwCnSxOrbRxObumgQ6BauP9Hsn8zLAx7
   5F9tB/SYm8myTe6ZmY4IqaH20vqt7ZyFOcCq2h3eOqE8pPNBN+9WUqLvM
   lw1HDaqUbCgR0+jK/TSIexyc8sPx43pxlLy3J5RCUvbbndW6lGjRSEu69
   r2FDGwQUAEN9pK6/ZSo1+HpSD9IvZxy8BUSyOCSmutkKn0O73Qh0Gt1cQ
   YA3hxgkWtSBrTg8BR2oMOqLqA/VMHIHwHItfObMny6qQv9Ws8U7orX11h
   2B2N3KXe+15qffs56GtVcpTkKOdFCoLkit0B3QBMrxuxZFKfHF1hGGVZk
   g==;
IronPort-SDR: mGQBMKhE8bVolKRXywiDcqOrWpP7vtGf2LSwmP63YSrZ/z66q9KdH9U2Ue9/AFjdZsSW1y+SUy
 63sYWGnw8fTa3H/ep665itUAP8xBgQHsMoqV3G/aGDmFFSNVSpCfzpeCRVfqYLgXosE0QYzQmg
 3qsX12CZokt8UaaVNUH7Nod0DvXPzEOWi3FHLwdzwEHnXT8z+9VZJ/ke8ej1qmqgvGjsApwp8n
 3xsONaPFiu5IRLdH4fyYDPQsvYE0YIhhFQ3VbkecHESC+xN+j3/FhaLgHGLJf/XM1T7jAEEI6K
 3Pg=
X-IronPort-AV: E=Sophos;i="5.72,407,1580799600"; 
   d="scan'208";a="73916794"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2020 08:46:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Apr 2020 08:46:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Apr 2020 08:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9qgvNAE9OWsPTuTklF4GHKeEp5o+aqn8yCLXQEQ+SV2feUJmA0qjVu0nsqpiPv/flBNRfJyqy22dmn3qdgt6/82moaZe50m/ALJ4nUHYVt2eLyHxOsmYXQyesCChltKPrbDIr00Tzm4dRzqm4S7U1smTOQoQWu1QLw1NBZcIjlGV565hWoJO4G2dB5cxCyc6hhcMnsSDWUaYB/BRJoHh8pof1nFfG1PGoHztFN9/isoYaWttobCfBmqL31IR/ZjSDZ8JGP6xoIa/E3O/EHwacN0SHV26tNRiTz+AHqUYy4QdioH5daoVc+CZmmJtt5AmUVPRVPRnAvtYX0uvjm96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P84WZnxdce9MQKhpjBP5O9EyHoER9WVXIe3XM6UMtbI=;
 b=X9KsxYOnwL60JpvguUr3eewF9MiDCkZ8IfZ4ZWQFULPGMH6lWmFC42JCQZ7Urgy2TD55v9cF0DKvA/bizmOUj/c9vQWvF3lOAiWFKsTSaN/QJ2RzHFiNfEdWGF11CaFlLVLAhqT1lP83NoYBaRBGpNnkJY5LN+vQIzqX9DqNfjsBCaJChMt7mX6l2u7b8vdmyNor+6pQ0mT2vPrDZH7rmYRXP+ql8gQUOBF8e/wWULt6VyWFKJLlomb02LhwBkGqKfA6bySKml9U+1CfB1pJ5iAQd1dLfu9IgX9uFbTL+zuYN6+5OVNfbTMbhOTI2C52HRqMgubz4gQahtDiQcqTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P84WZnxdce9MQKhpjBP5O9EyHoER9WVXIe3XM6UMtbI=;
 b=J1REPUv5+XEcIX6gT8fnLnYawKeBc7v3HaAvMXLrQMZSh+pVqaHZgVEb/a7jVUkKtbkXJZE6Gxq3ZmtR8ECg8mkArKDC0H2TbGOeCriSIUCQRUneIXgBAreN8/v9Wcb/ngh7KBtcbWPrUi76w+R2+i87u517DZo/C7xBhTzSAV4=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4194.namprd11.prod.outlook.com (2603:10b6:a03:1c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 15:46:00 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:45:59 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <danielwa@cisco.com>
CC:     <xe-linux-external@cisco.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to n25q256a
Thread-Topic: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to n25q256a
Thread-Index: AQHWFyrJEeAl1Y63FkSdbq93yQPoxg==
Date:   Mon, 20 Apr 2020 15:45:59 +0000
Message-ID: <12178429.kzmL6e4XO6@192.168.0.120>
References: <20200417174620.16420-1-danielwa@cisco.com>
In-Reply-To: <20200417174620.16420-1-danielwa@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a1e47db-3ea7-4456-9c8e-08d7e541ec79
x-ms-traffictypediagnostic: BY5PR11MB4194:
x-microsoft-antispam-prvs: <BY5PR11MB41942B8E643FF2C9330D28D7F0D40@BY5PR11MB4194.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(186003)(8936002)(54906003)(316002)(4326008)(6506007)(53546011)(2906002)(76116006)(6916009)(91956017)(26005)(14286002)(5660300002)(86362001)(8676002)(71200400001)(478600001)(6486002)(66476007)(81156014)(66946007)(9686003)(6512007)(66446008)(64756008)(66556008)(39026012);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6oHxLfRo0Y0wxilN8hRjzjQm3iqI1EfXjDU0APTx5l1lfJlH4ljWnxOrjS8KDt2jgYMfkJq5SJddWNK+PDMkvwrvu5qdlu8qfRSrbNezvmCUXGcX30aS4FkRJynszESutseLgFHh4Z8Jvon5B+a2I5gn9pj7qDnYcdnCEK0CXl7GivOLKJHIBG2pPpp4Rc5ZSOW3qAfpvHxH7i3UFgrHo4A90un3PoX6uUNFIkC63siE/rT5dR5YeMcnIQL91x4Q9tqFHxZA4i3f12sPfCN0GaPG3O8eSdheMXoEiW1m6q2XjiM/7Qp6ndgW99ZjZAZliyQ3kM12mpU28kUNsRQWjFjepxIxKdeB0kb2+V9smcVyvgh7R7bhZpwLe0nXrwMAE72NSTPATYJGvBSLXYdaNTOlBfWjB2WRjEC9PUqJLMw0s7OKWUkPcHz71m8FEeGnxvNnmcLhNtub8H6w5J2v/Hhbivsi/ozqKMla1Z1qFvzuzQCCirbWMVkiRwNoZRk
x-ms-exchange-antispam-messagedata: Raz3Ec11Ui3nauPWLK2KcjyMbx2FQ637lseDaRoE1ShEpZEBVYgJLN+n3X2nLFC3NsE7+ABxN5soZfyM579r3erkelFbNO3zuCCsiuUCvsNFo3CLa3ANAHFkUm8jF48bx34XbazYAn9/YY+BM7xdcg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC97DAEC90706F478E1DDCA65DE4135E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1e47db-3ea7-4456-9c8e-08d7e541ec79
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 15:45:59.7853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qb7OpoJykMzv08Ugjdi5wpA3XwztgoOnUVswVWue+i2pRvkIpE+XfyTj+2JATTSVH167HRg7cZ8HDVBckcCR8E41XLJyIRIUfdqwc+N00AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

On Friday, April 17, 2020 8:46:19 PM EEST Daniel Walker wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> The n25q256a supports 4-byte opcodes so lets add the flag.

This is not true for all the n25q256a flashes. SPINOR_OP_PP_4B,=20
SPINOR_OP_BE_4K_4B and SPINOR_OP_SE_4B are valid just for the part numbers=
=20
N25Q256A83ESF40x, N25Q256A83E1240x, and N25Q256A83ESFA0F.

You need to differentiate between the aforementioned flashes and the rest i=
n=20
the n25q256a, in order to add the 4-byte opcodes flag.

Cheers,
ta

> Tested on Cisco IoT platform hardware using Marvell A7040 SoC.
>=20
> This patch was base on one from Guo Yi <yi.guo@cavium.com>.
>=20
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi-nor/micron-st.c
> b/drivers/mtd/spi-nor/micron-st.c index 6c034b9718e2..471fe2bc2ba4 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -37,7 +37,7 @@ static const struct flash_info st_parts[] =3D {
>                                SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>         { "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
>                               USE_FSR | SPI_NOR_DUAL_READ |
> -                             SPI_NOR_QUAD_READ) },
> +                             SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>         { "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
>                                SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>                                SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> --
> 2.17.1



