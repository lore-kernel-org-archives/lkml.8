Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EA5C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4692072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="W2udFh6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgIENGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgIENFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:05:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B77C061260
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:05:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so12018655ejr.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xl1nZLcljWKorqUvDwgUa0UsWvHQM15ZTxSDh1SpSqY=;
        b=W2udFh6H0fGb8JExN0UWSQKlS1DXkIQk+M5Vh1Bxng3XsDPo+2GqxNedSbYBRa9sY/
         1Xw9OqrUfNym3M8yBAkbzDm0OdHQ8Y2dHfZ5Uqjo327lfiEZE67lQZIqRDyLH6miYfC3
         7qakdhViyk3tnojIH5yqWu54lCBmzLfEVg0/nS/PnlFP+JV7eIiT+/9hrzXrVbVAdbLY
         3J9oNt2uvtxvJBo1pn6qRA1NQp/2HettB/EQEqaPGi4ml4GMzZTboxIWt4R+aT/td1yi
         T/EWJHY4aE09QaFf78AT3i+nStB7is6zb8SMi5WhSuMMGAg7cO8fRchx3fa+Jc2Dqmi5
         e1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xl1nZLcljWKorqUvDwgUa0UsWvHQM15ZTxSDh1SpSqY=;
        b=A2bGNg5ZdgBYl3dfUl0SnLi5UollF9ZXBlr7MTk5ba5JTVQxLQ+QgarDS0Hsi85I16
         iS9Ir9pwE4komRKXp14z/qeJYbX+pWBftOiJqYJjgEts7iZ9cg7Ohg7dLy9s/aDymenz
         olDjvCaKasI/krT1JoCAC10m3QKXQ12rMtCxMxr8goMxUgadbu3ypZ2xYTvKyfYK2LuI
         +5STXaBq7X3/gVxC8L3ybO7mK6Fr8hSlRiyUIOvoWMjfTi0M/NtLqiGzORpH44NHYPkL
         21Zq8ArhQ56JkDDGjDhaxYHXVwAixvp+z5YUaWiSSJsyH2BFgNYQwBUvfjtsLVttgj2/
         XmRQ==
X-Gm-Message-State: AOAM530Y8OlfWbXYQhxTqR42uDwux07GcXl2AjpeQPRU2M7ZmNl2tDpW
        5EWhT1iA+JzU1z8+1q+m+uGEDnYDosv78tt/7uNVqDMtMVM+chQ0cU9vpj41c39i2N8DPk4QVM2
        cNaciFYWUracRi0Sa5GkQ6o6IX39/Eyshsej3p5ZEQOpbdCPLx7kR02k3J4yFpbJoTJXPYQK5bU
        ziJRFFhs/fKQ==
X-Google-Smtp-Source: ABdhPJyn57saXGT3ibN2UnRya8QVjZ6lQI//dqkrhaGWTC5szTQdkMmJg4BwGuFqYw4OfEn6NtZA7g==
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr12101849ejx.213.1599311151406;
        Sat, 05 Sep 2020 06:05:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:ee2:4b0d:3002:290:faff:fe54:449c])
        by smtp.gmail.com with ESMTPSA id s18sm9372655ejd.54.2020.09.05.06.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:05:50 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
Cc:     lee.jones@linaro.org, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        andrew@lunn.ch, jason@lakedaemon.net, gregory.clement@bootlin.com,
        luka.perkov@sartura.hr, Luka Kovacic <luka.kovacic@sartura.hr>
Subject: [PATCH 6/7] MAINTAINERS: Add an entry for the iEi WT61P803 PUZZLE driver
Date:   Sat,  5 Sep 2020 15:03:35 +0200
Message-Id: <20200905130336.967622-7-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905130336.967622-1-luka.kovacic@sartura.hr>
References: <20200905130336.967622-1-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the iEi WT61P803 PUZZLE driver (MFD, HWMON, LED drivers).

Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4647c84c987..01a85d753d81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8436,6 +8436,19 @@ F:	include/net/nl802154.h
 F:	net/ieee802154/
 F:	net/mac802154/
 
+IEI WT61P803 M801 MFD DRIVER
+M:	Luka Kovacic <luka.kovacic@sartura.hr>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/stable/sysfs-driver-iei-wt61p803-puzzle
+F:	Documentation/devicetree/bindings/hwmon/iei,wt61p803-puzzle-hwmon.yaml
+F:	Documentation/devicetree/bindings/leds/iei,wt61p803-puzzle-leds.yaml
+F:	Documentation/devicetree/bindings/mfd/iei,wt61p803-puzzle.yaml
+F:	drivers/hwmon/iei-wt61p803-puzzle-hwmon.c
+F:	drivers/leds/leds-iei-wt61p803-puzzle.c
+F:	drivers/mfd/iei-wt61p803-puzzle.c
+F:	include/linux/mfd/iei-wt61p803-puzzle.h
+
 IFE PROTOCOL
 M:	Yotam Gigi <yotam.gi@gmail.com>
 M:	Jamal Hadi Salim <jhs@mojatatu.com>
-- 
2.20.1

