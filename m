Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32652C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5E2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHaGwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:52:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40007 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaGwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:52:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id s205so879941lja.7;
        Sun, 30 Aug 2020 23:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8usTZGUCwzdko3c/cxOzexiS1sGTsVl4kgtGbj2TRE=;
        b=RLn15YqHBIir3kMpLdSF7jhvjMl0SW+vcdg5V25pA91r8cmg4AiIB9L0JPGjhRZoNJ
         JlR/gkbEfO6xLTqRTD1ZhxQEYfmR7uZGDY7fOLoQjltjpCifJ9KmpVFvieHdUKMYgKfP
         V7CyVmrjpVvV2NvjpZiaUoeFAYjITWNSvkU6ynHl4TRxBsjzxn0HcWUZhRafwVJBOSkj
         t1XvU+N764f1Q/BHgnkZ1S+7EGFLFS4u55pruy41DQ5cRB0RUS9vgDNEBqmXLzSO1qJ9
         mM3cpLrhBf5OD+xtPotfP3a1Nm3pXclxdgE/76kXggnsjxp5mxi13/IRG+NzlVNABb4F
         FO5Q==
X-Gm-Message-State: AOAM5328U34a8Y7o5Q/Dr6Z5HdEMQtWxRjyvQCYBSMVS9akfuF+lebn/
        wCsi6YGd6EM/kVl5ofqVQEt7I+KVF1o=
X-Google-Smtp-Source: ABdhPJwITHw0zG0/JCk/IApZuzswgGza/9V8RS4t/BGPO1wNzDWNI80bynwD2/xEdc88d9c7pWQ/hQ==
X-Received: by 2002:a2e:5c5:: with SMTP id 188mr4300250ljf.466.1598856751510;
        Sun, 30 Aug 2020 23:52:31 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id q20sm1367472ljj.42.2020.08.30.23.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 23:52:30 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: remove redundant assignment prompt = prompt
Date:   Mon, 31 Aug 2020 09:52:23 +0300
Message-Id: <20200831065223.6304-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Semi-automatic removing of localization macros changed the line
from "prompt = _(prompt);" to "prompt = prompt;". Drop the
reduntand assignment.

Fixes: 694c49a7c01c ("kconfig: drop localization support")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/kconfig/nconf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index daf1c1506ec4..e0f965529166 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -755,7 +755,6 @@ static void build_conf(struct menu *menu)
 			switch (ptype) {
 			case P_MENU:
 				child_count++;
-				prompt = prompt;
 				if (single_menu_mode) {
 					item_make(menu, 'm',
 						"%s%*c%s",
-- 
2.26.2

