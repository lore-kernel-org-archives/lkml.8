Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE4C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F01E20780
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kx5ovgqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgCUVDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:03:19 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37248 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCUVDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 17:03:16 -0400
Received: by mail-pg1-f201.google.com with SMTP id q15so3349673pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 14:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xNvYA6UhdIzCQNZy2uMLhsHjhbyUSQ3qyllU0rHtcf0=;
        b=kx5ovgqmJRy9LGIuPT4ywXhCTs3ARAfhGOZul8HGd64ytF9046OToOx7+bYcct4wDp
         smEgd1KPD9EJyBA3JJKmZUw1zNINb4lXDpEQtVmU+msGcV0voGhBB/nUyXC8pDL9B6n8
         4zoZ2K8dHdjHrDgy1oo/AVQMIlkmsceqLBO6pGFZQrzBZdReFjmbbQa7Etko8q7JbqcS
         R/dqzWdI6BOBvTV7EGEGcji3MwKGwVdUKcbs5Vo//vxMaBfqQJQwV8bEkk2hG4Qh2XSn
         eQFDa/tXb6HV2gjAxH8/yvbUpSEXrKzzNm/7QzCQtjYZy9cAOIelVI2GjzmDxvMwDZ19
         gD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xNvYA6UhdIzCQNZy2uMLhsHjhbyUSQ3qyllU0rHtcf0=;
        b=cAtLc8qRfFNsfkgUgf8fG9Rfq1HMYWHH1XQGfLiHvJhwtwevQTslHuuX/2/ILA3KfV
         cdBRxNLZLUEKaN2KLSHTAqtBcn17JepTaZamZapfMPNcfjzcgfBJiVokElY1Fz3OqFEE
         3EKfM0pzxpdOEt/zRRGoAHXYWI4KSbaQzTfSfOwPiYmXkSJE73+aMrSpqJBaaZfRzLEd
         LWFYCg66Zql5DFf0dcjYMcJT+ZA/hsS9kECBgw7nTz5lkGxbmvA7+NrhcLIdmchWB/UQ
         BoTuYj+II9bocqCfA1CwDC8gqLS07P70dnOBRdyOMB4JCsrjfGz+jmPkdmc+FudBulgv
         cUTQ==
X-Gm-Message-State: ANhLgQ2uw9RgxScWEcwR8HWPXAbSv4OufL8wkUrhefgqnfHdF2NfYv8D
        hAIKQC37ufmK66gqVCtnbBWnqLpP9rcHpks=
X-Google-Smtp-Source: ADFU+vtYlRCFa88mZmOzBJd3AZ3LAwx5smuo4Pvk3DO0lBLd90kUDcML0zo0KVJTHHQNheV1kmuzhjMEjWY6Ufo=
X-Received: by 2002:a17:90a:930e:: with SMTP id p14mr16445333pjo.159.1584824594216;
 Sat, 21 Mar 2020 14:03:14 -0700 (PDT)
Date:   Sat, 21 Mar 2020 14:03:05 -0700
Message-Id: <20200321210305.28937-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [RFC PATCH v1] driver core: Set fw_devlink to "permissive" behavior
 by default
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set fw_devlink to "permissive" behavior by default so that device links
are automatically created (with DL_FLAG_SYNC_STATE_ONLY) by scanning the
firmware.

This ensures suppliers get their sync_state() calls only after all their
consumers have probed successfully. Without this, suppliers will get
their sync_state() calls at late_initcall_sync() even if their consuer

Ideally, we'd want to set fw_devlink to "on" or "rpm" by default. But
that needs more testing as it's known to break some corner case
drivers/platforms.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

I think it's time to soak test this and see if anything fails or if
anyone complains. Definitely not ready for 5.6. But pulling it in for
5.7 and having it go through all the rc testing would be helpful.

I'm sure there'll be reports where some DT properties are ambiguously
names and is breaking downstream or even some upstream platform. For
example, a DT property like "nr-gpios" would have a dmesg log about
parsing error because it looks like a valid "-gpios" DT binding. It'll
be good to catch those case and fix them.

Also, is there no way to look up current value of early_params? It'd be
nice if there was a way to do that.

-Saravana

 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5e3cc1651c78..9fabf9749a06 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2345,7 +2345,7 @@ static int device_private_init(struct device *dev)
 	return 0;
 }
 
-static u32 fw_devlink_flags;
+static u32 fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
 static int __init fw_devlink_setup(char *arg)
 {
 	if (!arg)
-- 
2.25.1.696.g5e7596f4ac-goog

