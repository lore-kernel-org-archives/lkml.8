Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC86C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811022072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef80zkdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgC0VYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:24:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51925 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgC0VYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id c187so13035263wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfukkDHwtKj4BKlXc/fjhSsSldS9nfyhxc+J7rLMUOQ=;
        b=Ef80zkdZrF8agBFess6gmp2WYDfANzlCqZ5kc9TJFBJdhTDp8BBF/T2wvWSGKD2Ux+
         1bydBbVa7LeAgNcbuVtVp8X7svWe5bBvxYNsJIQ/VLYzCrCpAbwPukCbJs+eu6CTtY4B
         q7EKo0mkdJ20W4KVxCfqZmpORonw+voPf9/aoTIL04BSdjJD+EyO4sAx2yxwUXxSIS3p
         DGZmGaMYb6IvzZtokwms7DMjPzf4OWW1OEZfxbKQzCo0gbZJ5A3LsLpe5HGdYo3MGWf3
         LlHtE0QeyNBdvK66wGB7ZbrpToVwC6WDxeqWpPLjSdlgb/Wxw+g15hVsRgOVt8bdL75J
         Si4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfukkDHwtKj4BKlXc/fjhSsSldS9nfyhxc+J7rLMUOQ=;
        b=f0jtotxu9sDdSRp6JHbH7LXtDm3Cz2ugmNR9pPr+REtDYPd+Vq1f6LIm5e9auLazQu
         92c/WHnclAHpNZlgzsM4Ybu4BYA1MX2vtzM5L/Gq0lAHy1kWBylZHXbkGE4nrtupiPWF
         +VIZBLgQj5rCi12K8vmfGYdfPelvgF/UjET7TPM2JNtN/VF4uF1nO2xBGSgDyzE5iOMp
         S9UPXYjqkBIg9MNXOx+jD7I7FN0eWDPXSUGCRlF+WLx3tQzwh8esVH0lm7u7jLfmIMiU
         HRfnMNRjR8OnX68VDNgY8LGiiHPtgXBt0qmdkr3M4eGGjfc4aNezDkN5JN8jVu0ZuD00
         IyNQ==
X-Gm-Message-State: ANhLgQ1Z9NfJs6GvbHxUZg/mr0/6uaxy8IySEhKGhqveI8waCf9RbgQA
        U0khIbNdLfDAsV3dEoGLTQ==
X-Google-Smtp-Source: ADFU+vvgKU83rENNsYeVyec3WQDUcJE4oHjBb7ESipJUBJQaN94MAD5Ej3+z+MCMbQSvq8bR5BESDw==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr639905wml.189.1585344270664;
        Fri, 27 Mar 2020 14:24:30 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:30 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/10] trace: Replace printk and WARN_ON with WARN
Date:   Fri, 27 Mar 2020 21:23:57 +0000
Message-Id: <20200327212358.5752-11-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327212358.5752-1-jbi.octave@gmail.com>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle suggests replacing printk and WARN_ON with WARN

SUGGESTION: printk + WARN_ON can be just WARN.
Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6b11e4e2150c..1fe31272ea73 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1799,9 +1799,7 @@ static int run_tracer_selftest(struct tracer *type)
 	/* the test is responsible for resetting too */
 	tr->current_trace = saved_tracer;
 	if (ret) {
-		printk(KERN_CONT "FAILED!\n");
-		/* Add the warning after printing 'FAILED' */
-		WARN_ON(1);
+		WARN(1, "FAILED!\n");
 		return -1;
 	}
 	/* Only reset on passing, to avoid touching corrupted buffers */
-- 
2.25.1

