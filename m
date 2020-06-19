Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24268C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF15420771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8EWbXE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgFSFHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgFSFHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:07:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33593C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l17so7868557qki.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxhuxQycNieQ16w87JkTA9DQfwrE4fTWZ8DvCETKWbk=;
        b=N8EWbXE33GuLRhB4nF/r7qebEqLn6wGSnJRbNKKhK5CKbMgeUNWwwLSOVtNoB2MWTg
         6hYDMpCLOhswyz5LBmFFbLVrj7SZh7DbmtJx748+o7XwX5IyztICXLe/F4R14xuUallm
         5KXaGE4CirCMYqEmvdSQTY0uv4F0fEWNLYct/ITrZ8o90JDMR6W95hNCxaZxchQtn6HY
         s1IYQOUgZ2gVSXnQpK23D9Nd2Gol2iys92eXiZ2xOdqeC0ibK0SgRYhFF4BA3o1wVvSI
         iduaOHHbGnwNjSWUl4r4pfnlQxnCCbPSEJOxi6O2zxekqyp5fl6h1HQUhssB4yVP4Zx5
         m7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxhuxQycNieQ16w87JkTA9DQfwrE4fTWZ8DvCETKWbk=;
        b=dhbVTQHGRkBG4bHesfF4iDnxFY1JBW1GMxBHTj1JloJUOAotlUfLsCJNM9eL98/X60
         jVXPFLlmxK8j5VzAkrJH0mmE9lbwHJqnX9IY8XkU3joWGT32/wPwuPr4HLgeaU19HsEz
         ROZBKqbXQlBPebHIYVJgNYpU9iVn5pt1M8xkDvhUv6fvfnqph1E4OeutUpr2V9wiRyyN
         J1ZnfmFDgQnlx0wISxY9YcYC/iRCcULxcbF+I7oLgCLHGePgWrEeRUJHmbg/sjJfu/1+
         frEDxW13RUKYdtA8mywImRiUJFPnQH46zVHXjJM7q8sMxXYZXPpd6tPtjWQiG+BnVvvk
         toDw==
X-Gm-Message-State: AOAM533U0FjJiGAxNFQf3y/GCt7naOgPqAEtc/BqRwz4UPbUZbj2juv0
        stBu8/Vg4JlliegwQXiXAtM=
X-Google-Smtp-Source: ABdhPJypgjgeE05JPijQXMPTOnCQ0LI/Ef1IGd5HGvb7euUV2UZ7GmUd/GQ+FbWq/bF5/CQuSKn4MQ==
X-Received: by 2002:a37:4b17:: with SMTP id y23mr1809929qka.73.1592543259489;
        Thu, 18 Jun 2020 22:07:39 -0700 (PDT)
Received: from LeoBras.ibmuc.com (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id o6sm5235503qtd.59.2020.06.18.22.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 22:07:38 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] powerpc/pseries/iommu: Remove default DMA window before creating DDW
Date:   Fri, 19 Jun 2020 02:06:20 -0300
Message-Id: <20200619050619.266888-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619050619.266888-1-leobras.c@gmail.com>
References: <20200619050619.266888-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On LoPAR "DMA Window Manipulation Calls", it's recommended to remove the
default DMA window for the device, before attempting to configure a DDW,
in order to make the maximum resources available for the next DDW to be
created.

This is a requirement for some devices to use DDW, given they only
allow one DMA window.

If setting up a new DDW fails anywhere after the removal of this
default DMA window, restore it using reset_dma_window.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index de633f6ae093..68d1ea957ac7 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1074,8 +1074,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	u64 dma_addr, max_addr;
 	struct device_node *dn;
 	u32 ddw_avail[3];
+
 	struct direct_window *window;
-	struct property *win64;
+	struct property *win64, *dfl_win;
 	struct dynamic_dma_window_prop *ddwprop;
 	struct failed_ddw_pdn *fpdn;
 
@@ -1110,8 +1111,19 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (ret)
 		goto out_failed;
 
-       /*
-	 * Query if there is a second window of size to map the
+	/*
+	 * First step of setting up DDW is removing the default DMA window,
+	 * if it's present. It will make all the resources available to the
+	 * new DDW window.
+	 * If anything fails after this, we need to restore it.
+	 */
+
+	dfl_win = of_find_property(pdn, "ibm,dma-window", NULL);
+	if (dfl_win)
+		remove_dma_window(pdn, ddw_avail, dfl_win);
+
+	/*
+	 * Query if there is a window of size to map the
 	 * whole partition.  Query returns number of windows, largest
 	 * block assigned to PE (partition endpoint), and two bitmasks
 	 * of page sizes: supported and supported for migrate-dma.
@@ -1219,6 +1231,8 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	kfree(win64);
 
 out_failed:
+	if (dfl_win)
+		reset_dma_window(dev, pdn);
 
 	fpdn = kzalloc(sizeof(*fpdn), GFP_KERNEL);
 	if (!fpdn)
-- 
2.25.4

