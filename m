Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4293BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F0C20789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy3dixhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgFMP65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgFMP6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:37 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F6C08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:37 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c194so11733728oig.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gl7hLsW2EEIyewv4iaFzOiTfdffkChsOHbVzBW70XfA=;
        b=Wy3dixhJ89xAKNIjKWVD+OtCnUJlAn3RBHZN6FaEQoefeCprrrwOmhffjl1eXRSz0j
         PxuvMV70CxX6J5k7ZkHAkm9OHoEYZn+zs5TElTIJAfS9kM0PKA41Ay3DRuKwgEnUXdH4
         D6IJeah6YLFs0rq1IEdTNIjvLt17jkuCz7d/QPEL2njkjsAyY6mWhnCAKlX5B+ukwZ1a
         GS9yjQxjb/+OxIDXdkiQxV7qvvPdFmw7+xQNY2nCMN+0OWw0dFHl1o21j6c3SatUnyAl
         80Ank5nuzYiVFlT8eqhnjD0M39Kl7UanOUE4g6d6RIH4Xx+GY4tvmXpPC0849dIg0gve
         XP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gl7hLsW2EEIyewv4iaFzOiTfdffkChsOHbVzBW70XfA=;
        b=Nqs1/NWZg1QcNHVudTmxCGROd5ikbyIOjzgNUCGTeq5bEI1BIo1BGFZIh43q16I8Hq
         cJWglQpaYbQyzth6h49dBpkKxlY4pmT/wRvNhOkA97jR+9i14mwWb++ukSTfsfoEWvWF
         05tjkBs1mVP/AbwCWopMyOaFzbLzoGi9OZnYc42QR9DRyynRpByetT3CkJfGPGumaoBC
         2obZ8hKeh6Y68caVzGW9OLN7GEy/q60dmC/4b/kKbedAuhTvDY2+FNN45HG3x28Tl0jP
         PJiTtk73ddHtle4ACIH3ohaJ7QRAq0l9VsJF+Ovm1bzxs5UZOhQDme5oxl2P+kAy1VZG
         5tnA==
X-Gm-Message-State: AOAM530sNrjy+hFHGpFW/00GZQeZJmEBYoK1yGp3+NO8jDZaF5LZNa57
        rvYxf6gC1MWRw42OybY/Gns=
X-Google-Smtp-Source: ABdhPJw1BonPv2EIVs8JMjp3GS/uzG6AO7n2GtFhzkIyeIRgymHKYVttJf4oNb0sMxGegKqWtpoB1Q==
X-Received: by 2002:a05:6808:7c8:: with SMTP id f8mr3075221oij.51.1592063916855;
        Sat, 13 Jun 2020 08:58:36 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 22/24] dyndbg: add print-class as trailing number to control output
Date:   Sat, 13 Jun 2020 09:57:36 -0600
Message-Id: <20200613155738.2249399-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds trailing 0 for all existing callsites, and N>0 for
any uses of pr_debug_n().

subsequent patches add pr_debug_n(1) & pr_debug_n(2) to kset-example,
demonstrating that the callsite descriptors are getting initialized
properly by the *_cl adaptations done previously.

bash-5.0# modprobe kset-example
bash-5.0# grep -v '0$' control
[  311.060809] dynamic_debug:ddebug_proc_open: called
samples/kobject/kset-example.c:80 [kset_example]foo_attr_store =_ "called" 2
samples/kobject/kset-example.c:59 [kset_example]foo_attr_show =_ "called" 1
---
 lib/dynamic_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0035218d7059..262a6a761219 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -919,7 +919,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
-			 "# filename:lineno [module]function flags format\n");
+			 "# filename:lineno [module]function flags format prcls\n");
 		return 0;
 	}
 
@@ -928,7 +928,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		   iter->table->mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
-	seq_puts(m, "\"\n");
+	seq_printf(m, "\" %d\n", dp->pr_class);
 
 	return 0;
 }
-- 
2.26.2

