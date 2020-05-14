Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C74C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07308206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFa9LEYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgENIWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENIWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:22:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38817C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:22:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y16so2717609wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qdWmA1Euy8ZG30FI7AUlbvFYtFSjIbnys+8nxgEJbhg=;
        b=PFa9LEYzjwWMWmcWtxzDu0fdq/K+5YMclCSXA64Rlr9wUvrZBZ/9M0Qb4+G+g+R3x2
         funKlEv/81De8p6hoqZ3C3Mp6mO8xxpd5qSRdl5a/M+eRdY21v25CSDE7E9Od/hZRrd8
         NBuC3HaS9FIXoFWk4+YW6hfGd8hGWuWGZ25BhmJM9uTsJRmvlYJ0H7q0e9fzq+s1mlq0
         ovec4GfMY3KggkqZlGxoVqudk53Il3emE9lMn22vHRRGjaDXDoQPKYiIFY62zuo3YRRz
         yI+/47qBFaVlJqYfu3PgkPwcgU/ZGxs22UbhoIAV/vN03Hn2EJouCZj8xIzPFSFy5FSe
         ZhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qdWmA1Euy8ZG30FI7AUlbvFYtFSjIbnys+8nxgEJbhg=;
        b=SCFvUg7rV2EAhokQMjoFHoRwQW8+MVCI+atXK/DEFrlpvVW3+LynUgk+XbMclEdEmt
         4sfMHWD38IwewmrVdqM5QhCsBobeOtrlIVLwCpIDQDXy6zTKag62ieTJrNYfFfWoOhS/
         SW41RMXO+w2bGdkgsfsgPoaqXNtgms15cVLRkkzGYSOIikVM9dA/q4LgIkhUxVvitFXN
         lsyYf+7ulpjEvDCj1cNclJ3r3cEzSL3lEScQd1MMR5hrYePm1nHt/z2py44wrtc0tJ4g
         e7q91HQ9HHqevclA5UI+e2kho3M2ixWm3NNg174inILhY7rTiQbxXDl836AXTwKfQwuc
         SpRA==
X-Gm-Message-State: AOAM532ebIHrJqvqMuAx+FMcWs2wRflYHxoMaRcruqaBOLwSP8U985nu
        XVPnmUtPpgTi8gGugoHR3uUw4EnGUgKPkg==
X-Google-Smtp-Source: ABdhPJx+f1wrdNofwBzUEfjZS+B2S5ZwBh/K69NL9NfijqNi/OpJXubq5S/Uj8dTwz4ehytw0AUy2g==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr3974180wru.407.1589444531787;
        Thu, 14 May 2020 01:22:11 -0700 (PDT)
Received: from lmecxl0524.lme.st.com (2a01cb058702ff00bc4b798f4f30d41e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:bc4b:798f:4f30:d41e])
        by smtp.gmail.com with ESMTPSA id l18sm9170002wmj.22.2020.05.14.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:22:11 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, tglx@linutronix.de, alexios.zavras@intel.com,
        will@kernel.org, maz@kernel.org, steven.price@arm.com,
        etienne.carriere@linaro.org
Subject: [PATCH 1/2] firmware: arm-smccc: define identifier for Arm SMCCC v1.2
Date:   Thu, 14 May 2020 10:21:08 +0200
Message-Id: <20200514082109.27573-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define identifier value reported by secure firmware when its
supports Arm SMCCC specification v1.2.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 include/linux/arm-smccc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 59494df0f55b..1cf221f3f07a 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -56,6 +56,7 @@
 
 #define ARM_SMCCC_VERSION_1_0		0x10000
 #define ARM_SMCCC_VERSION_1_1		0x10001
+#define ARM_SMCCC_VERSION_1_2		0x10002
 
 #define ARM_SMCCC_VERSION_FUNC_ID					\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
-- 
2.17.1

