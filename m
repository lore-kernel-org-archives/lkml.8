Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54F3C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E58A2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="aWJuVcTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCWK7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:59:49 -0400
Received: from mout01.posteo.de ([185.67.36.65]:56926 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgCWK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:59:49 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D6E60160066
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 11:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1584961186; bh=XDHP1uEKV3Zyvo+tMi/ZAw+skOWJHrU9lwfxt887eQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=aWJuVcThLqSOOjf4ei0ql3Dwk7fQXdkQRUwVOFv3zuaKmDwBLzXJgQUbzqGgzFfc4
         dr+euvKiy/94Ugkf3j05YYitjQL0tKrRukv9oaf9OtoFdUzlSbndR2gfLAFk+FpW7C
         mtMI+P6TbUB4ehCmRcANBORIUeLaXXVdAUj9VGYckAylPTCNvJ28K8Ib4hBhxpq7ww
         cz0NTjzQ6Od9sG7YmFZt5FmBPCkIKVHJIFDl2qOckwrk3APRcEsfv3qaJTvoqiMK7I
         u+fFl4L8UyVPu7jq6GFkPO1bbl6QSLPmObTEoYSsGr6jS48dLKfKQ0JZnFC4N/aop2
         T1h3uSDDrTsdQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48mBGp23wDz6tmD;
        Mon, 23 Mar 2020 11:59:46 +0100 (CET)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/cpu: Fix a -Wmissing-prototypes warning
Date:   Mon, 23 Mar 2020 11:59:34 +0100
Message-Id: <20200323105934.26597-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing include in order to fix -Wmissing-prototypes warning:

arch/x86/kernel/cpu/feat_ctl.c:95:6: warning: no previous prototype for ‘init_ia32_feat_ctl’ [-Wmissing-prototypes]
   95 | void init_ia32_feat_ctl(struct cpuinfo_x86 *c)

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/kernel/cpu/feat_ctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 0268185bef94..29a3bedabd06 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -5,6 +5,7 @@
 #include <asm/msr-index.h>
 #include <asm/processor.h>
 #include <asm/vmx.h>
+#include "cpu.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"x86/cpu: " fmt
-- 
2.17.1

