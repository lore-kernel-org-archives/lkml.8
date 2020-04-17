Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B298C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA06221F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBba+lDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgDQAGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726578AbgDQAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:06:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21FAC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:06:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k15so165549pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WM3Tq0c8R3pgUAX4sl8Zd0e3Hd062EPmdbrM6FgguUU=;
        b=jBba+lDeR1UxjQTUBpFeX0n0PRNXdoK3rtzyiDFPQ091GElSDjdsalQlXrekANhDqe
         4xEkIdsckzZcZnQ5U10pEFk3Idfrb0qH3qnsKk4nEJOvTv4MBtaDSqARSrvQLVQxg/Zi
         +XGARiFpySJByDwKte0zrvNIrkfksQU89QtKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WM3Tq0c8R3pgUAX4sl8Zd0e3Hd062EPmdbrM6FgguUU=;
        b=kjOTN+S28Cw0E+lQuKiR6ol02wTDkclgHIEVcjSF6Mng4IufidqM7dDqSjXIr2prOA
         /eBh6NIvO+m/Dav4I6bUbh2o8qSZFzcG34KwUPMfq7HJdUqaPYeLJBxnL8gsr/LS9wS2
         naB5wZ9VUgTBfteSDa1yoNgHjrA3mIBFPC2mVWt+RVWiDmPAIsJX+T01rMRjGbSVaNpX
         rRdZz4cbR1RcPEaSVa5Blpp4CWcmrQUax0YFwjCHC6rL6ktLnieuPIXrKYWiXFEi0MdD
         xtGabie2/7c1e4aNK8LYGZhGUOJmkoW412Fsvvn56hIv2RUU4Rc9VB07yncIbzZDhvzK
         hvwg==
X-Gm-Message-State: AGi0PuajUTt7joGvOd1cLpZjKSyqkmMdx0WpJ65PI2gdj2SEY4xSyRKm
        19NJQ7Oh3Me9w0UcOW+dg8Bdhg==
X-Google-Smtp-Source: APiQypJePOhPgmDt0fk0dA30owcqD7Ov/yBmvqpeMHtIsiA2fngqwfwdQWTVO7iPQyZIbrP1llCtmg==
X-Received: by 2002:a63:581e:: with SMTP id m30mr281345pgb.295.1587082007280;
        Thu, 16 Apr 2020 17:06:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 78sm11064801pfy.185.2020.04.16.17.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 17:06:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] soc: qcom: cmd-db: Properly endian swap the slv_id for debugfs
Date:   Thu, 16 Apr 2020 17:06:45 -0700
Message-Id: <20200417000645.234693-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the slv_id properly by making sure the 16-bit number is endian
swapped from little endian to CPU native before we read it to figure out
what to print for the human readable name. Otherwise we may just show
that all the elements in the cmd-db are "Unknown" which isn't right.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 4f8b739c6485..fc5610603b17 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -254,7 +254,7 @@ static int cmd_db_debugfs_dump(struct seq_file *seq, void *p)
 		if (!rsc->slv_id)
 			break;
 
-		switch (rsc->slv_id) {
+		switch (le16_to_cpu(rsc->slv_id)) {
 		case CMD_DB_HW_ARC:
 			name = "ARC";
 			break;

base-commit: d6815c5c43d4f9d18e557d27fd27ae8d9cfd450c
prerequisite-patch-id: fc235b174200bb1b24876628a89a841d1c2e4aad
prerequisite-patch-id: df579afb4eaea4200733d9dffb1d75eef8d8360b
-- 
Sent by a computer, using git, on the internet

