Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582A0C4345D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DF420792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMCdyQhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgGWMZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgGWMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A0C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so4972738wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hLMOaM8iSqxASAI/AKDkn1rxF+S99dQlJ1Nf6t4G/bk=;
        b=XMCdyQhVFCi6/Umqy2BL5lvg3KZdsLZixNAGmFwN77HHlwBykzCjGpwPy9ESSXjVuT
         iTJxfXek7AOOcDSQn/MxjqdDCN4iacAy6i1ZwD/pWFX+hhVIygaZuE4aWYF7CsbwkvKT
         ifPsFUAb9HUS61VFI4qIeXx4LOCDA5cx9LiGC2TM+CX2yRjuYZTMaxQAInXAE/3XwngA
         H3yzgwUb0Zft8+3t0WskpYaGqxpVCt8eaSYKJrU29sVGAfdkn1huj4aGdp4QWuCuoxa3
         nNz7wBE3E79WtUZ63p1ja7Ip2nOXuEwXc+pNnqL/reGlksaJ4pf1w/zOWIzb7n4QOEi1
         8mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLMOaM8iSqxASAI/AKDkn1rxF+S99dQlJ1Nf6t4G/bk=;
        b=rdkAd1q2Pu4Bn8lYCQQwK4BAFDH8Wmpat+sl8ozDke4nMbLimiZjaDJE7qhzcTtB0e
         thZykym8fuFm9EF/WQrhFq8dX2yKZVkcdZFfZB8TdD/IO/ZK+pfO1GlK23qRSP1Mr3SI
         vUW07ucIMXvv4TSfhTOjhKCT/hByOdrn1SvhFVNYJtQhU4jMFUrlefDPRg6vr7LuBl7u
         5NsbYP3XsR3g3qV21ifMHGu/OhvQiAJpCI8XfDMSS7toNCw5iB60aKaaR1/QvYvjLsVI
         LBtZ+1QV9cJZ13tT2zFNrJQqETd89Mi0ajKa7mCWQ3WAlY0cq51+eJ5Tl6NvHPT7kKYt
         Ftfw==
X-Gm-Message-State: AOAM533AEslvkXooZw6rNiD9+rBFTFLkK8FZkHMZQnrarQ0GI4lHJQW9
        HGlbAuVZxqSmpB2DjJGiNIAnvA==
X-Google-Smtp-Source: ABdhPJwrD6HEwKn697niOMA41eFD1GShOngUDeMgSw8bSj35wuHIB+IqpnbyrtRx58qcvunvIeLsOA==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr4105420wrw.360.1595507132577;
        Thu, 23 Jul 2020 05:25:32 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Subject: [PATCH 35/40] scsi: bfa: bfa_svc: Demote seemingly unintentional kerneldoc header
Date:   Thu, 23 Jul 2020 13:24:41 +0100
Message-Id: <20200723122446.1329773-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the source file and no
descriptions are provided.

Also demote standard comment.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bfa/bfa_svc.c:3847: warning: Function parameter or member 'bfa' not described in 'bfa_fcport_get_cfg_topology'

Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bfa/bfa_svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_svc.c b/drivers/scsi/bfa/bfa_svc.c
index 0b7d2e8f4a669..1e266c1ef7938 100644
--- a/drivers/scsi/bfa/bfa_svc.c
+++ b/drivers/scsi/bfa/bfa_svc.c
@@ -2718,7 +2718,7 @@ bfa_fcport_sm_ddport(struct bfa_fcport_s *fcport,
 	case BFA_FCPORT_SM_DPORTDISABLE:
 	case BFA_FCPORT_SM_ENABLE:
 	case BFA_FCPORT_SM_START:
-		/**
+		/*
 		 * Ignore event for a port that is ddport
 		 */
 		break;
@@ -3839,7 +3839,7 @@ bfa_fcport_get_topology(struct bfa_s *bfa)
 	return fcport->topology;
 }
 
-/**
+/*
  * Get config topology.
  */
 enum bfa_port_topology
-- 
2.25.1

