Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA75217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uiNjXQyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAWOFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:05:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37205 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgAWOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:05:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so2674287wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4gsIb9YC469UFW7oh8C6aAa/TPxqrBfLmyyhtj3CuGY=;
        b=uiNjXQyOWDsb86gZ9wfQygYIsm8Sli+LoDzBYFlJgZccgKFpOUjRTMhX/U/edLsVny
         btviaaEVj8hxjlHkSaxhUZ3ymfa+H+qlB4w/qi0aUDE/Kv+YykP3Qe7k5eWQJ/C6kHmM
         43WRm3U2jICLSyQSgtYFerDDLGNQ617q5AiQG03z2mBAmnsz+5lbL23AoOWCTrEXkwas
         p4G4Rks8ybzd7ZA9Vsp9DuvZvIOv1mkyNvjZg3+nZeznD5MzGw/eb7sUqoD6lLV2UynG
         Mi8aDumK975mqz0n1nXpoXhN3z3z1MubLqx5x2R6Bn4+T7fTVGfB0+5IjyMUMaEcT4Mo
         2egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4gsIb9YC469UFW7oh8C6aAa/TPxqrBfLmyyhtj3CuGY=;
        b=NCgmULRBcfysdtwn/GWZ0X5I5KlfzQTjEK7p4siHD7ZoCK+YxNcWPDtYvIz023w9nQ
         TZf2RRDbFlwasneMhOsVFGQvExty5PKWxtlBobFVdGh4J4jxmZ/DX3sRUVM0H++feFX5
         d/y/B/X9GgW1Pn4r9NPvJEGDKtnPVE3WyrYju2lDuiozo5AIK89KyPZYgGnM865bkmiX
         FOGh3bZ4+9YXD0ZVfmtsCYmT6YtMW8qXLY+j1cNB5pF5cgOj7bcUViMXtOUEbH9EPS8e
         OhnvIHTBAVp/Zih9lNFeByvEm+lY5QjVfARDCkMw3BdVHI8jXnW2UwQnn2s2kQJ/5oF8
         qqVQ==
X-Gm-Message-State: APjAAAVq/2BfVow4+vJb3NTtWqzkKY4mHdMNyHRllkdUkmY4vV4GZQpb
        J2Ofhu0/oy/bzX0ypJ/wEVs6+g==
X-Google-Smtp-Source: APXvYqwDrzCTywVAEh9FHwzLKR3XzkFTJ66ccRazoz7NlIrbGRopwYEI6hgk47TjqhL/HyU4aNWKZQ==
X-Received: by 2002:a1c:66d6:: with SMTP id a205mr4588132wmc.171.1579788316991;
        Thu, 23 Jan 2020 06:05:16 -0800 (PST)
Received: from localhost.localdomain (amontpellier-652-1-53-230.w109-210.abo.wanadoo.fr. [109.210.44.230])
        by smtp.gmail.com with ESMTPSA id n16sm3100963wro.88.2020.01.23.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 06:05:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Stefani Seibold <stefani@seibold.net>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v5 0/7] gpiolib: add an ioctl() for monitoring line status changes
Date:   Thu, 23 Jan 2020 15:04:59 +0100
Message-Id: <20200123140506.29275-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Resending with some people who could ack kfifo patches in copy.

===

When discussing the recent user-space changes with Kent and while working
on dbus API for libgpiod I noticed that we really don't have any way of
keeping the line info synchronized between the kernel and user-space
processes. We can of course periodically re-read the line information or
even do it every time we want to read a property but this isn't optimal.

This series adds a new ioctl() that allows user-space to set up a watch on
the GPIO chardev file-descriptor which can then be polled for events
emitted by the kernel when the line is requested, released or its status
changed. This of course doesn't require the line to be requested. Multiple
user-space processes can watch the same lines.

This series also includes a variety of minor tweaks & fixes for problems
discovered during development. For instance it addresses a race-condition
in current line event fifo.

First two patches add new helpers to kfifo, that are used in the later
parts of the series.

v1: https://lkml.org/lkml/2019/11/27/327

v1 -> v2:
- rework the main patch of the series: re-use the existing file-descriptor
  associated with an open character device
- add a patch adding a debug message when the line event kfifo is full and
  we're discarding another event
- rework the locking mechanism for lineevent kfifo: reuse the spinlock
  from the waitqueue structure
- other minor changes

v2 -> v3:
- added patches providing new implementation for some kfifo macros
- fixed a regression in the patch reworking the line event fifo: reading
  multiple events is now still possible
- reworked the structure for new ioctl: it's now padded such that there
  be no alignment issues if running a 64-bit kernel on 32-bit userspace
- fixed a bug where one process could disable the status watch of another
- use kstrtoul() instead of atoi() in gpio-watch for string validation

v3 -> v4:
- removed a binary file checked in by mistake
- drop __func__ from debug messages
- restructure the code in the notifier call
- add comments about the alignment of the new uAPI structure
- remove a stray new line that doesn't belong in this series
- tested the series on 32-bit user-space with 64-bit kernel

v4 -> v5:
- dropped patches already merged upstream
- collected review tags

Bartosz Golaszewski (7):
  kfifo: provide noirqsave variants of spinlocked in and out helpers
  kfifo: provide kfifo_is_empty_spinlocked()
  gpiolib: rework the locking mechanism for lineevent kfifo
  gpiolib: emit a debug message when adding events to a full kfifo
  gpiolib: provide a dedicated function for setting lineinfo
  gpiolib: add new ioctl() for monitoring changes in line info
  tools: gpio: implement gpio-watch

 drivers/gpio/gpiolib.c    | 351 +++++++++++++++++++++++++++++---------
 drivers/gpio/gpiolib.h    |   1 +
 include/linux/kfifo.h     |  73 ++++++++
 include/uapi/linux/gpio.h |  30 ++++
 tools/gpio/.gitignore     |   1 +
 tools/gpio/Build          |   1 +
 tools/gpio/Makefile       |  11 +-
 tools/gpio/gpio-watch.c   |  99 +++++++++++
 8 files changed, 486 insertions(+), 81 deletions(-)
 create mode 100644 tools/gpio/gpio-watch.c

-- 
2.23.0

