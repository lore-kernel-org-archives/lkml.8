Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC763C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B78206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMm9H4kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgASNLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 08:11:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45929 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgASNLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 08:11:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so31057858ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 05:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xHIA7vcBxHwMAkwoOr5MVH09q2ANfVq6MDnOPA46wKA=;
        b=GMm9H4kh6lICMwcXLi3pCPmxoUAsI6XBUQGFk6hVmXJRjOUyeiol1Tl4cCOYOm+U/6
         Zz4hqRPBTXFqY8S9M7upFCsXnZZinp3pETKUIyqUJBWJ1pV9rQ/8iM0uqsifZDB9sbGV
         m6qeHNGv2xcFU27f1eqEkDfMH7gSHx328u/meYtzEXknRbGuY133xRl90BO5onPiNcLA
         BFgkKpJN8W8gJ2kbgW4VQvXjoy+IvvXyUKLobvOH9g6OZ4Up4ECMo7bAXHPCg2uqc/QH
         heuh3xuOqb30HD3TLU5hF0j9nDkao9jMEzuXu/zG3Jcep77vmsxNxlKUyZOTcrAv8uPy
         +vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xHIA7vcBxHwMAkwoOr5MVH09q2ANfVq6MDnOPA46wKA=;
        b=Ixwa4KF10jQXPtUXN0MvW0mHELwvxH3GLNRtLUv7ERiDwrrG4lRHY6U2KdEB1CWaHr
         wPfo45M43lJ/EAPebLm0Ei0Ph6oa60JT2BdHMm+nCAHswKfRKj3smcBSdmUj/HD7amym
         s2QgpmqMQ5604kokxQdcR09Vo8+pzO1cL7jUvnKY95fqHcDGhxDjcFNmyXnZdPMTT/3a
         VYLUo5OGMKTkQn+JsaIJOBD0ypibj8C2w1u4U8KUbtKeuwQelZPePFGoS9e3CGKUkmd9
         4NC9fFEBmchmQyquUQeYohopaaXN4yyi/8LpLox4jR7OJ1YDWIERfHjROgT/ckMCY6/x
         YHnA==
X-Gm-Message-State: APjAAAVkTwCzBbNHpbhpunypIW3LUsGI3TS8JJE/XphP6xHGliejnI5J
        kwm92JtgQB5231kUUK2Y955s7H7/OL8=
X-Google-Smtp-Source: APXvYqwZd4iDk6qeRz2ilmfbpzga5Cj7PJwS9TfHJLMB1Izkz+Ly4erVN4We8T/nhxG0zPpLk3vQxA==
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr11135376ljk.37.1579439459387;
        Sun, 19 Jan 2020 05:10:59 -0800 (PST)
Received: from localhost.localdomain (188.146.98.213.nat.umts.dynamic.t-mobile.pl. [188.146.98.213])
        by smtp.gmail.com with ESMTPSA id d11sm15217413lfj.3.2020.01.19.05.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 05:10:58 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Subject: [PATCH] arch/x86/mm/mpx.c: Clean up code by removing unnecessary assignment
Date:   Sun, 19 Jan 2020 14:09:33 +0100
Message-Id: <20200119130933.12228-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously variable 'ret' is assigned just before return instruction.
The variable is local so this assignment is useless
and therefore can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 arch/x86/mm/mpx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index 895fb7a9294d..30ab444301f5 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -827,10 +827,8 @@ static int try_unmap_single_bt(struct mm_struct *mm,
 	/*
 	 * No bounds table there, so nothing to unmap.
 	 */
-	if (ret == -ENOENT) {
-		ret = 0;
+	if (ret == -ENOENT)
 		return 0;
-	}
 	if (ret)
 		return ret;
 	/*
-- 
2.17.1

