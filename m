Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A6AC4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD5B24680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="DV4WEb0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBZRFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:05:34 -0500
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:23623
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbgBZRFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:05:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0RxALe+SfXUxDqwoJ6dR1cwm+9s0+PcYv2n57j0yN7dK4j1Y2FcKXwYwPBcL5TrpI9Hq4Hdb9NscogMxUkUFKR09/0vVuz6bqNvTpIxbWl5RdNjObmW7p5C3rkdNF2GwQLn9RJoWOtDSCk9BAK5U2aBQlLEO0F+iY/2FPMosMpzglx1l4z5MAx4xnQ5aANCboYgvaI61DXPiuzkpdZaDSULsb7HoliVA+QtAR2miYAAtstPqNDssWE2KYiZotYSGAqgNC2POThpkP5ZChk/rx8ibmoKoVxjKZd6NfgrJMuHQjiJ6dvPyobyVZeFVOH98/YnVEl9rfSQZO25Ii3LsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFn19vf1DKzpWE53bxFiFLuWiSeogiZdzQu5unar/yY=;
 b=cdiwYyr/Za5Aan1iyDONpuJyrVBdQLMPqzZyaesFrzNMapInIpDfASEoGVp5Yr70x72dirlbtWO4rNgnyP359v6IPEGp196s8wzTCV1qwy6oYLZv7t+iTn/VQ3/wfAJpiitbGFnKOIdlj2aKdbsQZswyeT39kuBeCG5Yhu3dkcbRP1Tlfp9WWm78VJ9gUovfDUrK6vTqQHV1ntmXtKV45aQfwoZUjAKPiNFE9Fg233OGvomrYWez9glYz5i6D+F1wQYX8mX2avEeSAG21uAAFdDT2drtwzVF8k5fC9TYpuxSz9DhAts4VT1CH39Ejs7Bx9rASpzFKJB73yV1pvnLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFn19vf1DKzpWE53bxFiFLuWiSeogiZdzQu5unar/yY=;
 b=DV4WEb0ekiHJoihQC6lRGe6gAiDqeJlhQLGsBXS8NXAeTFKfjQTuKpt84/+ZdvmcRdQE5EAnSpOkIDlNAOIAsvwNVi9s9KDfHtC5vRYnI8Ddl12ZrWZvQfHdQ8PBPaLxasfj9CYYCeVMYbngRU9xPc5GeFXwy/OGdVJH78T3kPk=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10)
 by MN2PR08MB6254.namprd08.prod.outlook.com (2603:10b6:208:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 17:05:31 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::884a:b0f5:3cf5:f4a4]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::884a:b0f5:3cf5:f4a4%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 17:05:31 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH v4 0/5] Add new series Micron SPI NAND devices
Thread-Topic: [EXT] [PATCH v4 0/5] Add new series Micron SPI NAND devices
Thread-Index: AQHV3StsSYZPcf3XqUeN3rLHHfjFbqgt0zWw
Date:   Wed, 26 Feb 2020 17:05:30 +0000
Message-ID: <MN2PR08MB63971F0C6D7AFD695D077EF5B8EA0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
In-Reply-To: <20200206202206.14770-1-sshivamurthy@micron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVydGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzAxNjI3MDktNThiYS0xMWVhLWIxZTktOTgzYjhmNzQ1MjUxXGFtZS10ZXN0XDMwMTYyNzBiLTU4YmEtMTFlYS1iMWU5LTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iMjU1MSIgdD0iMTMyMjcyMTAzMjkyMzUzNzE2IiBoPSJDbEQxWit5UTRtZy9ZVUUwdEd1NWV0Z3VxYVU9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIQUFBQUMwUEcveXh1elZBVzZVaEpaM3lVQVJicFNFbG5mSlFCRUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFCQUFBQUFYbTFpZ0FBQUFBQUFBQUFBQUFBQUE9PSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98ede546-b89e-43c4-e98d-08d7bade161e
x-ms-traffictypediagnostic: MN2PR08MB6254:|MN2PR08MB6254:|MN2PR08MB6254:
x-microsoft-antispam-prvs: <MN2PR08MB6254A3782A4DEE0581D31A8EB8EA0@MN2PR08MB6254.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:494;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(81166006)(8676002)(316002)(71200400001)(110136005)(6506007)(33656002)(478600001)(2906002)(55236004)(26005)(52536014)(7696005)(81156014)(5660300002)(86362001)(66476007)(9686003)(66556008)(186003)(55016002)(66446008)(64756008)(8936002)(966005)(66946007)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB6254;H:MN2PR08MB6397.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7hR6OK4oLCNMs/Qd36Tlyy2kqaZlTz/dp6VX7cztbu5lBxYh1tpvF4hoUR0YPpYKkEMkejiZWiIvMlUDHqasMRrcbseBt8JP30Q9Q1cBVikkUTaJVmLFZ/fdG6sXKfhI4/isntrcc3e+QO9HFbcWeIEuJ7nN23byr2lFxDTxoV5jIU87/VfZNRAFkcEn+bnBbL1OR5sMKNKVz46Vr2GtQRn6Ucf1mWpiD1aZxbVgoRHPqWC6ZoHuh1IlfaOVES5Pm30hf0iNOKYOwSslQ3Z6BD4YGu7wSvzayVvTcbZ73FCqDM1bpXVawC0ybYDjMwfroVGlzxghqg9HTKt8vwhNiSMKeuRyFNhYvSTMH5UHb0Nss1wlExGlcbrPPNldVPiQsW7S3F6QrOpD9DaJdzL4oloQW6EdTlPWucGSRJiDR/wEGj1ucnlMwktZDsgGxS+lHjHOUQDAh+wA+5G2Ljc7V86Sp8Vso264N3N44DBHgRJDECRifU0m5jrhJh1DJ/lHCn3KlxlDG/svIGuDQERig==
x-ms-exchange-antispam-messagedata: iCCjIcfORP3B42JLItZRj92qdFHSH8uZ4chRklWSz+pg/hnf6hLb0Sv94Mt4mo56k7B8f3WfQIs/JS/IS626cakl1kVwR7fbOv/spRApfoBtuLUjfFaPz48purLU1eymUUQZ10rxYnxC7p/f1Ix1OA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ede546-b89e-43c4-e98d-08d7bade161e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 17:05:31.0465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Viv/5pgpKyqmdqrwtfnejLErLbZMbs3L96zLO+YT/unsfW219pId5E6aM/IMmEdlLC+Vr9eavg0cxxk3/GSkjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miquel,

