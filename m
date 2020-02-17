Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4219AC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1888A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="F84Im76Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgBQNqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:46:18 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55282 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726823AbgBQNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:46:09 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HDhVxP007656;
        Mon, 17 Feb 2020 14:45:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=6krLsyTnJQGCuNqc99FBtGiT29OEuI/cKr9z9oLmia8=;
 b=F84Im76Z7/5isx65KidMfCyyaLPXGt2Y5cGz2X+0BlsHzESPQg4vgRpUp6J5rEQhhCOe
 emI2exVjxiGhhLWsO9coFpILiLMqcnTGanXsd8/dreBVmvJV9s+xVNDLvxpmtiKZnDBZ
 oOo10cDgPlSLoH/6mQTiQsblEhz6AYncmx41dwxyscm2KLYjp07f0i7LErZxMD9F1++X
 RepEMliZoXQWFD+zh64zpjOS3f4r+FEJc5b6wlExHGz3KG91Tkt+6QhI20r9vXqOl0Vy
 RQ97DpGzb4/dRxwF5kjC1sYgtkzMYJhAoIkLtSz+gxvnNWLR/VyGI4YLyihMutFA56Rt FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y68dp3axk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 14:45:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 93321100034;
        Mon, 17 Feb 2020 14:45:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E01A2FF5C7;
        Mon, 17 Feb 2020 14:45:49 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Feb 2020 14:45:49
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <fabrice.gasnier@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 0/3] clockevent: add low power STM32 timer
Date:   Mon, 17 Feb 2020 14:45:43 +0100
Message-ID: <20200217134546.14562-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_08:2020-02-17,2020-02-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add low power timer as boadcast clockevent device.
Low power timer could runs even when CPUs are in idle mode and 
could wakeup them.

version 4:
- move defines in mfd/stm32-lptimer.h
- change compatible and subnode names
- document wakeup-source property
- reword commit message
- make driver Kconfig depends of MFD_STM32_LPTIMER
- remove useless include
- remove rate and clk fields from the private structure
- to add comments about the registers sequence in stm32_clkevent_lp_set_timer
- rework probe function and use devm_request_irq()
- do not allow module to be removed

version 3:
- fix timer set sequence
- don't forget to free irq on remove function
- use devm_kzalloc to simplify errors handling in probe function

version 2:
- stm32 clkevent driver is now a child of the stm32 lp timer node
- add a probe function and adpat the driver to use regmap provide
  by it parent
- stop using timer_of helpers


Benjamin Gaignard (3):
  dt-bindings: mfd: Document STM32 low power timer bindings
  mfd: stm32: Add defines to be used for clkevent purpose
  clocksource: Add Low Power STM32 timers driver

 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |  16 ++
 drivers/clocksource/Kconfig                        |   7 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-stm32-lp.c               | 213 +++++++++++++++++++++
 include/linux/mfd/stm32-lptimer.h                  |   5 +
 5 files changed, 242 insertions(+)
 create mode 100644 drivers/clocksource/timer-stm32-lp.c

-- 
2.15.0

