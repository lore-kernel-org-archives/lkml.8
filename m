Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A955C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77CB22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RUixrVyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGTI2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:28:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17695C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:28:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so9719219pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHz+fh9KhorFs1TLxN9L3mwYW6buhjiKAJZKsFMcKOQ=;
        b=RUixrVyLy/D6O2GPVqA+VLNharw26Ydp8E7gQETyGg2n+yz8QV2yP9c627s6o9FBtP
         MEiLFH6mIj/cYiE1xnchA3oTTEdJ/mhJPqA2OwY6A6DFyy+L4/94Rbv/yganEIEkwDA7
         mamNcbjGwGuugX769pTgiVCIUvVXaMoiSczwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHz+fh9KhorFs1TLxN9L3mwYW6buhjiKAJZKsFMcKOQ=;
        b=STckcrNJICmz87OmwNzvlbIyHS4rJrqggnXYFEiEuxAzvMO0hvsNRUXZN/EAVTEZV5
         K16l5a/YcNxp89gtkOMt39naneEL+DS7qnVQQ6EQVRpBTMCqHKt0xJ9u4SQBy64Xf58E
         UMOXzWER7vvnk4Zu7UQLe70u8jup3qG79FzYMI4JjoZXQKwHAbySi19YXhqGChQ0ckuc
         WTl0aSsHtyuiTcWugby0u2w5U0oniHBEtbGKJdDR6/6kKEaGL61MnZm7wHaJrMavhps1
         54qNayV+33jhbLeV5yUemME/+QtXN9+xi+xeyc8dCfp+X3acWCiIoZCQoKkyGoE59769
         ewdA==
X-Gm-Message-State: AOAM532h1Pf7YzaqGdWMFfdqRen/HM3s/LyEvQs+aY2nqkpThfMA4d63
        Sc2XiHXK4l9XDmeD1didGjzqYQ==
X-Google-Smtp-Source: ABdhPJxjWtKCUQClEpnzDStDZ5GTTSbi6ahDhohPe7UgMv64xFCLOT5tOfGZayicdbBejh/Vj0PJyQ==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6mr14845530plb.57.1595233697582;
        Mon, 20 Jul 2020 01:28:17 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id o3sm5513095pfu.81.2020.07.20.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:28:16 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Shik Chen <shik@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scripts/decode_stacktrace: Strip basepath from all paths.
Date:   Mon, 20 Jul 2020 08:27:07 +0000
Message-Id: <20200720082709.252805-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the basepath is removed only from the beginning of the string.
When the symbol is inlined and there's multiple line outputs of
addr2line, only the first line would have basepath removed.

Change to remove the basepath prefix from all lines.

Fixes: 31013836a71e ("scripts/decode_stacktrace: match basepath using shell prefix operator, not regex")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Co-developed-by: Shik Chen <shik@chromium.org>
Signed-off-by: Shik Chen <shik@chromium.org>
---
 scripts/decode_stacktrace.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 66a6d511b524..0869def435ee 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -87,8 +87,8 @@ parse_symbol() {
 		return
 	fi
 
-	# Strip out the base of the path
-	code=${code#$basepath/}
+	# Strip out the base of the path on each line
+	code=$(while read -r line; do echo "${line#$basepath/}"; done <<< "$code")
 
 	# In the case of inlines, move everything to same line
 	code=${code//$'\n'/' '}

base-commit: 5714ee50bb4375bd586858ad800b1d9772847452
-- 
2.28.0.rc0.105.gf9edc3c819-goog

