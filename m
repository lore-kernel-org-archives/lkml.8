Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B118DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D15A20672
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AAIwCQxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbgGVB5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 21:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgGVB5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:57:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4865C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:57:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t15so346383pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Drqkc2tgZZvaYUxUbqIbEdXYhA3VSDckOTkIQ8M8ek=;
        b=AAIwCQxm0MD/9VytacsBFwghooNoX4JACgTn4Ja4VH5bhx1o+pJTp96uf6zLPYOmUc
         b/W1MXolbybIbKDgJRMEg25yH44Ic+/0K+YVW33oHNcJ/pTzjvWfoRlp5dxlpuKTelSp
         75KMedlB+EavIwBC5MfN4HkHZX/Dk5grXQ5tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Drqkc2tgZZvaYUxUbqIbEdXYhA3VSDckOTkIQ8M8ek=;
        b=CWI+6N/jRs55ydyluQusgnCC7tz0LXKHiCKZuc8av4oM/yRO06UQPi19TjYnzQh/lZ
         jsgLQ/81auMFMFaEVTfVq9BN5g4yV0iKSvUKhCIdEAEl1pkVIYlRleKE2EratAnuPn4y
         iQHXKIktZE5bXHtUfvOtvv7w5dyDZvD2Hby4MrESq957J3/RlHpkhUlsivyowsYYS/37
         OipEuFboCbz7qWOeiPexxG+gAWdU4npvSf/y1sLRF1jViEPdJVXqoIDm5cOgXcBNyACn
         vlhAhMatOUGsbg/krJwnlEL4YakbtmCFB+MeBwmVTSG2wyIXNDbZgNS0kJVDdStmuHO2
         8LxA==
X-Gm-Message-State: AOAM533g5LWNZm3Vcjja0uMhLOYnkjOrV/lGKDpPIyKiDqPL0HNdu81K
        TYiNs+RNO4rDZw1t2u5P8EbxFFVEPP0=
X-Google-Smtp-Source: ABdhPJw9QPbH9EnPILfpaViZufZnnDD5qjGQy7gL9rADCWeYBrfu4HEzogSIA12fVcOgdIkjiP6ckQ==
X-Received: by 2002:a17:90a:e2c7:: with SMTP id fr7mr7572744pjb.103.1595383068887;
        Tue, 21 Jul 2020 18:57:48 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id c1sm19408729pgi.52.2020.07.21.18.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 18:57:47 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec_proto: ignore unnecessary wakeups on old ECs
Date:   Tue, 21 Jul 2020 18:57:31 -0700
Message-Id: <20200722015732.1720840-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
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

Signed-off-by: Brian Norris <briannorris@chromium.org>
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
2.28.0.rc0.105.gf9edc3c819-goog

