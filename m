Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8846C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29922187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXEgZMMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgANH6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:58:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40797 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgANH54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:57:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so6185311pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdqD8NRNphouo9P3H8kSDAOVyLnUT6AjcPDXOI9PAiQ=;
        b=hXEgZMMfgZiKB0EiZMA8jnwtGVY5x7TFCicAgnVuoKVm/oL3b1I9rT4nQxEKh2Aduc
         eBf+3WgpTPpbe2XLWgBqBtMnr3mKL3ULYAd0CBWTnJfF3jikFm8ZJjIPUXHd3EYu8xCW
         fROeetq+ibhA623110viLke2EtOw1Ne/dMR+wB67s1Xo1kGPMGJ6lkOe+NBWBzUXXSlI
         tajOZDcrlDV00sqYDQHsLVyeCw/pnUojUaDdzuJxFFIbSuxTmWND8IwQgetc4u957+Kb
         8oH4RSxVb/aUQec1MZpft5UDzNNp8dPrJR3fq5UAtOhefO+8ITVeLPEwMrRUlTW8EwNT
         DkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdqD8NRNphouo9P3H8kSDAOVyLnUT6AjcPDXOI9PAiQ=;
        b=qglUT1IWaaiqFhnYymZkeR6/f9SDLbgFMq4+iFEIk6JWsd+I+thaAKsE1XDOIEA3Rd
         Fi/Sd2OJqZFAn8RoORzKiVqwQuzBace2R0qY4zO5CqQAh1NY40SgwaAffkVkLUhSI9SY
         jFbYKoIA+wOaSHyVweDlToF7VEZxpAnC0ZzBoHIo6XpDsfL/wrPKsykXW3pRpCHJpETv
         FjSjaEpy1PfoFLS818gLwJJDbNt5z8ji+I/CiAU77upIW+kKO7aAg/wqA4fAOcvsAywm
         PzvdFr96igODIbqC7wE4xpPilHyeOdIlRifrUjgCgWL+sYxOG5BkrJxjADc92Na/41Gs
         tgYA==
X-Gm-Message-State: APjAAAXdE27Zj/gG9mYrwLJyEviqs2E1qE4A+1Fz2G6AxJPyw3YbqHPw
        SsNZ2Lh8oCMIk2ehp5mlUAQ/Gw==
X-Google-Smtp-Source: APXvYqxYrG4IWc5BNa9rUaA7OJZ1AJ0p5PIQfRuXTlRa6Zk9yaCMkVK4RZYw1LGxEK8Z7NmG88+LNw==
X-Received: by 2002:a62:2cc1:: with SMTP id s184mr24788042pfs.111.1578988675810;
        Mon, 13 Jan 2020 23:57:55 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q63sm17349352pfb.149.2020.01.13.23.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:57:55 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 3/5] net: qrtr: Migrate node lookup tree to spinlock
Date:   Mon, 13 Jan 2020 23:57:01 -0800
Message-Id: <20200114075703.2145718-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200114075703.2145718-1-bjorn.andersson@linaro.org>
References: <20200114075703.2145718-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move operations on the qrtr_nodes radix tree under a separate spinlock
and make the qrtr_nodes tree GFP_ATOMIC, to allow operation from atomic
context in a subsequent patch.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- None

 net/qrtr/qrtr.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 304d536c7353..52816d44fb26 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -8,6 +8,7 @@
 #include <linux/qrtr.h>
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
 #include <linux/numa.h>
+#include <linux/spinlock.h>
 #include <linux/wait.h>
 
 #include <net/sock.h>
@@ -98,10 +99,11 @@ static inline struct qrtr_sock *qrtr_sk(struct sock *sk)
 static unsigned int qrtr_local_nid = NUMA_NO_NODE;
 
 /* for node ids */
-static RADIX_TREE(qrtr_nodes, GFP_KERNEL);
+static RADIX_TREE(qrtr_nodes, GFP_ATOMIC);
+static DEFINE_SPINLOCK(qrtr_nodes_lock);
 /* broadcast list */
 static LIST_HEAD(qrtr_all_nodes);
-/* lock for qrtr_nodes, qrtr_all_nodes and node reference */
+/* lock for qrtr_all_nodes and node reference */
 static DEFINE_MUTEX(qrtr_node_lock);
 
 /* local port allocation management */
@@ -165,10 +167,13 @@ static void __qrtr_node_release(struct kref *kref)
 {
 	struct qrtr_node *node = container_of(kref, struct qrtr_node, ref);
 	struct radix_tree_iter iter;
+	unsigned long flags;
 	void __rcu **slot;
 
+	spin_lock_irqsave(&qrtr_nodes_lock, flags);
 	if (node->nid != QRTR_EP_NID_AUTO)
 		radix_tree_delete(&qrtr_nodes, node->nid);
+	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
@@ -376,11 +381,12 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 static struct qrtr_node *qrtr_node_lookup(unsigned int nid)
 {
 	struct qrtr_node *node;
+	unsigned long flags;
 
-	mutex_lock(&qrtr_node_lock);
+	spin_lock_irqsave(&qrtr_nodes_lock, flags);
 	node = radix_tree_lookup(&qrtr_nodes, nid);
 	node = qrtr_node_acquire(node);
-	mutex_unlock(&qrtr_node_lock);
+	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 
 	return node;
 }
@@ -392,13 +398,15 @@ static struct qrtr_node *qrtr_node_lookup(unsigned int nid)
  */
 static void qrtr_node_assign(struct qrtr_node *node, unsigned int nid)
 {
+	unsigned long flags;
+
 	if (node->nid != QRTR_EP_NID_AUTO || nid == QRTR_EP_NID_AUTO)
 		return;
 
-	mutex_lock(&qrtr_node_lock);
+	spin_lock_irqsave(&qrtr_nodes_lock, flags);
 	radix_tree_insert(&qrtr_nodes, nid, node);
 	node->nid = nid;
-	mutex_unlock(&qrtr_node_lock);
+	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 }
 
 /**
-- 
2.24.0

