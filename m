Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D421EC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F6720737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hjHu74Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGXTIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGXTIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:08:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1742AC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:08:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w126so5561517pfw.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLe/OdSp6Fw1TtsCd8Mn/UyE/yt0Kzj/0i9kStm4nAs=;
        b=hjHu74TsssCcfZJhkXtNq32lhCkRo3h18fghgfFy13uqjRo3Qj3Pzgeozq1tv0BNZu
         S7svZRtcA8Zif0+u/pNMUSmozeA/8r7dwQjwC2rUnX9dr0CeRgbHGZX28TQ5Z2xeCi4O
         ePioeZdXUJvV1uEOQFDvjdJbYr5eLvByuzQng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLe/OdSp6Fw1TtsCd8Mn/UyE/yt0Kzj/0i9kStm4nAs=;
        b=raHOYtxTC8JkmgPTjTYfwlW312u2JXQD5/mCblG5Rx3gHtwn1Dplfy2q908HHraq62
         edOo9OxQkWnMwGy6ewPaaS/iajFfN4GYb3GKH36nQmmGM5lvncOxXmi+0P5R/iUMvsbv
         dvVjKW8cjfzGmJmuecOd2gKf8krk6gIXDBR2IjBP1KVli34PIS06bCGlYkhklx0Whkgr
         n0HbRXwOn4eorOENl0AQWvAT3Wrp1K+AU1KOJPxFpiApT8ibCpJ6+YapZXv/ziHKcnUH
         q5/WRKYjCXdcFO6ZMMQMXUuvRFRGD3DdTaPFeEhEHWo4GqW2wzwpeu8zMiiDiUCKx9pu
         SJ1g==
X-Gm-Message-State: AOAM533qjL4dqXR2JMg3XA8bmerA6XJGDKvQ4QE1yI42kbKWzrsyw1YI
        Sw883cpAoNbnWz6gd5fRzlZq9g==
X-Google-Smtp-Source: ABdhPJwuM5PLKGJAjBqvGZG9LH6s5vJIg23sGFxMU/RMzFHPIVsn0t+bCcgMx2JHHD7VRbWaeiA90w==
X-Received: by 2002:a63:4d3:: with SMTP id 202mr9867073pge.14.1595617730607;
        Fri, 24 Jul 2020 12:08:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id c14sm7157871pfj.82.2020.07.24.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 12:08:49 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec_proto: ignore unnecessary wakeups on old ECs
Date:   Fri, 24 Jul 2020 12:08:40 -0700
Message-Id: <20200724190841.3112365-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECs that don't implement EC_CMD_HOST_EVENT_GET_WAKE_MASK should still
have some reasonable default mask -- otherwise, they'll treat a variety
of EC signals as spurious wakeups. Battery and AC events can be
especially common, for devices that have been sitting at full charge
plugged into AC for a long time, as they may cycle their charging off
and on, or their battery may start reporting failures as it ages.

Treating these as wakeups does not serve a useful purpose, and is
instead often counterproductive. And indeed, later ECs (that implement
the mask) don't include these events in their wake-mask.

Note that this patch doesn't do anything without the subsequent patch
("platform/chrome: cros_ec_proto: check for missing
EC_CMD_HOST_EVENT_GET_WAKE_MASK"), because
cros_ec_get_host_event_wake_mask() currently does not return an error if
EC_CMD_HOST_EVENT_GET_WAKE_MASK is not implemented.

Some additional notes:
While the EC typically knows not to wake the CPU for these unimportant
events once the CPU reaches a sleep state, it doesn't really have a way
to know that the CPU is "almost" asleep, unless it has support for
EC_CMD_HOST_SLEEP_EVENT. Alas, these older ECs do not support that
command either, so this solution is not 100% complete.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v2:
 * more notes in commit message
---
 drivers/platform/chrome/cros_ec_proto.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 3e745e0fe092..e93024b55ce8 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -469,14 +469,26 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 						    &ver_mask);
 	ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
 
-	/*
-	 * Get host event wake mask, assume all events are wake events
-	 * if unavailable.
-	 */
+	/* Get host event wake mask. */
 	ret = cros_ec_get_host_event_wake_mask(ec_dev, proto_msg,
 					       &ec_dev->host_event_wake_mask);
-	if (ret < 0)
-		ec_dev->host_event_wake_mask = U32_MAX;
+	if (ret < 0) {
+		/*
+		 * If the EC doesn't support EC_CMD_HOST_EVENT_GET_WAKE_MASK,
+		 * use a reasonable default. Note that we ignore various
+		 * battery, AC status, and power-state events, because (a)
+		 * those can be quite common (e.g., when sitting at full
+		 * charge, on AC) and (b) these are not actionable wake events;
+		 * if anything, we'd like to continue suspending (to save
+		 * power), not wake up.
+		 */
+		ec_dev->host_event_wake_mask = U32_MAX &
+			~(BIT(EC_HOST_EVENT_AC_DISCONNECTED) |
+			  BIT(EC_HOST_EVENT_BATTERY_LOW) |
+			  BIT(EC_HOST_EVENT_BATTERY_CRITICAL) |
+			  BIT(EC_HOST_EVENT_PD_MCU) |
+			  BIT(EC_HOST_EVENT_BATTERY_STATUS));
+	}
 
 	ret = 0;
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

