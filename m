Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D395AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA27F206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCMB4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:56:01 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:27839 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgCMB4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:56:01 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 21:55:59 EDT
Received: from lcc-VirtualBox.vivo.xyz (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 22393261536;
        Fri, 13 Mar 2020 09:47:04 +0800 (CST)
From:   Chucheng Luo <luochucheng@vivo.com>
To:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wenhu.wang@vivo.com, trivial@kernel.org,
        Chucheng Luo <luochucheng@vivo.com>
Subject: [PATCH] fs: Fix missing 'bit' in comment
Date:   Fri, 13 Mar 2020 09:46:55 +0800
Message-Id: <20200313014655.28967-1-luochucheng@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVISk9LS0tKSUJNQkJMSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCo6Qyo*NTgwKDETCxQtCRwN
        FDdPFBhVSlVKTkNPS01PS0lPT0NJVTMWGhIXVRcOFBgTDhgTHhUcOw0SDRRVGBQWRVlXWRILWUFZ
        TkNVSU5KVUxPVUlJTVlXWQgBWUFKTkhLNwY+
X-HM-Tid: 0a70d192cf389375kuws22393261536
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
index dd147b490982..4d569f14a8d8 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -134,7 +134,7 @@ static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
 		d_type = vboxsf_get_d_type(info->info.attr.mode);
 
 		/*
-		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
+		 * On 32-bit systems pos is 64-bit signed, while ino is 32-bit
 		 * unsigned so fake_ino may overflow, check for this.
 		 */
 		if ((ino_t)(ctx->pos + 1) != (u64)(ctx->pos + 1)) {
-- 
2.17.1

