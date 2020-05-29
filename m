Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077C2208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZS30t7zQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgE2Thl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2Thi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:37:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41D2C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:37:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z64so351326pfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=fNXcIddLpH8ebppSuMU7PyvoPN2gD0pHIru8c+y94h4=;
        b=ZS30t7zQelDxYgde+Pm23ZECUTBbawnDW7kC0IVILV0ne90m612Nb5l3YsRQE/oHl2
         1vJcSu/x/6MRV1jBng+N0PRhk/5T7jcfqm9ohPaSS2K/eybU1guf0QAuMkinuhwjvt0i
         TF2tuAI2alWe1Wrb1/G1ovrHuKai8rFuCwtwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fNXcIddLpH8ebppSuMU7PyvoPN2gD0pHIru8c+y94h4=;
        b=hrBYuFZpbltLEZ9+7Ckpas4+972dsjZbnWLo4C2ZQAMBvSrcT28IFTiXExuxpk6zNO
         21KulvM4v3hUn/W4qnqzQ3AdjcyCSxs1trEeDK2Knpi8kV5URxYHyBGa1UpjQ/VZeCnB
         6VhD3w2+tSUVuXybcSAi6EO0AIMMTK5Cz3/bw5yhOfro7udWSsk72oLj+2BGjTcAIxPT
         afDaqXZsP8ebIM7I/w/R5wB4Bf73ZHa2cLVvApTenvXrwd1b+oFMz19qIQm20lB5GO8w
         lwARilRpp9TnuKskyKWguFxl4Yv8y/mAbzqueOsFHsq6rY28+0ZZLDLAZEOIYmPqOxlq
         XhGA==
X-Gm-Message-State: AOAM530uSMSrvLeGqr4gnw6xCw2Qwgt8gkpUPPyZhAaDJjepXXYj9WNJ
        YX+tL35hmwV4dX8MDe73miq+sA==
X-Google-Smtp-Source: ABdhPJya1s3vNg0rE6Fc75stD21lk3k+Kj0U12nwo3z5KVQaqPWvt9Xf14iZY0IqMpxDJMM/eRbs0w==
X-Received: by 2002:a62:5ac1:: with SMTP id o184mr9922534pfb.97.1590781057299;
        Fri, 29 May 2020 12:37:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 70sm7797958pfx.78.2020.05.29.12.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:37:36 -0700 (PDT)
Date:   Fri, 29 May 2020 12:37:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Elena Petrova <lenaptr@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: Entirely disable alignment checks under UBSAN_TRAP
Message-ID: <202005291236.000FCB6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8d58f222e85f ("ubsan: disable UBSAN_ALIGNMENT under
COMPILE_TEST") tried to fix the pathological results of UBSAN_ALIGNMENT
with UBSAN_TRAP (which objtool would rightly scream about), but it made
an assumption about how COMPILE_TEST gets set (it is not set for
randconfig). As a result, we need a bigger hammer here: just don't allow
the alignment checks with the trap mode.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/lkml/742521db-1e8c-0d7a-1ed4-a908894fb497@infradead.org/
Fixes: 8d58f222e85f ("ubsan: disable UBSAN_ALIGNMENT under COMPILE_TEST")
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.ubsan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 929211039bac..27bcc2568c95 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -63,7 +63,7 @@ config UBSAN_SANITIZE_ALL
 config UBSAN_ALIGNMENT
 	bool "Enable checks for pointers alignment"
 	default !HAVE_EFFICIENT_UNALIGNED_ACCESS
-	depends on !X86 || !COMPILE_TEST
+	depends on !UBSAN_TRAP
 	help
 	  This option enables the check of unaligned memory accesses.
 	  Enabling this option on architectures that support unaligned
-- 
2.25.1


-- 
Kees Cook
