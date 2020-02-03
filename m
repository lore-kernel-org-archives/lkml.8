Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6838EC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C84321582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aSkQ4DYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgBCNvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:51:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34066 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726561AbgBCNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:51:16 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013DlF9f029759;
        Mon, 3 Feb 2020 14:51:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Ig25JM6AtLTyb9X/mlnTXxZt7Y+zkIOmGtydqVrayJs=;
 b=aSkQ4DYsgfbRahVkwk8D7CxrED9yYNQvDOnQJHucmtrL/zf+JUpP0VBGVdJn44iELHut
 tyLy54mwCouffI03OS2slRHBJ/luuxNZdzZ8Pg309EojHQiGnKuuvIse/do03yh9IrQT
 0BPWT0dlwlqARNRqxR61/czTFdYsElGpxJPpReKmKlM3dabQaOBMWeWQdbQUfxHPrNr2
 ojf8o/oIsBDIGW94igYVeE9iSdirO1aFim0N7lU4mS1qAwVnDaHy8TSOWmWOG3zeIjZK
 Pz9AbmANKFig0GOqbrPgqIXadBw3wBCuXxPg+y+CIWHBZXKEDGXBDaeYDWRrwa2kY71U BA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xw13nh9f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 14:51:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 22EC210002A;
        Mon,  3 Feb 2020 14:51:05 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 122C02BC7CF;
        Mon,  3 Feb 2020 14:51:05 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb 2020 14:51:04
 +0100
From:   <patrice.chotard@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@st.com>, <christophe.kerello@st.com>
Subject: [PATCH 0/2] spi: stm32-qspi: rework probe error path
Date:   Mon, 3 Feb 2020 14:50:46 +0100
Message-ID: <20200203135048.1299-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_04:2020-02-02,2020-02-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This series is fixing the probe error path of spi-stm32-qspi driver: 
  - it allows to defer probe if reset controller driver is not yet probed.
  - if fixes the error path in releasing only allocated ressouces in case of error.

Etienne Carriere (1):
  spi: stm32-qspi: defer probe for reset controller

Lionel Debieve (1):
  spi: stm32-qspi: properly manage probe errors

 drivers/spi/spi-stm32-qspi.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

-- 
2.17.1

