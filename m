Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3ADC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440F820774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549823;
	bh=kZ0NiSTwCEI9iWhJHS4nvEjEPhJyU7VAc4ik70TAT4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v0NpdUyQI6B4ngj/T0hjTJ69VQUlToMlkm6qceisBbwX8eq5GUsOUvg7VloztBFn2
	 KxWKdHYnVz8egXrruOQBZUPzbnxrnEFNhQFoXv04MuImP0Auh46jeMRggs5eyDDYVF
	 CGkt8ZFeBzwYEBP1bu316DUqjmSdzOfPbjPCnsgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDVKDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgDVKDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:03:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC9D620774;
        Wed, 22 Apr 2020 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549817;
        bh=kZ0NiSTwCEI9iWhJHS4nvEjEPhJyU7VAc4ik70TAT4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2p4PKhv6CePkCKjbAJIR9P6CDyEgh8HOnW8hSyGROWsbg2uZgcUELZi5VF7wAX5w/
         n79SHMVqE9IgbTgIUCn45dsmoW1TBQQc/vVZDRQOT2276JYKoUOkUgjUjYli/osKjP
         EpBvZicCJA4gUo+BinTQAvX646nghHkTAB5BQfeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 4.9 019/125] usb: gadget: f_fs: Fix use after free issue as part of queue failure
Date:   Wed, 22 Apr 2020 11:55:36 +0200
Message-Id: <20200422095036.400891919@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
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
@@ -1036,6 +1036,7 @@ static ssize_t ffs_epfile_io(struct file
 
 		ret = usb_ep_queue(ep->ep, req, GFP_ATOMIC);
 		if (unlikely(ret)) {
+			io_data->req = NULL;
 			usb_ep_free_request(ep->ep, req);
 			goto error_lock;
 		}


