Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AF0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50ACB2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="QijV9x4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHMVEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgHMVEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:25 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B7EC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:24 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id o2so3330373qvk.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ycCIVy361UoLo0c5/AED/UxCAcejG5GKn68oBgGv2HA=;
        b=QijV9x4iaFVr4ppulFFUZv+PUc7jxU/O9GHaA9x761i20qidkkD1kGUq1KbcByoiYW
         ycJmmOdd1tlK9SukOuH1QBjIjTLnvROd4EwwbVlug8Kvwcpy5SeqwkRhFKzHJczfRgcI
         t/mLY1zYoTFj49exE5rWg+hdcxtMLY5vhqudWg5IbYWwSkZ4PrhzpN5PhrbpC8isfxps
         46Zej12Yz58j6T9YOd3483AnmjrhXYPHqsZckD5zuSRQtAIREWXt4eWmJ38C7GC0kIuj
         Bw1tch82CvP93lh9h5nEI9r1fHNWUrheMHmthfiCXSMHEE7fOUys2lrU1xVElVsYrNw+
         tChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycCIVy361UoLo0c5/AED/UxCAcejG5GKn68oBgGv2HA=;
        b=dhMQSyS9J1+zf3Big8ikNqggL0Dvq7otpWmVgJlBdogBf4Bg0kc3q56YBjoQaJZ7Z/
         ObyiRuAqaQzmQDTzj1JV0FSOvo69PY1F9arAVvF0wBEz8s7hZT92xU6YoXio7GlOIYSp
         G1xlcd5H1d0a/G2I3A2qAsgdrkkyRFc8dUIDWWa0dKRd+ScHTRsQ84FzVZoRLXaRSndV
         07fjuPIniYwI8nYcx6GzvC4Hk3+Wmhb4ZJSP+AgE4HKBqcbq2qNmqM23K9UkF5Ck863J
         l/kvsX7U+LbbGH2/SbcPqeGBTP/rN6UfDQQ6oRlkcwOBGxQrK4+CUrGZvEnQtT2jKOYe
         dDmg==
X-Gm-Message-State: AOAM532czOo5ftGyy5EAbMONCPMXtqeWN0PIhMIQopqCGRh1axoMOCF/
        OGPtonlh/hgg0SQIQLXC+EjcsA==
X-Google-Smtp-Source: ABdhPJy7Ev0oEAzZFQ91/Fm3qWfS688wZCmbhl8ge0Fwp1eNf3XvcIMjaZ7llS65arZ8Ck4HavVc8Q==
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr6510667qvx.6.1597352664041;
        Thu, 13 Aug 2020 14:04:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q7sm6663428qkf.35.2020.08.13.14.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:04:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: [PATCH 4/6] sysctl: make proc_put_long() use scnprintf
Date:   Thu, 13 Aug 2020 17:04:09 -0400
Message-Id: <20200813210411.905010-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813210411.905010-1-josef@toxicpanda.com>
References: <20200813210411.905010-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we're passing down a kernel buffer with enough space to account
for an extra NULL terminator, go ahead and use scnprintf() to print out
a long in proc_put_long().  count here includes NULL terminator slot in
the buffer, so we will get the correct behavior we're looking for.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sysctl.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 287862f91717..d8cc8737f58f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -484,6 +484,7 @@ static int proc_get_long(char **buf, size_t *size,
 
 	return 0;
 }
+#undef TMPBUFLEN
 
 /**
  * proc_put_long - converts an integer to a decimal ASCII formatted string
@@ -498,18 +499,12 @@ static int proc_get_long(char **buf, size_t *size,
  */
 static void proc_put_long(void **buf, size_t *size, unsigned long val, bool neg)
 {
-	int len;
-	char tmp[TMPBUFLEN], *p = tmp;
+	size_t ret;
 
-	sprintf(p, "%s%lu", neg ? "-" : "", val);
-	len = strlen(tmp);
-	if (len > *size)
-		len = *size;
-	memcpy(*buf, tmp, len);
-	*size -= len;
-	*buf += len;
+	ret = scnprintf(*buf, *size, "%s%lu", neg ? "-" : "", val);
+	*size -= ret;
+	*buf += ret;
 }
-#undef TMPBUFLEN
 
 static void proc_put_char(void **buf, size_t *size, char c)
 {
-- 
2.24.1

