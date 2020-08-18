Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A934C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02A92067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PwK8yXip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHRHwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:52:13 -0400
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:8577
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbgHRHwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:52:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqRZtE8b9hi7qzqvKprYhBDygtpACCNa1jNMMrYNe4ULQTee1Mwdom3hjzR0C6Uwjz7oxTbbqnobnhGbnrX8IXZuXX+Plv33swaQqYCT0ihuAd3jRHJQBkfSGdqdqmS1jY07dALx9E3SNwyM5iyOTgX5/qxh4pPuPww8q4knynvMsmj2f1Tdeh3UQE3oo5dmV9HvGGwgGyfpeROcunUZGPp1lgBkClXz0LAHvBEqJ/MPR3KZ3reBs1RhZM7UhlvmY9lOpOhC8RHS2SI4Ek/xO+/VAlUY/MmmFwNQ0R6y/wfbFUXyCpJbm2/OYZKq1SqgL2OyesX4t0cW0pdciSEwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Miebtisz2C/LWFj16D5bP632QuyrjrMp4iNoW5zCNRA=;
 b=WAqvKabwXH2kZ0ux4kngqJcocwJrL1yB9R3BNTeS8ca2D8BGH6khlAIoDHrSKkEbAI2S1MJySXUqqOqMfE5vXS1w3lmr5YFhz/tqmv1AGDZNDnQ1apt3iyUrm0M304kt0LIcz24sWiwGXMGXoD64stc2Kto533x4IYyhjlBcPyoZFR+Wa9cF9Hu3mQVW5sQGcj/pL9mQKMG3m7ZMPehZwwtddnm71mn6+iMMYW6qgDT2UtY16xnKJyBJcw5TW86WTFMaSSNdDN0g4LHwdgIKvvwYUPIFf9MMj01oo+dyxHEJhYR/6I2fUSRG7B37E/IdHfE5XpmS+EHyB0EhDFpGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Miebtisz2C/LWFj16D5bP632QuyrjrMp4iNoW5zCNRA=;
 b=PwK8yXipQCwjxv+7CV+3R8QhnDrlcvltTLi5z8Upbk0L5QcfFwLlkCUDMzSDPKsabFABkyyYVcIBhhyCiA4tANAwDgr7fRKVGd3WjqfcL/C6FsIgTyxdpZ1PiuH4fQp3TImjfelrRX0iV3GmSqVJQjoKbEj6P8LMX+qq7xo8IcQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB5027.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Tue, 18 Aug
 2020 07:52:04 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::b9c3:dcea:8cfe:327d]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::b9c3:dcea:8cfe:327d%7]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 07:52:04 +0000
Message-ID: <1597737122.73802.3.camel@oss.nxp.com>
Subject: Re: [PATCH v2 0/5] Add support of SECVIO from SNVS on iMX8q/x
From:   "Franck LENORMAND (OSS)" <franck.lenormand@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        aisheng.dong@nxp.com, abel.vesa@nxp.com, Anson.Huang@nxp.com,
        linux@rempel-privat.de, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, qiangqing.zhang@nxp.com, peng.fan@nxp.com
