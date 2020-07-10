Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E2620748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMb7iDYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgGJTox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJTow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:44:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09295C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:44:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so7750986ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Jefdz/yaOaAhqlfQ2b25fK1L/1k8801ZS9K7lHkt5E=;
        b=YMb7iDYiLk8dHq9kJdyGEpQnaZFcjmM/MmodM9yoolYsNlxXTwnkYl87mocs3EQUW3
         9u3X4fd+qN8Ynkm4ByDjD14ROLyN2oWUBycHHAlHl6a1qnykSgR1FTkMgXrs1kGZBxvt
         k4WaQ6+keuez4pbRr62eRCOz+DWK0l1Tfy05mrGgPtJuR+zgfBdvjuyk/GXBsy9FyB4x
         yCk4fW2PLTj2XDuHb+rQQgJoi+t3lsiBVVshUvX/y9NofoFAgQMTXueDh+zjQah4Jzyl
         HXA2u1XKFKruO7D6y2YzzSAbdwO2uWp111oplH0XrbVpbxiiMmHoElZkRecMxsx3uYOB
         zm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Jefdz/yaOaAhqlfQ2b25fK1L/1k8801ZS9K7lHkt5E=;
        b=FktCCSEDWCTqC0aP8KHr7mIBe2YbbOSoI+MYtT6ZGcmftVDwZYTqYrx/lfuqEgOewB
         I+/W7EjqGdo7ZWei3hQFetZq/Zqb5JH92+tyF7vZjibEZey3KFI7dGWYlR5FjdHAuLNS
         2aumnFHEfJTFYtaITU8BSbWtF7D/hKWGSrUCacbHX+KJg/fVpw88MHBYNUtm2wI0TCS1
         OHMtTuo0Mt6zC8XQjclwtMEUMNk5taAppqtBDD3kjQZXe8eQ8tqDk315v7Jnrd1iYiQA
         RYYLQQH8hs1z2mW88J5MEN2QWkKLklLvJY3RH9efSFt/T4ERRKKrxzzXLxVUW/enSqki
         VHRA==
X-Gm-Message-State: AOAM533M8lSTeI3odtPhBfHHCOQaIbqrL5BKx/lU75lWajXXfqhsdvQ4
        Cbt0++wGIAd4EVCcOFpiEOJ5HglRmV4Z0A==
X-Google-Smtp-Source: ABdhPJza4yxsAwxkWbnE2BL6yZTMcJPZFM0gSKEtlVvUUSDmiI9YEYoUJi1agaHDdYHLOhN4fw7KOA==
X-Received: by 2002:a2e:971a:: with SMTP id r26mr44521211lji.464.1594410290537;
        Fri, 10 Jul 2020 12:44:50 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id n4sm2493161lfl.40.2020.07.10.12.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:44:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/1] mm/vmalloc.c: Add an error message if two areas overlap
Date:   Fri, 10 Jul 2020 21:44:43 +0200
Message-Id: <20200710194443.2984-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before triggering a BUG() it would be useful to understand
how two areas overlap between each other. Print information
about start/end addresses of both VAs and their addresses.

For example if both are identical it could mean double free.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5a2b55c8dd9a..db2e1020dc51 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -549,8 +549,13 @@ find_va_links(struct vmap_area *va,
 		else if (va->va_end > tmp_va->va_start &&
 				va->va_start >= tmp_va->va_end)
 			link = &(*link)->rb_right;
-		else
+		else {
+			pr_err("Overlaps: 0x%px(0x%lx-0x%lx), 0x%px(0x%lx-0x%lx)\n",
+				va, va->va_start, va->va_end, tmp_va,
+				tmp_va->va_start, tmp_va->va_end);
+
 			BUG();
+		}
 	} while (*link);
 
 	*parent = &tmp_va->rb_node;
-- 
2.20.1

