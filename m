Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3023CC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA3820792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbGLGj6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgG0EI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 00:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0EI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 00:08:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13AEC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 21:08:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t6so7324957plo.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 21:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYT2Ny6spUa2d7WV446ZRztHW5dEHODP+nX8cO1zDks=;
        b=DbGLGj6l0HNYMZayqWr91tqOpFYAG6FSJZULt2ClFy36VPmCsTrmBcyDw5gMg9RLuZ
         g2vnd9mZuTVzMT+jTqZyuG2WCeT3xjQXqCDLRLGKXW8TTVJ2WpuidmBQv46eKqiCFZiu
         nDc+cPCv8TWKtPUhhDBgDUwfiGNkPvQgWHRia/mIt7frj526dzEKDCzAedYZWwcePqOV
         pbr2ZHvUdig23ul4bLuruBFRcAfI3V30/J6RbJXsUO+1thS5oowqD3b7Hh+TZurA9veP
         78qt59s+p+py8QZ07gpnePUy0/Qq5sN+5/ZsTmEhIhZGiMUHZQKJ1si/k5fe67dQO/gw
         CKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYT2Ny6spUa2d7WV446ZRztHW5dEHODP+nX8cO1zDks=;
        b=uFnewsGuHIRlzsIkoKmeH24bQ/K0pwGrWjeWXZhgzkR+kjU4hXFTfB19b/+KNKtgw8
         Hea69982wgKhpSnQb360eA5QiD8neilFxbETsljaMVDoqxETkuJWjoW00viju9NFo8Zl
         dB9GTyLnZGmFEGugBNTlKnF+PZa8BGaRuB/g8Ge8lm0zq6jKhBIACEVTROukHx98TRBK
         eGunSo5Jf9b0X/0kusNnQWZ/qGm8zMj73jV7i6Kh8SmI2wClyxQ3fSi+PARUDFLG1RHz
         UnC1ZBnqhws77juBb9eE4iij6106rgBxCATAG00U+mK+PbBrUW6hLFhDqb540ZfRsKDR
         C8Mg==
X-Gm-Message-State: AOAM532vpjUi7VusMr5Alpr+kWpm76Zs61mFKlKrw4Vd4UJmXwENn30Q
        QiOQ05x6L8ghaWBeW/DLdcdDIMt4Eak+7g==
X-Google-Smtp-Source: ABdhPJyRrQq27lPR1bCdVC+pgIgpPTcMqVHsrJ/2eSSPzZiFhrxv77DHWGZ4KTShHloN7kSeAGYg6A==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr17042568pjj.28.1595822906118;
        Sun, 26 Jul 2020 21:08:26 -0700 (PDT)
Received: from glados.lan ([2601:647:4c01:6541:fa16:54ff:fed1:1bd6])
        by smtp.gmail.com with ESMTPSA id e129sm6542501pfe.94.2020.07.26.21.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 21:08:25 -0700 (PDT)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <James.Clark@arm.com>
Subject: [PATCH 3/3] libsubcmd: Get rid of useless conditional assignments
Date:   Sun, 26 Jul 2020 21:08:16 -0700
Message-Id: <1f8ccfa329a210e2d58608b62c7f731de9fa60c2.1595822871.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <0a6e69d1736b0fa231a648f50b0cce5d8a6734ef.1595822871.git.tommyhebb@gmail.com>
References: <0a6e69d1736b0fa231a648f50b0cce5d8a6734ef.1595822871.git.tommyhebb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conditional assignment does not work properly for variables that Make
implicitly sets, among which are CC and AR. To quote
tools/scripts/Makefile.include, which handles this properly:

  # Makefiles suck: This macro sets a default value of $(2) for the
  # variable named by $(1), unless the variable has been set by
  # environment or command line. This is necessary for CC and AR
  # because make sets default values, so the simpler ?= approach
  # won't work as expected.

In other words, the conditional assignments will not run even if the
variables are not overridden in the environment; Make will set CC and AR
to default values when it starts[1], meaning they're not empty by the
time the conditional assignments are evaluated.

Since the assignments never run, we can just get rid of them. CC and AR
are already set properly by Makefile.include using the macro mentioned
in the quote above. In addition, we can get rid of the LD assignment,
because it's also set by Makefile.include.

[1] https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---

 tools/lib/subcmd/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 1c777a72bb39..5f2058a6a1ce 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-LD ?= $(CROSS_COMPILE)ld
-AR ?= $(CROSS_COMPILE)ar
-
 RM = rm -f
 
 MAKEFLAGS += --no-print-directory
-- 
2.27.0

