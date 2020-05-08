Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93216C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4D824971
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941722;
	bh=JFs8PvW9Eaksh19MTes//uc/Fb1GBekhhNjYYonSPtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xO0luhabvJvlN/6Bz8Mm3ITC9k0QalwWZnR1+sJEwcPZDelDKarZNCAZYpb+MiGoN
	 dRx5w1DZj5PZouRKzQmQhPuS2yVX9xkBNwuQbyV3C4NBSTI6oy5G8Ktr3nVGR6PkQq
	 hj5fNt1iI7ibb6dPxAurG7CLPMt9EVanL2ddQy7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgEHMmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbgEHMlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:41:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29272495F;
        Fri,  8 May 2020 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941712;
        bh=JFs8PvW9Eaksh19MTes//uc/Fb1GBekhhNjYYonSPtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGoLiEZs5D7VTrhFVO2ubrmoix/UQaiuqhAL2ZZJ+DNiHHtZ8iFX5RGDhCEQqptTo
         POpLBfzzPOE5NCcZlqJdehfyGqO36gUpJzX1h+UuGYE6zUZJMVlH1BwCuX1qTah9Go
         sWLU3flyp+prMdJfpnCPjuAjvrQjiaCmARWpmBw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Grant Grundler <grundler@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.4 141/312] mmc: block: return error on failed mmc_blk_get()
Date:   Fri,  8 May 2020 14:32:12 +0200
Message-Id: <20200508123134.397412537@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>

commit f00ab14c252ac459e86194747a1f580ab503c954 upstream.

This used to return -EFAULT, but the function above returns -EINVAL on
the same condition so let's stick to that.

The removal of error return on this path was introduced with b093410c9aef
('mmc: block: copy resp[] data on err for MMC_IOC_MULTI_CMD').

Fixes: b093410c9aef ('mmc: block: copy resp[] data on err for MMC_IOC_MULTI_CMD').
Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Grant Grundler <grundler@google.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/card/block.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -668,8 +668,10 @@ static int mmc_blk_ioctl_multi_cmd(struc
 	}
 
 	md = mmc_blk_get(bdev->bd_disk);
-	if (!md)
+	if (!md) {
+		err = -EINVAL;
 		goto cmd_err;
+	}
 
 	card = md->queue.card;
 	if (IS_ERR(card)) {


