Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397D3C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 06:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036EB206A3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 06:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBoxCyyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDDGBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 02:01:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37956 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgDDGBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 02:01:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id c21so4731644pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 23:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oG21IWxF/admIV9XheyanlxC7Api1UGcfx99b/IxXf4=;
        b=RBoxCyyx5PaP/hm3fxv/oXDtR9089AFmXU2RchLbcoBr/fBLdV5LNzoyPzUvuNX2sF
         hwyBtf27DgTduH+edBK4DeiGWYjyTsXdgXWEP8ADS1ng64laIxTo+EsYsS/zkz0+ilI2
         UO0XwZW3NrBUpNpVb0Sg4bzQKLUIYsTpdPqM1kMPTA4mZsTL1p/v57r+u8kQvx+oGpZz
         +G+1J19/XqXjxdGIupNLKDrg1Ma8vDokWwcOa1tPG1J6yh+Y3Gom/BoXhMcgVA1p00Z5
         OuTbD9HZ/sPJ+uia/vZuxf7GQ6VFApKgpFcOFpkgoczx9OO96+/2GzpiLNbPi/q3nA/V
         i7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oG21IWxF/admIV9XheyanlxC7Api1UGcfx99b/IxXf4=;
        b=A0n/z3pbaJ+ZcYo6JlE94gXHsnCxkEWpQg4365ih5ysANMrZhBhaJhkD3Pyc5hMdvO
         D1SZPAgU507UlUA9AA/nO8WEioDbGUy7xyun17wCKDv1OJXsNCt/j+8UwVJEnoHMY+mX
         NUsJgSWJ3KpGJZHK58vZo7nobAdCitsvLnRk1gXFed8qPEHKmhR6jFONvyxJGXvFXxEF
         TA/C5vzAtYXzuwcamVB4kwdEknJ3gKvYMvdlJ/IrnCwkoTJYMcvtZ1dub814aWlSsVRH
         ricA6mFTdRx6jsYVrq+CSjqY0BIQ8FF/o7gcCnfl04L6G4xEMIDJo4A4N4Dx7d9Gq1Gc
         ky5w==
X-Gm-Message-State: AGi0PubiL8aRjifc21kSIrZlMbAZKtcZJzRZ/Zm5k4h99wwnXqwTw41f
        1g7cdG6vI29AsvwFHZqVIAk=
X-Google-Smtp-Source: APiQypIKh+/En219vNNNq7J28XjQeMUj70c9mPZ6BgWOEzSyh3+Y7u6ey+aPWrZNc0TmAmajZ0LcqQ==
X-Received: by 2002:a62:e307:: with SMTP id g7mr11331286pfh.197.1585980104062;
        Fri, 03 Apr 2020 23:01:44 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id o29sm7074326pfp.208.2020.04.03.23.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 23:01:43 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] mm/vmalloc: Fix a typo in comment
Date:   Sat,  4 Apr 2020 14:01:36 +0800
Message-Id: <20200404060136.10838-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in comment, fix it.
"exeeds" -> "exceeds"

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1f46c3b86f9f..7d90159e84ba 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3365,7 +3365,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 			goto overflow;
 
 		/*
-		 * If required width exeeds current VA block, move
+		 * If required width exceeds current VA block, move
 		 * base downwards and then recheck.
 		 */
 		if (base + end > va->va_end) {
-- 
2.17.1

