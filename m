Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB68C7114E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 00:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC442073A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 00:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWX56Dh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgBPAkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 19:40:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43301 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgBPAky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 19:40:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so12742048oth.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 16:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP2d5mrDDYuWOGt0j6R7sVfg2HV+cZtGZwXSSh2x4yQ=;
        b=hWX56Dh/Gge2xHbvgZPqq0cqkBYPxvOKTABmU+RD7KKAyBpKUPo00A8YOVhzTBbar6
         NM3rb9fIi7WDXsxO8va38FgCFIYd7QFHD6vbdMs/5eJmbEkUyIJniod6cxXUtBwLp78D
         feaU16l4g3W4RcIU7oyAk1YFOWXDSAQEZsOLkBLgG/d1BwLEg2B5+q/i6FankzykAS2B
         GaWRLjXh3cOOcyENzTCHlCAQnlYYz3IEAc4yUA5Vtmm/MG9+VlDSlRqkQzjLhrAtqB8m
         99mL8SjnryBPlnJSPca+ileJ1Eon14cG02YQrgVviMngbASQ0dWWIZkcbj2jxSZ5gJxb
         bPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP2d5mrDDYuWOGt0j6R7sVfg2HV+cZtGZwXSSh2x4yQ=;
        b=OdtgSfgcPcj5Nr6MMpsYa0GBXeu7RKCLHr0rny3Ga5cY3pzylU5/QIUHVq8YLd1Nbc
         ie5eSjNQ5nazpNvsvRHCuYiTeAVsDUEddDe2zWFrU0G8Uzsu95T/X+FaFXX7CmsodPup
         LCm2GwV4gm0qNORxhbIHj1FeEkXg70bVTkb/4sIXNSbFTCDdPq5r67rNtbQQoa7TGzsE
         brnuvcV+cgAIgHLUP0uwd5GNP8JPA++52yqiYqQEq3tbjOlNhMognc7OESoY2RMrphXE
         GG+/Q/YiA2/iaIXhDGA+YMhZ7dpf4lXcWOOYFAJbTGoWudvv4UqTb3nxX+dYdBb+9LQ+
         Je8A==
X-Gm-Message-State: APjAAAV5UDNMMolT5+X1Q8ZYDT3GcYiE7OL/2asVMgSXdGAIx1rCV2Fm
        jBME5qDjtGsbmrICy646IVk=
X-Google-Smtp-Source: APXvYqyuZpug/NB6vcKcnwbQ/XBPbV0NsCAjTD7xPqll2VAa6KJDhxw+78bpH2GMCYmcCX21JjY0XQ==
X-Received: by 2002:a05:6830:1608:: with SMTP id g8mr7101714otr.169.1581813652532;
        Sat, 15 Feb 2020 16:40:52 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c12sm3438979oic.27.2020.02.15.16.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 16:40:51 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] virtio_balloon: Adjust label in virtballoon_probe
Date:   Sat, 15 Feb 2020 17:40:39 -0700
Message-Id: <20200216004039.23464-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when CONFIG_BALLOON_COMPACTION is unset:

../drivers/virtio/virtio_balloon.c:963:1: warning: unused label
'out_del_vqs' [-Wunused-label]
out_del_vqs:
^~~~~~~~~~~~
1 warning generated.

Move the label within the preprocessor block since it is only used when
CONFIG_BALLOON_COMPACTION is set.

Fixes: 1ad6f58ea936 ("virtio_balloon: Fix memory leaks on errors in virtballoon_probe()")
Link: https://github.com/ClangBuiltLinux/linux/issues/886
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7bfe365d9372..341458fd95ca 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -959,8 +959,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	iput(vb->vb_dev_info.inode);
 out_kern_unmount:
 	kern_unmount(balloon_mnt);
-#endif
 out_del_vqs:
+#endif
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	kfree(vb);
-- 
2.25.0

