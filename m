Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85592C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DB62068F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T8uaikqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGOE5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGOE5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:57:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90001C061755;
        Tue, 14 Jul 2020 21:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=STUO+XIIFpmBUz8ndZfBnBd61dv3oLoNgTAECGiMfc0=; b=T8uaikqtvHpMZtI5SQKdxvMHGl
        uLSSnMcbrukSKnQQp+pNYIMCueOwxwO4HGsQ3sCUlqTQ3MPI6CwB34dDet4cwOr0qVfhfEntv8tMd
        BDN0XK7vxGVY737yutDj1j2UGlpb780a/nIobkueVg6ioB3SMDgfHtcJtfYM+JHgKyN7oRJ1YRNxM
        QxmcbY1DfcOPUXOSlZXxACW8D4BdXyZw0zMfez2fyrg6AithFfN1qgdT6Q+o6oV0Q1Q63gtosLkyU
        rQyk+FNvz0wRn0yHKZmIJ1mbKidqeEcgcMp7yXOTAvfD9ayv81yxKAg/r67m7LxDGgOMVMIFwajT3
        S0JB75+Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZTe-0005gJ-H5; Wed, 15 Jul 2020 04:57:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/4] usb: linux/usb/gadget.h: fix duplicated word in comment
Date:   Tue, 14 Jul 2020 21:56:59 -0700
Message-Id: <20200715045701.22949-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715045701.22949-1-rdunlap@infradead.org>
References: <20200715045701.22949-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the doubled word "in" to "be in" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/linux/usb/gadget.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/usb/gadget.h
+++ linux-next-20200714/include/linux/usb/gadget.h
@@ -731,7 +731,7 @@ int usb_gadget_probe_driver(struct usb_g
  * it will first disconnect().  The driver is also requested
  * to unbind() and clean up any device state, before this procedure
  * finally returns.  It's expected that the unbind() functions
- * will in in exit sections, so may not be linked in some kernels.
+ * will be in exit sections, so may not be linked in some kernels.
  */
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver);
 
