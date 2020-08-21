Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D8120720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP/ta4SH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHUSQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8183C061573;
        Fri, 21 Aug 2020 11:16:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so1456625pfw.9;
        Fri, 21 Aug 2020 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SS7vNgp0D8obWt3XUwJWxxhAuelaFdMvAImhK0r+LqU=;
        b=eP/ta4SH9ogGRXGr6WZvtL8nGeEsws3H/7GJChPnLia/Im38Vt5keWrx/rjNyRYpCf
         S7q3RFFpQDc+yhWWc4OGCRcXhOUYZWbDFfJpwJOqegKZ8oXQtkdLQsbDF5BQAmboNDvl
         97TwWSPIpVK6Susr8i21P82x0qNmOoaiVE8GY1mrVyTSpVNB7oTI31uFY2v/qgQl7s46
         GGJhMiyvK+eBgxVD6nLTRQV8WC2vBuPr+k69qDuSoydip17E8JlL7gFlAWV3aMhU3+i8
         46FGFabqlWKAJqlBWkkvhrM/mS4D3BW7CZschlaRkplp+akLIQLVJ+4NPoxLIpQ18uUb
         vYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SS7vNgp0D8obWt3XUwJWxxhAuelaFdMvAImhK0r+LqU=;
        b=iUe7RTc02GUKuz2Gko7cCKyUr/opB+UEeuD+FYH8PDQ/ZUs7XE6ZAuSgB/njdOWtO+
         fz1pCqaCZxFSyr6Spv0PAlTwhm01jNPdG9oisK1SDFkVEmloZvTBOq+98nFM/fQCKboP
         +1uvUiLk3tgZWuyBgpRTeHXXpX0L1KMai+wPTk1fRQBZKJb9Xmk1iVQM1Hp5RhFQLnmH
         8KB15JZWFNXdn6kHM70COBRAbnGBli6u9MVYiEm1h2dloSY2RGQW9A9rjQV+chHX8Hk2
         azKIQIxssK2IfZv4nUEta0WI9+SN3enqKXzZZddp2sszcSSTdgGg9sQhF89IkGMvpK3t
         /rWQ==
X-Gm-Message-State: AOAM532hJDrhvLlSYYSlOEoYy00/wg4bsBat+4gNx5f3Rtta/wmLOgJf
        5Nq6szV5uSWTQOeOV/EmJMvwixByahmjvw==
X-Google-Smtp-Source: ABdhPJy85AiD5bM8YBVzcuUCdx5C+w0yjOLzlu8DWoPebpjsu9GcymWhMIQUhfLBVv+SyBfHF9rRfA==
X-Received: by 2002:a63:4545:: with SMTP id u5mr3109696pgk.229.1598033792126;
        Fri, 21 Aug 2020 11:16:32 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:31 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 3/9] split MODULE_AUTHOR() by one author per macro call
Date:   Sat, 22 Aug 2020 02:14:27 +0800
Message-Id: <20200821181433.17653-4-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In reply to https://lkml.org/lkml/2020/8/19/186 to split MODULE_AUTHOR()
per macro call.


Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 7170c36577bf..162b6c560af1 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -13,6 +13,7 @@
  *
  * ChangeLog:
  *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *			split MODULE_AUTHOR() by one author per macro call
  *			replace ACPI prints with pr_*() macros
  *		-v0.97	add support for cdpower hardware switch
  *		-v0.96	merge Lucina's enhancement
@@ -125,7 +126,11 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/platform_device.h>
 
-MODULE_AUTHOR("Hiroshi Miura, David Bronaugh and Harald Welte");
+MODULE_AUTHOR("Hiroshi Miura <miura@da-cha.org>");
+MODULE_AUTHOR("David Bronaugh <dbronaugh@linuxboxen.org>");
+MODULE_AUTHOR("Harald Welte <laforge@gnumonks.org>");
+MODULE_AUTHOR("Martin Lucina <mato@kotelna.sk>");
+MODULE_AUTHOR("Kenneth Chan <kenneth.t.chan@gmail.com>");
 MODULE_DESCRIPTION("ACPI HotKey driver for Panasonic Let's Note laptops");
 MODULE_LICENSE("GPL");
 
-- 
2.17.5

