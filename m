Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A2CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A453F2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z++8msct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgFQBCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFQBCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:02:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CDFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:02:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so144120pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2a002H3vcNUYJWpyRwovtWUn/ajmAxDHx0MWs9PMJ4=;
        b=Z++8msctdPpkpmbBjfmvMohChPXDgzSD9AtwZnDQEe3e0Kt9EMr3qi9KIGZNslsyXr
         xLp79imR3/YKoOqFdVgGw7josD+eVR+1USuL/E7J/kUnmDwQEs9qVUwl8McnXnhPhSu1
         eOpyIkmmOGW+GZ/SHwOmMCJdiTYyoAexK9/VkcLFKnV/if1DUlM1UlCVsU0rQau8XguM
         xZeinGWLaDbq1+nxElAmljy04KGeOjSbHh4GZWX0EqeWCaJKlndXBWEsjkorOAEi8czE
         RlzdUDPo84mfw9lgQ26Bq+WM1MW8+N+N2PlQjhcOyktUhvV39w8y4dFNL6bcFDzbpF0V
         JvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2a002H3vcNUYJWpyRwovtWUn/ajmAxDHx0MWs9PMJ4=;
        b=VwgOxUCequkr8Jsq/Hqg07PAiK/ugnp2k5kuFQ51JLBTrLDQ0GpD4Sjdc10cT3lS/e
         txv0W8/vfdrWuU5NOuGhwt4nXdzi01wElvvV727SiNCOn0wgWBoj0DRIYiYjJE4O2xH8
         2hOG1QSlilUcaGX2A2eErHc5kWl4hAIqyoaOeLFJz645Tr3RwimnzHu0sW/0Pq4ErTum
         eHuev4F/CdmkdhvNCjLbdieyUU1OfltkGyUHRqpv8JIoEez2U0PHXRvUtJthZvR62ZqC
         pTHMHG1FQzBEnhCTK1I/aCNS8yii6OeDIw9ki6Kqukne1nGDht9LEb+iymw54JbcISEa
         Hd5g==
X-Gm-Message-State: AOAM531Pobs4lYLk/WMHd19VjnAnBJmEhUIIrCo1+tgSUh8qnl20rTiR
        2PMcB9m8hfaK56hz558ayvhkljiIve4png==
X-Google-Smtp-Source: ABdhPJywNMJ6KgTrIYao5oHl5pmyoYTV3NqSGTdY+bxKIgOQHt/ofYCsUFqaFWq+tUtpmk15FKde5Q==
X-Received: by 2002:a17:90a:8089:: with SMTP id c9mr5862338pjn.126.1592355765913;
        Tue, 16 Jun 2020 18:02:45 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([89.46.114.134])
        by smtp.gmail.com with ESMTPSA id fv7sm3563299pjb.41.2020.06.16.18.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 18:02:45 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Sia Jee Heng <jee.heng.sia@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: Intel: KeemBay: Fix header guard
Date:   Tue, 16 Jun 2020 18:02:32 -0700
Message-Id: <20200617010232.23222-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

 In file included from sound/soc/intel/keembay/kmb_platform.c:14:
 sound/soc/intel/keembay/kmb_platform.h:9:9: warning: 'KMB_PLATFORM_H_'
 is used as a header guard here, followed by #define of a different
 macro [-Wheader-guard]
 #ifndef KMB_PLATFORM_H_
         ^~~~~~~~~~~~~~~
 sound/soc/intel/keembay/kmb_platform.h:10:9: note: 'KMB_PLATFORMP_H_'
 is defined here; did you mean 'KMB_PLATFORM_H_'?
 #define KMB_PLATFORMP_H_
         ^~~~~~~~~~~~~~~~
         KMB_PLATFORM_H_
 1 warning generated.

Fix the typo so that the header guard works as intended.

Fixes: c5477e966728 ("ASoC: Intel: Add KeemBay platform driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1053
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/intel/keembay/kmb_platform.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/keembay/kmb_platform.h b/sound/soc/intel/keembay/kmb_platform.h
index 29600652d8f4..6bf221aa8fff 100644
--- a/sound/soc/intel/keembay/kmb_platform.h
+++ b/sound/soc/intel/keembay/kmb_platform.h
@@ -7,7 +7,7 @@
  */
 
 #ifndef KMB_PLATFORM_H_
-#define KMB_PLATFORMP_H_
+#define KMB_PLATFORM_H_
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>

base-commit: 27f70ec4fa0e0f419031f1b8d61b1a788244e313
-- 
2.27.0

