Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F1EC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71A4206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h/doTU1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgD1VO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726697AbgD1VOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F97FC03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:14:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so8998920plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OVNvnisfgkYu5LPJfO/kG/+xFAcsPKgHoSUZfW5y90=;
        b=h/doTU1qG1diDauaG4awPo0siVlKxs5d3hJ4lnA8tM0J401L3v3bBQmJoeyedEqXwb
         51qxQobOPjOp0YRYa5DgkvyAUSbSbtN8u8KC6zK6J0bnGAluamUTpb+thPIv8ZnZ6hHp
         Agc3yHDWqkGWoApmfRi9iFjYsxh8LUGVylncM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OVNvnisfgkYu5LPJfO/kG/+xFAcsPKgHoSUZfW5y90=;
        b=O5pRZdQXsbs/q06OCIYWtqnm7qUTiCgMwhoF96uX94uSmvHSUY0SG+ZzaCTxQn0DnO
         B/k3X6kAEl2hSmB3ipZ4QRTWdaKQt8pAW6cDEfqWA2mJSq3zZFyso1vDvJUpBdtgxL+o
         HsVJNW1hXPjg663CVc3S7tqau6hY69ziV/GjiqBspQkTelRT5Lp/5+nzEOQiOn18qvla
         asbS/uwnXJhhIybcKp5rKCHLPTluVfKcGRQF86mVgbnjX+/zgUZ447N3L5mWJq8SaxHe
         vjemF9r7P1n8wLDzefjMIK+gRCuz38mDAksvZfbQ+aREGgl4BgZYyE5df5CWtUS/29Rl
         eaxg==
X-Gm-Message-State: AGi0PuaMRox4oSYkDKibp8X3ghogjcPQ3t7iZ37jcaYgnC+oX47ET8E2
        fXac4hHeeL03fan1oQz0lf+myQ==
X-Google-Smtp-Source: APiQypICBO33ruUlGkSJaFNPeFlv0L/gbSK0rXL8fq3M4//PGxHAL3DVuuFb8F/+QnhjSj2tyQD97w==
X-Received: by 2002:a17:902:bd09:: with SMTP id p9mr18601373pls.214.1588108460637;
        Tue, 28 Apr 2020 14:14:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm2988202pjf.30.2020.04.28.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] Revert "kgdboc: disable the console lock when in kgdb"
Date:   Tue, 28 Apr 2020 14:13:42 -0700
Message-Id: <20200428141218.v3.2.I02258eee1497e55bcbe8dc477de90369c7c7c2c5@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428211351.85055-1-dianders@chromium.org>
References: <20200428211351.85055-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 81eaadcae81b4c1bf01649a3053d1f54e2d81cf1.

Commit 81eaadcae81b ("kgdboc: disable the console lock when in kgdb")
is no longer needed now that we have the patch ("kgdb: Disable
WARN_CONSOLE_UNLOCKED for all kgdb").  Revert it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v3: None
Changes in v2:
- ("Revert "kgdboc: disable the console lock when in kgdb"") new for v2.

 drivers/tty/serial/kgdboc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index c9f94fa82be4..8a1a4d1b6768 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -275,14 +275,10 @@ static void kgdboc_pre_exp_handler(void)
 	/* Increment the module count when the debugger is active */
 	if (!kgdb_connected)
 		try_module_get(THIS_MODULE);
-
-	atomic_inc(&ignore_console_lock_warning);
 }
 
 static void kgdboc_post_exp_handler(void)
 {
-	atomic_dec(&ignore_console_lock_warning);
-
 	/* decrement the module count when the debugger detaches */
 	if (!kgdb_connected)
 		module_put(THIS_MODULE);
-- 
2.26.2.303.gf8c07b1a785-goog

