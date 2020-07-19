Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E8AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 06:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC582073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 06:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehhAQYSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgGSGN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgGSGN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 02:13:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE5C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 23:13:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so19310357wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PJ9J9wcnU/Bxiv6CHbGE76S39Qt+iorKUK+icppTQLM=;
        b=ehhAQYSLBAXwmbNEpG/weWJ1ytkZ/L04AQNrhupb6d828sQheuxqii8EqXLnFM0n0/
         LrRFfdqVGkg/04VBjY69BzpQJs3FceNjvpaRB0W3hs+VOwXzbQ1mIT5Vmn0GuLAwn+aN
         Vdl/njEFbcYZNzIKoXkDnAXWoaIl5C+NOEPTJdw/hB7qX4c+WJJCteEAeHHZRJDle1Ab
         /KbB5OTW98JJ4DIB/q3kQSOabMU9f+LQgewg1H7fMEv7Rst+Q2aRsK7z62L24jRD6Kod
         JfQO8jc8Dy/cZqFRwiMx1z8F2y0V0DLz8uCr+FPAcKT/zM3JcMRxMrfkxvnbBVQXbc0j
         QLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PJ9J9wcnU/Bxiv6CHbGE76S39Qt+iorKUK+icppTQLM=;
        b=mIQFksSENwGsxaUnuChGug1xZ7n4UUecOOm2I2j/Ia8xHZz8XjJ0ksk9P4Ai+n2rFA
         Wl7Qr5f09liwmrkICcEd0Nn8HFk88j48Hy13l9KdA6DPVAyCJQKZBepS/6Y8wSDdwJCB
         TdEPQQcqF54EEKuAtJuVyQSjyvY7sEy9oldmvIR1MIMH9nzbvk1Qs9DpKMqp3f9jppRr
         hUyfx0PfndavPut6XyUZMAQC907xTPMd3Gd/vREFCmWJVSHOC1BJ7b9OKIrtlDOVa1xR
         Zh3nWXDsROsl7u1FYQZsRSa1GZkcnUgMfahsKEozTTQvf6q+t7h4TCvTzXIJzfvwwWWB
         9TCA==
X-Gm-Message-State: AOAM530mdmNaotDvLenHhjPZmV5Xy2q2OMtEN+618ELJamkPnhup4bh/
        QcK631SBNvVCQX1PM1lbEsNRy9lf
X-Google-Smtp-Source: ABdhPJyZ6HWleTOXDBTa4j24lHVeQDuQK5Oe5eH+pblyzXU4+vBcFU8/jwqqE7UhaqxoJ+1QZuwJ4A==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr17040697wma.90.1595139204981;
        Sat, 18 Jul 2020 23:13:24 -0700 (PDT)
Received: from ogabbay-VM ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 31sm5412553wrj.94.2020.07.18.23.13.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 23:13:23 -0700 (PDT)
Date:   Sun, 19 Jul 2020 09:13:22 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes pull request for kernel 5.8-rc7
Message-ID: <20200719061322.GA31592@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request is for 5.8-rc7 and it contains an important bug fix for
possible out-of-bounds access error.

Details are in the tag message below.

Thanks,
Oded

The following changes since commit b279b1fe5799cf653de3822ca253f5d21639d90a:

  Merge tag 'misc-habanalabs-fixes-2020-07-10' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus (2020-07-17 11:56:58 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-07-19

for you to fetch changes up to cea7a0449ea3fa4883bf5dc8397f000d6b67d6cd:

  habanalabs: prevent possible out-of-bounds array access (2020-07-19 08:15:36 +0300)

----------------------------------------------------------------
This tag contains a single bug fix for 5.8-rc7:

- Check that an index is in valid range before using it to access an
  array. The index is received from the user. This is to prevent a
  possible out-of-bounds access error.

----------------------------------------------------------------
Oded Gabbay (1):
      habanalabs: prevent possible out-of-bounds array access

 drivers/misc/habanalabs/command_submission.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)
