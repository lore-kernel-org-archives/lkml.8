Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA850C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D160D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBCbSVbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgF2Sxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgF2Sww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D9C02E2CC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so15508942wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snRavlMzvk6o89999ihW2SJGcP4kgkkLuKbzazJuz7M=;
        b=EBCbSVbxb5YiApQEcA5o+TIGFgyXHcDAl7i662DfxDYdnp862l0GPoQfWOcNUtjcSe
         jnezcozxuPVkZo5f4KjMKLccsMOZTvdDTyEbUlK4123+wVNAkXCXWv8ZfYrJxAS3qZ93
         8vrs/CdF0z7YODI7HgsfSKNJdxYv1vhR4+IGMmCaoAOzFgJycGJVJ0ZGcNbsup+I/eZE
         XqHkVB4Rbu4LtbCpo307g++fMpBLSJJGlXhTLve6b5TV0o4HitW+xa8FO/mP/sCAT6Pa
         3VnkcXGnjMH8qE1jsEUyE7sTCYERb3R3EtTgvwOpZAcOq6zxn7z3UFHnAkImidK5q/fj
         I+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snRavlMzvk6o89999ihW2SJGcP4kgkkLuKbzazJuz7M=;
        b=E1B9uHYV11G8VOzJ/dZm6QESMXWulDYDc7+zYLfF803zBzV06sGnVyxLJP8r4VwAxw
         n00bJ6VjrbYyHb4gNUeQhE/nSa3yLx8mm0hxNXZLx1raMcUYBH97CdMT50Wa148bZrBr
         t+gFpfeWr0JjAs0evFy8QBlqkDJT6Wb2da+5OiEaYSXuR9oMmtL5Tr4wg3RBW4216+n5
         y2NrVi0HZFTHGIkVZaibza+mDaPVkyjrLnaItvKGwThwuaadJpKNdfIFPvOmt47uKYN6
         K60ZeXOeLCstHjEBvbky4CRTN9IZkf71ufKVoRw+dHZyZAgO2ZaMmNK7tlWlW4diQt/A
         Ls6g==
X-Gm-Message-State: AOAM533u5dFSkKtSN18wIJ+qKxI9KJYGWFXiYlEswqIrXofIj8x4RLTq
        90mEBB0S7+Drg7RrV6TOaargyQ==
X-Google-Smtp-Source: ABdhPJwtIrvDrDIcBEd1RS2NhZDsLvIxIfEKOQpWVF86D0jsOeJclt4mGbamK7+WRgzx6R43bbW3/Q==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr16182224wms.109.1593439490833;
        Mon, 29 Jun 2020 07:04:50 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 04/20] misc: habanalabs: pci: Fix a variety of kerneldoc issues
Date:   Mon, 29 Jun 2020 15:04:26 +0100
Message-Id: <20200629140442.1043957-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hl_pci_bars_map() has a miss-typed argument name in the function
description.  hl_pci_elbi_write() was missing documented arguments.
The headers for functions hl_pci_bars_unmap(), hl_pci_elbi_write()
and hl_pci_reset_link_through_bridge() were written in kerneldoc
format, but lack the kerneldoc identifier '/**'.  Let's promote
them so they can gain access to the checker.

These changes fix the following W=1 kernel build warnings:

 drivers/misc/habanalabs/pci.c:27: warning: Function parameter or member 'name' not described in 'hl_pci_bars_map'
 drivers/misc/habanalabs/pci.c:27: warning: Excess function parameter 'bar_name' description in 'hl_pci_bars_map'
 drivers/misc/habanalabs/pci.c:147: warning: Function parameter or member 'addr' not described in 'hl_pci_iatu_write'
 drivers/misc/habanalabs/pci.c:147: warning: Function parameter or member 'data' not described in 'hl_pci_iatu_write'
 drivers/misc/habanalabs/pci.c:324: warning: Excess function parameter 'dma_mask' description in 'hl_pci_set_dma_mask'

Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/habanalabs/pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index 9f634ef6f5b37..24073e8eb8df9 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -15,7 +15,7 @@
 /**
  * hl_pci_bars_map() - Map PCI BARs.
  * @hdev: Pointer to hl_device structure.
- * @bar_name: Array of BAR names.
+ * @name: Array of BAR names.
  * @is_wc: Array with flag per BAR whether a write-combined mapping is needed.
  *
  * Request PCI regions and map them to kernel virtual addresses.
@@ -61,7 +61,7 @@ int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 	return rc;
 }
 
-/*
+/**
  * hl_pci_bars_unmap() - Unmap PCI BARS.
  * @hdev: Pointer to hl_device structure.
  *
@@ -80,9 +80,11 @@ static void hl_pci_bars_unmap(struct hl_device *hdev)
 	pci_release_regions(pdev);
 }
 
-/*
+/**
  * hl_pci_elbi_write() - Write through the ELBI interface.
  * @hdev: Pointer to hl_device structure.
+ * @addr: Address to write to
+ * @data: Data to write
  *
  * Return: 0 on success, negative value for failure.
  */
@@ -140,6 +142,8 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 /**
  * hl_pci_iatu_write() - iatu write routine.
  * @hdev: Pointer to hl_device structure.
+ * @addr: Address to write to
+ * @data: Data to write
  *
  * Return: 0 on success, negative value for failure.
  */
@@ -161,7 +165,7 @@ int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data)
 	return 0;
 }
 
-/*
+/**
  * hl_pci_reset_link_through_bridge() - Reset PCI link.
  * @hdev: Pointer to hl_device structure.
  */
-- 
2.25.1

