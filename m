Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97096C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F11D207F9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE2Pt8S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbgF3Nxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388307AbgF3NvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DA7C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so18190802wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdyAQzGUZDqA1eYmqwW6m9OLrHYQ+P2llVYkgd4FTX8=;
        b=hE2Pt8S5AwVId23lueZ+yGkCmFFu1fwqVco8jIyW78nKWJrFIXetTc/yR8eI75Qaii
         DZpmTa2uqeBD3NInvTdZwjioXVxtLMKc8X4u26l6uSI/75D1uyTpO025wnpR0iaZ2Hi2
         E9c9ug48gYEzm+iqkA5vWqwYR5ysKX3KR0IBKmuPeJuEgCMBT/ohlaEGU7xdSXeLJuRj
         ZiL06zeczxfeLENngMMFJ39X2w9Ana3Fjp96qLbPBaK289XrSa0JuRngxygQielOT8CF
         /n7wqCVtFgLRLEIVy5oF/pNZL9x6K3JMBMI4JN1+z862FsxVi1viaR8mdbr83VZ1HZQf
         K2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdyAQzGUZDqA1eYmqwW6m9OLrHYQ+P2llVYkgd4FTX8=;
        b=lbHw/5G4fvoBOfGar75ELSzwOTrcs67zpUEzsc5JhMZYYqD8wv7iXyGlRRoDcEJ5qd
         oyYIdfzbW8+emfzYBUIsVV4AdBM8SmzP1Q3aOECRcKzXo+b/0utwO8q0SXKuPZqr/LPk
         5aeHKnbJPCdhDWAU2/g6U5X3yXe3qJJ7fToq+V3PTBi42ce2s1P1H0b2kloGtnhmpb9Q
         kVY3CMD4T928IefaP5qK0GVdFWAqZujWn72PYTpsYT93fVRG88qxldHrvmSHAD5A7zKl
         GkIHj8K8hLne22GEs85wmVwejNHvwWLL0VLKALASC7uEBeOqkRGFl7mAFMO605I6TSx7
         pLMQ==
X-Gm-Message-State: AOAM530t+rKiJDTucolGEs7KFVW3TMVVhJhke4rGRLBN/fTlFZgjEzai
        TzRYImUK4SWor7/JTnuwWmP+8Q==
X-Google-Smtp-Source: ABdhPJzZkUhnaiYGoKU11zPHejuow+g7olSZe4Bhiz8EWdA1f4D4IouDADVj35YoDpJMGYofe2mbZw==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr22001147wmg.56.1593525078259;
        Tue, 30 Jun 2020 06:51:18 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Cliff Whickman <cpw@sgi.com>,
        Robin Holt <robinmholt@gmail.com>, Dean Nelson <dcn@sgi.com>
Subject: [PATCH 04/30] misc: sgi-xp: xp_main: Staticify local functions xp_init() and xp_exit()
Date:   Tue, 30 Jun 2020 14:50:44 +0100
Message-Id: <20200630135110.2236389-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not exported and no external prototypes exist

Fixes W=1 kernel build warning(s):

 drivers/misc/sgi-xp/xp_main.c:227:1: warning: no previous prototype for ‘xp_init’ [-Wmissing-prototypes]
 227 | xp_init(void)
 | ^~~~~~~
 drivers/misc/sgi-xp/xp_main.c:250:1: warning: no previous prototype for ‘xp_exit’ [-Wmissing-prototypes]
 250 | xp_exit(void)
 | ^~~~~~~

Cc: Cliff Whickman <cpw@sgi.com>
Cc: Robin Holt <robinmholt@gmail.com>
Cc: Dean Nelson <dcn@sgi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/sgi-xp/xp_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-xp/xp_main.c b/drivers/misc/sgi-xp/xp_main.c
index 5fd94d8360707..61b03fcefb134 100644
--- a/drivers/misc/sgi-xp/xp_main.c
+++ b/drivers/misc/sgi-xp/xp_main.c
@@ -223,7 +223,7 @@ xpc_disconnect(int ch_number)
 }
 EXPORT_SYMBOL_GPL(xpc_disconnect);
 
-int __init
+static int __init
 xp_init(void)
 {
 	enum xp_retval ret;
@@ -246,7 +246,7 @@ xp_init(void)
 
 module_init(xp_init);
 
-void __exit
+static void __exit
 xp_exit(void)
 {
 	if (is_uv())
-- 
2.25.1

