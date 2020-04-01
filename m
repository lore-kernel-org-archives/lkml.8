Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4763C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A39420658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759118;
	bh=tet5YOIqQdCOHptiSOmkenXOZ5P8aUOSAsNdEt653NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sjCWV0ksQ/I1NLQ79K3t2auxOsb9fGY8AH5RP4QwZFltny9l1fsYXXj1kZh/2+k9A
	 hxd6E+2T3q2zh7BT9oP1MhALiqvyUMc5SbZLrsN/OOWijf+KZpy6aBpm6f0qBomcKe
	 9cisnEzQr88C6jMIRQdm8UyOEzbFpbVwcD9U2Dfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbgDAQih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388962AbgDAQic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:38:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1D020772;
        Wed,  1 Apr 2020 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759112;
        bh=tet5YOIqQdCOHptiSOmkenXOZ5P8aUOSAsNdEt653NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qq/ypKshbB7jWtsxz5UX4A/MH2w0yOzDzF1/ri83ph1TeC2YcNWHVLK2TmnUbHCOD
         T4QEKhqb870C9DkjWazEywkcG5M+dfM/0kpn4gYwqQeCxmjufPj935Vg8Ui84xN7Os
         FBiMDO6QL7f/Y4QJHYSsPGU5emlO22No5khjwkMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com
Subject: [PATCH 4.9 078/102] USB: serial: io_edgeport: fix slab-out-of-bounds read in edge_interrupt_callback
Date:   Wed,  1 Apr 2020 18:18:21 +0200
Message-Id: <20200401161545.691788527@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

commit 57aa9f294b09463492f604feaa5cc719beaace32 upstream.

Fix slab-out-of-bounds read in the interrupt-URB completion handler.

The boundary condition should be (length - 1) as we access
data[position + 1].

Reported-and-tested-by: syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/io_edgeport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -634,7 +634,7 @@ static void edge_interrupt_callback(stru
 		/* grab the txcredits for the ports if available */
 		position = 2;
 		portNumber = 0;
-		while ((position < length) &&
+		while ((position < length - 1) &&
 				(portNumber < edge_serial->serial->num_ports)) {
 			txCredits = data[position] | (data[position+1] << 8);
 			if (txCredits) {


