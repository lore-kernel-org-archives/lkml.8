Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AA0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9C92067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726737;
	bh=CqPY/+dkQ2Nz5ag0iLhLKZPPQ1DZEosOK/8x77+VTuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nE+5zCad1n3kLuRTIWEYOFrJZ8k7OLS1kFui5HKMtUe8eHJgRY+TKow0H2dUF1+Lp
	 JGRjfbu4b2rlaMeL5qbo8MjsijuYlL/zdw+bpEV3qwyabqvdq1lV0uZ4WD6FJ2SIBh
	 iJYPGxpvWCoFsyDIOytd7QJFoiz/BsTXiZo3QfCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbgFISS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730866AbgFIRuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:50:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D5A92081A;
        Tue,  9 Jun 2020 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725005;
        bh=CqPY/+dkQ2Nz5ag0iLhLKZPPQ1DZEosOK/8x77+VTuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROQYqmdb2x+scyCe/95L7Bkxzxv6X+js8xmScDSuHc8vFi3DGMM4u9kdbpSbFyJyW
         hrB9SH0+YPsHIFdFTrzhvnAVWwbmOCMJSFVtKKurM9XT+O4fJtEqWsBM1ap1iengpT
         vGrbRWNVifgTSReuYl6QQUYiFfW9qG5g+rACQ7dA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 31/46] USB: serial: usb_wwan: do not resubmit rx urb on fatal errors
Date:   Tue,  9 Jun 2020 19:44:47 +0200
Message-Id: <20200609174028.670373983@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
References: <20200609174022.938987501@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Liu <b-liu@ti.com>

commit 986c1748c84d7727defeaeca74a73b37f7d5cce1 upstream.

usb_wwan_indat_callback() shouldn't resubmit rx urb if the previous urb
status is a fatal error. Or the usb controller would keep processing the
new urbs then run into interrupt storm, and has no chance to recover.

Fixes: 6c1ee66a0b2b ("USB-Serial: Fix error handling of usb_wwan")
Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/usb_wwan.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -302,6 +302,10 @@ static void usb_wwan_indat_callback(stru
 	if (status) {
 		dev_dbg(dev, "%s: nonzero status: %d on endpoint %02x.\n",
 			__func__, status, endpoint);
+
+		/* don't resubmit on fatal errors */
+		if (status == -ESHUTDOWN || status == -ENOENT)
+			return;
 	} else {
 		if (urb->actual_length) {
 			tty_insert_flip_string(&port->port, data,


