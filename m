Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDCFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF2524772
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697399;
	bh=yi9QOP/il3GJcu7Kn35kfDf8jWGVv+A/VKq1CrPmysg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LKrWKkzBaDkOoWSsdEQf/spmJ3IWoRd/pUwqP6v1Kn9/jg4x4R3k9C/OSxCsijrTt
	 1G501K/ffQvTsw6FF9BprYsp6UNZiCpY7AvxbJD8BIMkZI5hrvcHXnpLG0zfTCD/UO
	 eFaU5P35qULnOX6pL4f2CLmbLVOr7+8i86mqfdJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405586AbgBNQXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:23:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393095AbgBNQVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73CC246B8;
        Fri, 14 Feb 2020 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697309;
        bh=yi9QOP/il3GJcu7Kn35kfDf8jWGVv+A/VKq1CrPmysg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXKJDCpcMoI0p4PXTrVbzKt2gQEXQgr9teWc+lKc6mRtyLl9gbfgXDDoXVQCOlKPY
         aohQpm0VDM5Tjn7PVYcbDl/kYDhR+ogOIGnjP64xn3wYErjIt0FQdaRTiTVaH3R/Ym
         JhxCoiF/iBmk+1PnjBI1IRiFkLJlkPlZUPb7xXy4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 021/141] nfs: NFS_SWAP should depend on SWAP
Date:   Fri, 14 Feb 2020 11:19:21 -0500
Message-Id: <20200214162122.19794-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 474c4f306eefbb21b67ebd1de802d005c7d7ecdc ]

If CONFIG_SWAP=n, it does not make much sense to offer the user the
option to enable support for swapping over NFS, as that will still fail
at run time:

    # swapon /swap
    swapon: /swap: swapon failed: Function not implemented

Fix this by adding a dependency on CONFIG_SWAP.

Fixes: a564b8f0398636ba ("nfs: enable swap on NFS")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index b1daeafbea920..c3428767332c2 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -89,7 +89,7 @@ config NFS_V4
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
-	depends on NFS_FS
+	depends on NFS_FS && SWAP
 	select SUNRPC_SWAP
 	help
 	  This option enables swapon to work on files located on NFS mounts.
-- 
2.20.1

