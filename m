Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865E8C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626352173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340469;
	bh=ZGFQnPj+OU8LVyvSqdIHmCAuOxQ6QFw+O6SrVP/NNeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rjUytSbZIVi4WJdbd/GvqJC5ymh5fdUFtORxSgNDmimWJ3I9R4AQh0fQz8pK3SvY8
	 5tjOUFIXUu6Esk5F0XZeXj2BjPryxtxbxAXINNsPdaQnCr+ScgGlvnSAO3f2bJJoXT
	 agNVvpqAI2T3tRgKxumfEFvFPaIGrURumIJIAmow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgEANlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731387AbgEANlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:41:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F09205C9;
        Fri,  1 May 2020 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340464;
        bh=ZGFQnPj+OU8LVyvSqdIHmCAuOxQ6QFw+O6SrVP/NNeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sogv4oTf4Wt4enideRNpO+XNmXiS5CgwoRvrTez379gGN3LWtOmasRGCRXMMfuvfS
         93DqRwWK3gyRigTPLgHjeI2ArgrJetZWe0SzHe2VhwAQKDH3gMNBi+GJkxeh8l2px3
         XYEnhSpvBVwtsiOa/EAlhVy4XSUVj/AFbNZDA6Sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 78/83] Crypto: chelsio - Fixes a hang issue during driver registration
Date:   Fri,  1 May 2020 15:23:57 +0200
Message-Id: <20200501131542.673357618@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ayush Sawal <ayush.sawal@chelsio.com>

commit ad59ddd02de26271b89564962e74d689f1a30b49 upstream.

This issue occurs only when multiadapters are present. Hang
happens because assign_chcr_device returns u_ctx pointer of
adapter which is not yet initialized as for this adapter cxgb_up
is not been called yet.

The last_dev pointer is used to determine u_ctx pointer and it
is initialized two times in chcr_uld_add in chcr_dev_add respectively.

The fix here is don't initialize the last_dev pointer during
chcr_uld_add. Only assign to value to it when the adapter's
initialization is completed i.e in chcr_dev_add.

Fixes: fef4912b66d62 ("crypto: chelsio - Handle PCI shutdown event").

Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/chelsio/chcr_core.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/crypto/chelsio/chcr_core.c
+++ b/drivers/crypto/chelsio/chcr_core.c
@@ -125,8 +125,6 @@ static void chcr_dev_init(struct uld_ctx
 	atomic_set(&dev->inflight, 0);
 	mutex_lock(&drv_data.drv_mutex);
 	list_add_tail(&u_ctx->entry, &drv_data.inact_dev);
-	if (!drv_data.last_dev)
-		drv_data.last_dev = u_ctx;
 	mutex_unlock(&drv_data.drv_mutex);
 }
 


