Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B9CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2912072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcrbEQbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgCaTdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:33:43 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:55610 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCaTdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:33:40 -0400
Received: by mail-wm1-f74.google.com with SMTP id e16so851997wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9pebgwHDTkH6XXgFkmfU8WrI61o8Xng8dx0KtxlN/Ec=;
        b=bcrbEQbzha46FNQKOhHvEOXyCZjTTeyfrvyUUT5tAoh1N+CRmSvTO2pni/gbLYflZV
         NhLRfhoNIZLmONihlHGjhS8BjlldxjAzNj06/NMLGhBff2cgkNKTJz22hCcUpcpf3WdW
         0Cw0MpE0SFhzoRFAco5Z1z9hv1Q1nh0b4PGPvLWSNPUTszgZhZtKVM4eBXcAyvX0xxGJ
         UAfgWFXaw7wmWOJ7ZO14oczV9vNptY7WYlrRHp4SCGHp/OCV6WQXZbk4BQBVl4CiOLUx
         KMLWXoJbcutnoYGBWdvHmyUsae2AtHO+4NWBBZbofgy3A+hj91xMfW2yge6d9nzTTSgq
         yIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9pebgwHDTkH6XXgFkmfU8WrI61o8Xng8dx0KtxlN/Ec=;
        b=ElGiCYEriKBznujioLCfzhdwOFD2YY1EqZfb4QSkDMPcKFpmorCHUovnokFsxtlbj1
         EWkZy9NwmRnmnHIaqfigNDz0XZZZie+Spk1bPdsCL6lbXwtYkY5pe7elPi9I1t+43+9H
         ywkNdXZUWcXKZ3YdTDJnULrGl+dPgeAqqx37POjG+XQTVEZKZF5ZCAWDXL1oJMCU/UVf
         +1XSSR7PDwr4WCfOP4Q+4jm1StzAwFOgBZ0RIfSSQ1E7goAmot87HZoE7S8DZX12tfvD
         dpU8xdme6IAcr6eqw3PSAI/fL5X0LscassIYyYbIlf55gI4Fc+/qZvzef/lMODgWUT2P
         btbQ==
X-Gm-Message-State: ANhLgQ3MkeAYMJXpaVAqX9J9NGNM/MlTo4efH8MRQLvTfn15oJA9NPET
        tGWLDFi0X/wQynwTktNScgZHDTT7ow==
X-Google-Smtp-Source: ADFU+vvo4G3bWuWjE+I9QyLYVhQRuROpUBi9RvM4R7ZrTh+vkeaksbtrOWuaLLRlGKRCqZ3CsnsnywsRAg==
X-Received: by 2002:adf:b1c6:: with SMTP id r6mr21490360wra.49.1585683218503;
 Tue, 31 Mar 2020 12:33:38 -0700 (PDT)
Date:   Tue, 31 Mar 2020 21:32:33 +0200
In-Reply-To: <20200331193233.15180-1-elver@google.com>
Message-Id: <20200331193233.15180-2-elver@google.com>
Mime-Version: 1.0
References: <20200331193233.15180-1-elver@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH 2/2] kcsan: Change data_race() to no longer require marking
 racing accesses
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus far, accesses marked with data_race() would still require the
racing access to be marked in some way (be it with READ_ONCE(),
WRITE_ONCE(), or data_race() itself), as otherwise KCSAN would still
report a data race.  This requirement, however, seems to be unintuitive,
and some valid use-cases demand *not* marking other accesses, as it
might hide more serious bugs (e.g. diagnostic reads).

Therefore, this commit changes data_race() to no longer require marking
racing accesses (although it's still recommended if possible).

The alternative would have been introducing another variant of
data_race(), however, since usage of data_race() already needs to be
carefully reasoned about, distinguishing between these cases likely adds
more complexity in the wrong place.

Link: https://lkml.kernel.org/r/20200331131002.GA30975@willie-the-truck
Signed-off-by: Marco Elver <elver@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Qian Cai <cai@lca.pw>
---
 include/linux/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index f504edebd5d7..1729bd17e9b7 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -326,9 +326,9 @@ unsigned long read_word_at_a_time(const void *addr)
 #define data_race(expr)                                                        \
 	({                                                                     \
 		typeof(({ expr; })) __val;                                     \
-		kcsan_nestable_atomic_begin();                                 \
+		kcsan_disable_current();                                       \
 		__val = ({ expr; });                                           \
-		kcsan_nestable_atomic_end();                                   \
+		kcsan_enable_current();                                        \
 		__val;                                                         \
 	})
 #else
-- 
2.26.0.rc2.310.g2932bb562d-goog

