Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65916C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45EED206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NyPhcF7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgGXTIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGXTIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:08:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FDAC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:08:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so5726219pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1golVKvQMtPFKTXci2gDoubKVQV9khMoEWiJu1+cjio=;
        b=NyPhcF7ES8xptWq8dHNT7VwVGzeQpKfZ5hRq8rGory7uVyoZMd4V8Re7FTzoRfEANd
         V9ylGwmoW/hs3J+61sj/6UNwzlKLZhVuXYaxOx/RZfv/hLe1ieazh6AvGyiRd00lZBna
         tiBh1rSzAdugOJEo3I+gBIlVBy6wmwjIWa7Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1golVKvQMtPFKTXci2gDoubKVQV9khMoEWiJu1+cjio=;
        b=kJdjd60zh8qavfF5FJzJMUBrY5jbQLPoOHQnLQubIqcH/1Ao8D/ZmfysQd9CH6eTip
         WNK1a+oeypwlX4PQogWNmh4HW4KenUtAWVlbRnD0GmKHWFikOq4HNm5is3Z1HyZR1IYv
         s8IN8/a2hWFkux8C0WnDBsXlJMfx2dyq1eWhsgdepEyGCKyE2fC6Rb8Ho0m4F+nCvjJV
         jyguHQSoNaFrtuJv3wadRrMkjBm3HqMuavchqES3K4t8J9XpiWV9VAhamCSyvUI74Wbp
         ceqyb7EZAr+h3xkNItWcnp3YxP9qVlBtmZ8ai5X6e5ra2mmIQ8JRiOI/1IdQtiQEMlai
         Ds5A==
X-Gm-Message-State: AOAM532rlXmxLvxeNIyvaWVRb20YShiQ97wGM/6PqTSqiARdiI/Plbz4
        wWZR3WzajuMZXhFl9Vj4gBsyoA==
X-Google-Smtp-Source: ABdhPJySCxAxlkIyR/MCENi3CKBep+K5xQ84CnfCIaWUraOnMKGPI77sG+bl/zCMOaUaQwlIK10oyg==
X-Received: by 2002:a63:c049:: with SMTP id z9mr9465123pgi.353.1595617732012;
        Fri, 24 Jul 2020 12:08:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id c14sm7157871pfj.82.2020.07.24.12.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 12:08:51 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_GET_WAKE_MASK
Date:   Fri, 24 Jul 2020 12:08:41 -0700
Message-Id: <20200724190841.3112365-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200724190841.3112365-1-briannorris@chromium.org>
References: <20200724190841.3112365-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As with cros_ec_cmd_xfer_status(), etc., it's not enough to simply check
for the return status of send_command() -- that only covers transport or
other similarly-fatal errors. One must also check the ->result field, to
see whether the command really succeeded. If not, we can't use the data
it returns.

The caller of cros_ec_get_host_event_wake_mask() ignores this, and so
for example, on EC's where the command is not implemented, we're using
junk (or in practice, all zeros) for our wake-mask. We should be using a
non-zero default (currently, it's supposed to be all-1's).

Fix this by checking the ->result field and returning -EPROTO for
errors.

I might label this as fixing commit 29d99b966d60 ("cros_ec: Don't signal
wake event for non-wake host events"), except that this fix alone
actually may make things worse, as it now allows for a lot more spurious
wakeups. The patch "platform/chrome: cros_ec_proto: ignore battery/AC
wakeups on old ECs" helps to mitigate this.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v2:
 * EOPNOTSUPP, not ENOTSUPP
---
 drivers/platform/chrome/cros_ec_proto.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index e93024b55ce8..31ca0af62388 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -208,6 +208,12 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev,
 	msg->insize = sizeof(*r);
 
 	ret = send_command(ec_dev, msg);
+	if (ret >= 0) {
+		if (msg->result == EC_RES_INVALID_COMMAND)
+			return -EOPNOTSUPP;
+		if (msg->result != EC_RES_SUCCESS)
+			return -EPROTO;
+	}
 	if (ret > 0) {
 		r = (struct ec_response_host_event_mask *)msg->data;
 		*mask = r->mask;
@@ -488,6 +494,13 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 			  BIT(EC_HOST_EVENT_BATTERY_CRITICAL) |
 			  BIT(EC_HOST_EVENT_PD_MCU) |
 			  BIT(EC_HOST_EVENT_BATTERY_STATUS));
+		/*
+		 * Old ECs may not support this command. Complain about all
+		 * other errors.
+		 */
+		if (ret != -EOPNOTSUPP)
+			dev_err(ec_dev->dev,
+				"failed to retrieve wake mask: %d\n", ret);
 	}
 
 	ret = 0;
-- 
2.28.0.rc0.142.g3c755180ce-goog

