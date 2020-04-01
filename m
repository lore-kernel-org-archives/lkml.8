Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E22EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5002063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758704;
	bh=HyGQ6v8gAKW3CkXWuQUkHU+uBAL5bF2qT3VezlbZYDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R2kO1sMCisu+m5dZuXaGbU4VhG/98Quy5XdxEuDIeLEHjO28RxN6wu9U+CUxI/5RA
	 RowIAt2rYthZM1YembWRzpHI7ldFEQWRjtnz03DRMJkro9sR8Rd/tISZuo50E2FOST
	 9+RVWip/cYArDiLFubQImvNIG0JFMDpTChXZbr1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbgDAQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388300AbgDAQbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:31:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEFCB2063A;
        Wed,  1 Apr 2020 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758695;
        bh=HyGQ6v8gAKW3CkXWuQUkHU+uBAL5bF2qT3VezlbZYDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Od+ZTbT/9jq49WRJmSyeulxQMczALDJHWpc70ELfqMCsi6O0CKuQDaeW8sJvHFh7/
         xVxC03J3XMByGx0lj7n7CKJfMKe89Lra1JuE8Lvfrpt/QMXKNWRbjkiy/s+JlGSH6u
         JLLxCTF9u3MacHYWF4lsMEb4NjuFHiJ5XuXo6410=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.4 20/91] intel_th: Fix user-visible error codes
Date:   Wed,  1 Apr 2020 18:17:16 +0200
Message-Id: <20200401161520.020908854@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit ce666be89a8a09c5924ff08fc32e119f974bdab6 upstream.

There are a few places in the driver that end up returning ENOTSUPP to
the user, replace those with EINVAL.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: ba82664c134ef ("intel_th: Add Memory Storage Unit driver")
Cc: stable@vger.kernel.org # v4.4+
Link: https://lore.kernel.org/r/20200317062215.15598-6-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/msu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -483,7 +483,7 @@ static int msc_configure(struct msc *msc
 	u32 reg;
 
 	if (msc->mode > MSC_MODE_MULTI)
-		return -ENOTSUPP;
+		return -EINVAL;
 
 	if (msc->mode == MSC_MODE_MULTI)
 		msc_buffer_clear_hw_header(msc);
@@ -935,7 +935,7 @@ static int msc_buffer_alloc(struct msc *
 	} else if (msc->mode == MSC_MODE_MULTI) {
 		ret = msc_buffer_multi_alloc(msc, nr_pages, nr_wins);
 	} else {
-		ret = -ENOTSUPP;
+		ret = -EINVAL;
 	}
 
 	if (!ret) {
@@ -1164,7 +1164,7 @@ static ssize_t intel_th_msc_read(struct
 		if (ret >= 0)
 			*ppos = iter->offset;
 	} else {
-		ret = -ENOTSUPP;
+		ret = -EINVAL;
 	}
 
 put_count:


