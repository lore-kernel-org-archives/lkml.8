Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8D5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F2A2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+4aQEtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgHZQrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHZQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D7BC061796
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so1318502pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tv4kkgaRKTSg5mtSljLIfWbV/kKMUzinzR1WF6eOzEg=;
        b=J+4aQEtMWRdEKu9phF530PTZGUl/xpTYrzdCpeHbB+8t4qEY57QZZ57Oy0uPAG7nWx
         4o1yCxg/bHvHeUri+8M0acPYPfr4CtxUJh5903KOR4u2OSWncpgRUzGawcbXVZ+UX3NC
         uyqfGC7n8eDOLw/mt2lHyNZq35ay3Dv7HTxUNXpgAa+7aVb9IAQgHUOPWw9J3RZi0my2
         9Ghv7Soy2weYsjF3W4KQ+m/rX+jwIpGLFwkr1JjOH2R8eENS0dYzpmE4chQDSw6TlNn7
         2wVCYXB6Jo/RUhdA8a9m7+P3piMKVs3mHmP54Vi8b92dfQv7zzr57oeQuGFoZOaYcJ3T
         6tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tv4kkgaRKTSg5mtSljLIfWbV/kKMUzinzR1WF6eOzEg=;
        b=XwMrBKbWXIDYEmW4dPn0hVU4OCtuUkUkSKB9edR9b43IXLX+m7ik+7ZeStwQD2tBT8
         Kvz0e3zs6+uW1Wv5JuhTsxDfDn/Xy5bPuYtVxUObHN9ZHPJwYhPckkacC1q5DfWjwQ/U
         2Vfw2CihxLxFtnbCmf7pjLdu+gIaP1Gtkd/h7xjJRSKOWF+DrK+YDIZIM6t4bKxt5c3o
         YGwLmtTm6VBLuUzKUvhsYUBAXDDIOS2noNlorN3ifYUIqjBjgtulESHURqA0d/mjOjXs
         Kio01/MyUD4u/NAg1h0zb/aiaE3ElbICyik0igxIUcT8yJ+YQ1u8Wb3zQLRJ3tBls5DN
         NYhw==
X-Gm-Message-State: AOAM532iftHXQrs8qh+IlipXUfaaUme3tzVM6afQVOXWOcvV497M15xT
        FxfMHhAH2ilb+4ncATBfWEweUA==
X-Google-Smtp-Source: ABdhPJxyzlVX/8Rvvcg9V+qehVKYMWuW/NjS+sBb919BgJbJyrH7K1Tk5T+Ui8lWqsfYm9kSDScjwQ==
X-Received: by 2002:a63:1d01:: with SMTP id d1mr6076566pgd.437.1598460344844;
        Wed, 26 Aug 2020 09:45:44 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:44 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] remoteproc: Properly deal with a kernel panic when attached
Date:   Wed, 26 Aug 2020 10:45:29 -0600
Message-Id: <20200826164529.224476-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic handler operation of registered remote processors
should also be called when remote processors have been
attached to.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 5586582f54c5..54b5e3437ab5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2491,7 +2491,11 @@ static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(rproc, &rproc_list, node) {
-		if (!rproc->ops->panic || rproc->state != RPROC_RUNNING)
+		if (!rproc->ops->panic)
+			continue;
+
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			continue;
 
 		d = rproc->ops->panic(rproc);
-- 
2.25.1

