Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E18C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A7F20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZlLFlMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbgF3HwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgF3HwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:52:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4BFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:52:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bj10so2925359plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3w+MEV6HK7a0ApN89q9Azr5fj9UihIbeOF7agLk6kY=;
        b=oZlLFlMK1E2eDrB2lEIneIu1RVJcAgM6DzVJOYlSsA4ENL/FRND8LEJNr/nlng2D2Q
         MEXdKYc1zoOsZZdwUtiK3CtW500TVRWggAUI7qoHeAf9RZUICLbMf9wd2fCuCFR5lLHS
         77AkbX5YZIe+j1lkNTHP628opAhm8Zzqqkmw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3w+MEV6HK7a0ApN89q9Azr5fj9UihIbeOF7agLk6kY=;
        b=leI7NV62Gzir6neDNap8To8B9Z4S/sg0RXMwMAiiacNnl/IvufAXVvGKuP2kr0QmIO
         ICD0Kr2ygjOTH1AsA9kg7JE0Sh56OoyAR0TnF7IxKY9BrKU2Nd4tyThIJBIINV68/Trs
         elnG8sqxj3gs4U39JL0YM7RCUsn4Vsj4GnUD3+YE286AVhGG8CN1USXCoVVM1XNTwk0Q
         cX4qGye1Q0BFVsefxuutenTF+RnXtE/C31QVETqYWg9r6HuNYmJncBTPmhoc449lygMv
         UxhWNBTGUVAMvfFih0r2/vHHnseFMASnjUw1iduzKYVioQlyK9Kh43ozWCQZgNklIfsR
         y48A==
X-Gm-Message-State: AOAM531Rh3/BKQwAu6mm7EQBJX2QurKMOEmWCN1POQprvMlseBQP+OW4
        t+YnaGSQ1sXEHi0SRub3zrF4Dw==
X-Google-Smtp-Source: ABdhPJyWzJoiTDCscIYBecrMj8G/UUR9BzRFo0AguLKfMz18q3CFApscIdsARzA+y29ANbDSos62LA==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr10869232plz.69.1593503534479;
        Tue, 30 Jun 2020 00:52:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id s68sm1494729pjb.38.2020.06.30.00.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 00:52:13 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        bhanumaiya@chromium.org
Cc:     groeck@chromium.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform: chrome: Fix EC timestamp overflow
Date:   Tue, 30 Jun 2020 00:52:03 -0700
Message-Id: <20200630075203.3054990-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC is using 32 bit timestamps (us), and before converting it to 64bit
they were not casted, so it would overflow every 4s.
Regular overflow every ~70 minutes was not taken into acoun either.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 23960f3acc0b1..641d91088cee2 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -465,9 +465,7 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 			 * Disable filtering since we might add more jitter
 			 * if b is in a random point in time.
 			 */
-			new_timestamp = fifo_timestamp -
-					fifo_info->timestamp  * 1000 +
-					in->timestamp * 1000;
+			new_timestamp = c - b * 1000 + a * 1000;
 			/*
 			 * The timestamp can be stale if we had to use the fifo
 			 * info timestamp.
-- 
2.27.0.212.ge8ba1cc988-goog

