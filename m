Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AF9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4821D20870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdDJM1wU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGCRn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgGCRm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07139C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so33527480wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISJzLOqlSFQczkvc3nK58bGo6HT98YijZfD9JIzoDdI=;
        b=hdDJM1wUbe6Ydmnsq4OtW1IpkqyR5cZyO21yDrMUJB1fPRtE9PXgy9WLg9uyjpLjDk
         02rvMWgwad9utS1g6bYTUJKX7YVCsq7Xs7//+phOH0Oi67PsV5lSVQdrkOAxOaz4tsQW
         KY+BgAb4/zf/Edqb5LDhPlUnPqTljgNt1UPtf3jD3WyDnAvR0z99qifIMbsQ0kwKpBKV
         Ite1MzW2DvZHvyOU6ALS9uUvdSlb6fFhLsh8xPfS7tsakPpgDNHMum8UEPMF5+ekR/rR
         nFk+JrvtjyhLapCvYjvvytXS9fNnf2ED2grHZRNAmLSgpIQYeigPbYlkngsCTR8BeljI
         +WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISJzLOqlSFQczkvc3nK58bGo6HT98YijZfD9JIzoDdI=;
        b=SYiPl+JnT0RmuoMkD5BEguEDwSitEjcNwNDi802e3na3cvlqqUSgAYXBsHoe1SKHQB
         l0HEhECauxHrIJjygSpx/MMTh8ZtGZJ0mN05ZTWGYwZF5Bi9/mmw2q32nJDFILEY82iJ
         7fHuUgR5uzub57WeAzEffp432g8F71CllZjSUxmzrDZwh/mTZ/RJwvV3zjyXUV0941Ez
         JBdN1fwKrIMyUqi3p1jRks22+4nVTo/XYNtuGVzBBkUWiZrJYQ8ppqkHgLLiKxiweCpK
         InhvEOO9QU2dd2kChijCZwtnFul3Cdt9wTLd40VAZ89W8Tdfd0t5ZnA1vO6vwKeNf4jQ
         M5EA==
X-Gm-Message-State: AOAM533cEL1S/4PTlpp9+OXwNqT2NloMHD1fUGkoB5HFEjKmDntdRVq/
        r08TbukZbLjNynJV56/ELIcKESkFH0g=
X-Google-Smtp-Source: ABdhPJwhbYBajzI+AeT8gPceWRCmWE8E9ElSc7oYeCmS6lqdip6cntrVuot3YBb3WbRXMC6UURMhIg==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr41969478wrs.60.1593798174786;
        Fri, 03 Jul 2020 10:42:54 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Christian Lucht <lucht@codemercs.com>,
        Stephane Dalton <sdalton@videotron.ca>,
        Stephane Doyon <s.doyon@videotron.ca>
Subject: [PATCH 25/30] usb: misc: iowarrior: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri,  3 Jul 2020 18:41:43 +0100
Message-Id: <20200703174148.2749969-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/misc/iowarrior.c:251: warning: Function parameter or member 'dev' not described in 'iowarrior_delete'
 drivers/usb/misc/iowarrior.c:279: warning: Function parameter or member 'file' not described in 'iowarrior_read'
 drivers/usb/misc/iowarrior.c:279: warning: Function parameter or member 'buffer' not described in 'iowarrior_read'
 drivers/usb/misc/iowarrior.c:279: warning: Function parameter or member 'count' not described in 'iowarrior_read'
 drivers/usb/misc/iowarrior.c:279: warning: Function parameter or member 'ppos' not described in 'iowarrior_read'
 drivers/usb/misc/iowarrior.c:483: warning: Function parameter or member 'file' not described in 'iowarrior_ioctl'
 drivers/usb/misc/iowarrior.c:483: warning: Function parameter or member 'cmd' not described in 'iowarrior_ioctl'
 drivers/usb/misc/iowarrior.c:483: warning: Function parameter or member 'arg' not described in 'iowarrior_ioctl'
 drivers/usb/misc/iowarrior.c:599: warning: Function parameter or member 'inode' not described in 'iowarrior_open'
 drivers/usb/misc/iowarrior.c:599: warning: Function parameter or member 'file' not described in 'iowarrior_open'
 drivers/usb/misc/iowarrior.c:647: warning: Function parameter or member 'inode' not described in 'iowarrior_release'
 drivers/usb/misc/iowarrior.c:647: warning: Function parameter or member 'file' not described in 'iowarrior_release'
 drivers/usb/misc/iowarrior.c:753: warning: Function parameter or member 'interface' not described in 'iowarrior_probe'
 drivers/usb/misc/iowarrior.c:753: warning: Function parameter or member 'id' not described in 'iowarrior_probe'
 drivers/usb/misc/iowarrior.c:879: warning: Function parameter or member 'interface' not described in 'iowarrior_disconnect'

Cc: Johan Hovold <johan@kernel.org>
Cc: Christian Lucht <lucht@codemercs.com>
Cc: Stephane Dalton <sdalton@videotron.ca>
Cc: Stephane Doyon <s.doyon@videotron.ca>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/misc/iowarrior.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 40e8c06894bff..4afd1ace3d32c 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -244,7 +244,7 @@ static void iowarrior_write_callback(struct urb *urb)
 	wake_up_interruptible(&dev->write_wait);
 }
 
-/**
+/*
  *	iowarrior_delete
  */
 static inline void iowarrior_delete(struct iowarrior *dev)
@@ -271,7 +271,7 @@ static int read_index(struct iowarrior *dev)
 	return (read_idx == intr_idx ? -1 : read_idx);
 }
 
-/**
+/*
  *  iowarrior_read
  */
 static ssize_t iowarrior_read(struct file *file, char __user *buffer,
@@ -475,7 +475,7 @@ static ssize_t iowarrior_write(struct file *file,
 	return retval;
 }
 
-/**
+/*
  *	iowarrior_ioctl
  */
 static long iowarrior_ioctl(struct file *file, unsigned int cmd,
@@ -592,7 +592,7 @@ static long iowarrior_ioctl(struct file *file, unsigned int cmd,
 	return retval;
 }
 
-/**
+/*
  *	iowarrior_open
  */
 static int iowarrior_open(struct inode *inode, struct file *file)
@@ -640,7 +640,7 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 	return retval;
 }
 
-/**
+/*
  *	iowarrior_release
  */
 static int iowarrior_release(struct inode *inode, struct file *file)
@@ -742,7 +742,7 @@ static struct usb_class_driver iowarrior_class = {
 /*---------------------------------*/
 /*  probe and disconnect functions */
 /*---------------------------------*/
-/**
+/*
  *	iowarrior_probe
  *
  *	Called by the usb core when a new device is connected that it thinks
@@ -870,7 +870,7 @@ static int iowarrior_probe(struct usb_interface *interface,
 	return retval;
 }
 
-/**
+/*
  *	iowarrior_disconnect
  *
  *	Called by the usb core when the device is removed from the system.
-- 
2.25.1

