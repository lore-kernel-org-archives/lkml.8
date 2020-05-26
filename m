Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C6DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E673208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEA8gNdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbgEZNNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgEZNNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:13:04 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A8C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:13:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r125so12236082lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ephXh0Ws1vURS05DtHce4Quc+oR69mUIgptnvs16X8Y=;
        b=jEA8gNdvAp3D9dKLQEp9DZLm40+NpEOW7y8uZvLh+BBMAcCwnzYhWjzJeSnuec+YZT
         AhFOjrUBrKElgJx8HIAxjPqTKPswQjBiphJD75YykqKli8Bgw7YDfJdTM9cxh7hudrYJ
         NSs0Tp4EWIfU4ugQXYz3I+ySjLx47qgQR7XKa7y1E/30m0lyuZG3p9P1jAEQDdUDgwEC
         tO0i1Ws5P9nODmjlibYciJ0A+K3YbwsdcpLUGlkXhWf6iKgpRUbLVZXpFbMoQgCHEgGz
         4dzPNha4SLQvxy2SytgG2C9emeUmq54LLNS9jPY6nBXugEJhj74HvZWZ+4MawN2F4CrZ
         5MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ephXh0Ws1vURS05DtHce4Quc+oR69mUIgptnvs16X8Y=;
        b=ELjqgKHg2iAwhtgcXEbr0JPexmGuTJ9VJkR3uXXi+maMzngXI49TJ4qnrhSTu/m6mz
         P1YBQgX/weMQG/QHNvYbp4wyYxVJ4CdpGp0M5nT90qWyLpTmCbZEciIo0vfZpmaODPoL
         UUQ3UYa7Wom130nAltV1gDhc3SFMRoE90zv2mH3/GrngB2mmmnDmjSLd6S0oZtPaREpM
         yZXJXpk91zd/bPG9+CEOIgD9QGjY0ox2IIOuTybapuPHvnW2VFkXLmnxI+sAdZq2giuI
         OkDRQOHXHwBLgrdIaBPog0o12Q7UexFCV49RJAk6CCqfMq7z5vPtMbys41MrcYb6YY5Z
         vZ5g==
X-Gm-Message-State: AOAM531M0QeIGo4TnM+saPjbn+5VNOBKkPFtCWmrUfMPYr7Q4L5XDRZP
        2YwEiD4dyAH5/TGjFY88dgdf8A==
X-Google-Smtp-Source: ABdhPJyXJJ3riQvr5hQMbP/Mq5TfkYaYDNtogu+2req5gEPqavseH0MGWZYipsgXfPkNKPdEkVm74w==
X-Received: by 2002:a19:c751:: with SMTP id x78mr521867lff.82.1590498782293;
        Tue, 26 May 2020 06:13:02 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id f18sm4952339lfh.49.2020.05.26.06.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 06:13:01 -0700 (PDT)
Date:   Tue, 26 May 2020 15:12:59 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org, John Hubbard <jhubbard@nvidia.com>
Subject: [GIT PULL] tee subsystem pin_user_pages for v5.8
Message-ID: <20200526131259.GA97001@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch converting the tee subsystem to use
pin_user_pages() instead of get_user_pages().

Thanks,
Jens

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-pin-user-pages-for-5.8

for you to fetch changes up to 37f6b4d5f47b600ec4ab6682c005a44a1bfca530:

  tee: convert get_user_pages() --> pin_user_pages() (2020-05-26 10:42:41 +0200)

----------------------------------------------------------------
Converts tee subsystem to use pin_user_pages() instead of get_user_pages()

----------------------------------------------------------------
John Hubbard (1):
      tee: convert get_user_pages() --> pin_user_pages()

 drivers/tee/tee_shm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)
