Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC55C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCD4217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el9uNpAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgBNFrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:47:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45034 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgBNFrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:47:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so8034991otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 21:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z2iYSLYDGYaGS4KoVmwUDz00gZO0krvmf/FASHSxL8U=;
        b=el9uNpAFUFfHliLH4Z4jbnVRGLrbY4XJCMgjQAInLFb1g6MHwSnoL4lr/XCT/aBRxs
         jLIQlIY+LYx+G42rSeanORto31kVNlfg/uPUpsgxttGWd6iYOeSkO5tBAwlvITAVKoXJ
         pRN7k3xbLOqI59sPcsS9sdYl3ayzl3Oi6DqQp2UHlBNfh2NLjRGuREQABww6ycZbvhik
         6vbFLztDxrrUUH+YLqGOdm6B8i8KKZeXtpov7S686swqmBqCR3Lsa89cNJGJtcoy3z69
         mdMThjyAHWlFfHjibcRWFgNaObxbgOjEBTpJGv+IwxgYaKuW/Sef/LqhoPdnXTVnjVkS
         jf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z2iYSLYDGYaGS4KoVmwUDz00gZO0krvmf/FASHSxL8U=;
        b=e3SWF82R6LQdXFbWpucooc22FiiZf02ZJr1/E8EAII5ttvMkWqBvpcLsLEFAIBg1yA
         BikSud3YN06rG8CixRWU7ZII1OxazlWeLWrbqCqtIGqX2fdm6u4jEjp6nKsxt1qP3sMl
         BOaqF6q5nFoNvmWzV6iIq+ghc2DhBL966XD5ufwSB9ohjlUGqD5ZwykE4jSvkN3+trWi
         vWGdpG5Ve4C6iPPGwEZ1VzrBX44VLavI79u6BEqPURupgGVZg3M2M1l/UyW2NBYwLx0o
         cQ2yoznnwdg1jgxkCmaiDmop3aWzl6aFlso2EH4ScRLgG4gs6mjllPAu89gq9J9o/KRb
         wOKg==
X-Gm-Message-State: APjAAAUyWBNz2h/z/odQXZOkDEkUJRXDUilMTKNL0YaK8s0wlhmHluXt
        GIP+TQz7lYFoSoOXgoCtsHU=
X-Google-Smtp-Source: APXvYqxP9k20s4Fu210nTsiauDqN0WjeicH2Gh47BzP033Qga6MrRzcCeBD+F7pQTE7qnBVo46LUqA==
X-Received: by 2002:a9d:7342:: with SMTP id l2mr974746otk.98.1581659233352;
        Thu, 13 Feb 2020 21:47:13 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id j5sm1631830otl.71.2020.02.13.21.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 21:47:12 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
Subject: [PATCH] drm/i915: Cast remain to unsigned long in eb_relocate_vma
Date:   Thu, 13 Feb 2020 22:47:07 -0700
Message-Id: <20200214054706.33870-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit in clang added -Wtautological-compare to -Wall, which is
enabled for i915 after -Wtautological-compare is disabled for the rest
of the kernel so we see the following warning on x86_64:

 ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1433:22: warning:
 result of comparison of constant 576460752303423487 with expression of
 type 'unsigned int' is always false
 [-Wtautological-constant-out-of-range-compare]
         if (unlikely(remain > N_RELOC(ULONG_MAX)))
            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
 ../include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
 # define unlikely(x)    __builtin_expect(!!(x), 0)
                                            ^
 1 warning generated.

It is not wrong in the case where ULONG_MAX > UINT_MAX but it does not
account for the case where this file is built for 32-bit x86, where
ULONG_MAX == UINT_MAX and this check is still relevant.

Cast remain to unsigned long, which keeps the generated code the same
(verified with clang-11 on x86_64 and GCC 9.2.0 on x86 and x86_64) and
the warning is silenced so we can catch more potential issues in the
future.

Link: https://github.com/ClangBuiltLinux/linux/issues/778
Suggested-by: Michel Dänzer <michel@daenzer.net>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Round 3 :)

Previous threads/patches:

https://lore.kernel.org/lkml/20191123195321.41305-1-natechancellor@gmail.com/
https://lore.kernel.org/lkml/20200211050808.29463-1-natechancellor@gmail.com/

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 60c984e10c4a..47f4d8ab281e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1430,7 +1430,7 @@ static int eb_relocate_vma(struct i915_execbuffer *eb, struct i915_vma *vma)
 
 	urelocs = u64_to_user_ptr(entry->relocs_ptr);
 	remain = entry->relocation_count;
-	if (unlikely(remain > N_RELOC(ULONG_MAX)))
+	if (unlikely((unsigned long)remain > N_RELOC(ULONG_MAX)))
 		return -EINVAL;
 
 	/*
-- 
2.25.0