Just a gentle reminder that I'd like some feedback.

Thanks,
Shiva

>=20
> From: Shivamurthy Shastri <sshivamurthy@micron.com>
>=20
> This patchset is for the new series of Micron SPI NAND devices, and the
> following links are their datasheets.
>=20
> M78A:
> [1] https://www.micron.com/~/media/documents/products/data-
> sheet/nand-flash/70-series/m78a_1gb_3v_nand_spi.pdf
> [2] https://www.micron.com/~/media/documents/products/data-
> sheet/nand-flash/70-series/m78a_1gb_1_8v_nand_spi.pdf
>=20
> M79A:
> [3] https://www.micron.com/~/media/documents/products/data-
> sheet/nand-flash/70-series/m79a_2gb_1_8v_nand_spi.pdf
> [4] https://www.micron.com/~/media/documents/products/data-
> sheet/nand-flash/70-series/m79a_ddp_4gb_3v_nand_spi.pdf
>=20
> M70A:
> [5] https://www.micron.com/~/media/documents/products/data-
> sheet/nand-flash/70-series/m70a_4gb_3v_nand_spi.pdf
> [6] https://www.micron.com/~/media/documents/products/data-
> sheet/nand-flash/70-series/m70a_4gb_1_8v_nand_spi.pdf
> [7] https://www.micron.com/~/media/documents/products/data-
> sheet/nand-flash/70-series/m70a_ddp_8gb_3v_nand_spi.pdf
> [8] https://www.micron.com/~/media/documents/products/data-
> sheet/nand-flash/70-series/m70a_ddp_8gb_1_8v_nand_spi.pdf
>=20
> Changes since v3:
> -----------------
>=20
> 1. Patch 3 and 4 reworked as follows
>    - Patch 3 introducing the Continuous read feature
>    - Patch 4 adding devices with the feature
>=20
> Changes since v2:
> -----------------
>=20
> 1. Patch commit messages have been modified.
> 2. Handled devices with Continuous Read feature with vendor specific flag=
.
> 3. Reworked die selection function as per the comment.
>=20
> Changes since v1:
> -----------------
>=20
> 1. The patch split into multiple patches.
> 2. Added comments for selecting the die.
>=20
> Shivamurthy Shastri (5):
>   mtd: spinand: micron: Generalize the OOB layout structure and function
>     names
>   mtd: spinand: micron: Add new Micron SPI NAND devices
>   mtd: spinand: micron: identify SPI NAND device with Continuous Read
>     mode
>   mtd: spinand: micron: Add M70A series Micron SPI NAND devices
>   mtd: spinand: micron: Add new Micron SPI NAND devices with multiple
>     dies
>=20
>  drivers/mtd/nand/spi/micron.c | 153
> ++++++++++++++++++++++++++++++----
>  include/linux/mtd/spinand.h   |   1 +
>  2 files changed, 140 insertions(+), 14 deletions(-)
>=20
> --
> 2.17.1

