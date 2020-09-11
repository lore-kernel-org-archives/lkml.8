Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB14C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1E92087C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0GoCwMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgIKJYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgIKJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:24:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78C1C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:24:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a17so10764525wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZsvG/SauzKMRV4u8/MtOFoZci+o6dCxmbXBGIM7a50=;
        b=C0GoCwMnOvnBY+2+L0nL96kQrzbpQJHwZv0N+qm4QZXcFWLYhlJmTu7u2nxGIN8kEb
         6Ms1rGU5GUXaoyHz0OMjOedBu7OsXpacE0mpczLdX4+RgfI7Bp+8EVM7966JEHQnBWke
         c6zn991D+Fxa+a+sMUdIt8XKen3Ptea+XQppBRgCdMOMcyF4jpewAbXDB3yV2b/dfky1
         GvFgGFYFLflrETgvFlUjOEu5eYM7DZFh+mGL10PE82HafYOquOXR/nxXAwvrf0itUFhh
         vfBqli232EvLgTCdpWpa044WpvCk++tB1lKeLh+79+LngIQGiNmznQRON8YVgiW73HXa
         K0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZsvG/SauzKMRV4u8/MtOFoZci+o6dCxmbXBGIM7a50=;
        b=d3uDgklbGdGqRKh86E7Eiq0JQSErNt926tpnrfEZr6fXmcFne1GiSQOB/x4vpgAIru
         ymHnIngvJ6ZTsrchqCk5ydFeKvV9f3AIuNRZtX2XzEreMZyzIW/VfE/3juzRnls6LILt
         VD+fjK1XHYfKv8P2gKAmC7JS+JvDXG4CAxEtj1IaYxSVB+wzvbxhGYN26gk2c0YMQxIv
         mwJ7Z5IUgMcSk3cfDypXCp0CsT4FxfMmgq/Av4lq8XjuaT5IWdHdmhrJrQAmPnKpYwTX
         YSEyoniXCbDycBdIzPw9IJict/soShiXRxD5w6g2xn6oBXQL6PKRTdrzSTf77aJ8bcs8
         cKRA==
X-Gm-Message-State: AOAM533PBgG1oLJguXr1heNZBxNpZsnj0lY2H6WafeEyak26MZvR3Nol
        33v82wmC20DE2tAa5ymFR2IAQhDQ6qGtZA==
X-Google-Smtp-Source: ABdhPJwT2zTIACtbEHcwRj6X6yZSyjEQMDhg/RhN5KU4tsLxeF/tXk7LZ1CUstYAK1USVCqaaPNG7A==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr1124780wrw.34.1599816253482;
        Fri, 11 Sep 2020 02:24:13 -0700 (PDT)
Received: from localhost.localdomain (188.147.111.252.nat.umts.dynamic.t-mobile.pl. [188.147.111.252])
        by smtp.gmail.com with ESMTPSA id o4sm3270841wrv.86.2020.09.11.02.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:24:12 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/page_alloc.c: micro-optimization remove unnecessary branch
Date:   Fri, 11 Sep 2020 11:23:10 +0200
Message-Id: <20200911092310.31136-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously flags check was separated into two separated checks with two
separated branches. In case of presence of any of two mentioned flags,
the same effect on flow occurs. Therefore checks can be merged and one
branch can be avoided.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/page_alloc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cefbef32bf4a..b9bd75cacf02 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3972,8 +3972,10 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	 * success so it is time to admit defeat. We will skip the OOM killer
 	 * because it is very likely that the caller has a more reasonable
 	 * fallback than shooting a random task.
+	 *
+	 * The OOM killer may not free memory on a specific node.
 	 */
-	if (gfp_mask & __GFP_RETRY_MAYFAIL)
+	if (gfp_mask & (__GFP_RETRY_MAYFAIL | __GFP_THISNODE))
 		goto out;
 	/* The OOM killer does not needlessly kill tasks for lowmem */
 	if (ac->highest_zoneidx < ZONE_NORMAL)
@@ -3990,10 +3992,6 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	 * failures more gracefully we should just bail out here.
 	 */
 
-	/* The OOM killer may not free memory on a specific node */
-	if (gfp_mask & __GFP_THISNODE)
-		goto out;
-
 	/* Exhausted what can be done so it's blame time */
 	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
 		*did_some_progress = 1;
-- 
2.20.1

