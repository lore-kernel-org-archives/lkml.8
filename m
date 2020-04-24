Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF339C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9727920706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzXG651t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgDXPB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727772AbgDXPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:01:28 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982FCC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:01:26 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id m5so4897158wru.15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vPweaUu0n8N5ojVI6YTHlNR6RVae+s1ZfL4NXpGDEY8=;
        b=CzXG651tqQGpLYABpTDUIWCPrBKtlNyPiKq2JvQ7XiWDgddU5MRSUeEDzupHu+4Oyb
         765grjuzBU1V/mqSKzgqnANCL+eZM0Js72WVBbPamB90SsD02Jlf8ookkEKnFLVLrkTV
         PtUYdWZ9AzGNy3Q0aBNrBUguEJEJpnh34geuHt0CEuQ9Jm7mN1Eoil5HwaMtHETi0htn
         D10kRvCoGCIk9/obRUq5+MoDz18475ZI7dIwhp1BEqeBcToOzZS8FjQh24klg0ej4SiU
         nxo6/Ua/UE6WD1EtlLv7v6ECbN2vtaAWIbDPwVKGf3/DrYXS3esGwSBMVRnF7qn5vZaT
         WVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vPweaUu0n8N5ojVI6YTHlNR6RVae+s1ZfL4NXpGDEY8=;
        b=j7im3JhL4S0yqPlY4i1avYhWt/O1zCaDdWbVGsIrHeP4lCFV3C2MiiBD+QHdgOLzR5
         WEsve/r/8MryKCB9135RUiwxMj86mWYtTKdCWYyWA7+MMoiUkPO2FSBE2OWeoSClBpAD
         /m1akhql7R0ccsm2FBpZfyfsPyQsWyQGJkAULa9wgbI2tix5siIZ/B9DpP1YVCyiNAy1
         pROAGlJTRZlHDSQ55WfIqXfUP30lp18e32NpLehEmDKvOKDJWo4a+uogNwak7B19mpz/
         lO/bxSFi2k00b1Lu5Pi4M/2qcFeeCDWdx5HxRamRPVbkrjYS6yC1lByyXeP6LkUFJGEM
         nnCQ==
X-Gm-Message-State: AGi0Puao4ftf1NDhkatRAPNQ29aSXZBmzIKW4MTH13mSBjHydZ2yVBeE
        n/jGcYmA/IGQRP2dCb91BwN7L8xN9IZesGtF
X-Google-Smtp-Source: APiQypKi6/7PAgEPPWLjNplmNSxX7MjIwrXlxZnQNxOtf329JhltiqzMVd1HjrrdLB4CXuk1PiqX2VDx28fBO85O
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr11760768wrm.106.1587740484984;
 Fri, 24 Apr 2020 08:01:24 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:01:19 +0200
In-Reply-To: <9c99c508da044822baf53db5e3fccd4f21b0f8d3.1587734346.git.andreyknvl@google.com>
Message-Id:
 <635f48fcb4bb99c70ab9d7f0dfe84d1ec7dc540e.1587734346.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <9c99c508da044822baf53db5e3fccd4f21b0f8d3.1587734346.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH USB v2 2/2] usb: raw-gadget: fix typo in uapi headers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200424150119.Nu2QaDhQqNc2EQHMQ0TmeS-AeZiVZLa63sBEJ-SzTL4@z>

Change "trasferred" into "transferred".

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Changes in v2:

- Updated commit message.

---
 include/uapi/linux/usb/raw_gadget.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/usb/raw_gadget.h b/include/uapi/linux/usb/raw_gadget.h
index ea375082b3ac..8544802b25bd 100644
--- a/include/uapi/linux/usb/raw_gadget.h
+++ b/include/uapi/linux/usb/raw_gadget.h
@@ -119,7 +119,7 @@ struct usb_raw_ep_io {
  * received on endpoint 0, provided that was an IN (OUT for READ) request and
  * waits until the urb is completed. Copies received data to user for READ.
  * Accepts a pointer to the usb_raw_ep_io struct as an argument.
- * Returns length of trasferred data on success or negative error code on
+ * Returns length of transferred data on success or negative error code on
  * failure.
  */
 #define USB_RAW_IOCTL_EP0_WRITE		_IOW('U', 3, struct usb_raw_ep_io)
@@ -145,7 +145,7 @@ struct usb_raw_ep_io {
  * request and waits until the urb is completed. Copies received data to user
  * for READ.
  * Accepts a pointer to the usb_raw_ep_io struct as an argument.
- * Returns length of trasferred data on success or negative error code on
+ * Returns length of transferred data on success or negative error code on
  * failure.
  */
 #define USB_RAW_IOCTL_EP_WRITE		_IOW('U', 7, struct usb_raw_ep_io)
-- 
2.26.2.303.gf8c07b1a785-goog

