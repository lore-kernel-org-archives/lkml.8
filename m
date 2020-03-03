Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A0EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361AE21D56
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9RypMQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCCA4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:56:53 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35924 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCA4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 19:56:52 -0500
Received: by mail-pl1-f202.google.com with SMTP id bg1so842412plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 16:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MjWn1xssQfoWQqE8a57xumnRtF/eKeos54BJPVuyJV4=;
        b=Z9RypMQmX1DwNAhQzgfwPiu4aHPUXLU7YWppGyRQBOx+02/19l5Mv6xS1CrmVHCise
         DMj/S7jt7FrFtvKkvxIvmKI/qPyJ0niR5A1bmQCf/q8WeQkeCnojsu8MddM0cqG8GBL3
         +iVLA8T1LvHeoIV4Ah2OWHyaectOrGPnUnACxbEbKRjXhh0m9C8FLRv0H5GMgV8BOwwv
         4822cYDagLBndX9/hi+Mq6gootKGvIGA65N29T8czKm11A8GVSsbUcKEeTK6kmTJlXo1
         Z+EiByzfI4wUTbbFIpuKBq8vFPum7sDOk/Kud4ZwO+gPibd0zVhWOmD3zhvMw6bYGdqW
         9rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MjWn1xssQfoWQqE8a57xumnRtF/eKeos54BJPVuyJV4=;
        b=YZe6kqbEAYwG1/8BhmZ9O1Hr26LCpx3SVtyTtRWnKL9UX8nA4d7y0fPHD9bjaNg48v
         l48qqB4qxOsiHPze2Y+e9JUvAf1QwgEJjbJ6BPf08ionAHw6KyZAUT2zTEbFCQ8ZdFrP
         0PdrdPpShqVxMhy0jHO7QuBfiTEY3WP06CnFVWXW7nMBRneoWWQrLzpb6mJCzrfT3Mt6
         AU/ABkIh5jocfe0eg7kYlLXerwfJ32jrrKNI4y433HaG7Wq1HwF8NoNDf46NzA3owpZe
         rvGZFDyf1MpCO252claHzSU8z4PI/wxc6I7IjfJVnnqZEAG+3L6e9E9XeS5WhC9g/FrG
         Nd9g==
X-Gm-Message-State: ANhLgQ3oKSzGKky3gst8HXxFq3f7tWBRRMOzSriR62IAUOFJD/ORLSdI
        Fp24O1JYFucD8Sr1fZ+GvPX0w4tpbuY1
X-Google-Smtp-Source: ADFU+vuTvBWJoDi9HjHUHwiqoNQ82VV/Guk+HqRmAyeMFXexpzrcVUJWMfZFz+RVBN7mv9wOQpa0LCXnMV/+
X-Received: by 2002:a63:ad42:: with SMTP id y2mr1524288pgo.445.1583197010143;
 Mon, 02 Mar 2020 16:56:50 -0800 (PST)
Date:   Mon,  2 Mar 2020 16:56:44 -0800
Message-Id: <20200303005645.237763-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 1/2] Input: Add keycodes for keyboard backlight control
From:   Rajat Jain <rajatja@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dtor@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New keyboards can have backlight control keys. Allocating keycodes
for them. Such keyboards are already available in ChromeOS.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 include/uapi/linux/input-event-codes.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 0f1db1cccc3fd..e12a19dc30262 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -652,6 +652,10 @@
 /* Electronic privacy screen control */
 #define KEY_PRIVACY_SCREEN_TOGGLE	0x279
 
+/* Keyboard Backlight control */
+#define KEY_KBD_BKLIGHT_UP              0x280
+#define KEY_KBD_BKLIGHT_DOWN            0x281
+
 /*
  * Some keyboards have keys which do not have a defined meaning, these keys
  * are intended to be programmed / bound to macros by the user. For most
-- 
2.25.0.265.gbab2e86ba0-goog

