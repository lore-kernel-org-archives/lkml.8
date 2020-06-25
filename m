Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77580C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562392076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJYjoIBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406607AbgFYTRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390701AbgFYTRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ECAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so7091357wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akaAj645pp+5kfB2OMHemKghBJ6xbAKNYnmCPlCSuI4=;
        b=DJYjoIBYSS2lz1zbBDeTTsMP/zoqEcyAlbRPPhemK424wFYbrYKJ8nOzwJXHGnnrO3
         xVgD4p5dW2IluzPSraMewfwy7VLOGiKVCJqXoDhOuj8jMgZ9uFV95vgLagUVoSclZUrP
         Yv/58ap4pjA2xK83ar6XJtiLkw7ZJj5t269M7AZOksbPNAlUw4aFRPSbVFEz0BLnhyHq
         ah2wRxrr/EB7e+CW9CzyK0IMcpAr6vOkCNG0NVggAASTusAgwhRbVrUgz2+agpr7FOE9
         SfBUXPOM288pdFyoWOh4ihtvLnURlwfrdksVtHOcyl0PxOaxc5rbCSWywe23opzNF5EH
         axvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akaAj645pp+5kfB2OMHemKghBJ6xbAKNYnmCPlCSuI4=;
        b=L3PUva8z4L2/4HXkeoLj3JhFOicfwohkK8S3mr3SwiFvLOpvicX/AFkctODcy3cNrj
         EKSP39OxpYqon0+7++MK/l4mu1B/r9byd7X9pTs+REv14Q331+wTsTz+9DFxPxyVcBaU
         4zEhTDsQNnxyqmwH509Kj97nNSswAnFOWi0X9WAnfdBDHYaXy6m3rAzgISOxIa2Kjuvi
         qr/nC7QgLg10/jysp6L1hA72pvIaYoEeTWBogM742SRbr+NoVpk4pXkyCxOqNQecxJc1
         6WSBieZX9otOGCAUdUYvnoZlplQKGd555uVDR7llw4kIDIIRMzrUo0j+q3EBpk3Gr3Tj
         EA3w==
X-Gm-Message-State: AOAM533myA2VNuZzI8/MJaMhxvx+bFN11/IyQTXLwIPzeNs69WyU7QOJ
        3I1PJI3DhudX4Qv4MVP2xD6iUw==
X-Google-Smtp-Source: ABdhPJxxuE2UVuaT+d/IHqyXzR0hzE7J39cB8NHtnMbnpwgisQf2e9In0WZInXBmGfRGOzs1i6h3QA==
X-Received: by 2002:a05:600c:2108:: with SMTP id u8mr5436244wml.189.1593112643364;
        Thu, 25 Jun 2020 12:17:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [RESEND 08/10] regulator: cpcap-regulator: Demote kerneldoc header to standard comment
Date:   Thu, 25 Jun 2020 20:17:06 +0100
Message-Id: <20200625191708.4014533-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing about this comment identifies it as a kerneldoc header.
They're missing all of their struct's property descriptions and
the correct 'struct *' header.

Fixes the following W=1 warning(s):

 drivers/regulator/cpcap-regulator.c:99: warning: cannot understand function prototype: 'struct cpcap_regulator '
 drivers/regulator/cpcap-regulator.c:337: warning: cannot understand function prototype: 'const struct cpcap_regulator omap4_regulators[] = '

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/cpcap-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index fbf823b830308..221e8db358c9e 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -89,7 +89,7 @@
  */
 #define CPCAP_REG_OFF_MODE_SEC		BIT(15)
 
-/**
+/*
  * SoC specific configuration for CPCAP regulator. There are at least three
  * different SoCs each with their own parameters: omap3, omap4 and tegra2.
  *
@@ -325,7 +325,7 @@ static const unsigned int vvib_val_tbl[] = { 1300000, 1800000, 2000000,
 static const unsigned int vusb_val_tbl[] = { 0, 3300000, };
 static const unsigned int vaudio_val_tbl[] = { 0, 2775000, };
 
-/**
+/*
  * SoC specific configuration for omap4. The data below is comes from Motorola
  * Linux kernel tree. It's basically the values of cpcap_regltr_data,
  * cpcap_regulator_mode_values and cpcap_regulator_off_mode_values, see
-- 
2.25.1

