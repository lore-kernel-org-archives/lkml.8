Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7642AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F01207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mowMqO9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgEGRHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgEGRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:07:05 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C7CC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:07:05 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a62so6486807qkd.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ymubhbuUMqo10NP0iRjdqCfzVtS0tpPXFP6hBmZD6a0=;
        b=mowMqO9im8184u6QOvUBA0wIM78Byr0OqoioGhshWiiwT8nJKONKJJz5svQElVrQKa
         TYEOuPweh0lLQnIpkM4IlDj46vfTQlhYXqkJ2w078q+zaS+1Kp33l1KLOCjpP+RPMvlc
         TceMvMFO/x8ng6ELmji6WKn+z5mkB5NSe7j12yp7xLzXV5ucHeZl6pVO4Kv847l4rMrI
         5G6pq5PMrPrpIXoFT/XsBKQa9l7gNtgfx6RDn2Ixi7tMhkKC1t9BsJPkfurxniFsVDOH
         uRyyPpOUsabh/m8iJswGUmZQ7GfmEVMDWrYeChDVkUMTUSkA2hL3wi8Ysur7vzXJ5ATj
         Pb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ymubhbuUMqo10NP0iRjdqCfzVtS0tpPXFP6hBmZD6a0=;
        b=UmE2ztbLfifOLR6Gkc0yC9S8tYdhnBoUDxWIKvvtSemWI1UHGczB/9/xomKkq1uKW1
         clvBWHxU1bkhR0DScS2NPt9jooytRdlAyezE+EvCLP3Fh6Kryh+tXETL7/DJQ2VAk9Ni
         4lkmuNuwjIgXEwHbLk/PWemeMAVt+PL0CY3dxJkLt2tEK4XvPfCGMAOcIA/iQ9lwZGUB
         m6hw4gRgjI7hyoCW6kD1kDb1UG9FDWITxmIi/0UKCJNsbh1uJQciWvOo/byC6KiyBPvI
         zMblOhpZ2CPdkIMW6EKfzjI7sGCzVmiHDV+FdSbWoXp6IXhvkDFTek4/VtU8B7VNguxZ
         M10g==
X-Gm-Message-State: AGi0PubIxT1fPh0oVrmghCn8E6vu8rKRoEb8hefz1LNFxM3K3183JWqE
        2zpaV6CiiCbxM20QuJLdpktkz2Bc1wvOuKVl
X-Google-Smtp-Source: APiQypLvkahc8DkzAjMi93zhah8Vj2AFn3RskThIsYEhnKOwAREgc0dTuM+sVqh9dhx1TvuAjZQlitIsge7llnO1
X-Received: by 2002:a0c:e8c2:: with SMTP id m2mr13550246qvo.24.1588871224508;
 Thu, 07 May 2020 10:07:04 -0700 (PDT)
Date:   Thu,  7 May 2020 19:06:54 +0200
In-Reply-To: <cover.1588870822.git.andreyknvl@google.com>
Message-Id: <eed8414b900ad9c899009afb9e9b6262c08fe253.1588870822.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1588870822.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH USB v3 1/5] usb: raw-gadget: fix return value of ep read ioctls
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They must return the number of bytes transferred during the data stage.

Fixes: 068fbff4f860 ("usb: raw-gadget: Fix copy_to/from_user() checks")
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index ca7d95bf7397..7b241992ad5a 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -669,12 +669,14 @@ static int raw_ioctl_ep0_read(struct raw_dev *dev, unsigned long value)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 	ret = raw_process_ep0_io(dev, &io, data, false);
-	if (ret)
+	if (ret < 0)
 		goto free;
 
 	length = min(io.length, (unsigned int)ret);
 	if (copy_to_user((void __user *)(value + sizeof(io)), data, length))
 		ret = -EFAULT;
+	else
+		ret = length;
 free:
 	kfree(data);
 	return ret;
@@ -964,12 +966,14 @@ static int raw_ioctl_ep_read(struct raw_dev *dev, unsigned long value)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 	ret = raw_process_ep_io(dev, &io, data, false);
-	if (ret)
+	if (ret < 0)
 		goto free;
 
 	length = min(io.length, (unsigned int)ret);
 	if (copy_to_user((void __user *)(value + sizeof(io)), data, length))
 		ret = -EFAULT;
+	else
+		ret = length;
 free:
 	kfree(data);
 	return ret;
-- 
2.26.2.526.g744177e7f7-goog

