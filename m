Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCCBC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D855220746
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqb3rK8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgEFXhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgEFXhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:37:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E7C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 16:37:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so1994617pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EAnXkkiwxKRM7CblIAMy11SzP6B2/JCkzu+vWJX88pc=;
        b=lqb3rK8rVmU3j9g93arTViQlSAMTDWsdJvgnjNx5BF9iIdr0N7OmOZFEgF0/VxWT2z
         xo06rLmv1vBONWyzSieCWcS95nFc2w5fnO1qGXuJ/OIyzJGeEyy2XfvD+1AAgW8a3buO
         mtur0W2BUPw61Xi4IeWZZC3zlIIKqAqONBkELQvxvSGBzWdsx7Nl5rzTypUIEdyqWfnJ
         GbJYtnyMDXBvwst17MDksCgItFCm4ndWnfBEgiyGtTeUbznZegiLz2KqVMhYzLJ7Erc8
         +PWmmcioPKcZUiKYR859QCNTfR+d++sSQjencnbAnAk7gXJyDcrYk2QfETTUKreAubOJ
         COOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EAnXkkiwxKRM7CblIAMy11SzP6B2/JCkzu+vWJX88pc=;
        b=GGKTaQWN64C0dUtU4mRLvKJ93Su0mc0TbbqKMBr4wUAQMZsgn31bHqBtjHsZhgli0O
         E2GWSPZByeJINlvFyLO4zxIeX0DBmQe2NokzAJUToXAMyZOEdspqLvhzEh77XIsNgxgP
         jiu6/xkeFO1mxYkw+BCTMNHtgWClmrcIy9rYuj98si8QzdQ6S0K/S4ClMz795+U8V8hY
         HJg79nBPwmlq1PcwMG5sRpdZKkbL7uHs10BjIQJw57jjv2KSwimn6yLpJmCdh33zcvEz
         yj/BOFIC5BEyqc2KCGIjYRmEvn9mmioh9woAOzf+fONrNt8EGiwPl8l/yQZQXRe9BWC2
         GInw==
X-Gm-Message-State: AGi0PuYoDxjn9b/L4XJaTlv1spRGqbKnb0JhdoDivIetSPgLA/U1dDXM
        MhNtwmYwfHzTiFLcmyBeqiU=
X-Google-Smtp-Source: APiQypLv/jbUn75bndy9vPWPChxYRiEYESuEAiRoS8PhJzULosGFbeMk25P6osgG1JhAMsvEvfMjEw==
X-Received: by 2002:a62:16cb:: with SMTP id 194mr11090455pfw.78.1588808231600;
        Wed, 06 May 2020 16:37:11 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d8sm2953132pfd.159.2020.05.06.16.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 16:37:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: mm: Remove virtual address print from B15 RAC driver
Date:   Wed,  6 May 2020 16:37:08 -0700
Message-Id: <20200506233708.422-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would be trying to print the kernel virtual address of the base
register address which is not very useful and is not displayed by
default because of pointer restriction. Print the Device Tree node name
instead which is what was originally intended.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Russell, if this is okay with you, I would like to carry this through
the Broadcom ARM SoC pull request. Thank you

 arch/arm/mm/cache-b15-rac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
index 3471fc64a3ae..bdc07030997b 100644
--- a/arch/arm/mm/cache-b15-rac.c
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -358,8 +358,7 @@ static int __init b15_rac_init(void)
 	set_bit(RAC_ENABLED, &b15_rac_flags);
 	spin_unlock(&rac_lock);
 
-	pr_info("Broadcom Brahma-B15 readahead cache at: 0x%p\n",
-		b15_rac_base + RAC_CONFIG0_REG);
+	pr_info("%pOF: Broadcom Brahma-B15 readahead cache\n", dn);
 
 	goto out;
 
-- 
2.17.1

