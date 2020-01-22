Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91636C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7272A2465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgAVHEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:04:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:11617 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgAVHEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:04:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 23:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; 
   d="scan'208";a="259360640"
Received: from pg-nxl3.altera.com ([10.142.129.93])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2020 23:04:39 -0800
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>,
        Loh Tien Hock <tien.hock.loh@intel.com>, Ooi@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO maintainer
Date:   Wed, 22 Jan 2020 15:04:21 +0800
Message-Id: <20200122070421.130524-1-joyce.ooi@intel.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to replace Tien Hock Loh as Altera PIO maintainer as he
has moved to a different role.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 MAINTAINERS |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a049abc..3401c4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,7 +726,7 @@ S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
 
 ALTERA PIO DRIVER
-M:	Tien Hock Loh <thloh@altera.com>
+M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-altera.c
-- 
1.7.1

