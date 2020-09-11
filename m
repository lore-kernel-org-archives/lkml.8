Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2292EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B98221E8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7fToiYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgIKEou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIKEot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 00:44:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5F9C061573;
        Thu, 10 Sep 2020 21:44:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s65so4668754pgb.0;
        Thu, 10 Sep 2020 21:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWm/S620WXgqZ5OlNqBLrJgrguVAGDJTsBuFCVlofDA=;
        b=P7fToiYefyYMYr2wEI7bvLu/7Dj1aOdaq5zyCD96sqIsFaNjAlBokgzh0pmhkhpXCv
         m1Xjuca4vsr5NKr3rb3TMRrusUAOZKRHopYEipcg4aWy+nNwEdn0ZV3SjaTBk7z5FkZD
         EUaMitJUN2yOZvPCR1kM0dSiZ78j8OFTeo7EG/9ddwwnL429r3gohN0qSb1YKI85x226
         XrUZMz96+6cv5CMh4fzGF0PWZ8xQr8i+lQbftZO2I+zt6Q909oR2qu/K6EIlIB0ctmXa
         LkqN5E7eq0/LBpgEfwzVZkIMu7g5ru+6LjT7FD6G7DePHPc2pnYNhPzKtjry/1Ej/Oo1
         NOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWm/S620WXgqZ5OlNqBLrJgrguVAGDJTsBuFCVlofDA=;
        b=mgv8Fkcy9PyTVDXLdY/ByqmG1Zpc/o0xYaK2NWqjo0VRLQnV6sh2bDqCsxLBQ1bsbt
         8LFNNiiwiTdYW8IfStAokrciK76Op8Py2QsIzMv0RISwPT/qas4o97iVGisQ8xxp3Pda
         USE8t3PG74YLiVwAfEFd87gTlS2epr6NhJLgpQ1OXkdnAq18sxgEmNPRvG2k1Qg64s2D
         OFI3uD/WxYFGcmF7Iz3aBzV7H7VhIy1ZP/BD+Q4581gWuHD/tqphnsTKiiZ6VW0KxPcM
         IcvvSD809I/PKa/UR7WKSeyP4Gk2GOyk6aD+uCCTnsIe3ISXCrIsWMm/JtjKzl/czprA
         F5SQ==
X-Gm-Message-State: AOAM531A+XgRYnrioyQ8uISVFbZWunlPnXMGi9mx8bEviwV86EwhBfi1
        sSaHEWSOMa8XMRYnI2ijbxQ=
X-Google-Smtp-Source: ABdhPJwuMu8YaSDV6HeMSDu1k8le5fQ7WGWNcwr2m64v8GzyWCvq2VgJnCP8Y5Vmjgw2wnWl7G/A9w==
X-Received: by 2002:a65:408b:: with SMTP id t11mr345723pgp.199.1599799486692;
        Thu, 10 Sep 2020 21:44:46 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-191-163.hyg.mesh.ad.jp. [111.169.191.163])
        by smtp.gmail.com with ESMTPSA id y4sm546575pgl.67.2020.09.10.21.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 21:44:46 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] exfat: remove useless directory scan in exfat_add_entry()
Date:   Fri, 11 Sep 2020 13:44:39 +0900
Message-Id: <20200911044439.13842-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing in directory just created, so there is no need to scan.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/namei.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index b966b9120c9c..803748946ddb 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -530,19 +530,10 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 		info->size = 0;
 		info->num_subdirs = 0;
 	} else {
-		int count;
-		struct exfat_chain cdir;
-
 		info->attr = ATTR_SUBDIR;
 		info->start_clu = start_clu;
 		info->size = clu_size;
-
-		exfat_chain_set(&cdir, info->start_clu,
-			EXFAT_B_TO_CLU(info->size, sbi), info->flags);
-		count = exfat_count_dir_entries(sb, &cdir);
-		if (count < 0)
-			return -EIO;
-		info->num_subdirs = count + EXFAT_MIN_SUBDIR;
+		info->num_subdirs = EXFAT_MIN_SUBDIR;
 	}
 	memset(&info->crtime, 0, sizeof(info->crtime));
 	memset(&info->mtime, 0, sizeof(info->mtime));
-- 
2.25.1

