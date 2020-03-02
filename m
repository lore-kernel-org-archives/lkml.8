Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5078C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B56224677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NEY2Or0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCBSHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:07:50 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33045 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:07:49 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: VEedeoKzQDs5akiyyPYZgDQ0d/06P4UBtk1gVg+zFUcHdAHQdKCAWUdf44mfqYkaj87EG+nC+R
 PZIgC4cXNqHMkL2d2/H+JN9lUgM7OEBoN0P9dkzQ9fvj7DNE9t6HebQ+lRbGx1KwdSCZ8TREtk
 f62QVBfbsOkZL0sL61OgnT0yW6pY/Wmir6u2aPJgGsk8PoPXfgTTm3D0fDYa5zDveCZceVEG9M
 oBxIg3OcHyOAlMADqJ1TLa1swTL5wOWe83cdFWSmxNVPEp0OBERdLwoQDohDkYn1GKjGCk1KYp
 9fA=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="70457040"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:07:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:08:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 11:08:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZfEvfngjr6Jytl94aCD8eqDFM+RjQ4cDf9TF6x7CQA6l5Ugl2QXrM5OH0FSE8wLTsmt0wjhuMYJXjYbZgurXgGXGgGkqMhWttUkI1X+ba2101PEwfBJQgVFJoGLmrRowpCd4cG8XV1NXoE+LsN/yyr0ZgYdQ0Oq2THW/3wJ2ciTxIqkFRVL6rApu3oLsis9oN1LMji2PsameCJ58PQ3MNZ5Tnc4N1xhkfVzlQGelyQ5n/sv+AMnvZKIv7Y3FJZleWAOpDxP9Ub/nFNOhU7IZpB/lcrwdX+ZidBDK/UfCe2aczwnZ9n3vf+JWEe6HPQWugAU639EFVU++pz2zXZw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0poWXIWUj865ea3V41XIXQeb+XxEgWLA3jDuYlmD8U=;
 b=ib/2i+cy6D+jYaK3S6FzBWT6yUEnYjXns7BNQTRv9QLWLhEH2xsjTcsW7dTjvyoRaTsTAZ/hC9MDT0BpMTzT0rJeftmKLSSn+TxjVtzbpsx2FAn7xywja0duvP/4nqGoqcd6nWjIMYVaUi3t1U0NuekXbepTO3UMMOOJElMqCDnEssLQ/uu71cDR7QDm0mTRZnfNFwPraC39y8RwtLJAPiUjntfCW5aAd8NR6KFG86PHYBIxXTBbREQpV1qSKgOwHOBVMjspLINgczBvNlL1zWej2mAiE6EI2lEKH7SfuHBd9Kx4PD9zdNxzU4Tjf4TnicsEeel57YFXK6W/YwpcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0poWXIWUj865ea3V41XIXQeb+XxEgWLA3jDuYlmD8U=;
 b=NEY2Or0SeZWfCwEGW4iu2RPTKtrGnZwn18hE9z5WpExnTK58fsVKJEZ2iMFDYu5Qt0jIFctSDMLYSC/pW3KBFL9nfcfxxhYdLqMs7MY33o/i06sihZcvBl8NDu83dbxWyZ9OJL5b4gaYeXQtje0sKV3kiu8AgjAgmw9XCdkkT1o=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:07:45 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:07:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <michal.simek@xilinx.com>, <ludovic.barre@st.com>,
        <john.garry@huawei.com>, <tglx@linutronix.de>,
        <nishkadg.linux@gmail.com>, <michael@walle.cc>,
        <dinguyen@kernel.org>, <thor.thayer@linux.intel.com>,
        <swboyd@chromium.org>, <opensource@jilayne.com>,
        <mika.westerberg@linux.intel.com>, <kstewart@linuxfoundation.org>,
        <allison@lohutok.net>, <jethro@fortanix.com>, <info@metux.net>,
        <alexander.sverdlin@nokia.com>, <rfontana@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 00/23] mtd: spi-nor: Move manufacturer/SFDP code out of the
 core
Thread-Topic: [PATCH 00/23] mtd: spi-nor: Move manufacturer/SFDP code out of
 the core
