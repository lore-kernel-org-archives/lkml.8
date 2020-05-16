Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE22C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFE720767
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i+igG9fN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X0h703nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgEPGjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 02:39:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50631 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgEPGja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 02:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589611175; x=1621147175;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Wt3azPXfUVl0RMdCuK//fKY9HSzhZ/q+8Z8VdRFT6Wo=;
  b=i+igG9fNLNuMBxssqxhro2W9Nh+EyYgEXXGsp7MDJv15nAkTAEgtsy7K
   T5ofI5X0ldAOWu3o0Hb0ujM5D3Cazs88mV7BnBp+kxxN+K2CyZLJ7TJRB
   oHQFahsUDbkCLffFUoTlCrBs/IenOLI0xZh36KesczpRSoKunEekRmj4I
   pBUrN9/TOiq8MRZddPnGwcFvtiqwnPmQdTjXf+REvsJawxtPMFBgSe7La
   l7IdSNgU+mb7SbSpHTOtNGqhXJ/HYOT1ATKQ3HD7QecpdK+GOiA8tcmXQ
   hGNdsY4pGlHCh1n9VfymypqbVlHG2cabaGIlLIYicJpkB90myIhK7Ugkg
   w==;
IronPort-SDR: cVkn3kmiDrS9jcP5gltEoq10nvjZFIrVZ/jDybMFbiuUmEcL4Bie7v6Oa4Nxabiioh8epinPJ8
 3PVZzporKQaJqi4ZE4r/sm2dnLDkWlwhnFc54sAI8gtsing6J+XHK6CzlHMMhmhCFF2BdhjMaO
 Oy39fjJttsHZBOVcWznIQIdQGqQ8/oOiN0JDw7Xa49cmtGzyUvJVdzaEk0FUXOQE0gyHZlF9ZB
 OzBoPR5M2nrbpNKNZV8XYdALyCIdMYP/ftmE3O4iElzN1KFvIeL4TGrIjcvqiJJjAc9vn6w5ZW
 rHc=
X-IronPort-AV: E=Sophos;i="5.73,398,1583164800"; 
   d="scan'208";a="240555224"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 14:39:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnMleQNWmK0TH/8xuKDsIzw8iE1MXXYsIZLNcvHrfECPdqK8ctZV0tE+o0m1d0g6d6APJtEpuZ0d37cCkOBDc55HOD8SBZ517w0ogBfN+tQ4IKvwliDqw2j3zMnR7jlBN9Sj5LaMBU2iVSDKIj18k/Z41wd3IZtLB9CLKiw2PYkOAn9xmSNPGM7jkPqvmZAUrxY8hUXhcW1NlDhn2aFFyTLTGRKJIbDq2k9FCkaImp5igd6iaYuRbpMZeEEzx+w/L/6mwlHQ+E1Hxvwg71DcRECm87So/BB7RwxrfiOPv1lJ1ZJb/0w+WWU5FWiUASbSMRMk1DQEmyafUWd9cjMOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+pxkYWY89LjURYHXKn7eE5s0eh6YNR6wXbSTl1Oe7w=;
 b=D14iPgZSKwYV8lctswQYv1uqBFevw1rO2T7WC5jVRYZARWF0mshLm0MedmHmgH7rzZTRCpX5fdyoqOcDimOxql1vSZ09fjuNroCvLGfMWtTPhuvpz1Yx4g3pzPD1MS/jBW1qImu5W4TEGsQfpaNzgDRixNPnUALcaU+V8RjTgCzKo9ZdsHnHHV9n8Ad6nHQ6evBOZNv1IqyZPt1mM27xcZawz8U43CYQWdrC6RT8vVIi2hjy1/z8xLfU3GujwBOWYhed0ygyZgt+E+sItkZy+xeF5D6W2B6/3Axl/837tzUpTrDnaty/fvp8e+uTMsUdXEbRoyxs3ZPARjIv/Z6NXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+pxkYWY89LjURYHXKn7eE5s0eh6YNR6wXbSTl1Oe7w=;
 b=X0h703nwHnMoM0eBryuyo3/4eza/bx5LqJa4y7KyBpC2Z98XnHF1vKuZ2Y/Bwp5W6lU8qcdUV8JCioa8gjoqSoxRMXL3oy4+CT7XOo1+FeY8j2XszuFITAoXp4nNBFGT53o+La8n9N04sBEfPeWG+b7iuflwDFMeSsncRCb5MX0=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4539.namprd04.prod.outlook.com (2603:10b6:5:2c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sat, 16 May
 2020 06:39:27 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2979.033; Sat, 16 May 2020
 06:39:27 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 0/4] More improvements for multiple PLICs
