Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD530C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFB7207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn1m888v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgFMWIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMWIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 18:08:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF21C03E96F;
        Sat, 13 Jun 2020 15:08:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so13534777ejd.13;
        Sat, 13 Jun 2020 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFwM9eMIugQqVr1lzeb1hUV6KdfGNOsIPEThUz0xWw8=;
        b=Dn1m888vkM7N+KTjvgHD3PykUMll8FA5bz1Up4dPhOE6/lzd5BqzDd4ytB9w/AyHqT
         //iU+2dlWgUx4AJIkHSu7H7SaLOvg8c5TnGI/eJXm1DlkkREgYMQOyrc/Rr/6zzRDgMi
         DdzmOeHPNM1S6aHl0vLMzccqWmT5QRlYj9+9UQ/k7T7zdBFkRgu8C1/SlSRLFI0Nudss
         n345v59GHXSyXxJQPNwPFCdQ9q+zeEwu4W77S/DpPFPZckH8rXU8ppryoPoLGptuxwFu
         ad5zmj+xWDgAES50Iz3eAaUzttLkwdm/I7jqxRhucgDfI4OnRnDetz4MJQPHM/sZUo/X
         xKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFwM9eMIugQqVr1lzeb1hUV6KdfGNOsIPEThUz0xWw8=;
        b=DGHT4R3wHC5lC3BeMBQXOnYqQ7oEvCfhBGV8mApFqZ+iYQSE4lgQLaaROKCe3meHi7
         L51ms4i4U+ErV4o18RwntidNbZgi7gVwwTDcSmWY+zkkyzWd4yP6S9lkHt/Z8Nlrn8JS
         U4k+RBtV3HA8Zb1FJx7WKyIvVhg4iF15jURz1tV3jdTbTsBVjxkzcz18rPHc5so6qJNV
         Q5GRw1qSlyjCUiRhjX0KYl/GFYiDRw6mWzL2MjXV88tSINow2GH/jge4EBRaloRYg6ZN
         dnneSxzpPoFlmJlVSmfz7/kIifnt30hel9Mk8hDE739BiFl2P7+vuJ3iUQMpFD4pHZYS
         x+YA==
X-Gm-Message-State: AOAM533Se+QjTJEcrP3A4m6SoKPPIF62ufJ7Btn8MQPhTi1rf++eOiJB
        qGHSUgt4LaI8+xFW+VMDcvq5ehjE
X-Google-Smtp-Source: ABdhPJyPWAcNIekp1P8doyLkD7jhyQtYuap6gECNKAHQ1KMEAfL0d+QdbDbpzmt+iUgpTvoTmWCYxQ==
X-Received: by 2002:a17:906:6403:: with SMTP id d3mr18783095ejm.386.1592086115860;
        Sat, 13 Jun 2020 15:08:35 -0700 (PDT)
Received: from localhost.localdomain ([188.26.56.128])
        by smtp.gmail.com with ESMTPSA id kt10sm6044774ejb.54.2020.06.13.15.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 15:08:35 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     UNGLinuxDriver@microchip.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] MAINTAINERS: merge entries for felix and ocelot drivers
Date:   Sun, 14 Jun 2020 01:07:53 +0300
Message-Id: <20200613220753.948166-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The ocelot switchdev driver also provides a set of library functions for
the felix DSA driver, which in practice means that most of the patches
will be of interest to both groups of driver maintainers.

So, as also suggested in the discussion here, let's merge the 2 entries
into a single larger one:
https://www.spinics.net/lists/netdev/msg657412.html

Note that the entry has been renamed into "OCELOT SWITCH" since neither
Vitesse nor Microsemi exist any longer as company names, instead they
are now named Microchip (which again might be subject to change in the
future), so use the device family name instead.

Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 MAINTAINERS | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f08f290df174..621474172fdf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11339,14 +11339,6 @@ L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/at_xdmac.c
 
-MICROSEMI ETHERNET SWITCH DRIVER
-M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
-M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-L:	netdev@vger.kernel.org
-S:	Supported
-F:	drivers/net/ethernet/mscc/
-F:	include/soc/mscc/ocelot*
-
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
@@ -12305,6 +12297,18 @@ M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	tools/objtool/
 
+OCELOT ETHERNET SWITCH DRIVER
+M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
+M:	Vladimir Oltean <vladimir.oltean@nxp.com>
+M:	Claudiu Manoil <claudiu.manoil@nxp.com>
+M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	include/soc/mscc/ocelot*
+F:	drivers/net/ethernet/mscc/
+F:	drivers/net/dsa/ocelot/*
+F:	net/dsa/tag_ocelot.c
+
 OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
 M:	Frederic Barrat <fbarrat@linux.ibm.com>
 M:	Andrew Donnellan <ajd@linux.ibm.com>
@@ -18188,14 +18192,6 @@ S:	Maintained
 F:	drivers/input/serio/userio.c
 F:	include/uapi/linux/userio.h
 
-VITESSE FELIX ETHERNET SWITCH DRIVER
-M:	Vladimir Oltean <vladimir.oltean@nxp.com>
-M:	Claudiu Manoil <claudiu.manoil@nxp.com>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	drivers/net/dsa/ocelot/*
-F:	net/dsa/tag_ocelot.c
-
 VIVID VIRTUAL VIDEO DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
2.25.1

