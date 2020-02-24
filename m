Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF9BC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D901D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiQNjaSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgBXRcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:32:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36950 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgBXRcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:32:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so11066763ljm.4;
        Mon, 24 Feb 2020 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n0uZMijXsC91Xryq6DgXAa7vxPjWgqP9Mwyhc//NHro=;
        b=KiQNjaSfaJLMdMhEFAcD1rxWt+6Je4jBxrDnEz7cx0+evqQ6l5RBt1pCt13mYdRIWe
         iJUUvyHM6xsq8OowZjjKxBmSqonGJ42m8rIBN7vy9vCrjoeweXwkE3mEJdIgfeqkLHY3
         dEMGvxDX1DMMD4C6rF4DCUEtaJ+ZWi7fw5oZgG5CIaC+y00/SLf6LY7OyAaKUaG+1/P4
         m1HeofsOKllMNYsRphjBNKwtJLeqbrIL7xqlCVuVMNCnBHWjtcf0rqQNSrZ6OlxNpakl
         DIIXJBvI7MvtxavNJIVJRpKIE+xGmDaaN39+E+uFkZOUDgLU4YFrQY0SAN/a7XK45VyZ
         TvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n0uZMijXsC91Xryq6DgXAa7vxPjWgqP9Mwyhc//NHro=;
        b=CIBpMvgHZF2Gpxo+yh733r/SUFmDjz7OPD/kiGbIbYDEMM8BOJh6sX31ymb5sSP4BF
         xSzZvAqF0J8bLa+MJYw8ekt5oLXdYabxCJMvLsQJJXr/CdwLM5FvQqZyu8Kar0rk0sxd
         Mmd184yOPK62Myd4177SONsNaJPYil/4nWPqLKDFhfd2J4xCtGVlS6s6bk1Q3mgcYrQ5
         UstA+olErupWdtQNcP7if0F3xjSwiyy2o9ApmimfFWmnFM0K6Ad01x2ueXQjO55wQSkV
         GAY9n8+kXFGrezC4IPnCiEHFWM+4CsaugxOyKESDVLcppWh9nenoWNUpkz+kg/bcCfF/
         zAHA==
X-Gm-Message-State: APjAAAWp+sOPNY0Yy41zU/ntPLYO9esosv/SXSCdrlmjtdce11UtAcOJ
        DzQvlyth1enenHOLVlNaR8Y=
X-Google-Smtp-Source: APXvYqxDJhJvKvHSYzF1Y+jEygZrBmenl+5cRQ7+H5Aj/GZGjqfjIQFOz3NL++koHTXdDyTCIPIVxA==
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr31431761ljg.166.1582565565196;
        Mon, 24 Feb 2020 09:32:45 -0800 (PST)
Received: from localhost ([194.44.101.147])
        by smtp.gmail.com with ESMTPSA id d9sm168025lfm.16.2020.02.24.09.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 09:32:44 -0800 (PST)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     philippe.schenker@toradex.com, marcel.ziswiler@toradex.com,
        stefan.agner@toradex.com, max.krummenacher@toradex.com,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] arm: dts: vf: toradex: re-license GPL-2.0+ to GPL-2.0
Date:   Mon, 24 Feb 2020 19:32:28 +0200
Message-Id: <1582565548-20627-5-git-send-email-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Specify explicitly that GPL-2.0 license can be used and not
GPL-2.0+ (which also includes next less permissive versions of GPL)
in Toradex Vybrid-based SoM device trees.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 arch/arm/boot/dts/vf610m4-colibri.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
index 2c2db47..75c6d82 100644
--- a/arch/arm/boot/dts/vf610m4-colibri.dts
+++ b/arch/arm/boot/dts/vf610m4-colibri.dts
@@ -1,7 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Device tree for Colibri VF61 Cortex-M4 support
  *
+ * Copyright (C) 2020 Toradex AG
  * Copyright (C) 2015 Stefan Agner
  */
 
-- 
2.7.4

