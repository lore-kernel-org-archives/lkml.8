Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E683204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7qIw+Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgHUOYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:24:43 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447C8C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:24:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so1310546qtt.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E5wf4mt808i5uA5gBCo+dSHXigscnzU9oaameGk1kBE=;
        b=S7qIw+Z6SWFkzpEfXXNGNsWZNxAm+oI8BEi4J/KguLDm3x9niSIeyc0tSo3+HOcJoL
         JK7EH9ZRpuZpQN+1AsKrYpnhj6PjFmU3Zv3oX/N0+wSYUSU92xqyyrvJ44WdDX1kajGO
         NVfN4mz7XZ2389FgFlrLjXAcMNnwmU3HDjf9p8kLfPDt6yZ/k4sxw5jGVg18TBzrmefF
         G3/YWDtJs76PhzusAwXWDgOiIQnFSgoIxGeX5sPqcnMJeQoCklMu8cmsEfbgL8Ab+Woy
         blWyNsx55D8idb+Om7i4NTQdJe9TqvpTqcpYqe9kA7+nVMQXmCEO5kO/unhhIJ2UA8Rm
         /rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E5wf4mt808i5uA5gBCo+dSHXigscnzU9oaameGk1kBE=;
        b=A9kufpgNwacr8UrpnoEqIk2O9SLyiZ7WbAvFMxX5YW9Lc2lypY0STa94MU3JIytEDw
         LnmSB0rtjtKDWqmnTi57FR7vy+P25V1bw/BYMLBLNqKfoGJiyrDXVd7fgo0pTmXHJ01i
         ohLdm6a/JWjEi8lo8k3as8ZG/arWAX3+IrDZSM4jelwKKIW8i+trOUQ0TwiXjA8VSXta
         x+hBF8vybE5eSS8fHBDbjvHfPheMVG2P68VM2bdsMvIO77oS3+GkitLcxgUuuYn+xQ0Z
         FBfYM1nKC/XcaBon22w3VVLNL95N5rvYmP4qtolzgwPji0fPXVV9dbeY5R0hse7saGeq
         l+Mg==
X-Gm-Message-State: AOAM530WJ+UQ7O0hLDMcSW5b3NZ18VidCr1Z5rDtNLil0VqyZEABW/Zv
        rTN1NrMdlWdk4TBJcE6/c1I=
X-Google-Smtp-Source: ABdhPJwGAtJBqwHbS8dpY9Ih3A1oa3Iydds1/wjtxXCwpReAeFZK9Gj+DSYEeUERYTHsfxxsH2gwXw==
X-Received: by 2002:ac8:7387:: with SMTP id t7mr2940728qtp.236.1598019882362;
        Fri, 21 Aug 2020 07:24:42 -0700 (PDT)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id v58sm2321784qtj.56.2020.08.21.07.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:24:41 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] regulator: dbx500: Remove unused debugfs goto label
Date:   Fri, 21 Aug 2020 11:22:29 -0300
Message-Id: <20200821142229.12087-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build warning is seen after commit 8bdaa43808b7 ("regulator:
dbx500: no need to check return value of debugfs_create functions"):

drivers/regulator/dbx500-prcmu.c:144:1: warning: label 'exit_no_debugfs' defined but not used [-Wunused-label]

Reported-by: Olof's autobuilder <build@lixom.net>
Remove the unused label and its associated error message.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/regulator/dbx500-prcmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index 7395ad2105ab..8b70bfe88019 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -141,8 +141,6 @@ ux500_regulator_debug_init(struct platform_device *pdev,
 	kfree(rdebug.state_before_suspend);
 exit_destroy_power_state:
 	debugfs_remove_recursive(rdebug.dir);
-exit_no_debugfs:
-	dev_err(&pdev->dev, "failed to create debugfs entries.\n");
 	return -ENOMEM;
 }
 
-- 
2.17.1

