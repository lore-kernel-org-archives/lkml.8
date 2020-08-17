Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2786C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A024D2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4ZgIE5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHQXlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgHQXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:41:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0044BC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:03 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d14so16660037qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4pvezruqLZGZxlep+/8CtLytSlMuAJbS5PO1pRjRZ2A=;
        b=o4ZgIE5hUZtt9C/X/WWI8vcoQiLbf5ZScgCCr+PJA64zZzgxYbha59fEpFp2wXPcO6
         v3cF/GAHaFnlwEhfdTMVtKe0UFpeantVLiSl9TwakZiJL88an5HoKvRHZ3mw38/D8o/4
         ADvG7N9hDTso4qWFlL8iMs2kb8f309m6tcv9w+p6E8TsRLbXQ1vqrKOPipf4RF1pqNWr
         qGjONDNhVOYPosm6u7V/CoIA6iGmXvJyRcEduDmNy1C4iwMBN/zZJwWVnfX9YR/4hvWh
         voBUwB2UWFb/TjgGf3nG85mOV+dbCR5b891zGXnykvOarEdkFPZq8rOhGOtA3QNaXeel
         6Tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4pvezruqLZGZxlep+/8CtLytSlMuAJbS5PO1pRjRZ2A=;
        b=aw5HKjyteit+gOo3XHKXvsYJIgWg5JftolPdnJrffI4mBZlJhUnvYxCdG+pSGto+pn
         /EGqbRj0FSMgXbV7e5tax4QJ0fN7Blzmhh3IZQ9ehKqghIZ8t9yQ2Qaz7AlQGfWh8fAU
         SxLz7XhtcMnYfay9QNEe+W+cUvmq5/TSLf/k/alybGRBDIdCUlNH2RiaPnLhp2k5K99k
         f+QK8tPN9LFgha5n1ViMnXrqaXfKi+Yin0HNAQkBdaCmQbsCTAWTKqhb4KtYrT2RbGeu
         S6LkWjEI5U+KxlCqnMi5Ux4oP6uVlDpzIsLbGT5Nt+NE0u75DLNQ1jxaQ1vin4JpnCDO
         3GCw==
X-Gm-Message-State: AOAM530nBGPY9xoFJLWhkaGhBFQXtjF6W8wk1Wq6DZZhsFgPd3dkoJu3
        BtYfPZt9q+4sOTKkocg712Q=
X-Google-Smtp-Source: ABdhPJxehOMVbJQckk7e/Qh1mMulQWUFFQwhe2K4ElGutd/V7ytUlUfzbgALu/PGyL6iroFhCddtUQ==
X-Received: by 2002:a37:614:: with SMTP id 20mr14659203qkg.456.1597707663297;
        Mon, 17 Aug 2020 16:41:03 -0700 (PDT)
Received: from LeoBras.ibmuc.com ([177.35.193.93])
        by smtp.gmail.com with ESMTPSA id w58sm22342868qth.95.2020.08.17.16.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:41:02 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/10] powerpc/kernel/iommu: Use largepool as a last resort when !largealloc
Date:   Mon, 17 Aug 2020 20:40:26 -0300
Message-Id: <20200817234033.442511-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817234033.442511-1-leobras.c@gmail.com>
References: <20200817234033.442511-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, doing iommu_range_alloc() only for !largealloc (npages <= 15)
will only be able to use 3/4 of the available pages, given pages on
largepool  not being available for !largealloc.

This could mean some drivers not being able to fully use all the available
pages for the DMA window.

Add pages on largepool as a last resort for !largealloc, making all pages
of the DMA window available.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/kernel/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index d7086087830f..7f603d4e62d4 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -261,6 +261,15 @@ static unsigned long iommu_range_alloc(struct device *dev,
 			pass++;
 			goto again;
 
+		} else if (pass == tbl->nr_pools + 1) {
+			/* Last resort: try largepool */
+			spin_unlock(&pool->lock);
+			pool = &tbl->large_pool;
+			spin_lock(&pool->lock);
+			pool->hint = pool->start;
+			pass++;
+			goto again;
+
 		} else {
 			/* Give up */
 			spin_unlock_irqrestore(&(pool->lock), flags);
-- 
2.25.4

