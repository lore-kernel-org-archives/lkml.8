Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADFCC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124572084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acqvOVae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBXQSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:18:11 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34535 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBXQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:18:10 -0500
Received: by mail-pj1-f67.google.com with SMTP id f2so83454pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsYjXT5y25umLgajERgJkh5L1V1CQFDUxeGT2hMU0Ag=;
        b=acqvOVaeFEL79wYat2Tu3xMbROsub914649oLTiIJFKmM6hLpIwCk81mP38kiSLcG7
         hpW8G8cTnyB7C2ICizsNPFnKw5yk46IsPsiViE1aaPyKts/TRsCu8ZkCRQaAKZ8Zf3kr
         JxJuk5BXNUySbjUF6LqA79YyCYOLsiIVFRRPIwhUOyplAIgTR7wmWPsaBM4mLr0CWM8q
         3YOABfY9X004jaZotMkXA0kEpXibJ6hwd83/sr7aCJWt/tHYOMmc1QUYlXjNmc295M++
         dWdwI/yfuchvWch1On+7IfjfuhRgXjVLzq8RdNfqV+9Za2yQvGv9rlrSIX6qHol4jMPf
         L7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsYjXT5y25umLgajERgJkh5L1V1CQFDUxeGT2hMU0Ag=;
        b=EI8dku5F3ffmsEuSSRro9jQswfwdKlk6JeSFukM1MhAB5bUEVZTJh+MiPk7cOu8UwJ
         b+lofjov1kL83Q/sfZJz+Ecunw8ETUneuEUot94ovvARJDGbGM5IZeEFO9rmeNDfDnqx
         dmY15Pfhy/BCCdPfyOU7FrUB8PYslv/HqBvGvZWlq29UaZYf9FxuElMLohqPSGoG1VmO
         ym+eKgvrtZPeyUHJkv7LBJ6PN20PXuXFnGx23xZ9pWmT3PSgyMAn3WPsq4rz5hUiA3pi
         SfYGXwSuFLR3J2cj4pn8u8j5crrYyN9Pqk/5q99/Q91XzFqpkN8zRpHgtaWIuT0JqF3s
         8wKw==
X-Gm-Message-State: APjAAAWWcDu9BmwBnDBR1/dO4+k1ERh5zVrH6HoYQwBH4VBZLYFsdlQf
        acpErz1U9xTWIKqHEZR1MZul+kOu5dTOtit5IBMTeA==
X-Google-Smtp-Source: APXvYqyct0MEZT8sBmLAJscQlsCSHUJ5kQli5XgQjFwmUvv+IvpSsHmF36IHxJv2zBF57KhhLIrasKR3AYCHB69TpOE=
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr46549947plp.252.1582561089283;
 Mon, 24 Feb 2020 08:18:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582560596.git.andreyknvl@google.com>
In-Reply-To: <cover.1582560596.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 24 Feb 2020 17:17:58 +0100
Message-ID: <CAAeHK+y7yKwQP-prUv17gFXKnKtBdfz7fQ8Gc5vwL49R4yCHuA@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] usb: gadget: add raw-gadget interface
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 5:13 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patchset (currently a single patch) adds a new userspace interface
> for the USB Gadget subsystem called USB Raw Gadget. This is what is
> currently being used to enable coverage-guided USB fuzzing with syzkaller:
>
> https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md
>
> Initially I was using GadgetFS (together with the Dummy HCD/UDC module)
> to perform emulation of USB devices for fuzzing, but later switched to a
> custom written interface. The incentive to implement a different interface
> was to provide a somewhat raw and direct access to the USB Gadget layer
> for the userspace, where every USB request is passed to the userspace to
> get a response. See documentation for the list of differences between
> Raw Gadget and GadgetFS.
>
> Currently Raw Gadget only supports blocking I/O mode, that synchronously
> waits for the result of each operation to allow collecting coverage per
> operation.
>
> This patchset has been pushed to the public Linux kernel Gerrit instance:
>
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2144
>
> Changes v5 -> v6:
> - Prevent raw_process_ep_io() racing with raw_ioctl_ep_disable() by
>   checking urb_queued flag in the latter.
> - Use GFP_KERNEL instead of GFP_ATOMIC where possible.
> - Reject opening raw-gadget with O_NONBLOCK to allow future extensions to
>   support nonblocking IO.
> - Reduce RAW_EVENT_QUEUE_SIZE to 16.

Hi Felipe! I'm still hoping for a review :)

(Forgot to add a link to the example that emulates a USB keyboard via
Raw Gadget into the cover letter:

https://github.com/xairy/raw-gadget/blob/master/examples/keyboard.c)

>
> Changes v4 -> v5:
> - Specified explicit usb_raw_event_type enum values for all entries.
> - Dropped pointless locking in gadget_unbind().
>
> Changes v3 -> v4:
> - Print debug message when maxpacket check fails.
> - Use module_misc_device() instead of module_init/exit().
> - Reuse DRIVER_NAME macro in raw_device struct definition.
> - Don't print WARNING in raw_release().
> - Add comment that explains locking into raw_event_queue_fetch().
> - Print a WARNING when event queue size is exceeded.
> - Rename raw.c to raw_gadget.c.
> - Mention module name in Kconfig.
> - Reworked logging to use dev_err/dbg() instead of pr_err/debug().
>
> Changes v2 -> v3:
> - Updated device path in documentation.
> - Changed usb_raw_init struct layout to make it the same for 32 bit compat
>   mode.
> - Added compat_ioctl to raw_fops.
> - Changed raw_ioctl_init() to return EINVAL for invalid USB speeds, except
>   for USB_SPEED_UNKNOWN, which defaults to USB_SPEED_HIGH.
> - Reject endpoints with maxpacket = 0 in raw_ioctl_ep_enable().
>
> Changes v1 -> v2:
> - Moved raw.c to legacy/.
> - Changed uapi header to use __u* types.
> - Switched from debugfs entry to a misc device.
> - Changed raw_dev from refcount to kref.
> - Moved UDC_NAME_LENGTH_MAX to uapi headers.
> - Used usb_endpoint_type() and usb_endpoint_dir_in/out() functions instead
>   of open coding them.
> - Added "WITH Linux-syscall-note" to SPDX id in the uapi header.
> - Removed pr_err() if case dev_new() fails.
> - Reduced the number of debugging messages.
>
> Andrey Konovalov (1):
>   usb: gadget: add raw-gadget interface
>
>  Documentation/usb/index.rst            |    1 +
>  Documentation/usb/raw-gadget.rst       |   61 ++
>  drivers/usb/gadget/legacy/Kconfig      |   11 +
>  drivers/usb/gadget/legacy/Makefile     |    1 +
>  drivers/usb/gadget/legacy/raw_gadget.c | 1078 ++++++++++++++++++++++++
>  include/uapi/linux/usb/raw_gadget.h    |  167 ++++
>  6 files changed, 1319 insertions(+)
>  create mode 100644 Documentation/usb/raw-gadget.rst
>  create mode 100644 drivers/usb/gadget/legacy/raw_gadget.c
>  create mode 100644 include/uapi/linux/usb/raw_gadget.h
>
> --
> 2.25.0.265.gbab2e86ba0-goog
>
