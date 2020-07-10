Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A34FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641892065D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=secretlab.ca header.i=@secretlab.ca header.b="ZRVe/ibO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgGJPUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgGJPTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:19:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBE7C08E763
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:19:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so6563742wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=secretlab.ca; s=google;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kxnyGnMwxTRwHtpgKXQFv4Sp6EsduZoxQF9xvlfrbr8=;
        b=ZRVe/ibOcbNKEM/ckw2d45EAviU8Pdos52byPUPcHAF0KcH9B9qASluESjw4KaH4Yg
         gBkMUVeA1w+53smdKc/n0mMXp8ja0j3tKCB99dT5ELfcmTBVz/0PIEcqwf9AD2yrL8er
         PY1kyYvl0PYqsDEk51ZVOmlJCnfONwb34Yym1ASVdaVRgYExPRp2Y3zXG/wT4X8+Nosi
         WXeFcMTadVk1AeJs7OmMT/m29gdv4Ev/PzKgJYP1/nA0q7mFScCBEyass+jmBB4cgKJE
         iMAW7Rj1l5WQ57KkxmxPz2NC3QjhP/w9B1s0khMrEXmosFgOecRkp0W0udq1Wt4sttst
         fihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kxnyGnMwxTRwHtpgKXQFv4Sp6EsduZoxQF9xvlfrbr8=;
        b=WWlryurFRfrvvp+d39fmqiiQlcyAMMbcouj62pZLJQixlrWhDkWxFTd7RzcyNeBWmZ
         L876D9xUDV0FgcUOdJTTZQMa2+fkl6VsrVoYpp26Bn9fw7U+cQUcmRsZl659xcLpmO7s
         xOCS4z6fkGdmPGWhCIEAcTWAKqqjyAoCjLGTE5CN8E3SH3ZKs2ospTisHUvmX7EWbgHF
         WThpZD7Jw7ko0vWuLRalAJvV64W46Dyn52hIuiA8EF1D7dn9iZq5KCgs1Arlw3N4ZuUC
         kTxWqoVl8XS8NoK9XYYS9vsmAGtkQ4WXEii/PTtfV1/0FtSKtKZcXNZ4wlrx07HX6btk
         kFmQ==
X-Gm-Message-State: AOAM531Be8R/pBgbTOml+bVupd7HxIkPA812Chz/x7kD8oAwrmgcQR6Q
        /77hquuXC7e/b7QoR93ECw8s/YNIbYuJIyz6
X-Google-Smtp-Source: ABdhPJzXzqIMMMApQjKWDU1z5QkbzF8CAES3zC4qQ+Oqh5yRVV9kfEvVTZWzmZDin+QTicbt2ad4Cw==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr5587090wme.65.1594394389624;
        Fri, 10 Jul 2020 08:19:49 -0700 (PDT)
Received: from moist.secretlab.ca (188.28.146.46.threembb.co.uk. [188.28.146.46])
        by smtp.gmail.com with ESMTPSA id d13sm10400297wrn.61.2020.07.10.08.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 08:19:49 -0700 (PDT)
From:   Grant Likely <grant.likely@secretlab.ca>
X-Google-Original-From: Grant Likely <grant.likely@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Grant Likely <grant.likely@arm.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Darren Hart <darren@dvhart.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH] hid-input: Fix devices that return multiple bytes in battery report
Date:   Fri, 10 Jul 2020 16:19:39 +0100
Message-Id: <20200710151939.4894-1-grant.likely@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices, particularly the 3DConnexion Spacemouse wireless 3D
controllers, return more than just the battery capacity in the battery
report. The Spacemouse devices return an additional byte with a device
specific field. However, hidinput_query_battery_capacity() only
requests a 2 byte transfer.

When a spacemouse is connected via USB (direct wire, no wireless dongle)
and it returns a 3 byte report instead of the assumed 2 byte battery
report the larger transfer confuses and frightens the USB subsystem
which chooses to ignore the transfer. Then after 2 seconds assume the
device has stopped responding and reset it. This can be reproduced
easily by using a wired connection with a wireless spacemouse. The
Spacemouse will enter a loop of resetting every 2 seconds which can be
observed in dmesg.

This patch solves the problem by increasing the transfer request to 4
bytes instead of 2. The fix isn't particularly elegant, but it is simple
and safe to backport to stable kernels. A further patch will follow to
more elegantly handle battery reports that contain additional data.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Darren Hart <darren@dvhart.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/hid/hid-input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index dea9cc65bf80..e8641ce677e4 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -350,13 +350,13 @@ static int hidinput_query_battery_capacity(struct hid_device *dev)
 	u8 *buf;
 	int ret;
 
-	buf = kmalloc(2, GFP_KERNEL);
+	buf = kmalloc(4, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 2,
+	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
 				 dev->battery_report_type, HID_REQ_GET_REPORT);
-	if (ret != 2) {
+	if (ret < 2) {
 		kfree(buf);
 		return -ENODATA;
 	}
-- 
2.20.1

