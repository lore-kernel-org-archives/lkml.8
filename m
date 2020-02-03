Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37102C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3F621741
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747502;
	bh=KQRTBNGIx/d9uZvKRGCFrbPP4MYDMOG24kIsgdaTp+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d8rGidmyrsDo2BvDuxidzP/V6Z1yG9uqDmFOhK1EAvvPho92fLxWHcpnqWJpZ/RBA
	 lTuHEFDDmqkAo9lV0TdhrJcwg4gw83znKkofIhr+94actzEhq49bxNTrO/c0oPAiPu
	 b37iMYrL4D/VJnmSuqx6jmCCfu2kDzHg8X7JoFTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgBCQbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbgBCQbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:31:37 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98CB721775;
        Mon,  3 Feb 2020 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747497;
        bh=KQRTBNGIx/d9uZvKRGCFrbPP4MYDMOG24kIsgdaTp+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYpRuovlT/3pnw0J+xqpXjiOmxi8i5wvREJLOFCGaKOFZdkHhxHeYWInBfLsb1M6u
         3LzZII6SdMQAhDZY8ieKD+De3h9kcoEWGZTiP9kXP5wtQOGR4GopvHa0XOXvDc9rHZ
         3CRHHUacScC1kDVOPdMg9uf+Nm1rQDFz+picWXAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        syzbot+6bf9606ee955b646c0e1@syzkaller.appspotmail.com
Subject: [PATCH 4.19 19/70] media: dvb-usb/dvb-usb-urb.c: initialize actlen to 0
Date:   Mon,  3 Feb 2020 16:19:31 +0000
Message-Id: <20200203161915.388634293@linuxfoundation.org>
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


