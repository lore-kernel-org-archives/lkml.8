Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9250CC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A04206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GzHzqzlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgGOE5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGOE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:57:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FA2C061755;
        Tue, 14 Jul 2020 21:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DPbfpG/KWvvF35gI4SQBvg79MOA4RF/nFNBLBvf5o58=; b=GzHzqzlxU2CrPGbAG6KbyumdZb
        qyeyFXeYoSx7dpQGVPwu8N+oohi7/X+FsrRFxzd69bdLH5Fta4DNLVUVcwahsQcFwgfUml/vX49/w
        q6182Ko2cohOPlYYuddASQcx/dFbKN+h2jUXcdX0CfoxKRJqanyeUVV5oW9R2C4Ik4p7czDlYE6AS
        3X5hLZXhBUFI8Jk0UNyemObYUsitNrgKD6nDgXqHC8CmlN1kmnDewqlUNvl8+we0G+ZuR5wiAV+hk
        lI72khX4p5cx1PRF+S6n6THo/elf0pyQVHhSDdpsc259J+P+KtYWIZrImQ+uPs3w8Mqw3hHCD4JU5
        uFVHHypw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZTh-0005gJ-Sb; Wed, 15 Jul 2020 04:57:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 4/4] usb: linux/usb/serial.h: drop duplicated word in comment
Date:   Tue, 14 Jul 2020 21:57:01 -0700
Message-Id: <20200715045701.22949-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715045701.22949-1-rdunlap@infradead.org>
References: <20200715045701.22949-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "set" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/linux/usb/serial.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/usb/serial.h
+++ linux-next-20200714/include/linux/usb/serial.h
@@ -212,7 +212,7 @@ struct usb_serial_endpoints {
  *	Return 0 to continue on with the initialization sequence.  Anything
  *	else will abort it.
  * @attach: pointer to the driver's attach function.
- *	This will be called when the struct usb_serial structure is fully set
+ *	This will be called when the struct usb_serial structure is fully
  *	set up.  Do any local initialization of the device, or any private
  *	memory structure allocation at this point in time.
  * @disconnect: pointer to the driver's disconnect function.  This will be
