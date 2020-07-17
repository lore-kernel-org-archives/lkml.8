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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F05C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B55D20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTcvrQrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgGQS4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgGQS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:56:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D5CC0619D2;
        Fri, 17 Jul 2020 11:56:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id a32so8414011qtb.5;
        Fri, 17 Jul 2020 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aboPIvFHnKHFaT+cwK3tyyM8mHDmnx6BqWuo9deNHfs=;
        b=oTcvrQrgVe+G6+q5StFLV/d9t+VYhU1kQRcRjbVJRvuS8AVfrPdQ8cgnfz56eK1m1p
         7WrVhQU8rlxS6VjJi5db13hR9089kaGw+8+x7rfdCi/m8mXrISPt3oLswktd+RjPalVb
         05G6ZjI2LuYPvcZCBrB5y9NQ87cvPtpqQ66sGjGaG6GW9V/nvWOG1JkpXQkjP93ux990
         RySQ0fWdcRWSAIk94bZJUM7lP852mh0TYLxgDpF/9AnyXe6goNJBUekPEA+kAK/wYOYM
         BJ57YNHbTmQeRjwKPUf6m5Qqa46jtqZ+SqbHiz+vl40E6Q3K37DD1mWIkO3fjWy8elOb
         pc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aboPIvFHnKHFaT+cwK3tyyM8mHDmnx6BqWuo9deNHfs=;
        b=I96+Bic6p0ZUBfFVR7L9+ilP4vVz++PeWiHcluHWydpF723qgGwyUUHZNH7Nq4h28A
         PYlerF8pKEi19oP7e6WP06rQWLWusEsdiS8yCzkxtlAUbITD4wQGVVCLh6mRyIMsaJjy
         0SkSVdjiKwrQFTi+L8TDPYj0gF38fnm1Y7/8YGay1WvnZ0wpI8LuHk9KFWt/0uNXRZ+t
         wVxftHMJR/A0tU5F0k/IiQfpfuB9bW/smqwQ+W0V6IrUC2VPL0t4jOB6fFtTmYvEJXTg
         aG98RZ9vypuS+dfopbrgc+YuoEul+PBqxFkaPnyFMDV1bFXyC0UzMyTsqte+VHft1GiG
         xC0g==
X-Gm-Message-State: AOAM532c2SQ5XywcyOkXNTIwGHrIhiJ/uFq6Rhk4Gujd3iICBxAabF19
        YcCAoZTKWIOXHnn3oXbtZbU=
X-Google-Smtp-Source: ABdhPJysmMJrbER6h9vEe4WlyRzD4sxN9odhTiLI0RYpCOOAQSekqXH5WeUCEcPjzB0XYtNG2pZuCQ==
X-Received: by 2002:ac8:4e08:: with SMTP id c8mr12044282qtw.299.1595012209862;
        Fri, 17 Jul 2020 11:56:49 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:56:49 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] Documentation: amdgpu_device_suspend: Fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:00 -0300
Message-Id: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix this warning:

warning: Excess function parameter 'suspend' description in
'amdgpu_device_suspend'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a027a8f7b2819..9e67abe8d0aad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3377,7 +3377,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
  * amdgpu_device_suspend - initiate device suspend
  *
  * @dev: drm dev pointer
- * @suspend: suspend state
  * @fbcon : notify the fbdev of suspend
  *
  * Puts the hw in the suspend state (all asics).
-- 
2.27.0

