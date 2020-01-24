Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8695C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A098D20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859619;
	bh=uQsHbokG9BAyFdZ45JbpzzPjVNWppD8Y4j3LNN/mQNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oOWfmUyCbR2+LOF5nKXMB4fDvY0yper6fG0TMt9NMNWY7NSy/AVuhWcfKaZRedxuf
	 /FduVWI73lqFmGsF2Ir/aydOiM2kpOTTuc/5BlUuc6knUBaJpU7u19BCxD6mwfzVBB
	 z9fUETMVXdI4FE/cIiVHzbAzPA7W/jqXj+jMyb1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbgAXJxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:53:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388084AbgAXJxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:53:37 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9C820709;
        Fri, 24 Jan 2020 09:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859616;
        bh=uQsHbokG9BAyFdZ45JbpzzPjVNWppD8Y4j3LNN/mQNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/B0lULYl1H/uNAIwpk8XTcQo5s7DPpD4f5sN1LbyCQo2cR4NNLx5Yrmt6EZHePgj
         3jS6doSA4BlWAEm+LvjGThpbTMez3EmyZmR1TJUqkggV+QroyPFi1BUIrKrI2Riq4w
         G2DOCw4egdHZk0ExAjm8nrQBndaOYp0wZpDQGtcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 134/343] NFSv4/flexfiles: Fix invalid deref in FF_LAYOUT_DEVID_NODE()
Date:   Fri, 24 Jan 2020 10:29:12 +0100
Message-Id: <20200124092937.606700724@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 108bb4afd351d65826648a47f11fa3104e250d9b ]

If the attempt to instantiate the mirror's layout DS pointer failed,
then that pointer may hold a value of type ERR_PTR(), so we need
to check that before we dereference it.

Fixes: 65990d1afbd2d ("pNFS/flexfiles: Fix a deadlock on LAYOUTGET")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.h | 32 +++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index d6515f1584f3c..d78ec99b6c4ca 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -131,16 +131,6 @@ FF_LAYOUT_LSEG(struct pnfs_layout_segment *lseg)
 			    generic_hdr);
 }
 
-static inline struct nfs4_deviceid_node *
-FF_LAYOUT_DEVID_NODE(struct pnfs_layout_segment *lseg, u32 idx)
-{
-	if (idx >= FF_LAYOUT_LSEG(lseg)->mirror_array_cnt ||
-	    FF_LAYOUT_LSEG(lseg)->mirror_array[idx] == NULL ||
-	    FF_LAYOUT_LSEG(lseg)->mirror_array[idx]->mirror_ds == NULL)
-		return NULL;
-	return &FF_LAYOUT_LSEG(lseg)->mirror_array[idx]->mirror_ds->id_node;
-}
-
 static inline struct nfs4_ff_layout_ds *
 FF_LAYOUT_MIRROR_DS(struct nfs4_deviceid_node *node)
 {
@@ -150,9 +140,25 @@ FF_LAYOUT_MIRROR_DS(struct nfs4_deviceid_node *node)
 static inline struct nfs4_ff_layout_mirror *
 FF_LAYOUT_COMP(struct pnfs_layout_segment *lseg, u32 idx)
 {
-	if (idx >= FF_LAYOUT_LSEG(lseg)->mirror_array_cnt)
-		return NULL;
-	return FF_LAYOUT_LSEG(lseg)->mirror_array[idx];
+	struct nfs4_ff_layout_segment *fls = FF_LAYOUT_LSEG(lseg);
+
+	if (idx < fls->mirror_array_cnt)
+		return fls->mirror_array[idx];
+	return NULL;
+}
+
+static inline struct nfs4_deviceid_node *
+FF_LAYOUT_DEVID_NODE(struct pnfs_layout_segment *lseg, u32 idx)
+{
+	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, idx);
+
+	if (mirror != NULL) {
+		struct nfs4_ff_layout_ds *mirror_ds = mirror->mirror_ds;
+
+		if (!IS_ERR_OR_NULL(mirror_ds))
+			return &mirror_ds->id_node;
+	}
+	return NULL;
 }
 
 static inline u32
-- 
2.20.1