Thread-Index: AQHV8L14v5uqqtrWhkmLNySK/DekJQ==
Date:   Mon, 2 Mar 2020 18:07:44 +0000
Message-ID: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 444af767-c611-43ba-1ff9-08d7bed49b9c
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142DC62E61DACBD7A853FDDF0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(966005)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ZLZ016wthleOCdLLXnodkIoGotUHh0pSw5SvYGKLZ6ieU5olsJf9PH6EOygE0zwHc2jbawSYf7RjhUtFnMkEVY4q5tAE85gsWL2oZfyfIuWSZgYrtM15W2a/Uw8fnmOnb7E9gukkqC8zGh2JyElTxmtCK1QtaW4pTP2m2xWXr5xdgoS54spIKFw1cbIFt0SM9w3zDV1TyKRT9vty70tGN4bMoVMyQY0SM3MnGbnnD08w0Kjw3OMX3JTbDhP4hxEP6qHUKbFSAHS9DMkXoHPo8zKUvM3k2UHZrESFXUATo/a+FvrSWory/z0yp0RtqfLnX4/l3iHjUQ1x1qiYV/Z983OQPeyhLrZdEHAIG0IpEmGZd7aGBwcuDutpcSrE/FOGpzQjRTgkTfyGI9u++Fm9nnDuW4xTWgXxfrwiRGW4sIrclypU05FVF0cWY1T6YdL8i1YeRQuQms0ryJMvtRT4M5Ldlf6yI/VMzuVsjPJhrBq+LzbPG5nFbxhG4oaTO9x/H/soESzAqqN4Uz0T9Xe/Q==
x-ms-exchange-antispam-messagedata: FYI25Qo23vceagk6v1CBXzs1C5ipXevLsya6bkDNVBxqm0tFarQIi/XNCTtVi8NKaEKkhbIXT6TmYVn2XI4gHKGzBCl4TEMdCMrXSxQHAdAWlLE5hUMRl5kKtOXfKXCTg53AR1SBqaw4++HFlB2YHg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 444af767-c611-43ba-1ff9-08d7bed49b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:44.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ck4XWsk8HIzpx5ewUXAtPnzlq13/RAAN7cFnlC/OBwfRylH6IT247NLpW4cOnW0kELFKbDdqcciIQLwYje1JWB9KCV+kkS6jzMJZ+2SpE9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Hello,

This patch series is an attempt at getting all manufacturer specific
quirks/code out of the core to make the core logic more readable and
thus ease maintainance.

This is a respin of the last chunk of Boris's work from
https://patchwork.ozlabs.org/cover/1009290/.

Tested an erase-write-read-compare with a 1MB file on the following
flashes: mx25l25635e, w25q128, n25q256a, is25lp256, s25fl256s0,
gd25q256.

Boris Brezillon (21):
  mtd: spi-nor: Stop prefixing generic functions with a manufacturer
    name
  mtd: spi-nor: Prepare core / manufacturer code split
  mtd: spi-nor: Expose stuctures and functions to manufacturer drivers
  mtd: spi-nor: Add the concept of SPI NOR manufacturer driver
  mtd: spi-nor: Move Atmel bits out of core.c
  mtd: spi-nor: Move Eon bits out of core.c
  mtd: spi-nor: Move ESMT bits out of core.c
  mtd: spi-nor: Move Everspin bits out of core.c
  mtd: spi-nor: Move Fujitsu bits out of core.c
  mtd: spi-nor: Move GigaDevice bits out of core.c
  mtd: spi-nor: Move Intel bits out of core.c
  mtd: spi-nor: Move ISSI bits out of core.c
  mtd: spi-nor: Move Macronix bits out of core.c
  mtd: spi-nor: Move Micron/ST bits out of core.c
  mtd: spi-nor: Move Spansion bits out of core.c
  mtd: spi-nor: Move SST bits out of core.c
  mtd: spi-nor: Move Winbond bits out of core.c
  mtd: spi-nor: Move Catalyst bits out of core.c
  mtd: spi-nor: Move Xilinx bits out of core.c
  mtd: spi-nor: Move XMC bits out of core.c
  mtd: spi-nor: Get rid of the now empty spi_nor_ids[] table

