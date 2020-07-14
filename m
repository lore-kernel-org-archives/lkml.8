Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D05C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381EC22B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753387;
	bh=mXHwHhKh8SZHgPmpOskA3H6RVyKL75Bc5+jHFc9GS0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T5m0hqHpG7MqrPKssJW7HAz77GzclffCT6gtMGwxdsHLXG1dUwPlAeS9Z9uWhs44H
	 WGQRmqY5aFMc3qPf3+4SrXJ0vj8pQgy4Wk5bdCMzI36vhZMH6GI2U0pYFqo19fWRRS
	 C10rAH9yZEvdhdY4U4oSZvSD3/1pbR3Ce6ggomJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgGNTDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730303AbgGNS5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:57:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D5E207F5;
        Tue, 14 Jul 2020 18:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753069;
        bh=mXHwHhKh8SZHgPmpOskA3H6RVyKL75Bc5+jHFc9GS0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSI6sxlGPDx2xVKMhqMdsVImNFodiArm5D7KZzgyn5SAKfPP9QsKN8tUYl3HsPxee
         F2mbozur+NxOcRE8kaDceCklfLKGIXY4rCu3P21zwJGwfdN7iFJDQq63dQZRpGToRo
         mTPRkgjb3GaNdR3D+KHecf/gAmg+MY791kx2S2s4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 5.7 108/166] IB/hfi1: Do not destroy link_wq when the device is shut down
Date:   Tue, 14 Jul 2020 20:44:33 +0200
Message-Id: <20200714184121.015647480@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

commit 2315ec12ee8e8257bb335654c62e0cae71dc278d upstream.

The workqueue link_wq should only be destroyed when the hfi1 driver is
unloaded, not when the device is shut down.

Fixes: 71d47008ca1b ("IB/hfi1: Create workqueue for link events")
Link: https://lore.kernel.org/r/20200623204053.107638.70315.stgit@awfm-01.aw.intel.com
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/init.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -844,6 +844,10 @@ static void destroy_workqueues(struct hf
 			destroy_workqueue(ppd->hfi1_wq);
 			ppd->hfi1_wq = NULL;
 		}
+		if (ppd->link_wq) {
+			destroy_workqueue(ppd->link_wq);
+			ppd->link_wq = NULL;
+		}
 	}
 }
 
@@ -1120,14 +1124,10 @@ static void shutdown_device(struct hfi1_
 		 * We can't count on interrupts since we are stopping.
 		 */
 		hfi1_quiet_serdes(ppd);
-
 		if (ppd->hfi1_wq)
 			flush_workqueue(ppd->hfi1_wq);
-		if (ppd->link_wq) {
+		if (ppd->link_wq)
 			flush_workqueue(ppd->link_wq);
-			destroy_workqueue(ppd->link_wq);
-			ppd->link_wq = NULL;
-		}
 	}
 	sdma_exit(dd);
 }


