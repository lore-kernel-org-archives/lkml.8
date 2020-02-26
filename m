Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA3C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785E420714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFh6ikaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBZSsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:48:16 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:56180 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgBZSsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:48:16 -0500
Received: by mail-wr1-f74.google.com with SMTP id m15so134877wrs.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XFu4BAAnBJ1eBI/euRsrVTFYhhqtxZPZ7+UVeILt+R0=;
        b=wFh6ikajptol6pVIDB4Rq/3sIfL5kR1w5srYe240ZS/5UXqj4mmPa1nhL9ZF+ix4WX
         8Q0OPOzI3SXCJ4d3N1kUn3uGc/OntiMAEwX6jyzuAljcI2p/dmmXDcFgNBKejv2mDDT/
         nM8Hk7V6BYz+zV7K3txmfc9iHJUx5CL7nuAD+beXYNOu7q3XSCE8ghzYQ5K/cwtIKRq6
         jZ5ZB7SQuTXzBrVyic5Dr/Wr5Q16s2yQyZWwg/iKWfjDVFOIHSseqpxE/gPHGHrGjldA
         SbriZ7OkWAqvmfGIenef6oqW9Jdkxcrf1YDUckqvcVZHsx0dT46V4nLq/sJtlE7NHUJt
         geEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XFu4BAAnBJ1eBI/euRsrVTFYhhqtxZPZ7+UVeILt+R0=;
        b=Tffe2rFAcn5NPZ+qih39TkijRpKOUjejxoyBvVNIPbBWigNEDnT4Ll3ew9E67j+I/u
         eWNkfO7TzXduh0gFCBo+BXKsvrpUzVwR1LUlx/YETCTF4PMr9dEmOJQWpqyKl060l5oO
         kWQlKT9GRnjoH3DM8yy807ld3uFTaq+kJHEbE2w/zc3FgDZC8LzmoWw6PmioMPSMdOoN
         rQ2a0jILD14MBCJNePeKHtd0GGdF4KnLG7bx6lmN8XBwDgQcAdv79ZbUHmzeHmdW+aJl
         IH0biUTX6qbPQSeU5DjzEIwVvojS61Up9ThnbtEV3b0pYyagYf4Q/YfL90gVkvLk3Q6L
         gKwA==
X-Gm-Message-State: APjAAAUVJLcIzeXgGHlT3ilpk5KA04Bv5XQRBY5OofYQb0Md5iHFT9Bf
        ESH+ZzZgvFKqTfnkIhxvLXm9pwOtRWGCO7hE
X-Google-Smtp-Source: APXvYqwDNhzzrF80ka1+pp4L4/UF5mod2pvXOHAZRzY7tn8g9fXtttyvseGLJftSYc968s9tFVrX87LAFLfCLd55
X-Received: by 2002:adf:fecf:: with SMTP id q15mr43626wrs.360.1582742893877;
 Wed, 26 Feb 2020 10:48:13 -0800 (PST)
Date:   Wed, 26 Feb 2020 19:48:06 +0100
Message-Id: <cover.1582742673.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v1 0/3] kcov: collect coverage from usb soft interrupts
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends kcov to allow collecting coverage from soft
interrupts and then uses the new functionality to collect coverage from
USB code.

This has allowed to find at least one new HID bug [1], which was recently
fixed by Alan [2].

[1] https://syzkaller.appspot.com/bug?extid=09ef48aa58261464b621
[2] https://patchwork.kernel.org/patch/11283319/

This patchset has been pushed to the public Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2225

Changes RFC -> v1:
- Don't support hardirq or nmi, only softirq, to avoid issues with nested
  interrupts.
- Combined multiple per-cpu variables into one.
- Used plain accesses and kcov_start/stop() instead of xchg()'s.
- Simplified handling of per-cpu variables.
- Avoid disabling interrupts for the whole kcov_remote_start/stop()
  region.
- Avoid overwriting t->kcov_sequence when saving/restoring state.
- Move kcov_remote_start/stop_usb() annotations into
  __usb_hcd_giveback_urb() to cover all urb complete() callbacks at once.
- Drop unneeded Dummy HCD changes.
- Split out a patch that removed debug messages.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Andrey Konovalov (3):
  kcov: cleanup debug messages
  kcov: collect coverage from interrupts
  usb: core: kcov: collect coverage from usb complete callback

 Documentation/dev-tools/kcov.rst |  17 +--
 drivers/usb/core/hcd.c           |   3 +
 include/linux/sched.h            |   3 +
 kernel/kcov.c                    | 187 ++++++++++++++++++++-----------
 lib/Kconfig.debug                |   9 ++
 5 files changed, 147 insertions(+), 72 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

