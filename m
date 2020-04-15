Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6A1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D08206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586950841;
	bh=nSl82cjhWjTA2l0ExvViT8VlR3vIJzSYqkYo4UEfc7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1pJ4plO3FuvJIIY/Ov99u4BdRFTC6Ro4R4/93hHCAvhqi+p19VYOm+wfMi0Y565KW
	 Q0vRHfEMa+bYucCZvi84l08vnCMTOp296JTkwmN6xpCms3RFv5krzTK+HiTg1h3Akz
	 zEcX9y1ICVF+u0WWwFywAjvbEDcIxpBOn6I//xWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897362AbgDOLke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408893AbgDOLfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9006B20737;
        Wed, 15 Apr 2020 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950550;
        bh=nSl82cjhWjTA2l0ExvViT8VlR3vIJzSYqkYo4UEfc7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYA+w9keah0mVOldlZDFaQUHhTqPrw9o4qcpomBXibVkzAYCY4LP5xIFPx9q+F2iQ
         TOSqTk63sE8mjc0pkCi+MbIw1oWf2zBzT5uoMp4c8ZdTyRIdc0dpTpbsWaZORG0Phh
         WSKlO2+PjIR4s64CIr6amGNt9lF/gCxlA6tgdlAc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liwei Song <liwei.song@windriver.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 056/129] nfsroot: set tcp as the default transport protocol
Date:   Wed, 15 Apr 2020 07:33:31 -0400
Message-Id: <20200415113445.11881-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liwei Song <liwei.song@windriver.com>

[ Upstream commit 89c8023fd46167a41246a56b31d1b3c9a20b6970 ]

UDP is disabled by default in commit b24ee6c64ca7 ("NFS: allow
deprecation of NFS UDP protocol"), but the default mount options
is still udp, change it to tcp to avoid the "Unsupported transport
protocol udp" error if no protocol is specified when mount nfs.

Fixes: b24ee6c64ca7 ("NFS: allow deprecation of NFS UDP protocol")
Signed-off-by: Liwei Song <liwei.song@windriver.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfsroot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index effaa4247b912..8d32788056022 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -88,7 +88,7 @@
 #define NFS_ROOT		"/tftpboot/%s"
 
 /* Default NFSROOT mount options. */
-#define NFS_DEF_OPTIONS		"vers=2,udp,rsize=4096,wsize=4096"
+#define NFS_DEF_OPTIONS		"vers=2,tcp,rsize=4096,wsize=4096"
 
 /* Parameters passed from the kernel command line */
 static char nfs_root_parms[NFS_MAXPATHLEN + 1] __initdata = "";
-- 
2.20.1

