Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51611C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E7920678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECdYGu+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgANNYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:24:51 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:50806 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgANNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:24:50 -0500
Received: by mail-wm1-f74.google.com with SMTP id o24so1852457wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hGuyL9FzNtQNL/0ScoRIInHWpYCNF5HmdXbCvKgZdsw=;
        b=ECdYGu+rdNNIUjG9dckwkjr2qnEvgJejBefK64t5DEy7cOZwEdzeAUQTRgEEbCZkfV
         4+cgsw7JgcZ1qEFJebVNc3Y9TaPzf3q/OuWAGoWGrMtYbo6kq3c3XUiv6t+lYnP5M2kb
         8Zqxd2ZvsXWaY5IkqE6BsaKprCK71+fkBRIw7mVQXdr5J4+xZ1fGPh2INqx+p4ySG/cU
         hr26+UnkjfM8T8tCmhf6kgyi4Ad4+Owpjs2xvQmahlYLH0BfmHw8NrbJHLOhkWNXPyIc
         qDmTRD+mp3QCwd6oeBoE+CPXmSjILWsmGy48C6nm1vJ1qdGkI0fUu/JG8tcFn/XAMreZ
         hiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hGuyL9FzNtQNL/0ScoRIInHWpYCNF5HmdXbCvKgZdsw=;
        b=jz5SA1zMCAsA3+sxclPbZqOuPct3GkKK8S0ADXNLjQWGLpVF5sTqemmuNi9XlfUnjj
         +0T09IG17OR8PldmR2lrOYm8ypElTnWobgiZq685/34EMkyfEZmmNEc2OJ4M2VvPk7Et
         nahbgYqyJKIvj+xULiVUu/1x5avpBPXFmmueHLBILrbTvVQW2j0tq08RAsL65IBUEMlD
         YKGDt3mDRt0Q0GPGiFdaKPjywxVGldt3LdZLjBhHsI+XR+WiQEQNNf9D68au+sVAi8I8
         ynX1F0EEYdJK7ze6fQ8J61nyPdysnCVCQ7GNYr89PPWzvlGXz53CvLbyy9oZsNgCS6I5
         mu9w==
X-Gm-Message-State: APjAAAX9Clj9Ma9WlEoV+CZraCSP3PJ8ypBVYdxTYpR9ZBssM3J9N1h6
        3RwMCSnpjqUQIkv7KSB9YXMwC4bcFNmwZjVy
X-Google-Smtp-Source: APXvYqxlmlyHpaXcRCFZeWfdpQwZFPBtaJP9KPxj4U8akF6FmJiQ4zOUe/zTidX/4h8lU976IaebhU3x1A4VCej7
X-Received: by 2002:a5d:5273:: with SMTP id l19mr25340120wrc.175.1579008288477;
 Tue, 14 Jan 2020 05:24:48 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:24:42 +0100
Message-Id: <cover.1579007786.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v5 0/1] usb: gadget: add raw-gadget interface
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

This patchset has been pushed to the public Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2144

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
 Documentation/usb/raw-gadget.rst       |   59 ++
 drivers/usb/gadget/legacy/Kconfig      |   11 +
 drivers/usb/gadget/legacy/Makefile     |    1 +
 drivers/usb/gadget/legacy/raw_gadget.c | 1068 ++++++++++++++++++++++++
 include/uapi/linux/usb/raw_gadget.h    |  167 ++++
 6 files changed, 1307 insertions(+)
 create mode 100644 Documentation/usb/raw-gadget.rst
 create mode 100644 drivers/usb/gadget/legacy/raw_gadget.c
 create mode 100644 include/uapi/linux/usb/raw_gadget.h

-- 
2.25.0.rc1.283.g88dfdc4193-goog

