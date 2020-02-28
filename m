Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A91C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201FC2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpEcFTm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgB1H4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:56:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41496 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1H4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:56:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so1085630pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 23:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wGIDcVupomw+rYzafmKANeDmOfnLh1mN06eyIzxgWso=;
        b=BpEcFTm07491mAwvQ/lxlBT5Yi1WeScCAtC01qXkBjVC/b33uILPahrOsoT97mH8ll
         T0aWZ7mM6sG41tGlAy3qfGrpEJR6Lh9tEjub6/Qf4ZYx8YjzkQP+JeYiKJ8Ud4SIze83
         4NY1uSnH2gwhzwSX4r/MujlVllWJyGjUOrnqdgeYJAsECCfbbadBwqt0t04xBfR95GYd
         HzttlMz1uMYb0yjOE5/jiNYlD4fgAVULVfwgcJSRk/pdIFjSyZy4Df7q4QseVkDGRWiS
         0m+5VDe0EG6XSrSc1CHz930DjW2eOMm+rKHNOdQcWtcpbwdeV3XXS9gZcSojgEFkh/Of
         6Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wGIDcVupomw+rYzafmKANeDmOfnLh1mN06eyIzxgWso=;
        b=YzwR0wXN8BeaCnYLzndX84nfLSSkowSbmtJimjX8aiJNpHsvU+zrDF/ntgK1wyytZ2
         teh5dRHfqFqGA7fG9wYFBdfPOUwKL15cCMtySNTQlrGnfEn52CtZx8CRQudI99gC5QXH
         8hcsJX+7WlEOpU0uNEgmWbxry36nxCSqcEyhBQgFCLH53qx+iV1NM6TzQjnahQJqtpug
         Iu5I9nc48H/eq9SfbmcuIRkAZE5rPXpjRvMzn1kJIsGuncehdFK5b9n9kJ8xI4eNexfE
         I3hhjCLIa34+tM1oBvOhhxm70qvl1rFKYVJYVQXi2qBfv3CUbUWyvkq1I6uUswsmi1u4
         i94A==
X-Gm-Message-State: APjAAAXDk2WoBwaKT5n7be1E+0oJWM79vzGyPmPyS5J7f4wvSmd+yaLO
        PZSeausAMKyt6pc3FG6kqWU=
X-Google-Smtp-Source: APXvYqxNQUCwhqpvFgrUAlP7d3bHLavu7f+B2lQn85cH0TELZt3anm+RoZA2iOYnttR9WVQeUnHdOw==
X-Received: by 2002:a63:b515:: with SMTP id y21mr3421313pge.148.1582876598811;
        Thu, 27 Feb 2020 23:56:38 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id o17sm4156279pfe.9.2020.02.27.23.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 23:56:38 -0800 (PST)
From:   Junyong Sun <sunjy516@gmail.com>
X-Google-Original-From: Junyong Sun <sunjunyong@xiaomi.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        sunjunyong@xiaomi.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: fix a double abort case with fw_load_sysfs_fallback
Date:   Fri, 28 Feb 2020 15:56:33 +0800
Message-Id: <1582876593-27926-1-git-send-email-sunjunyong@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_sysfs_wait_timeout may return err with -ENOENT
at fw_load_sysfs_fallback and firmware is already
in abort status, no need to abort again, so skip it.

Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
---
 drivers/base/firmware_loader/fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 8704e1b..1e9c96e 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -525,7 +525,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
 	}
 
 	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
-	if (retval < 0) {
+	if (retval < 0 && retval != -ENOENT) {
 		mutex_lock(&fw_lock);
 		fw_load_abort(fw_sysfs);
 		mutex_unlock(&fw_lock);
-- 
2.7.4

