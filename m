Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F9C35E00
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B373C20726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L65wrXfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgBYLaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:30:13 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17430 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgBYLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582630211; x=1614166211;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=F6J0f5QaF/SjK4oeY+JWx0EZF6vBtVVKsTgfqWyLaj8=;
  b=L65wrXfLdQlh+2ny3ve0qCt6C7vwQLaEmt6aZoRPZl1zZnOM+fDdw1lE
   sPFKUgCW0hgC0/0HJnAh0AopYhgUVthlWo5GcTh+X+l6+JaJErgyjlicJ
   uiYw2BAsTz4UWuE5MGnwb6DzDxDJo6wGc7bbS7phODi1KyTGSQ+79IlmY
   g=;
IronPort-SDR: 2cN/vl9BK+ohQRJrzGlpG1Mfsj8IXVkgBjhfK4pS/wkh1Ju7udxQwKR3b+c+UL5PBRwnqGURWN
 ybU5FrppDe8w==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="18467363"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 25 Feb 2020 11:29:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 3C9F6A24C6;
        Tue, 25 Feb 2020 11:29:54 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 11:29:54 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 11:29:45 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <hhhawa@amazon.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <eitan@amazon.com>
Subject: [PATCH v4 0/6] Amazon's Annapurna Labs Alpine v3 device-tree
Date:   Tue, 25 Feb 2020 13:29:20 +0200
Message-ID: <20200225112926.16518-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D02UWB002.ant.amazon.com (10.43.161.160) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series organize the Amazon's Annapurna Labs Alpine device tree
bindings, device tree folder and adds new device tree for Alpine v3.

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
 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts  |  23 ++
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi     | 371 ++++++++++++++++++
 9 files changed, 430 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/amazon,al.yaml
 rename arch/arm64/boot/dts/{al => amazon}/Makefile (64%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2-evp.dts (100%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi (100%)
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3.dtsi

-- 
2.17.1