Date:   Tue, 18 Aug 2020 09:52:02 +0200
In-Reply-To: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:200:42::14) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sopdpuats05.ea.freescale.net (81.1.10.98) by AM4PR0701CA0004.eurprd07.prod.outlook.com (2603:10a6:200:42::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.10 via Frontend Transport; Tue, 18 Aug 2020 07:52:03 +0000
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dcbe0708-cd87-4c67-7bba-08d8434b98df
X-MS-TrafficTypeDiagnostic: AM0PR04MB5027:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB502769EC1FE42273AB7FCCA1D35C0@AM0PR04MB5027.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FaghnpofhEVF8sBWToOxq0cLonChvQ/LB0ItUZLxqgdGX1UJs7TwxFMwRoBpwoaJU8jmG1UqTj4rL+/47c3EwLPnB6ITBGSFr0Xlkk4Zz+X8R+GIOdBh/8boYm2005ccho4aqiemtOWDBbuHq4uhHrBC137A+O2MvcM/hwf5Cu/Fb2hMP0Q+JyDoe4FC5swwskvo6h4H2KIdDD1QVJyBllCcLWGoxbmpp5sJ3jAU28R/vPlpVE9f7+nhpeo1o9CKyuyiZl8pEvRN6W/k7ph/jhUQxZEsLjFEgC77ntj6u5DZChSeR0SbZfcRWaCcdxid2FhOoVeBhZb1y3O8nSXsflPvzJqLrgKe4U2jo/aDK2f+nhKovzdyuuZIsxDLZWcShXXtzxBoppf2PyDENOugQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(6512007)(86362001)(66946007)(186003)(316002)(5660300002)(2616005)(16526019)(956004)(83380400001)(6486002)(6506007)(103116003)(66476007)(66556008)(8936002)(26005)(2906002)(52116002)(4326008)(478600001)(8676002)(99106002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AhB4eoAmGj4SIjoThg2dNmrKm/PFJTm6x9IrE6vGjhCYa3x4j1O5qVt0nNTE2xD2JP4a/oH7BvF5XlLyri5Gdh+6GOcHNzCXsZybXJPPJwLCk4ZQ4/kZjRuBWh2kJpaABmH8bwLcBK27ut41Uvl3ah7HcYmQuT1fgXLJkQXt58GxN54+4EnpjBKGUpkynrq7zydgrtha6jXq0TLn4+J0EBS0qMxih7A8jJXIAM/ufH37lYrDH4KwFQmqR6fMjDRZJhSB0B0GqJLC1AVr5IEBT/VzDTxRxWh+LNVuYgn4u7PzPkECAi5VNHOJXh8QsfZcaD0Tc5CQY/zTL4tYIcgB1dubc9IfMxYSsaX/sZt7ZvYmG3HtH8JF9P1rp52R360IaE4nzG/dugdY9G6Mn2mE19bjW+ITNeaGpjAaIRT+0RaCn5saW48JWA+dMkrlRXP8KAj5Nezl5tq6EDJuR8ihcWxjZpeo7p2or7ca+CJsP2Azu4/GrLmh++S7WhjwI2w/XOStbn7hT18sPXshLppiqWFGI8MJpFNR22F0tRk4cxL/jxWrvmptyojmN+9wpIJRwlYYCiHVYyoLN9SAgn4Hc8pCuf9djy+S210UXM2KKTzaCDnmO+C4de0wGf+dc0Le
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbe0708-cd87-4c67-7bba-08d8434b98df
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 07:52:04.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhd1/HfRWEMp7Sr6OH2M6R7UoOhzNOK7FG13wa8Pqjh6k6qh/Cu8gPDIOiFNG4g7/gsJrhMH2SLI0vTkj/nrUJH51Upg+sHBxU5O8JldtOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Peng was able to do a firt pass of review on my patchset which led to this
second version. I hope a maintainer will be able to take a look at this
patchset once rested after all the work they did for 5.9.

On mar., 2020-07-21 at 17:20 +0200, franck.lenormand@oss.nxp.com wrote:
> From: Franck LENORMAND <franck.lenormand@oss.nxp.com>
> 
> This patchset aims to add support for the SECurity VIOlation (SECVIO) of the
> SNVS. A secvio is a signal emitted by the SNVS when a hardware attack
> is detected. On imx8x and imx8q SoC, the SNVS is controlled by the
> SECO and it is possible to interact with it using the SCU using the SC APIs.
> 
> For the driver to communicate with the SNVS via the SCU and the SECO, I had to:
>  - Add support for exchange of big message with the SCU (needed for
> imx_scu_irq_get_status)
>  - Add API to check linux can control the SECVIO (imx_sc_rm_is_resource_owned)
>  - Add APIs for the driver to read the state of the SECVIO registers of the
> SNVS and DGO (imx_sc_seco_secvio_enable and imx_sc_seco_secvio_enable).
> 
> To check the state of the SECVIO IRQ in the SCU, I added the
> imx_scu_irq_get_status API.
> 
> The secvio driver is designed to receive the IRQ produced by the
> SNVS in case of hardware attack and notify the status to the
> audit framework which can be used by the user.
> 
> The goal of the driver is to be self suficient but can be extended by the
> user to perform custom operations on values read (imx_sc_seco_secvio_enable)
> 
> v2:
>  - Removed (firmware: imx: scu-rm: Add Resource Management APIs)
> 	-> Code required is already present
>  - Removed (firmware: imx: scu: Support reception of messages of any size)
> 	-> The imx-scu is already working in fast-ipc mode
>  - (soc: imx8: Add the SC SECVIO driver):
> 	- Fixed the warnings reported by kernel test robot
> 
> Franck LENORMAND (5):
>   firmware: imx: scu-seco: Add SEcure Controller APIS
>   firmware: imx: scu-irq: Add API to retrieve status of IRQ
>   dt-bindings: firmware: imx-scu: Add SECVIO resource
>   dt-bindings: arm: imx: Documentation of the SC secvio driver
>   soc: imx8: Add the SC SECVIO driver
> 
>  .../bindings/arm/freescale/fsl,imx-sc-secvio.yaml  |  34 +
>  drivers/firmware/imx/Makefile                      |   2 +-
>  drivers/firmware/imx/imx-scu-irq.c                 |  37 +-
>  drivers/firmware/imx/imx-scu.c                     |   3 +
>  drivers/firmware/imx/seco.c                        | 275 +++++++
>  drivers/soc/imx/Kconfig                            |  10 +
>  drivers/soc/imx/Makefile                           |   1 +
>  drivers/soc/imx/secvio/Kconfig                     |  10 +
>  drivers/soc/imx/secvio/Makefile                    |   3 +
>  drivers/soc/imx/secvio/imx-secvio-audit.c          |  39 +
>  drivers/soc/imx/secvio/imx-secvio-debugfs.c        | 379 +++++++++
>  drivers/soc/imx/secvio/imx-secvio-sc-int.h         |  84 ++
>  drivers/soc/imx/secvio/imx-secvio-sc.c             | 858 +++++++++++++++++++++
>  include/dt-bindings/firmware/imx/rsrc.h            |   3 +-
>  include/linux/firmware/imx/ipc.h                   |   1 +
>  include/linux/firmware/imx/sci.h                   |   5 +
>  include/linux/firmware/imx/svc/seco.h              |  73 ++
>  include/soc/imx/imx-secvio-sc.h                    | 177 +++++
>  18 files changed, 1991 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-
> secvio.yaml
>  create mode 100644 drivers/firmware/imx/seco.c
>  create mode 100644 drivers/soc/imx/secvio/Kconfig
>  create mode 100644 drivers/soc/imx/secvio/Makefile
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-audit.c
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-debugfs.c
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc-int.h
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc.c
>  create mode 100644 include/linux/firmware/imx/svc/seco.h
>  create mode 100644 include/soc/imx/imx-secvio-sc.h
> 

