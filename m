Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798E723F58
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyzcSS6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgFTSIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:07 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:36721 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFTSID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:03 -0400
Received: by mail-oo1-f68.google.com with SMTP id z127so90687ooa.3;
        Sat, 20 Jun 2020 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ps1bO1kQHItdDmcSsrlnZa+L4139j2nCHXNY+hwPMZE=;
        b=LyzcSS6Ea/UvBjRHq5RP/ogWCrXYFqQm06XOuHG5v9hWMBs2Zj4J18adXl2YpKpsPO
         OLn+e6r9o2Bh1u3l+6a3fXaQnCNx/h9MLuQ0Kakt9MH8cnt8A8YyVKZZvDuvxtdXK1Y0
         cHFpE/hdS+rqb+iHezdU1YjDtLQRmopZIUAmXjpst1RFSdMabLZGYtMhF4UKi14Jm54R
         ZFNfHi74eKuPIXdvBrWUca+AfTHJyg1dr9mLXgLVfGkz8NIPETHkrjMcixwwMCKpulgL
         hEyEWgDvGAFSEuwuJN9CNknHASiYfWYeXLEMeSjI+JkZHOGdQ+isWfskDEdX+MtGbFKc
         MM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ps1bO1kQHItdDmcSsrlnZa+L4139j2nCHXNY+hwPMZE=;
        b=qaAJ/JjfBfOChjjMh8Igq8xVc7ytnZRCTrQSHIZ00SUCt/nZgyZPLGxR1+paIYnCDH
         pYi44Ev0TpY0cMsiY1i/XV5Gugil+ehjzVCNhFlRHQMdeK5Eg4I4cFg+hemrFlXnzMcR
         lrWJ6icv9OCP0ifnxL4McUZydCUlpS1sUj4+tJxTpwaTPtHdp1eAWgpuNkAm40aFIfDn
         llNEfUieTh7DoDMltKsfTUTJpvrC/72/cxL8gTU3nyY34BlN2HFik5z9yTbBB6pCSDYj
         3aOY++8pkjGPsIUmleX1JHo51tWYa2D8Pnj4ARIjLVA0UAuTHAKT186wXKCcgDGpPnlu
         Mq7Q==
X-Gm-Message-State: AOAM5308ZYACjvlPhg/cvwsl0HEXO9PpWUVJxzbEJfwB+wYYmJRehNZo
        5SXvzmeRF9TPPYTR108njx0=
X-Google-Smtp-Source: ABdhPJw3sZcmRKn5Eau6ytbrCEAWYQwnz6snc7MqqtFKKRZPQ12S51k62JSX2iob3e4MZRGTgM3+Kw==
X-Received: by 2002:a4a:8908:: with SMTP id f8mr8298430ooi.7.1592676422251;
        Sat, 20 Jun 2020 11:07:02 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:01 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Subject: [PATCH v4 02/17] dyndbg-docs: initialization is done early, not arch
Date:   Sat, 20 Jun 2020 12:06:28 -0600
Message-Id: <20200620180643.887546-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since cf964976484 in 2012, initialization is done with early_initcall,
update the Docs, which still say arch_initcall.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 57108f64afc8..1423af580bed 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -250,8 +250,8 @@ the syntax described above, but must not exceed 1023 characters.  Your
 bootloader may impose lower limits.
 
 These ``dyndbg`` params are processed just after the ddebug tables are
-processed, as part of the arch_initcall.  Thus you can enable debug
-messages in all code run after this arch_initcall via this boot
+processed, as part of the early_initcall.  Thus you can enable debug
+messages in all code run after this early_initcall via this boot
 parameter.
 
 On an x86 system for example ACPI enablement is a subsys_initcall and::
-- 
2.26.2