Tudor Ambarus (2):
  mtd: spi-nor: Move SFDP logic out of the core
  mtd: spi-nor: Trim what is exposed in spi-nor.h

 drivers/mtd/spi-nor/Kconfig                   |   83 +-
 drivers/mtd/spi-nor/Makefile                  |   26 +-
 drivers/mtd/spi-nor/atmel.c                   |   46 +
 drivers/mtd/spi-nor/catalyst.c                |   29 +
 drivers/mtd/spi-nor/controllers/Kconfig       |   83 +
 drivers/mtd/spi-nor/controllers/Makefile      |    9 +
 .../spi-nor/{ =3D> controllers}/aspeed-smc.c    |    0
 .../{ =3D> controllers}/cadence-quadspi.c       |    0
 .../mtd/spi-nor/{ =3D> controllers}/hisi-sfc.c  |    0
 .../spi-nor/{ =3D> controllers}/intel-spi-pci.c |    0
 .../{ =3D> controllers}/intel-spi-platform.c    |    0
 .../mtd/spi-nor/{ =3D> controllers}/intel-spi.c |    0
 .../mtd/spi-nor/{ =3D> controllers}/intel-spi.h |    0
 .../spi-nor/{ =3D> controllers}/mtk-quadspi.c   |    0
 .../mtd/spi-nor/{ =3D> controllers}/nxp-spifi.c |    0
 drivers/mtd/spi-nor/{spi-nor.c =3D> core.c}     | 2503 ++---------------
 drivers/mtd/spi-nor/core.h                    |  432 +++
 drivers/mtd/spi-nor/eon.c                     |   34 +
 drivers/mtd/spi-nor/esmt.c                    |   25 +
 drivers/mtd/spi-nor/everspin.c                |   27 +
 drivers/mtd/spi-nor/fujitsu.c                 |   20 +
 drivers/mtd/spi-nor/gigadevice.c              |   59 +
 drivers/mtd/spi-nor/intel.c                   |   32 +
 drivers/mtd/spi-nor/issi.c                    |   83 +
 drivers/mtd/spi-nor/macronix.c                |   98 +
 drivers/mtd/spi-nor/micron-st.c               |  129 +
 drivers/mtd/spi-nor/sfdp.c                    | 1206 ++++++++
 drivers/mtd/spi-nor/sfdp.h                    |   98 +
 drivers/mtd/spi-nor/spansion.c                |   95 +
 drivers/mtd/spi-nor/sst.c                     |  151 +
 drivers/mtd/spi-nor/winbond.c                 |  113 +
 drivers/mtd/spi-nor/xilinx.c                  |   94 +
 drivers/mtd/spi-nor/xmc.c                     |   23 +
 include/linux/mtd/spi-nor.h                   |  257 +-
 34 files changed, 3121 insertions(+), 2634 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/atmel.c
 create mode 100644 drivers/mtd/spi-nor/catalyst.c
 create mode 100644 drivers/mtd/spi-nor/controllers/Kconfig
 create mode 100644 drivers/mtd/spi-nor/controllers/Makefile
 rename drivers/mtd/spi-nor/{ =3D> controllers}/aspeed-smc.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/cadence-quadspi.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/hisi-sfc.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/intel-spi-pci.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/intel-spi-platform.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/intel-spi.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/intel-spi.h (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/mtk-quadspi.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/nxp-spifi.c (100%)
 rename drivers/mtd/spi-nor/{spi-nor.c =3D> core.c} (52%)
 create mode 100644 drivers/mtd/spi-nor/core.h
 create mode 100644 drivers/mtd/spi-nor/eon.c
 create mode 100644 drivers/mtd/spi-nor/esmt.c
 create mode 100644 drivers/mtd/spi-nor/everspin.c
 create mode 100644 drivers/mtd/spi-nor/fujitsu.c
 create mode 100644 drivers/mtd/spi-nor/gigadevice.c
 create mode 100644 drivers/mtd/spi-nor/intel.c
 create mode 100644 drivers/mtd/spi-nor/issi.c
 create mode 100644 drivers/mtd/spi-nor/macronix.c
 create mode 100644 drivers/mtd/spi-nor/micron-st.c
 create mode 100644 drivers/mtd/spi-nor/sfdp.c
 create mode 100644 drivers/mtd/spi-nor/sfdp.h
 create mode 100644 drivers/mtd/spi-nor/spansion.c
 create mode 100644 drivers/mtd/spi-nor/sst.c
 create mode 100644 drivers/mtd/spi-nor/winbond.c
 create mode 100644 drivers/mtd/spi-nor/xilinx.c
 create mode 100644 drivers/mtd/spi-nor/xmc.c

--=20
2.23.0
