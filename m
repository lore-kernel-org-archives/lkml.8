Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DC6C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219622080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b5RMo4Yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgEFPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgEFPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D5C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so1154238pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5aPKY2j9qr0251TLSYO4+fUSg6ZX/RxgODVRo6vIvv0=;
        b=b5RMo4YvA42TztESKEzSQWr+T9IS3t2tUyslwMCatcIhmfHjeSQLqgglaX2b/JxU+y
         0ASyVmM14mcMQQvGdnu1TtdNq++e0uVj4ZNFRLq7PloqDBTEu6jdvKnJLAJc3+PWXUGj
         O0CHstni5hjbwhMG143Ie23RqLbObXvd+tyts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5aPKY2j9qr0251TLSYO4+fUSg6ZX/RxgODVRo6vIvv0=;
        b=ozJbUN93xyILW6fmvCLrwavF+Zk6KQGOBr8OkkDwPiuZ9mgxEHSl8Ov/GCptQSo91R
         uY/Vp2i0+9RXe60GmjhU66dcjoJRdMCgmU0nyhYxYcAZKU+GSFRxP+wuC2jX4qHUmPSG
         CE4w4siR1BS2ey8mV/clWZpIOaMtIJAe2/l7pqTKP6pfYYXjKiyl+fi7X/llRiOJ72TX
         gP0G4HmvN54pRSr3tAVS7tVIVK0KUkpU7CsXKfk0jYxIQwztS88c9NxDqwnc/DazSJq0
         1JjmHJV86U4I5L3hdbpAhJxkNFQxgaIztqNNTj+a3DXu9zOzlru9dlxM8omcEVmvGyu8
         M/iQ==
X-Gm-Message-State: AGi0PuaKP4SStwXQ4qyd8XHbZoYWU/oQFJunbZnE5WaC42mvFhL3WJjc
        TqHeUzcEveTWwPd+VSyw+I9vGw==
X-Google-Smtp-Source: APiQypJcdjoglFUBiRCCbRmw7a3B+hdMTzdBapv4zL2vAEcPVK7vXfjZkibGoBYBjdxm08KWkg89/Q==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr7683054pgj.348.1588778503907;
        Wed, 06 May 2020 08:21:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1sm2121527pff.180.2020.05.06.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 03/10] pstore: Convert "psinfo" locking to mutex
Date:   Wed,  6 May 2020 08:21:07 -0700
Message-Id: <20200506152114.50375-4-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pstore can only have a single backend attached at a time, and it
tracks the active backend via "psinfo", under a lock. The locking for this
does not need to be a spinlock, and in order to avoid may_sleep() issues
during future changes to pstore_unregister(), switch to a mutex instead.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 347b6c07f4cf..d0ce22237589 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -72,7 +72,7 @@ static DECLARE_WORK(pstore_work, pstore_dowork);
  * psinfo_lock just protects "psinfo" during
  * calls to pstore_register()
  */
-static DEFINE_SPINLOCK(psinfo_lock);
+static DEFINE_MUTEX(psinfo_lock);
 struct pstore_info *psinfo;
 
 static char *backend;
@@ -574,11 +574,11 @@ int pstore_register(struct pstore_info *psi)
 		return -EINVAL;
 	}
 
-	spin_lock(&psinfo_lock);
+	mutex_lock(&psinfo_lock);
 	if (psinfo) {
 		pr_warn("backend '%s' already loaded: ignoring '%s'\n",
 			psinfo->name, psi->name);
-		spin_unlock(&psinfo_lock);
+		mutex_unlock(&psinfo_lock);
 		return -EBUSY;
 	}
 
@@ -587,7 +587,7 @@ int pstore_register(struct pstore_info *psi)
 	psinfo = psi;
 	mutex_init(&psinfo->read_mutex);
 	sema_init(&psinfo->buf_lock, 1);
-	spin_unlock(&psinfo_lock);
+	mutex_unlock(&psinfo_lock);
 
 
 	if (psi->flags & PSTORE_FLAGS_DMESG)
-- 
2.20.1

