Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D303FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34AD2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgEUJf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:35:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728720AbgEUJfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:35:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9BA5FE96E50757FA2EB1;
        Thu, 21 May 2020 17:35:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 17:35:06 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <robh+dt@kernel.org>
CC:     <arnd@arndb.de>, <John.p.donnelly@oracle.com>,
        <pkushwaha@marvell.com>, <horms@verge.net.au>,
        <guohanjun@huawei.com>, <chenzhou10@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
Subject: [PATCH v8 5/5] dt-bindings: chosen: Document linux,low-memory-range for arm64 kdump
Date:   Thu, 21 May 2020 17:38:05 +0800
Message-ID: <20200521093805.64398-6-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521093805.64398-1-chenzhou10@huawei.com>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for DT property used by arm64 kdump:
linux,low-memory-range.
"linux,low-memory-range" is an another memory region used for crash
dump kernel devices.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 Documentation/devicetree/bindings/chosen.txt | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 45e79172a646..bfe6fb6976e6 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -103,6 +103,31 @@ While this property does not represent a real hardware, the address
 and the size are expressed in #address-cells and #size-cells,
 respectively, of the root node.
 
+linux,low-memory-range
+----------------------
+This property (arm64 only) holds a base address and size, describing a
+limited region below 4G. Similar to "linux,usable-memory-range", it is
+an another memory range which may be considered available for use by the
+kernel.
+
+e.g.
+
+/ {
+	chosen {
+		linux,low-memory-range = <0x0 0x70000000 0x0 0x10000000>;
+		linux,usable-memory-range = <0x202f 0xc0000000 0x0 0x40000000>;
+	};
+};
+
+The main usage is for crash dump kernel devices when reserving crashkernel
+above 4G. When reserving crashkernel above 4G, there may be two crash kernel
+regions, one is below 4G, the other is above 4G. In order to distinct from
+the high region, use this property to pass the low region.
+
+While this property does not represent a real hardware, the address
+and the size are expressed in #address-cells and #size-cells,
+respectively, of the root node.
+
 linux,elfcorehdr
 ----------------
 
-- 
2.20.1

