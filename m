Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2200C54FCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E30208D6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055624;
	bh=fO3TluuhGFUOPYRAZGSQGeSGo8AhaL5yJAE0kpz0YOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dwX1xc3s/cifNaBWD++Mj08A8LWGePI2D5fbA59W1TEFW2tDcnJVFCeOmW41Qyp42
	 TQ3eyOf02G88HT2eA5nN+S6v/JRn+8fHzxwCJ/y16CulhCDAuJLq1eE8tb6CV9EGrm
	 XZN+HqPVHziYlTjaeZNHPuJG+W88FHuEVEsuqM4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgCXNNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgCXNNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:13:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71414208D6;
        Tue, 24 Mar 2020 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055619;
        bh=fO3TluuhGFUOPYRAZGSQGeSGo8AhaL5yJAE0kpz0YOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoycFGx5jmpoRNReGZ20woo38fcaN1Ass9toC8ERLEXtmhznw1JI32c1LaWDLzRAs
         /z6rx3yfVLUr9W93upRqKYBNVdamSnS2zlDOt/nA/ZqX7V7rRhJMykrU6uF8k97HRv
         nrYUp454COov6iY2eRgV2SjPLUEKnGDq7NlxqHCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.19 40/65] intel_th: Fix user-visible error codes
Date:   Tue, 24 Mar 2020 14:11:01 +0100
Message-Id: <20200324130802.227261741@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
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
@@ -491,7 +491,7 @@ static int msc_configure(struct msc *msc
 	lockdep_assert_held(&msc->buf_mutex);
 
 	if (msc->mode > MSC_MODE_MULTI)
-		return -ENOTSUPP;
+		return -EINVAL;
 
 	if (msc->mode == MSC_MODE_MULTI)
 		msc_buffer_clear_hw_header(msc);
@@ -942,7 +942,7 @@ static int msc_buffer_alloc(struct msc *
 	} else if (msc->mode == MSC_MODE_MULTI) {
 		ret = msc_buffer_multi_alloc(msc, nr_pages, nr_wins);
 	} else {
-		ret = -ENOTSUPP;
+		ret = -EINVAL;
 	}
 
 	if (!ret) {
@@ -1165,7 +1165,7 @@ static ssize_t intel_th_msc_read(struct
 		if (ret >= 0)
 			*ppos = iter->offset;
 	} else {
-		ret = -ENOTSUPP;
+		ret = -EINVAL;
 	}
 
 put_count:


