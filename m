Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF52C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26EDC2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TcD0zJer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDVJIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:08:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10048 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgDVJIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:08:48 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M8wB7n011347;
        Wed, 22 Apr 2020 11:08:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Ps7TvwTK/0SEKTWJDXvtpJV0GLq5jnv18Nnlhcp4Kx8=;
 b=TcD0zJerMIjUUHkkZn3jX9sw9yQukoX0mUJx29wBmDDP7x7W8vh2fL7gE1wfUI6eTmJZ
 D9rkMmTbkYSocZCkGDmXWFv1Ogjk8qfHGBbp49WFeyJh0TNIVjuww3XMVmGuY9jfJQqZ
 bSYz6Nw/7QID6U+pUtlbn8hsWnavvWx5ZnQGdA9brMrEiejTNZBYpXbrYed1+bJhuj+t
 leCA1x4jro7K+BccK8+BdqqTIQSGCq4G31OcrDz5kjTl3QKZcNfEcNeyMmAIh2Ez84v5
 2WFps4uf7iSIv9T164oENzsixFepdm/Xb2xkwyzwjolYszuV3hP4lPpGZSb85kiarWFE OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fq11nbvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 11:08:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 625F410002A;
        Wed, 22 Apr 2020 11:08:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 55FCC2A4D94;
        Wed, 22 Apr 2020 11:08:38 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 Apr 2020 11:08:37
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/3] STMFX power related fixes
Date:   Wed, 22 Apr 2020 11:08:30 +0200
Message-ID: <20200422090833.9743-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-21,2020-04-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With suspend/resume tests on STM32MP157C-EV1 board, on which STMFX is used by
several devices, some errors could occurred: -6 when trying to restore STMFX
registers, spurious interrupts after disabling supply...
This patchset fixes all these issues and cleans IRQ init error path.

Amelie Delaunay (3):
  mfd: stmfx: reset chip on resume as supply was disabled
  mfd: stmfx: fix stmfx_irq_init error path
  mfd: stmfx: disable irq in suspend to avoid spurious interrupt

 drivers/mfd/stmfx.c       | 22 ++++++++++++++++++++--
 include/linux/mfd/stmfx.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1

