Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7A6C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DED8207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xjw3YQDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEGRHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgEGRHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:07:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A64C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:07:07 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id n22so7499823qtp.15
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UkoJB8mrsXvJ/mhp+/IOB9nRbu0RcDR5Saku4Tm8lGU=;
        b=Xjw3YQDKpPMme3PoqQQ8vRC+br/9ZRYJ4YydUX3wxHjW+x/HraXRlU2zOvDpyfLcPP
         Btez9FR8imo7LTgnaUc/gY4ZG86nZRSDftd2/vztY842ug21by/oURrcAcqSsGnVYoDO
         0OB5b8lSBjwo0NEDK3Mxh8rGzzb12C4eKxqmHWHVG0xyvLP2j0jGYIbzMgfsWfRv2rmB
         Nn6m19H0Ja+JeqCrlyMt+GKcqce8aM2cMEmCbpj/RsSaAZeiv+Cb0yF/uYgHcF5OYSLN
         UUf+j2a6w/QK34V3y37ELg2p9yfZb9LB10hnOoLoC/EVsSr46tfZOxswwqOop86EQgQu
         SAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UkoJB8mrsXvJ/mhp+/IOB9nRbu0RcDR5Saku4Tm8lGU=;
        b=oDOiFUpcRgIS+AUjVrgNpKvts2q2ZF8P1FQ586kUkeP95PjWQtMQOIYbwbDpQBwQsv
         1XvuyeJqd/N6tsmzkMCE/uP1E/hnRKwN+AFMz+1W9lhYC8J5SYbjmipAIq97NVt0zY7W
         WPS48jTaJw/Nmuyj7gXmHx62/Aqha5Yzy0NFn3PQx9GCko3UmeBNBsxrBX0C0K833+0g
         HBNpLO/iZ8Ke1646Mq7tJxgo8UaldDzro/jmbG1LEM6jGPk5tFU6coehDj2ZGLKDNov5
         rwEAW34ZT90OSSbTWwNcmaB9262N+6bC0hsuNfoYgKk1qeGWu3IRueKY2kgUUw3LV6kW
         FVZg==
X-Gm-Message-State: AGi0Puabna7uV52L9i8UmP7PiR/tQZP4lK5LqqX09UybPLt7zZd/0w5m
        q7ZVsQIZKYc5eEu75FTSpCuNWdB+kazX4Y3P
X-Google-Smtp-Source: APiQypLZa2bsIo3FGThkD21eG+RwPhgKjDyYY7K5nvsOcHUVUTmz1VXVMJ/cESbH1ZZ09e9oydvFKZ/4Lr/r9CMd
X-Received: by 2002:a0c:f2d3:: with SMTP id c19mr14261142qvm.109.1588871226725;
 Thu, 07 May 2020 10:07:06 -0700 (PDT)
Date:   Thu,  7 May 2020 19:06:55 +0200
In-Reply-To: <cover.1588870822.git.andreyknvl@google.com>
Message-Id: <f18addecff393ae7d2706c9eec928bdfc0260fec.1588870822.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1588870822.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH USB v3 2/5] usb: raw-gadget: improve uapi headers comments
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

Fix typo "trasferred" => "transferred".

Don't call USB requests URBs.

Fix comment style.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/uapi/linux/usb/raw_gadget.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/usb/raw_gadget.h b/include/uapi/linux/usb/raw_gadget.h
index ea375082b3ac..02885e021ee5 100644
--- a/include/uapi/linux/usb/raw_gadget.h
+++ b/include/uapi/linux/usb/raw_gadget.h
@@ -115,11 +115,11 @@ struct usb_raw_ep_io {
 #define USB_RAW_IOCTL_EVENT_FETCH	_IOR('U', 2, struct usb_raw_event)
 
 /*
- * Queues an IN (OUT for READ) urb as a response to the last control request
- * received on endpoint 0, provided that was an IN (OUT for READ) request and
- * waits until the urb is completed. Copies received data to user for READ.
+ * Queues an IN (OUT for READ) request as a response to the last setup request
+ * received on endpoint 0 (provided that was an IN (OUT for READ) request), and
+ * waits until the request is completed. Copies received data to user for READ.
  * Accepts a pointer to the usb_raw_ep_io struct as an argument.
- * Returns length of trasferred data on success or negative error code on
+ * Returns length of transferred data on success or negative error code on
  * failure.
  */
 #define USB_RAW_IOCTL_EP0_WRITE		_IOW('U', 3, struct usb_raw_ep_io)
@@ -133,19 +133,20 @@ struct usb_raw_ep_io {
  */
 #define USB_RAW_IOCTL_EP_ENABLE		_IOW('U', 5, struct usb_endpoint_descriptor)
 
-/* Disables specified endpoint.
+/*
+ * Disables specified endpoint.
  * Accepts endpoint handle as an argument.
  * Returns 0 on success or negative error code on failure.
  */
 #define USB_RAW_IOCTL_EP_DISABLE	_IOW('U', 6, __u32)
 
 /*
- * Queues an IN (OUT for READ) urb as a response to the last control request
- * received on endpoint usb_raw_ep_io.ep, provided that was an IN (OUT for READ)
- * request and waits until the urb is completed. Copies received data to user
- * for READ.
+ * Queues an IN (OUT for READ) request as a response to the last setup request
+ * received on endpoint usb_raw_ep_io.ep (provided that was an IN (OUT for READ)
+ * request), and waits until the request is completed. Copies received data to
+ * user for READ.
  * Accepts a pointer to the usb_raw_ep_io struct as an argument.
- * Returns length of trasferred data on success or negative error code on
+ * Returns length of transferred data on success or negative error code on
  * failure.
  */
 #define USB_RAW_IOCTL_EP_WRITE		_IOW('U', 7, struct usb_raw_ep_io)
-- 
2.26.2.526.g744177e7f7-goog

