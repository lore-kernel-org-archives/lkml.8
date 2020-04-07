Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B34C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867192075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="YtVBKm45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDGS01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:26:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40390 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGS01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:26:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id z15so392058qki.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurabindo.in; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tIzZDxt4owy5jO/YbfXWS31RiPx2ETthbOiAb1EV9P4=;
        b=YtVBKm457AxFLluMcN6Nh5lxMwkhKLfQcFmIzF16UjpYwbi574i9IUsdKd+i1y8jEZ
         QO7YgInPHWArXiIBcjFTESZaFPpm/XZUbS9LyoPsfi1H5/izGjt26qENa5Ffhy2rpsAf
         kRbqe9ODSQeEpnL+6EleAyr9WmqvD6gXi++mPr+wsYADbd9cXnt4oPEXFO3pqcvfrQ3x
         X6hUV8VWzIz1RB8h0egnBjFrOPNp5ewI4jMMUYtXnxzdx1hqS4quXLMc1USlubqy7332
         HSu19PvLsoWcJkcu6IrFEeYVF9yuwTMSCOnTnl7maeVFD3V58yJZBio0R7w8JP8TRr3Y
         NOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tIzZDxt4owy5jO/YbfXWS31RiPx2ETthbOiAb1EV9P4=;
        b=X8Q4lvQK/QCUfjHZ4XVNoUbMWaHQ1WkaxtPdRZj2j9OceKOMiifxJyD1PGlCsqN1Co
         YsUaFCmEXKuzGONLXWvtSbeMoehBPdLQWDA9Oh1WGkZqpY5jP05H+cv6m5TtONpOVA9a
         Ela/DU394kTaXUgSCkcSI8iESXMCzs03kfwwR+SwCA01BlyveU9f26IKUfK36Q+Ctzqb
         E0qAMMEpE9Ulug2LvZXQkGsxoktvbDmFv85Sc1jHSsTquZgEROChYs9rIkHe8dcN1uox
         +gznTu2DVvEoisHrsC6Oet5YdBMofLvw8bgJCOJnAxDDWnHFhyC485q420pF+cXoJr4W
         jSPQ==
X-Gm-Message-State: AGi0PuZuwVFHR+uEPZgiMTqG8wBFtn9WwO3YlskcvkoVhjJNPYg4VfGO
        lca2WbfFS00OsodtUTdLXsSeLA==
X-Google-Smtp-Source: APiQypI8YWAgQPWSYcS57KN14S6Q6DPtZWqlj+0qOHI2e6co5FZjn/hZaZ4asuloc3R4ftyLEEuEsA==
X-Received: by 2002:a37:6356:: with SMTP id x83mr3757099qkb.339.1586283984192;
        Tue, 07 Apr 2020 11:26:24 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca. [135.23.249.169])
        by smtp.gmail.com with ESMTPSA id f1sm16232830qkl.72.2020.04.07.11.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:26:21 -0700 (PDT)
From:   Aurabindo Pillai <mail@aurabindo.in>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] amdgpu_kms: Remove unnecessary condition check
Date:   Tue,  7 Apr 2020 14:26:18 -0400
Message-Id: <20200407182618.2488-1-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Execution will only reach here if the asserted condition is true.
Hence there is no need for the additional check.

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 60591dbc2..9fedfa531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -179,12 +179,10 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	/* Call ACPI methods: require modeset init
 	 * but failure is not fatal
 	 */
-	if (!r) {
-		acpi_status = amdgpu_acpi_init(adev);
-		if (acpi_status)
-			dev_dbg(&dev->pdev->dev,
-				"Error during ACPI methods call\n");
-	}
+
+	acpi_status = amdgpu_acpi_init(adev);
+	if (acpi_status)
+		dev_dbg(&dev->pdev->dev, "Error during ACPI methods call\n");
 
 	if (adev->runpm) {
 		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
-- 
2.26.0

