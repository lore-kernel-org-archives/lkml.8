Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A51C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B97220729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgG0XIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:08:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39324 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgG0XIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:08:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id w9so13584773qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1Rnn4vCkQ65/r9EgXb15c20xR4qwlNC9n/tWJktCdE=;
        b=pvL7VSHQrNo9T6TiP/O4AGm4GItnnWPXaqA3CnsABYt8+5+khr5IH/UelUWSAkXn0l
         PmNdsDoS1m+zMh3hFsenYPR2wjsYGnGg671ZqBTRgFAAbbloTCVq5KLZ4cCgoL6pdbHe
         9XXN2kYS9OqbVQDNX8HfixyWlRjLI73/Nw4RNJkBoUVSMEUlaOdZnnvQRzmZOIkTvUDF
         piupzSvyt+NBD7UJbWLgRfnGATNYVbDlEXV4zC+6UT1bM+AQdGyNuEDN05rfuxCAO1VB
         BR7wrL7pzwZycpzygoX/B2wAcZuhZdsE+Kss42LoJu/g/XhVQO33JgJfiE8VcBUQNEIQ
         t+DA==
X-Gm-Message-State: AOAM530HkjA/x7JDLcMfY+ePK5wqIGZvusIf4WNbqdRkxEH3ax8+m/Ae
        SiTUVi0p9MYyWzZfZu6CctjMpUJQ
X-Google-Smtp-Source: ABdhPJzLov2y7kpW3MsOIWujcojcoIAh0FzIIZNyngwsbbuKVHivngsLQ2rY+EjhxQhG7r0HpPXCVA==
X-Received: by 2002:aed:3081:: with SMTP id 1mr24609841qtf.118.1595891284479;
        Mon, 27 Jul 2020 16:08:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j61sm8216984qtd.52.2020.07.27.16.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:08:03 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] x86/kaslr: Remove bogus warning and unnecessary goto
Date:   Mon, 27 Jul 2020 19:07:55 -0400
Message-Id: <20200727230801.3468620-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the warning on seeing "--" in handle_mem_options. This will trigger
whenever one of the memory options is present in the command line
together with "--", but there's no problem if that is the case.

Replace goto with break.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index a4af89646094..21cd9e07f1f6 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -295,10 +295,8 @@ static void handle_mem_options(void)
 	while (*args) {
 		args = next_arg(args, &param, &val);
 		/* Stop at -- */
-		if (!val && strcmp(param, "--") == 0) {
-			warn("Only '--' specified in cmdline");
-			goto out;
-		}
+		if (!val && strcmp(param, "--") == 0)
+			break;
 
 		if (!strcmp(param, "memmap")) {
 			mem_avoid_memmap(PARSE_MEMMAP, val);
@@ -311,7 +309,7 @@ static void handle_mem_options(void)
 				continue;
 			mem_size = memparse(p, &p);
 			if (mem_size == 0)
-				goto out;
+				break;
 
 			mem_limit = mem_size;
 		} else if (!strcmp(param, "efi_fake_mem")) {
@@ -319,7 +317,6 @@ static void handle_mem_options(void)
 		}
 	}
 
-out:
 	free(tmp_cmdline);
 	return;
 }
-- 
2.26.2

