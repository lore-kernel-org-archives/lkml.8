Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FB4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694C920663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDXWp0V9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgFGQS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:18:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE134C08C5C3;
        Sun,  7 Jun 2020 09:18:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so7252464pfe.4;
        Sun, 07 Jun 2020 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:to:cc:subject:from:mime-version
         :content-transfer-encoding;
        bh=71YhZNLGhXbmxGNeFEQZl+p8Dpt5MYdooBczOyZ+OjU=;
        b=WDXWp0V9hMZ+1+Pc/Kkpj9DcDd/QARTzErAVYWNdh8fTCm8rJGEAxp2cnn61W4EhVE
         tj2/cz1vfg595gs86XIiY9vvgxDuL7mT6OPDRafcteRX9/o5SryKgyf+OdLmxkr4PIKy
         KFg/NRHRWSxTP7VwdB0MLBsnWioCNnjCfQT5+GtyMeGWWW1+tc20wVK5AYxw7czEBbZK
         QY55GpFT1j3t2Q7uFqWhdrGu/VFVDVwZpxW/stkLy+W7K1RwxGnyaz9KoujLO5mPKLH5
         2A4oNPfnrpAKN5KiSx4vOWvokF5zE5loHEygyZAsJ0NxmkD368/nV5s+UtZ9fSvksY6F
         nyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:to:cc:subject:from:mime-version
         :content-transfer-encoding;
        bh=71YhZNLGhXbmxGNeFEQZl+p8Dpt5MYdooBczOyZ+OjU=;
        b=E5nvoqcyz07ciX++4GZHtBoEYQxzk42KzpVM+sPNenv/6NOPAcdgB3Png8r9x3TCC6
         xQn8j8XhEYxooLuAGGxIXrzAJRsonYyThW1Wr2pQBDOJzgu5jOm4SW/2nbaWqESFd4Bl
         PvBsrcIizIQfq/7MhhFz0+7QyTAHNPKVf1Gw1Ee6U/c98u1gpoWzw5wgJfAczlg+lT9e
         m4SYIAieBxKYzJW1vqWBXWIHx2P/MsrmLlQpBs99yq0uJViuzJDtWDk4EEDjmAfZ/STo
         YFVRikCzaXjvUXh8C6gnqg2nq9bzgQwjLh8gpfY93qkHmlnUW3JD165F1P5Sy6Zez/6i
         Fugw==
X-Gm-Message-State: AOAM532Hg9Rn9oB4zHffjyrg/FmmWoFyKISaHLYKXWfEY/+MdOE3gyyx
        Hk+Ao526sSHtCuEKASDBrzs=
X-Google-Smtp-Source: ABdhPJxATwte1DIqAmpjKKJQlwDcZTgFxciMNIbPIyq6qCWNKXK5TC8z22ifbv+daPAJSuGFqgWHMg==
X-Received: by 2002:a63:7407:: with SMTP id p7mr17712961pgc.268.1591546703980;
        Sun, 07 Jun 2020 09:18:23 -0700 (PDT)
Received: from localhost (i60-35-88-138.s42.a014.ap.plala.or.jp. [60.35.88.138])
        by smtp.gmail.com with ESMTPSA id q36sm5432490pjq.18.2020.06.07.09.18.21
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2020 09:18:22 -0700 (PDT)
Date:   Mon, 08 Jun 2020 01:18:19 +0900 (JST)
Message-Id: <20200608.011819.1399059588922299158.konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH] nilfs2: fix null pointer dereference at
 nilfs_segctor_do_construct()
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
X-Mailer: Mew version 6.6 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit c3aab9a0bd91 ("mm/filemap.c: don't initiate writeback if
mapping has no dirty pages"), the following null pointer dereference
has been reported on nilfs2:

 BUG: kernel NULL pointer dereference, address: 00000000000000a8
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 ...
 RIP: 0010:percpu_counter_add_batch+0xa/0x60
 ...
 Call Trace:
  __test_set_page_writeback+0x2d3/0x330
  nilfs_segctor_do_construct+0x10d3/0x2110 [nilfs2]
  nilfs_segctor_construct+0x168/0x260 [nilfs2]
  nilfs_segctor_thread+0x127/0x3b0 [nilfs2]
  kthread+0xf8/0x130
  ...

This crash turned out to be caused by set_page_writeback() call for
segment summary buffers at nilfs_segctor_prepare_write().

set_page_writeback() can call inc_wb_stat(inode_to_wb(inode),
WB_WRITEBACK) where inode_to_wb(inode) is NULL if the inode of
underlying block device does not have an associated wb.

This fixes the issue by calling inode_attach_wb() in advance to ensure
to associate the bdev inode with its wb.

Reported-by: Walton Hoops <me@waltonhoops.com>
Reported-by: Tomas Hlavaty <tom@logand.com>
Reported-by: ARAI Shun-ichi <hermes@ceres.dti.ne.jp>
Reported-by: Hideki EIRAKU <hdk1983@gmail.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org # v5.4+
---
 fs/nilfs2/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 445eef4..91b58c8 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2780,6 +2780,8 @@ int nilfs_attach_log_writer(struct super_block *sb, struct nilfs_root *root)
 	if (!nilfs->ns_writer)
 		return -ENOMEM;
 
+	inode_attach_wb(nilfs->ns_bdev->bd_inode, NULL);
+
 	err = nilfs_segctor_start_thread(nilfs->ns_writer);
 	if (err) {
 		kfree(nilfs->ns_writer);
-- 
1.8.3.1

