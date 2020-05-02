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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63DCC47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7E0206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKWCM9z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEBTbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728052AbgEBTbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 15:31:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 12:31:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so5048799plt.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kwZfgYU5pOSIQurozok73LbTUD8n0X6fQwE6GivlBr0=;
        b=HKWCM9z26I0XXC2hIuNY//6teoEr1cIhqWHA105b7SE1K3wJH6XnYzPUMhWph4x+KN
         vDIL2d4u+6hk5ivagHu0JqtWE1v81lqavmpE70w/3BDn8h9/6HIgp7sfKiPoR4HpSw33
         Fb9FPx+YMPSCBbwJz8tFUNbDd0J+oJCD/QrzTpioBvARhYVb2dVxi0Pp8Hpy2aNFMVio
         J7gexJncqXQ2S1gQCBXq/7XNdyPgn2Bj8covz14cJtl1W1EcfD7lpsTdMK+sVcdqG1qf
         Xm5sh2dONmVTd9NBUQJLHRLa8q3+Hb/XdTIJ5eDZt5/rkbw7jr0daV+Ug+35GTMFsOTX
         lKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwZfgYU5pOSIQurozok73LbTUD8n0X6fQwE6GivlBr0=;
        b=edsKD6MXu7QvJgeG7wdPz81nkHSo5yG7ryJvzNXxoxcEiIsx52lrpTrUdW5hK8uxc/
         wFTwgDoa1kWIo0bOC5N+z6cXF4J9ojYcpGCgyhpRH2mMziXh1NPDGhKR9/v+xVsV8Ire
         vKeUmE3C4YnJl+sQnzS2GDda61n0B8ZDJiYU6aIpqzHVJBZFguczXcCpazmGOHw3CRxb
         8OLmK2BWh+WYpOofjf3luEE75UQQEmXEYRhqcV3ApOQJ3uTZzcSlrtNn0xrGZou+b4bt
         ODrZNW3lSYRTYfQQT4OnJ/kbEuNGFwiRX6LP7xwgJBsrT2ddN/yODGa3WM+E6g8wIYVB
         c1/g==
X-Gm-Message-State: AGi0PuY1ufZAmimIIFjXRDrTHdnYqU+hkWIUOIJBV80qS80tirHFlOzc
        aZm99ySkaiuTPqaM3+KVYawr6Rbji6I=
X-Google-Smtp-Source: APiQypJA7cnL0ZZG81/fp8O3RFdgnHGYF1RPFRF6LpVhzglnxI6TECL6gOwrrNkbWNDlwvuaizFlKg==
X-Received: by 2002:a17:902:a984:: with SMTP id bh4mr10379952plb.176.1588447906143;
        Sat, 02 May 2020 12:31:46 -0700 (PDT)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id 138sm5034358pfz.31.2020.05.02.12.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 12:31:45 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@denx.de>,
        Allison Randal <allison@lohutok.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 1/2] ALSA: line6: hwdep: add support for O_NONBLOCK opening mode
Date:   Sat,  2 May 2020 12:31:19 -0700
Message-Id: <20200502193120.79115-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502193120.79115-1-anarsoul@gmail.com>
References: <20200502193120.79115-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently line6 hwdep interface ignores O_NONBLOCK flag when
opening device and it renders it somewhat useless when using poll.

Check for O_NONBLOCK flag when opening device and don't block read()
if it is set.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/usb/line6/driver.c | 4 ++++
 sound/usb/line6/driver.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 4f096685ed65..86adf87d57f0 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -550,6 +550,7 @@ static int line6_hwdep_open(struct snd_hwdep *hw, struct file *file)
 	/* NOTE: hwdep layer provides atomicity here */
 
 	line6->messages.active = 1;
+	line6->messages.nonblock = file->f_flags & O_NONBLOCK ? 1 : 0;
 
 	return 0;
 }
@@ -579,6 +580,9 @@ line6_hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 	while (kfifo_len(&line6->messages.fifo) == 0) {
 		mutex_unlock(&line6->messages.read_lock);
 
+		if (line6->messages.nonblock)
+			return -EAGAIN;
+
 		rv = wait_event_interruptible(
 			line6->messages.wait_queue,
 			kfifo_len(&line6->messages.fifo) != 0);
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index e5e572ed5f30..1a4e3700c80c 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -163,6 +163,7 @@ struct usb_line6 {
 		struct mutex read_lock;
 		wait_queue_head_t wait_queue;
 		unsigned int active:1;
+		unsigned int nonblock:1;
 		STRUCT_KFIFO_REC_2(LINE6_BUFSIZE_LISTEN * LINE6_RAW_MESSAGES_MAXCOUNT)
 			fifo;
 	} messages;
-- 
2.26.2

