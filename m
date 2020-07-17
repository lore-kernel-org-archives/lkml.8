Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2DAC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3111B2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sf2i38fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgGQS50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgGQS5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F7CC0619D2;
        Fri, 17 Jul 2020 11:57:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l23so1889123qkk.0;
        Fri, 17 Jul 2020 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKo0ARnrr68jQrTW3aA7ana7z8LF5eDUItXW2815wwE=;
        b=sf2i38fIXhE1PaAkMfwqJYz4AsrY3ATtn1C/g23i15ONZNKYtQ8oDVvEiId3ocVyPE
         74/yoO4H3U21NU/oLjA7VeHjHWvIs2PDxuvyKsno7olYJpM9srXrDxKZdy9FlLR80OLM
         XqE9w3YldQVnZnCI6lt51oGoekQZZNKeqo+aDX4SYmz0zsesLzcmP0odb9qGjJJRmgXx
         GMrwEp68Kr4OUm7Z94idnYVnZis5Ua9UAR+pWg35THwnKOe79rlFPkDCdUQiRcSouGjw
         WSuq4bnLBILs3gPP66p6WVKRIe+15fo7zrIg+s/3m7CPVdxW/B6/cJ6ei4A20PDF9bCs
         QzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKo0ARnrr68jQrTW3aA7ana7z8LF5eDUItXW2815wwE=;
        b=OoZIfJF8FKb/3yRSMQTs9z+VzBbQbDIpMGWOs7TgMVWsQVNrhKtiXrS9GqJUfS25IU
         UWazoOxCP/beZvxTgARYL2eQdBMZgss0Wl8r1DelKvJccxNWraXrUu6Avch1UmkwP1mG
         QANSaGLV1rEndsOy7R7vnnsOqG7E4ubn6148D19iAaVygEkIZAUlXMOhGMpzbi57ggNi
         jublukXVYK299FN/kTB2fplsZfRWbB/mnA06rq3uVeXnVDS/5gGjwP1eKesElSu8e+qq
         +2/ThQlhIOHFWz3mb0zqQ4U4pFylQEfb/ntBQwmUFp6zz84frYQbjEhYudgGneBAmX5I
         1VXg==
X-Gm-Message-State: AOAM5314DgOn3cexuQ3E6vy4l/d8V/zU2TUaXhTbSgZU175WNPvEz5E0
        AeYv9m+DS3TGOwumlsPL3ro=
X-Google-Smtp-Source: ABdhPJwLAuJLfkHiruKbMme4I6Bjt4122l76rQN2BiapgbCwG62/dJQzdpP5s8AhSwZeLyfNkxV60Q==
X-Received: by 2002:a37:4884:: with SMTP id v126mr3181893qka.118.1595012242927;
        Fri, 17 Jul 2020 11:57:22 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:22 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/25] Documentation/admin-guide/mm/index.rst: Fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:11 -0300
Message-Id: <20200717185624.2009393-12-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warning:

WARNING: toctree contains reference to nonexisting document
'admin-guide/mm/nommu-map'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/mm/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 774dad6d3d291..cd727cfc1b040 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -31,7 +31,7 @@ the Linux memory management.
    idle_page_tracking
    ksm
    memory-hotplug
-   nommu-map
+   nommu-mmap
    numa_memory_policy
    numaperf
    pagemap
-- 
2.27.0

