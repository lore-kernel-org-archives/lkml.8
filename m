Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA849C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962C4207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6AauQ8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgGUQmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgGUQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:41:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D7C0619DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:41:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so6911847wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQB8TJQzsYjUZBwJPjslVDnhdOA5qUDUD1fBX7WXUPw=;
        b=s6AauQ8n56Hd4FuksA+gkR8KcO9HBr/y6WUo10QyX3zvi4KAoo8+pZGmdak7ERDzuV
         99OYlw2c0rBlQcpHR5AP7iL5o0uYUuAffpzjEfw7am78q86szC6f5DAuBHh4UWEVjoaO
         hSAA3xaX/ctyBuWRAMXgf97VJQ9wjV5RUV+B5njvjm5ttZorOXk4ij2gxsK5T8JReCsW
         twGHiGASNEmU9FKGC5yO3ToaNDbFNWjGipKnR3HXaUrMrP395Z+Zit3sOPKYSMfpO8Wo
         3Jzy0Z+UVwiIFRyAyq5TfgPoW+nAPdnV3CLV27XK5GtLjCYXHJHegxTAkNfRibTaN0Pv
         B86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQB8TJQzsYjUZBwJPjslVDnhdOA5qUDUD1fBX7WXUPw=;
        b=QUtAK31+YbfJA4SN142paMoibTuK48l+lM6ftqNbJ78MLUuo77rOQPAv2HpbIxn6z9
         eMwu/RGWYolGZ3d98EneVQgViZYV7LYXU50+Cz7abSHdarw+cNdYu2MU2Em0qVBLnWHk
         cw1hDiMbA7SimEVL6nAqRHwPPDjiBaYAnAVXIM707cesENH+bWLJS81yCf0OQiMAM2v0
         KWAbse3HO3TTZJgssyoHlpSqzNYEyKx7EJydJrmwQkA6PyW/0Z5DjGihIh0jZtB670yG
         OjGHlVzcVzZLdGVGGXW1A1CDPHxqC8eNp1GNWKDChlkCInNNvl5eW84LpDaw0KVx6+6v
         HsZQ==
X-Gm-Message-State: AOAM530kOWxJFbfqCMAQgIZYzn6f5xBKzSAJ1c6tMF97tUVZJEqzIALl
        K62NGXIuS/YDQLpknQbrfQxoBg==
X-Google-Smtp-Source: ABdhPJzqVFUhEYcBj5F93TGNUEsD1EfN6i9w06bfn1uhF2Sea76Z9iPfHB6hxsL5qavUoAFZVrY+jQ==
X-Received: by 2002:adf:97c1:: with SMTP id t1mr1257176wrb.294.1595349716252;
        Tue, 21 Jul 2020 09:41:56 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:41:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH 03/40] scsi: aacraid: sa: Add descriptions for missing parameters
Date:   Tue, 21 Jul 2020 17:41:11 +0100
Message-Id: <20200721164148.2617584-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also clean-up some white space issues while we're here.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/sa.c:147: warning: Function parameter or member 'p2' not described in 'sa_sync_cmd'
 drivers/scsi/aacraid/sa.c:147: warning: Function parameter or member 'p3' not described in 'sa_sync_cmd'
 drivers/scsi/aacraid/sa.c:147: warning: Function parameter or member 'p4' not described in 'sa_sync_cmd'
 drivers/scsi/aacraid/sa.c:147: warning: Function parameter or member 'p5' not described in 'sa_sync_cmd'
 drivers/scsi/aacraid/sa.c:147: warning: Function parameter or member 'p6' not described in 'sa_sync_cmd'
 drivers/scsi/aacraid/sa.c:147: warning: Function parameter or member 'r1' not described in 'sa_sync_cmd'
 drivers/scsi/aacraid/sa.c:147: warning: Function parameter or member 'r2' not described in 'sa_sync_cmd'
 drivers/scsi/aacraid/sa.c:147: warning: Function parameter or member 'r3' not described in 'sa_sync_cmd'
 drivers/scsi/aacraid/sa.c:147: warning: Function parameter or member 'r4' not described in 'sa_sync_cmd'
 drivers/scsi/aacraid/sa.c:290: warning: Function parameter or member 'dev' not described in 'aac_sa_ioremap'

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/sa.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/aacraid/sa.c b/drivers/scsi/aacraid/sa.c
index aa5d7638cade2..c9a1dad2f5636 100644
--- a/drivers/scsi/aacraid/sa.c
+++ b/drivers/scsi/aacraid/sa.c
@@ -135,13 +135,21 @@ static void aac_sa_notify_adapter(struct aac_dev *dev, u32 event)
  *	@dev: Adapter
  *	@command: Command to execute
  *	@p1: first parameter
+ *	@p2: second parameter
+ *	@p3: third parameter
+ *	@p4: forth parameter
+ *	@p5: fifth parameter
+ *	@p6: sixth parameter
  *	@ret: adapter status
+ *	@r1: first return value
+ *	@r2: second return value
+ *	@r3: third return value
+ *	@r4: forth return value
  *
- *	This routine will send a synchronous command to the adapter and wait 
+ *	This routine will send a synchronous command to the adapter and wait
  *	for its	completion.
  */
-
-static int sa_sync_cmd(struct aac_dev *dev, u32 command, 
+static int sa_sync_cmd(struct aac_dev *dev, u32 command,
 		u32 p1, u32 p2, u32 p3, u32 p4, u32 p5, u32 p6,
 		u32 *ret, u32 *r1, u32 *r2, u32 *r3, u32 *r4)
 {
@@ -283,6 +291,7 @@ static int aac_sa_check_health(struct aac_dev *dev)
 
 /**
  *	aac_sa_ioremap
+ *	@dev: device to ioremap
  *	@size: mapping resize request
  *
  */
@@ -300,8 +309,8 @@ static int aac_sa_ioremap(struct aac_dev * dev, u32 size)
  *	aac_sa_init	-	initialize an ARM based AAC card
  *	@dev: device to configure
  *
- *	Allocate and set up resources for the ARM based AAC variants. The 
- *	device_interface in the commregion will be allocated and linked 
+ *	Allocate and set up resources for the ARM based AAC variants. The
+ *	device_interface in the commregion will be allocated and linked
  *	to the comm region.
  */
 
-- 
2.25.1

