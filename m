Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD5C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1446520714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSbBnzy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgBZSs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:48:28 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:53649 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbgBZSs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:48:26 -0500
Received: by mail-wr1-f74.google.com with SMTP id n23so137902wra.20
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GUzRbTx+9+5SLlU+YVj83grWFXbPGAYyGcx3oLf377g=;
        b=JSbBnzy73DD7ilHDWTFrjHWPxRL7qMXhCBn/ySAMownKsqRDhzchskO8xsrPstrHmU
         7hbYdvKkxGKY64y17R2D0sCyYJS97SlynEXUWo9kcZ2s1U6RnVUVAvtiSm9LJyeqcS28
         gDjmCKR3o3dQoLoI9V/DGjM23yTRJ2WZEq2rwf7GIh/sjMsmJLqT1Lzns1pCU7Eh6VN7
         0egGzWbctmv/nxkmUStAHcDTVvEMkg9KxCZGkwQtqxwY3WZ90B16QfBlliEhPh5ALjn4
         ObyBYLTt1rSpfvp+CyeQpsNQgBNwLgnKWznE18PjeO/LJ5v5C1Yu8jaNW1CH1JnjGaD5
         3egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GUzRbTx+9+5SLlU+YVj83grWFXbPGAYyGcx3oLf377g=;
        b=C0rTh5dGtoPs+JT5LAOJotl8sF5BpdrOp+MDXvwSRoij0ZU5ROnIIh5d+psBBLJOwc
         mnToxVnPwYMj7anMUo13AU0YT0XyoDBb3NtuyKHIWs0DA+241zo2UswwbNjQCafHDDtY
         fNl2qSn3CnCPF5dlreZMx3KWv1gxHptbh+vqfXcqfQjVJdRfJUpWoNxMasOs4wTiWR2t
         W5bSpw8l/GGKeR4SdETc+zDl9O4SYatTRjLZm5mXORCAStdgA9Xdk3iTBTGLKGFyFDDd
         cvbpfZP2hChC/wwnXU3Qi7IuAkb78Wz7ZeBuznLUHfYuaxeZTZV4EUipKni+RXgZy8hJ
         8+qA==
X-Gm-Message-State: APjAAAX1YnlALAcp6mNX7QEl3Pp9ZBwy8x3aC1lkxtbT1CTlNLM6wtLw
        KD6WLK9pDnlWBfe4hZuK3gij8IMwEjxKTEyc
X-Google-Smtp-Source: APXvYqy+464jcwq7XNRH9yunMmB1w1Y35nJInpXA1U7aPORosC3hZ+1ZSK+jy5xDoiJde55La6FlNSHVBCJ5D74Q
X-Received: by 2002:adf:eac1:: with SMTP id o1mr48952wrn.234.1582742902870;
 Wed, 26 Feb 2020 10:48:22 -0800 (PST)
Date:   Wed, 26 Feb 2020 19:48:09 +0100
In-Reply-To: <cover.1582742673.git.andreyknvl@google.com>
Message-Id: <d440a200cc1a3faddfd429467ac42841ee002bbc.1582742673.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1582742673.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v1 3/3] usb: core: kcov: collect coverage from usb complete callback
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds kcov_remote_start/stop() callbacks around the urb
complete() callback that is executed in softirq context when dummy_hcd
is in use. As the result, kcov can be used to collect coverage from those
those callbacks, which is used to facilitate coverage-guided fuzzing with
syzkaller.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/core/hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index aa45840d8273..de624c47e190 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -31,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/genalloc.h>
 #include <linux/io.h>
+#include <linux/kcov.h>
 
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
@@ -1645,7 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 
 	/* pass ownership to the completion handler */
 	urb->status = status;
+	kcov_remote_start_usb((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
+	kcov_remote_stop();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
-- 
2.25.1.481.gfbce0eb801-goog

