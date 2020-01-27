Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7030C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB1320702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XxLDSW/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgA0IyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:54:09 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:31958 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729423AbgA0IyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:54:05 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R8rFdF011482;
        Mon, 27 Jan 2020 09:53:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ph4w8wTNIFAH7Lv1cHY+WCanej56MAlJja9BHKFQag4=;
 b=XxLDSW/oMTYlYGoDFhaCAy0QhI/ticramibopIUoEDsXm9T+L44NWf9NMnd8LcysTRkB
 xExnoMz9HiLgattMBBjlbHX5AmoTxGJjYZlDeFebU5uIoMtuS2akMUYbx9njCWlQyhVh
 rCuTdkB/HgCowGLe6WjRUfIWreG4fdq6IGL4ABVAZbhWW9ukVkiiCIHbKzINuN9+pxgG
 zJVae9Wosv6CbGwBsB3TqUUdqRTCKw9G2lA/TZkn/9xfMafPhsAaAKhcAR4dJp2wUfdi
 0bWPx17GvXi6j945h3g5/JXcL1cMM4Ur+l3Ug00UzJDAaMALDLQkG9Dkuzb3+gC+x+y2 bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpar4st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 09:53:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 604B6100038;
        Mon, 27 Jan 2020 09:53:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4F7ED21CA6A;
        Mon, 27 Jan 2020 09:53:42 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 Jan 2020 09:53:41
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH 0/6] STM32 MDMA driver fixes and improvements
Date:   Mon, 27 Jan 2020 09:53:28 +0100
Message-ID: <20200127085334.13163-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings improvements to the MDMA driver, with support of power
management and descriptor reuse. Probe function gets a cleanup and to avoid
a race with vchan_complete, driver now adopts vchan_terminate_vdesc().

Amelie Delaunay (2):
  dmaengine: stm32-mdma: driver defers probe for clock and reset
  dmaengine: stm32-mdma: use vchan_terminate_vdesc() in .terminate_all

Etienne Carriere (2):
  dmaengine: stm32-mdma: use reset controller only at probe time
  dmaengine: stm32-mdma: disable clock in case of error during probe

Pierre-Yves MORDRET (2):
  dmaengine: stm32-mdma: add suspend/resume power management support
  dmaengine: stm32-mdma: enable descriptor_reuse

 drivers/dma/stm32-mdma.c | 78 +++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 16 deletions(-)

-- 
2.17.1

