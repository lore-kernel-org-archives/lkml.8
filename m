Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC75C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA352053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSjpp+w4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgHOWC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgHOVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00833C0F26E0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so10521161wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=WLYTnHUA0a2ryAPEW7XzbXrrbhCmTAy9T6kfpCXT3us=;
        b=pSjpp+w4F4tENaGIN7uPFxmYe3iFUCGBDFHD972AzSRYz7sDTmDJuwmxnY5P11nVC7
         LgDsjFjsn0AMK2Hd1uoYQfIPKVZmP8UkdJ3GtcRIrHb5Np8Bt2tQGM4dCMDUJNSmYC1x
         BtsH/Wc5tfVm7lK5FT3scKxRwGW84JjfMlciFjozYV5CueQgWfamu7Kf8ZVoRINHdhjC
         luvWj6w9u9WyzNqxLr9MiYDn62WbHg8g1Hy/d6J+0Vsc1e3u15N53BpPSBZ++eY6z0Nq
         8vjvmJNHrk6gLOpqOz+Pn15yWJQtf5kOJKiadGKWlc9bWBX92TpnAEgZMegMkiCzXtjJ
         9++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=WLYTnHUA0a2ryAPEW7XzbXrrbhCmTAy9T6kfpCXT3us=;
        b=kZtn+kvGWDh4TSmiXerKJVPkKV/o+RnPYRnrnaVuU6MgqN9bbOFSYhbQHZu7tbVnPz
         RN8ybwnlptBshzSFYRUXVQhEXOCWNkYs/xe743ZGIg2/KhK9LxZo9SEvYISii0jKUbkH
         weia6xuUOt31w4eYD5PbImVfJtyiMJ6PE8t7GENBdPgsoOTA5huPrAsUI8tJ02fbyz6t
         X5cYEPFLytqkz7sAYJp6EM4THpARDRSLH7PcgaETlkGSGxMF4RKpsJU8t4qvt3zaxEU4
         fzwtpodvgNCfi4ptWuvmybw97/9EtODe23g87mdfxSXgeyL/PcB9FAlXi6gm6fcyRyhp
         koyQ==
X-Gm-Message-State: AOAM531MFzkjW2dkPBSvc4C2JXWi8PbToGuMV4j8y13VO6hDDkVtBVcr
        RWhJKN8bqf9eERnBReVE4kbofSl+k54=
X-Google-Smtp-Source: ABdhPJx+/G+yMFKLcKp6RLJpp0veR74FnSRychhVjN3ctz52NJp+5Ft04WSwxH4b38nGV3o4DqnJ0w==
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr8035088wmd.82.1597514380997;
        Sat, 15 Aug 2020 10:59:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id e5sm24460775wrc.37.2020.08.15.10.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:59:39 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 1/9] habanalabs: change CB's ID to be 64 bits
Date:   Sat, 15 Aug 2020 20:59:30 +0300
Message-Id: <20200815175938.16619-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the possible values for CB's ID are only 32 bits, there are a few
places in the code where this field is shifted and passed into a function
which expects 64 bits.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/command_buffer.c | 2 +-
 drivers/misc/habanalabs/common/debugfs.c        | 2 +-
 drivers/misc/habanalabs/common/habanalabs.h     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 7c38c4f7f9c0..33aee64f37aa 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -173,7 +173,7 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 		goto release_cb;
 	}
 
-	cb->id = rc;
+	cb->id = (u64) rc;
 
 	kref_init(&cb->refcount);
 	spin_lock_init(&cb->lock);
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index c50c6fc9e905..25775b12139b 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -110,7 +110,7 @@ static int command_buffers_show(struct seq_file *s, void *data)
 			seq_puts(s, "---------------------------------------------------------------\n");
 		}
 		seq_printf(s,
-			"   %03d        %d    0x%08x      %d          %d          %d\n",
+			"   %03llu        %d    0x%08x      %d          %d          %d\n",
 			cb->id, cb->ctx_id, cb->size,
 			kref_read(&cb->refcount),
 			cb->mmap, cb->cs_cnt);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 52a07c8d7d7c..2decf7be3e08 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -401,11 +401,11 @@ struct hl_cb_mgr {
  * @lock: spinlock to protect mmap/cs flows.
  * @debugfs_list: node in debugfs list of command buffers.
  * @pool_list: node in pool list of command buffers.
+ * @id: the CB's ID.
  * @kernel_address: Holds the CB's kernel virtual address.
  * @bus_address: Holds the CB's DMA address.
  * @mmap_size: Holds the CB's size that was mmaped.
  * @size: holds the CB's size.
- * @id: the CB's ID.
  * @cs_cnt: holds number of CS that this CB participates in.
  * @ctx_id: holds the ID of the owner's context.
  * @mmap: true if the CB is currently mmaped to user.
@@ -418,11 +418,11 @@ struct hl_cb {
 	spinlock_t		lock;
 	struct list_head	debugfs_list;
 	struct list_head	pool_list;
+	u64			id;
 	u64			kernel_address;
 	dma_addr_t		bus_address;
 	u32			mmap_size;
 	u32			size;
-	u32			id;
 	u32			cs_cnt;
 	u32			ctx_id;
 	u8			mmap;
-- 
2.17.1

