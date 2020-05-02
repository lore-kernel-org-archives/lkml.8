Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCB5C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9684620757
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4TQAU3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgEBTbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728488AbgEBTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 15:31:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9366DC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 12:31:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ms17so1693316pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIL2KbMxRtnATvJqUzPTFDCNwLrdBpSmmIc1wV1dEHA=;
        b=b4TQAU3lmiD8PQG+dwxpbXSHwlgPMje9VEnlG+Q/yWnaPXzbs0+oWvYmWyh9wIevPh
         hkznabwuMxJkrTsq0vpbyApI+jsejbYLhfj4JnIG/l7FH5aS1bn+B0ypxAIZ+LZs4IP/
         sh0wlwEQJ67L/Jp7OFw4xghqClyuUOd6sGPKj1SIAinSKZaANfpHRS1eELWe/DZ3iTWk
         nnC6CNSBJ2Le/CYvy1FQPX/Dp3eudXxq1UqepnRbMvp5e/9MjDPJOlACjGrBZ3nT/rvi
         u58TJt7z1vBVnh1wXZAHG8wI7Xij5SfUCBzKeP9XDiMkYE1vduykLcjPOu0L6DDTZO6p
         GARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIL2KbMxRtnATvJqUzPTFDCNwLrdBpSmmIc1wV1dEHA=;
        b=YE4bYthN5yBez3CSBB/8FVMrY/UfH3XnnRzTivzLddJb1VxEgQYgsqVFOnt0SjcQ5/
         80NZIkfYVC79QExDOSIETZ0dxxZiJqKR0wOyFYrmIZgBXaYOjI8amT8CICZ/hSvpaZMz
         dA7kKfCgMx8YEvHt/rqc7ZmPZ3US3uWc8DgglviERWaviaNm8GBlDbHsOghxMarXJjBh
         jW5rESzSxah25I7QoeyXz7GHkQXJ1eyASOFIZV21vgLJyPWyQKJvz9COgto2ibwwMy2A
         6hN1W4Uz3jpf0YVLjixGqRZ8vC5QEag7EIId/vh5Si/ILX2X5EN5xX5fTudsiLV+UE7N
         2YnQ==
X-Gm-Message-State: AGi0PuaNHOYY0V8tR+jXBNMr9C4YeBufMaBm+TOsxiSZ9m5cMz0LJkq1
        FLBRqmiVjwV1tNTti1RZgrA=
X-Google-Smtp-Source: APiQypLfNhHJHoTSTVVXkhevMfz86rU1oxpinZmTVTbPaayaoFIvld11z1VAQAQw+UFyVHFSEcorpw==
X-Received: by 2002:a17:90b:8c4:: with SMTP id ds4mr7545166pjb.133.1588447907181;
        Sat, 02 May 2020 12:31:47 -0700 (PDT)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id 138sm5034358pfz.31.2020.05.02.12.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 12:31:46 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@denx.de>,
        Allison Randal <allison@lohutok.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 2/2] ALSA: line6: Add poll callback for hwdep
Date:   Sat,  2 May 2020 12:31:20 -0700
Message-Id: <20200502193120.79115-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502193120.79115-1-anarsoul@gmail.com>
References: <20200502193120.79115-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least POD HD500 uses message-based communication, both sides can
send messages. Add poll callback so application can wait for device
messages without using busy loop.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/usb/line6/driver.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 86adf87d57f0..7629116f570e 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -630,11 +630,27 @@ line6_hwdep_write(struct snd_hwdep *hwdep, const char __user *data, long count,
 	return rv;
 }
 
+static __poll_t
+line6_hwdep_poll(struct snd_hwdep *hwdep, struct file *file, poll_table *wait)
+{
+	__poll_t rv;
+	struct usb_line6 *line6 = hwdep->private_data;
+
+	poll_wait(file, &line6->messages.wait_queue, wait);
+
+	mutex_lock(&line6->messages.read_lock);
+	rv = kfifo_len(&line6->messages.fifo) == 0 ? 0 : EPOLLIN | EPOLLRDNORM;
+	mutex_unlock(&line6->messages.read_lock);
+
+	return rv;
+}
+
 static const struct snd_hwdep_ops hwdep_ops = {
 	.open    = line6_hwdep_open,
 	.release = line6_hwdep_release,
 	.read    = line6_hwdep_read,
 	.write   = line6_hwdep_write,
+	.poll    = line6_hwdep_poll,
 };
 
 /* Insert into circular buffer */
-- 
2.26.2

