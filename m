Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2700BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008F220781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCvT6A2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbgFXKtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbgFXKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:49:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386D4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:49:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h15so1785877wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rm0PzYfDEfLIeFLqk84KmWVx+T9Uvb0Z9B/KLyoR+xk=;
        b=fCvT6A2SQZcvbsuT8IlpxFsEyCsT7qcpfdGp/lxH0Au6T/L8g5NKG9GUmsPRDJTzEO
         EKXkRIuGoPWVZxG3ZbEnigA5eURvQK4kD+OxkNxNLUxkI99SbQRsLKtgEiGfohu3VUrv
         HcyZsaeJemc0E7aSFybXT6nUaVhyACN2nzYe71v34n/IebKLgPO/yf8/By5NlGKI6x9D
         WcH4dfB0xNTLIH+X1OX/MbOVUgQxDLHJ+faau0cR62PlE+fE4+aAFrwt/RxfuO+YJ2hT
         uJ8oHlKh9CcreOCxa6TnYqsg9U75PWyufqurZEz21DT8YuNmwR9XpxPny0YmGoyoHQya
         aUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rm0PzYfDEfLIeFLqk84KmWVx+T9Uvb0Z9B/KLyoR+xk=;
        b=hSEGvHgHBwRS8/ChaDZG1Atwra2zy6vQGuM2FHqH0Q8Gqc1N38cSTt6XFAKEnuefmA
         FA2U09FxoBaNDF9cJpS9OeZi9clApVAxQn2Zv1HE4tLNQD4b4IJkR0k57TQWI3/hWDD1
         VW6XxlctagoCrWU8kn40Q0h/m4hYv4G5ABprpijk42GGh5PgazTIxqpWhbpCFKVyE+g9
         2mhnHRRel55ttRkosxVh1XUGlXCDzJa1nPrkKHzDXYjoLbm8yUc31eGKZQ15HUiTdtxt
         RoCMT4ovr2WN2YcxD1zVki8z5CZ86LxIOhHDj03Y5WHFlk3L1Cxzal1Kg/YuBltiNtaR
         kZxg==
X-Gm-Message-State: AOAM5328yaYJokRAlBS2F9ATer937hYVviI+1S6VYdp7XsnjGTSi09Tj
        VGpAOCo4eImjxP8j/dDiTjENjVxq
X-Google-Smtp-Source: ABdhPJy9/sOk8ex2jB6ikHmIqrwwBPJDvnSj8Utt90j4s5qZ/jYvlBiEyOVSeUGYQKgDJhpGuo2vlA==
X-Received: by 2002:adf:9062:: with SMTP id h89mr3190210wrh.285.1592995775777;
        Wed, 24 Jun 2020 03:49:35 -0700 (PDT)
Received: from ogabbay-VM ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id w17sm27932095wra.42.2020.06.24.03.49.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 03:49:34 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:55:39 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes pull request for kernel 5.8-rc2
Message-ID: <20200624115539.GA8680@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request contains important bug fixes for the GAUDI code that was
just merged. Details are in the tag message below.

Thanks,
Oded

The following changes since commit 8c289ea064165237891a7b4be77b74d5cba8fa99:

  mei: me: add tiger lake point device ids for H platforms. (2020-06-23 07:55:47 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-06-24

for you to fetch changes up to ce04326edd59d7902d7ef3a9d853864096e0cd1a:

  habanalabs: increase h/w timer when checking idle (2020-06-24 12:35:23 +0300)

----------------------------------------------------------------
This tag contains the following fixes for kernel 5.8-rc2:

- close security hole in GAUDI command buffer parsing by blocking an
  instruction that might allow user to run command buffer that wasn't
  parsed on a secured engine.

- Fix bug in GAUDI MMU cache invalidation code.

- Rename a function to resolve conflict with a static inline function in
  arch/m68k/include/asm/mcfmmu.h

- Increase watchdog timeout of GAUDI QMAN arbitration H/W to prevent false
  reports on timeouts

- Fix bug of dereferencing NULL pointer when an error occurs during command
  submission

- Increase H/W timer for checking if PDMA engine is IDLE in GAUDI.

----------------------------------------------------------------
Oded Gabbay (3):
      habanalabs: block scalar load_and_exe on external queue
      habanalabs: rename mmu_write() to mmu_asid_va_write()
      habanalabs: increase GAUDI QMAN ARB WDT timeout

Ofir Bitton (1):
      habanalabs: Correct handling when failing to enqueue CB

Omer Shpigelman (2):
      habanalabs: use PI in MMU cache invalidation
      habanalabs: increase h/w timer when checking idle

 drivers/misc/habanalabs/command_submission.c       | 13 ++++++++
 drivers/misc/habanalabs/debugfs.c                  |  4 +--
 drivers/misc/habanalabs/gaudi/gaudi.c              | 37 ++++++++++++++++++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  3 ++
 .../misc/habanalabs/include/gaudi/gaudi_packets.h  |  3 ++
 5 files changed, 56 insertions(+), 4 deletions(-)
