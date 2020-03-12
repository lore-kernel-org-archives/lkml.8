Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E8BC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA41D206F7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CC2uiJS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCLXJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:09:40 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:1162
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbgCLXJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:09:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVbzjEzXlteIgwIGtq9aYf6jhKnhFCISC7rTg8z4uD2r08mXHYSOJgdUq4vzwdJ2BI6p+v4bz1KJ88kC4euY4uHZo/xXNOnQgph4yzRVyanxyBldLBgJX6QmUY4jjCoOeLBRx1lYyDfvGDIp3ZnOIuw7fhs3ae0faX/Kq/BtAsKT4Vc51j8zQ1OxdMLIJuUuqA4mo7SUBs6gbAQ3CMZQ5U58phfVHnqqfwI4o44X25CfJyGG3zOkVT0nj0CzrSRaQoWred/wy7ufyjyp8HQLhpjxGOahiLZoEAf70wEVVlHjPkJwh5hqhCZ+v17EExX21D3Kc9uCegtJ+GzdgnLSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G3f1ZSWQim2VgkIcoEGon3kvv5YkNfQ7NAK/0Q0ibk=;
 b=WzKtGKLhQLj3FVJJU9DdJuRbJdh7yABh7Ko81L2MWSd8fab/4LTUkKAygHGXpMtoJaNlj79SYm0dlhTYktTZwr7sgt95bmMHIfpo66cZLVsa7zdM06PvTrb0eFKrlbNcKuO1iaYX7qzc5VqlcidhiS/8orBRkhM//cx3U6jF/FivxCCaccVFSSCQNV6E9RQXZAQqZl07o4Mtsr9Lq+scEQbVfLpfst9cyh6lHAHG9o05lLDZqG08twypQvrJeS/6u+MbwlIKUY3ZmViHy+fwFm2AbzWMbNkjWLboTQmtH8dizJhLSTcSrmeWYuyt3y1ojCn4rlWa9KoOJpplcAcBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G3f1ZSWQim2VgkIcoEGon3kvv5YkNfQ7NAK/0Q0ibk=;
 b=CC2uiJS6GYALpBzrRw2dnd1bJfITH1+bRfhfIgZ7srq5qVoz+rkIDjpDdhiew390hWdUZ+HF7/4qJNj3QmKrQ+XlyQkSKHXxv8cTy65AIWswQJu4LKFCABItdzG39vApp9wZWQax+Mz0lGFDC/FbDADPn5vpF13YimZo4wkV56w=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4685.eurprd04.prod.outlook.com (20.177.56.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.20; Thu, 12 Mar 2020 23:09:35 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::7526:c459:a627:493]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::7526:c459:a627:493%5]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 23:09:35 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Topic: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Index: AQHV8emRabKKTJAuM0OK7xtU5vZU9A==
