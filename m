Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69258C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373F3206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE1D4feJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgA3A33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 19:29:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33915 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA3A33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:29:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so1851992wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NKXAmCNluFTleOGteK3fJq6Z0n6+m36donNYzzstnig=;
        b=mE1D4feJyGF3q5NG8awe2zWKc74q3909Ep2ML4ft+uegUhElUbnV+wXW0SZ3JsO+Mm
         xksRMmQgpBIOxxA88e/5vHP6PasLZbjWg2TUBYoYaCsF/lGFKHQimzLDEW2vJ0INWNSI
         FuK8oU14c4bZSP9qcvibr4xyPSpUliay3ztzB5Yam3SYGpSYcGwAZ36cNZH3epjIwX3n
         22XdpT/RsxnKMoSsraUIKOrw3VNfetQEspk8o0IebwX7/jY6H7d9HBpamjtQpISfIKsW
         HOgDrun97cstFraVosbMcweAHbK3rgnNSBIyAe3D9AcGeovmQi6iVQ+2neRW6mm+KO8g
         uktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NKXAmCNluFTleOGteK3fJq6Z0n6+m36donNYzzstnig=;
        b=Ypkin2N0ocsmgfdJeNgS8EwWxQLMuF9R5ZXcqDL3qQWK4zQhWhAv8rFR/lASfcfcP3
         iTOP31KfGoQUhyCkIzcNcx6J6h5F4jXyJT/soXU6iln/2A78qvV/GNtovsDXqbXUgdQZ
         yeZJhcmXubERjAEPVwpYhUZ9ULmZ8xGrsOXq3yGmAfOLG9jx96xPZ2iij0vHq5zN2UQJ
         PQHYpDoTygY/wjppu3pGsr55n6E2VexW2SLQZOxe4Eu0cJPWQ4cODbiUkDm28dZRXio3
         caoevBToS+eCQZNtLE2NmVhs1mUyJexlL39TylTK5vm41NIiS11YNU5iIMlh4A6Ppjd+
         JYkw==
X-Gm-Message-State: APjAAAU10uIYBQF/HJRumf9QnQ3DXAPS7U19Dsx2LlNh/dVeq1tTHCp4
        NTyiTmx3FLO9rrvCxcxa7A==
X-Google-Smtp-Source: APXvYqwz257SMCVPpvTd9JWrn8AXoQkgBnRVeymWxzSln+TXebLZhYKYXmbfluXc+vjcbF4ZpjUwnA==
X-Received: by 2002:adf:a51d:: with SMTP id i29mr1530198wrb.119.1580344166675;
        Wed, 29 Jan 2020 16:29:26 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id r5sm5011294wrt.43.2020.01.29.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 16:29:26 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 1/2] fs_pin: Add missing annotation to pin_kill() declaration
Date:   Thu, 30 Jan 2020 00:29:13 +0000
Message-Id: <3d8d1f596dcf556f1b9276c4e6d2f5401e598657.1580337836.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1580337836.git.jbi.octave@gmail.com>
References: <0/2> <cover.1580337836.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports several warnings within the kernel acct.c file

warning: context imbalance in acct_on()
 - different lock contexts for basic block
warning: context imbalance in __se_sys_acct()
 - different lock contexts for basic block
warning: context imbalance in acct_exit_ns()
 - wrong count at exit

The root cause is a missing annotation at
declaration of pin_kill() within the header file
Given that pin_kill() does actually call
read_rcu_unlock()in its function definition

Add the missing __releases(RCU) annotation.

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

