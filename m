Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F19C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D97020814
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4N7mbnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgEUWZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgEUWZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:25:57 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C437DC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:25:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z1so8641783qvd.23
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IcMIWpTIuJhOXe3roKCgk3KWh3umIrVN5sjlOXmENmE=;
        b=n4N7mbnzd+X7RmLijocF1fab6W7WtoTITGMbGY3Qfn/byG9EcJvqHVnka2hmpyYVFs
         rrHb82CqiSaztzWuWl0w7CIIP8DtJXCCjTxqcM3hq5jGM3rBWTv5rANe3FfJKLNYxwot
         7eDFZbmuU2AtPzrRNgSiW0T2vIRfOnzNVfzTu4qo4fekYNBE/X9INuOeJb9+AeMBy6YY
         nvB4yQSetAr+59/y4rOaLDupbgJosev9HUrAX1n04wBq7Ubd7S309nMztfO9TSkHpmqO
         dQ82SxMi/0nL3nX6HoqKVmKBkqDmSlVI0Ny3VKBsV0YmRdXAIeC3EFMOMwKMf/5Y7ogg
         Ry+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IcMIWpTIuJhOXe3roKCgk3KWh3umIrVN5sjlOXmENmE=;
        b=L/nh+fX89v2u3zrpswhOBSCV5Gq4L/zbwmUAH1nHmuh2tuwBJZoWh4C/tGwrI4cbly
         ooI8WMWl3raIgZm/9VsnT0fWUUkV/OC8hm4wK7OBKpp+lT9cfPZFt86+8xmN37TtiCXj
         +k4egXmw2dmwWOqdYeCwDCktTQp5c+hCKI2eKjbSAIXxy6DaMxwPmj3+OflMGSXpZtj8
         gHo86IIs9Q3SBNf7fTyyj3NVo3ykwuhwEVgVz2DRR+5RwM/myERFNQMf7XBixziDemLW
         SAseySxMSk5ID2ohNxAUssdn5UMpZDmOble0ax6MG6FXUdA0urts6xng26iu25rLN0nW
         1FsQ==
X-Gm-Message-State: AOAM5311N/sDBArs7dGNU13/Nz6bMzsLwI+MY5EyZcQynIIUJK6ZEHhZ
        HSa5dY5b+SbqBtzl4fCO/X5guMbLeNtB
X-Google-Smtp-Source: ABdhPJy7zMpHMw3vtshTDzUFBDK8SKAjdIyya1+LREbYnNfVWw7HiFYhgZ5eGU1W+DninwgUHDkpcJ8rEx/b
X-Received: by 2002:ad4:43e3:: with SMTP id f3mr908752qvu.115.1590099955922;
 Thu, 21 May 2020 15:25:55 -0700 (PDT)
Date:   Thu, 21 May 2020 15:25:51 -0700
Message-Id: <20200521222551.259804-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] proc.5: add "wf" to VmFlags in /proc/[pid]/smaps
From:   Ian Rogers <irogers@google.com>
To:     Rik van Riel <riel@redhat.com>, mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, nilal@redhat.com,
        Florian Weimer <fweimer@redhat.com>,
        "=?UTF-8?q?Colm=20MacC=C3=A1rtaigh?=" <colm@allcosts.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents a flag added in the following kernel commit:

commit d2cd9ede6e193dd7d88b6d27399e96229a551b19
Author: Rik van Riel <riel@redhat.com>
Date:   Wed Sep 6 16:25:15 2017 -0700

    mm,fork: introduce MADV_WIPEONFORK

This was already documented in man2/madvise.2 in the commit:

commit c0c4f6c29c494c466f3a2a6273c5b55b76a72927
Author: Rik van Riel <riel@redhat.com>
Date:   Tue Sep 19 20:32:00 2017 +0200

    madvise.2: Document MADV_WIPEONFORK and MADV_KEEPONFORK

Signed-off-by: Ian Rogers <irogers@google.com>
---
 man5/proc.5 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/man5/proc.5 b/man5/proc.5
index 46d603f28..3e5b91af0 100644
--- a/man5/proc.5
+++ b/man5/proc.5
@@ -2020,6 +2020,7 @@ encoded using the following two-letter codes:
     ht  - area uses huge tlb pages
     nl  - non-linear mapping
     ar  - architecture specific flag
+    wf  - wipe on fork
     dd  - do not include area into core dump
     sd  - soft-dirty flag
     mm  - mixed map area
-- 
2.27.0.rc0.183.gde8f92d652-goog

