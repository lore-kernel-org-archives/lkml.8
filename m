Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,WEIRD_PORT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E33C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C1D207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHLMZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:25:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:55658 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgHLMZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:25:29 -0400
IronPort-SDR: mLkhHWXda9mWsPCnYk8BXuRdokxp6Xa8iIvnDU6Hndkg/ps06y0qsyYWzh6lnqahgkmdFgVHvY
 Ubd6G80MailQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="171981796"
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="171981796"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 05:25:28 -0700
IronPort-SDR: ywOfK2caexNoohfyuZvwPSk1dgtzJ6fZdA5v/MlqFPpcNGrWClgz2M45Tvihkln04HSWBEymfi
 TfkZqnwWzDSw==
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="439376747"
Received: from lhawrylk-desk.ger.corp.intel.com ([10.249.154.220])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 05:25:26 -0700
From:   Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
To:     ning.sun@intel.com
Cc:     Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Intel TXT maintainer
Date:   Wed, 12 Aug 2020 14:23:44 +0200
Message-Id: <20200812122401.1751885-1-lukasz.hawrylko@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an effect of changes in Intel, I took resposibility for supporting
Intel TXT in Linux from Ning Sun. This patch also replaces link to
repository, as previous one became outdated.

Signed-off-by: Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e627ed60d75a..cc70a40bba20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9039,11 +9039,11 @@ F:	drivers/hwtracing/intel_th/
 F:	include/linux/intel_th.h
 
 INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT)
-M:	Ning Sun <ning.sun@intel.com>
+M:	Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
 L:	tboot-devel@lists.sourceforge.net
 S:	Supported
 W:	http://tboot.sourceforge.net
-T:	hg http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot
+T:	hg http://hg.code.sf.net/p/tboot/code
 F:	Documentation/x86/intel_txt.rst
 F:	arch/x86/kernel/tboot.c
 F:	include/linux/tboot.h
-- 
2.25.4

