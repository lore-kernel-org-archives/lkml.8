Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03292C3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D232524656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBwXIcH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgBSEyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:54:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34149 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgBSEyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:54:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so21947187otl.1;
        Tue, 18 Feb 2020 20:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oh9QWb6pZZ5g69dU4FZ2txutGr0B2CSvIaPTiYXdnPo=;
        b=WBwXIcH52wj5UStzSlDaw2Ph8pzj/CYP3JRSbf54GZh79pza3d3RsxczDsukrXWSZ7
         86khT4brEkZbiwPESK+rtMahwlr7gE+9fQ0NRJakjryJkgDvh9ACjcNovCc0J9Sy5zll
         88LmmWVIvK2n273H7MJxpeDiBFbG2x5vk5wpwRXdCTotbpecqAQ1qdXfoQlb9uRU2yC6
         AvaBlQeWFdJnomzIM4hTbQfiEfCtrzQIMaRLgjQ8s6iN9JZCPEhU2N1slMVrr1UU1AB5
         El1e5Hnaz3m5KCaZqWo0pgU+ojOgoCdxbASQRLncZppeIXyvOm7iU+Zj2f6dMYh6cEHr
         9hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oh9QWb6pZZ5g69dU4FZ2txutGr0B2CSvIaPTiYXdnPo=;
        b=eEr7zdgp6grefX5RYr/3Cui9Kl+NUVu3sZWaKBycnKi8Rbwr6Q+Efghw749+QO/NqJ
         KjvY18nlFgP5TmLM05+e2VPv+8l9OwNH03QeZa1frxuTgXKureVewbSHUMPy2NL6mxwz
         C5yhHDHc+vpVNUqItf56O0gJWmuj0cQTuyQ5R4nc++OszPgq3QnWFB28oWfLHSEWSx7E
         VXbhYjaJdOviA2gzg3REpWHxFPDN6e6gyF6U4LQbKZ2ECgRDhiYA9+z31IufOf4miljW
         U7xyixRkerVWtanCBtjL7+jggyo19ULYHGZnqTBrOwGXp/vZejE/D1Q+vUVls+XRu6rS
         wNSQ==
X-Gm-Message-State: APjAAAUPzO6wXMt4JF17kaA/7ieWJZHPC5pfddLM6wXa9yenz1mGZplb
        K7Te3cOyx6v/L1dK06aYgxs=
X-Google-Smtp-Source: APXvYqxJRG2OQXc05asgj7HXthiAW2UIejHZq7541ZiIpdLqpMSEi/rSorSHXLJ0a/aaTltGwjj13Q==
X-Received: by 2002:a05:6830:1d91:: with SMTP id y17mr17502659oti.276.1582088077039;
        Tue, 18 Feb 2020 20:54:37 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c7sm288894otn.81.2020.02.18.20.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:54:36 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 6/6] kbuild: Enable -Wtautological-compare
Date:   Tue, 18 Feb 2020 21:54:23 -0700
Message-Id: <20200219045423.54190-7-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200219045423.54190-1-natechancellor@gmail.com>
References: <20200219045423.54190-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we disable -Wtautological-compare, which in turn disables a
bunch of more specific tautological comparison warnings that are useful
for the kernel (see clang's documentation below). Now that all of the
major/noisy warnings have been fixed, enable -Wtautological-compare so
that more issues can be caught at build time.

-Wtautological-constant-out-of-range-compare is kept disabled because
there are places in the kernel where a constant or variable size can
change based on the kernel configuration; these are not fixed in a
clean/concise way and they are almost always harmless so this one
subwarning is kept disabled.

Link: https://github.com/ClangBuiltLinux/linux/issues/488
Link: http://releases.llvm.org/9.0.0/tools/clang/docs/DiagnosticsReference.html#wtautological-compare
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b954c304c479..99080c57a1cb 100644
--- a/Makefile
+++ b/Makefile
@@ -742,8 +742,7 @@ ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
 KBUILD_CFLAGS += -Wno-format-invalid-specifier
 KBUILD_CFLAGS += -Wno-gnu
-# Quiet clang warning: comparison of unsigned expression < 0 is always false
-KBUILD_CFLAGS += -Wno-tautological-compare
+KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
 # source of a reference will be _MergedGlobals and not on of the whitelisted names.
 # See modpost pattern 2
-- 
2.25.1

