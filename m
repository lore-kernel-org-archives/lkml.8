Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613DCC35247
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3970D20720
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwLGpNYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbgAZOJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 09:09:39 -0500
Received: from mail-yw1-f54.google.com ([209.85.161.54]:37862 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbgAZOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 09:09:38 -0500
Received: by mail-yw1-f54.google.com with SMTP id l5so3488374ywd.4;
        Sun, 26 Jan 2020 06:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ZHxAfX3Xl6MKW4bncP+VkEHGeKBmUb+6NPJXOCTjuU=;
        b=AwLGpNYcsS7qaP2kfjXCQkOJaqqUJBsbEzRWANhEt5/OrZzxbCDZDLB/OayyRM5HGz
         CEODHwEt2bNhFRu6QEuhXYqFsTteK0817t8C7TP4s3+Hr6elp/1cy4+KKmYXNuJuQwfC
         m2tuRoZKEL+YN+bjiltULlRwgQ0uD0drmO4P8tyERO0oimdR2m0Pyd4FYCDLDN/mY6+Y
         lMzyvzMzGfUDyTOkVVx6n4HHL7ikL5byMEGHTuyGSUGaVROZI7krzNlw3/VRFeaRPyp6
         r6XaGY92QlMA2DIvBNXTHiVtWs7G9VXyhReIb8Etk8R7lSz/eFBXj+ySuRFbqN3up6kV
         ou7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ZHxAfX3Xl6MKW4bncP+VkEHGeKBmUb+6NPJXOCTjuU=;
        b=uZ1hNvliR51azjiZ997+KkJVOEAB1Mzfkd0ylmPHUzb75+CgQkkDUdXnWKLLc1vxb5
         JZNrEru+T+BSU5h4aX9LKDkUYlgKeDOAUqmi06y+m1Zklxo4pVgdYM+K6V4W1Pg2i0YF
         VcZg81Hb7QefloaKjFPVHyVd5tujEUtVxaTIC/OVbJG1ERuzOIiQAIylzfjJcHtJJxhD
         +8cihoclWtQxyfTUEFbfQ5Q1i5zfv3IX2zaDe5OG81GLxPTQuslQ4htpa+K29d+Owd5d
         p4e4m8pXi6PIqxMmXGcutcjfzyYR/6J9mvnwOLCPibozg6Dpnd4mVh/N4XIXSystsGom
         2+fQ==
X-Gm-Message-State: APjAAAVV6XjajuR7/khrJGmQEnykkkJ/aQ7w/0hWFKTVoxU0k/z5CyRD
        PLYru73/25GydQFDSEFSvhAbOLKAadM=
X-Google-Smtp-Source: APXvYqxAXLFzS6e1uHJOkGKuUKH4syBdGutgLsnCvPMkTMI9Cv5OIx4fObe+2P64lD6bn+Fh2SQq/A==
X-Received: by 2002:a81:3a06:: with SMTP id h6mr8962704ywa.170.1580047776433;
        Sun, 26 Jan 2020 06:09:36 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id a12sm5237214ywa.95.2020.01.26.06.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 06:09:35 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     han.xu@nxp.com, Adam Ford <aford173@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] dt-bindings: spi: spi-nxp-fspi: Add support for imx8mm, imx8qxp
Date:   Sun, 26 Jan 2020 08:09:11 -0600
Message-Id: <20200126140913.2139260-4-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200126140913.2139260-1-aford173@gmail.com>
References: <20200126140913.2139260-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for nxp,imx8qxp-fspi and nxp,imx8mm-fspi do the bindings
document.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
index 2cd67eb727d4..7ac60d9fe357 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -2,6 +2,9 @@
 
 Required properties:
   - compatible : Should be "nxp,lx2160a-fspi"
+			    "nxp,imx8qxp-fspi"
+			    "nxp,imx8mm-fspi"
+
   - reg :        First contains the register location and length,
                  Second contains the memory mapping address and length
   - reg-names :  Should contain the resource reg names:
-- 
2.24.0

