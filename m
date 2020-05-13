Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D7BCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3922492F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363266;
	bh=tuNb+NYMQBnQMFewZOaFo7HcYsYxZ9JgcdnhsXbA1VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CoZi8o4uB+ablo7Be4pA8nIVuklpaJQS8llnrMvhBZ9vctLKIRTEOR6B1ech4k8yM
	 q1PCQRa5OYFPWUNKCgwzHm5voh04YCEQcN27kRXLxwyGz6HthaFcyNXs0LNMYC+w9x
	 DoYXgMxbN7hxsCEcvmHv2sPXfh2SXfVxRiKpgyas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbgEMJrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732869AbgEMJra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:47:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E0423126;
        Wed, 13 May 2020 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363249;
        bh=tuNb+NYMQBnQMFewZOaFo7HcYsYxZ9JgcdnhsXbA1VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3QIMh/NjsqnVK5kbCFa+iGDgyordT/FKhW5W/wYgzhH+FJBu6aCiVKQJ9lfRTVtP
         aCiISXEpA2f+DP0rOS82bGmXBr3gxUuiltTaEWLlzbQBlj+mYYNBLpSV4GdJH0SuHc
         ShAWsXjV7oC/h3Csfl7zM2Pl691JO8Zc5/Nf9cZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 19/48] HID: wacom: Read HID_DG_CONTACTMAX directly for non-generic devices
Date:   Wed, 13 May 2020 11:44:45 +0200
Message-Id: <20200513094355.775789347@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094351.100352960@linuxfoundation.org>
References: <20200513094351.100352960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gerecke <jason.gerecke@wacom.com>

commit 778fbf4179991e7652e97d7f1ca1f657ef828422 upstream.

We've recently switched from extracting the value of HID_DG_CONTACTMAX
at a fixed offset (which may not be correct for all tablets) to
injecting the report into the driver for the generic codepath to handle.
Unfortunately, this change was made for *all* tablets, even those which
aren't generic. Because `wacom_wac_report` ignores reports from non-
generic devices, the contact count never gets initialized. Ultimately
this results in the touch device itself failing to probe, and thus the
loss of touch input.

This commit adds back the fixed-offset extraction for non-generic devices.

Link: https://github.com/linuxwacom/input-wacom/issues/155
Fixes: 184eccd40389 ("HID: wacom: generic: read HID_DG_CONTACTMAX from any feature report")
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
CC: stable@vger.kernel.org # 5.3+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_sys.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -290,9 +290,11 @@ static void wacom_feature_mapping(struct
 			data[0] = field->report->id;
 			ret = wacom_get_report(hdev, HID_FEATURE_REPORT,
 					       data, n, WAC_CMD_RETRIES);
-			if (ret == n) {
+			if (ret == n && features->type == HID_GENERIC) {
 				ret = hid_report_raw_event(hdev,
 					HID_FEATURE_REPORT, data, n, 0);
+			} else if (ret == 2 && features->type != HID_GENERIC) {
+				features->touch_max = data[1];
 			} else {
 				features->touch_max = 16;
 				hid_warn(hdev, "wacom_feature_mapping: "


