Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA080C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB6B20848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iPl0Mhlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgH0UmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0Ul7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:41:59 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89807C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:41:59 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so7239584iod.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EoftoojDAeVQX8wY//7x/4UEhS50XaZvmdzOjteBfD8=;
        b=iPl0MhlqabvHFYLDmYvok+Mrp6RvrqRbSln+E29jFumpS4aG52HkTFqVGZNsjWqYwN
         zN0LhwmdAQtnGBhDxWEHM9GFn3gjWiKp0q7V77nvFhDbDO2Yji8oRr/M/plDLHaiB5qX
         xAjbLaMe7V9I68zWkeJev/SnhldaRBAisJBSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoftoojDAeVQX8wY//7x/4UEhS50XaZvmdzOjteBfD8=;
        b=rXaSbBjn54HhgxUztX76wf/tXkVfz0QJ07zwa7/6RqcZ3FqJ/46mzx2facMOEnTSML
         YNYx8hHppQZ8lHGuAbxSQmhl1cMJQiO4lwrGYNlLPlFXrDCLbBp0bpI8u5/XxNWkEmbQ
         sLSuxfFEGTKF8rb8Sytb8mvwqOVyTujUp62hb1SeA80nyme+7j5H/SmrvD54eB6ORA/E
         6wqxTbelMczW9CYTVZyZrOl3UKt/IiEq0kAACfFnqdmZ2yBH3cUd05vwQV7ZYJv6BX2h
         A4PVK4j2zDNoWD/MWI8WWXM84GStRHXgNvBQamgJq6hxNFDrwqulsD6zUZgvFr/C2coM
         bX3g==
X-Gm-Message-State: AOAM531GCTwMtEqm0qMmQeLNmAjITPJ+3mIgZE7R0/cYpyBVmB2I+vq9
        7qZWbjp/p5VvGRpNn3yxID03xg==
X-Google-Smtp-Source: ABdhPJwUUS+SW6nQgzx12+Hfezv3y+Z7TwGFeh9cjJ9mkhkwvKbByOPK1VP/r2YVwSiB6ImEx1Rk9g==
X-Received: by 2002:a05:6638:12d4:: with SMTP id v20mr20156929jas.108.1598560918954;
        Thu, 27 Aug 2020 13:41:58 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id u17sm1640328ilj.0.2020.08.27.13.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 13:41:58 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, Shirish.S@amd.com,
        Raul E Rangel <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Input: i8042 - Lock i8042_mutex before flushing
Date:   Thu, 27 Aug 2020 14:41:54 -0600
Message-Id: <20200827144112.v2.2.I1417edfd3526143f14fea2546787ba4bb6f32ae8@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200827144112.v2.1.I6981f9a9f0c12e60f8038f3b574184f8ffc1b9b5@changeid>
References: <20200827144112.v2.1.I6981f9a9f0c12e60f8038f3b574184f8ffc1b9b5@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make i8042_flush lock the i8042_mutex before flushing the buffer. This
will prevent i8042_flush from clearing the buffer while a PS/2 command is
in progress. I'm not sure if this is really possible. We already
hold the lock when calling i8042_command, so this makes i8042_flush have
the same behavior.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

 drivers/input/serio/i8042.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 65ca6b47f41e8..b7ed93c5095c4 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -254,6 +254,8 @@ static int i8042_flush(void)
 	int count = 0;
 	int retval = 0;
 
+	mutex_lock(&i8042_mutex);
+
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	while ((str = i8042_read_status()) & I8042_STR_OBF) {
@@ -270,6 +272,8 @@ static int i8042_flush(void)
 
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
+	mutex_unlock(&i8042_mutex);
+
 	return retval;
 }
 
-- 
2.28.0.297.g1956fa8f8d-goog

