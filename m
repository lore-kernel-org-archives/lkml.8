Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846402333C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IA4Vzz42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgEVOeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbgEVOeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:34:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED9EC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:34:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x18so3355534pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jt95gM7bDaZUZl096LfhQlytpSjYv3RkW970ThzaFFA=;
        b=IA4Vzz42923hj72QNNcuVRP/Txsfsry0y7VVQ453xTFlJkzgmIqq5tWR1wl7ywD7jE
         ff9YJ72Pa1DMNZfT/neHIll7EA8oHhxHsYA811SYOTMpoVoaVlqCpQAuMzIuMh5pSWjS
         Webi0gLSSquYMpAoUA139QPmQDlz6IT/fR2bLQ9udlwxdRp2pyvi4VAI+ivSmXEkfF7a
         0TK+s81lg1eOw1GX5Txyhs11DZkjcC64QtTbqq7KgQUKCoZR3idaEbR+Awh1wrzagGE1
         OzOh/mM0H6DqIjcmX6zmrWyGiLpZldAxi/u8hm/NO439ICLl+RJyLDjfVVPovBaKLb13
         vzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jt95gM7bDaZUZl096LfhQlytpSjYv3RkW970ThzaFFA=;
        b=CyvoT2wFNIfigiu421pVb6713E3HxCs23h1zw7ISwJ5nQA3VlUmj+qGNBoRo+KDcVF
         vohNpLcnCmRJWLDBdR1yFr/p4XI8C7RJ6f54YP/NjGMata8jjc71HHk/s3vJqAUcoslO
         LY15G7kxRvW1s+AivYcOstvAC67tY1F5OZEINQQm0tFSN9S0Au7ThVUy499CWZ/9y3aB
         dx9Zc/Tp4BiPE5dShyYVRxl+z9qSm1TwAetmxUgx3ejJD71VFNIUAOdko9KP1T6tn+iH
         6aIlVruUAUsxyeiQen9edgEDmlv9a+6Bb80h0G2+VyDAMVD+2jkq3CImOKB1fxpCpTgP
         ZMbw==
X-Gm-Message-State: AOAM5325fhN/1Sz5CY3pg+Ta+77ybMxDhWBbagXdAelxsYVzuodZw/75
        o24P/9iwX9Es+x+GkSIL0LGyLQ==
X-Google-Smtp-Source: ABdhPJwL0Aom7OL3QO7sP6rWI4bhVxcyO1dbOlAn6mkTgxiIBT3D8I7zFT6+ruJ9GGI9iCbEmyr17A==
X-Received: by 2002:a17:90a:f0d8:: with SMTP id fa24mr4722575pjb.93.1590158055272;
        Fri, 22 May 2020 07:34:15 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id r2sm7247889pfq.194.2020.05.22.07.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 07:34:14 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2] kdb: Make kdb_printf robust to run in NMI context
Date:   Fri, 22 May 2020 20:03:47 +0530
Message-Id: <1590158027-15254-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While rounding up CPUs via NMIs, its possible that a rounded up CPU
maybe holding a console port lock leading to kgdb master CPU stuck in
a deadlock during invocation of console write operations. So in order
to avoid such a deadlock, invoke bust_spinlocks() prior to invocation
of console handlers.

Also, add a check for console port to be enabled prior to invocation of
corresponding handler.

Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v2:
- Use oops_in_progress directly instead of bust_spinlocks().

 kernel/debug/kdb/kdb_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 924bc92..3a5a068 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -699,7 +699,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			}
 		}
 		for_each_console(c) {
+			if (!(c->flags & CON_ENABLED))
+				continue;
+			++oops_in_progress;
 			c->write(c, cp, retlen - (cp - kdb_buffer));
+			--oops_in_progress;
 			touch_nmi_watchdog();
 		}
 	}
@@ -761,7 +765,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			}
 		}
 		for_each_console(c) {
+			if (!(c->flags & CON_ENABLED))
+				continue;
+			++oops_in_progress;
 			c->write(c, moreprompt, strlen(moreprompt));
+			--oops_in_progress;
 			touch_nmi_watchdog();
 		}
 
-- 
2.7.4

