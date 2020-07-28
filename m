Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7718DC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458D120759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dbgHyPlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgG1JOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgG1JOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:14:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:14:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so9575999plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kYQwuWrs/m4kOPcfnAtivVDPSr+0itm5vip5k2F3bs=;
        b=dbgHyPlcNQaWVKC7RJHB4RtJ0mFEyk6MrvhfgXOlrqlzIKjFkS9MvMODq1ysgwc8Gd
         JbKUzpJNPcahklKRSMSZuoCpYG+NQzXqYenQEL6MosvE70fGnlnWrUIKCvqgP4cFj1e0
         VHaqQTTrmkkPs506fkNPtDpJA9NwUddycaqZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kYQwuWrs/m4kOPcfnAtivVDPSr+0itm5vip5k2F3bs=;
        b=pWDcVju1CtkcBJdjVm5euUCgZTzZVlVzea60Fk1uwZPj5AmxhUbG2cKSOhCXn9T0BQ
         oAeEUAvsmhFD4dtPRhoR2LnorPhPkIuUrBm1CzSek/Iw52hUOtSB+fJubOPujAqTH8NA
         BVXh3eeSMTh6a9tdG9vNv5+iyeOscOeKngOEfAf9DAcBRPENPIzaCLVr8jRuPGFmvIfO
         YY64D1DzsZf7M84p3cVR4rR8Lh8uKzQWf5q+w6i1yOI7dTblpMcCyLfwkTxtABuNw1qM
         Ar4PZLLMzqs+GzokpblnB8WrXfaVMOotGZljSo8+kv2qrSrO0UwAJqXuN2xcR33o8zR7
         njmA==
X-Gm-Message-State: AOAM532DHj+z21GLT7W+QGo36QVmx3HYA/iSZ6sWrTGpQfV1inRnq+yr
        oYPLlnU/lvVUGzG2iBH5H3KC4Q==
X-Google-Smtp-Source: ABdhPJwlFZw0DGDuX6gDbbyGa42I13BY/zzhh04pzIcFAY25yafKtB3KPm2eYt2Zeh+Nwsvz25OJ6w==
X-Received: by 2002:a17:90a:2c0e:: with SMTP id m14mr3572819pjd.166.1595927650724;
        Tue, 28 Jul 2020 02:14:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id m17sm18293421pfo.182.2020.07.28.02.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 02:14:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     groeck@chromium.org, enric.balletbo@collabora.com,
        bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform: cros_ec: sensorhub: Simplify legacy timestamp spreading
Date:   Tue, 28 Jul 2020 02:13:55 -0700
Message-Id: <20200728091355.2506827-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some machine (nami), interrupt latency cause samples to appear
to be from the future and are pegged to the current time.
We would see samples with this pattern:

[t, t + ~5ms, t + ~10ms, t + ~10ms + 100us, t + ~10ms + 200us],
                             (current now)      (current now)
(t is the last timestamp time)

Last 2 samples would be barely spread, causing applications to
complain.
We now spread the entire sequence. This is not great: in the example
the sensor was supposed to send samples every 5ms, it now appears to
send one every 2.5ms, but it is slightly closer to reality:

sampling time in the example above
At sensor level

1             2             3             4            5
+-----5ms-----+-----5ms-----+-----5ms-----+----5ms-----+---> t

Before, at host level
                       1             2             3 4 5
--interrupt delay------+-----5ms-----+-----5ms-----+-+-+---> t

Afer, at host level
                       1       2       3       4       5
--interrupt delay------+-2.5ms-+-2.5ms-+-2.5ms-+-2.5ms-+---> t

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 94 +++++++------------
 1 file changed, 33 insertions(+), 61 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 1b9637655e63e..0b0bf93073c30 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -719,29 +719,22 @@ done_with_this_batch:
  * cros_ec_sensor_ring_spread_add_legacy: Calculate proper timestamps then
  * add to ringbuffer (legacy).
  *
