Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB222C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F7F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gXvyvwbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCXKua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:50:30 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:37522 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgCXKua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585047029; x=1616583029;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=TxlBi3ra4HMx8zuqspMqJ3ApAbYybIFOtoUMzIZQnpE=;
  b=gXvyvwbPIeS6MHA1/BKc6tLxq9xrsyguFOsvqk8TzEDPiYd5p+iaMoVp
   WVR71wKf2VkP3C+YVmZQy6032RJqsBVm9NjnjD0jc7CjlkgH+WxqfNDgA
   cVYHPRtJsYFH9+e5Xn+EpmuPB+9qIrFHTwuRcDi7bYvHge9p9QyGRvAAQ
   A=;
IronPort-SDR: bCo4jtv7LFaaBuNw2kk0Cv7swc6NiVbyPBkdlU1QBKrMC8FohCy5dsrclfPt1QZQBiyT+3uQzN
 d2F/l/rARt9w==
X-IronPort-AV: E=Sophos;i="5.72,300,1580774400"; 
   d="scan'208";a="34501424"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 24 Mar 2020 10:50:27 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 2E6EFA18E6;
        Tue, 24 Mar 2020 10:50:26 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 24 Mar 2020 10:50:25 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.241) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Mar 2020 10:50:15 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <hhhawa@amazon.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>
Subject: [PATCH v5 0/6] Amazon's Annapurna Labs Alpine v3 device-tree
Date:   Tue, 24 Mar 2020 12:49:12 +0200
Message-ID: <20200324104918.29578-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.241]
X-ClientProxiedBy: EX13D36UWA001.ant.amazon.com (10.43.160.71) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series organize the Amazon's Annapurna Labs Alpine device tree
bindings, device tree folder and adds new device tree for Alpine v3.

Changes since v4:
-----------------
- Re-order nodes in increasing order.
- Add disable to UART nodes.
- Add missing UART nodes (1,2,3)
- Add comments for GIC/UART
- Add io-fabric bus, and move uart nodes into it.
- Fix MSIx range according Alpine function spec

Changes since v3:
-----------------
- rebased and retested for tag Linux 5.6-rc2

Changes since v2:
-----------------
- Move up a level for DT node without mmio regs.
- Drop device_type from serial@fd883000 node.
- Minor change name of PCIe node to: pcie@fbd00000

Changes since v1:
-----------------
- Rename al,alpine DT binding to amazon,alpine
- Rename al folder to be amazon
- Update maintainers of amazon,alpine DT
- Add missing alpine-v2 DT binding
- Fix yaml schemas for alpine-v3-evp.dts:
	- #size-cells:0:0: 0 is not one of [1, 2]
	- arch-timer: interrupts: [[1, 13, 8, 1, 14, 8, 1, 11, 8, 1, 10,
	8]] is too short
- Change compatible string of alpine-v3-evp to amazon,al

Hanna Hawa (5):
  dt-bindings: arm: amazon: rename al,alpine DT binding to amazon,al
  arm64: dts: amazon: rename al folder to be amazon
  dt-bindings: arm: amazon: update maintainers of amazon,al DT bindings
  dt-bindings: arm: amazon: add missing alpine-v2 DT binding
  dt-bindings: arm: amazon: add Amazon Annapurna Labs Alpine V3

Ronen Krupnik (1):
  arm64: dts: amazon: add Amazon's Annapurna Labs Alpine v3 support

 .../devicetree/bindings/arm/al,alpine.yaml    |  21 -
 .../devicetree/bindings/arm/amazon,al.yaml    |  33 ++
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/Makefile                  |   2 +-
 arch/arm64/boot/dts/{al => amazon}/Makefile   |   1 +
 .../boot/dts/{al => amazon}/alpine-v2-evp.dts |   0
 .../boot/dts/{al => amazon}/alpine-v2.dtsi    |   0
 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts  |  24 ++
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi     | 408 ++++++++++++++++++
 9 files changed, 468 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/amazon,al.yaml
 rename arch/arm64/boot/dts/{al => amazon}/Makefile (64%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2-evp.dts (100%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi (100%)
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3.dtsi

-- 
2.17.1

