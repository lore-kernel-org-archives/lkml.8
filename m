Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9069C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947BC2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1OVxmoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406635AbgFXUdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406608AbgFXUdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:33:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E5C061798
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j3so3539847yba.14
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vVvCAj3rXahkiTyB3fdf4JdbPFhKMTMNyBg/koJzOHM=;
        b=A1OVxmohREiIQE9uWobns3DZjU2BjnF5/uRv4vfcaF2sodOxkh4sxle+6JGl3ADtOZ
         3fmTbkzX8W7ahG1bTGpXMMU9CdKC8UZUye2VucpEx7325i3QESTUcI83ndSOc6E8Kmzu
         N5PlhLkCWO4j4sIvQEk9eacQtD+bX2UY3Y5a4I1dsdat2Jm3e0YTj4ppvoCyl2YlPdbY
         ZyEZAXO2uSqBN9R05BjPoqjam4RsnD1PfD+i8NAuT2L+OMarD3RxLispCXwkir37c5B5
         L+Lu+ZWTjo7NmJwPgVCLx0NgAf7Qq1Qws+DG9FZOXnsn8vOlmmibTipSbU4GNNmhC8bb
         0u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vVvCAj3rXahkiTyB3fdf4JdbPFhKMTMNyBg/koJzOHM=;
        b=mV5NhelQlSDKLBaF/Ncy0o3g0+MGdfrEG8AX/tW/1TEUXDK3B3KWl6rVrjQSQSlLcn
         YNi0cW0o1vGi4ATCd2srbCf3ah1iEXjPKbojXzw0tQ2TYW+DkyaGWuE9FRb8W+E79Miu
         2EJjA1djWBsAzaimmiJ41b8WDoxPHRWLoBAzoVmxwnpOuRZgkij3ioktNa3TG607yENv
         Zi5B2edJyUXwWa5m+LkId3JveqPW/5taIK3lDxdV1kIhxjNzjSNK2yvJwbOeWyVGb4Sg
         iFRAEWm7Mw7MWJJMbYRuQI6ON4D59pSnBuqFkfm0AWg+PjI8kWWISwivlKP0smkqUcRv
         2ZAg==
X-Gm-Message-State: AOAM531iuZmbbT/9XvfGH3p14EiIx18tOSP7rSksBK+Tf9Xxxs1ZpNhu
        HsyoKM7VfCrW/N/6qmUf9dEx95rR63uyiwatbDc=
X-Google-Smtp-Source: ABdhPJxFwd5sYHcpKP7HH5wq1l18/N0yS86uUmxUS0eTeAHpLUaXB5pBxjwc02CZmZmfKSgokc5xwqXiDOu/w8PP8nk=
X-Received: by 2002:a25:7450:: with SMTP id p77mr23380392ybc.155.1593030816256;
 Wed, 24 Jun 2020 13:33:36 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:59 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 21/22] x86, relocs: Ignore L4_PAGE_OFFSET relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L4_PAGE_OFFSET is a constant value, so don't warn about absolute
relocations.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188cbdae5..8f3bf34840ce 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -47,6 +47,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	[S_ABS] =
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
+	"L4_PAGE_OFFSET|"
 	"VDSO|"
 	"__crc_)",
 
-- 
2.27.0.212.ge8ba1cc988-goog

