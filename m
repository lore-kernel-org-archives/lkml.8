Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE83C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0409F2137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgIGMXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:23:53 -0400
Received: from foss.arm.com ([217.140.110.172]:34330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbgIGMSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:18:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D7EE1045;
        Mon,  7 Sep 2020 05:18:38 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 830213F66E;
        Mon,  7 Sep 2020 05:18:37 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] ARM/arm64: dts: Fix SP804/SP805 users
Date:   Mon,  7 Sep 2020 13:18:25 +0100
Message-Id: <20200907121831.242281-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are the remaining patches of the SP804/SP805 DT fixes. [1][2]
ARM, Broadcom and Freescale have their respective fixes queued through
their maintainers already, but I haven't heard back from LG or HiSilicon
so far.
So can those patches be taken through armsoc directly?
---------------------

Some DTs in the kernel tree were not conforming to the SP804 and SP805
binding.
Fix those DTs to correctly describe the clocks, while making sure that
the devices stay functional with the current Linux driver.

Thanks,
Andre

[1] http://lkml.iu.edu/hypermail/linux/kernel/2008.3/07072.html
[2] http://lkml.iu.edu/hypermail/linux/kernel/2008.3/07167.html

Andre Przywara (6):
  ARM: dts: hisilicon: Fix SP804 users
  ARM: dts: nspire: Fix SP804 users
  arm64: dts: lg: Fix SP804 users
  arm64: dts: hisilicon: Fix SP805 clocks
  arm64: dts: lg: Fix SP805 clocks
  ARM: dts: hisilicon: Fix SP805 clocks

 arch/arm/boot/dts/hi3620.dtsi             | 30 +++++++++++++++--------
 arch/arm/boot/dts/hip04.dtsi              |  4 +--
 arch/arm/boot/dts/hisi-x5hd2.dtsi         |  5 ++--
 arch/arm/boot/dts/nspire.dtsi             | 12 ++++++---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 +++++---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  5 ++--
 arch/arm64/boot/dts/lg/lg1312.dtsi        | 10 ++++----
 arch/arm64/boot/dts/lg/lg1313.dtsi        | 10 ++++----
 8 files changed, 52 insertions(+), 34 deletions(-)

-- 
2.17.1

