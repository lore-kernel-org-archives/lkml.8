Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA401C47409
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8824620678
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579866176;
	bh=J9LrM+mqGbcrpIkt45gy+cmh4PRT0m+5ViQ6Wmc9K0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R107hAC5QaSbw5OGNJ3PnuM0jYLhrty+fp359wUhha/TXtSh550IEiOBm0vgCpBgc
	 /UeQz7qCT5eKyN8P/XdmYg+4vXAq7hukjmk/wT1+HXVkF/gpff8dq7+l1nax2eGgoq
	 F2g3uBUsc3N0vQG+KIqozZhifhHDGH9JvhKkSceE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgAXLKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:10:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732785AbgAXLKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:10:44 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D0E420708;
        Fri, 24 Jan 2020 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864244;
        bh=J9LrM+mqGbcrpIkt45gy+cmh4PRT0m+5ViQ6Wmc9K0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2V/pfGtH1CK4zc/0YhfdeOIR4rcXcdUd1o8CM4M3wO94sAPtrvkVHBDYltX++qWcr
         vQ85zKsofvp9qIJ1ojiZVGrR0jDm6eOsc+fEthTJnwJaO0o0T2q95KQ4Tkovtnu6Ye
         gTD11xdvk8UZeK2n37YYwZ1cBc6/cGdh25PKCi0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 204/639] media: sh: migor: Include missing dma-mapping header
Date:   Fri, 24 Jan 2020 10:26:14 +0100
Message-Id: <20200124093112.576752048@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

[ Upstream commit 5c88ee02932a964096cbbcc7c9f38b78d230bacb ]

Since the removal of the stale soc_camera headers, Migo-R board fails to
build due to missing dma-mapping include directive.

Include missing dma-mapping.h header in Migo-R board file to fix the build
error.

Fixes: a50c7738e8ae ("media: sh: migor: Remove stale soc_camera include")

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/boards/mach-migor/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 254f2c6627036..6cd3cd468047c 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2008 Magnus Damm
  */
 #include <linux/clkdev.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-- 
2.20.1



