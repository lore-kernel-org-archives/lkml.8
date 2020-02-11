Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D689C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0104720842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xYy9YEwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgBKJTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:19:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35624 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgBKJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:19:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so11321436wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVlESJACG89pklyqt5dku74uDucYx/inw781yhYszzY=;
        b=xYy9YEwOd9zZ/ik7pbrssQUXxyjszoulOXUQj8EoL34h7OY5pAzh43t1vT0dtAbln8
         7BA4R5YCHBr4ydY3sUzLXNlVyyf97waTKEfcSk1LDGRBn80b9PuTibFQuZQKkgKFASsb
         9m9IN6LR8JZorC0hARXRmw3zlNhoroISTgXbee9H2+OJ0estGuBJCSix0C0XkwbGx25U
         QgNAgYXHTCzrjGoPeHJ7AunyV+90U5rvmVoiAnik3ayvtPznNlpHSXmWFJ3bnEHSGYSC
         DKbsc3MuHhkm0WS4pqCv78bXIiaug8Ba3I5RNq//mMqIBOvXTniwbZWnb06QTSYlHe/8
         rlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVlESJACG89pklyqt5dku74uDucYx/inw781yhYszzY=;
        b=cMQHTlGpyOzPDy9n2YDdRx1RBtEIqMdWkkYRmVh0Zlp1R64nmIwRwWUPXdFmftepar
         XwrpKVKEhq8UKpYYHZZhv53BDvyfAPww8MYLNdAe/eTTgWVoZVkn2iHnnxZMYhCCB5qK
         3D90nipAfRhUymQHW3nh+bf4SnjQGXaSNL+PaexuBBojxhPPfc/3V9//LZrZQynYRUJO
         v+xs0MlaSFPWY8ew8mZZaXGxM7XDnlaGRX4u2e/FIGUTC2KJ2+uFf+9ozy39ynRpXiGt
         0dMrAVVDA5WhZEmF0DEKh8uu+y8qK9jcaDyS/Ldf2nZaYe2SN6NlwoheGgafpMfhU9YX
         eNww==
X-Gm-Message-State: APjAAAUAAYScqRrYJrs2p/1VufyjSPW1alPnl2Ez1ZPzBQFYyo5EBj6I
        MdppfxQlAgnQhHlD36S3C9nl9Q==
X-Google-Smtp-Source: APXvYqwNRTbfJgQ3bARtabhxG+X0aIsyLQ0k4H1EKu6LHKxMKj9fzDNNZ2wxF/MoEtIq3fWGqXmGIw==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr7348760wrm.131.1581412785245;
        Tue, 11 Feb 2020 01:19:45 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id y131sm2958622wmc.13.2020.02.11.01.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 01:19:44 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v6 0/7] gpiolib: add an ioctl() for monitoring line status changes
Date:   Tue, 11 Feb 2020 10:19:30 +0100
Message-Id: <20200211091937.29558-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Resending rebased on top of v5.6-rc1 and retested.

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

v5 -> v6:
- coding style tweak as pointed out by Andy
- fixed a wrong comment in the uapi header
- switch to using ktime_get_ns() for the GPIO line change timestamps
  as discussed with Arnd[1]

[1] https://lore.kernel.org/linux-gpio/CAK8P3a1t3MquLPuZqgds4osrTNTOG494s4fk_nhdn+N=B3qdhg@mail.gmail.com/

Bartosz Golaszewski (7):
  kfifo: provide noirqsave variants of spinlocked in and out helpers
  kfifo: provide kfifo_is_empty_spinlocked()
  gpiolib: rework the locking mechanism for lineevent kfifo
  gpiolib: emit a debug message when adding events to a full kfifo
  gpiolib: provide a dedicated function for setting lineinfo
  gpiolib: add new ioctl() for monitoring changes in line info
  tools: gpio: implement gpio-watch

 drivers/gpio/gpiolib.c    | 350 +++++++++++++++++++++++++++++---------
 drivers/gpio/gpiolib.h    |   1 +
 include/linux/kfifo.h     |  73 ++++++++
 include/uapi/linux/gpio.h |  30 ++++
 tools/gpio/.gitignore     |   1 +
 tools/gpio/Build          |   1 +
 tools/gpio/Makefile       |  11 +-
 tools/gpio/gpio-watch.c   |  99 +++++++++++
 8 files changed, 485 insertions(+), 81 deletions(-)
 create mode 100644 tools/gpio/gpio-watch.c

-- 
2.25.0

