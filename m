Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83245C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BA4207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/1o22f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgGIRql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgGIRq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:46:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A237C08E763
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 10:46:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so2849075wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npmbMmGwXmpaLu61Oedwmcs3qT0N7Ml8rtlLxMj9sy4=;
        b=F/1o22f0o/hLVmprlDU9Qr//sGwjrN5uBf5VsCAcjtijVd/dT2CI6MVzsvcskMRGpZ
         +7cVcba0uHIIcgEY9PEBnLie35L9sAdxl1kb5OP4V/14j6/iSyuyPkpHNPh6umlOFV5P
         JAcC8hsTvn+aAiUw9vEP7h1rTfAOwi1xSxFifbmG7f+W9zEmx/J1szmQPv5cF9isaQz2
         11rRmpTP/QRS6mWFSA1OvmVkmlXzipShH9+vRqUKXADfPgY9EtY61uynWcnPhndfAzSS
         jEiICGMcO0EtQPWeUAviR025+ZT/97yCIFkrUBkeDpLOoWW52ZX0T/yiI18fZit3cQkl
         dbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npmbMmGwXmpaLu61Oedwmcs3qT0N7Ml8rtlLxMj9sy4=;
        b=kROrPoS2U1/cpH65tdIsk9HDmTE13Sjh0aqoXU5Mr2qhmMem7IZDnGA/x/wUj+LGls
         wKd6eH1W+71ogWvkLYI+b7gM+16VlRiQWcMlMW6cmIRk8GzB4WcT7g0siOqQChvo3Ncp
         sNLvJAolNTm/2khHPj+I7eoyelU7qWcj3heT1bQJI5Ui1Nq3uU5N0qAV/MIGSfT1pGzd
         wJU4TdumW/1KHtJ5WlWBBLCCsw2n8//1a/S7j90JuyR29fJyPPxEMLugff5Yu3iE2Y+2
         RdjUBY7lI9RZfMxaJQX888jxzIvjSaBXSNCkciOl3KSG9QLx6lDN6XN7w8NA1/m6BFvI
         fk7Q==
X-Gm-Message-State: AOAM530hOVOp2RP4CwArI2YqxpXYB3kIE6B5xsK7s+Pwyi6N5Ralybb4
        SuqdXFmVFqDOsTERyqRRex7Qtg==
X-Google-Smtp-Source: ABdhPJyK0cTHJi/HHlU/eCy0bAteTij1tSUpRhma9IuaO7nlZzYQAcrF4E3VmyYJ9+nrGYNfRBh1Fg==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr1170635wmj.39.1594316784135;
        Thu, 09 Jul 2020 10:46:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id f15sm6063854wrx.91.2020.07.09.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:46:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 22/24] scsi: aic7xxx: aic79xx_osm: Remove unused variables 'wait' and 'paused'
Date:   Thu,  9 Jul 2020 18:45:54 +0100
Message-Id: <20200709174556.7651-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709174556.7651-1-lee.jones@linaro.org>
References: <20200709174556.7651-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like they have never actually been used.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic7xxx/aic79xx_osm.c: In function ‘ahd_linux_dev_reset’:
 drivers/scsi/aic7xxx/aic79xx_osm.c:782:9: warning: variable ‘wait’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/aic7xxx/aic79xx_osm.c:781:9: warning: variable ‘paused’ set but not used [-Wunused-but-set-variable]

Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 9235b6283c0b3..8e43ff86e0a60 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -775,16 +775,13 @@ ahd_linux_dev_reset(struct scsi_cmnd *cmd)
 	struct scb *reset_scb;
 	u_int  cdb_byte;
 	int    retval = SUCCESS;
-	int    paused;
-	int    wait;
 	struct	ahd_initiator_tinfo *tinfo;
 	struct	ahd_tmode_tstate *tstate;
 	unsigned long flags;
 	DECLARE_COMPLETION_ONSTACK(done);
 
 	reset_scb = NULL;
-	paused = FALSE;
-	wait = FALSE;
+
 	ahd = *(struct ahd_softc **)cmd->device->host->hostdata;
 
 	scmd_printk(KERN_INFO, cmd,
-- 
2.25.1

