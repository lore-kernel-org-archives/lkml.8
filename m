Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8343DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4887220C56
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILAMqABd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgIDUvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgIDUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:51:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A158AC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:51:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so1207892pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOzF/+k50saIcAgs0crn0HxyoohN6sXckiew66OC12g=;
        b=ILAMqABdT2BUjSzxk2Qzna3wBQ+wWWJjUCKHfj6PukUoGPJOi/jXS2GpXmpKNjnKz9
         IIYTDZ2A364YrdTNrli4Q4KJCCrXKtKj8C30TqalpzEUyXIErikpmy9EaNYwROgfhVLY
         Oa0UOXRbfzmxHHm157okuEI4MMwFSuX47FEG3ISpyu/t9BRrrvpw4hj3N9kY93FTYgVm
         LXGcvtesSXy/jqK6DA2khhbeRRXPEsPAHhHwTtpJMcoQ5w45Iatv8f/EGE1B1KgTecdh
         XgjtD178OWjXXvnEaH/MNe3YtYMo5jv34QFIG2nm2snqhlALFcchsfIbB+FtHKG5Jest
         F/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOzF/+k50saIcAgs0crn0HxyoohN6sXckiew66OC12g=;
        b=RZgrONqZcW6TzYAoP/tmYXKOX1MxpVUKXB8jgNoAKCNdr9PliKrYStivwYK6itqa2q
         CxbUQ8MlbQhXVTgK6/CgYPRXp+N9uQQ2SgbL7+CLoc/qBmSH2OKrrA/4hJnU3glv6t2o
         qz7pfjuJ3Mr1d0YnaXO7fo4vr19f5cYrRSuCGLRmTE/YmZFQ3ycIZkUpsn7kMJkhaw8d
         yxvifNLuRKcSgQsIGKmI/atXBBjvw9/dBNElzzKgTyuplYaZ6ekXtZ3JG50rUvLPSqQ0
         MC/G13sADCg6MS0g28VZ35WNcL+ey5Jo+T2XUI5RUXMGXVWTQyq6xdOEkmILXYS3nJ/z
         P4IA==
X-Gm-Message-State: AOAM532zkROr8hRJlm3TXs+xvxNBqlXLEOx4rSlwtNUEZLq0c9d3N280
        TnvZUSaP4/LEYk4BJ8MQ/6RaXFbKpcA=
X-Google-Smtp-Source: ABdhPJyo/lLHCir/m30kKatB4Y6iqVs5B1zRCth0xKXi/ED7xkptrjQ0vB68vxcRIGDfRM9OyMr9Fw==
X-Received: by 2002:a17:902:6843:: with SMTP id f3mr10250325pln.112.1599252667188;
        Fri, 04 Sep 2020 13:51:07 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gb17sm6193305pjb.15.2020.09.04.13.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:51:06 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] soc: bcm: brcmstb: biuctrl: Change RAC data line prefetching after 4 consecutive lines
Date:   Fri,  4 Sep 2020 13:50:55 -0700
Message-Id: <20200904205055.3309379-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904205055.3309379-1-f.fainelli@gmail.com>
References: <20200904205055.3309379-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the RACPREFDATA(x) setting to prefetch the next 256-byte line
after 4 consecutive lines have been used, instead of after 2 consecutive
lines. This does improve the synthetic memcpy benchmark by an additional
+0.5% on top of the previous change for Cortex-A72 CPUs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 28f69cc0df51..63864b6dea2e 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -23,7 +23,9 @@
 #define DPREF_LINE_2_SHIFT		24
 #define DPREF_LINE_2_MASK		0xff
 
-/* Bitmask to enable instruction and data prefetching with a 256-bytes stride */
+/* Bitmask to enable instruction and data prefetching with a 256-bytes stride,
+ * prefetch next 256-byte line after 4 consecutive lines used
+ */
 #define RAC_DATA_INST_EN_MASK		(1 << RACPREFINST_SHIFT | \
 					 RACENPREF_MASK << RACENINST_SHIFT | \
 					 1 << RACPREFDATA_SHIFT | \
@@ -174,7 +176,7 @@ static const u32 a72_b53_mach_compat[] = {
 static void __init a72_b53_rac_enable_all(struct device_node *np)
 {
 	unsigned int cpu;
-	u32 enable = 0, pref_dist;
+	u32 enable = 0, pref_dist, shift;
 
 	if (IS_ENABLED(CONFIG_CACHE_B15_RAC))
 		return;
@@ -184,9 +186,13 @@ static void __init a72_b53_rac_enable_all(struct device_node *np)
 
 	pref_dist = cbc_readl(RAC_CONFIG1_REG);
 	for_each_possible_cpu(cpu) {
+		shift = cpu * RAC_CPU_SHIFT + RACPREFDATA_SHIFT;
 		enable |= RAC_DATA_INST_EN_MASK << (cpu * RAC_CPU_SHIFT);
-		if (cpubiuctrl_regs == a72_cpubiuctrl_regs)
+		if (cpubiuctrl_regs == a72_cpubiuctrl_regs) {
+			enable &= ~(RACENPREF_MASK << shift);
+			enable |= 3 << shift;
 			pref_dist |= 1 << (cpu + DPREF_LINE_2_SHIFT);
+		}
 	}
 
 	cbc_writel(enable, RAC_CONFIG0_REG);
-- 
2.25.1

