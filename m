Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694E3C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4281D20719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eupvn9F4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCRRlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:41:39 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54474 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRRli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:41:38 -0400
Received: by mail-pj1-f65.google.com with SMTP id np9so1638734pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+3C2Jxxhr3Fr+QNugMvtsqXWRrlcrZp8cgZVUmeHq6g=;
        b=Eupvn9F4IuV64uIclKoKaUaiZVNZ6h6aMj155vDylT0wMP4LNdSoV6pm3ec7FrTfDB
         sHFZyzYpwYb/k8Xgf2vWBPuktIGlcC6M9vSi6bPruRcKrM+gAJ34wgCG7BRyGAmqXTKe
         aH0tnCzGGeo8GZO0QzmaOPKTq9ERO0gNqzYh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+3C2Jxxhr3Fr+QNugMvtsqXWRrlcrZp8cgZVUmeHq6g=;
        b=RQOdHmkhRLUToZiIghBYaTwP636cSw4SGqDBQcjktPOKJG6OsQ2fPHzlTLr1QdRNHt
         JGP412eXOPEDVT/SY5uGqSPmAkDLP1HS75WuATfecfMpedZmcL1KskTLrOWDq20p0v8F
         +1nbuOqlvaD/SsN4CRyiIpe5g+fpk9GgjvL7NTt1gWwVQJSboniMCwVeu+WjoEX5tS/y
         CwIsdJRjigMJY+tlnOrVUx7uyh0FfDMmG0jp18uX8EX4zy3uE+jLGs7H9oN+GGOkgEhS
         37DkmyYs6BWCdohHTOL8y+r87dDY0jFhD4pmX5El4o48J6Ntt3OjBOE8dM5R8TBudPFY
         6eYQ==
X-Gm-Message-State: ANhLgQ0GttQ8ZHpXDwIYOfEz8DDLoNRZef5d0ptF6UpZyWJCmy5CYez+
        aBt2oxxGrYmSGmJeDKTqsql72w==
X-Google-Smtp-Source: ADFU+vtoC83g4l9CYEO9DuSWjIYqVr4aYu70n80LmX1yY5WMAy84TZuRBaoA24wi9GWWrTMG6Dkqmg==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr5041308plt.27.1584553295464;
        Wed, 18 Mar 2020 10:41:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k5sm2934127pju.29.2020.03.18.10.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:41:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 1/2] docs: locking: Add 'need' to hardirq section
Date:   Wed, 18 Mar 2020 10:41:32 -0700
Message-Id: <20200318174133.160206-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200318174133.160206-1-swboyd@chromium.org>
References: <20200318174133.160206-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing word to make this sentence read properly.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/kernel-hacking/locking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index a8518ac0d31d..9850c1e52607 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -263,7 +263,7 @@ by a hardware interrupt on another CPU. This is where
 interrupts on that cpu, then grab the lock.
 :c:func:`spin_unlock_irq()` does the reverse.
 
-The irq handler does not to use :c:func:`spin_lock_irq()`, because
+The irq handler does not need to use :c:func:`spin_lock_irq()`, because
 the softirq cannot run while the irq handler is running: it can use
 :c:func:`spin_lock()`, which is slightly faster. The only exception
 would be if a different hardware irq handler uses the same lock:
-- 
Sent by a computer, using git, on the internet

