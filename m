Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F42F23403
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uN45YW4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgEVOe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgEVOe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:34:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B60C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:34:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b190so5281000pfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=40rREeQMNZRNzVvKI3RsdQwOOpr5Hq74BH4Z18GJSk4=;
        b=uN45YW4tw5D0FgwoNORtV54gmgbTluyIq0aSQaeMi7KCyrcStZFZMJ+orbDu/nqQnF
         Nb2PTjMZuG4ZX2Oxf6o9I3PTwm5Mr5ppE0P+4hmG8wi+MWM7Ix18h9xLBjH5qIZm60DO
         wyPiJiZB6KdD1PLs7Hlg+C6oimuKA55JObI9T5pp+83pwnzuv6s9YMN44sh3ITkty9/P
         NBSqk9um/JP+LPhb9TpbnEmmkajvQQKDPz9xF2amcMA44g4vF4h1v4AJQlMIK7Vcg9Up
         66JWgWmPJGqtgKfr11R7XIkjvmpDCq19ESERhsQNnvZyErAVIoM1jxXLwDFdXESq0z2e
         65SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=40rREeQMNZRNzVvKI3RsdQwOOpr5Hq74BH4Z18GJSk4=;
        b=YbJYkGOvh5/gTyH9J+lhAj6alJMH5D26ceY3MJIJ8HYrNiacLvMza44kBPxpvbA8VI
         zoM7wYlzUHxXiarcjPAk8jTDvqgFtV8sPikiFDuaTQZYUmzzhJMfHNz3EouzfmBteZOF
         yc8S855ka4ZCTFv99M3lzsidTStf4uevQ8R2bXPz3Yg5JI7hmMkcaeh5QI/Whx5/eRTn
         Yc8rmwkpvtubMTo/F95lyfmQFEat2CmyMS7fTy9Gb1BtHC7MR6l4j1Cw9AgyOk3G5Uqd
         j4Xt42MBe5INgI9TDWwEn1+jo+vp28rZsLnqUjGub+ar4URLa19oIDpWeGQMoZVWT0un
         A93Q==
X-Gm-Message-State: AOAM5328xrcX6TgvMjdaBP+VBPG5FHk0B9whSFVtUyvae5CVsHq/l4JD
        +/1NMY2dT5KIBlOOyOmWek1Gag==
X-Google-Smtp-Source: ABdhPJwrZRHOfM6L3mN940SNqqfhLIyCYCUZVuvyQcynkBdfeibkcfVH2yK05wo1GjCH7DMHNHZxXQ==
X-Received: by 2002:a62:15c7:: with SMTP id 190mr4204642pfv.190.1590158096802;
        Fri, 22 May 2020 07:34:56 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id y20sm6774642pfo.173.2020.05.22.07.34.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 07:34:56 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC] kdb: Switch kdb_printf to use safer console poll APIs
Date:   Fri, 22 May 2020 20:04:31 +0530
Message-Id: <1590158071-15325-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kgdb NMI context, polling driver APIs are more safer to use instead
of console APIs since the polling drivers know they will execute from
all sorts of crazy places. And for the most common use cases this would
also result in no console handler ever being called. So switch to use
polling driver APIs in case a particular console supports polling mode.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 3a5a068..8e0d581 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -24,6 +24,7 @@
 #include <linux/kgdb.h>
 #include <linux/kdb.h>
 #include <linux/kallsyms.h>
+#include <linux/tty_driver.h>
 #include "kdb_private.h"
 
 #define CMD_BUFLEN 256
@@ -699,11 +700,24 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			}
 		}
 		for_each_console(c) {
+			int line;
+			struct tty_driver *p;
+
 			if (!(c->flags & CON_ENABLED))
 				continue;
-			++oops_in_progress;
-			c->write(c, cp, retlen - (cp - kdb_buffer));
-			--oops_in_progress;
+			p = c->device ? c->device(c, &line) : NULL;
+			if (p && p->ops && p->ops->poll_put_char) {
+				len = retlen - (cp - kdb_buffer);
+				cp2 = cp;
+				while (len--) {
+					p->ops->poll_put_char(p, line, *cp2);
+					cp2++;
+				}
+			} else {
+				++oops_in_progress;
+				c->write(c, cp, retlen - (cp - kdb_buffer));
+				--oops_in_progress;
+			}
 			touch_nmi_watchdog();
 		}
 	}
@@ -765,11 +779,24 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			}
 		}
 		for_each_console(c) {
+			int line;
+			struct tty_driver *p;
+
 			if (!(c->flags & CON_ENABLED))
 				continue;
-			++oops_in_progress;
-			c->write(c, moreprompt, strlen(moreprompt));
-			--oops_in_progress;
+			p = c->device ? c->device(c, &line) : NULL;
+			if (p && p->ops && p->ops->poll_put_char) {
+				len = strlen(moreprompt);
+				cp = moreprompt;
+				while (len--) {
+					p->ops->poll_put_char(p, line, *cp);
+					cp++;
+				}
+			} else {
+				++oops_in_progress;
+				c->write(c, moreprompt, strlen(moreprompt));
+				--oops_in_progress;
+			}
 			touch_nmi_watchdog();
 		}
 
-- 
2.7.4

