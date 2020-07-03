Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9787C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8D020781
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGCC0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:26:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:51259 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGCC0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:26:30 -0400
IronPort-SDR: O7lf2elbCikiZsf1mE15oQGKyA8B7OQ6nLVtCnPPdFHe3HdR/6PJdJ9a7JRxWwAtGU7I8cljYM
 zOYZu63i5z6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="145212917"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="145212917"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:26:29 -0700
IronPort-SDR: 0Ve5FLC4SNoprdrxVntJ9NtWXdCSqMWN4SXOc6Mn+7Lvs65qxvNtZmIUGXSB1lmJ3/+3AL02E4
 8UAJk0IGGPuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="455734093"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga005.jf.intel.com with ESMTP; 02 Jul 2020 19:26:29 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Cornelia Huck <cohuck@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH] vfio-ccw: Fix a build error due to missing include of linux/slab.h
Date:   Thu,  2 Jul 2020 19:26:28 -0700
Message-Id: <20200703022628.6036-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include linux/slab.h to fix a build error due to kfree() being undefined.

Fixes: 3f02cb2fd9d2d ("vfio-ccw: Wire up the CRW irq and CRW region")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

Encountered this when cross-compiling with a pretty minimal config, didn't
bother digging into why the error only showed up in my environment.

 drivers/s390/cio/vfio_ccw_chp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index a646fc81c872..13b26a1c7988 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -8,6 +8,7 @@
  *            Eric Farman <farman@linux.ibm.com>
  */
 
+#include <linux/slab.h>
 #include <linux/vfio.h>
 #include "vfio_ccw_private.h"
 
-- 
2.26.0

