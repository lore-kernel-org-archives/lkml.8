Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D29C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E29C2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBRNtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:49:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:35526 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgBRNtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:49:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 05:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="268760941"
Received: from unknown (HELO srivasta-NUC7i7BNH.iind.intel.com) ([10.223.163.113])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2020 05:49:07 -0800
From:   Shobhit Srivastava <shobhit.srivastava@intel.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     furquan@google.com, rajatja@google.com, evgreen@google.com,
        andriy.shevchenko@linux.intel.com
Subject: [PATCH 0/1] Enable SSP controller for CS toggle
Date:   Tue, 18 Feb 2020 19:19:05 +0530
Message-Id: <20200218134906.25458-1-shobhit.srivastava@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


SPI CS assert may not always be accompanied by data. There are cases
where we want to assert CS, wait and then deassert CS. There is no
clocking or reading required. On Intel CNL LPSS controller, it was
observed that the above flow is broken after an S0ix cycle. There
is no issue after S3 flow.
https://patchwork.kernel.org/patch/11377019/ is an attempt to fix
this and it does fix the issue. However we are unsure if that is
the actual rootcause for the issue. As per the LPSS spec, to
propagate the retained CS to output,  SPI controller needs to be
enabled. The below patch tries to do the same and it fixes the issue.
The reason why there is no issue after S3 flow is because during
resume, BIOS re-initializes and enables SPI before doing kernel hand-off.
To test this issue we are probing the SPI_CS line on CRO. This is
because, even though the mmio writes to CS_CONTROL register sticks,
it doesnt toggle the CS line. Physically probing is the best way
to identify the fix.


Shobhit Srivastava (1):
  spi: pxa2xx: Enable SSP controller for CS toggle

 drivers/spi/spi-pxa2xx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.17.1

