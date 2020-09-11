Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F65C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AC1221E5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgIKERu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:17:50 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:63195 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgIKERt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 00:17:49 -0400
X-Greylist: delayed 1872 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Sep 2020 00:17:49 EDT
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 08B3SSNJ083872
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 11:28:28 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 08B3SMCn083854;
        Fri, 11 Sep 2020 11:28:22 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Sep
 2020 11:46:32 +0800
From:   "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <minyard@acm.org>, <linus.walleij@linaro.org>,
        <haiyue.wang@linux.intel.com>, <cyrilbur@gmail.com>,
        <rlippert@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     <ryan_chen@aspeedtech.com>
Subject: [PATCH 0/4] Remove LPC register partitioning
Date:   Fri, 11 Sep 2020 11:46:27 +0800
Message-ID: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 08B3SMCn083854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPC controller has no concept of the BMC and the Host partitions.
The incorrect partitioning can impose unnecessary range restrictions
on register access through the syscon regmap interface.

For instance, HICRB contains the I/O port address configuration
of KCS channel 1/2. However, the KCS#1/#2 drivers cannot access
HICRB as it is located at the other LPC partition.

In addition, to be backward compatible, the newly added HW control
bits could be added at any reserved bits over the LPC addressing space.

Thereby, this patch series aims to remove the LPC partitioning for
better driver development and maintenance.

Chia-Wei, Wang (4):
  ARM: dts: Remove LPC BMC and Host partitions
  soc: aspeed: Fix LPC register offsets
  ipmi: kcs: aspeed: Fix LPC register offsets
  pinctrl: aspeed-g5: Fix LPC register offsets

 arch/arm/boot/dts/aspeed-g4.dtsi           |  74 +++++------
 arch/arm/boot/dts/aspeed-g5.dtsi           | 135 +++++++++------------
 arch/arm/boot/dts/aspeed-g6.dtsi           | 135 +++++++++------------
 drivers/char/ipmi/kcs_bmc_aspeed.c         |  13 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c |   2 +-
 drivers/soc/aspeed/aspeed-lpc-ctrl.c       |   6 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c      |  11 +-
 7 files changed, 162 insertions(+), 214 deletions(-)

-- 
2.17.1

