Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F313CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18FF20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O106MpoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXQtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgGXQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:49:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20AFC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:49:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so4777192pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GQt2Z1ws/WfONIjOWp9AeuItjf9hMkR3TALYfXb7u3I=;
        b=O106MpoVjd9OAiNYoACBwGCFb/AqfJ74hf/aLS68KdQRU8QBBf2kXmGt3dlG8EFmZl
         tldbLqhbWpOl5KlqmMM//KMcNHYUTrcc01KlUPSOrLtlgwPNG05TXn93742HCOY38kio
         c5G8Lm966mtk3iXaGFW0iNPgW9UqpvUL8LzVRXJHMtgmWOsY89xgTvyZlqH+QKIUrxsw
         MzVBZ1JEu+zoV6bNeZvhRIMsUkyrmpFIK2T0ewM1hALHofP3gliEyj9cjmzS1wlFZfQS
         3ODloyX3PAhNaBgj/J0MNOFOEMvW6IaYZV7rfJltMYcZ9xxj7xvrIlKoUlr0HwdnWyR5
         lblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GQt2Z1ws/WfONIjOWp9AeuItjf9hMkR3TALYfXb7u3I=;
        b=KOjXcJmqAxJdMUDL3TCJAM6udQtet9Mm8QkFZnmQdbzUuYPt2Y5XPmxcvl0THWogTN
         TXFbdvUy5BGigTsZ68qsqj1njUSc2X/2JQWJLdw1IPsPmeDFT2FAbd6B2p3A4g7edVkb
         HEDQFMvpbZuwPg2KT6J0xj47XO4216/cxeWWveNirWZ+JXeQ2FGSIKp8+7jyV/bQhk/A
         tkQxtSF3nCSEsVCUEybxZdYLE9EMRj2S4v1D7O9hx5JX9APJbquZyBoLobOnUIs55BQV
         V5nE41UAoFSbyS0Wtph/qDEgwM9SWuVXeUCwj2mZ/Fg2ANlCruEVBKtoRd6HJJ6sqsGA
         8Jbw==
X-Gm-Message-State: AOAM5333XgXpvU/j7aurbnaNMTPCcCiZJ/jJSP4e2q8awrwuiYlC/KT8
        qqRFDZnFDaetCy1AFyN42rSfinjuHDU=
X-Google-Smtp-Source: ABdhPJyEn8R5pCXQtGwr5zjilHrF158dQmMATZYqIqSDms0Uoe+gVM8JOFPE2S1JajDB3gKMHMlgYQ==
X-Received: by 2002:a17:90a:ebc7:: with SMTP id cf7mr6279349pjb.207.1595609356077;
        Fri, 24 Jul 2020 09:49:16 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w20sm6797797pfn.44.2020.07.24.09.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 09:49:15 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.8-rc7
Message-ID: <c07ebe12-2b16-3811-9abc-d3e8d99b54db@kernel.dk>
Date:   Fri, 24 Jul 2020 10:49:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

- Fix discrepancy in how sqe->flags are treated for a few requests, this
  makes it consistent (Daniele)

- Ensure that poll driven retry works double waitqueue poll users

- Fix a missing io_req_init_async() (Pavel)

Please pull!


The following changes since commit 681fda8d27a66f7e65ff7f2d200d7635e64a8d05:

  io_uring: fix recvmsg memory leak with buffer selection (2020-07-15 13:35:56 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.8-2020-07-24

for you to fetch changes up to 3e863ea3bb1a2203ae648eb272db0ce6a1a2072c:

  io_uring: missed req_init_async() for IOSQE_ASYNC (2020-07-23 11:20:55 -0600)

----------------------------------------------------------------
io_uring-5.8-2020-07-24

----------------------------------------------------------------
Daniele Albano (1):
      io_uring: always allow drain/link/hardlink/async sqe flags

Jens Axboe (1):
      io_uring: ensure double poll additions work with both request types

Pavel Begunkov (1):
      io_uring: missed req_init_async() for IOSQE_ASYNC

 fs/io_uring.c | 61 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

-- 
Jens Axboe

