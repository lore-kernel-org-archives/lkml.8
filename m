Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87524C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB9F2065C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgFCF0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:26:12 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59804 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCF0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:26:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E23D200D4F;
        Wed,  3 Jun 2020 07:26:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ADEFC200D21;
        Wed,  3 Jun 2020 07:26:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 218E9402E4;
        Wed,  3 Jun 2020 13:26:02 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 0/3] Handle mailbox clock/power management related issues
Date:   Wed,  3 Jun 2020 13:15:41 +0800
Message-Id: <1591161344-12885-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current i.MX mailbox driver mainly supports 2 series i.MX SoCs with
different architecture, one is for i.MX8X platforms with SCU inside,
the other is for i.MX6/7/8M series without SCU.

For i.MX8X, 2 types of MU are supported, one is for system IPC, such kind
of MU has no clock/power assignment, they are both controlled by SCU. The
other is for application, such kind of MU has no clock assignment, but have
power domain assignment, consumers need to call mailbox APIs to manage MU
power in runtime;

For i.MX6/7/8M, MU clock or power could be assigned based on different SoCs,
but all the MUs are for application, consumers need to call mailbox APIs to
manage MU clock/power in runtime.

For the power management related issue mentioned above, they are as below:

1. clock should be managed in runtime to make sure MU clock/power can be off
   on i.MX6/7/8M platforms;
2. ONLY system IPC MU needs to have IRQF_NO_SUSPEND flag set, other application
   MU no need to have this flag, since the MU clock/power is OFF in noirq
   suspend phase and if MU interrupt arrives, with IRQF_NO_SUSPEND flag set,
   the MU ISR will try to access MU register and lead to system hang because
   of clock/power disabled;

To distinguish these different MU instances, use MU's clock/power assignment
status to decide whether to save/restore MU context during suspend/resume,
whether to have IRQF_NO_SUSPEND flag set, etc..

patch #1 is identical with https://patchwork.kernel.org/patch/11581215/, the
patch #2/#3 depend on #1, so I resend #1 in this series to make them as a whole
series.

Anson Huang (2):
  mailbox: imx: Add runtime PM callback to handle MU clocks
  mailbox: imx: ONLY IPC MU needs IRQF_NO_SUSPEND flag

Dong Aisheng (1):
  mailbox: imx: Add context save/restore for suspend/resume

 drivers/mailbox/imx-mailbox.c | 72 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

-- 
2.7.4

