Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F022C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D92207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgCXMyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:54:46 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:36154 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgCXMyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:54:46 -0400
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id JCuj2200C5USYZQ01CujFj; Tue, 24 Mar 2020 13:54:43 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jGj4t-0005G9-4B; Tue, 24 Mar 2020 13:54:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jGj4t-0005jJ-2M; Tue, 24 Mar 2020 13:54:43 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dma-buf: Improve CONFIG_DMABUF_MOVE_NOTIFY help text
Date:   Tue, 24 Mar 2020 13:54:42 +0100
Message-Id: <20200324125442.21983-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the help text for the CONFIG_DMABUF_MOVE_NOTIFY symbol by:
  1. Removing duplicated single quotes,
  2. Adding a missing subject,
  3. Fixing a misspelling of "yet",
  4. Wrapping long lines.

Fixes: bb42df4662a44765 ("dma-buf: add dynamic DMA-buf handling v15")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma-buf/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index ef73b678419c6d86..9626673f1d83ae64 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -43,11 +43,12 @@ config DMABUF_MOVE_NOTIFY
 	bool "Move notify between drivers (EXPERIMENTAL)"
 	default n
 	help
-	  Don''t pin buffers if the dynamic DMA-buf interface is available on both the
-	  exporter as well as the importer. This fixes a security problem where
-	  userspace is able to pin unrestricted amounts of memory through DMA-buf.
-	  But marked experimental because we don''t jet have a consistent execution
-	  context and memory management between drivers.
+	  Don't pin buffers if the dynamic DMA-buf interface is available on
+	  both the exporter as well as the importer. This fixes a security
+	  problem where userspace is able to pin unrestricted amounts of memory
+	  through DMA-buf.
+	  This is marked experimental because we don't yet have a consistent
+	  execution context and memory management between drivers.
 
 config DMABUF_SELFTESTS
 	tristate "Selftests for the dma-buf interfaces"
-- 
2.17.1

