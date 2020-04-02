Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36669C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0648C2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OHFqzXVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbgDBIKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:10:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43916 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387449AbgDBIKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:10:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id g20so1486210pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=rr2+JiyOTzs2D6VximK33Aonne21icc+eHi8FG/OnsQ=;
        b=OHFqzXVgCRW79+evfsGJ+kuZ94Ph3DbjI/cTcvPV402yG5nto9O5kiCL6nH1/ilwad
         P6532gUewqNBMEgllX6tCRBOtx3JEva1KlJfeC0UgLZdWSfZwkIgEzx0gn3MZuq/clpu
         xzv5W/9bmWHbnCVGIKEOWh01uMHGtNQu0mxXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=rr2+JiyOTzs2D6VximK33Aonne21icc+eHi8FG/OnsQ=;
        b=icvrjpUY0MOAWC1bSXsNV+F5iIz5Ehsao8eCefPZ1tQGP1/x8afU/1+W9KOWHY6slC
         ZgepAgnCBEp9qbQq77N6LbZWVFYCzyGs+4k6HK3C4ZkwbSBTPv64rCAP22PuWLLgQAof
         WcJ4a7aDO30rPglHhn4xXDU8mGL/hNRt+fzQ3CwupfFp+GrCQfu+5aty0MlwswTjuk5/
         jeOBBlz5WpnFFHDB0Ax5gLQH8SWgs2FAL3bGfw0i0IIZ+x4Omk/oY41mHDsfb5Acc157
         4v+JvDuHkNnh2U/uiSkreCNwV6zbXA23KcxirPc8Xax0B/3XsZwkB8JGhC9IsYJDW/cD
         zZ9w==
X-Gm-Message-State: AGi0PuZwzf1JCkyZHy01nHdVj51hYbLG69cgeUNOUKBNk5qYQE2w2sTT
        z0ityQkDKWy9mBSgzrYhD+z2ug==
X-Google-Smtp-Source: APiQypJ1LS6Q4XLKxKhj4KtCkhkkBK2oMRUFgRtWym8HkRx+R3SgX2/W68HhQ4MfO49pRYbr+N4Gmw==
X-Received: by 2002:a63:cf50:: with SMTP id b16mr2200848pgj.189.1585815049479;
        Thu, 02 Apr 2020 01:10:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i15sm2908549pgc.74.2020.04.02.01.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 01:10:48 -0700 (PDT)
Date:   Thu, 2 Apr 2020 01:10:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     Alexander Popov <alex.popov@linux.com>,
        Emese Revfy <re.emese@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins/stackleak: Avoid assignment for unused macro
 argument
Message-ID: <202004020103.731F201@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With GCC version >= 8, the cgraph_create_edge() macro argument using
"frequency" goes unused. Instead of assigning a temporary variable for
the argument, pass the compute_call_stmt_bb_frequency() call directly
as the macro argument so that it will just not be uncalled when it is
not wanted by the macros.

Silences the warning:

scripts/gcc-plugins/stackleak_plugin.c:54:6: warning: variable ‘frequency’ set but not used [-Wunused-but-set-variable]

Now builds cleanly with gcc-7 and gcc-9. Both boot and pass
STACKLEAK_ERASING LKDTM test.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/stackleak_plugin.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index dbd37460c573..cc75eeba0be1 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -51,7 +51,6 @@ static void stackleak_add_track_stack(gimple_stmt_iterator *gsi, bool after)
 	gimple stmt;
 	gcall *stackleak_track_stack;
 	cgraph_node_ptr node;
-	int frequency;
 	basic_block bb;
 
 	/* Insert call to void stackleak_track_stack(void) */
@@ -68,9 +67,9 @@ static void stackleak_add_track_stack(gimple_stmt_iterator *gsi, bool after)
 	bb = gimple_bb(stackleak_track_stack);
 	node = cgraph_get_create_node(track_function_decl);
 	gcc_assert(node);
-	frequency = compute_call_stmt_bb_frequency(current_function_decl, bb);
 	cgraph_create_edge(cgraph_get_node(current_function_decl), node,
-			stackleak_track_stack, bb->count, frequency);
+			stackleak_track_stack, bb->count,
+			compute_call_stmt_bb_frequency(current_function_decl, bb));
 }
 
 static bool is_alloca(gimple stmt)
-- 
2.20.1


-- 
Kees Cook
