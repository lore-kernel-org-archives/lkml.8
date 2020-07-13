Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DB5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8643C2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2Mzc5cK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgGMIAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgGMIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:00:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so14747546wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fObO+NKzZNjEK6DSZvXqA6TGAzJL4t9qXWkp6FNxmnE=;
        b=N2Mzc5cK/DpyZPqIlBKHUbHldktqieYQnYpoJngPtM+DhVjf8sbqzJy2zlwdIK1ucB
         bqXpqOZfH4eMO1zu2uNcjxXrvg6xQ/giuVGXDWkUxiloujAPRT/l/hElQBpweVZghVMi
         aJI/Q17SLycxCSjE+ycakn0d+aLLUSym+f4DFq1vcyFWkxvgmluIMBLDAoQwyj2Umi7K
         IlYZHqAdD7cMyUSWElO7iVNBvG5nSzaq23ohZ/IFdFxpy0ebE/3OLbY+pp8fR02CtSt0
         keZIuZCGbFCJirxx0QSvWia7iqxhDxgEFO3OcxvbhdzAXy3+gfOBlPLnsgLDuMCnui1y
         oWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fObO+NKzZNjEK6DSZvXqA6TGAzJL4t9qXWkp6FNxmnE=;
        b=DeNO7P/T+OCB6UoKFmGh59A1e0Ej9cx2R1WQDuJDAfj0EKLFR2/Ard6EqLMDqBACqs
         0kZ3aavVvpv5WfMsMHFU0jDWnJUr+B0ryY/YBf6YTGhIoANOS+pCZ4WzHBf9DW/EtKCI
         aqLgwENEEgfQ3EtaStZcO47NPvTNYd9nAISp1w4ndF44fAcYEOQNkDZN3bS/LGHcKOo3
         BYXWc+ZTT72cgO3fQeDYvUofZW0azCseR0Bt5FY7knXIEF2EFZGrtitPhaILDL8RuaTS
         e5XcUf7IPmTDxpIEDvYjT9XG3YocqvCDZV+JAI9BB6rZP3pj4LmvGZs9U+bf5QpIOvEC
         MDhA==
X-Gm-Message-State: AOAM533LB3BnkJlnf8nJq31I0yVUQHMH3De+w7+HbvPYvsL5KWGip7j7
        bDKTkyb6FmMvM5jJCGSQniumLw==
X-Google-Smtp-Source: ABdhPJwW3t5xWfFm2/Dwj6Tum4pGcl/MITFPEo8AKRohUzEqg85jlPwfdAKgGB8gAtcC46Qzvb9Wlg==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr78591987wrv.21.1594627235183;
        Mon, 13 Jul 2020 01:00:35 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id 33sm24383549wri.16.2020.07.13.01.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:00:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 24/24] scsi: aic7xxx: aic79xx_osm: Remove set but unused variabes 'saved_scsiid' and 'saved_modes'
Date:   Mon, 13 Jul 2020 09:00:01 +0100
Message-Id: <20200713080001.128044-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713080001.128044-1-lee.jones@linaro.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haven't been used since 2006.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic7xxx/aic79xx_osm.c: In function ‘ahd_linux_queue_abort_cmd’:
 drivers/scsi/aic7xxx/aic79xx_osm.c:2155:17: warning: variable ‘saved_modes’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/aic7xxx/aic79xx_osm.c:2148:9: warning: variable ‘saved_scsiid’ set but not used [-Wunused-but-set-variable]

Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 3782a20d58885..140c4e74ddd7e 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -2141,14 +2141,12 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 	u_int  saved_scbptr;
 	u_int  active_scbptr;
 	u_int  last_phase;
-	u_int  saved_scsiid;
 	u_int  cdb_byte;
 	int    retval;
 	int    was_paused;
 	int    paused;
 	int    wait;
 	int    disconnected;
-	ahd_mode_state saved_modes;
 	unsigned long flags;
 
 	pending_scb = NULL;
@@ -2239,7 +2237,6 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 		goto done;
 	}
 
-	saved_modes = ahd_save_modes(ahd);
 	ahd_set_modes(ahd, AHD_MODE_SCSI, AHD_MODE_SCSI);
 	last_phase = ahd_inb(ahd, LASTPHASE);
 	saved_scbptr = ahd_get_scbptr(ahd);
@@ -2257,7 +2254,6 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 	 * passed in command.  That command is currently active on the
 	 * bus or is in the disconnected state.
 	 */
-	saved_scsiid = ahd_inb(ahd, SAVED_SCSIID);
 	if (last_phase != P_BUSFREE
 	    && SCB_GET_TAG(pending_scb) == active_scbptr) {
 
-- 
2.25.1

