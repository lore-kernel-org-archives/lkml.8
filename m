Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE6FC3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352832469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRLJ3DCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgB0Qwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:52:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42107 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbgB0Qwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:52:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id n18so3777274edw.9;
        Thu, 27 Feb 2020 08:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivstkqAc2jBTEhbTH0moaUv+ywd1mANmLsnT4sGxaf4=;
        b=oRLJ3DCLUdlQ8CO7KWH+bg60QqHSKOVPuWAk0vqDM5EdwmNloknnBn142+nMTNQoPm
         b3p/S8pPec8UQukUYQhvGLDq0LfDQUFkVjE+P+mW2f2DJpWSRx0Y2jwbYHvu00LrH3Vo
         AXhpY5mFgmqS3K5euSDd2b+8xwFk/XxLZoadkoig2Q5M1KkXtxCfhHU3aUeGbjp4yg0H
         2gaZdORkbNCqiFRA4FDP+/kkCpvuJzSVtaVg1okPbuVvvlTMntUcSI6nrT05VqbvRKks
         sibhYxGQAAYOA/StYtTXVn2DBl4XmQBhyiNxEZkjWfRRojQ3d4CeXXnltmXtfr68vnYN
         +mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivstkqAc2jBTEhbTH0moaUv+ywd1mANmLsnT4sGxaf4=;
        b=PD3uR38TBknSJrd/OMPEhUvv1iCC7eRs9HlPiUBknVJ8ushiL139KST6k5gDC7yU8S
         yvJivitkd2IyyB7Gcag8hLfBmdL0+8hLi2Xw2B5Yah6000/EL7DcYCnzx+qxgs8iVNRl
         mOlJ2o3/8mq780DQRM5e5P8ll4M0rIFapvpE77+exW+75icZmaqoZ5Rh1/sSEVGQKQiY
         9AWwBhXLijnn6cs8CmEZAksCGweHj6cYmExz1Dzv+eb+yrazrl8Ta07qJIFzvlgtt2Wh
         vx1HJFKcWRC7Tkd1buGSW8Zb3lTiub3kecif1Rv2zXRzLO8CBcRmDZ+ee5lT3nwmfRAr
         IA3Q==
X-Gm-Message-State: APjAAAXuUvzgofv3uwD+rxGom6oie0n1injwkWSWH0puBFonFyOFEWS6
        Sr9YcUK1F30V0252G5qeqb0=
X-Google-Smtp-Source: APXvYqwMntBRGuKgTGlUYF8FPtdnWphoE5YRSZavfhj8926aPLeCq19BiEK36bddRONndGmfKDXyvQ==
X-Received: by 2002:aa7:c552:: with SMTP id s18mr5325160edr.331.1582822361093;
        Thu, 27 Feb 2020 08:52:41 -0800 (PST)
Received: from localhost.localdomain ([5.2.67.190])
        by smtp.googlemail.com with ESMTPSA id f13sm388541edq.26.2020.02.27.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:52:40 -0800 (PST)
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
To:     jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: espressobin: add ethernet alias
Date:   Thu, 27 Feb 2020 17:52:32 +0100
Message-Id: <20200227165232.11263-1-tmn505@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maker of this board and its variants, stores MAC address in U-Boot
environment. Add alias for bootloader to recognise, to which ethernet
node inject the factory MAC address.

Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index c8e2e993c69c..42e992f9c8a5 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -11,6 +11,12 @@
 #include "armada-372x.dtsi"
 
 / {
+	aliases {
+		ethernet0 = &eth0;
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.25.1

