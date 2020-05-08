Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA0BC47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2A321974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs5Haqqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEHVaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:30:10 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51471C061A0C;
        Fri,  8 May 2020 14:30:10 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x73so2570408lfa.2;
        Fri, 08 May 2020 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxBTJqZiekxvf2G8DxZqYim+VhvqcZUGLxb2iA/qngo=;
        b=Gs5HaqqhmBPofqnH9id018KoTv6ZoI3RZ6xYTo3SvRK5IsWE5GChPW7mCFetFWEjeo
         S5DSCzzrs8LzN2aJsFx2EnLMdPR3XdUjQIdt8HPr5hJnjK1MNLNt4Bq6YXP0984/5K9r
         XvH0s0n06Y8+zvNW00bF59MQiWXJI7drykRdQ/aXHm5JeHPp8LaojK42KShvIuibJAGT
         cYUrNmAtcYCfUBm2FS9hqqssYrYkUYbrpKFEe4hVukzOisIZH0xGMqoOGNn3m4B/7AuH
         tdYoFa24YEQ+Lt7QFNo4GEb5fCg85/nJ096xIQq5+bFFgG5QTtK6F/BTT8OwGodVxeDI
         BxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxBTJqZiekxvf2G8DxZqYim+VhvqcZUGLxb2iA/qngo=;
        b=OYgQ2Q+V93mTq0MAiC2HlBuniFDXadQkF79x7CKMsC/LRuJmnme6jMbSytkDjenuea
         HC0gejYUrP0jnQwynvQvCok8tOsxLeQVb4LErh9Po9N2ABrPO+57/9shLrdMCGxGMNzQ
         6yYdGFIQmctX4qd6yLtk6SlPy4d3t1iwQ2bjfTkV7B3WQ4eassHqSmon+OQ4rVgsKNba
         n9GMGJYlCuh0UtSyZn6ifiXJYGmmU1mYZLi6/Fsh7U1r0wcGtkvcYVNlWUDrIOtI80st
         se0ItXfv5Usz7nGDvXk82NfToPFc3Ev4OqMiAZkrSNxTLZT5uHKCJvZ+/Dx8aGz7wjdI
         0l6A==
X-Gm-Message-State: AOAM532N/fNCpLxVdmIqd0m867xdCAett35siFiQVMUBWWAEK+QdiA4b
        GD8fO8JpODxbss6cTYIgYPeHr9+1
X-Google-Smtp-Source: ABdhPJwNja5rS3zATF1PYo+5GejWgZ9hvuppPG6TonNSg2Cl+hoxhG5iowRvQWXFe9mn86LgEBdJCg==
X-Received: by 2002:a05:6512:3136:: with SMTP id p22mr3172195lfd.159.1588973408472;
        Fri, 08 May 2020 14:30:08 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id w16sm2059340ljd.101.2020.05.08.14.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:30:07 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] docs: debugfs: Update struct debugfs_reg32 definition
Date:   Fri,  8 May 2020 23:29:49 +0200
Message-Id: <20200508212949.2867-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the docs to match the implementation, both the definition of
struct debugfs_regset32 and the definition of debugfs_print_regs32().

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 Documentation/filesystems/debugfs.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index 6c032db235a5..1da7a4b7383d 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -166,16 +166,17 @@ file::
     };
 
     struct debugfs_regset32 {
-	struct debugfs_reg32 *regs;
+	const struct debugfs_reg32 *regs;
 	int nregs;
 	void __iomem *base;
+	struct device *dev;     /* Optional device for Runtime PM */
     };
 
     debugfs_create_regset32(const char *name, umode_t mode,
 			    struct dentry *parent,
 			    struct debugfs_regset32 *regset);
 
-    void debugfs_print_regs32(struct seq_file *s, struct debugfs_reg32 *regs,
+    void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
 			 int nregs, void __iomem *base, char *prefix);
 
 The "base" argument may be 0, but you may want to build the reg32 array
-- 
2.26.2

