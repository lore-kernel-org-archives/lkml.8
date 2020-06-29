Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB54DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854F4206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L70cZK+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgF2DIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgF2DIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:08:24 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD50C03E979;
        Sun, 28 Jun 2020 20:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Hd4aXGBrGGfmm233mYpZ8b0QDHhitqc6WSdHokmsNw0=; b=L70cZK+7xfK2L9PW/R4cMDhltK
        +fyIfl1GGtrCLqutr7UzcQB4dPV2uBbBlftqyIPa12yd/7/zn/MuMzpNtrNSiEO7MwUiTBZXlZIaI
        aDLa5a9SDHfloWMM5bqdiluHsYttn9BhRidEgMBX1pUjSr7kiTStTKfTDA5p7YTDzEyguLPKN6AI9
        t4pBV2y04PRlRROrSmHDwv3mISVLIj0oSRVpz/4jaEn55G2Tk43snbZSw0iaRNTet0jrrp8CLe4QE
        O8B7mgbGIiPUApjUTzq95iWcG7qwv/hwpsDSiReS3I4oOTiWaFmxxTPlsrGGYwDO0fKPf+eJCCvST
        0EEa+hKw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpk9N-00036y-FD; Mon, 29 Jun 2020 03:08:06 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] usb: gadget: fix langid kernel-doc warning in usbstring.c
Message-ID: <b49b7e07-8986-f185-3a99-a088419a532b@infradead.org>
Date:   Sun, 28 Jun 2020 20:08:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix spelling of the 'langid' function argument in the kernel-doc
notation to quieten a kernel-doc warning.

../drivers/usb/gadget/usbstring.c:77: warning: Function parameter or member 'langid' not described in 'usb_validate_langid'
../drivers/usb/gadget/usbstring.c:77: warning: Excess function parameter 'lang' description in 'usb_validate_langid'

Fixes: 17309a6a4356 ("usb: gadget: add "usb_validate_langid" function")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tao Ren <rentao.bupt@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>
---
 drivers/usb/gadget/usbstring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200626.orig/drivers/usb/gadget/usbstring.c
+++ linux-next-20200626/drivers/usb/gadget/usbstring.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_get_string)
 
 /**
  * usb_validate_langid - validate usb language identifiers
- * @lang: usb language identifier
+ * @langid: usb language identifier
  *
  * Returns true for valid language identifier, otherwise false.
  */

