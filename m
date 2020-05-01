Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C302FC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CB724958
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588347527;
	bh=yq71fZecRFuBE9pJTufX7whCpOlACPLvJF4nfyHNyI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aPrJS71VS0qGpeFmiYOzJIyVQ1nj/hzYEKySPNJlHQ5IAIDjrUSCIdvWjA067Hqg6
	 7vasHA2rABIOt1ogCtWZ7Ex9Woh3xOVdODkNOJGupMArsIFOORvFiS5aZ6pyFEZXV3
	 4kWTPVa27Yw9IaTjsKIiEXrUI0LhJtmrYjPLbrKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgEAPiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbgEAPiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1601424965;
        Fri,  1 May 2020 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=yq71fZecRFuBE9pJTufX7whCpOlACPLvJF4nfyHNyI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTa9EunYvRlUJSyIwE9HfhS8C+Cdr9eRbE85TGd2h0Ft6l2dBRP+bE/amdq/BeA2M
         ywyWiKM9Qg+lJsUbDyoyZ77ByyxABCjv1n/H32yyWjEvRZMXFnMGwKnfLLTGFJolPU
         8EANNlm5i6gvYg8GRosO/b5xjWAX44b6OLKIwB24=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE5N-AM; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 14/14] docs: staging: use small font for literal includes
Date:   Fri,  1 May 2020 17:37:58 +0200
Message-Id: <f0dd118559a49c1a8c1e248382f48d5a07c0751d.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The normal font is too big to display 80 columns, causing extra
breaks to be added at weird places.

change to the footnotesize, as this would fit a little bit
better.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/staging/index.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index 8cc9d94b0a13..184e6aece0a7 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -19,17 +19,41 @@ Unsorted Documentation
 Atomic Types
 ============
 
+.. raw:: latex
+
+    \footnotesize
+
 .. include:: ../atomic_t.txt
    :literal:
 
+.. raw:: latex
+
+    \normalsize
+
 Atomic bitops
 =============
 
+.. raw:: latex
+
+    \footnotesize
+
 .. include:: ../atomic_bitops.txt
    :literal:
 
+.. raw:: latex
+
+    \normalsize
+
 Memory Barriers
 ===============
 
+.. raw:: latex
+
+    \footnotesize
+
 .. include:: ../memory-barriers.txt
    :literal:
+
+.. raw:: latex
+
+    \normalsize
-- 
2.25.4

