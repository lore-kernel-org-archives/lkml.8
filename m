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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6737C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F3B208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9y+FTw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgGQS6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgGQS6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:58:35 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD2C0619D2;
        Fri, 17 Jul 2020 11:58:35 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so4675990qvb.13;
        Fri, 17 Jul 2020 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imbw+CP+ghTt2Y/z3YbaGFva39qKK/n06zESZnwqzsI=;
        b=B9y+FTw0XL1giiGZb3qtvbW54z1UYfzR+GUq73mijAayKULUypHistSTkceq4cDjgk
         oy6XUyk+yzTGAMc2Rs7BVppR5V9dtPhIVETbjWBP01toMfjK2mD6Tnfo9l+iAxOPhyLA
         8SDGGhfFz+k7iYKlSueBcLnMo0dcmDrsSB95uV/Vb2Jr6b1QDYPqSh0pQn5OnCUFDXKU
         d3ddhNn7GG63IUawbVuHCa4ZTNa1ZPGSbP+2tjXUOtgQlqx6HMwpsBhwmREEsL67VxYS
         TkKwPOz6SOoR7u+/X/YNQrVOO2zBC9BOCVhJwp+PBzuh4eOyifMKOKtr9nCkXJMr2nCk
         ZN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imbw+CP+ghTt2Y/z3YbaGFva39qKK/n06zESZnwqzsI=;
        b=MDfTk0gYfUJDOpQS8dPv7GeYhQd777g/TE3WH31fssHAEiGO/iBeMYicDCIYq300kM
         Dhe7pf7mboesClR+fo0g8+xBDJoy5Wg0VgIR+qaAarMoNwopWTVbpMeFPx8T2lCkQGf2
         o2rh+1IxB6yDDnh6NILr+5YFrJ5q/YmpOC7ZnWC1ooVWHGX44HnDiZRU1iM9YcpNVefP
         AqGhS4UqEt19YXhVgZEmUDSS3Iq7oPQKRdZd/hZZYuxY5WxMuzex5EvOsFhLnq/QGzKu
         uPZw0M7XxxyZfKVlh9kE1S08w/hq7r1obxZTGcG1eDasNbCwS0GGpwSTGIKHs7Qbv51O
         RItA==
X-Gm-Message-State: AOAM532Vj5pnkl+VOflrRU6swWD+dUk3z14TE5WcGtcOdoMfvx37crHk
        2+g9/M53Lzeb7/SJDc65C34=
X-Google-Smtp-Source: ABdhPJwYLsmujoxjuwaEx2ELPR4GbqMwfGLbozh5MOHu6lmgJWFVQaZqnMz6Q3+N52itguZli6SoEA==
X-Received: by 2002:a0c:a221:: with SMTP id f30mr10192082qva.115.1595012315084;
        Fri, 17 Jul 2020 11:58:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:58:34 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] Documentation/trace/index.rst: fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:23 -0300
Message-Id: <20200717185624.2009393-24-dwlsalmeida@gmail.com>
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

Documentation/trace/histogram-design.rst:
WARNING: document isn't included in any toctree

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/trace/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 7d83156c9ac1f..f44794c8fd840 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -19,6 +19,7 @@ Linux Tracing Technologies
    events-msr
    mmiotrace
    histogram
+   histogram-design
    boottime-trace
    hwlat_detector
    intel_th
-- 
2.27.0