- * Note: This assumes we're running old firmware, where every sample's timestamp
- * is after the sample. Run if tight_timestamps == false.
- *
- * If there is a sample with a proper timestamp
+ * Note: This assumes we're running old firmware, where timestamp
+ * is inserted after its sample(s)e. There can be several samples between
+ * timestamps, so several samples can have the same timestamp.
  *
  *                        timestamp | count
  *                        -----------------
- * older_unprocess_out --> TS1      | 1
- *                         TS1      | 2
- *                out -->  TS1      | 3
- *           next_out -->  TS2      |
- *
- * We spread time for the samples [older_unprocess_out .. out]
- * between TS1 and TS2: [TS1+1/4, TS1+2/4, TS1+3/4, TS2].
+ *          1st sample --> TS1      | 1
+ *                         TS2      | 2
+ *                         TS2      | 3
+ *                         TS3      | 4
+ *           last_out -->
  *
- * If we reach the end of the samples, we compare with the
- * current timestamp:
  *
- * older_unprocess_out --> TS1      | 1
- *                         TS1      | 2
- *                 out --> TS1      | 3
+ * We spread time for the samples using perod p = (current - TS1)/4.
+ * between TS1 and TS2: [TS1+p/4, TS1+2p/4, TS1+3p/4, current_timestamp].
  *
- * We know have [TS1+1/3, TS1+2/3, current timestamp]
  */
 static void
 cros_ec_sensor_ring_spread_add_legacy(struct cros_ec_sensorhub *sensorhub,
@@ -754,58 +747,37 @@ cros_ec_sensor_ring_spread_add_legacy(struct cros_ec_sensorhub *sensorhub,
 	int i;
 
 	for_each_set_bit(i, &sensor_mask, sensorhub->sensor_num) {
-		s64 older_timestamp;
 		s64 timestamp;
-		struct cros_ec_sensors_ring_sample *older_unprocess_out =
-			sensorhub->ring;
-		struct cros_ec_sensors_ring_sample *next_out;
-		int count = 1;
-
-		for (out = sensorhub->ring; out < last_out; out = next_out) {
-			s64 time_period;
+		int count = 0;
+		s64 time_period;
 
-			next_out = out + 1;
+		for (out = sensorhub->ring; out < last_out; out++) {
 			if (out->sensor_id != i)
 				continue;
 
 			/* Timestamp to start with */
-			older_timestamp = out->timestamp;
-
-			/* Find next sample. */
-			while (next_out < last_out && next_out->sensor_id != i)
-				next_out++;
+			timestamp = out->timestamp;
+			out++;
+			count = 1;
+			break;
+		}
+		for (; out < last_out; out++) {
+			/* Find last sample. */
+			if (out->sensor_id != i)
+				continue;
+			count++;
+		}
+		if (count == 0)
+			continue;
 
-			if (next_out >= last_out) {
-				timestamp = current_timestamp;
-			} else {
-				timestamp = next_out->timestamp;
-				if (timestamp == older_timestamp) {
-					count++;
-					continue;
-				}
-			}
+		/* Spread uniformly between the first and last samples. */
+		time_period = div_s64(current_timestamp - timestamp, count);
 
-			/*
-			 * The next sample has a new timestamp, spread the
-			 * unprocessed samples.
-			 */
-			if (next_out < last_out)
-				count++;
-			time_period = div_s64(timestamp - older_timestamp,
-					      count);
-
-			for (; older_unprocess_out <= out;
-					older_unprocess_out++) {
-				if (older_unprocess_out->sensor_id != i)
-					continue;
-				older_timestamp += time_period;
-				older_unprocess_out->timestamp =
-					older_timestamp;
-			}
-			count = 1;
-			/* The next_out sample has a valid timestamp, skip. */
-			next_out++;
-			older_unprocess_out = next_out;
+		for (out = sensorhub->ring; out < last_out; out++) {
+			if (out->sensor_id != i)
+				continue;
+			timestamp += time_period;
+			out->timestamp = timestamp;
 		}
 	}
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

