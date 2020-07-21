Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A6C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516ED207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6ljrpG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgGUQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbgGUQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8C3C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so21824062wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFXXcNYactXc03hl2acSO1gvLgU0ADiqS4Auy98l0Ek=;
        b=b6ljrpG1EBF8IfhnjjV9k/S7OREAseaGQxNSLkLYKHkKZJBOk9TyJQ6aN7cMbJCWmo
         TWg+czz5+3cY/e00jtry4YPNKz/1Un/eKvxxPoEBSy1ABFa9+ZRMCOiX4LRuqJJAgTFK
         XEdFtrY0iMyK6biVDcN8fLUekyA+5GhfJP8IHVLeO3pthjgI7J1QdhbJD88EqUFrzHud
         i05ROZExH4J4wpxKfaPLEUqw9NwN9E3iDbD8Ge/QVeW2dghGLGWjj+SkHWhbK0q8WvxL
         Z+crzAn5cVkg2anjn8tNPmxxZYgi+ImE874vwd2jyxyFn/QQm5W8UL0eKkCO0C91kUaC
         qJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFXXcNYactXc03hl2acSO1gvLgU0ADiqS4Auy98l0Ek=;
        b=rKefqlNl8Jbr5JbJv5XkZKwmh/Z3Xr4KWTwQS9KIDHRDn9e+7ouGj6mj6SyapYGes6
         IS8p2LQMhW4ol6sUa7m2SQtgUdlnpjxiiBPYr3i5xX/QHjO8w6Vi57ujdFUTDXpPmrUT
         L3nyWLtE9AYRYWoWG+vKVMfx0WtLEs/wexHcK/mP4ytlJw3M+QDRsH5o1XmzAuWexjSJ
         4t9QjRgqNBFZzECH3RH1TUAsXAbbUshojTEe8/zPdYJsXteoBmjS8PB9nZYsy9VhOvZd
         SN8GYWGoKK4q67+5qIVoAfubibXU1kA9pp9EfyANwL07k3Hxn18plBnYAi8lSfvo+qii
         7wKA==
X-Gm-Message-State: AOAM532YqVD0FRH8iSD9A47zT91KK+cWO2HGHPcIFwhdJE0RO3JTx+qh
        zYI6YlFv12LblFsnAbhzgCx+vw==
X-Google-Smtp-Source: ABdhPJx5Vgcvu8Pi2zkAFdv/mslhqs0TbRTs+9Cdw+rKjfr1GY81oGtszzL+LPdv7pDWlsxbh7Sb6Q==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr27051879wrm.65.1595349724716;
        Tue, 21 Jul 2020 09:42:04 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:42:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH 07/40] scsi: aacraid: src: Add descriptions for missing parameters
Date:   Tue, 21 Jul 2020 17:41:15 +0100
Message-Id: <20200721164148.2617584-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'p2' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'p3' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'p4' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'p5' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'p6' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'status' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'r1' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'r2' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'r3' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Function parameter or member 'r4' not described in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:203: warning: Excess function parameter 'ret' description in 'src_sync_cmd'
 drivers/scsi/aacraid/src.c:609: warning: Function parameter or member 'dev' not described in 'aac_src_ioremap'
 drivers/scsi/aacraid/src.c:639: warning: Function parameter or member 'dev' not described in 'aac_srcv_ioremap'

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/src.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index 787ec9baebb0b..11ef58204e96f 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -191,7 +191,16 @@ static void aac_src_enable_interrupt_message(struct aac_dev *dev)
  *	@dev: Adapter
  *	@command: Command to execute
  *	@p1: first parameter
- *	@ret: adapter status
+ *	@p2: second parameter
+ *	@p3: third parameter
+ *	@p4: forth parameter
+ *	@p5: fifth parameter
+ *	@p6: sixth parameter
+ *	@status: adapter status
+ *	@r1: first return value
+ *	@r2: second return valu
+ *	@r3: third return value
+ *	@r4: forth return value
  *
  *	This routine will send a synchronous command to the adapter and wait
  *	for its	completion.
@@ -602,6 +611,7 @@ static int aac_src_deliver_message(struct fib *fib)
 
 /**
  *	aac_src_ioremap
+ *	@dev: device ioremap
  *	@size: mapping resize request
  *
  */
@@ -632,6 +642,7 @@ static int aac_src_ioremap(struct aac_dev *dev, u32 size)
 
 /**
  *  aac_srcv_ioremap
+ *	@dev: device ioremap
  *	@size: mapping resize request
  *
  */
-- 
2.25.1

