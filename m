Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8694EC10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0A12075B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck+sA0a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCGWzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 17:55:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33159 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCGWzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 17:55:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id c20so4715986lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 14:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lmy6sY3BuY2QrfOC8Hp11UcSzO3l1+fu6BuIO/tde+s=;
        b=Ck+sA0a7Bh2+pT36DNBhLArjI2fLXSF/EZjL9wt60mmEoSudbOckrVquBxL/qTLzaE
         CO+6bSfYguhj1lGXyoGJMd4YzPlqr3r0xUYL3ABWtqA2OMZk+AuoeBUYnqqe7eR26Mp4
         XNVuDgfdBTSaoXmPgx0DoBvrxDcSPNpGifQIkOWWFu7GzHP8yLT9oItbDSuszECtssaw
         vmEFhWd48gBi9rLYFZPA34FLbW877lQa4TENNPzTA3D08JNTiJR6tctceuEPudp4KUuS
         FQihQ4KMLKPuOdHkgj4V7G3ze5k8gI5KZ1+EWSyNVhuaBfepmXcgndR9p/y0Xq5UZZnN
         9tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lmy6sY3BuY2QrfOC8Hp11UcSzO3l1+fu6BuIO/tde+s=;
        b=R4ZTsNj2+8yL+joWFu8j70rT9U4JTcDn5lxoLL2dEOe1n9vtCbTim6lsGeLYK7BQqZ
         BansRRqmV081AbO3AF4FzijYAGU0DvD9dDL48SCYl+DxTseH0AAO/l2/X48GCYwTw0WK
         btPfNN4eKeysURLvdlw2aqyFBSVCVh8oPMoQnooI5Vmv2emEZ4jRIy/CZsBWDCE+taSe
         dUNk3dLW11SuZ14VIvfvqjf+KYK6BiK/KHGtXGc0szaYMb9FUL+YSfWHVDvWcSzreyCG
         BkhwRHIIgdJFCtSRUPrDqNYOko84g0otbuUCzwMIwzMZZCSE5/FRZyUeJi9Z8KyBEvMk
         vTOg==
X-Gm-Message-State: ANhLgQ31yn7YO/Hj5Xe6MAOSgGNYHh6CnGOR9OnxG0hc5vLyV6grAb5R
        8joMNWZkjlATSkdkpGZAwh4=
X-Google-Smtp-Source: ADFU+vvWUa6/pPaqj/uFb25zlxb/uzdMqLjlzAPRBdX5/0+xW5Z9ge5inaMikdZA35Gr9e9M+fQe3Q==
X-Received: by 2002:a05:6512:3089:: with SMTP id z9mr193983lfd.15.1583621713144;
        Sat, 07 Mar 2020 14:55:13 -0800 (PST)
Received: from localhost.localdomain (188.146.98.10.nat.umts.dynamic.t-mobile.pl. [188.146.98.10])
        by smtp.gmail.com with ESMTPSA id v10sm19777324lfb.61.2020.03.07.14.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 14:55:12 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [RFC PATCH] mm/page_alloc.c: Micro-optimisation Remove unnecessary branch
Date:   Sat,  7 Mar 2020 23:53:35 +0100
Message-Id: <20200307225335.31300-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously if branch condition was false, the assignment was not executed.
The assignment can be safely executed even when the condition is false and
it is not incorrect as it assigns the value of 'nodemask' to 'ac.nodemask'
which already has the same value.

So as the assignment can be executed unconditionally, the branch can be
removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 79e950d76ffc..75456d04b5c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4819,8 +4819,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	 * Restore the original nodemask if it was potentially replaced with
 	 * &cpuset_current_mems_allowed to optimize the fast-path attempt.
 	 */
-	if (unlikely(ac.nodemask != nodemask))
-		ac.nodemask = nodemask;
+	ac.nodemask = nodemask;
 
 	page = __alloc_pages_slowpath(alloc_mask, order, &ac);
 
-- 
2.17.1

