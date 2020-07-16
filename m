Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2735CC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28AC2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbrRNiW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgGPHRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgGPHRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:17:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4CFC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:48 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so4634767qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kTol5GJuQxW55C0DALb7A0VHIIQ+s0sQAconNEeDfM=;
        b=lbrRNiW+DfxjpEXQTrZI6+0GTWdiR8d/1wJUN5MeczqIZPRM/Da3QIyy3INppiFCju
         8xxfGA5AxN1hIH5+GYNE2uhLThWIOwMknucUIzOVtXFCymzzDPeTz8cv75eGo8rGwns2
         J7FUISIqhjYs7PRTQUpsxZ07cklnEaUOgr0aIgweLAfB96kfw09noDCWjlzlu2UETWwO
         qlvJVgLclRGIKg4fL8viUE04DuCzN6rD3Fi3hVJR2ou0/ZfLEzdfOw9RlQdqzNCFozzm
         3J1oPyyg97jyJdlE1kSVekQGzGSfyCmUDmmaf8Uyp78p/yU8QIl33kDeDbf2ADUl28/u
         CSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kTol5GJuQxW55C0DALb7A0VHIIQ+s0sQAconNEeDfM=;
        b=eh49VM0rbpKcxTYE4PTqanTYv4IvlPILJmFyw+h491De7Gyp089KC9dWG8q5uTBxjs
         GYm8m5wFqOWBYD9Mg4shJuIsaHMM/YYozoKvnwnxvuy0Tpdo1lnvyLyxFRJdWxMlIoof
         jiNloEeROnNQDtLJbWd5xuYSR98XdsecAGw6GyylzZLCsZ/HNsruSS97JCf2iknQ6esV
         1V4EqP6CCcxZUVLEVBYcmvDvANT1v86LyQwITO9G+iWoonhFtx4nsGnBaNAFYJ3M6yzR
         pJVs1ugAqWX+OXHGTm4+hJoQcUepCPd+K8sxOmEvhTou928mmfDlEmsM3TE/g+PlH+zZ
         4/dg==
X-Gm-Message-State: AOAM530ucfHPDA0Gu/4SbWTZ4kT7sXXXXzvahVC2VP7PLdZLEOgnZ+8m
        S912mi/omplhkpKhRDzd/wk=
X-Google-Smtp-Source: ABdhPJyPYxbcXqZiIlqgIBkRwrA9s3w2p3iBLIHGZLyHZek8yS4AapXcz3RTTQ+dSn99zdJULxoDOA==
X-Received: by 2002:a37:7682:: with SMTP id r124mr2501311qkc.43.1594883867335;
        Thu, 16 Jul 2020 00:17:47 -0700 (PDT)
Received: from LeoBras.ibmuc.com (200-236-239-31.dynamic.desktop.com.br. [200.236.239.31])
        by smtp.gmail.com with ESMTPSA id a5sm6637989qtd.84.2020.07.16.00.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:17:46 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] powerpc/iommu: Move iommu_table cleaning routine to iommu_table_clean
Date:   Thu, 16 Jul 2020 04:16:57 -0300
Message-Id: <20200716071658.467820-6-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200716071658.467820-1-leobras.c@gmail.com>
References: <20200716071658.467820-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the part of iommu_table_free() that does struct iommu_table cleaning
into iommu_table_clean, so we can invoke it separately.

This new function is useful for cleaning struct iommu_table before
initializing it again with a new DMA window, without having it freed and
allocated again.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/kernel/iommu.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 9704f3f76e63..c3242253a4e7 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -735,21 +735,10 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid,
 	return tbl;
 }
 
-static void iommu_table_free(struct kref *kref)
+static void iommu_table_clean(struct iommu_table *tbl)
 {
 	unsigned long bitmap_sz;
 	unsigned int order;
-	struct iommu_table *tbl;
-
-	tbl = container_of(kref, struct iommu_table, it_kref);
-
-	if (tbl->it_ops->free)
-		tbl->it_ops->free(tbl);
-
-	if (!tbl->it_map) {
-		kfree(tbl);
-		return;
-	}
 
 	iommu_table_release_pages(tbl);
 
@@ -763,6 +752,23 @@ static void iommu_table_free(struct kref *kref)
 	/* free bitmap */
 	order = get_order(bitmap_sz);
 	free_pages((unsigned long) tbl->it_map, order);
+}
+
+static void iommu_table_free(struct kref *kref)
+{
+	struct iommu_table *tbl;
+
+	tbl = container_of(kref, struct iommu_table, it_kref);
+
+	if (tbl->it_ops->free)
+		tbl->it_ops->free(tbl);
+
+	if (!tbl->it_map) {
+		kfree(tbl);
+		return;
+	}
+
+	iommu_table_clean(tbl);
 
 	/* free table */
 	kfree(tbl);
-- 
2.25.4

