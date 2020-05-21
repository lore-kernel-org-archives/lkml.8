Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C25207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joJLl5J1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgEUOXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbgEUOWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904ABC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d7so5448853ybp.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2MIiys78gGheOmgr5sadClIeI2A+sMpKPCOuDS/ESKE=;
        b=joJLl5J1SFsKoRJrjXUDcmh8qcs04F+6FwFKkVywrcnW7KuMYcookU54rJf5+8CxBU
         jMcwH8Dy8k4JHN8jzYmaf1sIN4mhdK44x4cJjc+ebvK/VWsZMrLdnOkL+UlLCNUs4aV9
         yYWlqI+RJLHZo4EII9VFD4DUAl81+0P1sqOZm+Wi3L0huYztYhhXDHbuVkwZczt+kfnq
         vBVLUvjKXpIqm7YD2QSP9AK4y1TfGq/Ttorfoye6zY2EMVBPSTpwTP0GJanKX9ohyS6w
         i5K6Dv6qkWVLyxDiXjhgghb1/ESB2AGq9buw/mw/W8ncpqrXs6kvtzNB2PcZ45+M4nex
         Safw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2MIiys78gGheOmgr5sadClIeI2A+sMpKPCOuDS/ESKE=;
        b=RikgyHUjoOQqPwcrgdci67BjWvLwslIFlwjO86SAoO3nlIV39e+ngyHIDbfiv1PZUF
         ER766Ah3c/RW+ddknmXpmCGE2y8S9jyweu5FZcR8SidnURzuoT4uvAfgZHaf3vB5hoAd
         zrHJjv+KuibibdZDJufIIIXzV0Cv61fmDGjMoGR5A8kLoDKcxIi5sSDRePo/JtrU06b6
         hO5xgmuPZkyzokQr+JU+e9cvVOTWrGR4wXVyK7ZfwII0mr0w4aa09hp+dSdwcheaXBDc
         Cc1rrDE6kv4pEKfZiXf5RiMvUfuHt9Ww0uQ7g1G8KRhwEPcJm0qiTKvfDInvG7fQZTOp
         Vg0A==
X-Gm-Message-State: AOAM530tKtcD913BN/CF0bmHdHGeYWScckTKcsCwwPXYdrs26gOHPvKz
        5ZBjmBDEsLf8gd2JMdsGerEv6LonBQ==
X-Google-Smtp-Source: ABdhPJxBdd/PJ/l0pmbr2bj8AZZmXbcBbSQ4T1JSFjAYQMfu6rBVOZq6XAPfzUPajdaBTfa4OC2pTwynow==
X-Received: by 2002:a25:3608:: with SMTP id d8mr16539361yba.11.1590070960816;
 Thu, 21 May 2020 07:22:40 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:45 +0200
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Message-Id: <20200521142047.169334-10-elver@google.com>
Mime-Version: 1.0
References: <20200521142047.169334-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 09/11] data_race: Avoid nested statement expression
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that compilers have trouble with nested statement
expressions. Therefore remove one level of statement expression nesting
from the data_race() macro. This will help us avoid potential problems
in future as its usage increases.

Link: https://lkml.kernel.org/r/20200520221712.GA21166@zn.tnic
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Fix for 'const' non-scalar expressions.
v2:
* Add patch to series in response to above linked discussion.
---
 include/linux/compiler.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7444f026eead..379a5077e9c6 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -211,12 +211,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  */
 #define data_race(expr)							\
 ({									\
-	__kcsan_disable_current();					\
-	({								\
-		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
-		__kcsan_enable_current();				\
-		__v;							\
+	__unqual_scalar_typeof(({ expr; })) __v = ({			\
+		__kcsan_disable_current();				\
+		expr;							\
 	});								\
+	__kcsan_enable_current();					\
+	__v;								\
 })
 
 /*
-- 
2.26.2.761.g0e0b3e54be-goog

