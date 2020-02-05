Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D19C35243
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D67020661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxf/4cY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBEKHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:07:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40568 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:07:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so1906942wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 02:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kmN+kD4FSA2ah1VtoMNYp6bLpdHdftqa8imfp5qvFQQ=;
        b=uxf/4cY/d5W+AsY1/8m+Expm55bXJmtngFXF/rHWedksM3UV1Uqnw4P36T43Wxhnl/
         6O8akDYn3n3HAzBLUpGu0izJUtiD6fAWnB4lCcRSGBbCO+R4Em5OXJR7owAENDJJIAj9
         DiUIb1l3suJk4ZcFTBJvN04tvEvYXu9k0XekjeRrh49oAXJve69+wUSvPAuj+G1VjqDq
         NMlA0I384Ho7Nwq2w4mO3jQXRzJCtorUIvSKctFGSe0Zwc7lPnm0VeQhh6xhKJ/FpHHN
         vLpsRjRhg6d6DQBR/w1yUs4Ti42eK42Y5LlrG7ijZ4NoHTxTdWrmSo0qvPMdNQZSN7WO
         LnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kmN+kD4FSA2ah1VtoMNYp6bLpdHdftqa8imfp5qvFQQ=;
        b=gJRPkad37iI1JVbSGK8GgJtwU0R+B/Nf9PG9sBHgz/gfN6vaNdk8Fn+7kGGYpnTn5S
         wR7cKLL/g4pKWoXksnfKlbbwNloIWOXq2LCere3b0B0+KeO6tWR4HuUD1HxIi59PdRtW
         isemna3GgdZHEkLxhUQG4WJZUCcePfyfrhH+IlNJzaEdPXJUMz2RoFuVkvSFbxyfc9lf
         ORSifpXAH8NZ3AxHMH26erNfa2hyLmKjwJcKeQbZGR/llezKiIb415I4X9h2PLnlgIE/
         TnlqA6b4VCDhS3VKj8uOfCeB0towu2ne2y7NjBnWwejpX6XN3ht7EGoBvGBmTBCxSeH9
         xTxw==
X-Gm-Message-State: APjAAAUbP/I4SAo3S1z3fnl3ZuGgnSTUISsp+Mw3DwWNWHMvrmhVk4nB
        1O3tyfje0fju/rd/6qYRfa6ldHurH+Y=
X-Google-Smtp-Source: APXvYqw8R2TaGaAU3fic2Um7fz5KY8Q5ydfOXnJm0vGUyK4eHmdddD90kmC2E19/Z2AkBgRXGcRgLg==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr28029051wrn.341.1580897270947;
        Wed, 05 Feb 2020 02:07:50 -0800 (PST)
Received: from cizrna.lan ([109.72.12.137])
        by smtp.gmail.com with ESMTPSA id y6sm33749863wrl.17.2020.02.05.02.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 02:07:50 -0800 (PST)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panfrost: Don't try to map on error faults
Date:   Wed,  5 Feb 2020 11:07:16 +0100
Message-Id: <20200205100719.24999-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the exception type isn't one of the normal faults, don't try to map
and instead go straight to a terminal fault.

Otherwise, we can get flooded by kernel warnings and further faults.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 763cfca886a7..80abddb4544c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -596,8 +596,9 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
 		source_id = (fault_status >> 16);
 
 		/* Page fault only */
-		if ((status & mask) == BIT(i)) {
-			WARN_ON(exception_type < 0xC1 || exception_type > 0xC4);
+		if ((status & mask) == BIT(i) &&
+		     exception_type >= 0xC1 &&
+		     exception_type <= 0xC4) {
 
 			ret = panfrost_mmu_map_fault_addr(pfdev, i, addr);
 			if (!ret) {
-- 
2.21.0

