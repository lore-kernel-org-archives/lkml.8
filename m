Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD94C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DFD2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=oxplot.com header.i=@oxplot.com header.b="T0PTfwvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgA2G1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 01:27:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45602 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgA2G1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 01:27:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so7895329pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 22:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oxplot.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6UFif4QYuYoVHHF8C0fUM38tDzpkMkldis3l9HA1rE=;
        b=T0PTfwvcBHdhJQunyXRO7sXkGNa3wLUE4IkhKGHmwUc+KLBFE94b5wOgrbq+4MttL5
         q72wf4JpiCBtmsSUV4OmP9vCXWGwYHELqlxl3g2HhrCWhz3tfKpSfOzV2ZGwEApVepqd
         C5z2cFJXTAgWFVtozND7MZJGLVlM9N7Y6IqfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6UFif4QYuYoVHHF8C0fUM38tDzpkMkldis3l9HA1rE=;
        b=CQhrpiUfUnjv3j1HjbyNbK3o36QoXvnzgb9y3A0NF1G5vSeuYi+k6HHyZl4t/5xrV3
         UGNz8HgHsDY1L5fsGHe6mTeoi0fpFXy4ji8DSfBAGQWaG8AV31oa/kdfpNiwNmmao+iY
         DNLo1nAHzinBflp8o0/ksxmHGuEzld+MnYRbylEtdkYZyfrGR2JFuByiQMjduXSDZUyj
         M6KqZy+NERvSrDpXczuO5GtyS82ymQWzFzaACUbe1pkRopcGnGFhbZTYDgzAzQ0YtBEE
         To5Q+K016WjDuZE0+8FKwKFGQoZQivP6G1GBDDVP3RZEKJgQJRE0l9BIDdlBT24UkR3Q
         37Zg==
X-Gm-Message-State: APjAAAWDf8VFRyVugRHdBz+q4zJuY93zLiXd2AtVUAXAWGC2kVGh/QG8
        i+ik81UtH4NUE3FVBLMPAo62
X-Google-Smtp-Source: APXvYqxirriyZDHUUb67XKllGd4slvU4+TLQOBA3G0ePKugX+3aj8cC+8K0lLIQ8gZZIAOhbHpGvZQ==
X-Received: by 2002:a63:cb48:: with SMTP id m8mr29851187pgi.128.1580279261163;
        Tue, 28 Jan 2020 22:27:41 -0800 (PST)
Received: from localhost.localdomain (110-174-242-179.static.tpgi.com.au. [110.174.242.179])
        by smtp.googlemail.com with ESMTPSA id n2sm1145244pfq.50.2020.01.28.22.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 22:27:40 -0800 (PST)
From:   Mansour Behabadi <mansour@oxplot.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Mansour Behabadi <mansour@oxplot.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: apple: Add support for recent firmware
Date:   Wed, 29 Jan 2020 17:26:31 +1100
Message-Id: <20200129062631.22694-1-mansour@oxplot.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Magic Keyboards with more recent firmware (0x0100) report
Fn key differently. Without this patch, Fn key may not
behave as expected and may not be configurable via hid_apple
fnmode module parameter.

Signed-off-by: Mansour Behabadi <mansour@oxplot.com>
---
 drivers/hid/hid-apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 6ac8becc2372..d732d1d10caf 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -340,7 +340,8 @@ static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		unsigned long **bit, int *max)
 {
 	if (usage->hid == (HID_UP_CUSTOM | 0x0003) ||
-			usage->hid == (HID_UP_MSVENDOR | 0x0003)) {
+			usage->hid == (HID_UP_MSVENDOR | 0x0003) ||
+			usage->hid == (HID_UP_HPVENDOR2 | 0x0003)) {
 		/* The fn key on Apple USB keyboards */
 		set_bit(EV_REP, hi->input->evbit);
 		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
-- 
2.25.0

