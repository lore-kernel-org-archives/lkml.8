Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505CBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3075C2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dud3MkEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407165AbgFYUhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404887AbgFYUhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:37:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B51C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:37:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so3326221pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whJHMFEMgjRzi44wy4EIPH6hRXPgVH5q3fW7lz7Bwr8=;
        b=Dud3MkEn4GePcKidwA+cOtfaGIUA6tPP+wAkhU7r4p6+B8dsqDRYdrbOeiy89w5tBN
         J/ttvB3Shs/FgX5z0KkbK/lMGUyVGXj9t5dZnEJDa2PvDDYB69a46nEnxVLHVDKm2Nd2
         unGr9qlIU0vcmSzYZKROIMPoprBh418FIiIBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whJHMFEMgjRzi44wy4EIPH6hRXPgVH5q3fW7lz7Bwr8=;
        b=Td3ypfvv5W7OeNtcNr0sKpVHvdRZe92rqO0BlCooO9wltx9Eqiq5nlB96rRUP8pyzH
         8BRD9Thkom94WgKmCjBxzkFmV1B6GTrDSP+unfOJ18VkRVtKAOj5mv2mqPbT13f0oE3a
         mfF6PhPfDpIi9IDttf7LQ77jrtPOPERaDxn+2Sb+/EiLHjXW5YlU0mQRpDR06VaXC5uS
         TsHIwVEDZPjaLvepdvLHmELUjczN94hTZ6AAf021S6in+J4Ij4AG1z48yVS/k6yc1US7
         ECy40ONDHk4fuhuk3RzBGj3bdD7vk6kz2//RiF7TIfFJVNH4PFsl2cmqtSd5lE4mGAH2
         vspQ==
X-Gm-Message-State: AOAM532LrTK6HS1l1QfUc2k++34VjIWyDtPYJqvyuP7VnE/0zGIRusbU
        Dklf0p5M/AiPTXwQ1n7fNkCOGg==
X-Google-Smtp-Source: ABdhPJweFpJ4U1BCmjhoHhooi1MRUVbsWHQEhCsnDvQRjutUSrEy0423vFl51cCRoGIZsuNSTQGaKA==
X-Received: by 2002:a17:902:ba81:: with SMTP id k1mr34579262pls.218.1593117428146;
        Thu, 25 Jun 2020 13:37:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13sm9278734pfr.181.2020.06.25.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:37:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc v2 3/4] selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
Date:   Thu, 25 Jun 2020 13:37:03 -0700
Message-Id: <20200625203704.317097-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625203704.317097-1-keescook@chromium.org>
References: <20200625203704.317097-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we expect to see warnings every time for many tests, just reset
the WARN_ONCE flags each time the script runs.

Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/run.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index ee64ff8df8f4..8383eb89d88a 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -8,6 +8,7 @@
 #
 set -e
 TRIGGER=/sys/kernel/debug/provoke-crash/DIRECT
+CLEAR_ONCE=/sys/kernel/debug/clear_warn_once
 KSELFTEST_SKIP_TEST=4
 
 # Verify we have LKDTM available in the kernel.
@@ -67,6 +68,11 @@ cleanup() {
 }
 trap cleanup EXIT
 
+# Reset WARN_ONCE counters so we trip it each time this runs.
+if [ -w $CLEAR_ONCE ] ; then
+	echo 1 > $CLEAR_ONCE
+fi
+
 # Save existing dmesg so we can detect new content below
 dmesg > "$DMESG"
 
-- 
2.25.1

