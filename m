Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6D6206EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgICMij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:38:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48956 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728651AbgICM2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:28:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 818E426A143AB5ECD4D7;
        Thu,  3 Sep 2020 20:28:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 20:28:22 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/3] add support for Hisilicon SD5203 SoC
Date:   Thu, 3 Sep 2020 20:27:31 +0800
Message-ID: <20200903122734.2369-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD5203 SoC config option and devicetree file, also enable its debug UART.

Kefeng Wang (3):
  ARM: hisi: add support for SD5203 SoC
  ARM: debug: add UART early console support for SD5203
  ARM: dts: add SD5203 dts

 arch/arm/Kconfig.debug       | 11 ++++-
 arch/arm/boot/dts/Makefile   |  2 +
 arch/arm/boot/dts/sd5203.dts | 90 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/Kconfig   | 16 ++++++-
 4 files changed, 116 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/sd5203.dts

-- 
2.26.0.106.g9fadedd


