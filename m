Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2DC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9F8206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbgCLHv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:51:26 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:59216 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbgCLHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:51:26 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 03:51:24 EDT
Received: from lcc-VirtualBox.vivo.xyz (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 972EE261CC1;
        Thu, 12 Mar 2020 15:40:50 +0800 (CST)
From:   Chucheng Luo <luochucheng@vivo.com>
To:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wenhu.wang@vivo.com, trivial@kernel.org,
        Chucheng Luo <luochucheng@vivo.com>
Subject: [PATCH] fs: Fix missing 'bit' in comment
Date:   Thu, 12 Mar 2020 15:40:37 +0800
Message-Id: <20200312074037.25829-1-luochucheng@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVCTEhCQkJCTExKSkpDSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6Exw*Izg1MDJRDS41HSMf
        STFPCi1VSlVKTkNIQkJDQ05LQkxNVTMWGhIXVRcOFBgTDhgTHhUcOw0SDRRVGBQWRVlXWRILWUFZ
        TkNVSU5KVUxPVUlJTFlXWQgBWUFKTkhLNwY+
X-HM-Tid: 0a70cdb057389375kuws972ee261cc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The missing word may make it hard for other developers to
understand it.

Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
---
 fs/vboxsf/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index dd147b490982..be4f72625d36 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -134,7 +134,7 @@ static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
 		d_type = vboxsf_get_d_type(info->info.attr.mode);
 
 		/*
-		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
+		 * On 32 bit systems pos is 64 bit signed, while ino is 32 bit
 		 * unsigned so fake_ino may overflow, check for this.
 		 */
 		if ((ino_t)(ctx->pos + 1) != (u64)(ctx->pos + 1)) {
-- 
2.17.1

