Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636AEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7A7207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KK2BAaIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404023AbgEZVUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403878AbgEZVUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:20:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D90C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:20:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e11so9793678pfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGisQOmV53APODapZGkiDQDW8pXpGOOkL2XHOF+ONZg=;
        b=KK2BAaIAJ5Yi+TjwvE6MIde1Xjru0T5NibzAPzJhO8RKPqzn8GcPkr2VIoE6xPH0+U
         FGSplpDbAP61D36YAYEzx+L9yoZlEuUje6O2N5qNB5tgNN7uaWi4EKhtqhAialpU+Hmo
         ct7qVgSi0UawvYteoDUGFGo1alXKRElYtmWgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGisQOmV53APODapZGkiDQDW8pXpGOOkL2XHOF+ONZg=;
        b=ApnSnOGSUh+bYh5GZwjbNfBxIWddUEJ8QxlnYBqd5uVAUDHRg6lbFancAmw76F/jck
         ArP61Ofe01KuBbrLTMrL55UXAYixQ6WmPkBqyF03Yh+Mib/I1+KIpGuJyHz0DKzla3uy
         Gv6WHxUNYTrkM6/pYkPe/iRTCVGOek2ZyqTDITXkWYRsMW7g/cHkfoNFzZ4FltuRTrE0
         /wQVSe4as4u7o8tqtEPLCmNYoWFqKlz6mWwrxWvRR9dn1fwrwoHPYyUoCQObU+ZcAy+p
         OTFKqx83fPnjzSVtFKJXQzjLtpD3lF6eegxtepcHXlUKguWe7GBijF2WR63jpdQTsG3p
         OBYg==
X-Gm-Message-State: AOAM533NhloL9Jh/CRYO2SvgLUGCIL+QqmNAwgcsNnZ/nwxMjozhAGlS
        3uvSrO7ObU+TgwwATVf5xRvB9w==
X-Google-Smtp-Source: ABdhPJyRUTHJ2NTlACR9GHLm4lZWKlgOuHItqYb8TuIugAbs40aIbrPeUzCFI4VokAb2FKgL8osG4A==
X-Received: by 2002:aa7:9464:: with SMTP id t4mr696239pfq.52.1590528032045;
        Tue, 26 May 2020 14:20:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j124sm382333pfd.116.2020.05.26.14.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:20:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     sumit.garg@linaro.org, akashast@codeaurora.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kgdb: Don't call the deinit under spinlock
Date:   Tue, 26 May 2020 14:20:06 -0700
Message-Id: <20200526142001.1.I523dc33f96589cb9956f5679976d402c8cda36fa@changeid>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I combined kgdboc_earlycon with an inflight patch titled ("soc:
qcom-geni-se: Add interconnect support to fix earlycon crash") [1]
things went boom.  Specifically I got a crash during the transition
between kgdboc_earlycon and the main kgdboc that looked like this:

Call trace:
 __schedule_bug+0x68/0x6c
 __schedule+0x75c/0x924
 schedule+0x8c/0xbc
 schedule_timeout+0x9c/0xfc
 do_wait_for_common+0xd0/0x160
 wait_for_completion_timeout+0x54/0x74
 rpmh_write_batch+0x1fc/0x23c
 qcom_icc_bcm_voter_commit+0x1b4/0x388
 qcom_icc_set+0x2c/0x3c
 apply_constraints+0x5c/0x98
 icc_set_bw+0x204/0x3bc
 icc_put+0x30/0xf8
 geni_remove_earlycon_icc_vote+0x6c/0x9c
 qcom_geni_serial_earlycon_exit+0x10/0x1c
 kgdboc_earlycon_deinit+0x38/0x58
 kgdb_register_io_module+0x11c/0x194
 configure_kgdboc+0x108/0x174
 kgdboc_probe+0x38/0x60
 platform_drv_probe+0x90/0xb0
 really_probe+0x130/0x2fc
 ...

The problem was that we were holding the "kgdb_registration_lock"
while calling into code that didn't expect to be called in spinlock
context.

Let's slightly defer when we call the deinit code so that it's not
done under spinlock.

NOTE: this does mean that the "deinit" call of the old kgdb IO module
is now made _after_ the init of the new IO module, but presumably
that's OK.

[1] https://lkml.kernel.org/r/1588919619-21355-3-git-send-email-akashast@codeaurora.org

Fixes: 220995622da5 ("kgdboc: Add kgdboc_earlycon to support early kgdb using boot consoles")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/debug_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 4d59aa907fdc..ef94e906f05a 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1089,7 +1089,6 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
 		}
 		pr_info("Replacing I/O driver %s with %s\n",
 			old_dbg_io_ops->name, new_dbg_io_ops->name);
-		old_dbg_io_ops->deinit();
 	}
 
 	if (new_dbg_io_ops->init) {
@@ -1104,8 +1103,10 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
 
 	spin_unlock(&kgdb_registration_lock);
 
-	if (old_dbg_io_ops)
+	if (old_dbg_io_ops) {
+		old_dbg_io_ops->deinit();
 		return 0;
+	}
 
 	pr_info("Registered I/O driver %s\n", new_dbg_io_ops->name);
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

