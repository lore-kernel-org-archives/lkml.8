Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9852AC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E80420724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rb7245Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgCQOyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:54:39 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:52597 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgCQOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:37 -0400
Received: by mail-wm1-f73.google.com with SMTP id z16so1932252wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YnO147Q8BfuYNBKiEQsszIXKG8E9VejO4ffbcq8Gn6s=;
        b=rb7245Ras6C7y9qgw0zRxUstsDae6mXfHrz3F0GCcwWusok6lOSl/FLtbSXIBAlfAG
         pU/Gc01TdHjEAD4RfQa/mEescGcs/dwrVlhAnEPTrur54OVdeD9V/IPqXQltBDrIQcAq
         w5v2wYv0hqb6T+pGK/4MoPsHM2iKQUTFPPDlAjc58y6ffDaiF7ZLFM2RsEHZUuf6TV3y
         v/cxYLxN3MhtmcqrOWqQIdPF0F4Ryn42SoLljX47Z474bt+Zub1SNNH/dbIRzaEAJTAS
         clot3+jzM4JYF2HrHvCZTpgXRO97oyhUoguzWKDL/nbP8jQFTPsEnjANlJYJBmR8SHF/
         1v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YnO147Q8BfuYNBKiEQsszIXKG8E9VejO4ffbcq8Gn6s=;
        b=gT6Uouk2o30BcfZ5B3qSSL7iBTXZcgNorjKOHEJunYi2nv1VmYTIUbjatQzHNkbJ9g
         Q8e9kuKNSiT5Jd73q00fAj00Mwpq2r/Kb+Axlm2IAWT3KC2x5Q7wWpcl8UdFBL6h66P/
         n1vDn3mzF8nRD1uD88WwYAFNaS7FXp9ADVwucejsS0HZJBSYa0MGttlgELpSjr+Md6dt
         d2ChCW43a/PdkaOghD3KJLgc84kMJM+z3KW3s06utjNUPAx+VFpu/112gufURBe8ItkF
         T0J+tY7KOyJJErc8HoSNlAmKbdGbiX6jmaWjOsuyP2+f1HRJDaMQKk9b4RJVp9afnbv2
         Ub0A==
X-Gm-Message-State: ANhLgQ0fkd1IQ4L5GpvF7Qn9xC27v2yrVFD6rusrHdsRTeF25rL+pyxS
        ez5h+5C7QtIhv09VUdSdM/Ly/w4MY3sFvkXj
X-Google-Smtp-Source: ADFU+vuk+Yi3YFMcAI8MRlwoyHn7t0KCazaq6gRywdKYSzsiW1YSWh93dqA033BnLe0hih5cIW9z1npcTigPA9W1
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr6163103wrx.134.1584456876192;
 Tue, 17 Mar 2020 07:54:36 -0700 (PDT)
Date:   Tue, 17 Mar 2020 15:54:31 +0100
Message-Id: <6206b80b3810f95bfe1d452de45596609a07b6ea.1584456779.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH USB] usb: raw_gadget: fix compilation warnings in uapi headers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
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

