Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7FFC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC5120724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mEf1Z2tV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCRMOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:14:36 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:41120
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726664AbgCRMOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:14:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLWoTtiVvLveWa5w/+yBCBgP6LJ0PpqeBW5fgb0pUkAENriBl774uMa3s3UUHVZqjGOXWFAATHXuG+BFV+UvgkAjJCZxG6xK5JwbJRccbgBP9PP9x0ffnx+isBdxRUpNcoMxp1IPBFUhAyPjsggtvecEhf6ZcOcq7S/ewSTsj3jD64gLS6OPpy1DZl5axGulHR5XvSQgEU6Q04qmv4IjU0uiuyP3r2uEcQqM1sz6Ttx0OFlgE8ZkxrvDAmuoKq+wFt1v0lyuMYBUWsYZ2wdxfmFsF9CD+nzCJnWitVFqVpKfAVHuMsMOQAfl13mTidU9g0TkeIriCyEN+gNBbQ9kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR++3607CDS+4HICGKWHLp5QDSSYdSHHk2HUaYcOHjc=;
 b=jccjUnxI0I+L9PnqDIzyFzqu7Y9Gx/l9hSnf6BcHZACvPouaPaz5K0o3SW7FW9P6UYx1dDFXio78Iyf0ur8P3ftqxzdB/FOkLkn7+CsXIZArvbGTtDrSXYuo45CYTgk/5S2ClQyDol1PpUhobnB8LgptJbe16/oSIYuqvJFgeyaEvgeOzkdYXmu5hvlcI+hWUNpGFuh5saU44G5smafHo9PmTSLvFipBsPESrWcbggCOyuhKFUbSsJ0uGmaehnSSS03wEGO5FZYWLg6hHM4cpgbL191E8B7ZN9CimbomFmJOd0r3MOapdBFqTnCHHCI3upU/gpJ+9nEjuCvsV7zK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR++3607CDS+4HICGKWHLp5QDSSYdSHHk2HUaYcOHjc=;
 b=mEf1Z2tV2ScAMpeupYIKrmfdsj6GELiouZk7IzIWmTIANXj/Im8wYqBr6AVxycO304Sq/xfZro8WStSiu70LJgBm/TEbaZxDKqQrRpiizVhx3mye+WAwv7BtgS9fnF8evG4kzZwsyED1jHuQgzu0kD2Np3ky00123TeWGgJLO4k=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5363.eurprd04.prod.outlook.com (20.178.114.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Wed, 18 Mar 2020 12:14:31 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 12:14:31 +0000
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
Thread-Index: AQHV8emRGg+Z0s59ZUi7vGFwjsJP+qhOWEqw
Date:   Wed, 18 Mar 2020 12:14:31 +0000
Message-ID: <AM0PR04MB44811D112C5D31E815B4F9CC88F70@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023455D0FE9766FFBE1EE5EEEFD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <AM0PR04MB448123609B2FE8F5ECAF1F4388FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB4481D74E3C38B047562F419988FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <VI1PR04MB694108DF36F465324BA45E05EEF70@VI1PR04MB6941.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB694108DF36F465324BA45E05EEF70@VI1PR04MB6941.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6819aa9-e5a6-4533-577c-08d7cb35e9db
x-ms-traffictypediagnostic: AM0PR04MB5363:|AM0PR04MB5363:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB536330168C99CC2369A1EE7B88F70@AM0PR04MB5363.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(110136005)(316002)(15650500001)(53546011)(5660300002)(86362001)(44832011)(54906003)(7696005)(6506007)(26005)(33656002)(186003)(81166006)(81156014)(52536014)(55016002)(66946007)(76116006)(66476007)(8676002)(9686003)(64756008)(66446008)(966005)(66556008)(71200400001)(2906002)(8936002)(478600001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5363;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30qcigvVNFw0tQamhuVpzUS3v+4KMCaMiFyVi7S7jTDYpZNlIIGs433jXaGKqHEYNzyxl6AGaHlkCMIU3bdovf7vlX8RA69NjulLu3s2IBTiODGkapZMIYumfXD2p/BvHrSCoORs8BD87bt+ZPHxS0ODXggNPImTluH9/2S2mdqG8AvhD1Q+ner4UNiNrxad/4YvE7KsMYSu8AsZUOJYsYkGD+/qWC6WPd9k6DmbifsXG470W3D//Wklfgq/X28PsxFPF83PiDcPzhvOlaNvQYw0cBuzYJa1+mcqFq8tjHY8MtSAeA5k+q3MYTKmIxYPbUDHCwiiTEcApQ/q+DJLRfG/7xUp1p1CLCoq1dIDJB/Q5L1VglQL8gnWOeWzDwRO8shPXF0u1ish3KLjSqFqdpTlAiGKynTjVFEqDzuDp3EBWopW6uZO7uxxyrVjKiakf5yueQ9m7WozZLSzKIaKCHQ6WLp1vG7NhE2KWMXmorfvqzGBuWfXM8+5i7fTNM2ymLwfVeWtLt3yFu5JviWPJQ==
x-ms-exchange-antispam-messagedata: lxKBIW1m3YGWK5E22E6ZDM/gd6E84Ecd/Sl2eMUl9rJ5WzeUP9IAJKAsNswBHvL5jCcBBadIvj2rQG4G88/e6Fk308S6fnVIqFkc2j2TOKOEy3AGGukI/uLqz60agH8vnLWsCbnL7fMMi8hESa7gIQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6819aa9-e5a6-4533-577c-08d7cb35e9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 12:14:31.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97VTisQatIjvMk/BB16uR0mASAwZtH47W2h7WJl1eB6wgIuTTl94n0lCw9E3iE4AYvqgH1TQ3j0xregRyPO8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5363
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel
> type
>=20
> On 2020-03-13 9:38 AM, Peng Fan wrote:
> >> Subject: RE: [PATCH V6 0/4] mailbox/firmware: imx: support SCU
> >> channel type
> >>
> >> Hi Leonard,
> >>
> >>> Subject: Re: [PATCH V6 0/4] mailbox/firmware: imx: support SCU
> >>> channel type
> >>>
> >>> On 2020-03-04 7:55 AM, Peng Fan wrote:
> >>>> From: Peng Fan <peng.fan@nxp.com>
> >>>>
> >>>> V6:
> >>>>    Add Oleksij's R-b tag
> >>>>    Patch 3/4, per
> >>> https://www.kernel.org/doc/Documentation/printk-formats.txt
> >>>>    should use %zu for printk sizeof
> >>>>
> >>>> V5:
> >>>>    Move imx_mu_dcfg below imx_mu_priv
> >>>>    Add init hooks to imx_mu_dcfg
> >>>>    drop __packed __aligned
> >>>>    Add more debug msg
> >>>>    code style cleanup
> >>>>
> >>>> V4:
> >>>>    Drop IMX_MU_TYPE_[GENERIC, SCU]
> >>>>    Pack MU chans init to separate function
> >>>>    Add separate function for SCU chans init and xlate
> >>>>    Add santity check to msg hdr.size
> >>>>    Limit SCU MU chans to 6, TX0/RX0/RXDB[0-3]
> >>>>
> >>>> V3:
> >>>>    Rebase to Shawn's for-next
> >>>>    Include fsl,imx8-mu-scu compatible
> >>>>    Per Oleksij's comments, introduce generic tx/rx and added scu mu
> type
> >>>>    Check fsl,imx8-mu-scu in firmware driver for fast_ipc
> >>>>
> >>>> V2:
> >>>>    Drop patch 1/3 which added fsl,scu property
> >>>>    Force to use scu channel type when machine has node compatible
> >>> "fsl,imx-scu"
> >>>>    Force imx-scu to use fast_ipc
> >>>>
> >>>>    I not found a generic method to make SCFW message generic
> >>>> enough,
> >>> SCFW
> >>>>    message is not fixed length including TX and RX. And it use TR0/R=
R0
> >>>>    interrupt.
> >>>>
> >>>> V1:
> >>>> Sorry to bind the mailbox/firmware patch together. This is make it
> >>>> to understand what changed to support using 1 TX and 1 RX channel
> >>>> for SCFW message.
> >>>>
> >>>> Per i.MX8QXP Reference mannual, there are several message using
> >>>> examples. One of them is:
> >>>> Passing short messages: Transmit register(s) can be used to pass
> >>>> short messages from one to four words in length. For example, when
> >>>> a four-word message is desired, only one of the registers needs to
> >>>> have its corresponding interrupt enable bit set at the receiver side=
.
> >>>>
> >>>> This patchset is to using this for SCFW message to replace four TX
> >>>> and four RX method.
> >>>
> >>> Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
> >>>
> >>
> >> Thanks for the test.
> >>
> >>> My stress tests pass on imx8qxp with this patcheset, however
> >>> performance is not greatly improved. My guess is that this happens
> >>> because of too many interrupts.
> >>
> >> Might be. Could you share your testcase?
>=20
> https://github.com/cdleonard/imx-scu-test
>=20
> >>> Is there really a reason to enable TIE? Spinning on TE bits without
> >>> any interrupts should be just plain faster.
> >>
> >> I could try to disable TIE and give a try. If performance improves
> >> lot, I could change to non TX interrupt.
> >
> > After rethinking about this, we need TX interrupt, otherwise we have
> > to use TX_POLL which is slower or let the client kick the TX state mach=
ine.
> >
> > Compared with original method, this already reduces to use 1 TX and 1
> > RX interrupt. This already good for system.
>=20
> Sorry, I missed that fact that your patches don't include the required DT=
S
> changes. Indeed that is only one TX and one RX irq per call now.
>=20
> Running my test now results in RX timeout :(

Might be long that 4 word messages, because not check TX empty
and RX full in my patch.

>=20
> -----
>=20
> On an unrelated note: are you sure it is appropriate to change the compat
> string here? Another way to implement direct SCU communication would be
> as another channel type, IMX_MU_TYPE_SCUTX.

No. This will introduce more complexity. Per Oleksij's suggestion, I added
the compatible string.

>=20
> It also strange that you're adding a bool fast_ipc in imx-scu, do we real=
ly want
> to support the old path?

It is to avoid break DT backward compatibility.

Thanks,
Peng.

>=20
> If SCU protocol was implemented as a channel type then maybe we could
> sidestep mbox_request_channel_by_name, parse mboxes manually and
> always request MU_TYPE_SCUTX.
>=20
> --
> Regards,
> Leonard
