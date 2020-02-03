Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F167EC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFEA20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747297;
	bh=u2g1A+vh9tpzSPImH5UnbDujl5mdiA901sHrr8Qx1VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tdTVx2ClTFn2cOEZFmMqnQfWPyHEns5xwQIxWUQFXcGr6SwKBhxxf778hcqzIFf/+
	 f/FMztMzQStWpfQJAzEfGHiG+s3vk3a/uwCYS4TAjSFzWwYjIEbzNwV1eH33FARqO4
	 2Ht3dyNIvDJnGFXitVW97pD7jDSVYYBzV6PLClL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgBCQ2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:28:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgBCQ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:28:05 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4DD20838;
        Mon,  3 Feb 2020 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747284;
        bh=u2g1A+vh9tpzSPImH5UnbDujl5mdiA901sHrr8Qx1VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=schZfrPxyGDWFwnLAk2Q4F8nPsYFup6rrBEOUmRAtLEuBl12BPbBoYrZAMGdFjfqP
         Isnm06QMi96Kb10qBWMhmV0+QUoSxU45r7RD+6R90fBIOFPvuEGRnVwZGvXEGd1KG1
         mdOu+4+3KaBjzcHqu96XmAA/tcGq8vR2M8hTOkbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fariya Fatima <fariyaf@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 02/89] rsi_91x_usb: fix interface sanity check
Date:   Mon,  3 Feb 2020 16:18:47 +0000
Message-Id: <20200203161917.183994388@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 3139b180906af43bc09bd3373fc2338a8271d9d9 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Cc: stable <stable@vger.kernel.org>     # 3.15
Cc: Fariya Fatima <fariyaf@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/rsi/rsi_91x_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -105,7 +105,7 @@ static int rsi_find_bulk_in_and_out_endp
 	__le16 buffer_size;
 	int ii, bep_found = 0;
 
-	iface_desc = &(interface->altsetting[0]);
+	iface_desc = interface->cur_altsetting;
 
 	for (ii = 0; ii < iface_desc->desc.bNumEndpoints; ++ii) {
 		endpoint = &(iface_desc->endpoint[ii].desc);


