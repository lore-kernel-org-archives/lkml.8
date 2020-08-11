Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6625C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B008206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="esuzoFhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHKV2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgHKV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:28:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B466C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:28:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l60so79665pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCT6jEWl7Ju91vm0nT1I8FuApKx+NvXpkLG15OsEHkE=;
        b=esuzoFhsB/iEmKzuUt171SiF6FvHkUYdHIeocMRIgJV/ZGWEk08Efdxct8CTU/66c2
         /0yjniyVDGe58g1ztBzVITg+/JIt463KXNCOhrC03F4dqm5zPHTql6AjqjA8qnW6PTyx
         0jf0/9cR+hDst6jq8p/QWVhKHiSTnUbcKyd1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCT6jEWl7Ju91vm0nT1I8FuApKx+NvXpkLG15OsEHkE=;
        b=mVSVjfNNwoiOOsLeTpcXMDxra64pT0wH6CFZSmIb6BNIlLeDQH/RFSNx46wkHtd6rO
         ZQ5dXxtPqR4Ja/SQbat2uBrjChR2Hmd8dnzsxovnMPY61JQd/avwRcEgWcYaUzT3XOTW
         vxeT6gOV3VkWNEBvvmRiXfSJWG1FDRdniqNt3x5ue6k8h+9zcaB8toGGwy/EWTzVqqZt
         ThkPvEgNg0mrdaBm4dtzyTPnWFqouUBU89wdAk/UJW7fcBhPXQn3UHSmcBUxjWrS8wAD
         z9ADTxtqPVQfdJGi9pf1NdK/INRtU8OWL3PxhihCIX+73WGp173+cIPW5y5TIsZ1EEqM
         7n2w==
X-Gm-Message-State: AOAM5308+sF3ulmWx222dEK/BHfBznKKsIE8KpUa6k3cf4KcLyAYCNIv
        9UiJHIvZ+1CFFDxiMovkdKcJ6A==
X-Google-Smtp-Source: ABdhPJzD/W82CiysLDNV0dL8QhQty9JDkFCHdQcIDgUP++MlsuruBsxpl6Pt1LaJSLlMf2/Y4nZW8A==
X-Received: by 2002:a17:90a:ca17:: with SMTP id x23mr3022737pjt.194.1597181317702;
        Tue, 11 Aug 2020 14:28:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 198sm20644pfz.120.2020.08.11.14.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:28:37 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] OPP: Put opp table in dev_pm_opp_set_rate() all the time
Date:   Tue, 11 Aug 2020 14:28:36 -0700
Message-Id: <20200811212836.2531613-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get the opp_table pointer at the top of the function and so we should
put the pointer at the end of the function like all other exit paths
from this function do.

Cc: Rajendra Nayak <rnayak@codeaurora.org>
Fixes: aca48b61f963 ("opp: Manage empty OPP tables with clk handle")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/opp/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9d7fb45b1786..bdb028c7793d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -893,8 +893,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * have OPP table for the device, while others don't and
 		 * opp_set_rate() just needs to behave like clk_set_rate().
 		 */
-		if (!_get_opp_count(opp_table))
-			return 0;
+		if (!_get_opp_count(opp_table)) {
+			ret = 0;
+			goto put_opp_table;
+		}
 
 		if (!opp_table->required_opp_tables && !opp_table->regulators &&
 		    !opp_table->paths) {
@@ -905,7 +907,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 		ret = _set_opp_bw(opp_table, NULL, dev, true);
 		if (ret)
-			return ret;
+			goto put_opp_table;
 
 		if (opp_table->regulator_enabled) {
 			regulator_disable(opp_table->regulators[0]);
-- 
Sent by a computer, using git, on the internet

