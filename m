Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0535C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D100520758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIBEle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:41:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44255 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgIBEld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:41:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id b19so4211257lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 21:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CNQ+uOSUaXPsAHOE4jBatrY5v8vedinhiQESkHIW8co=;
        b=Fycp9tpVRdEbQa1NU6DG7dID5xl2M17PHeeo71svSYTHZ2P85KW7jmPJ8nfQtMB/M0
         88/LauVaM2zf9Oh1viUnxrLPa5xfsXSOBIIIgxNuHGvVW5eGRhO4enOh+gDThhzWCkwU
         pBq7USJpVH1hw1DZxxECeA6LalzAzeLz+Nce4ZX4FaRJEK2HGTaxE8jgEXng/Hk7mEy6
         D/LzO3jUIuR2b+j35H96QF9wohqYw2hDq1LHMIJGY85q7mrsDQMKmAr7ZQ9fGmOiN5f4
         EiOZdS8bb0NtG3UzR8SyH4wem4RtBMQLuVtwloPEeIgfRTgTypSU6Q6hCJrpn+DTHHDl
         bW3A==
X-Gm-Message-State: AOAM5329q/LqT9fdRNWFHqsA3RR7mIYHTL9ufGUc02OWF29DRRiMaC8e
        pVheY68gT312E1XsSFPvSrY=
X-Google-Smtp-Source: ABdhPJxfgSnF1CLTWj3u4dHFE+w+eNMO9yzG4J3SAAiH1jhnncu2lyxxvtzRku/oPsswKDk/3fPk9Q==
X-Received: by 2002:a05:651c:310:: with SMTP id a16mr2180211ljp.250.1599021691194;
        Tue, 01 Sep 2020 21:41:31 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id i26sm704823ljj.102.2020.09.01.21.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 21:41:30 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: ifnullfree: add vfree(), kvfree*() functions
Date:   Wed,  2 Sep 2020 07:40:59 +0300
Message-Id: <20200902044059.7133-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the list of free functions with kvfree(), kvfree_sensitive(),
vfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/free/ifnullfree.cocci | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/free/ifnullfree.cocci b/scripts/coccinelle/free/ifnullfree.cocci
index 2045391e36a0..285b92d5c665 100644
--- a/scripts/coccinelle/free/ifnullfree.cocci
+++ b/scripts/coccinelle/free/ifnullfree.cocci
@@ -20,8 +20,14 @@ expression E;
 - if (E != NULL)
 (
   kfree(E);
+|
+  kvfree(E);
 |
   kfree_sensitive(E);
+|
+  kvfree_sensitive(E, ...);
+|
+  vfree(E);
 |
   debugfs_remove(E);
 |
@@ -42,9 +48,10 @@ position p;
 @@
 
 * if (E != NULL)
-*	\(kfree@p\|kfree_sensitive@p\|debugfs_remove@p\|debugfs_remove_recursive@p\|
+*	\(kfree@p\|kvfree@p\|kfree_sensitive@p\|kvfree_sensitive@p\|vfree@p\|
+*         debugfs_remove@p\|debugfs_remove_recursive@p\|
 *         usb_free_urb@p\|kmem_cache_destroy@p\|mempool_destroy@p\|
-*         dma_pool_destroy@p\)(E);
+*         dma_pool_destroy@p\)(E, ...);
 
 @script:python depends on org@
 p << r.p;
-- 
2.26.2

