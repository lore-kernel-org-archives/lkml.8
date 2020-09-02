Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A27C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E610207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599036941;
	bh=KSfDn1rAofDp+IGlsS+1QKVw8oVSBvy/kgB52AVCOfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MuTrDoFLoLyTiU9sWhikvkx8C4EQZEpMaiErq7TIvyMISUmi56sxZNdRVuLMVM8rp
	 Xvzt03ocxvn6cPZO5SD19Feu7SszEQrFu+iBb01gENqWH1Ssh4YRhkljRvnca/POmS
	 MZJu+oRpZ0u8Qp+7u3GdV8liuYy1l2Ms4AWinvLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBIzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgIBIzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:55:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B422078B;
        Wed,  2 Sep 2020 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599036933;
        bh=KSfDn1rAofDp+IGlsS+1QKVw8oVSBvy/kgB52AVCOfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tP7I3x75qYFGfPcjUGPHKxG0VFwywevHXRUFfZDfrXdM4G6ADRucJNsc6Y4NgJtB1
         pBqOJ8J7Bd9dBiPDRE53g+mlQuUusiVISC0BY+AETsIHspdVKPc+dp4ydGT7vR6fQt
         yAauxh1P7WYbdjPa8hUceQuedAadbsjafGM9gy84=
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH rdma-next 2/4] gcov: Use proper duplication routine for const pointer
Date:   Wed,  2 Sep 2020 11:55:11 +0300
Message-Id: <20200902085513.748149-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902085513.748149-1-leon@kernel.org>
References: <20200902085513.748149-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The filename is a const pointer, so use the proper string duplication
routine that takes into account const identifier.

Cc: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/gcov/gcc_4_7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 6d706c5eed5c..318211deb903 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -283,7 +283,7 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
 		dup->merge[fi_idx] = info->merge[fi_idx];
 	dup->n_functions = info->n_functions;

-	dup->filename = kstrdup(info->filename, GFP_KERNEL);
+	dup->filename = kstrdup_const(info->filename, GFP_KERNEL);
 	if (!dup->filename)
 		goto err_free;

@@ -359,7 +359,7 @@ void gcov_info_free(struct gcov_info *info)

 free_info:
 	kfree(info->functions);
-	kfree(info->filename);
+	kfree_const(info->filename);
 	kfree(info);
 }

--
2.26.2

