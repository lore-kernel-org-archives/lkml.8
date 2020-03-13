Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52CDC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C94320637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QRCyIDgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCMBHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:07:10 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:15511
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbgCMBHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:07:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOPp6+en2SP3fcX2YeNA6KdNLGOsAuXxVcSBLDqCylZ1SxuSmjAWXwXcD38H1FJ3vgeEyhO5MGItqmztXDzqdUN1hd1PXt9LFFeWidpAy45ddue7EmakiYh1MmS3JxwqWcotkdVt02oiFX/QUMO+X+VCks6nEdERYln9WNGJo/n0+EVWGACrFylp9jzgQmk1/US2N9cFEsi08Q5DGOSo9DDBP2bW9qS5INzvwreT0w1pREFtdxu2QtvN2FF6sGE0QocmN3mptPoIOdfuag1VH/dOt3eppg0XXOOlHwRDp8LtyyLuvqlK1xRe7OtwaANzMsBhDEOW5OaeZZRaAh1teg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5niwCAsrxLTwgaXbUvUZX5n1KE9z0NUD17qbohRrZ8=;
 b=iFXHaMtpWM7HRWhgYm/K82neL+poSrzFRlcftI6FiUYb6zsXfbVUGnE6EEsJymgthj7zQra3mtROvMr7UMhmwTCXpJHx1ScjvY84y4YzXUDr/SC/Wl/HcVjYqxL7yaVkB7cbQH2jbi6KlI4FFDjpbFniQVsE5l9rRCcUC9LmK+w2acLXAUSFcLm8E2nYUiStf8cTPrFqSThdIoOr8pyxLTJl1EY3UkZ3zsb2EFt1sF4XipMPiTkjf5O+iOLO9BZHR0NEE6D1qCfjJh6hZmkuuu34/cpDe1LfkW2HhdFh13aZET152D8XJz/EpeogaXIf/T4jc1lmCiAA7K2ayFfQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5niwCAsrxLTwgaXbUvUZX5n1KE9z0NUD17qbohRrZ8=;
 b=QRCyIDgEpuMS1YkvWIgHQzAMMwVrBtSfdjEMF+DX/jzcvkYa51avb814SJEXR8QQ6rn3g2o8HRbcNTLY79L8ckp0ml03LLfl/CQv+KlGBXPSSXHvHgy+SA83cc93UMG/zYfWE/hBLnhtQ25uJYHyGCpuAf3OIGjCjR71p/LSV2E=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5986.eurprd04.prod.outlook.com (20.178.116.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 01:07:05 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 01:07:05 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
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
Subject: RE: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Topic: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Index: AQHV8emRGg+Z0s59ZUi7vGFwjsJP+qhFwwug
Date:   Fri, 13 Mar 2020 01:07:05 +0000
Message-ID: <AM0PR04MB448123609B2FE8F5ECAF1F4388FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023455D0FE9766FFBE1EE5EEEFD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023455D0FE9766FFBE1EE5EEEFD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdbedf90-873d-41d4-03f1-08d7c6ead8c7
x-ms-traffictypediagnostic: AM0PR04MB5986:|AM0PR04MB5986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB59862449CF87B73670A2452588FA0@AM0PR04MB5986.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(8936002)(81156014)(81166006)(66556008)(44832011)(316002)(33656002)(186003)(86362001)(26005)(966005)(66476007)(76116006)(6506007)(53546011)(66446008)(64756008)(7696005)(54906003)(66946007)(110136005)(71200400001)(52536014)(15650500001)(5660300002)(9686003)(478600001)(8676002)(4326008)(55016002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5986;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 63cYTHs4W7nyoR4T8VXkEcNT2ar2aY6amDo+xbb5CoCAAy3sWMMSz4REz1Rodk90n8uuS1KtsH1JKa6HWt6Pul5ROE6X27rVNXXl7ux9BHM8kgcAsoNDBH0H1WE6qmCAQr3SfQmqip/O5INrkPfh+++WmWpSSY89m/3/XwhPfR/egQbCGrxl2HEASmFBWLE1MFU0IgS9SFHki2z867wzWSF0cvukT6PWab/TgEjsW//r2Nax/d5LUYIcQa0c74Yd5eYz2AOK2lP8id4/UJzgeiBaLpIc8rw/c5x+HbYYehDBAxDvxgoysOYSZUKCXAtmLZFDUPfcZ/3X63x+KxNmBp9hnTiLnKsJ4Eo2Tc0ObOc6edKybAnfvfir/ZvQaU6OPdu4SC20bXcog1rxeKbsMNK6WNqxxuzM1legKALPu3Fr8JJ5aJyZa5WzyO4mVqQ0fL+kuwtYrSKPLMk7c2kn8GdzDZzUkCqhO7zaDbSZ5mlrXmGmc7OGS2O9OVA4iA54yPiqskUBwRWVM5vAPAa3LQ==
x-ms-exchange-antispam-messagedata: mZ3MFL3+CSaxjVvbk3RDE+XNWgS1E28Jlwf+ppBJ3Rvq9jlukQF2xHkqj1YoEIaBZt+1MlGWDGBGKajEuhF+fiUaVdkymI6UPKDLX/39058pYxo7Y99134U8J+hpsiPhneehhX7drQbMfwfN0E0YdA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbedf90-873d-41d4-03f1-08d7c6ead8c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 01:07:05.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnEjNKtpOtd4hTaUVYDTjfy+SEV458dOCLKBg2FX7WmQ6K5FSgTxLfa9CrBB7CfTFSyN+BjKG4pL2Ya7WoPRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

> Subject: Re: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel
> type
>=20
> On 2020-03-04 7:55 AM, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > V6:
> >   Add Oleksij's R-b tag
> >   Patch 3/4, per
> https://www.kernel.org/doc/Documentation/printk-formats.txt
> >   should use %zu for printk sizeof
> >
> > V5:
> >   Move imx_mu_dcfg below imx_mu_priv
> >   Add init hooks to imx_mu_dcfg
> >   drop __packed __aligned
> >   Add more debug msg
> >   code style cleanup
> >
> > V4:
> >   Drop IMX_MU_TYPE_[GENERIC, SCU]
> >   Pack MU chans init to separate function
> >   Add separate function for SCU chans init and xlate
> >   Add santity check to msg hdr.size
> >   Limit SCU MU chans to 6, TX0/RX0/RXDB[0-3]
> >
> > V3:
> >   Rebase to Shawn's for-next
> >   Include fsl,imx8-mu-scu compatible
> >   Per Oleksij's comments, introduce generic tx/rx and added scu mu type
> >   Check fsl,imx8-mu-scu in firmware driver for fast_ipc
> >
> > V2:
> >   Drop patch 1/3 which added fsl,scu property
> >   Force to use scu channel type when machine has node compatible
> "fsl,imx-scu"
> >   Force imx-scu to use fast_ipc
> >
> >   I not found a generic method to make SCFW message generic enough,
> SCFW
> >   message is not fixed length including TX and RX. And it use TR0/RR0
> >   interrupt.
> >
> > V1:
> > Sorry to bind the mailbox/firmware patch together. This is make it to
> > understand what changed to support using 1 TX and 1 RX channel for
> > SCFW message.
> >
> > Per i.MX8QXP Reference mannual, there are several message using
> > examples. One of them is:
> > Passing short messages: Transmit register(s) can be used to pass short
> > messages from one to four words in length. For example, when a
> > four-word message is desired, only one of the registers needs to have
> > its corresponding interrupt enable bit set at the receiver side.
> >
> > This patchset is to using this for SCFW message to replace four TX and
> > four RX method.
>=20
> Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
>=20

Thanks for the test.

> My stress tests pass on imx8qxp with this patcheset, however performance =
is
> not greatly improved. My guess is that this happens because of too many
> interrupts.

Might be. Could you share your testcase?

>=20
> Is there really a reason to enable TIE? Spinning on TE bits without any
> interrupts should be just plain faster.

I could try to disable TIE and give a try. If performance improves lot, I c=
ould
change to non TX interrupt.

Oleksij, do you agree?

Thanks,
Peng.

>=20
> >
> > Peng Fan (4):
> >    dt-bindings: mailbox: imx-mu: add SCU MU support
> >    mailbox: imx: restructure code to make easy for new MU
> >    mailbox: imx: add SCU MU support
> >    firmware: imx-scu: Support one TX and one RX
> >
> >   .../devicetree/bindings/mailbox/fsl,mu.txt         |   2 +
> >   drivers/firmware/imx/imx-scu.c                     |  54 ++++-
> >   drivers/mailbox/imx-mailbox.c                      | 267
> +++++++++++++++++----
> >   3 files changed, 260 insertions(+), 63 deletions(-)
> >
> >
> > base-commit: 770fbb32d34e5d6298cc2be590c9d2fd6069aa17
> >

