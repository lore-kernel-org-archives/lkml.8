Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF05C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CE220767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hd+JD6CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgFVUyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVUxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:53:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B0BC061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:53:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so8096627plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0f9fJa8OA2NYK/yNB2OP/HZmbwcQdR1u3azDKPTOctw=;
        b=Hd+JD6CBzuK2BqDJ7ALVYyglKxpkRCQl/0Pa2q6BAjhgJ3NHdrXKo6F4eQ6/jyDStH
         FIVqU3u47cOdbudkrx208IcOhncwoGH1jnGAJADb0o2PduIem6t5sPc9hr2tyZhQYq1l
         95xaMVXc58L8xguf+zEj8rW6zjssA+PybgqA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0f9fJa8OA2NYK/yNB2OP/HZmbwcQdR1u3azDKPTOctw=;
        b=MnfmAXPmRsRc9CNlr8uWoGbOvzDIYk0/D6e32+XAXHBxbfxW9l2eTBqswIoDIN3Buq
         r3RIgxpesUW1COoT57j6Ly41+Kc8pA6hROclkUhzGUE8SDhTeuVz8H7k6XPsr2/7R7Q4
         qio4XGjfaq5WAj8a1kiaMmbb6v1qjiqydC5nlJYnr+FNwCIf949xGI4OflsfLehH8jPj
         O0XKKy7aQD1Po+sk6aOtp6VN0KD0ySARlSO0ABKube4JX0lJWQeWjy5DKpbGdaFsL56l
         bEKqrH9+eD5HnI+5M9lUJO0CH2MZCfKI00YYbx6wPnB8fKtSl3/Vx21KZB8MJ4gxTLAW
         lyTA==
X-Gm-Message-State: AOAM532ZZIdnuGdu0xJnmMb5K2WXf1eUcs5hUnrHIlszO7FGf5nH/XVc
        C9EMGmvh+HJaIsCvu4WL/HW7kQ==
X-Google-Smtp-Source: ABdhPJwDyDpJoERWXvnmPuVM21tZ6v5TTnDZi7kCn7EzQhXmCI8+YdMStbWxb/4Hf75B75ybRmVdhw==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr21722171plz.145.1592859227557;
        Mon, 22 Jun 2020 13:53:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1sm13934721pfo.197.2020.06.22.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:53:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date:   Mon, 22 Jun 2020 13:53:39 -0700
Message-Id: <20200622205341.2987797-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622205341.2987797-1-keescook@chromium.org>
References: <20200622205341.2987797-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* section,
so remove it via the common DISCARDS macro in preparation for adding
--orphan-handling=warn more widely.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..6fbe9ed10cdb 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -934,6 +934,7 @@
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
+	*(.gnu.version*)						\
 	}
 
 /**
-- 
2.25.1

