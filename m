Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C9C433ED
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DE62073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taLp8dAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgGRQwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGRQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:52:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2DFC0619D2;
        Sat, 18 Jul 2020 09:52:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so11582773qkg.5;
        Sat, 18 Jul 2020 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9h6K45vkpXDeowF/Ktfihv6pK2OwZVMzS2bGOB7FuYg=;
        b=taLp8dApvZABtj4fuMZayWYO/pecoysRuG6QzfFz+B69i/M07CBU3sn+A3CX2MwSeN
         LCfFMSqjB+iTm3ncb4tKq/FqYrZ3Qg6Ax68bppxvsonPovsRgQlXJX87V123SxqimUwr
         +73k4UnPTCdz1L2QDtnRojaYjZUAnZR9sfiiZEQy/2po+Rh0Ou8EttXFMhI6i+rBaeSn
         m9/SpZSCnH2sGVrNNDLlKSGWEWXzlJQD6suKnwWtxq100msd/d3lNJjq6FySkYFC3j9W
         ZBiQDvDvL+HTU/S70uXofuudmoMO5Y2lPl38hNrjZULFrt1ggWDMiPsiCNVNHtr8rS4w
         FFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9h6K45vkpXDeowF/Ktfihv6pK2OwZVMzS2bGOB7FuYg=;
        b=hh8wrAhMQetH7mvI8iujRnkgT/D61bvEebylKa1/cclHR/OGh14ho69vKh4ZC3etQv
         IOX+imU9Mi8pXeU/+wbnu9ZNdc0bvfP1aDNnZjSHtlEt1dGorKT27x0NXWSK8ebQNjtX
         l81kRdcUY6F5lJVK9qbyd1o798H0hZ5pIzNeM3GH8Z87Vd/HdF+vWWxiva9IfYIipFsb
         PQ2uZs68xO2xY45KQvlFvsDinovmVrjD/I6o5XSV/b1y84IZ8o2teuBc3VHeZNNDI+52
         s6X8w+tOMF62+Z1PDC/h+JsQVFLrxHcWx+cfgsgsJxpe3m8b3MdQMgjrV7Oj8uNrSGsW
         Drdg==
X-Gm-Message-State: AOAM5301Y+H+SM1VEqGGi51oge3xZ4WDVrYkMu9qB9CwIgrzf40CIzuu
        HLXhmAAXm/sZaoItKjZY0P8=
X-Google-Smtp-Source: ABdhPJw31yI2A2zxbk2J5sAQRp9sjKM/HZ3aH8iCOERJ6gqSBh87EiG/Num0cJhMMrCzNJnHMSqxtQ==
X-Received: by 2002:a05:620a:2eb:: with SMTP id a11mr13407474qko.383.1595091134082;
        Sat, 18 Jul 2020 09:52:14 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:602d:16d:d038:1a92:190d:65d2])
        by smtp.gmail.com with ESMTPSA id q5sm15361801qtf.12.2020.07.18.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 09:52:13 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: firmware-guide/acpi/index.rst: Add intel-pmc-mux.rst
Date:   Sat, 18 Jul 2020 13:51:05 -0300
Message-Id: <20200718165107.625847-11-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718165107.625847-1-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
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

By adding 'intel-pmc-mux.rst' to the index.

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

