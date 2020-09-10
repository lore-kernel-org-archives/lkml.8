Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B94C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20862221E5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599772821;
	bh=Ze7vXi1wbkU0MsV4ETWUDVXtSmlXna+i8eZq+cvFNxM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nayKCMRR2595Eubb4OZimDgXCt+StsqdALeQzUHzbEBVTtbYHx15CF3ZSVZK3FTm7
	 FhqAJjFARdI3gqT/2W5F3U9jrAYi8xuYYbvrupywMHTJxTcKckPZenZ96dUvk/x3Vd
	 w5kr5aB6mEpzLgJViRqQ0Joi5i0jRg8ZCmDnaueY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgIJVUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:20:19 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:42807 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbgIJO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:26:13 -0400
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-05.nifty.com with ESMTP id 08ADllED030900;
        Thu, 10 Sep 2020 22:47:48 +0900
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 08ADiY4U001894;
        Thu, 10 Sep 2020 22:44:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 08ADiY4U001894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599745475;
        bh=WL98q/7s+UmiqnVaDR4JUCigpcZ/zOKRJsU9m2uipak=;
        h=From:To:Cc:Subject:Date:From;
        b=uMHg8B9hXQAKipMm67kWTGQPCaRSrrFL5TEi64sGGq0dDnT2S79HsPKf9LczpVOKC
         cmixqMGo40sBqVF1Eag9hqFIJZ2EtwXi2ZtNuUTT+cgeqdkPZzeH1EYaXGFkOB1cC6
         twd9D/964iMd/sUoFHr+qF9uqwaMpEiw+hQK3LDrl4rwxjNk34vWi2bjt4SJ0hHNe9
         44qVFnaomtwi1C9JtKZs3b/l+5E5D+xWN8RAqzCHGEx5osmh7EOpqhHGQg6YJat/Zs
         ZEfhk5b/uUkrH9m7dJ2L/qhVdfN/LHLehchIlUDlmoLxdy5a23fSL9fO4GeuspcgSr
         O0SjVT0MmZIiw==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: remove redundant CONFIG_KASAN check from scripts/Makefile.kasan
Date:   Thu, 10 Sep 2020 22:44:28 +0900
Message-Id: <20200910134429.3525408-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e0fe0bbe57b8 ("kbuild: include scripts/Makefile.* only
when relevant CONFIG is enabled"), this file is included only when
CONFIG_KASAN=y.

This ifdef is redundant.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.kasan | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index f4beee1b0013..1532f1a41a8f 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_KASAN
 CFLAGS_KASAN_NOSANITIZE := -fno-builtin
 KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
-endif
 
 ifdef CONFIG_KASAN_GENERIC
 
-- 
2.25.1

