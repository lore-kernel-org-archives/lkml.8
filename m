Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F89C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346B42078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979711;
	bh=Pk1j2qWhzTS6QEG7IBMEiNngbhmF5UqUq4eXu9KMYxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EpmphjVdYW9Oa7JY0nfu/ghlOQLEFw3OTT0Y84Bjwr/GFxZ7eRtfT3zO3fVqX6yxI
	 /9x/yyAojR/JuYJGeMCgTY+fG2UQmyqk99pDCbJNfXcdxafiRhe0ar8wJbebHdGOrS
	 9ZIWmnlZj3gvE3zQzIK/iBG5X5JSvikxBOha8jgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbgIARBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbgIAPUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:20:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975EB20767;
        Tue,  1 Sep 2020 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973649;
        bh=Pk1j2qWhzTS6QEG7IBMEiNngbhmF5UqUq4eXu9KMYxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqdwO+PPU96EKxmNCPlpDCGJIWhYFG8uI514Ddr9tc88jQmIQLWAJpERKcFy+MTqV
         PFZgjcfftJ1kLnYzn+ml3Wu/MgrBCu35ImPZup3hVg+MyhWTOX5uoo1M5Ejn9zxdkp
         RlKgKuwrDuVb4ik6MiAdqXwZsAlJ3QdfJKxItxL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Kees Cook <keescook@chromium.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, stable <stable@kernel.org>
Subject: [PATCH 4.14 83/91] USB: gadget: u_f: add overflow checks to VLA macros
Date:   Tue,  1 Sep 2020 17:10:57 +0200
Message-Id: <20200901150932.295655115@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150928.096174795@linuxfoundation.org>
References: <20200901150928.096174795@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brooke Basile <brookebasile@gmail.com>

commit b1cd1b65afba95971fa457dfdb2c941c60d38c5b upstream.

size can potentially hold an overflowed value if its assigned expression
is left unchecked, leading to a smaller than needed allocation when
vla_group_size() is used by callers to allocate memory.
To fix this, add a test for saturation before declaring variables and an
overflow check to (n) * sizeof(type).
If the expression results in overflow, vla_group_size() will return SIZE_MAX.

Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Brooke Basile <brookebasile@gmail.com>
Acked-by: Felipe Balbi <balbi@kernel.org>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/u_f.h |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

--- a/drivers/usb/gadget/u_f.h
+++ b/drivers/usb/gadget/u_f.h
@@ -17,6 +17,7 @@
 #define __U_F_H__
 
 #include <linux/usb/gadget.h>
+#include <linux/overflow.h>
 
 /* Variable Length Array Macros **********************************************/
 #define vla_group(groupname) size_t groupname##__next = 0
@@ -24,21 +25,36 @@
 
 #define vla_item(groupname, type, name, n) \
 	size_t groupname##_##name##__offset = ({			       \
-		size_t align_mask = __alignof__(type) - 1;		       \
-		size_t offset = (groupname##__next + align_mask) & ~align_mask;\
-		size_t size = (n) * sizeof(type);			       \
-		groupname##__next = offset + size;			       \
+		size_t offset = 0;					       \
+		if (groupname##__next != SIZE_MAX) {			       \
+			size_t align_mask = __alignof__(type) - 1;	       \
+			size_t offset = (groupname##__next + align_mask)       \
+					 & ~align_mask;			       \
+			size_t size = array_size(n, sizeof(type));	       \
+			if (check_add_overflow(offset, size,		       \
+					       &groupname##__next)) {          \
+				groupname##__next = SIZE_MAX;		       \
+				offset = 0;				       \
+			}						       \
+		}							       \
 		offset;							       \
 	})
 
 #define vla_item_with_sz(groupname, type, name, n) \
-	size_t groupname##_##name##__sz = (n) * sizeof(type);		       \
-	size_t groupname##_##name##__offset = ({			       \
-		size_t align_mask = __alignof__(type) - 1;		       \
-		size_t offset = (groupname##__next + align_mask) & ~align_mask;\
-		size_t size = groupname##_##name##__sz;			       \
-		groupname##__next = offset + size;			       \
-		offset;							       \
+	size_t groupname##_##name##__sz = array_size(n, sizeof(type));	        \
+	size_t groupname##_##name##__offset = ({			        \
+		size_t offset = 0;						\
+		if (groupname##__next != SIZE_MAX) {				\
+			size_t align_mask = __alignof__(type) - 1;		\
+			size_t offset = (groupname##__next + align_mask)	\
+					 & ~align_mask;				\
+			if (check_add_overflow(offset, groupname##_##name##__sz,\
+							&groupname##__next)) {	\
+				groupname##__next = SIZE_MAX;			\
+				offset = 0;					\
+			}							\
+		}								\
+		offset;								\
 	})
 
 #define vla_ptr(ptr, groupname, name) \


