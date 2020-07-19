Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A665BC433FE
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A43020738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPRMmWyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGSXMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgGSXLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38175C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:36 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 18so10812706otv.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjkiLR+60k9QfvgBZn9QHWt4cqJyvhTf2cZ66HgG/g8=;
        b=sPRMmWyBOK0bzRCo5iKWMGlfVESewAW1LHC2FSlaxXboPedqHIeGGyXAOx9RHiMbyJ
         Dm4793memuW+pbTsUVs2nu9TpQ2d8qSRNCA5STBDZkeJ6dUXggT9BgAS9agHv+OjiRTG
         i8eFEfg1QI+o725zDmImsBTWvNYNevwtSxzdANnkPxwUc8OAjbt6dR+i+N6WaLiaj4Rq
         9sgWWz0bjkI0h96XxMbkNRM7sXezeMqtdl7DcOrepbmO+lXrWG3ILtTISkp31zX7aA/+
         hUZNMl4kxctT8ipL4c6ZzRBFKEk0xpTGGIMbp0D4S4Fg3CCyI0vLc67T2gCnKPrBbYut
         6bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjkiLR+60k9QfvgBZn9QHWt4cqJyvhTf2cZ66HgG/g8=;
        b=UfpxEO2oomfqDlM5diqvMdWJAISx/+aIvQi1gaDxQe12oXOG24vIES4N5+cgNdHs/8
         0HKPPfn1FfMdsbqIuZwfW/zJJAqMmiuoHLorNW9e0YT3kdvcQSq8nqfmeJZaNzczIwo7
         nVVHjXUtCeGswtJ1fYMK4DkPOtppsyfObt1cVHNq1ikrpotP3ofgP6C1T7Rm9sfwiasH
         VRsnFE8D6JrUyV3wKhMWy7lJ8nwnMgwCDFuy35wdDQL+QtO+Myj3rTf3SBwBH+3H4DyX
         VldFyOw1mLLf9xMtOhsEBQuAA9Gg/Pb7kjkL2hK/d+S4pyD+Sps0/EBg5OzAq9JCKWyH
         ns/A==
X-Gm-Message-State: AOAM5319UFPKGfQaYGz394Gy43uiZg+XrBm6nOmF4CM6wl2FGJnj7CC9
        h49DNFtmwgoQeJPMebBoy60=
X-Google-Smtp-Source: ABdhPJz9YdRGF/dws8Tzc1lDIJSUQyELx9Jcg24qi6ogYUzhTY6rNZr6l9gUZGTfYoa3+cob32KV5g==
X-Received: by 2002:a9d:7552:: with SMTP id b18mr17096570otl.344.1595200295572;
        Sun, 19 Jul 2020 16:11:35 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 08/18] dyndbg: fix pr_err with empty string
Date:   Sun, 19 Jul 2020 17:10:48 -0600
Message-Id: <20200719231058.1586423-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this pr_err attempts to print the string after the OP, but the string
has been parsed and chopped up, so looks empty.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0cb5679f6c54..1d25a846553b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -420,7 +420,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			}
 		}
 		if (i < 0) {
-			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
+			pr_err("unknown flag '%c'\n", *str);
 			return -EINVAL;
 		}
 	}
-- 
2.26.2