Date:   Sat, 16 May 2020 12:08:57 +0530
Message-Id: <20200516063901.18365-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::12) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.60.36) by MAXPR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Sat, 16 May 2020 06:39:23 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.60.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dac512a-f01b-4207-1b86-08d7f963e137
X-MS-TrafficTypeDiagnostic: DM6PR04MB4539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4539BB41E81B381134F1548B8DBA0@DM6PR04MB4539.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 040513D301
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n41V8tiewqW/quOjYp3pBOz+PVxdefTaHpHfl9+JPPCMm4qTyHhwxNOYvAWhzcgTCIrmCopjxwcozKpaWyxmfRMgiIfFTYgVHnzglACAEf6k1DwXFQOfGmNoRQjL0TAfXF1ogoJmnLCXUFdxVfJVQFucKFw8jUklfjquMhECuwJo9zJFPbVsNL4NNkkAycpze/P8jTdcA8RbNr9O2gKZVgZXTeLB/g+Qm3M5Q8FH/cB7iy6PAWzT09pXiyoA+tkKzNndw/WuZsAGFBoDvo/JGfwlMXeE+NuUYmRCEsn66xSwqrZsyiabY/dQaJdy3N3y1imqdsnRvSw/BuBUcJFBfsUS+xk6dg0+C6Y+4Qnfa2xTnfSyhRQ4fSCGQFd+h607tbeKDVzqUtsHv6dGB0Br9VWZlEdr11tU3FZRKX+JljObSYWtF1kMLiFqeoFbqeqVnEPKzDLKxfDjFgJsrej077XtK2P/TOEc6zdpSCJ02wg5K+ZWv8Kxy0PWFRzb8Srs5Bfs3vHVm/dsuU8jHoJLMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(6666004)(1006002)(2906002)(8676002)(36756003)(8936002)(966005)(44832011)(26005)(54906003)(86362001)(7696005)(52116002)(55236004)(110136005)(1076003)(16526019)(186003)(316002)(5660300002)(66946007)(8886007)(55016002)(66476007)(66556008)(478600001)(956004)(4326008)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oddKB7A2/h2WujbuMlBfBWsVWEcEluL94Zo+UNO8Vqu4W6j9G7SS7xlxYXizNw9N9pZptEUvNAsClGD0gFNd1mhLDDEg7SLEQkHWqAslWGyGoOXyJETR1vbMQn/+a1UCjbS62gEMvi5ND9v6XIN4wwM+fZzf4AzMsKyon+U+MtYEGuLR3uMI6fBuv/WHRtgaQG21YYviKO2F8JBO+gTriOgAfW7oHrVM6vHPHUvmHfJUubdfg/50OluM0XDI3BFQA4judtkoITecxLa9kGE4UBJa6AWtvnviNuecbfBje4xLC6H+C8H7Zg9j8s1Ro31hPbi8t846r57du4M4NHAEli8sDwZtKkO3stA+6QBDL04pBNgVZMH9wKHfx/VFNDYB7n22mdNCZYiqJUpehPC1AJPJGwWXvW3xCLwDL5yrav/1sJUd3w8+OG810sAZbyslCfzIdrkS0a6gPBFx51Y6d6BH9G0NlneKhRA82cQ//Ak=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dac512a-f01b-4207-1b86-08d7f963e137
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 06:39:27.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZg1UrKtgAKassh9ZwB/zNdkjYTeArHNW4vHfEvcDaugG0Kw1OqCPP/dXsyO3gBBrFnhon+c+XVKBrcbjdjQvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4539
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does more improvements for supporting multiple PLIC
instances.

PATCH1 and PATCH4 are fixes whereas PATCH2 and PATCH3 help users
distinguish between multiple PLIC instances.

These patches are based up Linux-5.7-rc5 and can be found at
plic_imp_v1 branch at: https://github.com/avpatel/linux.git

To try this patches, we will need:
1. OpenSBI multi-PLIC and multi-CLINT support which can be found in
   multi_plic_clint_v1 branch at:
   https://github.com/avpatel/opensbi.git
2. QEMU RISC-V multi-socket support which can be found in
   riscv_multi_socket_v1 branch at:
   https://github.com/avpatel/qemu.git

Anup Patel (4):
  irqchip/sifive-plic: Setup cpuhp once after current handler is present
  irqchip/sifive-plic: Improve boot prints for multiple PLIC instances
  irqchip/sifive-plic: Separate irq_chip for muiltiple PLIC instances
  irqchip/sifive-plic: Set default irq affinity in plic_irqdomain_map()

 drivers/irqchip/irq-sifive-plic.c | 50 +++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 15 deletions(-)

-- 
2.25.1

