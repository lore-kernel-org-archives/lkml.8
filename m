Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7ACC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B469F206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tb+/K0K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgGFNds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgGFNdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1818C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so42072018wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtWn8hsOXI1tl0MUhSmyvGeFes81dlof0v8VW7+fdbw=;
        b=tb+/K0K1eA704mpMyghl55v/zWI4mSEucjEWMkto05EJAwtt81Tuc5Ialuiq8LeS2R
         x7eNhrR5yGpofVpGMlUc+dGvW6hOfzZAKfuPvTYOL9cr6csy+Q7aT4rJAe+QBVgDpCWB
         JmX38nI6hJKRDaLdaCbKahq0CK0atprPWa2Wn5hZzUEnnjAXQrcx+95LGiam9CAdWbmM
         QFxzd5VOEiDqMgyMUKWN0JEn5Yco8m9QTRctmmUjIDZ2rJKKvS/HJF17k9YJnzu5eULF
         XF3nsJOJPonHF1SaySMBGld80Ol8vOnadKhByaY0CkSeG7cHOObHZPhTkBpFLNt2aOaX
         OXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtWn8hsOXI1tl0MUhSmyvGeFes81dlof0v8VW7+fdbw=;
        b=qoWmyeRbjlIyIeHbetmE6wWIqA2jJ3OPdLKKtWO/rY0nqtdKnuIgSxxUPCt5XlU7vd
         /md7HLxD6yjzU3Is+aafwO41ZCRxKc1oaPmhYF5wr7XfVBeS7PKlAPBy0x7Tdev6DjCE
         RQ/q5osonfuBB3MTWNpn/wU6w4WqtDoJRbHqQptEQI0TlrD9Shr6ldchRpVsin0ARpwH
         +5vQmGgxzAe88v1yOf/r0m6D0U2buK7dYsiP6t/8sx42jlp7icLXyD2lEq8obYW38HbK
         uFV6sNHR/hirIjt3w+Q1T95G+/jgtv8xNK9Pkf2HOGzlBnXhn0xubKvwTfvyyo/mkMpx
         ziUg==
X-Gm-Message-State: AOAM530NdtrSk3Dz78NJ7glQR9eIDoR6tako35RTWhqNoHhSXONOruf+
        qTQ+EacVF2m/KTadk0GGLJnjbg==
X-Google-Smtp-Source: ABdhPJxVTByOnTI298yDjNpJQ+8K3fWLg5oZdMazHD2udtCJrLX53D0eLnbVRozcdO4IHjwxa9apZQ==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr51110615wma.4.1594042425621;
        Mon, 06 Jul 2020 06:33:45 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Juergen Stuber <starblue@users.sourceforge.net>,
        David Glance <davidgsf@sourceforge.net>,
        david <david@csse.uwa.edu.au>,
        legousb-devel@lists.sourceforge.net
Subject: [PATCH 01/32] usb: misc: legousbtower: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Mon,  6 Jul 2020 14:33:10 +0100
Message-Id: <20200706133341.476881-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/misc/legousbtower.c:280: warning: Function parameter or member 'dev' not described in 'lego_usb_tower_debug_data'
 drivers/usb/misc/legousbtower.c:280: warning: Function parameter or member 'function' not described in 'lego_usb_tower_debug_data'
 drivers/usb/misc/legousbtower.c:280: warning: Function parameter or member 'size' not described in 'lego_usb_tower_debug_data'
 drivers/usb/misc/legousbtower.c:280: warning: Function parameter or member 'data' not described in 'lego_usb_tower_debug_data'
 drivers/usb/misc/legousbtower.c:290: warning: Function parameter or member 'dev' not described in 'tower_delete'
 drivers/usb/misc/legousbtower.c:306: warning: Function parameter or member 'inode' not described in 'tower_open'
 drivers/usb/misc/legousbtower.c:306: warning: Function parameter or member 'file' not described in 'tower_open'
 drivers/usb/misc/legousbtower.c:405: warning: Function parameter or member 'inode' not described in 'tower_release'
 drivers/usb/misc/legousbtower.c:405: warning: Function parameter or member 'file' not described in 'tower_release'
 drivers/usb/misc/legousbtower.c:452: warning: Function parameter or member 'dev' not described in 'tower_check_for_read_packet'
 drivers/usb/misc/legousbtower.c:468: warning: Function parameter or member 'file' not described in 'tower_poll'
 drivers/usb/misc/legousbtower.c:468: warning: Function parameter or member 'wait' not described in 'tower_poll'
 drivers/usb/misc/legousbtower.c:494: warning: Function parameter or member 'file' not described in 'tower_llseek'
 drivers/usb/misc/legousbtower.c:494: warning: Function parameter or member 'off' not described in 'tower_llseek'
 drivers/usb/misc/legousbtower.c:494: warning: Function parameter or member 'whence' not described in 'tower_llseek'
 drivers/usb/misc/legousbtower.c:503: warning: Function parameter or member 'file' not described in 'tower_read'
 drivers/usb/misc/legousbtower.c:503: warning: Function parameter or member 'buffer' not described in 'tower_read'
 drivers/usb/misc/legousbtower.c:503: warning: Function parameter or member 'count' not described in 'tower_read'
 drivers/usb/misc/legousbtower.c:503: warning: Function parameter or member 'ppos' not described in 'tower_read'
 drivers/usb/misc/legousbtower.c:587: warning: Function parameter or member 'file' not described in 'tower_write'
 drivers/usb/misc/legousbtower.c:587: warning: Function parameter or member 'buffer' not described in 'tower_write'
 drivers/usb/misc/legousbtower.c:587: warning: Function parameter or member 'count' not described in 'tower_write'
 drivers/usb/misc/legousbtower.c:587: warning: Function parameter or member 'ppos' not described in 'tower_write'
 drivers/usb/misc/legousbtower.c:669: warning: Function parameter or member 'urb' not described in 'tower_interrupt_in_callback'
 drivers/usb/misc/legousbtower.c:724: warning: Function parameter or member 'urb' not described in 'tower_interrupt_out_callback'
 drivers/usb/misc/legousbtower.c:752: warning: Function parameter or member 'interface' not described in 'tower_probe'
 drivers/usb/misc/legousbtower.c:752: warning: Function parameter or member 'id' not described in 'tower_probe'
 drivers/usb/misc/legousbtower.c:863: warning: Function parameter or member 'interface' not described in 'tower_disconnect'

