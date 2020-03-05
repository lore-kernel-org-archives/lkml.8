Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED929C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5C520637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgCEQzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:55:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:17958 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgCEQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:55:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 08:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="229756664"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga007.jf.intel.com with ESMTP; 05 Mar 2020 08:55:43 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, mdf@kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH 0/2] Patches for firmware 
Date:   Thu,  5 Mar 2020 11:12:24 -0600
Message-Id: <1583428346-13307-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Hi Greg,

Please take these 2 firmware patches, which are changes for Intel
Service Layer driver.

Those patches have been reviewed on the mailing list and applied cleanly
on current linux-next.

Thanks,
Richard

Richard Gong (2):
  firmware: stratix10-svc: add the compatible value for intel agilex
  firmware: intel_stratix10_service: add depend on agilex

 drivers/firmware/Kconfig         | 2 +-
 drivers/firmware/stratix10-svc.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4

