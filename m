Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C95C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634BC2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="wD3em0zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD3LOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgD3LOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:14:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20CDC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 04:14:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so6414713wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPJM/JQ+ZX8J0CzDLB2FNeh+4uMaMtvoGlJhpe05FKo=;
        b=wD3em0zjC7PhgZRk3mvs7RPlzaHN8XgHBX+2PZMPOHA+0fbQNF1xbaJ5sOhIvN262p
         dCDaFvjPB1DALVSJhUT2wFJsLmUUdrFdV1V/bscKwwvpGH/s6orBGaEdNYH/CCpPVDLB
         yP/cbbLK+xskefeeLJh1tl3c8j090odDD2kHmybaNL5cKX/VDhfuDGVTQ7t8hzPBmmln
         Wcu6wbildXNRJDRnuxyK3JoDfEf3z8V1zuHuSQuHQmNn0urUlNI+RHoFShv4Wi5f3jZL
         0cnDMNRgLHjMC9ybhDuJ754tWc5Ow1L1H70bas/YqQYc7rFx4T5VpmFsQLyFbHJftV4W
         c6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPJM/JQ+ZX8J0CzDLB2FNeh+4uMaMtvoGlJhpe05FKo=;
        b=PR4Z6d8EJyEqffHDO05BArxoP7xDIGzs1GJDS4SmSDpvORgHcEAbfIR10WD9bUAyZs
         3+TUTa1rEmurqHCD9X5YpCAPtLT12HGw4sf5xdhJnEkeVNBP5Gf7mJ8OpTb8LeoEBSF2
         Kne1eFcJacL8wPWn7rPp6AxvKFcBtw8Wx4IDLeIGyGFlIZJWMttNPLYqUBfE4M2Ukwhl
         6ExsM/iJs+HVKVLcUCozjO1OL71Dd7ZVGeIFzYj35v6x0K1B+1Kof6KSEJITs/3NYt8P
         aGMF6sG+Dfg8qOnAQzF3pP9BUvjLIIp6O/cXPFZsXVnJ4L6Imkc3ozGqe5vDEMtbOb5h
         blTg==
X-Gm-Message-State: AGi0PuanC2W8q3+CKJ9aSduLxuRAhCYKbafqYPZ4qDvFmwjVIRgVsyJ8
        LgBWeA5fuEtVTWCQStzIEzi3XsNs3Jw6UQ==
X-Google-Smtp-Source: APiQypKhHctaXeThKlhkmq+lX5fz+mvYIUIhH6Bc9PVcBoNEd9v8AJfTlYk00fOwhzm7Ks/ET1oYCA==
X-Received: by 2002:adf:8543:: with SMTP id 61mr3134316wrh.243.1588245275324;
        Thu, 30 Apr 2020 04:14:35 -0700 (PDT)
Received: from linux.fritz.box (p200300D99706B800C31B4649AAB0E4BE.dip0.t-ipconnect.de. [2003:d9:9706:b800:c31b:4649:aab0:e4be])
        by smtp.googlemail.com with ESMTPSA id h16sm3821265wrw.36.2020.04.30.04.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 04:14:34 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH] xarray.h: Correct return code for xa_store_{bh,irq}()
Date:   Thu, 30 Apr 2020 13:14:23 +0200
Message-Id: <20200430111424.16634-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__xa_store() and xa_store() document that the functions can fail, and
that the return code can be an xa_err() encoded error code.

xa_store_bh() and xa_store_irq() do not document that the functions
can fail and that they can also return xa_err() encoded error codes.

Thus: Update the documentation.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 include/linux/xarray.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index d79b8e3aa08d..2815c4ec89b1 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -576,7 +576,7 @@ void __xa_clear_mark(struct xarray *, unsigned long index, xa_mark_t);
  *
  * Context: Any context.  Takes and releases the xa_lock while
  * disabling softirqs.
- * Return: The entry which used to be at this index.
+ * Return: The old entry at this index or xa_err() if an error happened.
  */
 static inline void *xa_store_bh(struct xarray *xa, unsigned long index,
 		void *entry, gfp_t gfp)
@@ -602,7 +602,7 @@ static inline void *xa_store_bh(struct xarray *xa, unsigned long index,
  *
  * Context: Process context.  Takes and releases the xa_lock while
  * disabling interrupts.
- * Return: The entry which used to be at this index.
+ * Return: The old entry at this index or xa_err() if an error happened.
  */
 static inline void *xa_store_irq(struct xarray *xa, unsigned long index,
 		void *entry, gfp_t gfp)
-- 
2.26.2

