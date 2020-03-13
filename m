Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5360EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1022B206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XqAj3Lgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgCMHif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:38:35 -0400
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:24606
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbgCMHif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:38:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnYZYpp9kyD0VH6RjkY0NGwI31V0rHvgEdVDwBBvvFTYf6ociL8665mhlFyy0VS3i03D/oRAt23NnYE+iG9+ghuuMpOBw/0C/3jifDcg2uOGYQS10yH5UbAO9rTpcvG8BXdfk4OCxsMZnM3tLLIhn3xMUkQ+//gv4b3pKOz4W90swoK5jifUtcKLq4NefaEHaE9BAmpPsiCq2MZ/K9U5rqGexODDMzfaNw8DVXwefELqgER16mwqPOBWpU7ftoLiYy1clAPFg/lsyR0cFSLACYWGZiZRnUTkLeqle2/wIDeay716pXDIK1Qyk5lrL5Ft3hrb1NfycmslsvFs1JL3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zSF2nYz1TiVEtUXL8yn14ilYDZ9PM0mVaSfic0mKks=;
 b=is6ecwZPUB+TUA4VRjBsSXZwpi/HQBHu7o187dqk0XEgkUCK9iKkuMUQ/j/FzYMWIqsTet/s2ggQuUsmvZAtGBNDPDTQo4XPakxlMlDOidjdM3gnLi9OslLGFQLE+rSnn3PUkmglIAL3RxOPmgcxig9nAgY5p3UCeGyM7AiwhYzglhtPb4B3fh0ELrM/0jxX7NZDyJmdrl6PUnlhyHP1GBVb3VeKoMF2cPtbbBVHt5IsaWg+A50Jj7hNtU+HpkWPrOIBU2zM2bt8nXJB1HohIasPIJkpwpba13FAMULWerTlwSJ89fNRXzX85jCEwgUKtL204ZT5Rq1/E0lPhCqScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zSF2nYz1TiVEtUXL8yn14ilYDZ9PM0mVaSfic0mKks=;
 b=XqAj3LgheLtOs1d/m0T11mJJ7cN5AImo8KHHMcWiZCG9voAPsBCI2bTtsDQfyxoaZsynsaVpF3IN3EbfF3Nm2mLIZj7U2N8WhGSPsR+v9jxLk/0FGgpD68aNY+vWnKG9P2UV9sGIJU2x3kgLdCdVNQj8971ge5CSxtB7Y3h0Ciw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4705.eurprd04.prod.outlook.com (20.176.214.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 07:38:31 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 07:38:31 +0000
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
Thread-Index: AQHV8emRGg+Z0s59ZUi7vGFwjsJP+qhFwwuggABtClA=
Date:   Fri, 13 Mar 2020 07:38:31 +0000
Message-ID: <AM0PR04MB4481D74E3C38B047562F419988FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023455D0FE9766FFBE1EE5EEEFD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <AM0PR04MB448123609B2FE8F5ECAF1F4388FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB448123609B2FE8F5ECAF1F4388FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d34f8c54-a4f5-4b65-cd87-08d7c7218773
x-ms-traffictypediagnostic: AM0PR04MB4705:|AM0PR04MB4705:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4705ACA74FB5B642E1CC62CF88FA0@AM0PR04MB4705.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(71200400001)(110136005)(2940100002)(4326008)(76116006)(8676002)(9686003)(55016002)(86362001)(33656002)(15650500001)(66556008)(66946007)(64756008)(66476007)(26005)(186003)(66446008)(316002)(966005)(2906002)(478600001)(81166006)(52536014)(44832011)(54906003)(5660300002)(7696005)(6506007)(53546011)(81156014)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4705;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fo9w1M6Kv3EKltWzvcKpaTrmbVwSM6OfLVidCF1Hl6ZVPiH3MISXe2DkClafegary4ltF/3supvPl24rIBql0i7RDDHHynyzJu1ga7OlZgFFGQZ+ByupRARM4C92HL2/NKEjn4/ChF9ohZwEgGeysj1JmEawF6hldEhPlFlYMYLZPPCYcxDsRgmbNlVJDGZcFC0G0bwElx5cGixM7HegskiPbgaR0Vpgo2sR0O+oPgyEGacIPKL7ioM9KWsvkxAyL01LY7pfjyVmW5kIQCTEqEPAsj4bhLb9WuKHBlhw5uIWPW98K+vpmI7pdWA3Sun7L17Q4InL+0tG7bVNZD/mewlVrJz91Aq3gB5t/iM6pVxEfkPFBDMDNButFcajaZb/0bgOkF8cAfko7TlMQRCkfmu2KXpFwJ0KrGik781eG5FBA91JWFj3u0JXXoc7mlPfHXqNENeZbFYVNa43gIYJMP9U2j1Y4vI8rKX8inMI7MKAkKqTVunn0JyLEpfifydem1kvlW8zqTgfkgslWUExqQ==
x-ms-exchange-antispam-messagedata: 6+4gixYVtNbgUqIu71sVVhLSxija6lZLq607eceDJtk1AZqMgimTInb/oc5MlL0AO6JYtbs0l3CKg5jsLyhWCGWaJncJF8U4riRVarUdsdy5SC/2Cc3B5VGJWmO1oxsalSfeWzyCULqEAzn+8LnE+w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34f8c54-a4f5-4b65-cd87-08d7c7218773
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 07:38:31.5136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcugRavhZRW8l+NZuNGR+51eDHv0mEhIR59JhYYxWiVmERhX89CWW7tQdIkTnwIpoTTUjRFtax6MR64KZkGdVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel
> type
>=20
> Hi Leonard,
>=20
> > Subject: Re: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel
> > type
> >
> > On 2020-03-04 7:55 AM, Peng Fan wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V6:
> > >   Add Oleksij's R-b tag
> > >   Patch 3/4, per
> > https://www.kernel.org/doc/Documentation/printk-formats.txt
> > >   should use %zu for printk sizeof
> > >
> > > V5:
> > >   Move imx_mu_dcfg below imx_mu_priv
> > >   Add init hooks to imx_mu_dcfg
> > >   drop __packed __aligned
> > >   Add more debug msg
> > >   code style cleanup
> > >
> > > V4:
> > >   Drop IMX_MU_TYPE_[GENERIC, SCU]
> > >   Pack MU chans init to separate function
> > >   Add separate function for SCU chans init and xlate
> > >   Add santity check to msg hdr.size
> > >   Limit SCU MU chans to 6, TX0/RX0/RXDB[0-3]
> > >
> > > V3:
> > >   Rebase to Shawn's for-next
> > >   Include fsl,imx8-mu-scu compatible
> > >   Per Oleksij's comments, introduce generic tx/rx and added scu mu ty=
pe
> > >   Check fsl,imx8-mu-scu in firmware driver for fast_ipc
> > >
> > > V2:
> > >   Drop patch 1/3 which added fsl,scu property
> > >   Force to use scu channel type when machine has node compatible
> > "fsl,imx-scu"
> > >   Force imx-scu to use fast_ipc
> > >
> > >   I not found a generic method to make SCFW message generic enough,
> > SCFW
> > >   message is not fixed length including TX and RX. And it use TR0/RR0
> > >   interrupt.
> > >
> > > V1:
> > > Sorry to bind the mailbox/firmware patch together. This is make it
> > > to understand what changed to support using 1 TX and 1 RX channel
> > > for SCFW message.
> > >
> > > Per i.MX8QXP Reference mannual, there are several message using
> > > examples. One of them is:
> > > Passing short messages: Transmit register(s) can be used to pass
> > > short messages from one to four words in length. For example, when a
> > > four-word message is desired, only one of the registers needs to
> > > have its corresponding interrupt enable bit set at the receiver side.
> > >
> > > This patchset is to using this for SCFW message to replace four TX
> > > and four RX method.
> >
> > Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
> >
>=20
> Thanks for the test.
>=20
> > My stress tests pass on imx8qxp with this patcheset, however
> > performance is not greatly improved. My guess is that this happens
> > because of too many interrupts.
>=20
> Might be. Could you share your testcase?
>=20
> >
> > Is there really a reason to enable TIE? Spinning on TE bits without
> > any interrupts should be just plain faster.
>=20
> I could try to disable TIE and give a try. If performance improves lot, I=
 could
> change to non TX interrupt.

After rethinking about this, we need TX interrupt, otherwise we have to
use TX_POLL which is slower or let the client kick the TX state machine.

Compared with original method, this already reduces to use 1 TX and 1 RX
interrupt. This already good for system.

Thanks,
Peng.

>=20
> Oleksij, do you agree?
>=20
> Thanks,
> Peng.
>=20
> >
> > >
> > > Peng Fan (4):
> > >    dt-bindings: mailbox: imx-mu: add SCU MU support
> > >    mailbox: imx: restructure code to make easy for new MU
> > >    mailbox: imx: add SCU MU support
> > >    firmware: imx-scu: Support one TX and one RX
> > >
> > >   .../devicetree/bindings/mailbox/fsl,mu.txt         |   2 +
> > >   drivers/firmware/imx/imx-scu.c                     |  54 ++++-
> > >   drivers/mailbox/imx-mailbox.c                      | 267
> > +++++++++++++++++----
> > >   3 files changed, 260 insertions(+), 63 deletions(-)
> > >
> > >
> > > base-commit: 770fbb32d34e5d6298cc2be590c9d2fd6069aa17
> > >

