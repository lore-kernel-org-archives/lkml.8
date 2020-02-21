Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E07C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936FE24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272691;
	bh=z9lZsmTV7165P7cffCuoQ2Igv1tMoJpZxY/bd3jhAiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DjmKlzPdUaJPN6qVD7dPy6DRHFZrIQ/5ksnF3Q8X36W7tkCpH2AzESEy1Yo9A0mbn
	 8ASr7O5HH9fw8Mn9hGwouVa/bJrYcnGz+ngxMuIQ06UYQPOxXlQyLZAJdoVMNyfQuz
	 iFx3bb339FiqcEU2RQKAxb4gh8HV0krpWR9ksy3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbgBUILa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731756AbgBUILZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:11:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A701C20578;
        Fri, 21 Feb 2020 08:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272685;
        bh=z9lZsmTV7165P7cffCuoQ2Igv1tMoJpZxY/bd3jhAiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aip4s1HDByiFbfFkihe+SUocGr9DSvJJ+io359DcnIsKC7Ekeiwz4iL3vtaTLWGT/
         n+Fm5S3ro7UZ0v6oRyHH12VPemIDbSYhSSjhHq5/YDAzYNQG2239DoEeL84g8NhToh
         P32S2QPUcZu9co8bOvN71DT6wOwpiY3tL+8blwVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 237/344] f2fs: free sysfs kobject
Date:   Fri, 21 Feb 2020 08:40:36 +0100
Message-Id: <20200221072410.848453998@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 820d366736c949ffe698d3b3fe1266a91da1766d ]

Detected kmemleak.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index b558b64a4c9ca..8544c0ab7b32b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -782,4 +782,5 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
 }
-- 
2.20.1



