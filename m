Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B643AC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880FF20775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgICNMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:12:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728950AbgICMxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:53:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3994CD8AFAE9B2A858E0;
        Thu,  3 Sep 2020 20:05:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 20:05:19 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/2] add support for Hisilicon SD5203 vector interrupt controller
Date:   Thu, 3 Sep 2020 20:05:02 +0800
Message-ID: <20200903120504.2308-1-thunder.leizhen@huawei.com>
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

The interrupt controller of SD5203 SoC is VIC(vector interrupt controller), it's
based on Synopsys DesignWare APB interrupt controller (dw_apb_ictl) IP, but it
can not directly use dw_apb_ictl driver. The main reason is that VIC is used as
primary interrupt controller and dw_apb_ictl driver worked for secondary
interrupt controller. So add a new driver: "hisilicon,sd5203-vic".

Kefeng Wang (1):
  irqchip: add Hisilicon SD5203 vector interrupt controller

Zhen Lei (1):
  dt-bindings: interrupt-controller: add Hisilicon SD5203 vector
    interrupt controller

 .../hisilicon,sd5203-vic.txt                  |  27 ++++
 drivers/irqchip/Kconfig                       |   5 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sd5203-vic.c              | 128 ++++++++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt
 create mode 100644 drivers/irqchip/irq-sd5203-vic.c

-- 
2.26.0.106.g9fadedd


