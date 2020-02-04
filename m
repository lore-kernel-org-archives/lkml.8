Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1B3C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62362082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQ0ZB6uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBDRVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:21:36 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:57226 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgBDRVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:21:35 -0500
Received: by mail-ua1-f74.google.com with SMTP id b15so5057419uas.23
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P5Zl9LQYe0TwoSBlL27JA/OuhbAcWy+b13rTN8vanpc=;
        b=QQ0ZB6uuqbxCJElvNJUgezUS9U6tosI0PZypsN0qkNsnv8Q5ab7WkP44YW9MlwxLa5
         p1A+xVX18I0IsONIy3AGkxpYM1iJP2xssabLbdjsqRqVHYUpNc8FvAATeI6/SxOUzpYH
         TDq3tfoRXHGaZiPvYTZXVSm9zWwKFZZTDKwhQLSdrlDjYFRbb0rl5veBZ35WqR2tGJMn
         aiywLjOnlKgvtjSOc+LLxfvkwdqp5aLJv5yv5Sf9WbAyctIbpGdJqNOa3fTNqWxFW3q9
         Em/OVGsyxOqHNY/iGfA/nWumKOnRmynQRKf+i3LYrKntb8lNxj4JgVkvZ7ul7LduO4nn
         ghgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P5Zl9LQYe0TwoSBlL27JA/OuhbAcWy+b13rTN8vanpc=;
        b=YW2NEcCKl86fNV0q6IkbWTtxn9dkBN431V/lhZTotywGKnZ/OaTLmyyG9DWdITtHX/
         /idLAhx0yzEyyvEpJKOBsX7GiWi2krYzarxwgyZT2hUEa2POJ+eSMNPQYtUN/EQS/0kR
         mc5pK0Dyp3j8bNBgvl6H31BS1keZy0XZX1KtNt0oC31DAARqRAJa/RP8wsYj7NT9z5RJ
         6PmK5pY78NhCENy+E7QGL8uvVRFz7WBJRv9a3NaZyoDCBRxP/zvk7FT0wqHcwrz4mmfC
         TPP+EtH8Fcp/SqGhCe1FxYf3n2cuBW7E1FO5bQH0OTUg6ty9did9QckAhz6rhAbn0UJx
         hVrg==
X-Gm-Message-State: APjAAAXJgrxa1FFAif4AUd7jrbDOLH569+wzwtFOx+bjaWd74yt7b+Q2
        k3VHT0lvTOLKbhI0xF2Y7YxpGynBRg==
X-Google-Smtp-Source: APXvYqwFQgJtsGlJlVyMC5UJR7gARCZMcqT2mxfWx6E5XwMyiGKF8uu5MTEINJPmX+QRk3Vapx6+Wd6skg==
X-Received: by 2002:a1f:db81:: with SMTP id s123mr17780179vkg.45.1580836894663;
 Tue, 04 Feb 2020 09:21:34 -0800 (PST)
Date:   Tue,  4 Feb 2020 18:21:11 +0100
In-Reply-To: <20200204172112.234455-1-elver@google.com>
Message-Id: <20200204172112.234455-2-elver@google.com>
Mime-Version: 1.0
References: <20200204172112.234455-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 2/3] kcsan: Clarify Kconfig option KCSAN_IGNORE_ATOMICS
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify difference between options KCSAN_IGNORE_ATOMICS and
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC in help text.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Update help text to mention alignment w.r.t. previous option.
---
 lib/Kconfig.kcsan | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 66126853dab02..020ac63e43617 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -132,8 +132,18 @@ config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
 	help
-	  If enabled, never instruments marked atomic accesses. This results in
-	  not reporting data races where one access is atomic and the other is
-	  a plain access.
+	  Never instrument marked atomic accesses. This option can be used for
+	  additional filtering. Conflicting marked atomic reads and plain
+	  writes will never be reported as a data race, however, will cause
+	  plain reads and marked writes to result in "unknown origin" reports.
+	  If combined with CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=n, data
+	  races where at least one access is marked atomic will never be
+	  reported.
+
+	  Similar to KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, but including unaligned
+	  accesses, conflicting marked atomic reads and plain writes will not
+	  be reported as data races; however, unlike that option, data races
+	  due to two conflicting plain writes will be reported (aligned and
+	  unaligned, if CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n).
 
 endif # KCSAN
-- 
2.25.0.341.g760bfbb309-goog

