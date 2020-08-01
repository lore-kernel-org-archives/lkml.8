Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB8CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA8B2076A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFpkgMHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgHASqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgHASqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:46:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC40C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 11:46:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c80so11058297wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lYVftSeKWtv82RkcEjL/lpHSO/4ZGc4ItPGRuKW3M+Y=;
        b=AFpkgMHNpf9cG8eKjkOX9FQrJ3xcasdHHae9E85xX10FcCoBz5bkJFaq7DrUwY8Wq8
         qeDjaUnTsTHoqSNHF+nymeQO/40B82plqCMuLF+yCGvsAt1IsHJ/pvm7O5LVGtHvF9K6
         C90MaPtL4a5Xs2g0kczm1Lni4OFdLi5RDXVU1no3jGVuwUkcKI7/jztGfPvSrTx4jy1Z
         53oocLuuzjsSZbgxm6musnDL9EqNbn7s65SX50+RWA5+2hHVl++mqfWdRa5hRYH2XVGJ
         /Nx2jzTwfT8XmeYxxQBsw+8zSwba5IgY8UTEEElJusMhVdptZRI81kIy0sIjCJntWkuQ
         2wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYVftSeKWtv82RkcEjL/lpHSO/4ZGc4ItPGRuKW3M+Y=;
        b=BR6x+c4nuQekHuKn0gDp4UlCiKbSPvAmx1gdqiQu45IIwX1XzF/8NsoVdriu5Khuzp
         Il2NzREdibiwPqEKs0iWgT8xBC8IYSg8a2hfgj9vIAgc60+jXWk40mGX+FPkU4WUgLub
         wMNQW6yCk9oYVTZ1eQOX3MEpcx8iPMJCTrKEpTxRAbi6TMFqAVSk4SNHTmpo9kaxnAo3
         6OTnHDhMZVbAV90yCtV+OYFATGdkjOGMr4k/m4eCeDkpFxoJvnQVCtaDQucPdrBJfqCQ
         rf5qPHU2v/9EmZZ96mLM3OOn5eXHezKkiJkCJtPzygxb7RhrIJNCvaWYG9LVnUBlR22q
         7IYw==
X-Gm-Message-State: AOAM532ObwE03s4mt1HUcy+iZd4Cjg+rForxDAkELTkEO1wFDsly8Ygj
        OJ64olLjjikVAKot61MIx1oOxUDc9Ng+
X-Google-Smtp-Source: ABdhPJyqLEl7sAWrbFV7+FymYo1AuoB+mxNTGNDerUi6jsmnyfuOJGhc28nMo7JVr7tTPsCFOTLp1w==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr2366699wmi.101.1596307595562;
        Sat, 01 Aug 2020 11:46:35 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id g7sm17468447wrv.82.2020.08.01.11.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 11:46:35 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/4] acct: Add required space between variable and operator
Date:   Sat,  1 Aug 2020 19:46:00 +0100
Message-Id: <20200801184603.310769-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200801184603.310769-1-jbi.octave@gmail.com>
References: <0/4>
 <20200801184603.310769-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch tool reports an error

"ERROR: spaces required around that == (ctx:VxV)"

To fix this space has been added between the variable,
the operator and the value.

Add the missing required space.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/acct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index b0c5b3a9f5af..d7cc5f917e11 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -451,7 +451,7 @@ static void fill_ac(acct_t *ac)
 	do_div(elapsed, AHZ);
 	btime = ktime_get_real_seconds() - elapsed;
 	ac->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
-#if ACCT_VERSION==2
+#if ACCT_VERSION == 2
 	ac->ac_ahz = AHZ;
 #endif
 
-- 
2.26.2

