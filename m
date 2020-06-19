Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96253C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729A8217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VVwx3ZGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395115AbgFSQcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389512AbgFSOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:51:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C1CC0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:51:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so1894735pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PFwcZNJJ7J9pO5V4LgviWHgUqQktGpHF/1kf5JMeuDo=;
        b=VVwx3ZGlX2RwFbSkQjJpR+KnTKm2X8fVgt9HDsdg9laBMqpsD8A+rToclzEwT1eFa+
         B7lNk6ClHheYaxl9v5HuDfNiTwE9uYijkbeYPKVCVcYgPnNfN7teMIUIEMeqmeebApau
         Olk9P/8SEPfBkj4iGMXY4d5PYAWqHOuGFDWgIgmJatlXgD8WNQI8hH/GEBbcpYsODy1W
         ac8WqvylSyLtm4RLxKHXFvN1gR3ZnTS3RHCG6u2KTPU8as2weM3XJjwlLNQde5A/Mqmw
         7ZMv5iyYVtbhVEmFgoeTrxC1VG4TBB0PCUTuD+DGploEiDxeZSWD9JMe2BhyHINfK+6S
         YHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PFwcZNJJ7J9pO5V4LgviWHgUqQktGpHF/1kf5JMeuDo=;
        b=aVc+jI/il+ak+lj2AcVybdt2kyoKhR5Jft2uigpwspgdYjWgNAhe7298OBXIg+wqKH
         0i20LeYs9LO1T5vCVH50mmwxe0UKUxxNFhsaRT2H7lS6R4DkLKAudo25VO9VtnMlOLqD
         VUt+QPe3WLGKuMfNOSHcrjm7U1zAGawb7Yd9OTFWZznUcdl1IQpaPmqPzjSxfNvWbGWT
         jS+8P3mWhLaopRUeDeuqet65RfyYw3ra8IFPhAgNyLyqbtCAVgpr+AzI5fjeY2e2BfmK
         QiOFK4fqx60sndtPPmwN2yJVyGeUwB/8NdCzVIHeSVi83vjBLwz+HN7IiWZT3dlTVfv5
         v9+A==
X-Gm-Message-State: AOAM530Mocc6lBEDaJy1YSXlVReE6F7QVbSWyMFkan9ttQhXH4+ga1wo
        hvGe3C/qweiTdqDqEwShiZmBX7WvAd6tGw==
X-Google-Smtp-Source: ABdhPJxveQ/cPoUUnyZh3usSqy7LrbOlRjM8Jdwm6ASW0EJqk2pfxtjHXKRvby/5eylPBEfUnPIPqg==
X-Received: by 2002:a05:6a00:2b0:: with SMTP id q16mr8456361pfs.104.1592578318472;
        Fri, 19 Jun 2020 07:51:58 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k126sm6297710pfd.129.2020.06.19.07.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:51:57 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.8-rc2
Message-ID: <c7fcf452-15af-4085-528a-7bc52110e21c@kernel.dk>
Date:   Fri, 19 Jun 2020 08:51:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A few minor changes that should go into this release. Please pull!

The following changes since commit 6929f71e46bdddbf1c4d67c2728648176c67c555:

  atomisp: avoid warning about unused function (2020-06-03 21:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.8-2020-06-19

for you to fetch changes up to b5292111de9bb70cba3489075970889765302136:

  libata: Use per port sync for detach (2020-06-18 09:21:40 -0600)

----------------------------------------------------------------
libata-5.8-2020-06-19

----------------------------------------------------------------
Kai-Heng Feng (1):
      libata: Use per port sync for detach

Navid Emamdoost (1):
      sata_rcar: handle pm_runtime_get_sync failure cases

Ye Bin (1):
      ata/libata: Fix usage of page address by page_address in ata_scsi_mode_select_xlat function

 drivers/ata/libata-core.c | 11 +++++------
 drivers/ata/libata-scsi.c |  9 ++++++---
 drivers/ata/sata_rcar.c   | 11 +++++++----
 include/linux/libata.h    |  3 +++
 4 files changed, 21 insertions(+), 13 deletions(-)

-- 
Jens Axboe

