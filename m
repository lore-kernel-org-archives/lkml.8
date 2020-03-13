Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5DBC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971BE206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+SVMP+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgCMStX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:49:23 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39305 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgCMStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:49:21 -0400
Received: by mail-pj1-f67.google.com with SMTP id d8so4801360pje.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=90AE9sMx0DmNIFlwt1eo4jRDreFCtqYc27Ffu1Laysw=;
        b=Z+SVMP+BWpseMqQPeLmm/ybhgsB65oa13OSI96503tIGRdkD2U32+m+2S8xKsATDu2
         G08fVtJ7ru8/9/E2jZemD1CUoxdatZ4GqBRQ5m6MdSstwUowBrbbt0YUhLPdZVhnkm8R
         wr/evXIx3lO/w4rDKbfGpc5yjPp5ggOSJOTUwN5k+xZsl2LIFWW5CdCuPlApicnqcHvh
         dQUCvLg0UQG3iXuwrH3GbOyoC97EOrkANjOfN0fn9hE0LQyt9zoLFavobiVA5Cev6wNx
         x2vUyZ8+dFyyvkFTgW8bXdJQ+fSjqvTJrQgoaYAW9m5P5WnX9nV4roipd3yhJ/e+Kchu
         w21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=90AE9sMx0DmNIFlwt1eo4jRDreFCtqYc27Ffu1Laysw=;
        b=Delj9Y4EpnBMYsWrh6PwWcTIBF3jUH7x849iG/7Vf063Igm+NV2tdcwc8SxpNCrDin
         993QwFp3FUKyWTho8tBG77kpKYynGADIFWxt4BKTIveYxeuLZ77/kShlq79azHGNjlmw
         r7gX2BO/Xu45/zfXrkHG6NeYwdu/0ec1TOITMYTVbzK7oDF4p0FgrezzxumPJww9nwnR
         nEv95zwy2SiDM8akZccoj2ds2aQAw9sFvlZW+6fI0ETOSCPal5k19cQsgQgU2kh2zv94
         sikSxl1VfAvjkDviVMvmK3Nnq28tiro6C5LDeKXe65KYhAqYJaO+Kn81E8bc2hKkrqjI
         pIYw==
X-Gm-Message-State: ANhLgQ1QY3eLVESemN97HHxiGY7oh0qslIBJPmGdFjP9z7ibkwCe8TaR
        MlRj1wS5vLQZDX3UwmcdOYQ=
X-Google-Smtp-Source: ADFU+vvANNqJb9ZoxH/9mV+/K4EDklVGly0wimelaijHmruWWnFjpQxZD81x8dTuAVTZG74EW28m9Q==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr14554874plp.40.1584125360970;
        Fri, 13 Mar 2020 11:49:20 -0700 (PDT)
Received: from localhost ([161.117.239.120])
        by smtp.gmail.com with ESMTPSA id f69sm6493705pfa.124.2020.03.13.11.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 11:49:20 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     willy@infradead.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH 2/2] radix-tree: fix a typo
Date:   Sat, 14 Mar 2020 02:49:09 +0800
Message-Id: <20200313184909.4560-3-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313184909.4560-1-hqjagain@gmail.com>
References: <20200313184909.4560-1-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"iff" -> "if"

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 lib/radix-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 379137875e25..0534823adf07 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -794,7 +794,7 @@ void *__radix_tree_lookup(const struct radix_tree_root *root,
  *	Returns:  the slot corresponding to the position @index in the
  *	radix tree @root. This is useful for update-if-exists operations.
  *
- *	This function can be called under rcu_read_lock iff the slot is not
+ *	This function can be called under rcu_read_lock if the slot is not
  *	modified by radix_tree_replace_slot, otherwise it must be called
  *	exclusive from other writers. Any dereference of the slot must be done
  *	using radix_tree_deref_slot.
-- 
2.17.1

