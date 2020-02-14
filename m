Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A63C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72584222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKGBSiQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388492AbgBNUsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45145 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388190AbgBNUss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so12445969wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IcVuUFOrbU5qrSSwM+6v1NJbX6QBWvay8FGpA9hv2wU=;
        b=tKGBSiQ3V94vVSE+cGOOlyWiVdOcbYhQZ0GOAed3OcOTvsew34Q7GXIPBjzwZyZRN8
         0bgwy+rzDdi+abqHIIm2EtF7DB10yBC0wTsS9NndCFW4nXe9/E1VJZa4LmjlG+cyS54a
         Z8mTdoLOXZINn0L2TZ0v1KOr91DPgtm9D3UubCmnz+861/fLAu/SW5VD3D6atkg8cXRC
         DzkAx/y3KRltRlO/WUeH2sFyoLWSIsDHjVkS/VTFKJ06ZZIOMvp7jf9msQESjnztvMeE
         e8bqEQoxIx+hp3filCLsAHKbJz9YfQmWo7Xys8KIejrr0XlZbcZvVLfWrLHbE8QUc7pf
         9waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcVuUFOrbU5qrSSwM+6v1NJbX6QBWvay8FGpA9hv2wU=;
        b=pAV9RCJtJp3TNuQOwkT0HfcHTE1MjO8K6OCps61S24QyVCWKsSatKGs33PlNG8vsqX
         hZyyLTL0F9if6RMUNzUprS3PCfnI2vWtVTB+NCFXls0HXhMQRkRARsgA5Iuykbj+0FpB
         Y+ke5io41h4xR43xpsZFwmRcPdn3i6SjGWAdQJlT3hEELBIbrrp7DpvP5R4ivYI72zsx
         6J0lYADXqg762TGPyz1s71neHyfEw377nOLGFfu88lIZWchMcq1mjq9DovkETqIj/MUu
         QI+VFsn84iAkRT3sA3N9L5FDaT1piHKO5MhBgf7TV6xOHTklCY5xxkq1dfKKNZq9UWVV
         uN7g==
X-Gm-Message-State: APjAAAUo5xkOvYRg7ADLamSJeOR8U1bPn2DkP4LZnrRQzlZXWQfcCvuV
        TmdeZvtDBj89kk5p3Q9bH9+YqsI2d3Ln
X-Google-Smtp-Source: APXvYqxasJW4gTvv6WlGJS2JXirxZd/Rdk3jKWtbyZSZNuC38prz87hrUgdmDy5lSs+GrwyLFCZpyQ==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr5704394wrs.365.1581713326237;
        Fri, 14 Feb 2020 12:48:46 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:45 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR)
Subject: [PATCH 11/30] mm/zsmalloc: Add missing annotation for migrate_read_unlock()
Date:   Fri, 14 Feb 2020 20:47:22 +0000
Message-Id: <20200214204741.94112-12-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at migrate_read_unlock()()

 warning: context imbalance in migrate_read_unlock() - unexpected unlock

The root cause is the missing annotation at migrate_read_unlock()
Add the missing __releases(&zspage->lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index da70817b4ed8..2eab424c8c67 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1838,7 +1838,7 @@ static void migrate_read_lock(struct zspage *zspage) __acquires(&zspage->lock)
 	read_lock(&zspage->lock);
 }
 
-static void migrate_read_unlock(struct zspage *zspage)
+static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 {
 	read_unlock(&zspage->lock);
 }
-- 
2.24.1

