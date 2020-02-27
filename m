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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFE2C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BC3246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr9HQW5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgB0Qs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:48:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44808 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbgB0Qs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:48:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so4010299eds.11;
        Thu, 27 Feb 2020 08:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eyvg065g0/euNZVm3LdEpqtwEZkQRrm2w5Fpig4SXd4=;
        b=Mr9HQW5NJWNHat6l1myE6wZLLZoDTDoOq8YyZclRM9kwFT4rVbP3k7sLI6QISjU3G4
         4dBZDFPEkNhiOEBBrRxZ0EiGRtNfkaWJjaKkm+Y/7A9k0hqRybWrbBxQimdOhuOvPAmQ
         fjUB7THLlrA7gdfOzfGw1lO8OW4wRV57zGg84DkX0rE80eb+Kip/7znycCuPEalEkx4B
         XDJIiWy4S+sQKVHaa2oF3uddMdwHMHfzaSHZwQP9w18sy5LiJQiDUVx3VY3JLIlnn7xx
         Lkoo6YMCsvQAL8BLTYUYyCtCwCFxGx5yIDBCptsnM31rlqEyDLEC+gq9ra2CeewiFR4N
         BCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyvg065g0/euNZVm3LdEpqtwEZkQRrm2w5Fpig4SXd4=;
        b=kLuumIRA40eFmodw1NkDzd1OYwQs3LhdifO4GUKmFYYnrkQGZBuwvKjIJJYiajWm6J
         YgyfjkGVw05D0PeUS3spmmHwl8Iaw7rwHH//7MFNkUSMBA5ysmUK+Om5jZgwNN+FtW7D
         8ACV+5PMakmkQpIfMu6m93tvc1QkM5/AKZDUObqzt/1pDeLas4zM4vT3Sd82afrGltwO
         2Y1UMJD2eR+CdOG2iVxbgMpYlo2F+EitCCkZPE+fE1GsanpGuZkGRf/iDOXreIGloq4v
         FMmiGk/9HGkJnI10WD70VzsTmbfevqSN6N8D6qyHennb+arz7u6lQ+HMmfXyaGWZa1tV
         GDWA==
X-Gm-Message-State: APjAAAVC9MWT4aLewbasS2jm5VtQ80cXf6dQ7s6Pi3gdwbD5SwKi1JOO
        P0e8ZcKb6nQX3Khbz29rYGZ/bBDfMCkzTw==
X-Google-Smtp-Source: APXvYqzLLozlNz92t5BtswquB9rtniU6OhbYmfbX3YxneKTC3x1oqZdBOiYukUAl1LYuCO5rwHGalg==
X-Received: by 2002:a17:906:5208:: with SMTP id g8mr21431ejm.104.1582822135185;
        Thu, 27 Feb 2020 08:48:55 -0800 (PST)
Received: from localhost.localdomain ([5.2.67.190])
        by smtp.googlemail.com with ESMTPSA id d2sm107455edr.97.2020.02.27.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:48:54 -0800 (PST)
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        gregory.clement@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: marvell: build ESPRESSObin variants
Date:   Thu, 27 Feb 2020 17:48:42 +0100
Message-Id: <20200227164842.11116-2-tmn505@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227164842.11116-1-tmn505@gmail.com>
References: <20200227164842.11116-1-tmn505@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adding ESPRESSObin variants didn't include those in Makefile to
be built.

Fixes: 447b878935 ("arm64: dts: marvell: add ESPRESSObin variants")
Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
---
 arch/arm64/boot/dts/marvell/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index f1b5127f0b89..3e5f2e7a040c 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -2,6 +2,9 @@
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7-emmc.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-uDPU.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
-- 
2.25.1

