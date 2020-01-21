Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258CDC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CCA21734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAUGTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:19:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:33355 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbgAUGTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:19:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 22:19:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; 
   d="scan'208";a="278302031"
Received: from hyperv-sh3.bj.intel.com ([10.240.193.95])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2020 22:19:49 -0800
From:   Jing Liu <jing2.liu@linux.intel.com>
To:     virtio-dev@lists.oasis-open.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, Jing Liu <jing2.liu@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Zha Bin <zhabin@linux.alibaba.com>
Subject: [virtio-dev] [PATCH v2 3/5] virtio-mmio: Add feature bit for MMIO MSI
Date:   Tue, 21 Jan 2020 21:54:31 +0800
Message-Id: <1579614873-21907-4-git-send-email-jing2.liu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current MMIO transport layer uses a single, dedicated interrupt
signal, which brings performance penalty. Add a feature bit (40)
for introducing MSI capability.

Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 content.tex | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/content.tex b/content.tex
index 5881253..ff151ba 100644
--- a/content.tex
+++ b/content.tex
@@ -5840,6 +5840,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   \item[VIRTIO_F_MMIO_NOTIFICATION(39)] This feature indicates
   that the device supports enhanced notification mechanism on
   MMIO transport layer.
+  \item[VIRTIO_F_MMIO_MSI(40)] This feature indicates that the
+  device supports Message Signal Interrupts (MSI) mechanism on
+  MMIO transport layer.
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
 
@@ -5875,6 +5878,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
 A driver SHOULD accept VIRTIO_F_MMIO_NOTIFICATION if it is offered.
 
+A driver SHOULD accept VIRTIO_F_MMIO_MSI if it is offered.
+If VIRTIO_F_MMIO_MSI has been negotiated, a driver MUST try to
+set up MSI at first priority.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
 
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
-- 
2.7.4

