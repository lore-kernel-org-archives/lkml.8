Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A8DC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DBE24680
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK1u9MXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbgBNUsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47085 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388212AbgBNUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so12449165wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqlwSy6JMgxnPSfhZV4GwX+hZPQbfgP4zcGS/hUO46k=;
        b=rK1u9MXuCcnFGL388qiEoUa8Jg+ToyIFWPYrxRIOpPzoRoDCk2NB2PjmION6rddk7T
         yIvAkdaQAUvyk5hw6ErIyf0wn1O8vJS/bNL0AcwP2zwzVUTdLr3R/9IdP1HfpchRhZQQ
         wm326/cNnSZfNleMu4Ju4ykSGtudK1Z9vLr+diS5RlU+XTiPZux6WvjZxPTTPVEkwaTi
         dVY1xukw7YnJARIPM228FIFB46bObW63W54wEVXouKJ3GjlLXLPEQn9eu+lBDRcE4nX3
         sbwmcWUe+lJQwPYJkZCX7n8RfZiOZF4uNmmdcjRqNk4vSVs2m2qiz3/3Pr+/98c3BM9d
         JjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqlwSy6JMgxnPSfhZV4GwX+hZPQbfgP4zcGS/hUO46k=;
        b=bLij0zL6f/qGiU090N+732ccBuHVs6oxmY/q63TTEGeZD9mJYriod29+y2c5K5CWvG
         lPGOCEgdqifTIfb+RpocB2BLuxDwMgc1LrgprJJ5BZzpRgDrChTZdTMCs9vl4wK+FnCd
         XL1PopFIh/sEFtg811il2hv2robHffH51SVk5O1Li7Z8ORLG5tIX4Knr3NLFlBZwJIOw
         D4u3rovgbIL/V4y4Ug3oKCb5rRbr0DOHWSMufyvpYkmC6h+NotEuSCnlpXp/ugeU0rY+
         xEvM+JiJhbHC2OCB7+8y8WcHkARAzHdfpxp95vdzoQvx2+KWV1ZPti91dM4I702tbZLv
         +Gyg==
X-Gm-Message-State: APjAAAVW1/VZtHOzfvUAVlx3l7rJasdN/sDbvZHsxloqwaMUhNtfgOWo
        ZCTH7QQ4oOYHgNwD9v0qpdgraqEDiT/B
X-Google-Smtp-Source: APXvYqx3BRdFm8QfTGe2Z9ycFT0iXwpatNpSCYxoADc3HCdoqycvCR6uHqsis0NapQD3Fq11gPG2mA==
X-Received: by 2002:adf:f103:: with SMTP id r3mr5806487wro.295.1581713327415;
        Fri, 14 Feb 2020 12:48:47 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:47 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR)
Subject: [PATCH 12/30] mm/zsmalloc: Add missing annotation for pin_tag()
Date:   Fri, 14 Feb 2020 20:47:23 +0000
Message-Id: <20200214204741.94112-13-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at pin_tag()()

warning: context imbalance in pin_tag() - wrong count at exit

The root cause is the missing annotation at pin_tag()
Add the missing __acquires(bitlock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2eab424c8c67..7bac76ae11b3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -891,7 +891,7 @@ static inline int trypin_tag(unsigned long handle)
 	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
 }
 
-static void pin_tag(unsigned long handle)
+static void pin_tag(unsigned long handle) __acquires(bitlock)
 {
 	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
 }
-- 
2.24.1

