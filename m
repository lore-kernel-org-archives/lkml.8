Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7992DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F7520674
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460365;
	bh=ri5SmGQSGMCiKlt3DW7hiKmA2kvneVt3pqjs+bNhvL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvhaQHKSgO700gKhBCvwfLdcLIESNdcyGhKAOC6T1DImdmygJYQ/AbmkDlowZURvK
	 h5nO8NFwLeO7vJmyl2ZhmR9mIxN76Xb4ezs4+DlnWamzTgSBghSjNyKX7LhphtCdwF
	 GrULP2U1bCjzx7JKiZdCODzdbZNapZBwXpPeDK0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgF2Twn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387701AbgF2Tk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D892488E;
        Mon, 29 Jun 2020 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444390;
        bh=ri5SmGQSGMCiKlt3DW7hiKmA2kvneVt3pqjs+bNhvL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AoRJcVsTx9JIEoUwdjsvSIAq0KXy8e71oDvDkyEA54q+x9z7MRl/2qt3UfOYJM5JU
         QIzzAoI5IApG4Lpud506NGAQR+XUR+UGjFa/NcasS3ECViKnjOeYNb2JJmaGx/hXYe
         JY0T30DoGF3gh1hBkoXYTyomKtFxcwzoVX5gnOKM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 067/178] efi/esrt: Fix reference count leak in esre_create_sysfs_entry.
Date:   Mon, 29 Jun 2020 11:23:32 -0400
Message-Id: <20200629152523.2494198-68-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 4ddf4739be6e375116c375f0a68bf3893ffcee21 ]

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 0bb549052d33 ("efi: Add esrt support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Link: https://lore.kernel.org/r/20200528183804.4497-1-wu000273@umn.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/esrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index d6dd5f503fa23..e8f71a50ba896 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -181,7 +181,7 @@ static int esre_create_sysfs_entry(void *esre, int entry_num)
 		rc = kobject_init_and_add(&entry->kobj, &esre1_ktype, NULL,
 					  "entry%d", entry_num);
 		if (rc) {
-			kfree(entry);
+			kobject_put(&entry->kobj);
 			return rc;
 		}
 	}
-- 
2.25.1

