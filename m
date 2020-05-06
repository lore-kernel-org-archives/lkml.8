Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEDFC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA3420836
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U9O3LFB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgEFPVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbgEFPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6D1C061A41
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so1242662pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=abGIv/DdrNJt2Rz7dowQp90zZu4jBR2B6nuWuRnKkME=;
        b=U9O3LFB1qlKclxe075qGu5xo3xrMDDz7IOdPPcNMZfhaK6oU8/KaCqfVrFbBojb+kF
         RlstceOC3w4CsecV9rpMFOOR6f6gbx/qyvrTcLsqwy08jxuVW5VfpTDh4ZGVdF70hRDK
         zrri0EQ9i7U7MezqI+VW/QkhRMsJTYHgj0wIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=abGIv/DdrNJt2Rz7dowQp90zZu4jBR2B6nuWuRnKkME=;
        b=SX27mw8oE9NhFm0dtk7PHHBXRSnA8QlKDGtcLu2ftCHvPC7zV+qO+BAeWIHw9+bz/I
         fr/RVKIfnoOHmqxXANK1D3zNsbLpW+Q94XjvE66Wx6STMi1BK96X5sr5qVtojCb9fAAP
         F33dNGdicAGwWLruDJM6zdlM6Xfnim4WRWGXnFX6mSEc8hBtCU7Vv/IePaF3GYWADBoT
         oLb/U2Oq9j0aLQGyYDPOxJYTICZ7hez13uCO1PC0NGiDip3qPbQqElBlrrOk57Gkb88a
         dEl1ixhSonjrb2+ZL/ydWdnjGdGSZrz+4rTjw+OKi++0etDywKodxQijeFbpbwlgtUc7
         cw2A==
X-Gm-Message-State: AGi0PuZ3Sf2pSIbDEwxkaoOSEn3TlcGPeMpU42J+kI/pJKCXxF0Z+qwX
        CUzFi3YSx8cTGtPeybAkLmfSqA==
X-Google-Smtp-Source: APiQypKRaz6yrGzT3/NYxjULwoEsys/LiTxAitWFf6a1UZRTEc+kLFR9zz4OeLSceQZ40Pvg5yMccg==
X-Received: by 2002:aa7:808e:: with SMTP id v14mr8922680pff.168.1588778505369;
        Wed, 06 May 2020 08:21:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i72sm2287178pfe.104.2020.05.06.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 02/10] pstore: Rename "pstore_lock" to "psinfo_lock"
Date:   Wed,  6 May 2020 08:21:06 -0700
Message-Id: <20200506152114.50375-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name "pstore_lock" sounds very global, but it is only supposed to be
used for managing changes to "psinfo", so rename it accordingly.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 44f8b9742263..347b6c07f4cf 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -69,10 +69,10 @@ static void pstore_dowork(struct work_struct *);
 static DECLARE_WORK(pstore_work, pstore_dowork);
 
 /*
- * pstore_lock just protects "psinfo" during
+ * psinfo_lock just protects "psinfo" during
  * calls to pstore_register()
  */
-static DEFINE_SPINLOCK(pstore_lock);
+static DEFINE_SPINLOCK(psinfo_lock);
 struct pstore_info *psinfo;
 
 static char *backend;
@@ -574,11 +574,11 @@ int pstore_register(struct pstore_info *psi)
 		return -EINVAL;
 	}
 
-	spin_lock(&pstore_lock);
+	spin_lock(&psinfo_lock);
 	if (psinfo) {
 		pr_warn("backend '%s' already loaded: ignoring '%s'\n",
 			psinfo->name, psi->name);
-		spin_unlock(&pstore_lock);
+		spin_unlock(&psinfo_lock);
 		return -EBUSY;
 	}
 
@@ -587,7 +587,7 @@ int pstore_register(struct pstore_info *psi)
 	psinfo = psi;
 	mutex_init(&psinfo->read_mutex);
 	sema_init(&psinfo->buf_lock, 1);
-	spin_unlock(&pstore_lock);
+	spin_unlock(&psinfo_lock);
 
 
 	if (psi->flags & PSTORE_FLAGS_DMESG)
-- 
2.20.1

