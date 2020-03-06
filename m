Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F7C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E3720717
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ov8p4sH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCFO2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:28:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46484 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCFO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:28:48 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 026ESegK099759;
        Fri, 6 Mar 2020 08:28:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583504920;
        bh=nJkBMed8w4sXrkiAhBZn6mLmjcuxymlMCJ3xM5WNMgE=;
        h=From:To:CC:Subject:Date;
        b=ov8p4sH3ZClhBwI0tyRzc2zbzjm5Tylsp3e/0A0sAg1hdnV4YW4pyAEnk0afPn0hr
         0Ru1T9b38lKCcuiiSoFAyAWlt/dUqo7V1QilSCtmAWVIXrugr43WWz908Sk5/MqN2D
         mYiOA5iolb6vc2PULBn0F32kGdOXQQPTMFO6z2VQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 026ESeIu041112
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Mar 2020 08:28:40 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Mar
 2020 08:28:39 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Mar 2020 08:28:39 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 026ESbUY115246;
        Fri, 6 Mar 2020 08:28:38 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH v5 0/3]  dmaengine: Initial debugfs support
Date:   Fri, 6 Mar 2020 16:28:36 +0200
Message-ID: <20200306142839.17910-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes sicne v4:
- Move the dmaengine_debugfs_init() from late_initcall to be called from
  dma_bus_init to avoid races due to probe orders of drivers.
- Separate patch to create DMA driver directories for debugfs

Changes since v3:
- Create a directory for dmaengine and name the initial file as summary
- Function to get the debugfs root for DMA drivers if they want to place files
- Custom dbg_summary_show implementation for k3-udma

Changes since v2:
- Use dma_chan_name() for printing the channel's name

Changes since v1:
- Use much more simplified fops for the debugfs file (via DEFINE_SHOW_ATTRIBUTE)
- do not allow modification to dma_device_list while the debugfs file is read
- rename the slave_name to dbg_client_name (it is only for debugging)
- print information about dma_router if it is used by the channel
- Formating of the output slightly changed

The basic debugfs file (/sys/kernel/debug/dmaengine/summary) can be used to
query basic information about the DMAengine usage (am654-evm):

# cat /sys/kernel/debug/dmaengine/summary
dma0 (285c0000.dma-controller): number of channels: 96

dma1 (31150000.dma-controller): number of channels: 267
 dma1chan0    | 2b00000.mcasp:tx
 dma1chan1    | 2b00000.mcasp:rx
 dma1chan2    | in-use
 dma1chan3    | in-use
 dma1chan4    | in-use
 dma1chan5    | in-use

Drivers can implement custom dbg_summary_show to add extended information via
the summary file, like with the second patch for k3-udma (j721e-evm):

# cat /sys/kernel/debug/dmaengine/summary
dma0 (285c0000.dma-controller): number of channels: 24

dma1 (31150000.dma-controller): number of channels: 84
 dma1chan0    | 2b00000.mcasp:tx (MEM_TO_DEV, tchan16 [0x1010 -> 0xc400], PDMA[ ACC32 BURST ], TR mode)
 dma1chan1    | 2b00000.mcasp:rx (DEV_TO_MEM, rchan16 [0x4400 -> 0x9010], PDMA[ ACC32 BURST ], TR mode)
 dma1chan2    | 2ba0000.mcasp:tx (MEM_TO_DEV, tchan17 [0x1011 -> 0xc507], PDMA[ ACC32 BURST ], TR mode)
 dma1chan3    | 2ba0000.mcasp:rx (DEV_TO_MEM, rchan17 [0x4507 -> 0x9011], PDMA[ ACC32 BURST ], TR mode)
 dma1chan4    | in-use (MEM_TO_MEM, chan0 pair [0x1000 -> 0x9000], PSI-L Native, TR mode)
 dma1chan5    | in-use (MEM_TO_MEM, chan1 pair [0x1001 -> 0x9001], PSI-L Native, TR mode)
 dma1chan6    | in-use (MEM_TO_MEM, chan4 pair [0x1004 -> 0x9004], PSI-L Native, TR mode)
 dma1chan7    | in-use (MEM_TO_MEM, chan5 pair [0x1005 -> 0x9005], PSI-L Native, TR mode)

With the last patch the debugfs looks like this:
# ls -al /sys/kernel/debug/dmaengine/
total 0
drwxr-xr-x  4 root root 0 Jan  1 02:00 .
drwx------ 29 root root 0 Jan  1 02:00 ..
drwxr-xr-x  2 root root 0 Jan  1 02:00 285c0000.dma-controller
drwxr-xr-x  2 root root 0 Jan  1 02:00 31150000.dma-controller
-r--r--r--  1 root root 0 Jan  1 02:00 summary


Regards,
Peter
---
Peter Ujfalusi (3):
  dmaengine: Add basic debugfs support
  dmaengine: ti: k3-udma: Implement custom dbg_summary_show for debugfs
  dmaengine: Create debug directories for DMA devices

 drivers/dma/dmaengine.c   | 102 +++++++++++++++++++++++++++++++++++++-
 drivers/dma/dmaengine.h   |  16 ++++++
 drivers/dma/ti/k3-udma.c  |  63 +++++++++++++++++++++++
 include/linux/dmaengine.h |  14 +++++-
 4 files changed, 193 insertions(+), 2 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

