Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C342065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KpCSdog7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgGHMC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgGHMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0ACC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so3825887wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OYcU6QrkQ8vEFK16KZ0JwglvYSsa1RsL+nSDllm7Llo=;
        b=KpCSdog7huLlJl0j5Tz551x3UOHlNMY59WJnYF7IOjTNQ7wGfCYJwMCkY7q/tQQvFB
         tPxTBmOK4P2phupcTbCAGmgW4bl05vYVFXnkPACYCRmO5PurZJ5BotQL4IfIkwBK0vRx
         9AEOsxpeG4po7sQEpY9l227WkEHE3rKVKVmlrH1c3xkFMfY8xEXRsJY0W9lQ1rINQecT
         e8EmCwPRoEPigbSphNAFdzgSsGLRbOtOumrBqaXFbPKvjqEKmzp/E8inOLjAld3mGX0p
         rqYQH6JHXH01TBdNtxnNOBkHOP5k2WyPD6yo7rRy/U875/5DH47Rut8yY7Nx1xj2qTW5
         QrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYcU6QrkQ8vEFK16KZ0JwglvYSsa1RsL+nSDllm7Llo=;
        b=lkUv1nLuYKEkV4t8cKwY7e8+L4ciYyOyao6OWR+FTpAgYKzr/xfB0/XHx0SY81a461
         +GdFqbZVNCs1NOmlpEOyYXxNovOLn0jSj6CNr+YsGM3ydo2TlPQ8EAAg8QZxYavvoQKH
         LQpRX/x+VJSc9kJTWSa/bV3aPayAXODUCM5Xm9z9kD/uOIyb/vdZD8eu1GAhGl6c1t77
         hYpr5L/YRO2MJS/YcQozDfEUfitws0l/BpsJBZIZXmlNSfB5QXeTeFuVFkY2rEvrcTe5
         CeIzDQG+L9okpxvbHtTFnlx/kZt9z8T/0LExwJi/v9/EsUK9pMF8Rp0Rqj35fRUlwfTC
         enHQ==
X-Gm-Message-State: AOAM531pxi1bJnDgEld6MF4cy0AchOkwcVlwojXoBYafCR7M2Tmc1kZk
        5vwuRzfnr+mqgsgszuK1gmu2XQ==
X-Google-Smtp-Source: ABdhPJycC9Sqys7Gmp7jg5AAPUD6iK1Pq5Uk5vSy/gv3EyAVuisDIiJYjEPx39WpB5AD7BroV+e4sA==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr8789530wmk.138.1594209746128;
        Wed, 08 Jul 2020 05:02:26 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/30] scsi: libfc: fc_exch: Supply some missing kerneldoc struct/function attributes/params
Date:   Wed,  8 Jul 2020 13:01:52 +0100
Message-Id: <20200708120221.3386672-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/libfc/fc_exch.c:66: warning: Function parameter or member 'left' not described in 'fc_exch_pool'
 drivers/scsi/libfc/fc_exch.c:66: warning: Function parameter or member 'right' not described in 'fc_exch_pool'
 drivers/scsi/libfc/fc_exch.c:100: warning: Function parameter or member 'lport' not described in 'fc_exch_mgr'
 drivers/scsi/libfc/fc_exch.c:727: warning: Function parameter or member 'ep' not described in 'fc_invoke_resp'
 drivers/scsi/libfc/fc_exch.c:727: warning: Function parameter or member 'sp' not described in 'fc_invoke_resp'
 drivers/scsi/libfc/fc_exch.c:727: warning: Function parameter or member 'fp' not described in 'fc_invoke_resp'

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/libfc/fc_exch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
index 52e8666598531..16eb3b60ed582 100644
--- a/drivers/scsi/libfc/fc_exch.c
+++ b/drivers/scsi/libfc/fc_exch.c
@@ -49,6 +49,8 @@ static struct workqueue_struct *fc_exch_workqueue;
  * @total_exches: Total allocated exchanges
  * @lock:	  Exch pool lock
  * @ex_list:	  List of exchanges
+ * @left:	  Cache of free slot in exch array
+ * @right:	  Cache of free slot in exch array
  *
  * This structure manages per cpu exchanges in array of exchange pointers.
  * This array is allocated followed by struct fc_exch_pool memory for
@@ -60,7 +62,6 @@ struct fc_exch_pool {
 	u16		 next_index;
 	u16		 total_exches;
 
-	/* two cache of free slot in exch array */
 	u16		 left;
 	u16		 right;
 } ____cacheline_aligned_in_smp;
@@ -74,6 +75,7 @@ struct fc_exch_pool {
  * @ep_pool:	    Reserved exchange pointers
  * @pool_max_index: Max exch array index in exch pool
  * @pool:	    Per cpu exch pool
+ * @lport:	    Local exchange port
  * @stats:	    Statistics structure
  *
  * This structure is the center for creating exchanges and sequences.
@@ -702,6 +704,9 @@ int fc_seq_exch_abort(const struct fc_seq *req_sp, unsigned int timer_msec)
 
 /**
  * fc_invoke_resp() - invoke ep->resp()
+ * @ep:	   The exchange to be operated on
+ * @fp:	   The frame pointer to pass through to ->resp()
+ * @sp:	   The sequence pointer to pass through to ->resp()
  *
  * Notes:
  * It is assumed that after initialization finished (this means the
-- 
2.25.1

