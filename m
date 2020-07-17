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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01CEC43460
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9762074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Toe6w4uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgGQS5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgGQS5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:51 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4CC0619D2;
        Fri, 17 Jul 2020 11:57:51 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w27so8414747qtb.7;
        Fri, 17 Jul 2020 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CShXBcl2gG+ttHq1iUUeEfAUxSCh08DcwdO7I0alno=;
        b=Toe6w4uz4ARrU+woO+botwrhI2Qi/z7MzUDD9RFLaUJVOWmsSrApLtiR2z7FYgv5Mh
         7ykVF5eriUJAuU2ADIH/PZ37Lv9PzFHOQ8ByAaQj0SJ3ByGDH4uJsezkkZuiIXGO8NOx
         GjGjFhxA07I4+Uk8akbnwT6zWFSAKGD1WdlXCi77V66gJHjMP0NNjE0MSXb3T5/Y44Hm
         KnrTJ1zOsE3Hbe73rE8fuP2hszbffeN0KGBuueCMEAJpFfbvOo+dkhHogPTPp6Spairk
         LPVmj7ChhQVrOtLL2jCzx25ppeHX+TLwldAPqMDPNoaYYDpdfZL32lHcInmHfcOIrXpQ
         kYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CShXBcl2gG+ttHq1iUUeEfAUxSCh08DcwdO7I0alno=;
        b=pPG47KC+kFLMLq/ZIzF7t3J/u7NeYwGwUL03pXv8joWUavS7UklDRspwKNI02weNKH
         mCZxT6XLYtTAFAwcStLg1qjIpyswKb4QIx/mtsFQ7QYs6ONGIR9GG7lg4kA0TbCUhP2Q
         g4MUmPSS6fDzat/CjypMKz5MGV0n9whZogtgcqFuTeR0pcCoCX6WzOgEU6gTfIzZ+K2t
         0g4AHKK3FkQOklWJbHQmUQWTujYIDi1erran/pLaayzR24LxQtP4Qf20rXQnxmdAZclL
         2KNtbMiih5bpr10U76+PiIRBoy/3JQR38R8GHgJJjSrifQHK5CvEIvIdpyby8e4QTCVj
         YLWQ==
X-Gm-Message-State: AOAM532f//m9dQLZgXg9+G8CDyrxE0Qemb+OcwA5kJXjaW6O9niqJWOe
        5oWb9vFvfcqAAhKL/JAjaSI=
X-Google-Smtp-Source: ABdhPJxt8S3qRXxoYaiRbF1g+z6osbck+sZf5lNKUFZDNJRYUMseeW4oAuVJHmU9iwu7Nc0F60k/Tg==
X-Received: by 2002:ac8:4e4a:: with SMTP id e10mr7814523qtw.368.1595012270943;
        Fri, 17 Jul 2020 11:57:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:50 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/25] Documentation/bpf/bpf_devel_QA.rst: fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:16 -0300
Message-Id: <20200717185624.2009393-17-dwlsalmeida@gmail.com>
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

Fix the following sphinx warning:

bpf_devel_QA.rst:444: WARNING: Unknown target name:
"documentation/bpf/btf.rst"

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/bpf/bpf_devel_QA.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 0b3db91dc1002..a26aa1b9b2595 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -643,5 +643,6 @@ when:
 .. _selftests: ../../tools/testing/selftests/bpf/
 .. _Documentation/dev-tools/kselftest.rst:
    https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
+.. _Documentation/bpf/btf.rst: btf.rst
 
 Happy BPF hacking!
-- 
2.27.0

