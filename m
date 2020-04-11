Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F263020644
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607941;
	bh=WcPZf72Rezz8eZzvRe3VgL9o1sU1PHZVSn7SwgV9RIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snMP5YcYSaiAo11e1E5lpF24cEMti02OEWLgRQAEv0eq8RwnAj4n8Lj0xJ2fzYIMV
	 rBH3PleNuPV6Gq8H2ubiXoRiOtqilRPcBBStyVxKaVjvc/J8dGkjPatynaGswhaQ8v
	 tNxTExxttD9YLGFhRVwCt1bvGGughf9flEOIlSZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgDKMZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgDKMQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:16:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F15B20692;
        Sat, 11 Apr 2020 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607387;
        bh=WcPZf72Rezz8eZzvRe3VgL9o1sU1PHZVSn7SwgV9RIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQUWQcR96qEJlmXLD6Nn4AkfT54ovz3lqttnPaPGKAGjxdiqfQhcXAzXG42rCTPWU
         +3QFddNNhX5DZIxx2uGg4Yiy2pQSWym6U0u9QV6bZlqqrPDR/OLXG7aebFdVKrBCyx
         bsfF58gbWOaau8k//rmUfKH2LS7rFLKWtrw0vLxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 52/54] rpmsg: glink: Remove chunk size word align warning
Date:   Sat, 11 Apr 2020 14:09:34 +0200
Message-Id: <20200411115513.847281835@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
References: <20200411115508.284500414@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

commit f0beb4ba9b185d497c8efe7b349363700092aee0 upstream.

It is possible for the chunk sizes coming from the non RPM remote procs
to not be word aligned. Remove the alignment warning and continue to
read from the FIFO so execution is not stalled.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rpmsg/qcom_glink_native.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -813,9 +813,6 @@ static int qcom_glink_rx_data(struct qco
 		return -EAGAIN;
 	}
 
-	if (WARN(chunk_size % 4, "Incoming data must be word aligned\n"))
-		return -EINVAL;
-
 	rcid = le16_to_cpu(hdr.msg.param1);
 	spin_lock_irqsave(&glink->idr_lock, flags);
 	channel = idr_find(&glink->rcids, rcid);


