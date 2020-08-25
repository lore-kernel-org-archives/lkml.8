Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DA6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEF4207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNNIdw2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgHYHKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgHYHKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:10:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89394C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:10:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so6192323pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cGSRd7I0SCxqdyTaBPcY4PAA0jEQQULAtHrZoGGo1pM=;
        b=YNNIdw2TpYsIyU0Ly5iF4T09BX2GIRRodEwsUWdAqHqD4U18rCWpYMvR5vgdg87kdi
         cm+EuCQeHXpYZiqWGZborf0wtijtGP3cbQps6UHva9f/CBZT82MKfOiaZ6MhG1+rbkv2
         Y62qK/N6oMK/nTpg5n4VLPBpQ9hLE2uSQiDzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cGSRd7I0SCxqdyTaBPcY4PAA0jEQQULAtHrZoGGo1pM=;
        b=GyrMi5EWLPBBbHLbk7AEqhqCXLvcx5K3QdFqbIqRqXSy+zrzkeCHmZJeJMCX4Ns8j0
         XqLgn/iTVNFix3MPJsqAsVZZ9c79x4X03YhqnQskdqLRT+MYshvakdWAvdo3esORW0g4
         AHa4EmokJYYUt5NUoLd0zmxKcgDkJxlcmrU0K6Gk+g2Ze9CpM+GycQZFFJMgw0mP7P32
         w6E28ckJoN96fxiEDH7WLvu5kYEJwSv2+a2cgk0Q/of8IYEphjWsnnqXL8xkLD4RwlxP
         Te0dVuXeK1H+iPV90ZKhsYpmlv78toJfC2jqkKzqRCA/6WPA1J/4I/uWWqfnwXV2gYsD
         hByQ==
X-Gm-Message-State: AOAM532ceOoLHT3fgLSjRtfcW3V1tvsMLRKoQ/6OFlMPcmVH49gkjnNa
        yILpWdIu4lR+9zdlSPpyiCjJgA==
X-Google-Smtp-Source: ABdhPJxhoDNMh0zvVAWYdXbJ3/yiu8BrfQCZr9Kxsw4TSVDBmcJl5gXRwU96bsmEuAWUG0w2Fu5BAA==
X-Received: by 2002:a63:c902:: with SMTP id o2mr6036356pgg.264.1598339403002;
        Tue, 25 Aug 2020 00:10:03 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id y4sm14218064pff.44.2020.08.25.00.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 00:10:02 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: Warn if trace_printk and friends are called
Date:   Tue, 25 Aug 2020 15:09:58 +0800
Message-Id: <20200825150942.1.I723c43c155f02f726c97501be77984f1e6bb740a@changeid>
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

 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4aa1d9d5e62c5b0..4b4988f25223c6a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4272,6 +4272,14 @@ sub process {
 			     "Prefer dev_$level(... to dev_printk(KERN_$orig, ...\n" . $herecurr);
 		}
 
+# trace_printk should not be used in production code.
+		if ($line =~ /\b(trace_printk|trace_puts|ftrace_vprintk)\s*\(/) {
+			my $func = $1;
+
+			WARN("TRACE_PRINTK",
+			     "Do not use $func() in production code (this can be ignored if built only behind a debug config option).\n" . $herecurr);
+		}
+
 # ENOSYS means "bad syscall nr" and nothing else.  This will have a small
 # number of false positives, but assembly files are not checked, so at
 # least the arch entry code will not trigger this warning.
-- 
2.28.0.297.g1956fa8f8d-goog

