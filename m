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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B32C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468AC207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0j9R+8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgGQS6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgGQS6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:58:32 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E2EC0619D2;
        Fri, 17 Jul 2020 11:58:32 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w34so8452921qte.1;
        Fri, 17 Jul 2020 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWryTU/P+/m/0oaOtnG0FgkqcG7rUoxiTpusYauQ+wA=;
        b=R0j9R+8Fs0M99wtEXk0ZlDvAuj67eFbJcuq8CdHEjJBXCqsb5qUlZagNkr1iSS8a7n
         8fgqrYwV19mP0L8KBYdM4nJmry4+u7zZ4MjTdlpAuYkMgbV59PW1/kvPpUIE5JL6IMNH
         pRWDjOU/MTtjhcGnQn6xNMr7CD1yGRaVBxNFboOArpcSflA0ZV8oRO4RafzdI0h0ssqr
         0uxtWETBNJboO8BqSsKzrfYfqCaLogiaY5CSEVd/6HdRjxnD1xqhuC4471pdoC9GX0NN
         nGmRBQPC0Gi5eamKtUJGSbyMqAV77ixrEN10NE08OyWeh6rBfOvZcsT9EDatZGH5JlNm
         Cv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWryTU/P+/m/0oaOtnG0FgkqcG7rUoxiTpusYauQ+wA=;
        b=J3MePXeDZU/W8btvRLNahUepYWAcYM3RED2mvDuir8DWPHQreQs8QfbQ1P3hb+Gr4D
         2nbT9LJV8AT5kKpVgffw7zaWWYBOG0NzRXdDI6zUv+svL1zQt7kbJue97FMgPFwIsHap
         F1fPJK1NkA3gplBzwmvE58HUnrXGWKN03osVI83vdE7Nk2zFg2GWJB4iaRGQD5Z6lICG
         fEL/JzHJWmww+JRLJVZjos+0kIY3Lfw2tgS6Ejl+Jr6nVgotb6W0yB2x6HxYyTpK6MJ8
         D4zpkIAgZRUQwLXKCGPCtu4GSwOMUB/+b15j3ny9nJvloHBkmQjFtFg4OekmiQJ2AgrM
         dbfA==
X-Gm-Message-State: AOAM5322kCkjdnWbF8wWAelWDDIdJPwqMB8j5YftiBtHrbh/YqZHnF5w
        zd16ZvOiiLfh+roeRIhJyes=
X-Google-Smtp-Source: ABdhPJzHdGQmNDzYs8D4w9VcodsGAEMw2W3aYMqBLe58ETrvC4bQ9k7vIv657uqzKSqls8rblbs7NA==
X-Received: by 2002:ac8:6d33:: with SMTP id r19mr12507736qtu.167.1595012311498;
        Fri, 17 Jul 2020 11:58:31 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:58:30 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/25] Documentation/firmware-guide/acpi/index.rst: fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:22 -0300
Message-Id: <20200717185624.2009393-23-dwlsalmeida@gmail.com>
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

Documentation/firmware-guide/acpi/intel-pmc-mux.rst:
WARNING: document isn't included in any toctree

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/firmware-guide/acpi/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index ad3b5afdae77e..f72b5f1769fb2 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -26,3 +26,4 @@ ACPI Support
    lpit
    video_extension
    extcon-intel-int3496
+   intel-pmc-mux
-- 
2.27.0

