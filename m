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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CC5C4345E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57C8208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udQB1X7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGQS5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgGQS5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:48 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BCFC0619D2;
        Fri, 17 Jul 2020 11:57:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c139so9684183qkg.12;
        Fri, 17 Jul 2020 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZpiBcjGlIPxF0KYd7Qc+BnCOu25vSDqixulLrFvuOY=;
        b=udQB1X7Om0JJKCtkDF+i4wDpOjQQUvPYkGHL7BaYyW5sBK96EfJnW04juDmu3CMuRG
         AI2Je8tLMY//PT3Tduq7EPF6xKcV/1Reggd4DCMfPeFkOd/GvfpG/s+zNqhkVCLtOUSI
         MXXPmW1A2eeIiUXB+ee6eQM61cvDLRajVZ1ardx8Mjs6sGr87IsfatgoqreJgJjEOTt3
         DdUwKjfBp/Wud04Q1709+ojlIph43SEJKtm2fA2ES2GA3eOMETiFJ9rogFBoHLIFBLzj
         6tPEiIm8QqySrgBInDheQ9N7h32JiQmiwSmafc2edIfDduRY8dR2+0MHLRgg+tzs6lws
         KFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZpiBcjGlIPxF0KYd7Qc+BnCOu25vSDqixulLrFvuOY=;
        b=ae5lSKF61oGU/5gYyS2CZsC5vXZkdc2gTLXaeFD48ZWoiNf+fxzMigSkRX62TjGE7W
         8UcOwfxSTNCQUIiO8XWa8nMtKipdkglSEO1YPDhSBhR4ZAs5mm7IOoNfiCNOR46Mf1h8
         QK9obagwxx9K1X/hehydvbzFED1FWKUfDmegXZq3oQleDWASsoDZQTdfQc29Q/bKAn5g
         dWGaVx8RXkvILQCDtZvLzxeFtn1fCSp81XYGN1TT+VfBUooxy7kL9rsf/kJ1g61+d/oU
         fGJb+YhxYZb/1owxgX+6HRdUV9+gWHJ12nTZYjJyurZmC6SfDRMiBegzbysf+36CtA+j
         aQxg==
X-Gm-Message-State: AOAM530AY6TgfeCMHfrGFsV/y3zIDhPVMraVlxfOzJd18vaDt8jA0mdq
        5uC5wdYOGgk5JsKTdI7Caeo=
X-Google-Smtp-Source: ABdhPJxskhUb3+0MpFjxcG1s5cEFwat3wq15g1MDMjkt2vkJEWlZeGVjg/3FFj9YfU3Vp7Ss/Rql5g==
X-Received: by 2002:a37:954:: with SMTP id 81mr10093122qkj.336.1595012267562;
        Fri, 17 Jul 2020 11:57:47 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:47 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/25] Documentation/process/index.rst: Fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:15 -0300
Message-Id: <20200717185624.2009393-16-dwlsalmeida@gmail.com>
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
'process/unaligned-memory-access'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/process/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index f07c9250c3acb..dd231ffc8422d 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -32,7 +32,7 @@ Below are the essential guides that every developer should read.
    kernel-enforcement-statement
    kernel-driver-statement
 
-Other guides to the community that are of interest to most developers are: 
+Other guides to the community that are of interest to most developers are:
 
 .. toctree::
    :maxdepth: 1
@@ -61,7 +61,7 @@ lack of a better place.
    botching-up-ioctls
    clang-format
    ../riscv/patch-acceptance
-   unaligned-memory-access
+   ../core-api/unaligned-memory-access
 
 .. only::  subproject and html
 
-- 
2.27.0

