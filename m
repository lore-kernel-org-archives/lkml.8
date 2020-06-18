Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2004C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A547207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEFv3E7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbgFRW0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbgFRW0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:26:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120A4C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:26:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gl26so8079130ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvWfXIMWoA6MVSNkVag1xUER2gYc00hqPnjKfTiOEUs=;
        b=cEFv3E7h+DeOt+sPvYPXJNfnwGAEI4q/BQ2arjcoupkTEPfuV/YcVrAtWqRxoJZEsJ
         vbK8c2BKsZjXfUERfl4UO0tCiyClOgmgDCmnXUm6mTsz5EJMJqjMK8/VY1ipgnwKcNBJ
         Z8DdBhfc9JCnGAvHRNCdx3bEXVUKeTzr8BRz/d4iOoVSrekSaO5xfmlAFC6BJjkbYAie
         SIfrh/JnZYmK2anLSzIPSoW3GpPy/4axBeB6t7uqoPCWXCzfyCvDIfh2IFHxgmEb2rWe
         7PGsdoiXVDZAbl4UxfnPgGReKD3KyG1Y1LNqXJjHRsawyrONDiU/LFqWrWeMGvIAX9HV
         Pq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvWfXIMWoA6MVSNkVag1xUER2gYc00hqPnjKfTiOEUs=;
        b=fLfvugV1tzMVbshuUcnCiuR14TjVZ3bmPV/khh1HEh58qGQWGUs2gwnhflxQO4RIlF
         SHiwji4t9o4aSAc+8SsmEULS/bYZb5Pc80+FvlXzS5SCwWhyVRU+K5PB2WIpjRx2YdXf
         jfqOs2fL/D9f60d6dhf5a0nZTzkrYFsNAdFTPTcH6mzrGDSyuK+zKGPaJJWB+PsajieQ
         MAwPHSnkZSczG2Y6ZYqewNDXtDoEuOTT9pM9I2UhtcI1kN3paEqtCYa60mTMfHup8Ml4
         y+kbscjIkfb2jb5Rrxnx6nVY0ILUufkoPHYncVHKDHO+NX3XXb5fJu8rv9+Zy9vD4KoQ
         PnRQ==
X-Gm-Message-State: AOAM530gAwUZZpBJgedr1jwg0CfFFUbTeKfmB8JyorB4jRz1U+qr7ylp
        FxSCFWOqMSZJZKPJwuiRhco8VsAi
X-Google-Smtp-Source: ABdhPJy8nWz4vsqTJbJfuEoFndOswXJ0Dgs4TBpBUcPHNhOfCp+xuz3zsh8wqEp5U9dQYTvi0fWW9A==
X-Received: by 2002:a17:906:3a0d:: with SMTP id z13mr848475eje.122.1592519189818;
        Thu, 18 Jun 2020 15:26:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:4c3c:7f8a:3583:598e])
        by smtp.gmail.com with ESMTPSA id oq28sm3249766ejb.12.2020.06.18.15.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 15:26:28 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] sparse: use the _Generic() version of __unqual_scalar_typeof()
Date:   Fri, 19 Jun 2020 00:26:20 +0200
Message-Id: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the file is being checked with sparse, use the version of
__unqual_scalar_typeof() using _Generic(), leaving the unoptimized
version only for the oldest versions of GCC.

This reverts commit
  b398ace5d2ea ("compiler_types.h: Use unoptimized __unqual_scalar_typeof for sparse")

Note: a recent version of sparse will be needed (minimum v0.6.2-rc2
       or later than 2020-05-28).

Cc: Marco Elver <elver@google.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Will Deacon <will@kernel.org>
Link: https://marc.info/?l=linux-sparse&m=159233481816454
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/compiler_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e368384445b6..e34a1080f36b 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -254,7 +254,7 @@ struct ftrace_likely_data {
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
  */
-#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900) || defined(__CHECKER__)
+#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900
 /*
  * We build this out of a couple of helper macros in a vain attempt to
  * help you keep your lunch down while reading it.
-- 
2.27.0