Date:   Thu, 12 Mar 2020 23:09:35 +0000
Message-ID: <VI1PR04MB7023455D0FE9766FFBE1EE5EEEFD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36489fec-7fcd-4b69-7362-08d7c6da6e6d
x-ms-traffictypediagnostic: VI1PR04MB4685:|VI1PR04MB4685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB46858D0BFF0E5B4D958A70B2EEFD0@VI1PR04MB4685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(52536014)(66946007)(91956017)(33656002)(53546011)(6506007)(7696005)(66556008)(4326008)(66476007)(64756008)(66446008)(76116006)(55016002)(5660300002)(71200400001)(15650500001)(2906002)(9686003)(110136005)(44832011)(26005)(8676002)(86362001)(966005)(186003)(54906003)(316002)(8936002)(81156014)(81166006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4685;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRelKZNrGIiPJ9K4xjHG2+VAJqWv9CWPUa0kAzCDFDIpbwezgkCnRtYr+b5bDT2kgbMrLnWpuDq9x4F2mWb++6qW+vq1/NVkged6UtP9bKtHPsdZWCNloclZdsCDoIfu1jqMCvp3gkZ7cEzzvXfTPU6YEWnpxX1tz6v476GM1a/2dcU8MrEIS/gs9Z3YBV+ac6VrCmRuDvgOxIyPax0r5AtAOrLKJ/KNfE3i+xXGZu02CpUnmv9JZHEo7F+SBm/8+SUpqB8VtNlsFffqLny6IlfbPkxvvOqdWahu347WDq95f9jYDxiHzWx8lbhEvKTEY9I+ziGUDDu5Mcl9snjmDh/hBj8OLBU0jdMZrB9oaerAJwNXuJ0GoMKw8ZwfEh5Eyh3fV6cB6VHMH02Mde4X6Jp/eheLI//u9r6GiB+80XvusfZkKpNZDfZY3hqOwA0Hn44i2nuJPKRzYbo4n87qOAjbLfa5fn/j5t68s/eiwhT1lJaR5kxf7SJfQ/qKFYJJIvY9lVodkKALnK1bYN3/7g==
x-ms-exchange-antispam-messagedata: 1P+8WVn1ABn1Qwke07SECptFyLKI2qA5U8ZjR2d3dvV3IjOTawg/1yxBPMweh7oQzXf7mf3ENUMv8v22As1XXu8wXM77DPOwaW5oXVWkBN/+mkPfg1VoCuW50TjypvqIJUgfLTFpsmX9cIyRrR7KNQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36489fec-7fcd-4b69-7362-08d7c6da6e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 23:09:35.3135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYWx5iE6DjW6BWalIKvOlqupQBY78h7TCfXF10J4HDbcR//+RpbIlJ19RAI0BOJndrotp43KS1AT0xotgiOSlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-04 7:55 AM, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> V6:=0A=
>   Add Oleksij's R-b tag=0A=
>   Patch 3/4, per https://www.kernel.org/doc/Documentation/printk-formats.=
txt=0A=
>   should use %zu for printk sizeof=0A=
> =0A=
> V5:=0A=
>   Move imx_mu_dcfg below imx_mu_priv=0A=
>   Add init hooks to imx_mu_dcfg=0A=
>   drop __packed __aligned=0A=
>   Add more debug msg=0A=
>   code style cleanup=0A=
> =0A=
> V4:=0A=
>   Drop IMX_MU_TYPE_[GENERIC, SCU]=0A=
>   Pack MU chans init to separate function=0A=
>   Add separate function for SCU chans init and xlate=0A=
>   Add santity check to msg hdr.size=0A=
>   Limit SCU MU chans to 6, TX0/RX0/RXDB[0-3]=0A=
> =0A=
> V3:=0A=
>   Rebase to Shawn's for-next=0A=
>   Include fsl,imx8-mu-scu compatible=0A=
>   Per Oleksij's comments, introduce generic tx/rx and added scu mu type=
=0A=
>   Check fsl,imx8-mu-scu in firmware driver for fast_ipc=0A=
> =0A=
> V2:=0A=
>   Drop patch 1/3 which added fsl,scu property=0A=
>   Force to use scu channel type when machine has node compatible "fsl,imx=
-scu"=0A=
>   Force imx-scu to use fast_ipc=0A=
> =0A=
>   I not found a generic method to make SCFW message generic enough, SCFW=
=0A=
>   message is not fixed length including TX and RX. And it use TR0/RR0=0A=
>   interrupt.=0A=
> =0A=
> V1:=0A=
> Sorry to bind the mailbox/firmware patch together. This is make it=0A=
> to understand what changed to support using 1 TX and 1 RX channel=0A=
> for SCFW message.=0A=
> =0A=
> Per i.MX8QXP Reference mannual, there are several message using=0A=
> examples. One of them is:=0A=
> Passing short messages: Transmit register(s) can be used to pass=0A=
> short messages from one to four words in length. For example,=0A=
> when a four-word message is desired, only one of the registers=0A=
> needs to have its corresponding interrupt enable bit set at the=0A=
> receiver side.=0A=
> =0A=
> This patchset is to using this for SCFW message to replace four TX=0A=
> and four RX method.=0A=
=0A=
Tested-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
My stress tests pass on imx8qxp with this patcheset, however performance =
=0A=
is not greatly improved. My guess is that this happens because of too =0A=
many interrupts.=0A=
=0A=
Is there really a reason to enable TIE? Spinning on TE bits without any =0A=
interrupts should be just plain faster.=0A=
=0A=
> =0A=
> Peng Fan (4):=0A=
>    dt-bindings: mailbox: imx-mu: add SCU MU support=0A=
>    mailbox: imx: restructure code to make easy for new MU=0A=
>    mailbox: imx: add SCU MU support=0A=
>    firmware: imx-scu: Support one TX and one RX=0A=
> =0A=
>   .../devicetree/bindings/mailbox/fsl,mu.txt         |   2 +=0A=
>   drivers/firmware/imx/imx-scu.c                     |  54 ++++-=0A=
>   drivers/mailbox/imx-mailbox.c                      | 267 ++++++++++++++=
+++----=0A=
>   3 files changed, 260 insertions(+), 63 deletions(-)=0A=
> =0A=
> =0A=
> base-commit: 770fbb32d34e5d6298cc2be590c9d2fd6069aa17=0A=
> =0A=
=0A=
