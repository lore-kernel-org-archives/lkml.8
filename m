Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6631AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3672820738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873586;
	bh=jNTNES8TzyLbIlxABgiLo6CoJEf7X3BZZA4/JCXPorU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nC95XfPlS/yeHJfYLd9xQz8jHryLl8y/aX3F2Z4YzJ3HWp3y5jnTACYzpbHVv7FJl
	 fp5W0olcn9KNJTNequv1+19XczI4GmA/LCcn4iIYjuX5Ac1ln4GFBcT5H8YeUJdLru
	 0CFpilIXWMmIocuuiY9bq9xUpkU7KN+JOqUYBXog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgFWAxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732394AbgFWAwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9582920809;
        Tue, 23 Jun 2020 00:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873555;
        bh=jNTNES8TzyLbIlxABgiLo6CoJEf7X3BZZA4/JCXPorU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcTX7l2VAdvdJtTKR9dpFVPyMbyOnqev81s7+9i+utyQVGHvOF7Cv87JWNP+mdvzE
         eC/S4u8fDSEyZNpAVUl59E3gY3tSFEeW12o5NACEWW1fXUZKlIwE7Fkm07bPfdn+L1
         2132hdQO2dN4K8UwMKWZNXXc1+EWjziwzPeaa938=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/14] docs: fix references for DMA*.txt files
Date:   Mon, 22 Jun 2020 17:52:31 -0700
Message-Id: <20200623005231.27712-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As we moved those files to core-api, fix references to point
to their newer locations.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/memory-barriers.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index eaabc31..0e4947a 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -546,8 +546,8 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	[*] For information on bus mastering DMA and coherency please read:
 
 	    Documentation/driver-api/pci/pci.rst
-	    Documentation/DMA-API-HOWTO.txt
-	    Documentation/DMA-API.txt
+	    Documentation/core-api/dma-api-howto.rst
+	    Documentation/core-api/dma-api.rst
 
 
 DATA DEPENDENCY BARRIERS (HISTORICAL)
@@ -1932,7 +1932,7 @@ There are some more advanced barrier functions:
      here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
-     relaxed I/O accessors and the Documentation/DMA-API.txt file for more
+     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for more
      information on consistent memory.
 
 
-- 
2.9.5

