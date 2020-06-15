Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44047C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C00207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vplh0Fj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgFON4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFON43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:56:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AE9C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:56:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so6873250pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+BfvoZ+77dTAo4L/XNf+TiVonlXEEViAwZrs/5d7U9U=;
        b=vplh0Fj9/eSjlcLM1uoaEHsnubxkfYZJQTNBNwkrq469Vg8oUjYF+ExpyWU8sd7dd2
         tu0PGAqL6qcINmBHnDVyQ36ihZLF+SSVIKjMIBGkAuq4wqViV2XX5wTl0MR/pNqN8vG8
         al5a1MDzOAECR74HCCZ1mGHac9BHtNf+VAaOCxp1il1dTV76bP3kxPZE3WayuJ3Kz0Qs
         5QEhfbvSs+KzWvj11Rj8s1Y8Nx3394hru2UVIsGXLlcyPmVC8qzWkzlMImHRAw0Y7IpH
         Ca/eCkdU4xiK9lPNFvYWrBSR4DCk4CqoByR3ISrODiT9CdYos8pLKcblYqUMvWGxR04m
         H9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+BfvoZ+77dTAo4L/XNf+TiVonlXEEViAwZrs/5d7U9U=;
        b=F2f6rtaTDcwV25g0UBPmX60UDfY+cyqh7IFYpc5K6q+HeYMaEU3Q/4N0Fe87fO1TeE
         mV/797yvNwRx2waLE6Mz7CJgwuFMcN8792zr2z974QgO30uxHFmeYK66MkvnxlUFkW1n
         OiCkWrVI8eiD1cHhInUlWumEBAN87RSCdNPJv1uDsDIAsxAWC+0kAcS3ygecRQSMS5hf
         4HSUckKl0dwMQSiog+rjsFNq5RqQsolojbTidu67chdkqAziXvChGkvk6ZxfsZLZFdCs
         8gM834+14QDaiMDvZv71mEtIP7giZGwhwae7A7Th/oUjAYjAZFeOa6HbD8H21UVuliQ3
         dqYA==
X-Gm-Message-State: AOAM531yYsTmkbZEvBvrbTAEffIqwnfK3V5LjrOZY9dhvGOOqf1Z9ZG6
        iiro9uxXRE/8XeE9IMzUdZ/NXQ==
X-Google-Smtp-Source: ABdhPJwVhpIdNIqkhVyeCQ5zjjJWP0RCYj7RGnqZE1YV/4j4JxB8XfQa842SpJkUUSps8c9DQx5uIw==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr22252506plb.235.1592229388518;
        Mon, 15 Jun 2020 06:56:28 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.20])
        by smtp.gmail.com with ESMTPSA id h20sm13751691pfo.105.2020.06.15.06.56.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:56:27 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] uacce: remove uacce_vma_fault
Date:   Mon, 15 Jun 2020 21:55:57 +0800
Message-Id: <1592229357-1904-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer error if removing uacce's parent module during app's
running. SIGBUS is already reported by do_page_fault, so uacce_vma_fault
is not needed. If providing vma_fault, vmf->page has to be filled as well,
required by __do_fault.

Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 107028e..aa91f69 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -179,14 +179,6 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static vm_fault_t uacce_vma_fault(struct vm_fault *vmf)
-{
-	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
-		return VM_FAULT_SIGBUS;
-
-	return 0;
-}
-
 static void uacce_vma_close(struct vm_area_struct *vma)
 {
 	struct uacce_queue *q = vma->vm_private_data;
@@ -199,7 +191,6 @@ static void uacce_vma_close(struct vm_area_struct *vma)
 }
 
 static const struct vm_operations_struct uacce_vm_ops = {
-	.fault = uacce_vma_fault,
 	.close = uacce_vma_close,
 };
 
-- 
2.7.4

