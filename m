Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D1C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A69B2467E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeDzCCaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgA0XzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:55:13 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56515 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgA0XzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:55:11 -0500
Received: by mail-pf1-f202.google.com with SMTP id h16so7453415pfn.23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4KjA2O3e5WfLc30wyB/HF4idXFgGIVfHNa/bFpMvIf4=;
        b=jeDzCCaf1mffpWsNrUWt3r7/AOzqb0HR4TMgu+vUxItxw6dM6qGy/RsJMXmJ6WYtdX
         7H8qxJXbYGCxHSQx3QtCpcOzkdM45i3w9usgyo/DrZsvjkKUMrf4ydiONm+ks/OZxmvr
         3NdNCDOAf2Ml6HAvOos5npaI8Mv3di0sVVio3OCZp7bEC1JysLrZEbnWde7rnyJwnHi/
         +/mzZWV6qyHFvgt3m00Et6fna971JpKrXzOX23GkJhQTJnCNsxnJA1w8wXDW5VNmEzDW
         tS2PA0lJg4Pka6yL4zllgKJA7fgCr3xDBatOSLX0vWRq+yM/k362tyJzSFjiQso3iRXx
         vQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4KjA2O3e5WfLc30wyB/HF4idXFgGIVfHNa/bFpMvIf4=;
        b=hpPtmkZgU3QcWPCoJhS5zaJhf3iZndDdwrdJjupRHYPRhtjs39qMZhlxFRel+Stv+G
         txE/FZqf+x4/1tO7xMyMdHd7NGCbkdJu1p8SFnVOFfmlL4+JHLjNSjEjIxFDuJPkBOK1
         vfvcMzQx1ylmBk9ZXPdTHzqwsgt7MXtsM0M3BIRPGef6li/rL5BBvsvK5oW8WR64itjl
         Z2k9VNNnjhgRsdirr0j2Wc4n/6pM7l+jZZyDy5gg32DJxQEc+vGiNh2OKJqiNQ+yIbrw
         CEDm+OyeXfpGfcHkNKHqvsFsJwbCNoquZ+W4dMH3Fr1cwUqKuqO9ctn1rgnGTJuXfpDr
         lTfQ==
X-Gm-Message-State: APjAAAVRFy4ckSMoz9kWsmuoGgT3bzdgHrAaHaPpV9AGeGjBKrUcuVpd
        Pii5mvwz6tbEYOPB12H2F5UB5bNKHIG0zY4hJCoinA==
X-Google-Smtp-Source: APXvYqxX2cTYOYi/6gfypjziF+v7JoXLJYFHxYRZUMf0IT3deC7wiZG5csxN84jPhbo7NcVApT5J2LUA/tX8yW3rQK9e7g==
X-Received: by 2002:a63:d041:: with SMTP id s1mr22025574pgi.363.1580169310297;
 Mon, 27 Jan 2020 15:55:10 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:53:55 -0800
In-Reply-To: <20200127235356.122031-1-brendanhiggins@google.com>
Message-Id: <20200127235356.122031-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127235356.122031-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 4/5] ptp: 1588_clock_ines: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Richard Cochran <richardcochran@gmail.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_PTP_1588_CLOCK_INES=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

/usr/bin/ld: drivers/ptp/ptp_ines.o: in function `ines_ptp_ctrl_probe':
drivers/ptp/ptp_ines.c:795: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/ptp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 475c60dccaa4f..17e670fa1d4c8 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -80,6 +80,7 @@ config PTP_1588_CLOCK_INES
 	depends on NETWORK_PHY_TIMESTAMPING
 	depends on PHYLIB
 	depends on PTP_1588_CLOCK
+	depends on HAS_IOMEM
 	help
 	  This driver adds support for using the ZHAW InES 1588 IP
 	  core.  This clock is only useful if the MII bus of your MAC
-- 
2.25.0.341.g760bfbb309-goog

