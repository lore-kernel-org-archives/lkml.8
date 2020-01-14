Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71AFC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A237B2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxydxJ9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgANNl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:41:27 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54266 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgANNl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:41:26 -0500
Received: by mail-pf1-f201.google.com with SMTP id k26so8787943pfp.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d+VdQ2mgKVufPtzjAPQVlGG6NNayGmHdnWPr+cE7Zlg=;
        b=vxydxJ9xqFxpwBc2+UwfYvzeeJpgLwd/1r3pppsJwIBl+STg3q0/MMmyu1axqmnaru
         xm1giynSu1419J1y6kfH0IL7f14D7iMnLFgrdvN+uW/rFSqIUTfQAJDX1TX/hOqcTFk2
         /N/tVvCsqfdw3ynNPIdX6QiaX/K3m0u4q5S1gZD4BZHVw0bNyLZAxfxEPRMSodC14qHM
         gwe4snUrF2jaul+wVyR65CvZh8lJtSp3kvPq8aenqxz5Y7ME575tTVtSPalakIOnqUFa
         OvhOat5LFFF83Ushb6mvW3v5Pf/9ysaOK6jgFLm8UQ06wvVXwtxrVSps2GRn2YfUIpal
         3iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d+VdQ2mgKVufPtzjAPQVlGG6NNayGmHdnWPr+cE7Zlg=;
        b=UXFwZ6227Jew4Yru82yr2pw1SGray2N6sYbJOe3+GUCuVWwpGO86si6+voEeC37+8L
         5JQoZv48DvLyVNZ95Iz8qtTt20Z4r9TSi/Ilrfbt/av6/GVqpc5VwU6DByfgNyHa1V2N
         gxUyvnCGWtNvFXhn1CQrakb25+B9ty/rWw0Tj2wq+7YsjqPUnuKWpgwdpyNbz050nb7g
         y4kfNKkD95Nj+/erIOQO2CNcjtmhgkfSsHL2NL/IKpfbLyqQwMnXaFAo2ZHjZWAO5qqy
         n6od0Kllf49lkQvg+I0SDgv7GwAgLuiFfcNQ0/0uvBw/h+HAfaXF3NKkmGQWYd7YpMpF
         MNcQ==
X-Gm-Message-State: APjAAAVORKD8jhupMcRyher6vtnVC+4fzc4OZV2UkpyQFry1ecGT2f3T
        Ped6QZuVnnH8JfxgC3rAMbl1VvXLMj3dNBI=
X-Google-Smtp-Source: APXvYqxPytptLgvCOeDIY8GJeYREKZybdYA2zNzqFDpmj8uJG4bTWCrOZJ7jIuAoqRo47+i8Apc/fTaIZr2pw90=
X-Received: by 2002:a63:9d85:: with SMTP id i127mr25739436pgd.186.1579009285567;
 Tue, 14 Jan 2020 05:41:25 -0800 (PST)
Date:   Tue, 14 Jan 2020 21:41:01 +0800
Message-Id: <20200114134101.159194-1-liumartin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH] dma-buf: support 32bit DMA_BUF_SET_NAME ioctl
From:   Martin Liu <liumartin@google.com>
To:     sumit.semwal@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        liumartin@google.com, jenhaochen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds SET_NAME ioctl coversion to
support 32 bit ioctl.

Signed-off-by: Martin Liu <liumartin@google.com>
---
 drivers/dma-buf/dma-buf.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index ce41cd9b758a..a73048b34843 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -25,6 +25,7 @@
 #include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
+#include <linux/compat.h>
 
 #include <uapi/linux/dma-buf.h>
 #include <uapi/linux/magic.h>
@@ -409,13 +410,32 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 	dma_resv_unlock(dmabuf->resv);
 }
 
+#ifdef CONFIG_COMPAT
+static long dma_buf_ioctl_compat(struct file *file, unsigned int cmd,
+				 unsigned long arg)
+{
+	switch (_IOC_NR(cmd)) {
+	case _IOC_NR(DMA_BUF_SET_NAME):
+		/* Fix up pointer size*/
+		if (_IOC_SIZE(cmd) == sizeof(compat_uptr_t)) {
+			cmd &= ~IOCSIZE_MASK;
+			cmd |= sizeof(void *) << IOCSIZE_SHIFT;
+		}
+		break;
+	}
+	return dma_buf_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static const struct file_operations dma_buf_fops = {
 	.release	= dma_buf_release,
 	.mmap		= dma_buf_mmap_internal,
 	.llseek		= dma_buf_llseek,
 	.poll		= dma_buf_poll,
 	.unlocked_ioctl	= dma_buf_ioctl,
-	.compat_ioctl	= compat_ptr_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= dma_buf_ioctl_compat,
+#endif
 	.show_fdinfo	= dma_buf_show_fdinfo,
 };
 
-- 
2.25.0.rc1.283.g88dfdc4193-goog

