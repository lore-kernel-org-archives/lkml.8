Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C784C3403B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3D620801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="T8GRwcZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRNNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:13:00 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41464 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726340AbgBRNNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:13:00 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IDCelT012136;
        Tue, 18 Feb 2020 14:12:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=xh9StjrKQoi3YqvG7gzxeBKNMD5vor0HeJJ1DoKwiHw=;
 b=T8GRwcZJzVefAS7Ng8ytr4ydei06en/eP6yA8pNMfv0B6UbSgG7YrLfLFy3HquF+Dg3G
 aOeK+igIp3NYltnHLzwHuTvjjhZ45WPSsXHnnpdJzPg5fC3IOj+O1CNnwML/v6n/G1xO
 CwjRs011+YOxA8+51xD2dP1oxzocAwNFyEct+scLOuUQ39kwABnZSwF6Rfp7wEu7ngB4
 TwM79/qQKi0vN/x73Mpc1kkgMM9Bqe3ZkSA89lBUP4sO/UH/arZhB7cTDVXXxzGfsGSR
 nrD9Z3/whL4HxB5xDGupGdaG6SCft0M+ojXACy/INTuRitJD/ZEy4sF5ZCVj4iC+tjIh Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y68dp97uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 14:12:43 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7698510002A;
        Tue, 18 Feb 2020 14:12:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3F6C72B12F3;
        Tue, 18 Feb 2020 14:12:37 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Feb 2020 14:12:36
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <marex@denx.de>
Subject: [PATCH v2 0/2] Add GPIO level-sensitive interrupt support
Date:   Tue, 18 Feb 2020 14:12:16 +0100
Message-ID: <20200218131218.10789-1-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the possibility to handle gpio interrupts on level.

GPIO hardware block is directly linked to EXTI block but EXTI handles
external interrupts only on edge. To be able to handle GPIO interrupt on
level a "hack" is done in gpio irq chip: parent interrupt (exti irq chip)
is retriggered following interrupt type and gpio line value.

In exti irq chip, retrigger ops function is added.

Changes since v1:
 - Fix issue reported by Marek: return statment in "stm32_gpio_set_type"
   function.

Regards
Alex

Alexandre Torgue (2):
  irqchip/stm32: Add irq retrigger support
  pinctrl: stm32: Add level interrupt support to gpio irq chip

 drivers/irqchip/irq-stm32-exti.c      | 14 ++++++++-
 drivers/pinctrl/stm32/pinctrl-stm32.c | 45 +++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.17.1

