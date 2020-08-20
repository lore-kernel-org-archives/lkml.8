Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC305C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A71D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882136;
	bh=njMCN4wfeEu0obOdjp8oNlijF2KTgbRN8fh42Towaew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dg/Wa/JchNOIbObDl050kvHaSSQ7xdtupy2NRGEIKa/P3iJpncIElORGkAfhPhEZP
	 jO0X1H6tCiRVHvGt25pccbmg02quGWbkfAkMh6XZYvEQRqp2NLYSxd/tYSMg/Qk9el
	 ZM6+L31qrQP9q+rMy3FVpjY0EQbPQ1f2xY9/hsgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgHTAIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbgHTAC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:02:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BCC20FC3;
        Thu, 20 Aug 2020 00:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881776;
        bh=njMCN4wfeEu0obOdjp8oNlijF2KTgbRN8fh42Towaew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1RMYGyBWZUuy5T+F3nr5kantMJP5vZPhcCk8pas1uAM54W/NysDAjs5tq1yEDqm2
         GeGaJy91TGuNpqkSDiz2bO8WwPaO+RNVy3nlt9Bw5G/rh1bjiO+3l7gcw66o2/NLYe
         ySQEb/fEgTVwT7sdBZlozljtuV3A66EH+OmRNURs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gaurav Singh <gaurav1086@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Michal Koutn <mkoutny@suse.com>, Roman Gushchin <guro@fb.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Chris Down <chris@chrisdown.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 19/22]  tools/testing/selftests/cgroup/cgroup_util.c: cg_read_strcmp: fix null pointer dereference
Date:   Wed, 19 Aug 2020 20:02:26 -0400
Message-Id: <20200820000229.215333-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000229.215333-1-sashal@kernel.org>
References: <20200820000229.215333-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Singh <gaurav1086@gmail.com>

[ Upstream commit d830020656c5b68ced962ed3cb51a90e0a89d4c4 ]

Haven't reproduced this issue. This PR is does a minor code cleanup.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Michal Koutn <mkoutny@suse.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Chris Down <chris@chrisdown.name>
Link: http://lkml.kernel.org/r/20200726013808.22242-1-gaurav1086@gmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index bdb69599c4bdc..5e939ff1e3f95 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -105,7 +105,7 @@ int cg_read_strcmp(const char *cgroup, const char *control,
 
 	/* Handle the case of comparing against empty string */
 	if (!expected)
-		size = 32;
+		return -1;
 	else
 		size = strlen(expected) + 1;
 
-- 
2.25.1

