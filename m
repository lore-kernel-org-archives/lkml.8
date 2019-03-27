Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227CFC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F274320578
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgC1QoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:44:18 -0400
Received: from mx.sdf.org ([205.166.94.20]:49799 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgC1QoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:44:17 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhGqn011685
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:17 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhG7f004946;
        Sat, 28 Mar 2020 16:43:16 GMT
Message-Id: <202003281643.02SGhG7f004946@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Wed, 27 Mar 2019 08:27:16 -0400
Subject: [RFC PATCH v1 25/50] HID: hid-lg: We only need pseudorandom bytes for
 the address
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Simon Wood <simon@mungewell.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's just to reduce collisions among cooperating USB HID
devices; it's not intended to be secure against a malicious
attacker (and it would need to be a lot larger than 16 bits
if it were).

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Simon Wood <simon@mungewell.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-lg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 0dc7cdfc56f77..b6b6ed9834c7c 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -832,7 +832,7 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 			/* Select random Address */
 			buf[1] = 0xB2;
-			get_random_bytes(&buf[2], 2);
+			prandom_bytes(buf+2, 2);
 
 			ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(cbuf),
 					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
-- 
2.26.0

