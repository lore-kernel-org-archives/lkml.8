Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3813CC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 15:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EFB20706
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 15:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKq4LAxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHWPVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 11:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgHWPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 11:21:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25909C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 08:21:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f193so3487242pfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Len0YLjL+1HYVWLhCeiF5ALGuM9sVBgacotYzHDBck=;
        b=CKq4LAxuP4oo+spy/Sjtq2HUumog5bo0IHYmqEpjVCxC6JkHFtCwsCBMkudgSOlZgC
         gtoP46ectLgIOopfzu1t32vOnOYo2swQ0Gt8Ct6SkmJ6YfA3hAkKFhOHJISdD0MtvFkv
         o0HTvXT8d/AGRstup6rRL3A+b3jlv8TV6sGp4TQr7XsmWQE+DW3Otgc7RhGrFpyfhgw1
         Obm4jpuWpZxrNb+f4VPnww0sjbFmv2PNqphHnmVvZqhqA8/2vM1dAgxGYiJIaLd3uFV/
         cXRHl1A1LvY73Sq0aGMS2xPHvBmBTI/vWu4m9Si+F4+VuNZk5jBMYu9z+o3S5ijfnWkB
         82wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Len0YLjL+1HYVWLhCeiF5ALGuM9sVBgacotYzHDBck=;
        b=dCqV3rh3egYokir4J7lZ55g9U+rGVl846BL2nrmp6Thi0U5eg4fQ8z91Ej272hkU5x
         Rs7EI/5+UK2+sbeo2RvCJk5BORCL3Ik5t3QPyi+SnNeQEDIyFrQ80DoztYGzz/E8DCVo
         MqcEh8fM1wdhv7aRntut78dpSwcPsXh+6IximzDbPc3C0Kq00OVTJMiRyyCDgdKSA0bN
         4H6CsZkrs0LNnNzgjDy7qSNakjOGkIcmjS22g39YlFDfgaYx/BUTnhBI7r6JqYXG+don
         J52PCQ1E6We87ALSb1Ysy/7dIbP1OV51k8a9vLDFg2H14wX9UurCrFwbs6jOu7skM65T
         A8ew==
X-Gm-Message-State: AOAM533k3S2M7pM60ZGnBTQUQ3gazMTYwJpwyfsOv/DTZV13hJ4U9Pgv
        4Ewb5WN235YbVeW5UPfPyCBGimzX+MqSpA==
X-Google-Smtp-Source: ABdhPJynFN6QXBqe/BQZ1PIMKOJQW64sDPaA+7Mon0obiv343TtEITd8Tte5Kxo4hI1j3vshd7m0zg==
X-Received: by 2002:aa7:8b01:: with SMTP id f1mr1224840pfd.35.1598196101834;
        Sun, 23 Aug 2020 08:21:41 -0700 (PDT)
Received: from thinkpad.teksavvy.com (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id g129sm8457637pfb.33.2020.08.23.08.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 08:21:41 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] ntfs: add check for mft record size in superblock
Date:   Sun, 23 Aug 2020 08:21:47 -0700
Message-Id: <20200823152147.55766-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

number of bytes allocated for mft record should be equal to the mft
record size stored in ntfs superblock
as reported by syzbot, userspace might trigger out-of-bounds read by
dereferencing ctx->attr in ntfs_attr_find()

Reported-and-tested-by: syzbot+aed06913f36eff9b544e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=aed06913f36eff9b544e
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 fs/ntfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 9bb9f0952b18..6407af7c2e4f 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1810,6 +1810,12 @@ int ntfs_read_inode_mount(struct inode *vi)
 		brelse(bh);
 	}
 
+	if (m->bytes_allocated != vol->mft_record_size) {
+		ntfs_error(sb, "Incorrect mft record size [%u] in superblock, should be [%u].",
+				m->bytes_allocated, vol->mft_record_size);
+		goto err_out;
+	}
+
 	/* Apply the mst fixups. */
 	if (post_read_mst_fixup((NTFS_RECORD*)m, vol->mft_record_size)) {
 		/* FIXME: Try to use the $MFTMirr now. */
-- 
2.28.0

