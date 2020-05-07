Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83ACC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA73207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJ2cM97l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEGRHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727978AbgEGRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:07:14 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62262C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:07:14 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y31so7486437qta.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7/PrXCrrp5hii78pLoOm9OApKV03tezSTtbf21wn2GQ=;
        b=vJ2cM97lrsVanMLQWlqZTgaTuRFdaYInxkAXTc1yX40b8vt+T925FTXgJal0sutkm/
         Qod3Kghc5YBrrYcrNJdKZwVj5qtIf40beNkJT2yW5S1C0QnqVbWws9SKTPfagLcfREO0
         gD5X+dGPLcTZSDKGFGnChODgWTY5EzyAPi3VA+ZD5mmDoS2rduAzlZDc9L0scC8/LOx+
         2qCOly+pNoVVgZZEwX0oZ/iaAYI3wIKJXNyiSIRtdzCGKHRVlnZ6U2ahWUcez0t8gRHy
         38s5DeSTRojmMQcMWprmAHfOoWWA77z3TSlb4p86rDN++UNEQNfB3iEnJHTvlHLGMl7Z
         t4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7/PrXCrrp5hii78pLoOm9OApKV03tezSTtbf21wn2GQ=;
        b=A0sq4uKrmYZ9NF06m4ysu8khMCfHHTwM8XXm9bxJOlshSMbhEZGZkN1YSmG52DpTXX
         0b+a8aTESSWDkYBQhAW0OVJhZ/aIulzTATA4BCFGia7EkS2Hb2R1sF5xHvLv/zRP3u90
         83eW9a2lNY9e8D1rjdPNrTHZETr2G6s6At5JlTZYtOuLenJP7FygFFbYgPtHeF/Qd1j6
         YZJiR38vLZpQbCfL/Ee2pNLlWTTdqFH9t/qtzHtNpTzxr92RgFrGgXdAZkrspnIgHkUR
         CQ0CUictfkMvzRgOWAB2aIVHlWfY1MpGlT8C4x69GMpFw6YHQBbjC6sulWFdMhoN74NR
         n/bA==
X-Gm-Message-State: AGi0PuY5RhixTlpPpboK+GobxFHV7LEBrs7WEByk8P+oLrQt3OMxPcck
        Axfvg+4xhK+UCrCBPOtUyKNGv2mTEFpEhE7E
X-Google-Smtp-Source: APiQypIy9HLMvQvr1IoBhkEe19b6+HAz9x1jbIn1bDPc6Z2265SQK2szy4myS1YuI24410DJjPCvk1IQhD93SQVM
X-Received: by 2002:a0c:ffa3:: with SMTP id d3mr14017803qvv.12.1588871233518;
 Thu, 07 May 2020 10:07:13 -0700 (PDT)
Date:   Thu,  7 May 2020 19:06:58 +0200
In-Reply-To: <cover.1588870822.git.andreyknvl@google.com>
Message-Id: <b07af6ea7091afe7aa528b3015e041999aeebe97.1588870822.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1588870822.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH USB v3 5/5] usb: raw-gadget: documentation updates
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

Mention the issue with fixed UDC addresses.

Links external examples and test suite.

Add more implmenetation details and potential improvements.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/usb/raw-gadget.rst | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/usb/raw-gadget.rst b/Documentation/usb/raw-gadget.rst
index 3b3d78e850b2..68d879a8009e 100644
--- a/Documentation/usb/raw-gadget.rst
+++ b/Documentation/usb/raw-gadget.rst
@@ -49,10 +49,36 @@ The typical usage of Raw Gadget looks like:
    Raw Gadget and react to those depending on what kind of USB device
    needs to be emulated.
 
+Note, that some UDC drivers have fixed addresses assigned to endpoints, and
+therefore arbitrary endpoint addresses can't be used in the descriptors.
+Nevertheles, Raw Gadget provides a UDC-agnostic way to write USB gadgets.
+Once a USB_RAW_EVENT_CONNECT event is received via USB_RAW_IOCTL_EVENT_FETCH,
+the USB_RAW_IOCTL_EPS_INFO ioctl can be used to find out information about
+endpoints that the UDC driver has. Based on that information, the user must
+chose UDC endpoints that will be used for the gadget being emulated, and
+properly assign addresses in endpoint descriptors.
+
+You can find usage examples (along with a test suite) here:
+
+https://github.com/xairy/raw-gadget
+
+Internal details
+~~~~~~~~~~~~~~~~
+
+Currently every endpoint read/write ioctl submits a USB request and waits until
+its completion. This is the desired mode for coverage-guided fuzzing (as we'd
+like all USB request processing happen during the lifetime of a syscall),
+and must be kept in the implementation. (This might be slow for real world
+applications, thus the O_NONBLOCK improvement suggestion below.)
+
 Potential future improvements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- Reporting more events (suspend, resume, etc.) through
-  USB_RAW_IOCTL_EVENT_FETCH.
+- Report more events (suspend, resume, etc.) through USB_RAW_IOCTL_EVENT_FETCH.
 
 - Support O_NONBLOCK I/O.
+
+- Support USB 3 features (accept SS endpoint companion descriptor when
+  enabling endpoints; allow providing stream_id for bulk transfers).
+
+- Support ISO transfer features (expose frame_number for completed requests).
-- 
2.26.2.526.g744177e7f7-goog

