Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6685C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A1D2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eis52n3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgH0PRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbgH0Lge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:36:34 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA4C061237
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:25:34 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t23so5999410ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YhRPi+iPivlqG8bK16eTYTOlYGA4i6j4kZaE7AObBLg=;
        b=Eis52n3ZktmyztMq1qI1UemlajzME0c49pz8n6js8ZD5yG8BFyNOQsJjR9xO+E49RR
         NxwGJK3uJP0YzwlSom1UDiMZpco4G+3JSVz/+g1i3JvsxO7+wSOZ6LgksLoepg/M9H5w
         0mOzt0+UDZ/Dnq2O7EupgKXEtFrDTjZ+q+kQkYtcs02aLtMU+6+E2/yEDIAXtIAQGeGi
         nPwiqw6AeVSmZ6zTG/FPVZCXtc/YEdRsHjA8vyj+Gn4ioX9XNFc7JjJWTejsfXq6mIL2
         Vdp7wgPNhTfefV+Xxis94UnR8vSYhnc0Frb9INAKdusn+UeY6rpCFDlglvJrb92YRhtp
         xRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YhRPi+iPivlqG8bK16eTYTOlYGA4i6j4kZaE7AObBLg=;
        b=P7xBhNBC8gASNsUSi4WFTkykcfjU0LAoDKUiP0Jcni4ee9jem2rGzDayHY+nHzqkOb
         EHaEF1AmoqYXWEvT9kEX/5jpH2UsowEt0NSp5ZvzPDceCJMJR43dKo4MpfuYF1SOluzi
         zRSfNpcthp3URgOvQdASvQ2Cblaqp0522s0vsEHu494yRLM6mkbaiUuai/9r6NWjH3jY
         BYKw40hIoEdi9ItT5Bot0fHQS2vkGDhIs5kNJhnXVIdX+KP9vt8E1nlZ/6Biz5vIJX1i
         63CDeHrkrIu/O3WbfYKg1q8Mv0gZYJCvzIo59tbhccEOEVIteAeDOy0kqZLgTgJgzWix
         B7lA==
X-Gm-Message-State: AOAM533U9Ajos+nYW+il4QbYo0oOi/HJnZ7XAOVoE8Y2kR9UT3VoGili
        wuLE8DkypwK2HWqvDOmj6sA=
X-Google-Smtp-Source: ABdhPJzmZLy9GvIvyrmGs8hXjVy/ig6/izuQc7KdVIg69wVwPAB7TUaQ26ALhhKYHnsiXtXaq07AOA==
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr9986674ljo.286.1598527533010;
        Thu, 27 Aug 2020 04:25:33 -0700 (PDT)
Received: from WORK-PC.study.tst ([91.198.14.21])
        by smtp.gmail.com with ESMTPSA id e14sm411801ljl.96.2020.08.27.04.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 04:25:32 -0700 (PDT)
From:   Valery Ivanov <ivalery111@gmail.com>
To:     greg@kroah.com
Cc:     arve@android.com, riandrews@android.com, ivalery111@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ion: remove unnecessary intermediate variable 'objs'
Date:   Thu, 27 Aug 2020 14:24:48 +0300
Message-Id: <20200827112448.85831-1-ivalery111@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necesssary to use 'objs' as an intermediate variable for assignment operation.

Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
---
 drivers/staging/android/ion/ion.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 3c9f09506ffa..137bef25dcbc 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -523,15 +523,12 @@ static int debug_shrink_set(void *data, u64 val)
 {
 	struct ion_heap *heap = data;
 	struct shrink_control sc;
-	int objs;
 
 	sc.gfp_mask = GFP_HIGHUSER;
 	sc.nr_to_scan = val;
 
-	if (!val) {
-		objs = heap->shrinker.count_objects(&heap->shrinker, &sc);
-		sc.nr_to_scan = objs;
-	}
+	if (!val)
+		sc.nr_to_scan = heap->shrinker.count_objects(&heap->shrinker, &sc);
 
 	heap->shrinker.scan_objects(&heap->shrinker, &sc);
 	return 0;
-- 
2.25.1

