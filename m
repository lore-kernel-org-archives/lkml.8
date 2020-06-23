Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B9820675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944844;
	bh=hG/hd2J4dHLGSRu02sYKuZfaGjpfA6fauxrCVBm5Y5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bVih4gBb7RjNM4aPZmilaIOwfcydLshvZMpeOgMwHKOTE0XAeS6aqaSbTf+sLVYAN
	 zFtGlFVc3ckDNNzpbQ4vIcbPVtCartDqCTvL/7bEMF8jLJ+GypsgJH/G+w59jkAtKs
	 0dGP+c4Y9vgDTUrG1MTHwkQYRHRZEUGT/QQhAfFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392273AbgFWUkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392248AbgFWUkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:40:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB8DE2053B;
        Tue, 23 Jun 2020 20:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944837;
        bh=hG/hd2J4dHLGSRu02sYKuZfaGjpfA6fauxrCVBm5Y5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oi3h1OrqkEa0BBw2JU7sdkxafPJkMqEKyU0A+fxTNsl7k1wxAohiXIKL+3bbmMm5m
         wr4Xxat0iLmtY/mk/EtMpixaZPUKspoIMtrxLRgLHRYfuiJfQDjK7MgT/7aG2WR2Yn
         PbIpFOQgz9tA6PkJENa5S637g0R47NtcvYnGcXJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 145/206] NTB: ntb_tool: reading the link file should not end in a NULL byte
Date:   Tue, 23 Jun 2020 21:57:53 +0200
Message-Id: <20200623195324.111692731@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 025747c1568ea..311d6ab8d0160 100644
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



