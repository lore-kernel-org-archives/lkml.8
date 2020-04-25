Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C2C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 04:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C2620767
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 04:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USf3A4Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDYE2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 00:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgDYE2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 00:28:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02084C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 21:28:21 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m2so9613432pls.20
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 21:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jlWm2W56cPxF9swXmGH8NRqkrkbQu6KJvx19LPVmMj4=;
        b=USf3A4Bo7Zr8p6MaHrHFt3d//e574hrCNQpuIO9UKVHA7Gx+vJCaDGq9godA8VTfAO
         t4buVW4N0SOLBVmFRG+pw2l1Zjf5E1tp/jz9eZGXAjs31Ez3z2aTi1fJrWAP7+PKtXXO
         9ERRoDsujoOlLS1+vxQKFcDNU37rcWQ82d4kSAYkHwUx5aC6kQXtahOPVdmP5xBHcF2P
         GIBnrKvHG/Hv006bRZn/XWEVXItQ3PWsA1QaTFHc2Z4iqpXyJHb9y58604S3yfdGHULj
         i6I3YOtD0c6rNszhHZlFwd+5jRxu9rGu8IwKBYMbcMGc3wSCXN6eDwwv+hAPs2S2oT/j
         L5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jlWm2W56cPxF9swXmGH8NRqkrkbQu6KJvx19LPVmMj4=;
        b=WSmt/PJck+fY9Kr/8t0ieYf5/VnMEyDhGp2N0VGufUZxk7dkMjHFjkIk1buCzzPeH8
         4eN8pbuPNq8lriCZH8ZYbEvmoA4tBaW1DQaPy86r3ljEr4fCYHa5VM2afDwDKVqjURM/
         OPizQ5Iq18T7dpuj4jMyAZx7zV1hlC750y06o551e9BjNNHIEj1A7KV6UYVgJWhx+S5j
         SFjTA8V1AlhzxGXEsRjFLQ8eHpJ9C2Y//jrY1L5emuyz3OW17Mo0sl7o4Zpxv8WHrets
         CmqaqXy8ri16WAqzBCq2cH0b5xB64Elx2snKJcSULhTa0l5ELcgrklqdrfjsiRV+hzzV
         RxIQ==
X-Gm-Message-State: AGi0PuZXawBERZdlscOAOuSYJFQN+AddLW8s0PnRoRAKjb7bGLlWkXfL
        K7LH6mb0QNC1z6B5GB1o4g7HvObG95OijQ==
X-Google-Smtp-Source: APiQypKmbTXULY46nA3boun6yFxN3mnnz6RPfPbLSPhfo7WU3zVgjZhi1VF7XdY9fAWy3Y58zhtWQIDdrvV8sg==
X-Received: by 2002:a17:90a:df15:: with SMTP id gp21mr3536242pjb.2.1587788900064;
 Fri, 24 Apr 2020 21:28:20 -0700 (PDT)
Date:   Fri, 24 Apr 2020 21:28:14 -0700
Message-Id: <20200425042814.132920-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] um: Fix "time-internal.h" include in xor.h
From:   David Gow <davidgow@google.com>
To:     Johannes Berg <johannes.berg@intel.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the wrong header was included in xor.h, breaking make
allyesconfig on UML (or, more specifically, kunit.py run --alltests).

----------------------
In file included from crypto/xor.c:17:
./arch/um/include/asm/xor.h:3:10: fatal error: shared/timer-internal.h: No such file or directory
    3 | #include <shared/timer-internal.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
----------------------

Replacing this with "linux/time-internal.h" builds fine.

Fixes: d65197ad5249 ("um: fix time-travel=inf-cpu with xor/raid6")
Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/include/asm/xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index 7a3208c47cfc..36b33d62a35d 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm-generic/xor.h>
-#include <shared/timer-internal.h>
+#include <linux/time-internal.h>
 
 /* pick an arbitrary one - measuring isn't possible with inf-cpu */
 #define XOR_SELECT_TEMPLATE(x)	\
-- 
2.26.2.303.gf8c07b1a785-goog

