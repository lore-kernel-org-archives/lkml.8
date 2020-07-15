Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C202068F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wXbyNJer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGOE5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGOE5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:57:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF1CC061755;
        Tue, 14 Jul 2020 21:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QH+Jx7GuW5CZ9F7NvhpWICwR1gQiO7ytC/JPD1xAQ8A=; b=wXbyNJerlnoUG/6yjY1iMxP/sc
        8Yj3hhphZtZYY6RKYXh6qiGmCC2PdarEvOWBi6Bhp38zQiPeaN0rvv4Lfi+Cz/brvpGEopojNnQJF
        A0Ao5/pJBCtzgYW8zfFiwyg5WvZVo7pGohEeiBq9SwS2LbVCUBim2v/+epB2+p4UjclZv4pozzGNl
        ymxV4uUmiRN+7p8bNHckN2oc8FBh79+oOEfTX4+L+5ENooz2FoHFnd2PC9OCYZz7+No3eKSxKqzih
        pHZ411/Vfp3R7sRu/RXSuZaFW/paMbqYwSpfsJad58WshVkUA4w22GoUw8vEjGSzqk8BRPAgjbrBC
        z8P0vi3g==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZTc-0005gJ-I9; Wed, 15 Jul 2020 04:57:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/4] usb: linux/usb.h: drop duplicated word in comment
Date:   Tue, 14 Jul 2020 21:56:58 -0700
Message-Id: <20200715045701.22949-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/linux/usb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/usb.h
+++ linux-next-20200714/include/linux/usb.h
@@ -341,7 +341,7 @@ struct usb_interface_cache {
  * @interface: array of pointers to usb_interface structures, one for each
  *	interface in the configuration.  The number of interfaces is stored
  *	in desc.bNumInterfaces.  These pointers are valid only while the
- *	the configuration is active.
+ *	configuration is active.
  * @intf_cache: array of pointers to usb_interface_cache structures, one
  *	for each interface in the configuration.  These structures exist
  *	for the entire life of the device.
