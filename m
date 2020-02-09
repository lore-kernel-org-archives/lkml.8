Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBCBC352A4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57022084D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/7HX0Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBIWoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:44:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38467 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgBIWoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:44:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so8450283wmj.3;
        Sun, 09 Feb 2020 14:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QuH3HSliYDNsbFGS4Y5YwZwL5waK3j6MFtJQuD3XF6Q=;
        b=F/7HX0Rz+mxutOT/8fmYHa4d8KdkbN0x4K64xH0QJSgvXGHabRr4WLfCCuL2JWGjoj
         ZvaUPI06n9C5TluYXfGdykelxmtFzOBTDh4T+M9qbbKTid5ZunWUCZP5SpCpFinCF/4l
         YSetmTi/xJY/4gauvGnWn1rqAKvPNZXOcgnaxPzFlWai+AUse+oLHGecbVp774om7yGG
         Zz9mQ0OecwB1RFFAOJFUOj4HWpFCfF0Y2iaCr752wvqi8syTw7WcULZltv4rPQP0e5Uo
         5G2AxEa1h2Yf3a6WW0gwUMkF+URTTcPzB3MJYN69WNzD08ZeEIkGAHqhw62eE7SZ2zFo
         WRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuH3HSliYDNsbFGS4Y5YwZwL5waK3j6MFtJQuD3XF6Q=;
        b=B39trIerqEf8CW/yMEqxD9QdjtRPUQvxxTUkBL3NQ8xGBYwGQP5f9ozlS5qTirC7Bh
         Pl/dePvYJyNyXb8YKHNTEPJlporR2cZ+3MzvNcaMYbqLundNrG8sETzjXAgVRSkPCR9j
         VmRIT63k/EVgJ5cg+caCyaZFhvWRffe2nqdBPCY81dZ6rDLcVJte5N/n/yQKtwf86v4S
         R89PjD4agQG6OzTKBI0mE4ZulHqkTzn+g8Zn/ZuKae++Im6j0zRCW8oNnBYz0bQtP1pc
         TTDG/RRe1nGJtNGHEttiH8KNINw/7GpRg9NPmAHHSgMwFZJ2R6wHu8+UmzzVmDIVNPSi
         GyZA==
X-Gm-Message-State: APjAAAX4OC7SjS/U2J53dc92S/TXM4d5iI3p4blIVEq1p2IxiVzc7wWy
        lpBfEjUQGWLwW3Kh+vB3tA==
X-Google-Smtp-Source: APXvYqxLLjSXh+vhpnYc88KSridcNaHZ/9poWAA0s/BqO0YixKYx6HsCEym5WOCR+AeQOLyLW3rc9A==
X-Received: by 2002:a1c:a9c4:: with SMTP id s187mr11060848wme.97.1581288254422;
        Sun, 09 Feb 2020 14:44:14 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id g18sm12660450wmh.48.2020.02.09.14.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:44:14 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 07/11] fs_pin: Add missing annotation for pin_kill() declaration
Date:   Sun,  9 Feb 2020 22:44:04 +0000
Message-Id: <e1f17a7b53760467defc7055ce1bd11d7e8f80cb.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports warnings within the kernel acct.c file
at acct_exit_ns(), __se_sys_acct(), acct_on()

warning: context imbalance in acct_on()
	- different lock contexts for basic block
warning: context imbalance in __se_sys_acct()
	- different lock contexts for basic block
warning: context imbalance in acct_exit_ns()
	- wrong count at exit

The root cause is the missing annotation at pin_kill()

In fact acct_exit_ns(), __se_sys_sys_acct() and acct_on()
 do actually call rcu_read_lock()
then call pin_kill() which is defined elsewhere.
A close look at pin_kill()
- called 3 times in the core kernel and 2 times elsewhere-
shows that pin_kill() does actually call rcu_read_unlock().
Adding the annotation at declaration and definition of pin_kill()
not only fixes the warnings
but also improves on the readability of the code

Add the missing annotation __release(RCU)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 include/linux/fs_pin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs_pin.h b/include/linux/fs_pin.h
index bdd09fd2520c..d2fcf1a5112f 100644
--- a/include/linux/fs_pin.h
+++ b/include/linux/fs_pin.h
@@ -21,4 +21,4 @@ static inline void init_fs_pin(struct fs_pin *p, void (*kill)(struct fs_pin *))
 
 void pin_remove(struct fs_pin *);
 void pin_insert(struct fs_pin *, struct vfsmount *);
-void pin_kill(struct fs_pin *);
+void pin_kill(struct fs_pin *) __releases(RCU);
-- 
2.24.1

