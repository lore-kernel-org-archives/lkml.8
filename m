Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E41BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DAE20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340109;
	bh=ZgdRohyeoqyTe+zFijsGSWH8xU5n9mO1FJu1F/BIhj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0seiNqJm43HHYKbWyqNm/QtH3ZIejDbQrxzM5b2oJc8qClMm0aGlpYdVBtg1p1KsG
	 B20JeZmUVOIEpXPll8MBijORHRdoTwddbzwqhq2x2QBFpVwNdlIFHGBL3m/BiA9E1v
	 b9GgqFC5j/8prc6RDYQ3s33/uvsoVDF4G26xn0+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgBJNI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbgBJMje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:34 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C3F20842;
        Mon, 10 Feb 2020 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338374;
        bh=ZgdRohyeoqyTe+zFijsGSWH8xU5n9mO1FJu1F/BIhj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVy8k0+WwvNCWuR2J4ZP7GT/fhXneKnH8yguFhJwjxqlhh/Y6o2CUnggAnXo2BaLW
         BKMEwBDPHrO8cPSbr7zoLQMSl4eTMPFvBSvo/QWdYJ5ulnhr/dVpgkf1ec0gAdCvo7
         l5In4osbZE1CQ6LjKUA/jh2Ff5WehQgfSFAdA7M0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Li <jun.li@nxp.com>,
        Peter Chen <peter.chen@nxp.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.5 047/367] usb: gadget: f_fs: set req->num_sgs as 0 for non-sg transfer
Date:   Mon, 10 Feb 2020 04:29:20 -0800
Message-Id: <20200210122428.383827294@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

commit d2450c6937018d40d4111fe830fa48d4ddceb8d0 upstream.

The UDC core uses req->num_sgs to judge if scatter buffer list is used.
Eg: usb_gadget_map_request_by_dev. For f_fs sync io mode, the request
is re-used for each request, so if the 1st request->length > PAGE_SIZE,
and the 2nd request->length is <= PAGE_SIZE, the f_fs uses the 1st
req->num_sgs for the 2nd request, it causes the UDC core get the wrong
req->num_sgs value (The 2nd request doesn't use sg). For f_fs async
io mode, it is not harm to initialize req->num_sgs as 0 either, in case,
the UDC driver doesn't zeroed request structure.

Cc: Jun Li <jun.li@nxp.com>
Cc: stable <stable@vger.kernel.org>
Fixes: 772a7a724f69 ("usb: gadget: f_fs: Allow scatter-gather buffers")
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_fs.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1062,6 +1062,7 @@ static ssize_t ffs_epfile_io(struct file
 			req->num_sgs = io_data->sgt.nents;
 		} else {
 			req->buf = data;
+			req->num_sgs = 0;
 		}
 		req->length = data_len;
 
@@ -1105,6 +1106,7 @@ static ssize_t ffs_epfile_io(struct file
 			req->num_sgs = io_data->sgt.nents;
 		} else {
 			req->buf = data;
+			req->num_sgs = 0;
 		}
 		req->length = data_len;
 


