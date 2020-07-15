Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FE7C433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E8B20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRHNplZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgGOI1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbgGOI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3122C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so1470940wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBqTF9msKxXESKXR6D7ZZTPRiLswk1Xy6QhvSew6gR0=;
        b=oRHNplZ7GSg6wW9XCQnXu7Ag3RRbpbsqZQOc7oxhhgEyiH+dzYvNYDSO1XjRvkWcJl
         7uBZeyJQHXz5gFKwdA4IaSPpjV0DX6KUjXmZbpt8DBZ3nZ44yItO9dQ//zBdrT/9cvTm
         Z72l+F9wCR8PderUySuiWy3jJEaa+wHxOy/cCPEY1a5C1RNJjZLnes/9fkbm4M1QHuS+
         PgfHkNEUwTaIxHSK6Iv6NBKuuHfF1GDdnFJjO0G83E91e34xz0i1ZA2+w8hIbKEF8GHy
         LlIZ+WuoYrKed+fVVbT2gpUEMdYo71pO5SW08hEGUWqSPfskXX6Mi9dOWpWUo89QJinQ
         FZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBqTF9msKxXESKXR6D7ZZTPRiLswk1Xy6QhvSew6gR0=;
        b=ZIYxwwY+B/gIBPSccpzj99X76hkB97jdz0G/keOHaR7sLHUcsEvlkBZ/dspAq59K0r
         8t9mnVEKOHDh1rYabJoZ5B97b3s5hhScDdzncsvE14eZNIzgKNfpc9bfNW6fn1h2DDwm
         fj+FyB/FJoJJjWp2jsUHXU8Sf7SQO7wVwg/UCRc9zvgLZsP57ah6RWYme50n6iMU7zQ8
         48gqweM0K0CW7noanEUwVPOMfsf6YgXA3sTbteRVk3kfAdM/DR3B/Z9HGeEoTY2kNMBd
         qkpZJJQtnJFUsM1zEv/fUNPGMjguJ2p/H+3IxdSLzl/JCU1B0joprnUD8trr4YZOO9oY
         JFDw==
X-Gm-Message-State: AOAM533xXBVuluwMvOXdn28mfqgzPVeCiIvBrkUun3T54hFNYP8hQqE2
        TjYd+Sdodi/V+4TBvDsC4aFrWA==
X-Google-Smtp-Source: ABdhPJy5SCVD1rT1DRxu8zgDWo02ZeuPue7Qv83+P6OX3TiNf3xq9p2hLtBri2FdrgS6Qle9GcUXPA==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr9898491wrw.123.1594801611303;
        Wed, 15 Jul 2020 01:26:51 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andreas Herrmann <herrmann.der.user@googlemail.com>,
        Dominik Brodowski <linux@brodo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Paul Devriendt <paul.devriendt@amd.com>,
        Mark Langsdorf <mark.langsdorf@amd.com>
Subject: [PATCH v2 10/13] cpufreq: powernow-k8: Mark 'hi' and 'lo' dummy variables as __always_unused
Date:   Wed, 15 Jul 2020 09:26:31 +0100
Message-Id: <20200715082634.3024816-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if we fail to use a variable, even a dummy ones, then the compiler
complains that it is set but not used.  We know this is fine, so we
set them as __always_unused here to let the compiler know.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/powernow-k8.c: In function ‘pending_bit_stuck’:
 drivers/cpufreq/powernow-k8.c:89:10: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]
 89 | u32 lo, hi;
 | ^~
 drivers/cpufreq/powernow-k8.c: In function ‘core_voltage_pre_transition’:
 drivers/cpufreq/powernow-k8.c:285:14: warning: variable ‘lo’ set but not used [-Wunused-but-set-variable]
 285 | u32 maxvid, lo, rvomult = 1;
 | ^~

Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc: Dominik Brodowski <linux@brodo.de>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Paul Devriendt <paul.devriendt@amd.com>
Cc: Mark Langsdorf <mark.langsdorf@amd.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/powernow-k8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 3984959eed1d5..0acc9e241cd7d 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -86,7 +86,7 @@ static u32 convert_fid_to_vco_fid(u32 fid)
  */
 static int pending_bit_stuck(void)
 {
-	u32 lo, hi;
+	u32 lo, hi __always_unused;
 
 	rdmsr(MSR_FIDVID_STATUS, lo, hi);
 	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
@@ -282,7 +282,7 @@ static int core_voltage_pre_transition(struct powernow_k8_data *data,
 {
 	u32 rvosteps = data->rvo;
 	u32 savefid = data->currfid;
-	u32 maxvid, lo, rvomult = 1;
+	u32 maxvid, lo __always_unused, rvomult = 1;
 
 	pr_debug("ph1 (cpu%d): start, currfid 0x%x, currvid 0x%x, reqvid 0x%x, rvo 0x%x\n",
 		smp_processor_id(),
-- 
2.25.1

