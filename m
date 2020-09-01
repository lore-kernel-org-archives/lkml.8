Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2624C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CF621582
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974639;
	bh=Qj7JQS+ohLx5lQJpKyzZQKyNdacmCCnN1LoA2xLvZVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iEhgw63IXU+H2FZ8+n7yu+LmkniZ+ECjQFzJnlX2fVExYi3DmAXgVgcp8qwoGUUeO
	 jfZyxVdbBSI9fqzlHVViSNDdutdEjt7E/MHTQsUJwGytheHdFWVHSsVVtepEKf0IhR
	 eoTcv56cSGpFDRXHpPsWnJeyJKoSvs16w4AbPF5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgIAPhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbgIAPfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:35:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D4221534;
        Tue,  1 Sep 2020 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974548;
        bh=Qj7JQS+ohLx5lQJpKyzZQKyNdacmCCnN1LoA2xLvZVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuFZ77HL6gJVyYk0FTLEsWQB7N8jwC9+i0D7BoZ0y7UIVjxda5YkoyrRi3cVHvpyG
         eIZ+DZAHQFS6FyXXLtPv+Ow0kKL0W1wU+HTZUJQdqy7pEpNEoWXrmZUC2SPP43+WGd
         V59508Lv6oJlm0s5GELFGs8k7Fxzp+FS/xiJVxuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brooke Basile <brookebasile@gmail.com>,
        stable <stable@kernel.org>
Subject: [PATCH 5.4 197/214] USB: gadget: u_f: Unbreak offset calculation in VLAs
Date:   Tue,  1 Sep 2020 17:11:17 +0200
Message-Id: <20200901151002.381889040@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit bfd08d06d978d0304eb6f7855b548aa2cd1c5486 upstream.

Inadvertently the commit b1cd1b65afba ("USB: gadget: u_f: add overflow checks
to VLA macros") makes VLA macros to always return 0 due to different scope of
two variables of the same name. Obviously we need to have only one.

Fixes: b1cd1b65afba ("USB: gadget: u_f: add overflow checks to VLA macros")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Brooke Basile <brookebasile@gmail.com>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20200826192119.56450-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/u_f.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/u_f.h
+++ b/drivers/usb/gadget/u_f.h
@@ -25,9 +25,9 @@
 		size_t offset = 0;					       \
 		if (groupname##__next != SIZE_MAX) {			       \
 			size_t align_mask = __alignof__(type) - 1;	       \
-			size_t offset = (groupname##__next + align_mask)       \
-					 & ~align_mask;			       \
 			size_t size = array_size(n, sizeof(type));	       \
+			offset = (groupname##__next + align_mask) &	       \
+				  ~align_mask;				       \
 			if (check_add_overflow(offset, size,		       \
 					       &groupname##__next)) {          \
 				groupname##__next = SIZE_MAX;		       \
@@ -43,8 +43,8 @@
 		size_t offset = 0;						\
 		if (groupname##__next != SIZE_MAX) {				\
 			size_t align_mask = __alignof__(type) - 1;		\
-			size_t offset = (groupname##__next + align_mask)	\
-					 & ~align_mask;				\
+			offset = (groupname##__next + align_mask) &		\
+				  ~align_mask;					\
 			if (check_add_overflow(offset, groupname##_##name##__sz,\
 							&groupname##__next)) {	\
 				groupname##__next = SIZE_MAX;			\


