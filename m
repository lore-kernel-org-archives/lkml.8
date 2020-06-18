Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B845BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FCA20897
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445358;
	bh=7UP8d+aNwH4B+abjTH5Mp+3kA+gA4M7eqyVYX0XBBlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EAxiQXBgU8fM5ld1k34cuel6HdE2BL1cmzbgR4sHNUulxPHqPbMVfJLS5ShPrY9MU
	 PeEuC3PwwBUygZovqYiuGBAQOgTstZgfuccteWpzMxETR8H+OwDwWtpZFJAC+NlK3T
	 DAA6hsCYZSzNLecS720sIHTj2/0XUJfY57z5rSr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbgFRBz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbgFRBZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:25:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506A12088E;
        Thu, 18 Jun 2020 01:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443537;
        bh=7UP8d+aNwH4B+abjTH5Mp+3kA+gA4M7eqyVYX0XBBlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ukjd0vt7TsbqRSonc+0GFz+SLdl9Y4pPCAT/+9a27sKTTndzsvuI0stjflPvv7zsy
         lJNPGb0da4h1vK8rLEflZgNO5Sh2NERRL2Z5fJIC3W2AnvDyi71kvp7bajBgdfQY2u
         d96u7cYL/dmmAv/7EFSj8dlMHaEeXegeRyed/U2I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>,
        linux-ntb@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 155/172] NTB: ntb_tool: reading the link file should not end in a NULL byte
Date:   Wed, 17 Jun 2020 21:22:01 -0400
Message-Id: <20200618012218.607130-155-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit 912e12813dd03c602e4922fc34709ec4d4380cf0 ]

When running ntb_test this warning is issued:

./ntb_test.sh: line 200: warning: command substitution: ignored null
byte in input

This is caused by the kernel returning one more byte than is necessary
when reading the link file.

Reduce the number of bytes read back to 2 as it was before the
commit that regressed this.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <allenbh@gmail.com>
Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/test/ntb_tool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 025747c1568e..311d6ab8d016 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -504,7 +504,7 @@ static ssize_t tool_peer_link_read(struct file *filep, char __user *ubuf,
 	buf[1] = '\n';
 	buf[2] = '\0';
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, 3);
+	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
 }
 
 static TOOL_FOPS_RDWR(tool_peer_link_fops,
@@ -1690,4 +1690,3 @@ static void __exit tool_exit(void)
 	debugfs_remove_recursive(tool_dbgfs_topdir);
 }
 module_exit(tool_exit);
-
-- 
2.25.1

