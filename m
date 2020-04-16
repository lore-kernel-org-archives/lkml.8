Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD93C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C8321927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047880;
	bh=Zdg/vgCZtVzpvtzNd6vjcd/5iwmO3Je1o3bPcCol/5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0VBvePghdAQxMmlPzoV1Y+xpVzezsu+Fy9F+re9YPE+yH43XdA5UInl4+HMTgJQNQ
	 EQqrQv7HD9Kg8dsabnJlizVzOm5mXEUba0OXFUtX3CFIh8EFXGzNx9wv6pm4NcprYT
	 fY8bCenjFviFTDE+jwTnIun1PQ02LJOG3hUU52AM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgDPOIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898502AbgDPNpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:45:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 293E3208E4;
        Thu, 16 Apr 2020 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044720;
        bh=Zdg/vgCZtVzpvtzNd6vjcd/5iwmO3Je1o3bPcCol/5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVHXra5wx4K0kogPrSF4a7mQTQfT3GSJspC9hy5hqwlIDM4DjZ0tKb8fCWWmO5lPG
         AArxqwcDb9M8Ld1Gu/QLMYwKOzr/Bj4IDPKdYnY1Jc+DwgzG8sN0Xv7+VMN0w4SxL2
         3eOHlPwmSvVwnnMNaGzEkt8xA7847mpchzu9vB5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 5.4 073/232] usb: gadget: f_fs: Fix use after free issue as part of queue failure
Date:   Thu, 16 Apr 2020 15:22:47 +0200
Message-Id: <20200416131324.428413287@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
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


