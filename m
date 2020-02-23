Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82440C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B3020880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAq2e6gU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBWXTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:19:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50836 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBWXSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so7183571wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GI9BZY4TB2izB5xSJHviRhwOt5X6QjPfmN1xXuflLJ4=;
        b=jAq2e6gUTSO/pwZz6ieJWw4lhzNYyfJUj8KfnKG9aNKCuldz6MWz3vMlGQJgV80cjF
         hw/emXyUBckOUtc2erctMp06jVen6cWAM4CwRyTowUI18jJR8Yi2zSCA3Xq2BEgXsD8S
         h/+K7N946Wd+B8TZ5VBG2K6KHlJVH1RIUPaHedsFKrmx2CQfeL48D4nXvMM3yDDGpFCl
         g/I3eA7X9r0VcJjhQgkAFlZHHMO6qOX0KLbn2htsCB148BBBg6PoCIMmPBwZzYyJEFzZ
         lPCoyVVvjN8bOXiM09al6HUarREsYBFEa8vA9t+bMc4HjSudCo61VdlGVlSZHumUkV84
         stkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GI9BZY4TB2izB5xSJHviRhwOt5X6QjPfmN1xXuflLJ4=;
        b=dSPQ8RtgnqsBxRJxT/JqR8EgXVkyBWQIdls/ZeTwvd00eH/vGzZ9vL+gqdR4ek3XpB
         0EXsDoGMMl65STqIjI4v8b4Xx1J4i0VtL9dgHspSsU1fFB/2QpWpbKLSfNv5SolJlzTH
         EusmoUd+K+yW+BG5gxv6h+Hu/uFHBV7kASz4hd46HYuWAMGqNfDdFsSqClCdD/Mo8bDg
         v665EvLwgmHgRWJQg2Hu0VeHsukS0sfTJGpwRAi9Dn/WGURW/FGR95W5UpT3FF6y1Fpp
         sP9K6sLsSlH09vpPXAE0nCR2nPMkMmMwfI++KmElojJqEjf3Keid1vSu9Q4+K2hJ3TZg
         xQpQ==
X-Gm-Message-State: APjAAAXyXWEmiXghNQc6sql37KFZeIQO2YG9eDa+05rQnLv5pFpfj/RT
        reKui4VARigOFH1Mg8ACXtPmOophqSs7
X-Google-Smtp-Source: APXvYqzzs/Hk4vrDw7YzVbcCq9FgPGizU/92wgoZ0vUzId4d0EPpXK14pBK3QJEvGbbWjcK2nUaDjQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr17634168wmb.174.1582499897287;
        Sun, 23 Feb 2020 15:18:17 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:16 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR)
Subject: [PATCH 19/30] mm/zsmalloc: Add missing annotation for migrate_write_lock()
Date:   Sun, 23 Feb 2020 23:17:00 +0000
Message-Id: <20200223231711.157699-20-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at migrate_write_lock()
warning: context imbalance in migrate_write_lock() - wrong count at exit
The root cause is the missing annotation at migrate_write_lock()
Add the missing __acquires(&zspage->lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/zsmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 10a96651cb97..7ec69a1140cf 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1846,6 +1846,7 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 }
 
 static void migrate_write_lock(struct zspage *zspage)
+	__acquires(&zspage->lock)
 {
 	write_lock(&zspage->lock);
 }
-- 
2.24.1

