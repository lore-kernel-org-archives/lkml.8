Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F23DC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412162073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rc+l/Rv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgAQH5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:57:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42428 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgAQH5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:57:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so25469800ljj.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 23:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9pVB+0P7nfsJ3yw8f27fOejAwfBrljBWFRRLcIw8Iyo=;
        b=Rc+l/Rv9m/ZgvuQmdU48ZHmimFov2VXRkFP5lEQwoadwha6Oef+WXSfBES2zbBCx/h
         NNkM6Tj44JJ+76mP4cz4ZLHFvN5TRmqFaY96jC+NlxXTggJwdVtNYm+o3yC23Llv57uw
         YcAix08P8IWYp/xu7PfwWu/fKyRgJrS4A4RQndR+TbN4TEbmiF7guUh2WDLidqfDAzvg
         TFhLa2bpV9p5Av+imffz4msprTQvRhpyFIOw4YNqSuSsbJiCKFRz3ixfblLnTwTpxqL2
         yPyEchnDgmpERX/DoXwwai2Yrn6AmB6hRn+0NoWbii8oG8BIfeO2t5CYCaRxiPgpAta1
         ijrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9pVB+0P7nfsJ3yw8f27fOejAwfBrljBWFRRLcIw8Iyo=;
        b=Z8wr5zviLmkTPy7UygSFzKiOWhU721Y8YRc+1IlWwf7xpz9zyehNYYGpRYXZZAGJbK
         j6ciWCvtyDMT8O+x5Fj+fMP4cqcbmYCe0uEpJ7JM88Wg/EWYiRRi4OAkjlrY5iTst5W0
         zKBFkwNd+JJoTV4+yroKn3eo87rdifpdcVXtzWthfRA8n1GVMngPemUdMAIO7BJGxUHo
         li7JzhYvZwPuul214z3A7O2KFsLtrBiu6o0127/Ac0rGX0m54iizQvvqSbJP7PgsrLxz
         x+884jcIrytt/EHErxi2GGY55XBPJ0t/YBD+AsIA6t5MRlMFCOSpxsfOM7086g7XLWvA
         MZDQ==
X-Gm-Message-State: APjAAAV13yL1+S4PBOnMWZT83oDzFk9L+Gh7oqVLBauwRGDglyTEGA6X
        vyBDeCoiWIHJdehuEwv06G1son0O5DWw2a9baDTzOQ==
X-Google-Smtp-Source: APXvYqx3hxlXD94SSEkmtAQv90zVU0pdzIvcV/Q+Q2Smp4R1vzTVUUxtUbrlf9A0GfNNbLuErH9hB2dBBeyYJ4MDDHc=
X-Received: by 2002:a2e:918c:: with SMTP id f12mr4948308ljg.66.1579247857887;
 Thu, 16 Jan 2020 23:57:37 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Jan 2020 08:57:27 +0100
Message-ID: <CACRpkdatPeRrqDzb7ynELvRD_TUfjAc3XCYPKmE5BrQdFXakiQ@mail.gmail.com>
Subject: [GIT PULL] gpio fixes for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Kevin Hao <haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

a GPIO fix for the ThunderX is all that appeared in the last week(s).
The revert affects a single driver on a rare piece
of silicon.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.5-4

for you to fetch changes up to a564ac35d60564dd5b509e32afdc04e7aafee40e:

  Revert "gpio: thunderx: Switch to GPIOLIB_IRQCHIP" (2020-01-15 11:17:21 +0100)

----------------------------------------------------------------
GPIO fixes for the v5.5 series:

This reverts the GPIOLIB_IRQCHIP in the ThunderX driver.
ThunderX is a piece of Arm-based server chip. I converted the driver to
hierarchical gpiochip without access to real silicon and failed miserably
since I didn't take MSI's into account.

Kevin Hao helpfully stepped in and fixed it properly, let's revert it for
v5.5 and put the proper conversion into v5.6.

----------------------------------------------------------------
Kevin Hao (1):
      Revert "gpio: thunderx: Switch to GPIOLIB_IRQCHIP"

 drivers/gpio/Kconfig         |   1 -
 drivers/gpio/gpio-thunderx.c | 163 ++++++++++++++++++++++++++++---------------
 2 files changed, 107 insertions(+), 57 deletions(-)
