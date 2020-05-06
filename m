Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24ECC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B19C20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/ilkMXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgEFQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgEFQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:42:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E06C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:42:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so3482661wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oIeCC+0/EiI9sm7qFQDhCkikI6og9UeKJJkXjCNEh4=;
        b=O/ilkMXARUeK2D3ICsAU4LxK79OJT0MBJTCLZkow0BNCeXP0XnQLIR/feAtb8UBZN+
         3wfBIP1Jk9Oy8l+t4VgxtRWpsgAGmez4XRquO5zOS9zprjlLf+Cq9NX1fsd9O1karj2l
         fvRRo8c8dIBVe7ZYolmUmk/lDRGT8AGC4qjoIr4HMn+PyiCzUyPkviui+9wHq+MXGg+3
         o4GoIUAmJ0bWO11IEL308Icc81nqK4l3czpdFYqYd5eeaCOuuVJsrmxlWNjcvXbekhM7
         qOQBxEgzEE7iawm0ZBkb0nsdrfTL0Hj/W+A0typua7DtMwCcaXeO3p1FOxPB+EIFOotF
         Y+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oIeCC+0/EiI9sm7qFQDhCkikI6og9UeKJJkXjCNEh4=;
        b=moFkfDLRt+PG2qvTPPm9exl4ipXhcTddEbHC3jWUVhHMByy2FqqeQ4nD2ReVSL3Md1
         /rBcVGNl0mYs2a8vIV0fv7QyjQxNkLidRowt2Wf7l9bay8fO8qb+3YNswBlFAe21Y5GI
         u6DyA6sZy7hOwbTB8fm8sho9/GhVdn4h6OQ8WwAK4PFCygcOdG2A6rl7nW478JkxAwkJ
         yl43JjU3j1IegmoRA0up/Bj+vf4GVOuoBRPJyj6PVoi1a0mPM7AablLzBAT3Rpbw0K8I
         csyZ8+sykG/r+ICESfmjsluH4uJxNGZyv+MRuJ4RBfVUyz25PiGfjIOYQ8U0LMXT5SZE
         P8Tg==
X-Gm-Message-State: AGi0PuapDGhTf4pyOo2XQ2Cart4OxVvBGbu6sdKzsbXiQSAUNLSE8Ghk
        E50OVm0szpWPNcgHFqTvvHAXig==
X-Google-Smtp-Source: APiQypLmV4ose9t9DElkNYLgYcNAXiarZ1Br8nv0JcfOv4Av1Zc/Cvy3tfs67XWkiIIaMRomr4d+yw==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr5212647wmn.46.1588783367518;
        Wed, 06 May 2020 09:42:47 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z132sm920713wmc.29.2020.05.06.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:42:46 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, Will Deacon <will@kernel.org>
Subject: [PATCH] kgdb: Fix spurious true from in_dbg_master()
Date:   Wed,  6 May 2020 17:42:23 +0100
Message-Id: <20200506164223.2875760-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a small window where a badly timed migration could
cause in_dbg_master() to spuriously return true. Specifically if we
migrate to a new core after reading the processor id and the previous
core takes a breakpoint then we will evaluate true if we read
kgdb_active before we get the IPI to bring us to halt.

Fix this by checking irqs_disabled() first. Interrupts are always
disabled when we are executing the kgdb trap so this is an acceptable
prerequisite. This also allows us to replace raw_smp_processor_id()
with smp_processor_id() since the short circuit logic will prevent
warnings from PREEMPT_DEBUG.

Fixes: dcc7871128e9 ("kgdb: core changes to support kdb")
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/kgdb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index b072aeb1fd78..4d6fe87fd38f 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -323,7 +323,7 @@ extern void gdbstub_exit(int status);
 extern int			kgdb_single_step;
 extern atomic_t			kgdb_active;
 #define in_dbg_master() \
-	(raw_smp_processor_id() == atomic_read(&kgdb_active))
+	(irqs_disabled() && (smp_processor_id() == atomic_read(&kgdb_active)))
 extern bool dbg_is_early;
 extern void __init dbg_late_init(void);
 extern void kgdb_panic(const char *msg);

base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
--
2.25.1

