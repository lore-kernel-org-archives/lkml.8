Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCCAC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80458206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOp9nl7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgD1WId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbgD1WIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:08:32 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC00C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:08:32 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c140so158769qkg.23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hlzgtua4FT07Iktkw8wO18i+dcUI37C1JOVLxE2W49E=;
        b=UOp9nl7/O1pI2hxJvYsrlzNgllpaws4gm0GsfrWDKc118citm945gekme8wLEqUnBk
         ghSuezea6nD3T42PS7kaRNMxfGLH8yHaE6b1gkNbL4CR+MUIIDV7KrZshPP7piKVq8y/
         4Nt+Qfwb0ydufNCstPtzwPdqp/GDj05QX4jXg24cpJQvjglhnh4udMgD5BKrRg0zpDxD
         mnXES+l31yGCVVg1JXmHwiam6WxJMCce8el89GqTrpyxnM5U9UWKjuahE95jkii8Ke05
         uSY14aeChjx+CosW6NbTAynh9EO7qpd7wPEok6DkOfxMnXD1jo4D6lYCBrCyi+KiMskI
         ySMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hlzgtua4FT07Iktkw8wO18i+dcUI37C1JOVLxE2W49E=;
        b=AIsx2ZHjO4KJB4jT31oJCuoSsfwtRBLxtuXT5PoyMD8NOChIaQtauLijk1ER54+vTx
         XVXKnsXwUSObj+LyjtekyfGUg9dy5Mq3mgCeGGWC8Lhx8viM9aAsDb/GFQmnWxgwA1K5
         xiCZMYaSzpEem/xlzdoZ7dIyxtyCOnPm6+39mRyJi9g33F5VXpdsuu9PpMeKyUF5lhzB
         +nFir4b96YrgP6MJKSI0g94qw9n8QIFz1TQmWmkQBQGkpVXR+FPp1WoV6Ud5WKgGlcLf
         XI7QmkgLhldkuojNrzLAnRIsxzsmwJcaZVgMezSG0esj9AiPNB5jR+s3lqdSx8tnZ/rD
         kELg==
X-Gm-Message-State: AGi0PubEehKJJQUg/3DvOKq9SfEcMkzNBsed6yT8XJDZcxuuGhJy53Gj
        YZ65hKaxf8u2Y4hUtNeNkQDnaGaP3tY=
X-Google-Smtp-Source: APiQypLAaGzhfm+BuScTw/mOhTDXDhIQF44+NVjFS5CcBrcmTSJLPmiSmhxBAPqe+kDzWXUhHpZmjX/NWpAD
X-Received: by 2002:a05:6214:3e2:: with SMTP id cf2mr28521504qvb.193.1588111711076;
 Tue, 28 Apr 2020 15:08:31 -0700 (PDT)
Date:   Tue, 28 Apr 2020 15:08:25 -0700
Message-Id: <20200428220825.169606-1-zzyiwei@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] gpu/trace: minor comment updates for gpu_mem_total tracepoint
From:   zzyiwei@google.com
To:     rostedt@goodmis.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     prahladk@google.com, lpy@google.com, android-kernel@google.com,
        Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yiwei Zhang <zzyiwei@google.com>

This change updates the improper comment for the 'size' attribute in the
tracepoint definition. Most gfx drivers pre-fault in physical pages
instead of making virtual allocations. So we drop the 'Virtual' keyword
here and leave this to the implementations.

Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
---
 include/trace/events/gpu_mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
index 1897822a9150..26d871f96e94 100644
--- a/include/trace/events/gpu_mem.h
+++ b/include/trace/events/gpu_mem.h
@@ -24,7 +24,7 @@
  *
  * @pid: Put 0 for global total, while positive pid for process total.
  *
- * @size: Virtual size of the allocation in bytes.
+ * @size: Size of the allocation in bytes.
  *
  */
 TRACE_EVENT(gpu_mem_total,
-- 
2.26.2.526.g744177e7f7-goog

