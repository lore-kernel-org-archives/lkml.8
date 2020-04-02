Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB76C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812F320721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2FfgDff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbgDBBIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:08:43 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53206 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732462AbgDBBIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:08:43 -0400
Received: by mail-pj1-f66.google.com with SMTP id ng8so867486pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 18:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ugT5XXd14ijtpN2Hcg23GtWvr136nCMP/a+tddTYftg=;
        b=x2FfgDffWuPCb3iqPQXusSrJ2Jg4mJneLdYc+zcx3YcUfkDozfKVRcZxzTlXYSCZ9X
         2ANIQ6LekB022DMzPxuDeE5vhgGldCLzqQVQ8/X1DYICNdizfTFK7jQKtejzJTx2GUlT
         XA++HCSYvvdPjtX8Qzw8IqS+Wei8/s8bWqRecBQqtoJxKzXgzJf8cnTxxGZJlxeZ6G+M
         29JZdenCUaYZ9XCW7g5FFY02Lrly/JDPRFU7F8haXacZxvftfBAst3pWm3WM/uCn8u2p
         Gc1nDEeaTFetizm8iUIxOGx3IaX4EMDm/D7H4Ds78laUuXB6KGFMzCicbT/mcsCMzUO9
         2tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ugT5XXd14ijtpN2Hcg23GtWvr136nCMP/a+tddTYftg=;
        b=bsjCuSTo557wRuQy8GWt89THsvwxIhIMfyrRX5vdtBGj7I6d08h3MegxZp6+lj3emv
         oKQtbQmLkWvkBioffbfkBAhUGbUVj32gcva4oXYa6MPZlSG4Myl0M/FeS9Zm/j785SiX
         LSVP02WOOnSQRmuNWXh0dgFfmXJQAaqI8Evp85zYd55Z8ZTIb0Z93pt1qJ1Rd0T3XnOz
         IwtEQr+YVTds18vb3UD6XHc57XwSFSFK2SUHBu9gk7/Y8sTI4te8W9g5PM+HmRcrjGSz
         XDErfhrjNrJKHwBht6hjk1sw7smFCcmi/rH1oEjlRznyLJ4HYucmI/m/L2uy4c6modzb
         wQ7g==
X-Gm-Message-State: AGi0PuYeOU8uudQKWRBd3Qmg9m2GW0QsLtvs8KztoplImLmAsj1Jyztq
        tPeEp0HJoa80x5tB5nZsxkgctA==
X-Google-Smtp-Source: APiQypIFgAZ5m3lls8sFY57ACWOX7DXY3R/lYBPHIct2oj/PeLwE5hdc+/QpiPC7fmbj6sxlT3JBjA==
X-Received: by 2002:a17:90a:cc14:: with SMTP id b20mr944517pju.75.1585789720512;
        Wed, 01 Apr 2020 18:08:40 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u13sm2281011pgp.49.2020.04.01.18.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 18:08:40 -0700 (PDT)
Date:   Wed, 1 Apr 2020 18:08:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] hwspinlock updates for v5.7
Message-ID: <20200402010837.GB751391@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.7

for you to fetch changes up to ef17f5193edd42e8913c93d0b601c101c56a15bb:

  hwspinlock: hwspinlock_internal.h: Replace zero-length array with flexible-array member (2020-03-25 22:30:46 -0700)

----------------------------------------------------------------
hwspinlock updates for v5.7

This marks all hwspinlock driver COMPILE_TESTable and replaces the zero-length
array in hwspinlock_device with a flexible-array member.

----------------------------------------------------------------
Baolin Wang (1):
      hwspinlock: Allow drivers to be built with COMPILE_TEST

Gustavo A. R. Silva (1):
      hwspinlock: hwspinlock_internal.h: Replace zero-length array with flexible-array member

 drivers/hwspinlock/Kconfig               | 12 ++++++------
 drivers/hwspinlock/hwspinlock_internal.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)
