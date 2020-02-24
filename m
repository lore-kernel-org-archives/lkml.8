Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4E3C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9684520838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ox8snbgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgBXQNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:13:10 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:45348 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgBXQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:13:09 -0500
Received: by mail-ua1-f73.google.com with SMTP id h10so1298923uab.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h60gecOqE+CkPbm4fQgbS/Dl80MdiGYEyWLaquQ9wSQ=;
        b=Ox8snbgmpRptmL9zqZZzMCWd9miSlaakRxq5b+8hKP3Yn242ka+PSr3D+Z0cjjsqLZ
         VUU3/kCii9htAhzkEU3llvBIaGwZLd5kXUgP3qKr3lNHHLn1V0JCvCgVXbJDzWW2Z0Km
         Z/S144HTsa9nOCjY3v68Eo7kQqTPoYme2phc5yY914d2MPgffby6E1G/gciDcClsNrPs
         bDhZ/IvTzB3CN2NzTTiDXkemmLTkUIofuSewsyOfC0SJNl2FNkyDeD87RpJoPIG4/KKo
         bUGBVstY6o6OqeKzMEhyUnvXetvVsvQ1fznOBCzfg+uwOYqtZabEtYKz0pSCyXOEswqh
         xyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h60gecOqE+CkPbm4fQgbS/Dl80MdiGYEyWLaquQ9wSQ=;
        b=rHo+j53drjMd13ZVLF4PnJzdHOQ8TjsVWq2i2VkUgw2WaDu21pcZWhfcrNGgVj0lNs
         FZrRrynjBlN9grVaQgtD4UTnYH/zeDqf8Yq5PCIsCFjn0PN+5ntX229zv2IiN2E7he6r
         y12mXsAb6dVVL5oQliNmplYxQImBs+g5FxTz1y9cP7dBf6NVYMPhwtuSYi3lSv8f+ZlT
         RJgSlNG7n5Eg+AJRHGCNv35mSzVUPoGi/oHVoEof5oQSjEYTI6oyrpTSy4MFdTIoCN+q
         ZyWmZ/isHrpwgvixpA8+dEg08dOciSAqPdyZ7wsfG4FAD7RIJXuf+iO2AKwIVokp67eJ
         xKAw==
X-Gm-Message-State: APjAAAUuB9OYAuz3gbTLV6b0yhC7XHJvvowMMmK3XBPcT1eKwsYRCtSJ
        DTGBWn2uCZAUVMVvf0els+6W0Q3BAo54Sgxs
X-Google-Smtp-Source: APXvYqyHYOouo+7ZokPmPMZJo8lMfUVKGwR65i04F8Dcl7WDv1r/VG4+3hLIzOU3dosUsBLyR8+ZT+rVqJHxCCoD
X-Received: by 2002:ab0:74ce:: with SMTP id f14mr24789698uaq.118.1582560787523;
 Mon, 24 Feb 2020 08:13:07 -0800 (PST)
Date:   Mon, 24 Feb 2020 17:13:02 +0100
Message-Id: <cover.1582560596.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 0/1] usb: gadget: add raw-gadget interface
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset (currently a single patch) adds a new userspace interface
for the USB Gadget subsystem called USB Raw Gadget. This is what is
currently being used to enable coverage-guided USB fuzzing with syzkaller:

https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md

Initially I was using GadgetFS (together with the Dummy HCD/UDC module)
to perform emulation of USB devices for fuzzing, but later switched to a
custom written interface. The incentive to implement a different interface
was to provide a somewhat raw and direct access to the USB Gadget layer
for the userspace, where every USB request is passed to the userspace to
get a response. See documentation for the list of differences between
Raw Gadget and GadgetFS.

Currently Raw Gadget only supports blocking I/O mode, that synchronously
waits for the result of each operation to allow collecting coverage per
operation.

This patchset has been pushed to the public Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2144

Changes v5 -> v6:
- Prevent raw_process_ep_io() racing with raw_ioctl_ep_disable() by
  checking urb_queued flag in the latter.
- Use GFP_KERNEL instead of GFP_ATOMIC where possible.
- Reject opening raw-gadget with O_NONBLOCK to allow future extensions to
  support nonblocking IO.
- Reduce RAW_EVENT_QUEUE_SIZE to 16.

Changes v4 -> v5:
- Specified explicit usb_raw_event_type enum values for all entries.
- Dropped pointless locking in gadget_unbind().

Changes v3 -> v4:
- Print debug message when maxpacket check fails.
- Use module_misc_device() instead of module_init/exit().
- Reuse DRIVER_NAME macro in raw_device struct definition.
- Don't print WARNING in raw_release().
- Add comment that explains locking into raw_event_queue_fetch().
- Print a WARNING when event queue size is exceeded.
- Rename raw.c to raw_gadget.c.
- Mention module name in Kconfig.
- Reworked logging to use dev_err/dbg() instead of pr_err/debug().

Changes v2 -> v3:
- Updated device path in documentation.
- Changed usb_raw_init struct layout to make it the same for 32 bit compat
  mode.
- Added compat_ioctl to raw_fops.
- Changed raw_ioctl_init() to return EINVAL for invalid USB speeds, except
  for USB_SPEED_UNKNOWN, which defaults to USB_SPEED_HIGH.
- Reject endpoints with maxpacket = 0 in raw_ioctl_ep_enable().

Changes v1 -> v2:
- Moved raw.c to legacy/.
- Changed uapi header to use __u* types.
- Switched from debugfs entry to a misc device.
- Changed raw_dev from refcount to kref.
- Moved UDC_NAME_LENGTH_MAX to uapi headers.
- Used usb_endpoint_type() and usb_endpoint_dir_in/out() functions instead
  of open coding them.
- Added "WITH Linux-syscall-note" to SPDX id in the uapi header.
- Removed pr_err() if case dev_new() fails.
- Reduced the number of debugging messages.

Andrey Konovalov (1):
  usb: gadget: add raw-gadget interface

 Documentation/usb/index.rst            |    1 +
 Documentation/usb/raw-gadget.rst       |   61 ++
 drivers/usb/gadget/legacy/Kconfig      |   11 +
 drivers/usb/gadget/legacy/Makefile     |    1 +
 drivers/usb/gadget/legacy/raw_gadget.c | 1078 ++++++++++++++++++++++++
 include/uapi/linux/usb/raw_gadget.h    |  167 ++++
 6 files changed, 1319 insertions(+)
 create mode 100644 Documentation/usb/raw-gadget.rst
 create mode 100644 drivers/usb/gadget/legacy/raw_gadget.c
 create mode 100644 include/uapi/linux/usb/raw_gadget.h

-- 
2.25.0.265.gbab2e86ba0-goog

