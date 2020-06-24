Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8781FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681AB2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xm0pw21C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391465AbgFXUc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391451AbgFXUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:32:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754FC061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:32:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c3so3488653ybi.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xQdUf2OUslJj5DjDkMf3WWk6yA/Z9kKXMPQTw/J6IlI=;
        b=Xm0pw21CFWwXKUCWT9uv8sjRFTZSZ2FxFwksg6PZZFhaViOtrXe11fAV4rmUtsA/iD
         yw79dp1HbVFKYB9IyYfau+MusfZUyo7hsiV4z3U+B+VERxLsAmDLIOjA6ZbmwYQrk90b
         ude2AkBLX9/aWcsdUn0At059rWaNafFELeyyTNpWfaIPQWe975NuzYbO2Y2+sB6z99TZ
         DkeatZZ3I3Kg3WrJcfsykfzzNiGAFFIiaZ9KHBKGVzxxZKDwbNS3dVYdRS4I3s6IiWF7
         F9FQwIOY90ZeHvihhQegbpcF6vQYY7VW45ZJstmN7BQcaqrs2XDnMXsRYKvPnePBoQiK
         Uk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xQdUf2OUslJj5DjDkMf3WWk6yA/Z9kKXMPQTw/J6IlI=;
        b=LSnK56oywgWg1t1z9cTJs1Zr6Ls2ya51bBGsi7zMLvlrNDCruirabo+jmQppOwO0w/
         ccPJhkMstGx2XICd1mWA8pzwMxVbXgsgyw/EsyQSe0DaVWqhw8GgBjIjfkHJBa8TsXEl
         VNYeMnjU7sN+WC+GC4A5QKL5yI/vMoMJY6/WkaZHdmrz/amnU8d/0o+yebJHM559rXEw
         cazvQNkz1K4ErjENl2c4wVyPT029O4ZQVo1he+/TNQlLyuSf5uysYf/dIHCTKMoyrfu0
         Ei5/9JP8Om/KPq9v6NiqrXDSLOB2ftLM/HqBGcXdGHtrHKdPf0HdE2cHw9Fkv9LC5vlh
         yQpw==
X-Gm-Message-State: AOAM530sb8aVLTyzM910UU2KwP85aqIZYpC3ld68u2dEHI2FZl5XIrNU
        /JnehC2B0ctwGaIYsdVb1+7tEMkZv8yARPB+RIM=
X-Google-Smtp-Source: ABdhPJyaNd4T7jCJ2XxtqDk7As6bELzRlErz6uaK57hfCOoUmajW51Nj+2rWe6ZzApbtPE/D/8XgpW5QlQwx29+bABU=
X-Received: by 2002:a25:4cca:: with SMTP id z193mr43175648yba.510.1593030771779;
 Wed, 24 Jun 2020 13:32:51 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:39 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 01/22] objtool: use sh_info to find the base for .rela sections
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
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 84225679f96d..c1ba92abaa03 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -502,7 +502,7 @@ static int read_relas(struct elf *elf)
 		if (sec->sh.sh_type != SHT_RELA)
 			continue;
 
-		sec->base = find_section_by_name(elf, sec->name + 5);
+		sec->base = find_section_by_index(elf, sec->sh.sh_info);
 		if (!sec->base) {
 			WARN("can't find base section for rela section %s",
 			     sec->name);
-- 
2.27.0.212.ge8ba1cc988-goog

