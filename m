Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8C020772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMukI+8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgGBTbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGBTbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:31:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7213CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 12:31:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so6359210pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OGY4T8Zcs1wcon8HLlPhq3ExfaPukK8uw6n/UEszhf8=;
        b=vMukI+8Yv8X+JxDkvnM5hqEvcXbDyO4isuhU2PoyffLpuGKnfl2sXMKAEAK180NxbE
         vDFj55MDco7WU2fFqrEk42iWq2F+virb1m6p3rDPERupGTxifDdqE9Y5NU2G22V/1KkT
         yKpZPbFjw1X9l0nJ1p72s7jp9M65suzdx8q+nRxbfAiZtYj9s3zbF3aTS1+s5OvO3eJz
         tjtEMVxV8gXCg+McmXhFbBclhFf8Ylr86FiEVpqSmL3wq902s59FD5qMB9pD9qWc/wap
         VfVRtxTkTpb/bb1j3lscTUwiMx9NlrcWonpuhi+7wnyu+iBu8mad38gtGNM4lCvR3hEN
         TPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OGY4T8Zcs1wcon8HLlPhq3ExfaPukK8uw6n/UEszhf8=;
        b=YAbp1sLGwrkY2GOfn2/erAeIRePtaC8W0lPutYli5qM/9rEuurf9353PoVC6lRy0ft
         Cnb5wp0Klp41IALsUZscN+ui8uc8DaSr9y6AF0r1eDjkKyjlFFo9FwYH2tCrWlp1e68N
         rOBZgOxjDHtg6crO1F3XunyeKHxbqMPSDIAVFKA60VNAKD94pvb1AAR8UkGJcd59VS9z
         C5NOALz3p93Ty6Rg+VCkMi2re9JU41I3qYOTYggbR2XQc0jPzxjKmMAyKtoJ1BhLmtCm
         B1Zew/zYP1baJ9hUojn9hNKdQpmqRFBJPy6yMK8S5ER440PT+Fb5v88pYoJ9mXk+kyQP
         28Sg==
X-Gm-Message-State: AOAM532wgpguuEBpCPG+6T++NTzNnS29K2HP9Ft0hI+zLakKLmxeuIYE
        uvwCekcDotCey1g9uwDkL64=
X-Google-Smtp-Source: ABdhPJzMUcvdYtFO3zsputaplxh/6FPWCjBX+jSLUSWbLPvXQRFShaLna9JWCkpgdfDYCFe1M5jHRA==
X-Received: by 2002:a17:902:c408:: with SMTP id k8mr28530471plk.279.1593718282774;
        Thu, 02 Jul 2020 12:31:22 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id n63sm9735707pfd.209.2020.07.02.12.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 12:31:22 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Li.Xiubo@freescale.com, timur@tabi.org, shengjiu.wang@nxp.com,
        linuxppc-dev@lists.ozlabs.org, festevam@gmail.com
Subject: [PATCH] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
Date:   Thu,  2 Jul 2020 12:31:02 -0700
Message-Id: <20200702193102.25282-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Shengjiu who's actively working on the latest fsl/nxp audio drivers.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
---
To Shengjiu, please ack if you feel okay with this (your email address too).

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..54aab083bb88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6956,6 +6956,7 @@ M:	Timur Tabi <timur@kernel.org>
 M:	Nicolin Chen <nicoleotsuka@gmail.com>
 M:	Xiubo Li <Xiubo.Lee@gmail.com>
 R:	Fabio Estevam <festevam@gmail.com>
+R:	Shengjiu Wang <shengjiu.wang@nxp.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
-- 
2.17.1

