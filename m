Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FCEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4B020771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MmepaoUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgGVB5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 21:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgGVB5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:57:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF781C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:57:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a24so351627pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=su1XkeyRnzMEHK9Yn/D1y3WRDB7LvpOU7Y4o6l5KStw=;
        b=MmepaoUCiDHsOdlsts0QjlFqbQdU0BbhFm4FK/Ima/IkA6DkQ+yY7kShOxmA9KZPU0
         ldiyGqYLLufEvYLkiIRRxf52AOdEKR7+NMrGsZ1tXJooC+xPibcSJw8tDxkPskwS2daH
         3/3azAb+DnRLnP08f/yMsxrXGiic/sdMkXV84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=su1XkeyRnzMEHK9Yn/D1y3WRDB7LvpOU7Y4o6l5KStw=;
        b=GN3ysoYI1BGJb1EmpHb6Gw6T+Wus1b81C3LnPWtcNfUMUw6u6Vhy2BHX+8VImMWZlD
         Qnm2+nYr8DyeJheYJE2M8KWkf58SnqovHLDiJ1tkoeyK8zAVFgfvFz9k6/UX2nHSUEyz
         h5vXibIvQCNHEmgFnidGBDAsmBa5bfxvonBYQIfFrEbpZm/tN7zSlS5Xw94OsVQoyWd2
         wjEbfSrY8ojycCyEq4vsjA0RJYzjNGAjP/ir2kQ0mfMwwYTP09SEH29MFeQHWeueVynh
         8GPfI5v7LOa2lP8Vuz5eE43qi5bVYhRPzZnAwpUqF1OZ/XrZgvhu+j+cfdGfpXMOwf+O
         KVDg==
X-Gm-Message-State: AOAM53333VTwoOcD893rp7OcQRTDw78yKEatiNJOnZ7Q+E6WJprZHjQl
        9sGDRE/I468oLTcUH+ic8FSnVJZKHoU=
X-Google-Smtp-Source: ABdhPJzgTf103+oIhWLzD5Ntc06p7/NH90abxrYrt8ldY8jos0KdvPpz3TMYKxkkO5DqziUZaGsY5Q==
X-Received: by 2002:a65:6799:: with SMTP id e25mr26124415pgr.364.1595383070340;
        Tue, 21 Jul 2020 18:57:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id c1sm19408729pgi.52.2020.07.21.18.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 18:57:49 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_GET_WAKE_MASK
Date:   Tue, 21 Jul 2020 18:57:32 -0700
Message-Id: <20200722015732.1720840-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200722015732.1720840-1-briannorris@chromium.org>
References: <20200722015732.1720840-1-briannorris@chromium.org>
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
 drivers/platform/chrome/cros_ec_proto.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index e93024b55ce8..01a74abe4191 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -208,6 +208,12 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev,
 	msg->insize = sizeof(*r);
 
 	ret = send_command(ec_dev, msg);
+	if (ret >= 0) {
+		if (msg->result == EC_RES_INVALID_COMMAND)
+			return -ENOTSUPP;
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
+		if (ret != -ENOTSUPP)
+			dev_err(ec_dev->dev,
+				"failed to retrieve wake mask: %d\n", ret);
 	}
 
 	ret = 0;
-- 
2.28.0.rc0.105.gf9edc3c819-goog

