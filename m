Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC055C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2CA2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7pR2L08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgIIRCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbgIIPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:47:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE2C061374
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:18:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so3139414wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9k53vYT+N1BhX48Rij3GUI6/3bZme1pQPIscVRVPBk=;
        b=w7pR2L08zpdeRf35Al+3qzs7BazoxXi4K4IFvtwZqlJyksSS0c7H3PF2KZ2sgSSDpP
         FujlD1ob/vsHrx5wxZLDonYVVHtcd+AXdHbZfNbNzsCZkbidsTZ+Lr4Nfn2Nd9M9vZBu
         6WI2b+ZvoxZ3zrP6nAIC6cjUK0kdYgTnytIoeXk4TNJlyjW7FMxZBxbkvHoOBZ82Zlrd
         kIL8pIbKnrXxflQBzM8bWpfk3tpF7rBN8mZm195zu+18tAAPCku7Da+vnsHdKAA/FT74
         EElHBXICQCjxCOv9+mZ/k2kk1GjvOPKLrcQ7X/wJpKqivHZx1iP9jiI/2aQIvbMhY/jx
         h32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9k53vYT+N1BhX48Rij3GUI6/3bZme1pQPIscVRVPBk=;
        b=OKNq2X7Sf36qBMU9dW1WyW1WWtRkxX7FFaH08Shmsu1Ca4P/5sd6LYEZeM4bwzPeh9
         H/Ru9KDkf3oGeFyIlZhntW5lRWiR5i71+d+yLG/KwdztD3mIbBlAWKERX626n/m7UX9+
         7eVTAmsEzvmsd6gSqUxEU4e2TJ1vnY1LN4HzBMKvFVfrMufZgR/ezIF7vCp5eaf2e2jo
         5NXKcEGwdiPaAKMeCoS8IEbEC3up9M5mpKXGVvAeRc9gAamJrW3e5OTThS+PpuoHQ8vi
         BzOhQqAfnq+VNumq0zjo0CCqdm7LbGvUO8yshWE8pX50+lXTuUFSYiYguO62TkWyn5Vp
         8toA==
X-Gm-Message-State: AOAM533ZE8OS7pBWvqzbWV7G4XtFKCi39LHvprwzlVSPAVnOBXGLIH8m
        DLMXgevQqe8Lq7/ZBFzhdu06ng==
X-Google-Smtp-Source: ABdhPJzTIAjuCKugtfkjMCZdT9znBSCY0+3Irznm89yqpZg1M9XHZgxPVJURAeXo03ClvT2+A4cCiw==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr4138682wrt.409.1599661085905;
        Wed, 09 Sep 2020 07:18:05 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q18sm4463736wre.78.2020.09.09.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:18:05 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH] kdb: Fix pager search for multi-line strings
Date:   Wed,  9 Sep 2020 15:17:08 +0100
Message-Id: <20200909141708.338273-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently using forward search doesn't handle multi-line strings correctly.
The search routine replaces line breaks with \0 during the search and, for
regular searches ("help | grep Common\n"), there is code after the line
has been discarded or printed to replace the break character.

However during a pager search ("help\n" followed by "/Common\n") when the
string is matched we will immediately return to normal output and the code
that should restore the \n becomes unreachable. Fix this by restoring the
replaced character when we disable the search mode and update the comment
acordingly.

Fixes: fb6daa7520f9d ("kdb: Provide forward search at more prompt")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    In the long term the kdb pager code would probably benefit from a
    bigger rewrite since the way it handles newlines is still quirky
    and confusing. However this fix is easy to backport so I decided
    not to hold it back whilst we wait for code that is not yet
    written.

 kernel/debug/kdb/kdb_io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9d847ab851db..e240c97086e2 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -706,12 +706,16 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			size_avail = sizeof(kdb_buffer) - len;
 			goto kdb_print_out;
 		}
-		if (kdb_grepping_flag >= KDB_GREPPING_FLAG_SEARCH)
+		if (kdb_grepping_flag >= KDB_GREPPING_FLAG_SEARCH) {
 			/*
 			 * This was a interactive search (using '/' at more
-			 * prompt) and it has completed. Clear the flag.
+			 * prompt) and it has completed. Replace the \0 with
+			 * its original value to ensure multi-line strings
+			 * are handled properly, and return to normal mode.
 			 */
+			*cphold = replaced_byte;
 			kdb_grepping_flag = 0;
+		}
 		/*
 		 * at this point the string is a full line and
 		 * should be printed, up to the null.

base-commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
--
2.25.4

