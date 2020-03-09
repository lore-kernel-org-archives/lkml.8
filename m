Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D2BC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF50620873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCIRtO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:49:14 -0400
Received: from mail-oln040092253105.outbound.protection.outlook.com ([40.92.253.105]:6098
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbgCIRtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrc91E9iWp6/X08RfIZc8ee9pFJK5i2GfKi5J6MYgKmemp5LhupAjjcV6wTxJ/cCrREvX+Mn9weOYC7TdeCF7tu6PUzieEETrhMIZuACJ8pMpiaAaTnYe9ifOeb1mAKerk8fwAxLtquGhCNrF71ZHG5Vveezak20OORJBO5MwgBmcn1iH4fzzzCVEqYlDDRgNa9hWpmVjCJmFcGzdgnzQtxgSjChRxDhjPp1idHqPshhyYKXcST4COlLJssq8aLZLrIvPwFuWgRI8jBq/Ey5U5DQVL229WCkSUqCLcXL9bJ5vKACHNPnaFKN0QeFfrTbE2YiLiyOWuTA/czXu9U5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIDkSRkmjcwLgl9W/QQuRCOAqcvjbsDB0jpbuzxb/fw=;
 b=LlqLhDTXIFErVslpqf0hDDfL6295vdtJpuwmjZn+JQtao3qBe+o/RFyd87rFdmZlwKwMyt8DAMiahrwHvZAWz7l3qmOVn6gpXLMyxPuG7gcg8n6sXl7LxNpSiJle9bOZ5cX/bd8qgrgjhLlPheKdwgNQdVzE4igqkNM0R485SbWPu8PR+n7Dv156X+09BAfR8D7MK8AoTqXI3qGjHSlEultx+c6ziNYFnT8rLncNW7f1OKSxTQmdl5VbDNpyZ/nmIvzPX8TsQAx4guUDAuoRjAteP8ztf343Q4hLDEPa25RfNa+KJ7Yj7/qn+XC4og/jZq9HLejoOqt9zqKScCxczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT045.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::37) by
 HK2APC01HT118.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::338)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Mon, 9 Mar
 2020 17:49:08 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.57) by
 HK2APC01FT045.mail.protection.outlook.com (10.152.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 17:49:08 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 17:49:08 +0000
Received: from nicholas-dell-linux (2001:44b8:605f:11:6375:33df:328c:d925) by MEAPR01CA0029.ausprd01.prod.outlook.com (2603:10c6:201::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Mon, 9 Mar 2020 17:49:06 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 0/2] nvmem: Add support for write-only instances, and
 clean-up
Thread-Topic: [PATCH v3 0/2] nvmem: Add support for write-only instances, and
 clean-up
Thread-Index: AQHV9jsIrwS6KhTqfEeGzuGXh51Jbw==
Date:   Mon, 9 Mar 2020 17:49:08 +0000
Message-ID: <PSXP216MB0438614877E3559E155F12AF80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0029.ausprd01.prod.outlook.com (2603:10c6:201::17)
 To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:D72E65D032AB40DC6C58283FDB8E17632F3CE7DFD012717B3770DFD5F10D2147;UpperCasedChecksum:DD327475E681C02463FA0139663305666F425200C5F86A92F260531124A0CAA1;SizeAsReceived:7722;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [TmusDcVuF0IrG326Pb3R99Pd9tiHnqjX10MKKPR1A0RxoR+Xq+jUAuOiH0DIKtj5]
x-microsoft-original-message-id: <20200309174901.GA1830@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 0fb723e0-cbae-4a3b-a092-08d7c4522ac1
x-ms-exchange-slblob-mailprops: =?us-ascii?Q?rO8E+RXTnU/cEBXoKIq/8aFxnq9tHOwUXOjWzzghlKIS1cAfIWnNyZPqMm7j?=
 =?us-ascii?Q?gJpGyBtbbkTH+YzAbDZIRY45VowEq+9R1CPHoRsePHF4qpkwMNT+3sUggBj1?=
 =?us-ascii?Q?E98Gc2Sdi4yfkh4frzVeFcPmF946upkRc/sWhJytCoZgYbL9wWMbT/6MlmTy?=
 =?us-ascii?Q?O/de/Qj3mxEEjSXGs4qCjrwKSt52WrJLpEz4tNjg5loiZFAgDntLiSduNfQQ?=
 =?us-ascii?Q?6PExJ6ZnteTVyL6YY+eNIA4WT+b5G6cSVhUiX/O0Hn/FT/qHbIprMDiRuyJc?=
 =?us-ascii?Q?jpKlBlCnkQjRYvygE1YeD5Tduq9p4qRrVw75BIYwF5USE8EJa8t0oyFFk4uo?=
 =?us-ascii?Q?P5kCYOh0BAcghHZIrADVNTZQmbCLSKbBxdws6Kt6FLnYdJA9bLyPES315Sz1?=
 =?us-ascii?Q?V+3lgiO0jaaqQar3OOAb3deT+gF23VbtEH9+4Y6ifyz64riOU9+mnDg78GTh?=
 =?us-ascii?Q?g30dIWpPWx6GknBvEGXoCZZp25YiS7ZKYBAoBDKadJzdQx4rLTtNQk3o+eyD?=
 =?us-ascii?Q?5YHY2ifMWJ9CcuosBRNoruHRexPtD97EUhsnNSYLkkCAHn7CjfMsF+DYr0Xr?=
 =?us-ascii?Q?v3TNZFjUNN1cpTr5ZUg04YHdapD5ZKEEZQnJa9AO8E5UA6HWKY29yCmOmZ6q?=
 =?us-ascii?Q?x0zRZXOg5JnhEfTiAvKkf1inAgdYOUwDrigumhuBh9avm5KViMKbDX80MLig?=
 =?us-ascii?Q?NbLKA919bYh1kLJTfdsYZTDWJTVD8noS+riSUq88X+BYW8V2tftjvBXetcaZ?=
 =?us-ascii?Q?t+AS6uZJhbvpfc8v8KEd6jXqVL93OBvXEvS3dzhmpqfuMCi6MxIbVE078uJF?=
 =?us-ascii?Q?BqqTHtHmhqM89TbRwlbxGquIs0evEDJIN5TpczMXeYwlJXvmlWH8SyazBcII?=
 =?us-ascii?Q?xfJP1PvG8gHQfh1YyxY2zToPVij81wCA0/TPPAen9t5eVkm3hPM105koFrnH?=
 =?us-ascii?Q?Kr2wmfiblTAvBDvAxEFnBXJ/DpIAUksaCYa/mW1gasG82H5G9paUF4TuJMlU?=
 =?us-ascii?Q?/P7atDAz8L58kzU54n//o6hPb6ZyOTpdJkcZhbB187zRrBEe2/6O9/GuCMvW?=
 =?us-ascii?Q?eu3kRhylozz7JGuLKn29K4rIdds/eg=3D=3D?=
x-ms-traffictypediagnostic: HK2APC01HT118:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hl92k0Er96lN1QZfklXedpxpAno6zd9Qh/1HkuISTMNYcB3M76skezcvq6k/QurnD2y2shlb7U1wrSlPP+mYSVxxNmuWCcG/FfpFRveDrCNEqL2RenBYOJee09OCA1M5v80jLUnKSiVxvjGeghObhlh39XdQPySUl3FO2p8m6x0EdezZN0yMOhVAYf8TJKhTitI8ynW4xWhDDmWUZOMwxUoMUp3rINsIeatl9DSTPOc=
x-ms-exchange-antispam-messagedata: rKfofwDVCs43RYS1vT0HTdRBjux66MeDDxfjdPcJ/daIlH2oEJ78Jzg/znes04JRA8Jy4g3cIo8JJV9uOTYHgyQQU6wsWKqTBi/DAR25CFswRikx12sj9IrBmxO/yLUlAISxrccF9UHwNyT8QzKhE9KYSDR3vjjFtSI1LaLNqQuGr4l8BYS0Jd9k2cl2Qdhh05kGTCzwSqSTmKkBCuwITQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8BEAC0524B7BA4DB6B595EAD0A8EE67@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb723e0-cbae-4a3b-a092-08d7c4522ac1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 17:49:08.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Previous version: https://lkml.org/lkml/2020/3/2/693

Changed since previous version:

- Fixed memory leak when returning from nvmem_register().

- The patch 2/3 from last time was applied by Srinivas, so dropping it: 
  https://lkml.org/lkml/2020/3/5/616

- I split the patches into two as I said I would.

- Mika Westerberg asked me to send patch 3/3 to him again after v5.7-rc1 
  is released, so drop it for now:
  https://lore.kernel.org/lkml/20200306053455.GY2540@lahna.fi.intel.com/

- Removed comment from last return in nvmem_sysfs_get_groups() to avoid 
  confusion.

Nicholas Johnson (2):
  nvmem: Allow nvmem_sysfs_get_groups() to return NULL as error
    condition
  nvmem: Add support for write-only instances

 drivers/nvmem/core.c        |  4 +++
 drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 8 deletions(-)

-- 
2.25.1

