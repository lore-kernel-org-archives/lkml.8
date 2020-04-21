Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB5C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE54520679
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3bGNHY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgDUSZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:25:05 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40024C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:25:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y21so12090953plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cnOWvAX0sep70p3VrDw18tfWn9QAG3e1hzHrT0Mjfi0=;
        b=b3bGNHY1zIe9xQGsKgZSTAcnhrb5+WunEBgEWGqAsZyaUwd4jy/Mmxhj7tjjVyEn7V
         4MLVxDhRQ3+KN4+FwAzezrv4SvuupGSfM6eMmTcoXNU8iMzul2TlhNYeQOBkIgtVPA5h
         H1SXPa3HXo/PKXK6UmcO9luQ2OUPT4+iRWPS7QLCZcVm7ZDHwZ7TlDnZIidBqLASoyrQ
         NftS9/zS80vqzPPy1oRixKDNGKP2LekKt2tuLu/XNYwb1OdXMT+CEOJuToi0Fxh6Gzhl
         8AWOAF8p5p+daH9E+tycsZxGAzZKNB8uJocYgxYxIMiHM0abtfS54aNRdI/SrBQTKtMS
         KYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cnOWvAX0sep70p3VrDw18tfWn9QAG3e1hzHrT0Mjfi0=;
        b=VnwvOYtGtogZAb4VjuU2EDVjfvSEmWWtd5/WCLxboigoPWcBhIw7UrKONvw2rklPaC
         /wvbot9uTwaihoZRQrwK+ai80bcm8nr+J5mX5ihIVUaHsy1CLnlXmPFFrLJjDdwgq81I
         gx0ohrfKh8Dsev99ULTwtBmucz3x7iEf83taU+DfyeMl3raq28N7ucPeuewBGahsXaOX
         8NT2CwyHLEKU7iJdVzSixTvXcqd7m5UUVgBZtaFT95El0Zh2/+z+e4izrFcCkpiera2f
         ObbB1nAF2XwZMC1UPnXOaczBoXxph+yH8tV5snVWXFVU/TM4K8d8UT0/mLdELOe9g0Td
         5xuQ==
X-Gm-Message-State: AGi0PuY2HDa1HItgpabjC6kpcJA+zoTExjgCG1GfWu2e4aZGJsf1YU8m
        y1iPv3ZZqJfIfLjtUAmkqdfiSvn3a575G2ssOeY=
X-Google-Smtp-Source: APiQypIFYdhUnOyvNiyOGXisCNwmVKjSimXutUVDGAOSp6Rqb0btIC/u9PCidSL1eYQjKd8ovBL6NxbsXQGy9twUZKo=
X-Received: by 2002:a17:90a:9908:: with SMTP id b8mr7023722pjp.67.1587493504821;
 Tue, 21 Apr 2020 11:25:04 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:25:01 -0700
Message-Id: <20200421182501.149101-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] objtool: use sh_info to find the base for .rela sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ELF doesn't require .rela section names to match the base section. Use
the section index in sh_info to find the section instead of looking it
up by name.

LLD, for example, generates a .rela section that doesn't match the base
section name when we merge sections in a linker script for a binary
compiled with -ffunction-sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 09ddc8f1def3..73cfe45975c8 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -468,7 +468,7 @@ static int read_relas(struct elf *elf)
 		if (sec->sh.sh_type != SHT_RELA)
 			continue;
 
-		sec->base = find_section_by_name(elf, sec->name + 5);
+		sec->base = find_section_by_index(elf, sec->sh.sh_info);
 		if (!sec->base) {
 			WARN("can't find base section for rela section %s",
 			     sec->name);

base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.26.1.301.g55bc3eb7cb9-goog

