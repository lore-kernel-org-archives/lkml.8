Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC27C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E282080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581252991;
	bh=YD4NidAWtqA6u76URz+1LR9TLwrOmomcGvPe5nlw37Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iLMdKbxCxhfhF2dHZ8NPd6tYZxzXeUYHYKt68JJh4mPHzxERanLsozn793N5lAe1i
	 Id/OSf5mZn8NLTqWTPxpYcCsDARnx1nyH/wfmZBu+jK9fJJfNZ1/vwDTRjYzBWeHew
	 fYfr3CUbbedugyLFXrb+W7MdP4HKEF0weGSUXzok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBIM4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:56:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbgBIM4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 07:56:30 -0500
Received: from localhost (unknown [38.98.37.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78BE20733;
        Sun,  9 Feb 2020 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581252989;
        bh=YD4NidAWtqA6u76URz+1LR9TLwrOmomcGvPe5nlw37Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJjlJPQRwAzSeKC8LXioAXqAYmvVA03v0r//S68By2j4wk/2HfBNErshnE6m3q8Ea
         cc2jbAGQsz80hd6dE1qJz2vysIEiiI4oadPTK9XlaCtlXPlFX1FCLDsfMavYhulXwN
         gvVKvw2WgZERJ19tvIThhy1N2in+BY/Ak3OpZFr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/6] powerpc: mm: book3s64: hash_utils: no need to check return value of debugfs_create functions
Date:   Sun,  9 Feb 2020 11:58:58 +0100
Message-Id: <20200209105901.1620958-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200209105901.1620958-1-gregkh@linuxfoundation.org>
References: <20200209105901.1620958-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 523d4d39d11e..7e5714a69a58 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -2018,11 +2018,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_hpt_order, hpt_order_get, hpt_order_set, "%llu\n")
 
 static int __init hash64_debugfs(void)
 {
-	if (!debugfs_create_file_unsafe("hpt_order", 0600, powerpc_debugfs_root,
-					NULL, &fops_hpt_order)) {
-		pr_err("lpar: unable to create hpt_order debugsfs file\n");
-	}
-
+	debugfs_create_file("hpt_order", 0600, powerpc_debugfs_root, NULL,
+			    &fops_hpt_order);
 	return 0;
 }
 machine_device_initcall(pseries, hash64_debugfs);
-- 
2.25.0

