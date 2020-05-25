Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5968C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA6C2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfUPCVhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgEYF2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEYF2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:28:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:28:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j16so3465435wrb.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=L9KTCL62miysC4G9LaoSTZdB/dtWNH8pIG+LiC5Re3g=;
        b=LfUPCVhUEg8m8lN/MQlL4GekJ0tWuoTKvrPgj1T0qzw8Ya8iwRgfKjCLCgN8fkvL6P
         KhahjR4Jx/RywbjFjEc8J75iyhZgoCueb9l8JOYkWH9G+1Umx8z6JsDhTt3vkImUrEdc
         G67lwoN9+uGdZyVGCuxRUeSdS9RrDOXPNqlRItFaDTs1WKMwQAMlSlxRyk6mzWWeaP+p
         hp9e83P9nN60y8Qvxi+rnLVX5W/pI5vNSum14Boo8mRzyz8uQNrkMcIzMEcOWaFP1+Yb
         jY/+1GnK3C+W/acCALgy05q9NIX9sN2Ut6fNwQOiI29mSN2scskgSevqx2a8Q+vmYyaA
         ISqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L9KTCL62miysC4G9LaoSTZdB/dtWNH8pIG+LiC5Re3g=;
        b=uUgSAcWszrGLKivsGCrbPdE2Ayla6ClKGvMhSFohG/CS6QonP+uZY1htyg/IoFKsCF
         KqGlDZ+7EvYgxJEoqSQaxCaTNI6iipg+oKAEx+8oN+N4isEffemaYCWsmtue7MGHSZya
         nPkcv6Mvxfl+MXN462rRKf5j9moVMliNEcnetOvLQ3bdkNA0UsnQW6KTXMnpOPe7sGw6
         Yrz6uNxury+QwIR9FjEVjp8ZYCFYsQGDAqcXFEmi3fYyJRBYqWXjUb6C8WUrIYNoqvwn
         RMZEpijaWNYlgbLoJGCbNwLlbz0YmsT2/N7nBH/L6UJIErqTjkAzS1j5HcEgYsD/nPn2
         PcRQ==
X-Gm-Message-State: AOAM530tPujRHIMtPsBh7jZPdQxYV70Qx4zPHXWY8US6vH3cXV94ZD89
        B3vDOcijN3tW5FqsJ/CI7at0tLXZ
X-Google-Smtp-Source: ABdhPJz6Ho4ysYOj9vnw0hQaV+nZQP8o21HmsdEOaodoaJi6EWigG9E9TzsF5Kwt+pGNGpbjgmyG4Q==
X-Received: by 2002:a5d:5048:: with SMTP id h8mr13457735wrt.293.1590384499194;
        Sun, 24 May 2020 22:28:19 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j4sm15257962wrx.24.2020.05.24.22.28.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 May 2020 22:28:18 -0700 (PDT)
Date:   Mon, 25 May 2020 08:28:19 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs second pull request for kernel 5.8
Message-ID: <20200525052819.GA19318@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the second pull request for habanalabs driver for kernel 5.8.

It contains important improvements to our MMU code and our ASIC reset code.

Please see the tag message for more details on what this pull request
contains.

Thanks,
Oded

The following changes since commit 709b41b56a16a5901a89dcaeb75d2233f80d9e55:

  misc: rtsx: Remove unnecessary rts5249_set_aspm(), rts5260_set_aspm() (2020-05-22 09:38:14 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-05-25

for you to fetch changes up to 8ff5f4fd40df9525675ea0e512da4cec65d646eb:

  habanalabs: handle MMU cache invalidation timeout (2020-05-25 08:17:57 +0300)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.8:

- Improve MMU cache invalidation code and handle case where the
  invalidation doesn't finish in a reasonable time.

- Remove the option to perform soft-reset to GAUDI. Soft-reset is where the
  driver only resets the compute and DMA engines of the ASIC. This is not
  relevant to GAUDI as we must also reset the NIC ports. And when we reset
  the NIC ports, we must also reset other stuff so we prefer to just do
  hard-reset (where we reset the entire ASIC except for PCIe).

- Fail the hard-reset procedure in case we still have user processes which
  have active file-descriptors on a device. Doing hard-reset in that case
  can result in a kernel panic because of gen_pool checks

- Don't initialize the default wait callback of dma_buf with the default
  wait function as that's the default...

----------------------------------------------------------------
Daniel Vetter (1):
      habanalabs: don't set default fence_ops->wait

Oded Gabbay (1):
      habanalabs: GAUDI does not support soft-reset

Omer Shpigelman (4):
      habanalabs: improve MMU cache invalidation code
      habanalabs: add print for soft reset due to event
      habanalabs: don't allow hard reset with open processes
      habanalabs: handle MMU cache invalidation timeout

 drivers/misc/habanalabs/command_submission.c |  1 -
 drivers/misc/habanalabs/device.c             | 23 ++++++---
 drivers/misc/habanalabs/gaudi/gaudi.c        | 74 ++++++++++++++++++----------
 drivers/misc/habanalabs/goya/goya.c          | 35 ++++++++-----
 drivers/misc/habanalabs/habanalabs.h         | 10 ++--
 drivers/misc/habanalabs/memory.c             | 35 ++++++++++---
 drivers/misc/habanalabs/sysfs.c              |  5 ++
 7 files changed, 126 insertions(+), 57 deletions(-)
