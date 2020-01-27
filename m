Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B26AC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E728B21739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MLzLYhbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA0NUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:20:34 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36794 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgA0NUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 08:20:34 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKRh7080041;
        Mon, 27 Jan 2020 07:20:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580131227;
        bh=7S+AHAvGw+jEstuwftAAsutAuBgK1pdbwIioApexPDY=;
        h=From:To:CC:Subject:Date;
        b=MLzLYhbKuhDlAvg7/DI1iAGbWW6JlBQlfHGW4CxLVDcMCDISPLD7et2UDqihNUwBv
         UVLNV6EuBtuIWx7Yjfusz7Z52tp1+CCFJinu31ev54bNxkzZfVOxjk/GJ4fJOTP21f
         XDKV/nUoQtRa3tyhdQFU1SwqznYkql3qks9JGr5Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00RDKRwi013881
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jan 2020 07:20:27 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 07:20:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 07:20:27 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKPa2020427;
        Mon, 27 Jan 2020 07:20:25 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
Subject: [PATCH for-next 0/4] dmaengine: ti: k3-udma: Updates for next
Date:   Mon, 27 Jan 2020 15:21:07 +0200
Message-ID: <20200127132111.20464-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Based on customer reports we have identified two issues with the UDMA driver:

TX completion (1st patch):
The scheduled work based workaround for checking for completion worked well for
UART, but it had significant impact on SPI performance.
The underlying issue is coming from the fact that we have split data movement
architecture.
In order to know that the transfer is really done we need to check the remote
end's (PDMA) byte counter.

RX channel teardown with stale data in PDMA (2nd patch):
If we try to stop the RX DMA channel (teardown) then PDMA is trying to flush the
data is might received from a peripheral, but if UDMA does not have a packet to
use for this draining than it is going to push back on the PDMA and the flush
will never completes.
The workaround is to use a dummy descriptor for flush purposes when the channel
is terminated and we did not have active transfer (no descriptor for UDMA).
This allows UDMA to drain the data and the teardown can complete.

The last two patch is to use common code to set up the TR parameters for
slave_sg, cyclic and memcpy. The setup code is the same as we used for memcpy
with the change we can handle 4.2GB sg elements and periods in case of cyclic.
It is also nice that we have single function to do the configuration.

Regards,
Peter
---
Peter Ujfalusi (3):
  dmaengine: ti: k3-udma: Workaround for RX teardown with stale data in
    peer
  dmaengine: ti: k3-udma: Move the TR counter calculation to helper
    function
  dmaengine: ti: k3-udma: Use the TR counter helper for slave_sg and
    cyclic

Vignesh Raghavendra (1):
  dmaengine: ti: k3-udma: Use ktime/usleep_range based TX completion
    check

 drivers/dma/ti/k3-udma.c | 452 +++++++++++++++++++++++++++++----------
 1 file changed, 343 insertions(+), 109 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

