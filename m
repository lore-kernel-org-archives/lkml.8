Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0948DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB65A2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jp0ZPR0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHTWKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:10:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76DBC061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:10:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a75so24798ybg.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=yJwAau26hmxXDK7LYJ3raaNV0n3CHaFw9SQbcJH8sEA=;
        b=jp0ZPR0FxAheFL9TaDHJpLBdkF8RMdsuqogh+TQsc9O5logL4ZbPUmQXt4iFAVsdPt
         t0UFCsaxtebtbQEIpwLN2OHQ5vGZsaiZEaq2rdf8iL05k1zGifwMycxpvfUA4aZSNLn9
         InR5iNt0Gz7hK9ENo46ajMKo+wMsmjep/Mhb6o1rpxtHftfrEcU2ZhPiki61DOBVgbLq
         NbGrKmZT/TrgsZqgo+lGWiy/85ElcfQYu9/O/UALRL7Cgo2b1thGr9vBRbMPBGFbHr/X
         hPUtkCfENG9wxazhmpR0QLpIzsWGzMUxm+uvG/QcI97aHX8Jpv+6S5K6dLDCfAyilJON
         4Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=yJwAau26hmxXDK7LYJ3raaNV0n3CHaFw9SQbcJH8sEA=;
        b=T3wWY3FdIWrA3TjZB2IxFzPK8jg60CNZARypAcN6RXt8VtncWrcpsquaXKUzh5L8Hs
         Y7hNogImyubCQG38mk8jwMH18aBNWEXyjS7gDT1rDvnnceROLIhygyJ9+6oj996kZvTH
         lUeooume84d9N5SVmY0iJJq+5vyFqFiEHj/20XBT0GuO55OXULAFSfNtbxojXjilB0UM
         V4YkGfP+TQmSlWHselB5IjTJDX8tTb2OSeuGmYOo3RTIeXbVoi1SbVUPERGO6uEmPPou
         FZTFfEv5pRH7aCLuKYbWNr/m9t3v7MYOKvTxVtu5DAJIsvvMPtlCT+eV+qzPRAT9W0He
         UNPg==
X-Gm-Message-State: AOAM530izFTnrc8eX3Mhe6pjvnLBmkS5nRlv0DkFrDH9fcvGWy2kC9zH
        OWkcun4H5jok/NRRPo/DqlmCSwgFlzGbgieOoGs=
X-Google-Smtp-Source: ABdhPJx30GNZ3GSuvsFhK/9SM8q9Vjp2kLIGiXlPALUfITy+qGebu7li50lrnbr4PyABra6n07ZFPtW+mf+/2rTZOzo=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d812:: with SMTP id
 p18mr462820ybg.460.1597961401739; Thu, 20 Aug 2020 15:10:01 -0700 (PDT)
Date:   Thu, 20 Aug 2020 15:09:55 -0700
Message-Id: <20200820220955.3325555-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] Makefile: add -fuse-ld=lld to KBUILD_HOSTLDFLAGS when LLVM=1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While moving Android kernels over to use LLVM=1, we observe the failure
when building in a hermetic docker image:
  HOSTCC  scripts/basic/fixdep
clang: error: unable to execute command: Executable "ld" doesn't exist!

The is because the build of the host utility fixdep builds the fixdep
executable in one step by invoking the compiler as the driver, rather
than individual compile then link steps.

Clang when configured from source defaults to use the system's linker,
and not LLVM's own LLD, unless the CMake config
-DCLANG_DEFAULT_LINKER='lld' is set when configuring a build of clang
itself.

Don't rely on the compiler's implicit default linker; be explicit.

Cc: stable@vger.kernel.org
Fixes: commit a0d1c951ef08 ("kbuild: support LLVM=1 to switch the default tools to Clang/LLVM")
Reported-by: Matthias Maennich <maennich@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index def590b743a9..b4e93b228a26 100644
--- a/Makefile
+++ b/Makefile
@@ -436,6 +436,7 @@ OBJDUMP		= llvm-objdump
 READELF		= llvm-readelf
 OBJSIZE		= llvm-size
 STRIP		= llvm-strip
+KBUILD_HOSTLDFLAGS	+= -fuse-ld=lld
 else
 CC		= $(CROSS_COMPILE)gcc
 LD		= $(CROSS_COMPILE)ld
-- 
2.28.0.297.g1956fa8f8d-goog

