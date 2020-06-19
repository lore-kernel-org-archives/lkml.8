Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E43C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59F921852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578699;
	bh=5StiBJX239xbQ2TBSQhispyxs0136n1QRkV2NzneILo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aXzHgrht0+0lrvN9vaE6AiqPNrRlhxqEcWb/Evb7EunWOAOeOAvSb/wGgthIU73Rk
	 1qY2ugt5eBfMcQaFI++9vOw41PLM5GsVh8i9jQYioM1s7IZ0zpC38LRT7quRtDAYgt
	 YfMk/+wpoMIrWd8eYo3IOXL28yj3EzTHv5O9Tic8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbgFSO6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390361AbgFSO6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:58:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82BC621919;
        Fri, 19 Jun 2020 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578694;
        bh=5StiBJX239xbQ2TBSQhispyxs0136n1QRkV2NzneILo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGqvF10m1kJS0uI0o+p4+B9LDHt3/N0fFDbNyVO4YcKjKu0h/ktqwwYpkoEVUooW0
         DM0nDYRoZCsTKfAKjgbzs96Beof0Fti3N7jNO72gqZgkaYUXwdL8K7QS9f8bh2Km8k
         lH4enfCoSfOPA2aQPn4oC0C0evqJnMxcFE4oir/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 090/267] mmc: sdio: Fix potential NULL pointer error in mmc_sdio_init_card()
Date:   Fri, 19 Jun 2020 16:31:15 +0200
Message-Id: <20200619141653.187262591@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit f04086c225da11ad16d7f9a2fbca6483ab16dded upstream.

During some scenarios mmc_sdio_init_card() runs a retry path for the UHS-I
specific initialization, which leads to removal of the previously allocated
card. A new card is then re-allocated while retrying.

However, in one of the corresponding error paths we may end up to remove an
already removed card, which likely leads to a NULL pointer exception. So,
let's fix this.

Fixes: 5fc3d80ef496 ("mmc: sdio: don't use rocr to check if the card could support UHS mode")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20200430091640.455-2-ulf.hansson@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/sdio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -720,9 +720,8 @@ try_again:
 			/* Retry init sequence, but without R4_18V_PRESENT. */
 			retries = 0;
 			goto try_again;
-		} else {
-			goto remove;
 		}
+		return err;
 	}
 
 	/*


