Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41FDC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB470217BA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747494;
	bh=gz9eAKYke4ruOq2+sHvKHX8F3njkkoFPfbTen9cabb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kks2pn7SQhANatrRZjXN0C3jnY5Npz/FCBI7I68Si4CATGIxqbG0+MiIeVqOcIBX2
	 PhAdZOS/ZeutzukoRaQ1X0vWfY3yRLBDynsnM69pTEKgWvskB/+MLPDJacVWyerxEw
	 /o7iy37HhdfDXMbubc8jNtRh/p2fsJ8kIEpBH0IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgBCQbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:31:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbgBCQba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:31:30 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F5521741;
        Mon,  3 Feb 2020 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747489;
        bh=gz9eAKYke4ruOq2+sHvKHX8F3njkkoFPfbTen9cabb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFZDyqMVXY28OoqAo1A2KyQuYJfdEJAu4zk6woRtME8LO8HGhWvXHM9Qb6Mvx226G
         lRotLrlc8+/SKvkDyNUkKFCSRV509XXlRqsI9KmTUUqOiGr/295SYcuVpv7niairye
         o/vuPGcWmZJE5DIKgkOi+mXJb/6d6h05AXwNtKvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+9d42b7773d2fecd983ab@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4.19 16/70] media: af9005: uninitialized variable printked
Date:   Mon,  3 Feb 2020 16:19:28 +0000
Message-Id: <20200203161914.964010217@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

commit 51d0c99b391f0cac61ad7b827c26f549ee55672c upstream.

If usb_bulk_msg() fails, actual_length can be uninitialized.

Reported-by: syzbot+9d42b7773d2fecd983ab@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb/af9005.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/dvb-usb/af9005.c
+++ b/drivers/media/usb/dvb-usb/af9005.c
@@ -563,7 +563,7 @@ static int af9005_boot_packet(struct usb
 			      u8 *buf, int size)
 {
 	u16 checksum;
-	int act_len, i, ret;
+	int act_len = 0, i, ret;
 
 	memset(buf, 0, size);
 	buf[0] = (u8) (FW_BULKOUT_SIZE & 0xff);


