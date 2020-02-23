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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDD0C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CC720880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2gOqbm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBWXTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:19:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38228 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgBWXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so7457716wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6aPVDykefLHu9vWbDWoJ+MolfROsTG/Ceq0Yzhn9jk=;
        b=S2gOqbm1yxGnTsrRP5C07CWiBCjIcIVeSH6rMw39UAH1Kjzl7uWufLJ+hto8NqnajQ
         pF4eKbgtbtaWFsZ/k+eMJB6gqwfrBZNXHd/+hwEXyFUh2gp3PcTYJVBsTyMVDe8yWN9T
         0pfGrgVkVjufZubYuIV/i0sFOkGVBJ/3kPe+CllpEAFQAd9JrL8Iyg0BoT29CtRkUY0V
         hXgH79sNFM09rgVSC/l/wMdKTb3tNNMHZrieTCExGtw44DsIumpXNQQNvOmHE0qH4Ie7
         L+liCjhMzeqHYAk9oGpCsrAbjRGTRwG7nXGazLD7zI60cQZOH9O+Pey7zLJ3wu6WGCEa
         uQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6aPVDykefLHu9vWbDWoJ+MolfROsTG/Ceq0Yzhn9jk=;
        b=udIOmVLktTTnXTqDg1Of1So4Jl2wdnHB0MdJWoJlo7Kvl6VMwqg2v+xicNrfShPamj
         JeNWbhsGjSrDiJrcutuGq5j7HFmUEKCK+b+V5+5QyC8SAt5eGjX1YPuNcHD17oY8gBmb
         vBk9ALiJ77yqpQqvkV209ObPKZ9ZJXT3Uov99fCIq6JonigmnVfykoq18F9aIgDTu7Yo
         YhSPKbcIsVdBuit2bnyTUD7HPJ2XI13GctMqBkZ4gb1dGr40jszrrIulkJUEx0eh2Puz
         oEarCx0yCgociSpfC0gsvRtGVkORQ4kp6sHL97GOMStFEcMOaLbcdTotPfiZq9Do4oSn
         GHQw==
X-Gm-Message-State: APjAAAVaJiDCy1zQDVId8Br+oLkU00lTDr1oQNKMzvH293hOHgAChhMG
        q2lrOr0S6TAuwUKMAVMqVw==
X-Google-Smtp-Source: APXvYqzal3bDkpH/HXQ57tPEbVcB1ODz0w1n/zKTZub6/eEpWLPn6+I6cghxIrKksHQjjaWCmi52MA==
X-Received: by 2002:a1c:e3c2:: with SMTP id a185mr18023546wmh.27.1582499896239;
        Sun, 23 Feb 2020 15:18:16 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:15 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR)
Subject: [PATCH 18/30] mm/zsmalloc: Add missing annotation for zs_unmap_object()
Date:   Sun, 23 Feb 2020 23:16:59 +0000
Message-Id: <20200223231711.157699-19-jbi.octave@gmail.com>
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

Sparse reports a warning at zs_unmap_object()
context imbalance in zs_unmap_object() - unexpected unlock
The root cause is the missing annotation at zs_unmap_object()
Add the missing __releases(zspage)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/zsmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9d3f9b3d22aa..10a96651cb97 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1349,6 +1349,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 EXPORT_SYMBOL_GPL(zs_map_object);
 
 void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
+	__releases(zspage)
 {
 	struct zspage *zspage;
 	struct page *page;
-- 
2.24.1

