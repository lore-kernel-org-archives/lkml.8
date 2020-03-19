Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF7BC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9398E20775
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vB+ZL9tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCSWM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:12:28 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:57829 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgCSWL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:11:56 -0400
Received: by mail-wm1-f74.google.com with SMTP id f9so1571976wme.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YnO147Q8BfuYNBKiEQsszIXKG8E9VejO4ffbcq8Gn6s=;
        b=vB+ZL9tqVJcAaugYExOK+dJD6+VoZcjwf8huI233jMEi3vlRlVuYfR1w59pAYyeFGq
         0aurG5XHAmhfR8rO2twUDX/4MryFExVZrl/dJSy5dykP/iCH1PEasHHK5+ss0Ym4bUEM
         olqhzUpErgFqM91GnmPbCOTR5hvGOqwKcsO712Fjc3akBkUfGXOTkBdTNnMV+rU6BQp3
         AAXIEM9/rHEXjzHDwq+M+wqVkOrVquJ/6ycsUSTZfqbQdkVCVImonQTDCAGkVxkKalHx
         E4y+UlMw8USVNIKzX/JBBYaX/q6Ae0Fs7FTSPlDSTtCbUNrqeao2o8okL2/UFXaJkYli
         QvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YnO147Q8BfuYNBKiEQsszIXKG8E9VejO4ffbcq8Gn6s=;
        b=LdZS2Wg7EhgegBEQLmTlVbvTETPLmI57PlRawptGuYzviYBsAfOg4lx/vyqTJwasuu
         RqQcV/ONVeuK1l8uw30nXCrrWLR52crH80HkhUXzZtRbSHRDrmgzwbqoSaGhgqPF8mGq
         HZMjrcsKSwhBJYUgKu3iA+RSEKwZcMhZe2BxRUUDqwZvcIXaJCLlg1bzxlzfMn+njnvC
         nPWCg+wy/A0SqSVnab/GjXzZblfSnqOKIRerz21/7zs+PmGv3QZmbtjei7/5C+JCtOj2
         6K3k/1uyzkZwZUY5Po7fe4YeL8sDkfo/4dKJvdyaVqyHYXPmS1qznoHwggDR+KsAbigF
         JNHw==
X-Gm-Message-State: ANhLgQ3oFXuyXQapOVV+y7watq5cJJooefSr81ODAgR3aOmrBwUDgKUC
        edIUENTEuifemVqQvEiF9I4c/xTE70wTPYPH
X-Google-Smtp-Source: ADFU+vuhAnTFDp93u9bxNSwjdWx/XQWCDLYMfqinwA2kIZ5a3q7WAgPMw2RqRpTpBZ9kpYOKEBjFQrTOyHIYYPnf
X-Received: by 2002:adf:97d5:: with SMTP id t21mr6512634wrb.45.1584655912665;
 Thu, 19 Mar 2020 15:11:52 -0700 (PDT)
Date:   Thu, 19 Mar 2020 23:11:35 +0100
In-Reply-To: <cover.1584655448.git.andreyknvl@google.com>
Message-Id:
 <6206b80b3810f95bfe1d452de45596609a07b6ea.1584456779.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1584655448.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH USB] usb: raw_gadget: fix compilation warnings in uapi headers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200319221135.OTg6dkAoCF6zWhLtnAsh7MfVf_1oplED4d-47poznp0@z>

Mark usb_raw_io_flags_valid() and usb_raw_io_flags_zero() as inline to
fix the following warnings:

./usr/include/linux/usb/raw_gadget.h:69:12: warning: unused function 'usb_raw_io_flags_valid' [-Wunused-function]
./usr/include/linux/usb/raw_gadget.h:74:12: warning: unused function 'usb_raw_io_flags_zero' [-Wunused-function]

Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/uapi/linux/usb/raw_gadget.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/usb/raw_gadget.h b/include/uapi/linux/usb/raw_gadget.h
index 00cbded71061..ea375082b3ac 100644
--- a/include/uapi/linux/usb/raw_gadget.h
+++ b/include/uapi/linux/usb/raw_gadget.h
@@ -66,12 +66,12 @@ struct usb_raw_event {
 #define USB_RAW_IO_FLAGS_ZERO	0x0001
 #define USB_RAW_IO_FLAGS_MASK	0x0001
 
-static int usb_raw_io_flags_valid(__u16 flags)
+static inline int usb_raw_io_flags_valid(__u16 flags)
 {
 	return (flags & ~USB_RAW_IO_FLAGS_MASK) == 0;
 }
 
-static int usb_raw_io_flags_zero(__u16 flags)
+static inline int usb_raw_io_flags_zero(__u16 flags)
 {
 	return (flags & USB_RAW_IO_FLAGS_ZERO);
 }
-- 
2.25.1.481.gfbce0eb801-goog