Cc: Juergen Stuber <starblue@users.sourceforge.net>
Cc: David Glance <davidgsf@sourceforge.net>
Cc: david <david@csse.uwa.edu.au>
Cc: legousb-devel@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/misc/legousbtower.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
index ab4b98b041158..8aca55c4c95f1 100644
--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -283,7 +283,7 @@ static inline void lego_usb_tower_debug_data(struct device *dev,
 }
 
 
-/**
+/*
  *	tower_delete
  */
 static inline void tower_delete(struct lego_usb_tower *dev)
@@ -299,7 +299,7 @@ static inline void tower_delete(struct lego_usb_tower *dev)
 }
 
 
-/**
+/*
  *	tower_open
  */
 static int tower_open(struct inode *inode, struct file *file)
@@ -398,7 +398,7 @@ static int tower_open(struct inode *inode, struct file *file)
 	return retval;
 }
 
-/**
+/*
  *	tower_release
  */
 static int tower_release(struct inode *inode, struct file *file)
@@ -440,7 +440,7 @@ static int tower_release(struct inode *inode, struct file *file)
 	return retval;
 }
 
-/**
+/*
  *	tower_check_for_read_packet
  *
  *      To get correct semantics for signals and non-blocking I/O
@@ -461,7 +461,7 @@ static void tower_check_for_read_packet(struct lego_usb_tower *dev)
 }
 
 
-/**
+/*
  *	tower_poll
  */
 static __poll_t tower_poll(struct file *file, poll_table *wait)
@@ -487,7 +487,7 @@ static __poll_t tower_poll(struct file *file, poll_table *wait)
 }
 
 
-/**
+/*
  *	tower_llseek
  */
 static loff_t tower_llseek(struct file *file, loff_t off, int whence)
@@ -496,7 +496,7 @@ static loff_t tower_llseek(struct file *file, loff_t off, int whence)
 }
 
 
-/**
+/*
  *	tower_read
  */
 static ssize_t tower_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
@@ -580,7 +580,7 @@ static ssize_t tower_read(struct file *file, char __user *buffer, size_t count,
 }
 
 
-/**
+/*
  *	tower_write
  */
 static ssize_t tower_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
@@ -662,7 +662,7 @@ static ssize_t tower_write(struct file *file, const char __user *buffer, size_t
 }
 
 
-/**
+/*
  *	tower_interrupt_in_callback
  */
 static void tower_interrupt_in_callback(struct urb *urb)
@@ -717,7 +717,7 @@ static void tower_interrupt_in_callback(struct urb *urb)
 }
 
 
-/**
+/*
  *	tower_interrupt_out_callback
  */
 static void tower_interrupt_out_callback(struct urb *urb)
@@ -742,7 +742,7 @@ static void tower_interrupt_out_callback(struct urb *urb)
 }
 
 
-/**
+/*
  *	tower_probe
  *
  *	Called by the usb core when a new device is connected that it thinks
@@ -854,7 +854,7 @@ static int tower_probe(struct usb_interface *interface, const struct usb_device_
 }
 
 
-/**
+/*
  *	tower_disconnect
  *
  *	Called by the usb core when the device is removed from the system.
-- 
2.25.1

