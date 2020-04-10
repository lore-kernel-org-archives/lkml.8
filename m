Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D02BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257F520857
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jrKTM89N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDJQXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:23:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42385 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgDJQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:23:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id v2so802729plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lfx3tjaOBOzaW9h0e1NHY7R45MyYzBd77LVWDJwb7c=;
        b=jrKTM89NWarNDGkzWQeV2RHja8BiVq0r76KzJHL55eZ4Xykhu9ygG4m7HbaqDQZlTJ
         33frEQMVpj2Ci6tX5EXpGIXDlDXUJKoZWjLZHmBEAOmj0EVZf0O4SIqvlZiTxX4Vdned
         kQYXcLhWADTpRgIRMMyqUO9dezuwUawGjYyRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lfx3tjaOBOzaW9h0e1NHY7R45MyYzBd77LVWDJwb7c=;
        b=ATjvjQlMBCpClgh6+NQgzNzWruRk408KGFgA/1TtwhZQPTx8JawIfx+m9R5P4v7YGx
         uL/QxjW+PAEeSRYfY3OrDF2y1QHGWlLLjlfAUGIx9CCRt1lbnwEAPuivwOjDVgbV05gv
         zSrIVHwBHf2ls4JMYmTrN6IPbDosdhRzwZhIDEo82R9M1za7yjCdsh9hjFXxj6rUdzvz
         X8SP5ZcHG/ofmjzPaQjZwo1Reh5f0eyy7oxhMBBMGTMmN1YM8dYwU4n+2j42EKYscPSV
         8B85iDX4P1Iu9UZpImqQXb/AF12h+Wq8j+te3r/0GMFhPo/KWn8gVQ8iWZYJXr85aBR6
         92Aw==
X-Gm-Message-State: AGi0PuYoZ7D4WPiG4UtsdqY/nuRn3n2u9c30HBhcib/QWtBnc82jqq7L
        krtsmm18m8NwPQ/mHEcBUJNrs8pGbMGZLg==
X-Google-Smtp-Source: APiQypI06UFeO82Nn6452eDgLyA7WAeQB3fbihVYiQ9w3yje5QiSYfvYC4AEzwzWENW5OcNnmMrt1w==
X-Received: by 2002:a17:902:988e:: with SMTP id s14mr5261529plp.179.1586535802158;
        Fri, 10 Apr 2020 09:23:22 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id c4sm1977138pgg.17.2020.04.10.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 09:23:21 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jett Rink <jettrink@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Mathew King <mathewk@chromium.org>
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_ishtp: free ishtp buffer before sending event
Date:   Fri, 10 Apr 2020 10:23:05 -0600
Message-Id: <20200410162305.76638-2-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410162305.76638-1-mathewk@chromium.org>
References: <20200410162305.76638-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jett Rink <jettrink@chromium.org>

Recycle the ISH buffer before notifying of a response or an event. Often
a new message is sent in response to an event and in high traffic
scenarios this can lead to exhausting all available buffers. We can
ensure we are using the fewest buffers possible by freeing buffers as
soon as they are used.

Signed-off-by: Jett Rink <jettrink@chromium.org>
Signed-off-by: Mathew King <mathewk@chromium.org>
---
v2: Reword the commit message
---
 drivers/platform/chrome/cros_ec_ishtp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index e673a7f738fc..ed794a7ddba9 100644
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
2.26.0.110.g2183baf09c-goog

