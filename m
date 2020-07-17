Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20583C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07BF20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkHyGUQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgGQS4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgGQS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:56:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE1DC0619D2;
        Fri, 17 Jul 2020 11:56:53 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ed14so4702884qvb.2;
        Fri, 17 Jul 2020 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eqTx6tb7dBGI8HdQ+BpE3NFeVVk8jp8/GWRA4DtIeM=;
        b=YkHyGUQWE8vd9APfIxDejQXtHyQcWy6j6uk/Zq4gV34+LFIVX4XxqvUfkWh7+qOMmD
         hX3jzvXDaDSuATQN39y/UEEDlUe4cPXntQ1wcXKixr6QD/RVRZJ4NqMP/ZaFL0BytGBS
         3q6q8NX2dashADj2NLrkfd9CCDgSAbUZPX4oNVrfo+gbogBzmSlqzkSPrqviFXKT3ou/
         r2TKyZ114CzvwMrwykNE3udzj4H/kRh4czLs2a8n3sVG1joQL27mO1p7Dbr8ZiLP1PQv
         ewdizaWliiIULB+auk1yXuMkxtZV5qS4HTnzMQbMVOCAryQ5hGoZw0wO/lc92LA/8YcV
         sETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eqTx6tb7dBGI8HdQ+BpE3NFeVVk8jp8/GWRA4DtIeM=;
        b=X2sCEBr9rEXfBFYBnex9yQHmX+bN5u+Wp5cky7ep9lH0fXsSHxPloK+ycxCA3FagBb
         YFQrIU/G0ycyypr0lQjrzbTbaD9vP9KbI9ajhkcOlPMMdR4jIkqJQGpCz3YNWSeQ97fY
         gcqKSoehI0fD6++AmP0etvfcVddXy+yACO+PMU9oiAuvAfp/0D0QX2l09IBOM0F6wwP/
         csgaDem89PLCNEtrrCoInAKHGQTnFeVaZsFKxSkNDww/7BEmY2SuX+JzQH3fByKxsTwi
         TgaGFADOd2/zBJ49HjvJ8XdnSKvewKXDQeeju1SI5lDto2m7BtyS3jnrSO2w7aUolfUw
         4wVw==
X-Gm-Message-State: AOAM530Nktgf5EiAJMRtiOHHXZAO1WiXK/JCPWtHOj75+JT9R91N415f
        jZezNHiMRhG/Lz/R1zYxzf8=
X-Google-Smtp-Source: ABdhPJwt5WASW4BjPu1ozR3xxKwj22kweC0huB8eVMyAPvNXhKPZgHoBvgJL9/ZnBXFyhZQ5gm3Tvw==
X-Received: by 2002:a0c:9e91:: with SMTP id r17mr10412286qvd.182.1595012212866;
        Fri, 17 Jul 2020 11:56:52 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:56:52 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/25] Documentation: amdgpu_device_resume: Fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:01 -0300
Message-Id: <20200717185624.2009393-2-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warning:
warning: Excess function parameter 'resume' description in
'amdgpu_device_resume'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9e67abe8d0aad..dd7da7b4b696d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3473,7 +3473,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
  * amdgpu_device_resume - initiate device resume
  *
  * @dev: drm dev pointer
- * @resume: resume state
  * @fbcon : notify the fbdev of resume
  *
  * Bring the hw back to operating state (all asics).
-- 
2.27.0

