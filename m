Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E263DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B8220748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="tIdgZ4jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgGXKjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGXKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:39:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900DC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:39:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so7527921wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHdxCCtAxsdNwqWlZsmsaGSLGhK0kJ1tZwNHB/8rXdk=;
        b=tIdgZ4jRKnl2bMPcLNVW/J5K2vucpsFanUiuGE0dj7qI6OuHBFwQ0YTvsavb5PGxJH
         7iviGrpxVB9I64dglOC9k10owGp0JQK1BcGf++uyseOI1foE5kdP0SBDSrZ1BdkBFBMh
         VpLqQPzj1D/8LDIJaDHc+Zjpmz2TIgYfYG7qamjgIE103m/8tN+QUy28sN0lDZYJPIjo
         uTsJH5SvG42gUiVvuoGUy0uTm4vnQXImAo2Z7igZxsi0EmBwiwT62ejg31nMOc7x4urX
         IBVlkNDBhd+W8XDEodt9QM9h1CrRMa71fgly9h87QpJeLvyRjecHcqsCBSm5a+gghItF
         SiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHdxCCtAxsdNwqWlZsmsaGSLGhK0kJ1tZwNHB/8rXdk=;
        b=PHXnkCRR94qN6RMTDvYYFebFpbE2GhgZD9v6SXqs2dVY60NIUB2T0QcksJs0IX/20a
         cTlKiJue8SdrYlNg2u4zN8YgOv5vIk6qCv73hRCAj+w9OtvT9/yhkdQFpzcsra4qzpTO
         gWNoy/AfFfF3UcI5Hvtq+tJSmXsSlF218EA6FQmjb2qtZupE/pVT1RTfoMQd4edrXKCR
         o7fNaQUQskJIafMRT2QrGFWEvVuOHcG/t81Z+xCaMAQetS10LWL0BZgmVlf7L6CoZF3p
         Aajb5jhIyraGxaivjaTm/FTGCv4B6P2BZR7HfaomePZgxy6Kr7cvvMeix9I8McJn84/h
         vUOg==
X-Gm-Message-State: AOAM533IH9082yfTaXvZfcURAU6AJGGvdRXqjewfMAz0rZwyraqBNzVi
        bfNRIdV0THPIcBbsUMuskglEcg==
X-Google-Smtp-Source: ABdhPJxIOWOQAngZE4YY/7+tg8Tk9gtgWe22Fj9tsgMyjTga8VbFtaphwOr0BR2V8nOYGX+qNMsUHg==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr8288923wmk.34.1595587141483;
        Fri, 24 Jul 2020 03:39:01 -0700 (PDT)
Received: from lukakovacicapc.local ([2a00:ee2:4b0d:3001:fbc5:498b:ed6d:cfac])
        by smtp.gmail.com with ESMTPSA id f186sm6526280wmf.29.2020.07.24.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:39:00 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        Luka Kovacic <luka.kovacic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: [PATCH 4/4] MAINTAINERS: Add an entry for MikroTik CRS3xx 98DX3236 boards
Date:   Fri, 24 Jul 2020 12:38:40 +0200
Message-Id: <20200724103840.18994-5-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724103840.18994-1-luka.kovacic@sartura.hr>
References: <20200724103840.18994-1-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An entry is added for MikroTik CRS3xx 98DX3236 based switches.

Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Jakov Petrina <jakov.petrina@sartura.hr>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d53db30d1365..9da194a33b7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11402,6 +11402,17 @@ M:	Oliver Neukum <oliver@neukum.org>
 S:	Maintained
 F:	drivers/usb/image/microtek.*
 
+MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
+M:	Luka Kovacic <luka.kovacic@sartura.hr>
+M:	Luka Perkov <luka.perkov@sartura.hr>
+S:	Maintained
+F:	arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
+F:	arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts
+F:	arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
+F:	arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts
+F:	arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts
+F:	arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dts
+
 MIPS
 M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-mips@vger.kernel.org
-- 
2.26.2

