Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B33C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9CF2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMUHViHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgD1TUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729135AbgD1TUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:20:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C1C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:20:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y8so26088249ybn.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Fbbhxh4PPBK5DhbGxek1hM5pONPrv64ZqzBYP6IWdgM=;
        b=MMUHViHjh2RSu07H0hX9x0wTNbUDw/3YD/fUs/Zol6IKlPKiYE5IUD5kjxdwHxKmEF
         OKSmLz/l/N4uA28HO1UEqtfSDy2q+TYB/g+6crxozgyuTCLS3c+NGSFZ1OJh7fTPPQQ7
         EYXvNsYxUkoEN8q5ndnr6ZaNm75URqvOwjQFMx8h3kEL1LllBtBrFD4zGp1XGHHjQbJh
         wiL52CpeJYQYXtzwvW169Ooex9+paUS0YxQT4uU6GpUJKHwocpq8P5OJp0LENXKOng9V
         oIODLmxZvk6dT4KkgmkgnbZkNGPGPUpS9I5X8aGGjC0r3CVYOq/azZ4tnliWmctPfbVF
         ncWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Fbbhxh4PPBK5DhbGxek1hM5pONPrv64ZqzBYP6IWdgM=;
        b=kKPUBza/SwfW2beI6IRFSMshPIBnwf9ltAx69p32nrw01xAQSr+eu0m1M6Jy7L2Cpm
         JGfGVB+D2K5gZTyl7ntOn/yPy+88hFP0n+GFeSL8SmrPdlqcZZAebyxcRpzgeE2tU/yd
         WhHc4isRrHPtnhvn/NngR9rFRVqUmkXqGT5G+JlbM3+cdbj/wAOcTmVAxG6LSlzuyXTo
         0TvzKb9UzoGgWCzJeTynypReBf7AwW2bDmUoWetc8NKw8qxrofP9IWsCyPXCZ2rpGzzv
         ekj6C85qh907aSDFFrzgrxqp7ItKsq0vkGv9t2TLGLNPvl6Ga5aybiQEPc2L46abmH78
         O4jw==
X-Gm-Message-State: AGi0PuZYGM06AqUN7Uv2WBfzubAbXJZyQpin1b+JrhbEC8lxgdd+1T3U
        SQR5UamIkoBwOKD0ilBdydhnEVOEWMj4KsU=
X-Google-Smtp-Source: APiQypIorS2hJ4gmyi9qP95LIYm3KdrbyIHYeqC6pWNsRz34gbx353DPsWQd/IBRveDhJAwEPuidW0iMVEEj2oQ=
X-Received: by 2002:a25:2583:: with SMTP id l125mr51619838ybl.446.1588101612166;
 Tue, 28 Apr 2020 12:20:12 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:20:05 -0700
Message-Id: <20200428192006.109006-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v1] Revert "Revert "driver core: Set fw_devlink to
 "permissive" behavior by default""
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 18555cb6db2373b9a5ec1f7572773fd58c77f9ba.

The reason[1] for the original revert has now been fixed by
commit 00b247557858 ("driver core: Fix handling of
fw_devlink=permissive"). So, this patch reverts the revert. Marek has
also tested this patch with the fix mentioned above and confirmed that
the issue has been fixed.

[1] - https://lore.kernel.org/lkml/CAGETcx8nbz-J1gLvoEKE_HgCcVGyV2o8rZeq_USFKM6=s7WmNg@mail.gmail.com/T/#m12dfb5dfd23805b84c49f4bb2238a8cce436c2f7
[2] - https://lore.kernel.org/lkml/CAGETcx8nbz-J1gLvoEKE_HgCcVGyV2o8rZeq_USFKM6=s7WmNg@mail.gmail.com/T/#m2408a6ce098b2ebf583ca8534329695923ae57fe
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Greg,

Can you please queue this for 5.8?

Thanks,
Saravana

 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 073045cb214e..c9045521596f 100644
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
2.26.2.303.gf8c07b1a785-goog

