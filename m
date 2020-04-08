Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5DDC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FB620730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRoJybSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgDHSRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:17:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43596 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbgDHSRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:17:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id z6so1314640plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JeU+n6VZS/NWtSXdg0vnR7Ls7ou5phTdOeG8jlvTQLA=;
        b=VRoJybSzC5pfiXpAOqSO7PyBIdg5lvn+c32vJtamMdcA5bpxQd1jxWKTWbrPCjmryM
         3Q4TLWGb71vBuIBPtluUI19WDppfYAPwVpm6KCCR6d8jSf2DscyPfS9ewrqaEj6UQdNZ
         VG5YzC9KsnSLEx73yQV7uUpwmwXWwaMiZdMEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeU+n6VZS/NWtSXdg0vnR7Ls7ou5phTdOeG8jlvTQLA=;
        b=OEo/34REXq3AF6o0NRPIpZcO7xQ5dMgkCC8uGU3i554OkkTSq86M0MCTVpJKKi5pAd
         7fxjuwKn4O1NbHmGrWdvuXNrfiS4f/S/v3JIG6hckMqwPVpCHMEUYYMGTczhbmNTcHsL
         D0YjRrK2gC8X2JAdvyvCjhyZ8SNPWTh9OLLhnhUCipE4rzvKDqDnrPn4uPJ2Q8ucM0ly
         LX/1SY2eiHyxTNexG5AxkeXnSEDXdx6i4Kh47oDsyOti8Fo802jgmrhuArrDAjzopNk1
         q3d0TNf7Bos23nVFxdgxRqyTIY3eG5cgb8iscLlqokQvhb43ECe1xLp/im+1XR9F9bhc
         w1LQ==
X-Gm-Message-State: AGi0PuZ2kcCz3QoJVGgvm+cH3iTysRwwzcZNTslTYuMJX4waToi1rS4x
        A7EOOGQ/7LeVJSGFpbhUJNFSRjpAsR1GpA==
X-Google-Smtp-Source: APiQypJRrb60qRAjUQ/dAUHiNFQsuZb4oJmZ2mLKarzN7UGnRW2BvJO12GJ05PuqVLekSZQgzsesBQ==
X-Received: by 2002:a17:90a:2264:: with SMTP id c91mr6811461pje.43.1586369832229;
        Wed, 08 Apr 2020 11:17:12 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id e27sm1347074pfl.219.2020.04.08.11.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:17:11 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jett Rink <jettrink@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mathew King <mathewk@chromium.org>
Subject: [PATCH 2/2] platform/chrome: free ishtp buffer before sending event
Date:   Wed,  8 Apr 2020 12:16:38 -0600
Message-Id: <20200408181638.184559-2-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200408181638.184559-1-mathewk@chromium.org>
References: <20200408181638.184559-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jett Rink <jettrink@chromium.org>

Free the buffer as soon as we can to ensure we are using the least
amount of buffers as possible.

Signed-off-by: Jett Rink <jettrink@chromium.org>
Signed-off-by: Mathew King <mathewk@chromium.org>
---
 drivers/platform/chrome/cros_ec_ishtp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 6f90deb5cf55..7d27850b9235 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -303,6 +303,10 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
 		       rb_in_proc->buffer.data, data_len);
 
 error_wake_up:
+		/* Free the buffer since we copied data or didn't need it */
+		ishtp_cl_io_rb_recycle(rb_in_proc);
+		rb_in_proc = NULL;
+
 		/* Set flag before waking up the caller */
 		client_data->response.received = true;
 
@@ -312,12 +316,14 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
 		break;
 
 	case CROS_MKBP_EVENT:
+		/* Free the buffer. This is just an event without data */
+		ishtp_cl_io_rb_recycle(rb_in_proc);
+		rb_in_proc = NULL;
 		/*
 		 * Set timestamp from beginning of function since we actually
 		 * got an incoming MKBP event
 		 */
 		client_data->ec_dev->last_event_time = timestamp;
-		/* The event system doesn't send any data in buffer */
 		schedule_work(&client_data->work_ec_evt);
 
 		break;
@@ -327,8 +333,9 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
 	}
 
 end_error:
-	/* Free the buffer */
-	ishtp_cl_io_rb_recycle(rb_in_proc);
+	/* Free the buffer if we already haven't */
+	if (rb_in_proc)
+		ishtp_cl_io_rb_recycle(rb_in_proc);
 
 	up_read(&init_lock);
 }
-- 
2.26.0.292.g33ef6b2f38-goog

