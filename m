Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99366C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6989E2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqgsQqdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbgFXDbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388292AbgFXDbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:31:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CCC061573;
        Tue, 23 Jun 2020 20:31:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id i3so602833qtq.13;
        Tue, 23 Jun 2020 20:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=X456btJqa3FBWYccHsV53SG1SovSKcsEuNnigqV+tyo=;
        b=oqgsQqdGKU5BQpM2m+Kuk1bmmqRyYz49Dv8FaIqwaBRMIfLPkivagZM8LuMx43B/bt
         HlF4BFdHstvUefkEN+XTLhEwpnYNLcJBKQM7jNrQ9KzTmCWJOJM86wiMcjs6uB4psrbX
         1z0gx2aXrLw5lEMk1nh9WfSzq0XCf3XM4WCIcUC/+X2iPXNkaTVx+89vYdEx+VfIiPaO
         3gZxMJRd0inXasto8D7sdzj7i40vkY+t48vxx9P+186Jhhq8DZKnz5weswgvHscWvBpR
         xrbzPk4rQHeO+JG4wWBADt9A2UfD/HGzMl/ZtILvo/wZZs/WNUheTxcU2/n5NkyVSl7H
         EMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=X456btJqa3FBWYccHsV53SG1SovSKcsEuNnigqV+tyo=;
        b=FjTizpzBFIBxLumhJPv2uCRml1RyiVuJg9F9LSnxDTA3N+TusZgQJfUbcAvX/Rkj7u
         3e8kDR9ypD8y7OoQWYjB2GNR76aD3HMirVFxul4BCYAjNPzwUuqEaSkJNtCiLImX4D0e
         IXopdM9WCTKIgKbXVUXikQLMVVi8p1wE6pUMGoU3Ut5g66uk23vQ2yT3oQ1xDoHtUufg
         qKjNK+4ng+8ELkrUq7nZ87ZguGxDfa+tbNfitiIg6bxGhgwSi06sC+Rk40dhNF8de43y
         uigpRQ2aON1VTjzBfX97r3+TVUS2PRGhd7KtOJkdV2Z9V0n3gBmIv6vFziBjqAlfBzF2
         0ykA==
X-Gm-Message-State: AOAM531G73pfzO+s5ReKioLnP7Bm8/CjA60hVJYZLNNBOrP2kqrCD7Ou
        00EBaWtSgEt21U2bAs+9ToI=
X-Google-Smtp-Source: ABdhPJzSgc6HcM7S8Si0zcj1qwXLvZeru+fHPWjbRBSOkyse3VW555uFMC7ltmBEqDWgyAvV998lYw==
X-Received: by 2002:ac8:5385:: with SMTP id x5mr16709606qtp.230.1592969493722;
        Tue, 23 Jun 2020 20:31:33 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:596e:7d49:a74:946e])
        by smtp.googlemail.com with ESMTPSA id d78sm2276360qkg.106.2020.06.23.20.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 20:31:33 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:INTEL PMC CORE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [drivers/x86] fix bound check in pmc_core_mphy_pg_show
Date:   Tue, 23 Jun 2020 23:31:25 -0400
Message-Id: <20200624033126.5972-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check bounds before accessing map[].

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 drivers/platform/x86/intel_pmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 7c8bdab078cf..f571f9cf7217 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -795,7 +795,7 @@ static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
 	msleep(10);
 	val_high = pmc_core_reg_read(pmcdev, SPT_PMC_MFPMC_OFFSET);
 
-	for (index = 0; map[index].name && index < 8; index++) {
+	for (index = 0; index < 8 && map[index].name; index++) {
 		seq_printf(s, "%-32s\tState: %s\n",
 			   map[index].name,
 			   map[index].bit_mask & val_low ? "Not power gated" :
-- 
2.17.1

