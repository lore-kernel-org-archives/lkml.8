Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F3C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BD72082E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkGmaN7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBIWsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:48:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37227 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBIWsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:48:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so5261160wru.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5h8f3WgoxP68Q6jLjqnQAtMRjQkjB73Uemeu2QcLQ8=;
        b=EkGmaN7Hdx2AlLEaPXhlhQGpfOEm+tHRBC/MIcGo5vf6FsWUktGo0FD0AviDcjdToY
         MbxjHvGKJSALR8264JXx5D9gmG8VvRL5LvPbc1wQKxK4TUE+lKnqXgaMCC1CoE0DF9v9
         +guEHtFifFdPN9cRUFrwzo1IyNhnejLmnBCD5yDEKWcnhPOwjtgdbl9h/h+KIzDwXtwV
         Q3DSNJCoblTbQA4WGLzSthx6bhNzdpYNVCenOwUTwGOuX8t3wcLEsDKp26RzjZlcJmLH
         iVIePJDgrWXk3IeRfB0ZvskyL3Pmfcli/ZUAGXBRvkmhrkG/q7EOO4VE8YSkTrTQ6aku
         t+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5h8f3WgoxP68Q6jLjqnQAtMRjQkjB73Uemeu2QcLQ8=;
        b=R9mp9V9czmT0pYE8oAT3FOkqEWSegFXY+Aq3nIFngYGGSlX77D7vHKaJrQ4oYd5Vu4
         mUAUImkeuPM2665buajUZXAOruuVYyr2ibMqCdlxDBTWbvuAq6v1TKmhIBWxxF6/9Sfu
         JdI7WzRkgOrRoAr4lx2Fz3l3hOJxiTvSl2UqqK0KzEwBqN4iR3l18LcfvFN245EGmPqY
         ti8GaQ4hI7ltyFFj6RsE28JJFrcKgA78Y+fCf71wElTneWFg8onmgA1WQb5UNl38XtZi
         9DGJ1sItwd99W+WocA5ss1ATyi6IGChIFF45tv60bMHfs/4v7oyAcn2XbFpd24jlgvW4
         vCrg==
X-Gm-Message-State: APjAAAWl418ue0gPwXfT7ImdSU+0VCj9q8BgbrTV97fzwqgxdb/+NcZe
        E88qWZ4PtcNMe6AmtU8lNg==
X-Google-Smtp-Source: APXvYqzPnz2CPIG4fKhNxRmelMYzQbiLmYpx3/e93ZBy+WFI67OYTVo119MdAJS3TtEK6WC/eYc89w==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr13257456wrs.143.1581288497124;
        Sun, 09 Feb 2020 14:48:17 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id p15sm12708938wma.40.2020.02.09.14.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:48:16 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, akpm@linux-foundation.org,
        dvyukov@google.com, glider@google.com, aryabinin@virtuozzo.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 09/11] kasan: add missing annotation for start_report()
Date:   Sun,  9 Feb 2020 22:48:07 +0000
Message-Id: <1eca01a2537e0500f4f31c335edfecf0a10bd294.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at start_report()

warning: context imbalance in start_report() - wrong count at exit

The root cause is a missing annotation at start_report()

Add the missing annotation __acquires(&report_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5ef9f24f566b..5451624c4e09 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -77,7 +77,7 @@ static void print_error_description(struct kasan_access_info *info)
 
 static DEFINE_SPINLOCK(report_lock);
 
-static void start_report(unsigned long *flags)
+static void start_report(unsigned long *flags) __acquires(&report_lock)
 {
 	/*
 	 * Make sure we don't end up in loop.
-- 
2.24.1

