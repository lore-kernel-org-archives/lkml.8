Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD8BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFCA221E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599773259;
	bh=wDBghXZe8kluN8YfN5whMmcG1buegyspf54V0ZHlhMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QZqfpZ1zobUJ5KeQRrXODDeraq3B0lHPVlCOVdBFOLTjc41N7/yk3wd4xKHWRVDR2
	 Hz4D0Cex9xoCZ0Rok5lMjoOxqm/elCTb0WD9+5yQd0vleIW8AepgMViTZp5V0dvh0y
	 E11xiM43MYd0Bjc5yxqu7WFfm0uxa4Be2JwJlwAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgIJV1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:27:18 -0400
Received: from condef-04.nifty.com ([202.248.20.69]:29600 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731080AbgIJOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:09:49 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-04.nifty.com with ESMTP id 08ADsjMN032624;
        Thu, 10 Sep 2020 22:54:45 +0900
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 08ADpSIx001308;
        Thu, 10 Sep 2020 22:51:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 08ADpSIx001308
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599745892;
        bh=GfWXsevD+/JY+AqdR3iC3oPYU2Z7Pjb6F8wdpSkfPC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwK2cMh39J9rOU6iXiFeF+EX6KMfOKNDrFuPTU9GwJWA4caRNJr9dSGq/Ruh2vaLy
         Khd3KqlsFN0VJm26UgMrOrZvhmsLUey9YdRp2tI7/ZafSb3+Bw0CgFNhiB10ErJePx
         hoRpqJ8vM29aGVyIB9p68vzSk1WdVT1zxdYoOt51bw/cSa2Yd/Ube9u3Cig8SQDoVI
         t4EnwukTTHdxQko1FX1FhGJnK12xwC6Unpb0CHllIXHw7uUuIILPDXqBJlQpsvXHT1
         wM8a+Om0gB0CVPljU8Z4UIntzifK8gaKCeIoNHtAEp8/Fv9bYjDZIV7JHsFuIKQ+dN
         N8Ptvnr02at/A==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kbuild: remove cc-option test of -fno-stack-check
Date:   Thu, 10 Sep 2020 22:51:19 +0900
Message-Id: <20200910135120.3527468-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910135120.3527468-1-masahiroy@kernel.org>
References: <20200910135120.3527468-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimal compiler versions, GCC 4.9 and Clang 10 support this flag.

Here is the godbolt:
https://godbolt.org/z/59cK6o

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1b6abecc5cab..5102c89d3167 100644
--- a/Makefile
+++ b/Makefile
@@ -934,7 +934,7 @@ KBUILD_CFLAGS	+= -fno-merge-all-constants
 KBUILD_CFLAGS	+= $(call cc-option,-fmerge-constants)
 
 # Make sure -fstack-check isn't enabled (like gentoo apparently did)
-KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
+KBUILD_CFLAGS  += -fno-stack-check
 
 # conserve stack if available
 KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
-- 
2.25.1

