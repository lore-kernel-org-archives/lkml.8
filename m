Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9CDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F7E20732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051921;
	bh=Zdg/vgCZtVzpvtzNd6vjcd/5iwmO3Je1o3bPcCol/5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t6trbU9udG40FHQh/q+shGS5jjNhA+PLB6BLSfcA4Xgn+wRBKfKcNPsBMIXJDZESv
	 nfqlEZc6S38Eg0BPRVF6PIfcfduJ73ac57eL2HNxHKfu8yIXYhBk0SNv2nWj7SAZ6x
	 b93u81nPIsU1PIGNstKjXqD3uUM7oh6Uz0X7ZPRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894721AbgDPPpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897055AbgDPNfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:35:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B9621BE5;
        Thu, 16 Apr 2020 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044109;
        bh=Zdg/vgCZtVzpvtzNd6vjcd/5iwmO3Je1o3bPcCol/5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlZic/oF+ZC1w58phC3KI18MzdtF5MVBigVtTA8UukFeV+aZbu+caRRtvN5LgUdT0
         lFQ74Z8eHl2/yig9/9/5x50yXdUWQUDaF2lX64IHo0w/sbGOBf22pCpdmS4kF1R77G
         L2CBCYbGGzdaz0puU06AIXIcOak7i79eTFXgN2qs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 5.5 085/257] usb: gadget: f_fs: Fix use after free issue as part of queue failure
Date:   Thu, 16 Apr 2020 15:22:16 +0200
Message-Id: <20200416131336.594045522@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sriharsha Allenki <sallenki@codeaurora.org>

commit f63ec55ff904b2f2e126884fcad93175f16ab4bb upstream.

In AIO case, the request is freed up if ep_queue fails.
However, io_data->req still has the reference to this freed
request. In the case of this failure if there is aio_cancel
call on this io_data it will lead to an invalid dequeue
operation and a potential use after free issue.
Fix this by setting the io_data->req to NULL when the request
is freed as part of queue failure.

Fixes: 2e4c7553cd6f ("usb: gadget: f_fs: add aio support")
Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
CC: stable <stable@vger.kernel.org>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Link: https://lore.kernel.org/r/20200326115620.12571-1-sallenki@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_fs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1120,6 +1120,7 @@ static ssize_t ffs_epfile_io(struct file
 
 		ret = usb_ep_queue(ep->ep, req, GFP_ATOMIC);
 		if (unlikely(ret)) {
+			io_data->req = NULL;
 			usb_ep_free_request(ep->ep, req);
 			goto error_lock;
 		}


