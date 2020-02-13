Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553D4C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB2920661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608965;
	bh=hYNz40p2Qlm43B9gsOmwAE7R5tC9tcvgb6V4u5Ihi58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SlmLwFcbKrTTkBmhq8DJ/5ZPuwoK3ARJQP9VQMgw88tZE03dm6/KqxKeGlC47Xqca
	 PC0bbx+9y1xN9ATOqrUvVlBKmnSL1X5dKNjUYPTppa55cuR+dfrnaDvsK/REpssAsd
	 xg3+KL2buKrBJb4dnmjrc2VtQjgYd7FtYt57G4CQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgBMPtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387618AbgBMP0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:46 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C48120661;
        Thu, 13 Feb 2020 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607605;
        bh=hYNz40p2Qlm43B9gsOmwAE7R5tC9tcvgb6V4u5Ihi58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQ61FAW1BJLcrnu8QuJ9jTZVN/q32+JObTsTKQIDQy7rWrarLZ2CVATkZ4cgJJT/q
         osJxwKz+jHkaoD6FlpFYV/OYWiN47CJ/eIJnHIfOCXGGHbn46YifL7gF6vTPcWnbUx
         HKSG/nPYFYmFC59Ih2zbcKEgo0lZVhOu6wFV9lQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4.19 44/52] media: i2c: adv748x: Fix unsafe macros
Date:   Thu, 13 Feb 2020 07:21:25 -0800
Message-Id: <20200213151828.199697666@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 0d962e061abcf1b9105f88fb850158b5887fbca3 upstream.

Enclose multiple macro parameters in parentheses in order to
make such macros safer and fix the Clang warning below:

drivers/media/i2c/adv748x/adv748x-afe.c:452:12: warning: operator '?:'
has lower precedence than '|'; '|' will be evaluated first
[-Wbitwise-conditional-parentheses]

ret = sdp_clrset(state, ADV748X_SDP_FRP, ADV748X_SDP_FRP_MASK, enable
? ctrl->val - 1 : 0);

Fixes: 3e89586a64df ("media: i2c: adv748x: add adv748x driver")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/adv748x/adv748x.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/media/i2c/adv748x/adv748x.h
+++ b/drivers/media/i2c/adv748x/adv748x.h
@@ -361,10 +361,10 @@ int adv748x_write_block(struct adv748x_s
 
 #define io_read(s, r) adv748x_read(s, ADV748X_PAGE_IO, r)
 #define io_write(s, r, v) adv748x_write(s, ADV748X_PAGE_IO, r, v)
-#define io_clrset(s, r, m, v) io_write(s, r, (io_read(s, r) & ~m) | v)
+#define io_clrset(s, r, m, v) io_write(s, r, (io_read(s, r) & ~(m)) | (v))
 
 #define hdmi_read(s, r) adv748x_read(s, ADV748X_PAGE_HDMI, r)
-#define hdmi_read16(s, r, m) (((hdmi_read(s, r) << 8) | hdmi_read(s, r+1)) & m)
+#define hdmi_read16(s, r, m) (((hdmi_read(s, r) << 8) | hdmi_read(s, (r)+1)) & (m))
 #define hdmi_write(s, r, v) adv748x_write(s, ADV748X_PAGE_HDMI, r, v)
 
 #define repeater_read(s, r) adv748x_read(s, ADV748X_PAGE_REPEATER, r)
@@ -372,11 +372,11 @@ int adv748x_write_block(struct adv748x_s
 
 #define sdp_read(s, r) adv748x_read(s, ADV748X_PAGE_SDP, r)
 #define sdp_write(s, r, v) adv748x_write(s, ADV748X_PAGE_SDP, r, v)
-#define sdp_clrset(s, r, m, v) sdp_write(s, r, (sdp_read(s, r) & ~m) | v)
+#define sdp_clrset(s, r, m, v) sdp_write(s, r, (sdp_read(s, r) & ~(m)) | (v))
 
 #define cp_read(s, r) adv748x_read(s, ADV748X_PAGE_CP, r)
 #define cp_write(s, r, v) adv748x_write(s, ADV748X_PAGE_CP, r, v)
-#define cp_clrset(s, r, m, v) cp_write(s, r, (cp_read(s, r) & ~m) | v)
+#define cp_clrset(s, r, m, v) cp_write(s, r, (cp_read(s, r) & ~(m)) | (v))
 
 #define txa_read(s, r) adv748x_read(s, ADV748X_PAGE_TXA, r)
 #define txb_read(s, r) adv748x_read(s, ADV748X_PAGE_TXB, r)


