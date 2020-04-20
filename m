Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAA6C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A769206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AQ+BNEev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDTMQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:16:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgDTMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:16:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KBrrvn025502;
        Mon, 20 Apr 2020 14:16:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=4Hco8eUbgLngU+46SDeLvb1sIqNNOjjSfMzszI1XO5o=;
 b=AQ+BNEevYsYsgUn6CBuo20UiAFcWlH0jqXedBULgcomSfszGAglUmuoncne2s7229+dY
 OP+NwM2LOtnYHJ4s3GI1JdtK2koSA97Q/Wg0vGjraaMpottCsp+jjcIQESU/01eF6d4E
 Q03vsaHNR0tChkteNNeTQ0kfGrjnDpmTTCxuIaqLrefpmo/xrLsHnFdhRH1fmiDYeSCg
 X5X7KIncLd2Xbn8yKrZyh4OksEayeONm1xsh7pUVz+6PTpp9j8eqWCRNZEQ0ffUg6UAf
 gUEO5OANcxiJr9gkuDCpQm3Y4yP8Oka7PlRAOFH6SMWDy3JZQBMGEn7/IXhh6qm5LhG/ Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fq11a668-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 14:16:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8AACB10002A;
        Mon, 20 Apr 2020 14:16:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F6E320FA76;
        Mon, 20 Apr 2020 14:16:24 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 20 Apr 2020 14:16:23
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <fabrice.gasnier@st.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v7 0/6] clockevent: add low power STM32 timer
Date:   Mon, 20 Apr 2020 14:16:14 +0200
Message-ID: <20200420121620.2099-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add low power timer as boadcast clockevent device.
Low power timer could runs even when CPUs are in idle mode and 
could wakeup them.

Lee has acked the MFD part.
Clocksource driver still need to be reviewed by maintainers.
Add missing part of the bindings to describe interrupt.

version 7:
- rebased on top of v5.7-rc2

version 6:
- simplify binding, DT and code to use only one interrupt

version 5:
- document interrupts and interrupt-names bindings
- use a different wake up interrupt
- add device-tree patch
- make STM32MP157 select low power timer configuration flag
- enable fast_io in regmap configuration

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


Benjamin Gaignard (6):
  dt-bindings: mfd: Document STM32 low power timer bindings
  ARM: dts: stm32: Add timer subnodes on stm32mp15 SoCs
  mfd: stm32: Add defines to be used for clkevent purpose
  mfd: stm32: enable regmap fast_io for stm32-lptimer
  clocksource: Add Low Power STM32 timers driver
  ARM: mach-stm32: select low power timer for STM32MP157

 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |   5 +
 arch/arm/boot/dts/stm32mp151.dtsi                  |  35 ++++
 arch/arm/mach-stm32/Kconfig                        |   1 +
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-stm32-lp.c               | 221 +++++++++++++++++++++
 drivers/mfd/stm32-lptimer.c                        |   1 +
 include/linux/mfd/stm32-lptimer.h                  |   5 +
 8 files changed, 273 insertions(+)
 create mode 100644 drivers/clocksource/timer-stm32-lp.c

-- 
2.15.0

