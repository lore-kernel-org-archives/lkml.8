Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879DEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533742065C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hDJcgPW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgHFArB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgHFAqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:46:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D43C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:46:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so8041088wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nyhjLBB+HDOsnYsr5HndxYbNx6+5wm5yHY6ny38HDy4=;
        b=hDJcgPW2MiTxXBswBep7MurSgrMndx27kGTrYrfoAGNpiEKXvaZvTrft0xKE7cgaIu
         aYIcejlSXK9L+12376ktVVoJD5K0lmq8Ma6GecuKXeY8HRko8iFeQ6IyFjJmG5Us0Pge
         HNR8pEMhJhFh5YEZayW/H8tmfqv8e57nny8h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nyhjLBB+HDOsnYsr5HndxYbNx6+5wm5yHY6ny38HDy4=;
        b=C1SL+QRn/qZpb/b5tK2k3sxRCJOiZT7XwiduKitWVf6G+XshhMg75Fo+WvOqMrUTfk
         65WnINg2c2LiYmxh+shBFwfEwMP83hKq9jq/SG8iSeIjZaIYPLr34T4p5ADLaCRYeESK
         wWstUB5EchkSh+mI0FTr1sSCSZY5Xd3eMO+kFfukmNAAo3kx8MKT/Linb9CANFtZ5Yjj
         iYTiP41dsJBx4+m/63TZNJ88EMQKamN0X/hP3pvh+r4jrc9oFErZCVMNcogfdjLE1PXQ
         lHk8rHTip+U70Ouc5TFXC90Tnwx+5/7Rl1Zu86L7gcJAJCURa3xMb6KsUlb7+7JTUjpK
         cuSw==
X-Gm-Message-State: AOAM532g+CVqzyNn+mg3elWJK4len6ZsmCZTdvnSb0eYBBmnXtPRkpWd
        7suczZ9SP3uBk7sp384FwbSjiQ==
X-Google-Smtp-Source: ABdhPJxLf7K13HNTLNtyAdRbRDG+KMdPwlV9DlvflOV39DtxIAiWGlgLp1lzDc9ik4ubDjhcSEFiUA==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr5262510wmg.113.1596674811265;
        Wed, 05 Aug 2020 17:46:51 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c17sm4665745wrc.42.2020.08.05.17.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 17:46:50 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 3/3] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Wed,  5 Aug 2020 17:46:31 -0700
Message-Id: <20200806004631.8102-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806004631.8102-1-scott.branden@broadcom.com>
References: <20200806004631.8102-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d4aa7f942de..fa610b492350 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3657,6 +3657,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

