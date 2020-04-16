Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78F7C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB521D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoPHn4aW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506475AbgDPLpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634025AbgDPLny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:43:54 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DACC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:43:54 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id r11so1550261wrx.21
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/kCl4Qp/HWFb3bfjnVpgsPir2dBStE2GQr6w0WtQly4=;
        b=LoPHn4aWZllHhakXzK28hq0gYhdoPqjIUb5q8/9LUlHog4lr4YMsmhmr8PmtJTdMav
         xM6ygCdhcmyyvfd/mJ8DK3mdTAY9KsDJy6ksfNFP+kPKzedwwKjmPRVSb0f5b538c2G5
         WHSBeN5XustfBv4quIIiTSQDddY1iixE9KDr/fqmBHTmJPz+uP4AOB9efp28tE+mDE2P
         /fQ6mz3ZOi+SukgXRg232QEAxg43TB7bzsLQC7GHociU8BZGVw/bquOFTGonDwSou/m2
         Zkj3TJJbNndy9201si0eQbdT0J8AABk0pWCg+ZCj2/Nn0u/qS3iOlZuFfuGZbGyYAEFU
         RQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/kCl4Qp/HWFb3bfjnVpgsPir2dBStE2GQr6w0WtQly4=;
        b=Lj7ZOtiF7vJaYa9pMn2SvORGbVYt+dud/MpSLHPuIdrPc69ubVVabQVQRKK2bVmaBm
         M6B/vYoBa1CI5c8Z4O454UZ6a5T5sdl9qLl0esn3VvLXfDwEp5uwlTauQ9kxF5EIigK5
         U8Lcd6diejfIt2xb0TsjdwId4CYzXUrDsk/A10qEm91N+NqfGIWRIfUM1EYCbNLTP/8q
         bhU06Vi5FiX+GFB/PR6hWmVxrcIPUb7HOPd2kLQvadw5Vlf5Y+HtvBWvhSraHOQaYZUQ
         uLuk/P5GzdGBUzUPDeHCbA1BWOVbVeH33GNWzY0mHyXvzv/8/zO1GKL9vRM3lDkW0/wA
         QS6g==
X-Gm-Message-State: AGi0PuZkV0u0a1IV4ahUGEwMNi6hVkLFkYHs0dKabeYgDsv4tXfywt/H
        vTaQFQwA11UOJKPVCPfatDLyPCOOmg==
X-Google-Smtp-Source: APiQypLbJHPjUQ2RlNkAM2mV95H3x40l/9Wm7yqr0AuKQvBVjKLGdfbybl/iUwu5f7bkVTRNSwWM4kQfuA==
X-Received: by 2002:a5d:404a:: with SMTP id w10mr7562452wrp.397.1587037432601;
 Thu, 16 Apr 2020 04:43:52 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:42:57 +0200
Message-Id: <20200416114256.226329-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] kunit: Add missing newline in summary message
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        alan.maguire@oracle.com, frank.rowand@sony.com,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing newline, as otherwise flushing of the final summary message
to the console log can be delayed.

Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/kunit/test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 7a6430a7fca0..ccb2ffad8dcf 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -93,7 +93,7 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	 * representation.
 	 */
 	if (suite)
-		pr_info("%s %zd - %s",
+		pr_info("%s %zd - %s\n",
 			kunit_status_to_string(is_ok),
 			test_number, description);
 	else
-- 
2.26.1.301.g55bc3eb7cb9-goog

