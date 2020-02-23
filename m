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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B1AC35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD23F208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OshIeKXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBWXTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:19:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34211 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgBWXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id s144so9450236wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1oTGA9EL4D/pEy5bBbpm6Q1m0B+MEn/I9d6coIuOhs=;
        b=OshIeKXsSYunnGUcKYn79kw8sa43GaDpprGqf1mIDyAzOXN4+E16wCdXFHde/BymW2
         x+dhHoghAqQHU1HlJfxkQKEUpu3xQiEwo0UKqDQ3eP666zjQDi0jXkYvYCqRstKnFTL/
         IPJdl0RQV0B34APWRSfCMwVhZbeFrwUVNizg/K3or8V7yARiq2w0nV4HBxILjyMVxZ5o
         nzpdqCRUobp41CiFrTkPYawD66/2LaokWlBf2xeql5SxF1IwNI0Lp9noW2ESOCOR7f6G
         TJSSJ4fdA2qFRhF+XyO/PqUstKgu7bJiTuklTiFrvWC5i7Eo4WCH32OoN1sQMzWMlfpH
         EsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1oTGA9EL4D/pEy5bBbpm6Q1m0B+MEn/I9d6coIuOhs=;
        b=Llv28DbpAV7mN10RXOOEvbzxMHj4HWns3//rX8dKvmgrDXohdwwXkscEumy89Sl6a1
         OckdDx476SUvcm/HkmwnZ0fwZjVZ1gdxc8sxsUlAbge2FSByrS6u+L5GgRq7/MHUs0x4
         ZAVkjNp5z/N9ZlyglDCkLCmcFDkKftCthH+5szC8cpSnCLfMxmqsl1GITN0/SXBFyhFi
         Y7pz4kkBGBcjCe3lsp3obQGGhxrpGpS+iFC1+5IvH0jwY8mj2SH8EfhC7Njazl+/VnR8
         XmCRjooMO4Y/H6JzhUbfEYqW4hWsGb8aSITvcRQpGEfUp2Szm+btzWirK0XiMI/GsXAN
         LloA==
X-Gm-Message-State: APjAAAVHeRmRkaRS0+TJczOHOOSdmCU21rqXKIztntTwcKHBdgWLW36v
        x0VIlaeBbTDQXlkBa9IKyAL7HzfWvc+o
X-Google-Smtp-Source: APXvYqyin2nwiiHBrn066/AF/36V+AEFfzRcbMa+GbqYwfdyeWfGe5v/t4dAnZeBrdrukqwu7Ge84A==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr18788298wmo.13.1582499895215;
        Sun, 23 Feb 2020 15:18:15 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:14 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR)
Subject: [PATCH 17/30] mm/zsmalloc: Add missing annotation for zs_map_object()
Date:   Sun, 23 Feb 2020 23:16:58 +0000
Message-Id: <20200223231711.157699-18-jbi.octave@gmail.com>
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

Sparse reports a warning at zs_map_object()
context imbalance in zs_map_object() - wrong count at exit
The root cause is the missing annotation at zs_map_object()
Add the missing __acquires(zspage)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/zsmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2aa2d524a343..9d3f9b3d22aa 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1290,6 +1290,7 @@ EXPORT_SYMBOL_GPL(zs_get_total_pages);
  */
 void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 			enum zs_mapmode mm)
+	__acquires(zspage)
 {
 	struct zspage *zspage;
 	struct page *page;
-- 
2.24.1

