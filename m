Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3D2C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6082082E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581253010;
	bh=GRNlCphWpXIvtZiNgAuJlAdnF1u0WDJDK9iyYMOqCT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KM7ML9dD/WXANCJMeBg4H1oN7Irlh+a0ILsstiFwRtg9c/HQKD+wdLjvu/tJ39XCo
	 LWMi8Ye9WoaguSgbZ14/+BU9L9ITrkuoG+H/WIJ7sNqTXn5ak+oGUpBUBmbeC3YaNp
	 SQDDX2yernlZTJjxByITrPjW4dz1rVyT1Qbqoy84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBIM4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:56:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbgBIM4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 07:56:48 -0500
Received: from localhost (unknown [38.98.37.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EAFC20733;
        Sun,  9 Feb 2020 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581253008;
        bh=GRNlCphWpXIvtZiNgAuJlAdnF1u0WDJDK9iyYMOqCT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQ6J44OaGNVpV9mF3MLMe0ePvDSGT/CMsNyBCqvcryzIYIuOeCqvidQWLcDBg7ezw
         N0Hc1LMUzAFCX2QUS4zuOzzB1R/5AEnVHARcL2q0n4yRngttPTcb7g5+xt9fEv6D5Y
         5f8eJpss/k4xgHtAaTTHpLafATKmhnohqDA+Bdfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5/6] powerpc: cell: axon_msi: no need to check return value of debugfs_create functions
Date:   Sun,  9 Feb 2020 11:59:00 +0100
Message-Id: <20200209105901.1620958-5-gregkh@linuxfoundation.org>
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

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/cell/axon_msi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 57c4e0e86c88..ca2555b8a0c2 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -480,10 +480,6 @@ void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
 
 	snprintf(name, sizeof(name), "msic_%d", of_node_to_nid(dn));
 
-	if (!debugfs_create_file(name, 0600, powerpc_debugfs_root,
-				 msic, &fops_msic)) {
-		pr_devel("axon_msi: debugfs_create_file failed!\n");
-		return;
-	}
+	debugfs_create_file(name, 0600, powerpc_debugfs_root, msic, &fops_msic);
 }
 #endif /* DEBUG */
-- 
2.25.0

