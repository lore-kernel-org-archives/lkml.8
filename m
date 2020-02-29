Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B69FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C5A2468E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qafUWy3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgB2Q0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:26:24 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:44780 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgB2Q0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:26:24 -0500
Received: by mail-wr1-f73.google.com with SMTP id u18so3032100wrn.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 08:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8BHXIrZSo7ztwvDixAus2JEWbAlyG62J4LvSOy7NOlw=;
        b=qafUWy3q/1azkDlmbfWYWObCnOL4k2oL8OWI9/bFjri3ropOCRD3HCjzXYb0gU+Zgd
         nrhUc8WdAdlO+1lF3lwHymlT6ej/pMR1ylxmNyFTWnahfltWmtlwg/gWmKgX6OeYB7wU
         F8wJb8cE/BX2O19BLOfCKgz/52OlHXRFJBhbVsIcOEfCrFJ7gxV2gNOg0bZDy8dCgP6s
         IVeAANhjUub6Qp9hwis0Iz7hE7oLE8s6Hx0aS7+Sit67j7DbPjmWOq7zwHnKtllywG+m
         4eT/OYKF6vYFDm/lj/acKx3CFL8y74Q+AUhnCqMPeIRfcQmGqLIAqy5sCnOTWa6GUBUO
         Ka2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8BHXIrZSo7ztwvDixAus2JEWbAlyG62J4LvSOy7NOlw=;
        b=m+k88O1lcAjqlRFhegsNmtkdttbw5q1ciJ68664LXZx6lHbd/GufD2bvd5bpChCZni
         kQv/dHbPwBbyNFbAB2dbfN7aX+9ZaK7uCqiLlnVfrYMbMe+yYRIred1heaI/W9w2iFZH
         qm/hXjpYpg0XNeIiSKPhRk71EkoomNbhezCvkQXm8f2BYvJ/GX/Oj/IRBcnlCIxZuRl3
         ex2fFdsAFiBPj1rSNTxhGt1BKpEUuQVRl+9UZ2jiiQv81scbU78/BUj5f2aj5DiZTanN
         vN5WylBzMnHysXUHZJNWWCEHpSGMDBj9WFyp/RxMMRK7RDQmgO047/g52Q8cLmPVG+Zy
         FUIw==
X-Gm-Message-State: APjAAAUCSX1gi++lZmZs9edNleZeVRI5gz5R+hvex+7LiX2STBYexD7F
        7lOLorB1aExOsRZoWKKIJp8LPVF1vw==
X-Google-Smtp-Source: APXvYqz5zp3w/yIYkoRFmWDN6+R/VNNJ6KBztADaNjM2Md9pBxdoFrUExKKcmUSlpX99QxDIj9Fa04QCXw==
X-Received: by 2002:adf:d4d2:: with SMTP id w18mr11942681wrk.180.1582993582002;
 Sat, 29 Feb 2020 08:26:22 -0800 (PST)
Date:   Sat, 29 Feb 2020 17:26:07 +0100
Message-Id: <20200229162607.6000-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] tools: Fix realloc() use in fdarray__grow()
From:   Jann Horn <jannh@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If `entries != NULL`, then `fda->entries` has been freed, so whatever
happens afterwards, we must store `entries` in `fda->entries`.
If we bail out at the second realloc(), the new allocation will be bigger
than what fda->nr_alloc says, but that's fine.

Fixes: 2171a9256862 ("tools lib fd array: Allow associating an integer cookie with each entry")
Signed-off-by: Jann Horn <jannh@google.com>
---
To the maintainer:
I'm not sure about the etiquette for using CC stable in
patches for somewhat theoretical issues in userland tools;
feel free to tack a CC stable onto this if you think it
should go into stable.

 tools/lib/api/fd/array.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 58d44d5eee31..acf8eca1a94a 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -27,15 +27,13 @@ int fdarray__grow(struct fdarray *fda, int nr)
 
 	if (entries == NULL)
 		return -ENOMEM;
+	fda->entries = entries;
 
 	priv = realloc(fda->priv, psize);
-	if (priv == NULL) {
-		free(entries);
+	if (priv == NULL)
 		return -ENOMEM;
-	}
 
 	fda->nr_alloc = nr_alloc;
-	fda->entries  = entries;
 	fda->priv     = priv;
 	return 0;
 }
-- 
2.25.0

