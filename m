Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83B8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC552078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933780;
	bh=Ek0ULgVy39jBD8SSkFxugE25V40WPVHosBEnKWbkujI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ypYdbphAeqsLqK6mq5NAYIqOZpGUwY4IxNcc69eZIBEWcaHHqBwvRqJNm5NVC81yb
	 K1q53O6oQN32uHYkzzFBb6KDII4e1GdiQhFvDXZGbp0wLiG43Qz6Z6B5ovzO6abv88
	 Pm5WL+4Mu9nkpV+MVD1/SQ+XhMO+Xr+tYadTaso8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgFWRgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbgFWRgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:36:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CBA7207D0;
        Tue, 23 Jun 2020 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933770;
        bh=Ek0ULgVy39jBD8SSkFxugE25V40WPVHosBEnKWbkujI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BESqwDwCp+OcAN5fOS4tl1YtgtT2B8FDNKq+FpOPaSK2s75D6aDe3uVrLsrtIgKUs
         UmTWRENHQDUb6UQWiMYycHGErPr/PS0ZB0vVXhmvZEN0/Lk8NftBnVXT0FP6Afo8a1
         yChghWW2uOKl/Qpd8W/GaaJm/fqbE4iQdAh+oHVE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 09/24] test_objagg: Fix potential memory leak in error handling
Date:   Tue, 23 Jun 2020 13:35:44 -0400
Message-Id: <20200623173559.1355728-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173559.1355728-1-sashal@kernel.org>
References: <20200623173559.1355728-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit a6379f0ad6375a707e915518ecd5c2270afcd395 ]

In case of failure of check_expect_hints_stats(), the resources
allocated by objagg_hints_get should be freed. The patch fixes
this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_objagg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_objagg.c b/lib/test_objagg.c
index 72c1abfa154dc..da137939a4100 100644
--- a/lib/test_objagg.c
+++ b/lib/test_objagg.c
@@ -979,10 +979,10 @@ static int test_hints_case(const struct hints_case *hints_case)
 err_world2_obj_get:
 	for (i--; i >= 0; i--)
 		world_obj_put(&world2, objagg, hints_case->key_ids[i]);
-	objagg_hints_put(hints);
-	objagg_destroy(objagg2);
 	i = hints_case->key_ids_count;
+	objagg_destroy(objagg2);
 err_check_expect_hints_stats:
+	objagg_hints_put(hints);
 err_hints_get:
 err_check_expect_stats:
 err_world_obj_get:
-- 
2.25.1

