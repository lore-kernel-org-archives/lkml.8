Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3271C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0D120CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747768;
	bh=KQRTBNGIx/d9uZvKRGCFrbPP4MYDMOG24kIsgdaTp+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UfNanoA7tv9mswdJx/e9NZULxmaDPauFTdO7/+ZC74y8S5mxS20xF3iB4PZcdqlq9
	 W/jgtZ7QoE+Mk02aAvQDYr4oU/LJhpdkyVSNOH0BIvdj+6PBTJ33IwtBQ7zaN3+N9A
	 YQUitzM9Pr+KSym2d+1ldruhn/MIkXZ2GEWx1sMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbgBCQgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:36:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731115AbgBCQgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:36:02 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69E9B2051A;
        Mon,  3 Feb 2020 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747761;
        bh=KQRTBNGIx/d9uZvKRGCFrbPP4MYDMOG24kIsgdaTp+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/SfVMZK+7b9ypAowOcQsoBdr5S2H5YkCYZBYz9knzq2jN3qL2CAHbFX6dKLHE8Yg
         yLvJB4lx2LEgbZBTrVndV3AFvsBM7//LOu2tpKVNuZsoM0pwWZi5o7doSFpoQsicaD
         0v+SN4RhLe7p1YjZ6lrf/eaFqN/wIK/gPw7MzgDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        syzbot+6bf9606ee955b646c0e1@syzkaller.appspotmail.com
Subject: [PATCH 5.4 19/90] media: dvb-usb/dvb-usb-urb.c: initialize actlen to 0
Date:   Mon,  3 Feb 2020 16:19:22 +0000
Message-Id: <20200203161920.218827702@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 569bc8d6a6a50acb5fcf07fb10b8d2d461fdbf93 upstream.

This fixes a syzbot failure since actlen could be uninitialized,
but it was still used.

Syzbot link:

https://syzkaller.appspot.com/bug?extid=6bf9606ee955b646c0e1

Reported-and-tested-by: syzbot+6bf9606ee955b646c0e1@syzkaller.appspotmail.com

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb/dvb-usb-urb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/dvb-usb/dvb-usb-urb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-urb.c
@@ -12,7 +12,7 @@
 int dvb_usb_generic_rw(struct dvb_usb_device *d, u8 *wbuf, u16 wlen, u8 *rbuf,
 	u16 rlen, int delay_ms)
 {
-	int actlen,ret = -ENOMEM;
+	int actlen = 0, ret = -ENOMEM;
 
 	if (!d || wbuf == NULL || wlen == 0)
 		return -EINVAL;


