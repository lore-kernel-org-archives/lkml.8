Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC333C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840A2206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948442;
	bh=chibOaOC+8zwPMo1Dx/NxO88sknBaY7+ztfAMhFuOq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HhJ62Y+QcHGOA0u8qhChmpUjg+4g8Quu+uy4Ww8OaMrgM4AkrF4MSTVGP4aBJkq1D
	 ZqrFUQv3SjqdTaE+JT1SW9n6pTE5Ojg3K6pXEt1dtWZGze7QkGZeqReRmLzTz750Es
	 oJIsOmswCvOjnrkPvfIQ13vjUXB01cHvyC0sFS5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393971AbgFWVkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388496AbgFWUGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:06:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C0482078A;
        Tue, 23 Jun 2020 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942801;
        bh=chibOaOC+8zwPMo1Dx/NxO88sknBaY7+ztfAMhFuOq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y+mrGIlhVkhiTupxh1TLtatRNqVMhm28oyoaB5d8tp6of77/Nauh/wl5Z7o0FgQWD
         MnFWWdOWDD9AaeBtdVmFaJflq1s4C2M1k7VvRslZWemo1IGOD46zHHaEj5waruBNmg
         aQdlXt1RAnrloXOLnhUmgtNdLIHTp4xmigRjy5Tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 100/477] f2fs: handle readonly filesystem in f2fs_ioc_shutdown()
Date:   Tue, 23 Jun 2020 21:51:37 +0200
Message-Id: <20200623195412.324267457@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 8626441f05dc45a2f4693ee6863d02456ce39e60 ]

If mountpoint is readonly, we should allow shutdowning filesystem
successfully, this fixes issue found by generic/599 testcase of
xfstest.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6ab8f621a3c5a..30b35915fa3a3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2219,8 +2219,15 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	if (in != F2FS_GOING_DOWN_FULLSYNC) {
 		ret = mnt_want_write_file(filp);
-		if (ret)
+		if (ret) {
+			if (ret == -EROFS) {
+				ret = 0;
+				f2fs_stop_checkpoint(sbi, false);
+				set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
+				trace_f2fs_shutdown(sbi, in, ret);
+			}
 			return ret;
+		}
 	}
 
 	switch (in) {
-- 
2.25.1



