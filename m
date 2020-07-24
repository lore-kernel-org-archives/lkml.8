Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA22C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAEAD2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a6Y/L91h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGXN1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:27:44 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:55684 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595597264; x=1627133264;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=GEQALP2YK7Y1RCK5HFtBMn6+lsbi6MEGwon9BiZrUcA=;
  b=a6Y/L91hcu3G0Jl5gwy+HF4viwbxj5/li7OT6e9VXHLVi1+XkSGj4qhq
   nA+KEYtkwXxiBS9gtnfWcmRjvSjQMSnuiru0Nk4qHxbvMPjIvRjPidxx9
   Xhnu3K3csc6KAhwHtgxDFMBGM7Ltk1HbJUshKz6K3gjSuH9maiQzXoQBx
   4=;
IronPort-SDR: 5q+pCF6MlLntyqmyq76+dyVonwbRdqKLZHYclOsufOPVFK0FK5h0dMQt0QPn9ry4mBpjhSz2tb
 L3FUXifnJhLQ==
X-IronPort-AV: E=Sophos;i="5.75,390,1589241600"; 
   d="scan'208";a="61287045"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 24 Jul 2020 13:27:42 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id A64BBA17F8;
        Fri, 24 Jul 2020 13:27:40 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Jul 2020 13:27:40 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.160.65) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Jul 2020 13:27:31 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>, <tsahee@annapurnalabs.com>,
        <antoine.tenart@bootlin.com>, <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>
List-Id: <soc.lore.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <arm@kernel.org>,
        <soc@kernel.org>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <eitan@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH v6 0/6] Amazon's Annapurna Labs Alpine v3 device-tree
Date:   Fri, 24 Jul 2020 16:26:48 +0300
Message-ID: <20200724132654.16549-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D32UWA004.ant.amazon.com (10.43.160.193) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series organize the Amazon's Annapurna Labs Alpine device tree
bindings, device tree folder and adds new device tree for Alpine v3.

Changes since v5:
-----------------
- Rebase on v5.8-rc6

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

