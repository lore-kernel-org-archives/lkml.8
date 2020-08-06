Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03F8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22348221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pXQv1rb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgHFR0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbgHFRB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:58 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD2BC0A54D7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 06:59:20 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id l13so16052675qvt.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aDhJ3BwsHEwEzPKPkJxFBX4MNurIU5lO4LLSrBoplxs=;
        b=pXQv1rb1LDMT9p5PJKkN34fCIy1Nuuyoj0JXb3dtmNH2cYyfiVSD29lea9Qm6P09OM
         69lJrSspkIqY4nar32A/byyQSbLt2PndQGSD67O0bv4UWATkrowXoLo5TziSpMTc1suy
         XrTYTDszMCn/26jfkCmkQn0b4AOEH/9Y/MCYs8dnvafufaVE8CAK+LYCSDg/MN9RLYp3
         MXK8H/k8lbl6s0KHZLek+gFJw7vKxecHM7L7XwSCvuMpDQoaOHiuQRE742w8cpj/D0I4
         tlbAxj8WHqGCBSxuqUrIBpl3RvhdSNa/fQqptXS3Vj7BkdFIHq/FgcZo5N3/KwjokQTs
         gYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aDhJ3BwsHEwEzPKPkJxFBX4MNurIU5lO4LLSrBoplxs=;
        b=LlMW1SKkgcqLfMx/5DJ0wGSwXMJ+/keRBqpNZsVV7Yl757AzdTDzh5tjTtkVVZcYel
         t8IhncfoIjDv8ldsRSHmzA5/cg6HlxYOUSEFDRgKYsUGfY8t1bqZkQQgwRwiL2xdu4A1
         q5mKiBFEv6lVbs3uh317r81Gwt4+ePa3laD25lhA7f7kOkQqQjzSnADXzTJa/b3XvBUk
         +EZCG0aE2qk1sFlcLUAa9W8o/d0H6/Ue/eLYB4N13iAFRq7/N2XWkxCanbCXBu6gm57O
         30eG7g+PKLw/SBIpLiVIGlDlWEGcSGn5E7gBVmdZTmj8z1jiPCpbo/Es05q+8OSWSkKL
         dLFQ==
X-Gm-Message-State: AOAM533Ak5il+rkpyjhcORBzvZ/osXvif3pbIwnGfhTJPXdXatiUgjSZ
        4lE38OMvrXyQ5F5x7eQcug9F+w==
X-Google-Smtp-Source: ABdhPJzFT3bBn7kvSmKrN3dp/BXM9RBI6m1pRrSjKba4KzSAlrw7TW+cwxJLIBiJb6w/1qG7dlkDyg==
X-Received: by 2002:a0c:b60d:: with SMTP id f13mr6793580qve.38.1596722352707;
        Thu, 06 Aug 2020 06:59:12 -0700 (PDT)
Received: from localhost.localdomain.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r6sm4489285qkc.43.2020.08.06.06.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 06:59:11 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     torvalds@linux-foundation.org
Cc:     daniel.diaz@linaro.org, linux@roeck-us.net, tytso@mit.edu,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] random: fix a compilation error on arm64
Date:   Thu,  6 Aug 2020 09:58:36 -0400
Message-Id: <20200806135836.31736-1-cai@lca.pw>
X-Mailer: git-send-email 2.18.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-next failed to compile using this .config,
https://gitlab.com/cailca/linux-mm/-/blob/master/arm64.config

arch/arm64/kernel/kaslr.c: In function 'kaslr_early_init':
arch/arm64/kernel/kaslr.c:128:6: error: implicit declaration of function
'__early_cpu_has_rndr'; did you mean '__early_pfn_to_nid'?
[-Werror=implicit-function-declaration]
  if (__early_cpu_has_rndr()) {
      ^~~~~~~~~~~~~~~~~~~~
      __early_pfn_to_nid
arch/arm64/kernel/kaslr.c:131:7: error: implicit declaration of function
'__arm64_rndr' [-Werror=implicit-function-declaration]
   if (__arm64_rndr(&raw))
       ^~~~~~~~~~~~
cc1: some warnings being treated as errors

Fixes: 585524081ecd ("random: random.h should include archrandom.h, not the other way around")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/random.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/random.h b/include/linux/random.h
index f45b8be3e3c4..da782c16c20c 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -12,6 +12,8 @@
 #include <linux/list.h>
 #include <linux/once.h>
 
+#include <asm/archrandom.h>
+
 #include <uapi/linux/random.h>
 
 struct random_ready_callback {
-- 
2.18.4

