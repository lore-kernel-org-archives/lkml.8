Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878AAC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538EE206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+l4BXwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgHYLlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgHYLga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:36:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82BC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 04:36:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so1104031pjx.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glFTkS5G7hs4SNdc7xuyY0+I6rArkO6QBk+llo/j5FQ=;
        b=A+l4BXwL8oca3n7v8aMTKTcICSrXGYTx/nHjowSd50dIHc94OIG9VY1FbjRbccROJ6
         2Q73gFyOjU3I1sLPEwC3cXL9/ARZSjYwdX4JmHCDVkqY9d21cswHf+CqNsaFi6VCvZtn
         XOaS8gu6hEKrnsYrGqTnmYGE89W1/WdhYofeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glFTkS5G7hs4SNdc7xuyY0+I6rArkO6QBk+llo/j5FQ=;
        b=tQxUDroSdupNMwWEI5wbSMZdrii5XOvUZ81dN/GRVgVRfR9RxXsAQvs8CNEFcJW0Qt
         WJHEIAnc5/BFdf7WBgy8wsi6wx5sTtCw+d3Vscr/zeXRZlVeEdHPh7KSqYLCk5uvNhun
         XIc3t7vtWJdc7e7N/CyBM4qfo39r3HmsCbwv5L29JkubKjRc3Bpsa+xQ/k9xlzxzzygR
         I7cMv2mw/RmQ8efbSr+chQGfeY6ltyo7y45y/cyfcqp9z2DAA3Sf/mewL0fRkG+l6yBm
         Zsw92zoEgA0ju08IqhQDZOVc90+O5ckBR+OZ8zy1bf5vAyOf+mrBxXRrHrRwhIcLblor
         Vudw==
X-Gm-Message-State: AOAM531vb8Irtmvat9BR9z+619biR0xkgIXTi5/s2rQKtf16URtYz2FA
        Yaywwvbo++wq8B0RSMa+9WZ5fg==
X-Google-Smtp-Source: ABdhPJy4yBj9SbHa9s44Trh1M4T/0mY5MMRYpEq9Kpm/iTyJawjS0anz8F4CDdLjtzBIKT+QNuoz0w==
X-Received: by 2002:a17:90a:ce:: with SMTP id v14mr1242997pjd.123.1598355376234;
        Tue, 25 Aug 2020 04:36:16 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id e29sm15130084pfj.92.2020.08.25.04.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 04:36:15 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: Warn if trace_printk and friends are called
Date:   Tue, 25 Aug 2020 19:36:06 +0800
Message-Id: <20200825193600.v2.1.I723c43c155f02f726c97501be77984f1e6bb740a@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_printk is meant as a debugging tool, and should not be
compiled into production code without specific debug Kconfig
options enabled, or source code changes, as indicated by the
warning that shows up on boot if any trace_printk is called:
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **                                                      **
 ** trace_printk() being used. Allocating extra memory.  **
 **                                                      **
 ** This means that this is a DEBUG kernel and it is     **
 ** unsafe for production use.                           **

Let's warn developers when they try to submit such a change.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
See also extensive discussion under this thread:
https://lkml.org/lkml/2020/8/20/244

This seems to be the simplest way to try to reduce the number
of trace_printk that make it into the kernel.

Changes in v2:
 - Use $1 directly, fix wording, remove final period.

 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4aa1d9d5e62c5b0..1102aa0ec2f7a05 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4272,6 +4272,12 @@ sub process {
 			     "Prefer dev_$level(... to dev_printk(KERN_$orig, ...\n" . $herecurr);
 		}
 
+# trace_printk should not be used in production code.
+		if ($line =~ /\b(trace_printk|trace_puts|ftrace_vprintk)\s*\(/) {
+			WARN("TRACE_PRINTK",
+			     "Do not use $1() in production code (this can be ignored if built only with a debug config option)\n" . $herecurr);
+		}
+
 # ENOSYS means "bad syscall nr" and nothing else.  This will have a small
 # number of false positives, but assembly files are not checked, so at
 # least the arch entry code will not trigger this warning.
-- 
2.28.0.297.g1956fa8f8d-goog

