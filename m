Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3821BC5ED43
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E59320801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813224;
	bh=xvG7Q9c1TnSbn9EvpuDSAZA0zsykoYXqY9kglk0SCtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qx5klZfmRZYEi0RRuUxUVIWBHt8sJd3wl99cMhtdfF/1+AQ+PmHsb7SNRYVjpfXcz
	 k5W9vhQe/FT8ZwrTt/ZXIpDFXDW6dLcNRcYvsGpcdxIxXu07i7LVnfWuMUPdlJM0C3
	 BAAaNkZ6kwWNeFERjKTuD7P81A9sP2Pwt+WXpzW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbgB0OSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbgB0OR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:17:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC0024690;
        Thu, 27 Feb 2020 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813077;
        bh=xvG7Q9c1TnSbn9EvpuDSAZA0zsykoYXqY9kglk0SCtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKIhxnhnCFztMjQjajgKIXV6SDL6bnZOygRU7oHaAt/42fjOnFxJKkd8t0Re4JVR3
         k/TJIGR3TdRVLGRLho/Fm1Wfv5tzm5At/cGFqoENpAwzNHuMEf32XmsfhqiNoeMUpp
         E4VPeLYOiGP2iKtaveTeBR2wiwaaeYhVEoBBKToc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.5 128/150] iommu/vt-d: Fix compile warning from intel-svm.h
Date:   Thu, 27 Feb 2020 14:37:45 +0100
Message-Id: <20200227132251.494825863@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

commit e7598fac323aad0e502415edeffd567315994dd6 upstream.

The intel_svm_is_pasid_valid() needs to be marked inline, otherwise it
causes the compile warning below:

  CC [M]  drivers/dma/idxd/cdev.o
In file included from drivers/dma/idxd/cdev.c:9:0:
./include/linux/intel-svm.h:125:12: warning: ‘intel_svm_is_pasid_valid’ defined but not used [-Wunused-function]
 static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
            ^~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Borislav Petkov <bp@alien8.de>
Fixes: 15060aba71711 ('iommu/vt-d: Helper function to query if a pasid has any active users')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/intel-svm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -122,7 +122,7 @@ static inline int intel_svm_unbind_mm(st
 	BUG();
 }
 
-static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
+static inline int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 {
 	return -EINVAL;
 }


