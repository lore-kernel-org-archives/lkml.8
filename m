Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0531F20656
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG2LFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:05:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:49337 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2LFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:05:47 -0400
IronPort-SDR: HyOEsUpt/AxxptsfqCzCTP/xaPOPpE01CtFkoeRMI4kmL0FghL0t0bnmgVMOtWjiPACiu5rerI
 Fq1Decum+Veg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="148852198"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="148852198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 04:05:47 -0700
IronPort-SDR: kg/cJaFMDnNJa1D3qND0GmO9CQHVhp+QB/RAt7s6bwbWQKLglFZgcdkAKP/8A9yxqDTPDz+kpr
 /AaNOSD2XKoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="464822552"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga005.jf.intel.com with ESMTP; 29 Jul 2020 04:05:44 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Joe Perches <joe@perches.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [char-misc-next] MAINTAINERS: Fix maintainer entry for mei driver
Date:   Wed, 29 Jul 2020 14:05:40 +0300
Message-Id: <20200729110540.3205585-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mei driver has sub modules, those are not
listed via scripts/get_maintainer.pl when using asterisk:
drivers/misc/mei/*
The correct notation is:
drivers/misc/mei/

Cc: Joe Perches <joe@perches.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86994c35d56e..dbe6a71eb6f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8789,7 +8789,7 @@ M:	Tomas Winkler <tomas.winkler@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/mei/*
-F:	drivers/misc/mei/*
+F:	drivers/misc/mei/
 F:	drivers/watchdog/mei_wdt.c
 F:	include/linux/mei_cl_bus.h
 F:	include/uapi/linux/mei.h
-- 
2.25.4

