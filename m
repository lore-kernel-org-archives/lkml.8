Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D9C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A9C2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj6xzOA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgFMP7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFMP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:01 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7DC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:01 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id f2so2542567ooo.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LuUknDN6PlR7Taqo1rpiAxQDtU4FT1BBR3mE8leDF4=;
        b=Zj6xzOA0oqxM88nnPyXjuB/7wtCHsIRcPDp1Nv1LqBinVeYmNo8n42XVMnHMIs/kZM
         JxEBW1c+jwAf1j0A4k6jKEn3CF/1u1dIXBJNiB18RpnNTI5Sr66qDxqjfOnCMV+OHgKv
         Rjfp1OsfWcpe6YE3fG4tq7WM295NtvjVcEl2GrAclLR7dT2URxxrH15Hc2imw5v+ial7
         4bRM0fCw6LRNbbbNrUfXgLEDJ+IzOQ6icz3hSwH9ok+TmPHLexuouf3Hc/MU8RC1+n62
         osIRDkQ2T9pr77lyWwRyIG17NS5o1w0Se1cuk0xaWavv5NLlRC6GAKN0lFtVDyLlfMmK
         iMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LuUknDN6PlR7Taqo1rpiAxQDtU4FT1BBR3mE8leDF4=;
        b=jYEDCa4dKjGRC2zto3jxtnf45QuL+/xxbGBsdCflg/Ruo9u/0TkHPf7oeteRYBJ9z7
         U/0as5zc3LIYcCnDW9xOBRsb4r8DaE7YjU4xUbvncvvW+NDHPLFBPYA/vd+Kqx1XMXs8
         eqB/ZHWuf3hrZtchSnRZ0UTNKkaLUE4gjaHtd51Mf/LT30X0XfQ9D4sM5rWSi2wGywOS
         /ZPMNH6rKhbEjnS2PzROly1snoSXGOW4C258UHVVkpZvoSeHHTSABA6bDWnVJogf51rr
         tJiVt0JdacZcSPfcuZgFZpPow5Zf6O9rHS+Ji103/Lrxcg9o0OxSluru76hAV1YPrz7j
         EwVQ==
X-Gm-Message-State: AOAM532NCOKJGAOaywtoJW0mkG9tXzJh0c+XYKlM3d5LrOcgijc4qpvH
        sZPLGxtLi7pJOd2HNqSVe5Q=
X-Google-Smtp-Source: ABdhPJx/AUXTkwW5plyM4ziMDBGHCr1i3spROwHN7jUvMZMPT4frEksBPLVnlRIq5KsaaJTM0JqS8g==
X-Received: by 2002:a4a:e496:: with SMTP id s22mr14976624oov.67.1592063880742;
        Sat, 13 Jun 2020 08:58:00 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:00 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 03/24] dyndbg: drop obsolete comment on ddebug_proc_open
Date:   Sat, 13 Jun 2020 09:57:17 -0600
Message-Id: <20200613155738.2249399-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4bad78c55002 ("lib/dynamic_debug.c: use seq_open_private() instead of seq_open()")'

The commit was one of a tree-wide set which replaced open-coded
boilerplate with a single tail-call.  It therefore obsoleted the
comment about that boilerplate, clean that up now.
---
 lib/dynamic_debug.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 321437bbf87d..2989a590ce9a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -853,13 +853,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 	.stop = ddebug_proc_stop
 };
 
-/*
- * File_ops->open method for <debugfs>/dynamic_debug/control.  Does
- * the seq_file setup dance, and also creates an iterator to walk the
- * _ddebugs.  Note that we create a seq_file always, even for O_WRONLY
- * files where it's not needed, as doing so simplifies the ->release
- * method.
- */
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
 	vpr_info("called\n");
-- 
2.26.2

