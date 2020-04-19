Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092FAC54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6DD2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEzYahmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDSSE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 14:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgDSSE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 14:04:58 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3D5C061A0C;
        Sun, 19 Apr 2020 11:04:58 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k9so6832302oia.8;
        Sun, 19 Apr 2020 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noeMRyfCXiVNDac4SbXL/yZSIwLo263SYX8F156uBM8=;
        b=SEzYahmb0dEcma2OmED8egn4Vohg7pDmFIUee7ZQrIQlW02yaKOWbIxgcoC5KEMJ+S
         NF/fjMNabSgVJUdeashBcatocSrjL2AcZJ9J70uIHB8NMSgZruXdL0tPzyU/ViP99UEU
         3pu+kGg0P+LKHM4QbWzx47aw+OUfp41ekptnWNIRmVbONkEwslKzGGxlK3CCMCeCZ2L9
         Y1XVUxp0pyFQ2F57IBLVzPoEtItWRkro6vYGZ7oqEV2pg7vUkErrz3WquoDedp4/34T+
         sL6aryysjx/Qau79gRfDG72wDkCznhSfAqd04ivixCFVFFB39WxjeoQ9BIQB2ay4Z3hn
         J+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noeMRyfCXiVNDac4SbXL/yZSIwLo263SYX8F156uBM8=;
        b=NYKkodjWbE0unKl98av/XmTLdz+u8EExveA/tYDZDjxoEjxgIAvBy5/5p3lLUb1qHQ
         uiLBdanEUplxoegxcBxburzH6XtzUlMNmO9p3poLVogLPbYfj5JX6iis4vHCJio7GB6s
         YRF8lghbTIqviXA5uVnQbTMFpUW35EBBr28KCVkq5tmil3+hwwCHHTzGRfwUQnrq7MZP
         vsu1416hHpdMGIkW3MRuWT/G2QNpE++b6UNhVLe90ORdtMBYcRoRayDI6LClHxM6taVD
         lqhyuXPkQugZtN4n9xEe02SrP4Z9e21lA78ikIbSAg40AWdAA5210z/Rc7GemGFeYC2T
         sXYA==
X-Gm-Message-State: AGi0PuZJhR5zYFCCdfvijRUSuV8lIVBSOmByaajpZeTx9Cyx9+JQTNj5
        uiVkdLjpZF2ulqV+sSsDd/g=
X-Google-Smtp-Source: APiQypJoH846YLVMv5jnqLShzu94g8oRiMnmBIkHXgUf9p88SARJoNlwf94kkTV7gsmszLFNA0sZ4w==
X-Received: by 2002:aca:d6c1:: with SMTP id n184mr8245343oig.126.1587319497584;
        Sun, 19 Apr 2020 11:04:57 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id t10sm3720075oou.38.2020.04.19.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 11:04:57 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 1/2] kbuild: add CONFIG_LD_IS_LLD
Date:   Sun, 19 Apr 2020 11:04:44 -0700
Message-Id: <20200419180445.26722-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

Similarly to the CC_IS_CLANG config, add LD_IS_LLD to avoid GNU ld
specific logic such as ld-version or ld-ifversion and gain the
ability to select potential features that depend on the linker at
configuration time such as LTO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[nc: Reword commit message]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Sami, please scream if you are unhappy with how I worded this commit.

 init/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 9e22ee8fbd75..c15ee42b8272 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -23,6 +23,9 @@ config LD_VERSION
 config CC_IS_CLANG
 	def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
 
+config LD_IS_LLD
+	def_bool $(success,$(LD) -v | head -n 1 | grep -q LLD)
+
 config CLANG_VERSION
 	int
 	default $(shell,$(srctree)/scripts/clang-version.sh $(CC))

base-commit: 50cc09c18985eacbbd666acfd7be2391394733f5
-- 
2.26.1

