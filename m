Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA72C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6ED02074D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn2BtkYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHGUKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:10:20 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4816EC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:10:20 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 25so3057898oir.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgP7WwDilGEtspTgVkOv5lPLm3Tj4TA+TAE2e5VngkQ=;
        b=Fn2BtkYAUEWONC2B2r5P7++ILH4yha2msE6c7WxSUkQUcmdnlIf9zoUIyC3F8Q23qu
         bOTB7hEalppR1PdOWkzGw2brkvQmCoFkETZ9+6dFTgtUQLgoJSybhPw+Ypi/mLoqA+sy
         DLM5rI6eZ+ECDTIMURT1jNNaANm0FfLbjVSL2zB9SLVcdFkKyZG+czIOElJcQ1tjuxs9
         fHA6uD1pErLXGjTykxcVJjXOdyrd84JVOs1z7uAuZG/zj8PK7vCO3V9z6IwLkrzKKXZu
         XY4ltb6VXgV+tv52rzOxMq4P6DfWb+0DQTvjw9KWHx0KHk2AklVTujkxZ7uNcsSFMKHJ
         3zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgP7WwDilGEtspTgVkOv5lPLm3Tj4TA+TAE2e5VngkQ=;
        b=ca6XJIr5Xs84JPx7gbBHOv1P9yM5o+qgaz8m26avV2VCIVcYq0tFcvGFLRNoBZDiwI
         SwekfQBNTp/gIGAPMKkdryJDVQJcHYUsFAeeFUPflLFIBlQfcoMqQRiNgzcj87gONxnG
         OPbdmZVCohsVp63zCm2MM1Zske1rh26Me7y1hPzWM8r1v7ly9mr335iRq2QfSHLgiAvq
         1zwXaaMzNYg7/8O/alxJOLFQGzYsS1VNxW4orX+DdED5rJRgKTm283KQmzjuifQiR20Y
         6E0kWTVKTzaUNx4uZWFV48lAkLLplme16+/Co8QiLvyVbEanaHSTAZN66zpfR6EOByTM
         Z56w==
X-Gm-Message-State: AOAM533bRN7ctDdqj/7oXXOHWHWsG3mMuRl9lj9iNwrNIok4C5s//NxG
        dZAPVObJQOhx4LKeiAe+owOUIDID2wY=
X-Google-Smtp-Source: ABdhPJwuL05vKPmYk2CPkKFc1IFTD3g22CIx8t/B5hSRAyK900cDTelq6EPMd87/2xNP6PFeP9nOwg==
X-Received: by 2002:aca:c508:: with SMTP id v8mr12408452oif.149.1596831019701;
        Fri, 07 Aug 2020 13:10:19 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::af38])
        by smtp.googlemail.com with ESMTPSA id s6sm1835794otq.75.2020.08.07.13.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:10:19 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/7] dyndbg: select ZPOOL in Kconfig.debug
Date:   Fri,  7 Aug 2020 14:09:50 -0600
Message-Id: <20200807200957.1269454-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807200957.1269454-1-jim.cromie@gmail.com>
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dyndbg will next need zs_malloc and friends, so add config reqs now,
to avoid touching make-deps late in a patch-set.

I used select in order not to hide dyndbg inadvertently.
I want to say recommends, since it could be an optional feature.
Whats the best way ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..a7973063baf0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -100,6 +100,7 @@ config DYNAMIC_DEBUG
 	depends on PRINTK
 	depends on (DEBUG_FS || PROC_FS)
 	select DYNAMIC_DEBUG_CORE
+	select ZPOOL
 	help
 
 	  Compiles debug level messages into the kernel, which would not
-- 
2.26.2

