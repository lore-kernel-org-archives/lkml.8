Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747AEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4735920866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXCxutaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgHaM7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:58:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A4CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 05:58:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e17so5160397wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ySw25x0O04qLGcF+VK66BQQdRqEdOahV8Po+1urh7rs=;
        b=LXCxutaDwQNCq1YDCT9qPjPMoDQl37qEwssiRqP2AAZXV+zZJ5jj6u1jYFlHccJJRE
         tUDNPXoqsHfQrela5ClsFKiiGWAvMATO8UpfRwCTcFZDZM2t2qfGO1QMi6LVZ1it+t/W
         LGtYSnMIdJyLeWGvPVmiUqGJrzr4Nsv57Qu5D7XUxsfFO9JGjJF6eRjIl1NjgtWh/Y2c
         LW1vu0QsdpRwQEykpeJJWNkAAX7xXv0ibp56Osxyx6m9MuVKtU8ctb+1SUTV5EIvrOfH
         CbhPFdtGid5ToglTh41G+S9fP4IQLXqpTOyLpTGAWiboCMHg2QlA6DQ8N+AZpiyVG9wg
         zScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ySw25x0O04qLGcF+VK66BQQdRqEdOahV8Po+1urh7rs=;
        b=tf3Hrsiaw6eix9qqzMFDFz20uROk9BSdzAjxTuBGI0J4yOroM78CvyzNVLq3X6xSIo
         Q+NMx4ihBXr5dwyUkyNMCZOkTEB4681Ov4W7gB0/C+WVd2RpbAumD6hNslwKoBbiSgI6
         WYQdJuWxlGsPGontoJ4i3arkJAdrqWnh2xTnLhKF8h3oaf5RZQgjSr3Popcx0bwNz+GR
         80e8AbVd/9O/HCr0ddbi3h7V6f1RHKJUSQDptSyu1hTRUNcRuFvj/dR6KdHUIfHXOSUC
         2hhXJ5hNOq19py1oEMaAsZIj+82fucphizbFvNCWIu5o7g68/YF1LIR6vBeD2jENFeeQ
         vb4w==
X-Gm-Message-State: AOAM5324jkRSI1pDpbeHt2VHAjamoUmUmuxXXzq8v+DqCrRskBuJI7qL
        0E1vFWkYf1Dswae2+fiv4+U=
X-Google-Smtp-Source: ABdhPJzFzxYVSyN53pakiySgoDRQ0pojDbnyg3x0Jf4OKQDyn8YhrL6ATb+6AYSCZhN8p92FQmKrwg==
X-Received: by 2002:a1c:1b8f:: with SMTP id b137mr1338786wmb.151.1598878711891;
        Mon, 31 Aug 2020 05:58:31 -0700 (PDT)
Received: from ogabbay-VM ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id p14sm12658869wrx.90.2020.08.31.05.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 05:58:31 -0700 (PDT)
Date:   Mon, 31 Aug 2020 15:58:29 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes pull request for kernel 5.9-rc4
Message-ID: <20200831125829.GA29862@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request for habanalabs driver fixes for 5.9-rc4.
Two small fixes, details are in the tag.

Thanks,
Oded

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-08-31

for you to fetch changes up to 69c6e18d0ce9980c8c6708f1fdb4ba843f8df172:

  habanalabs: fix report of RAZWI initiator coordinates (2020-08-31 15:10:27 +0300)

----------------------------------------------------------------
This tag contains the two fixes:

- prevent user buffer overflow through a debugfs entry

- fix the report of the engines that create RAZWI error in GAUDI

----------------------------------------------------------------
Moti Haimovski (1):
      habanalabs: prevent user buff overflow

Ofir Bitton (1):
      habanalabs: fix report of RAZWI initiator coordinates

 drivers/misc/habanalabs/common/debugfs.c           |  2 +-
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    | 32 +++++++++++-----------
 2 files changed, 17 insertions(+), 17 deletions(-)
