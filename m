Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F5BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A43A2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592262791;
	bh=HGJzoC5XExSt4wsgEPUS6ZDs+czaXfcrRPmazD8rgiE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rn9IkE0VDWZahNtUPAil8Q0Gx13XA0cMyCm9wnRejGmhuImBpd0zEbS+XyHClS+Ww
	 cGeBnMGhM2BCnZvzr1+EaUlucJGdASHdCdZHeyt0pjJRMUDm6PusN7j6B723Smq6Sn
	 pyrgJjP251kSPwTRZjWdZORK5+rSxPeNGavGMv78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgFOXNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:13:08 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD8D2068E;
        Mon, 15 Jun 2020 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592262788;
        bh=HGJzoC5XExSt4wsgEPUS6ZDs+czaXfcrRPmazD8rgiE=;
        h=Date:From:To:Cc:Subject:From;
        b=TSVprE2cHcnj3VQS/DYhJcGT/tVAu1KwGLoLZG0+K6bFoqo5kxrPn2ZR0CtyC1ZG1
         VwEEJLiIfovpjuTT/DXSnK1hdpgl0YFErq/nrn8qaVNarJjqrMdhIb7mIgaZ9Dnhzx
         KBk9ABBgvakiwxpgZBObfI+bmaBcHHYwNryUiudw=
Date:   Mon, 15 Jun 2020 18:18:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] usb: sisusb_con: Use array_size() helper in memcpy()
Message-ID: <20200615231827.GA21348@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size() helper instead of the open-coded version in memcpy().
These sorts of multiplication factors need to be wrapped in array_size().

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/misc/sisusbvga/sisusb_con.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index cd0155310fea..586d6b01c3c4 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1226,7 +1226,7 @@ sisusbcon_font_set(struct vc_data *c, struct console_font *font,
 		sisusb->font_backup = vmalloc(array_size(charcount, 32));
 
 	if (sisusb->font_backup) {
-		memcpy(sisusb->font_backup, font->data, charcount * 32);
+		memcpy(sisusb->font_backup, font->data, array_size(charcount, 32));
 		sisusb->font_backup_size = charcount;
 		sisusb->font_backup_height = font->height;
 		sisusb->font_backup_512 = (charcount == 512) ? 1 : 0;
-- 
2.27.0

