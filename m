Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E67C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3036F20786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="xvsIaGxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgCaP1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:27:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37448 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbgCaP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:27:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so17419132qtu.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VFmTu4uYulpUU5in51vToheYdVlAq1Y7eqMyGwDEhI8=;
        b=xvsIaGxnMknx8N7QgJaLh9AYgim3Yzr9d2ImHJb6Fm01eN61rKj0TtvbuDRcAonw05
         ZlQT1tqS2mvg9gInk48P+SLwLCFspAXO9goQ80GzoZSYcdozAOr4AbqieMYIDBCUhEga
         XnQao8gTvNKF0cUQ7PWdMaBP5jx9dK++L03hKkti65thILpnTTU6HPikNcaOKAOynM3i
         Xd4RfRPHXw1kpYFicGHnWU23E+FJLXUDWavXEqCQkBYqg/E+J5JqVP+9ViwXqzToUnjM
         Ip29GoMWHHk0bc4oAX91VvskBcLFjXK386s3VyOVm/qiKMtxsgKhOOc89QwGBMb4zNDn
         Dhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VFmTu4uYulpUU5in51vToheYdVlAq1Y7eqMyGwDEhI8=;
        b=DfddWXqF/UVz+LdjzRZO7ZTTEZvSJYwFYQyLMFMG/mTdN1BLaOebaley6iRvkfk2aW
         lu0ibLHCfmp4opl+CNcuLVyMlrrdRV2BoskHsjB2EGPNNI8Blrx2oiopgohEFhhYL+It
         pKn8cn7vKGQi3GkBO9IMkb0GlMly1SAT+ILxROG6+f9ViMK5zLAntpQfwDBpf+YaI3VA
         SiHEmxpr4Pvvuoea+v+V5LbotHJJiRsEknkLTleR/o2oLu9Wk6JQNgOpukYfObKi2g1U
         8zIxB3Pt+1IIR1rkjDV+ANMosM/1xDrHwSvyRHRrRn++GgxUJlLd3SuR0eISqR5Z2auC
         rkZw==
X-Gm-Message-State: ANhLgQ39GOQy6M0U1CbJFjiQTuYLR0dvMt+kysavxprjPz9lhH0ngiob
        223vdv+CnzFvCHnwKXH28XXQKT9YaTWbKQ==
X-Google-Smtp-Source: ADFU+vs5KHa/86yJddBLr6QS2vwH/Z2sgGhSsdkNYXC51dKELK8f6xV1wM4weTeXYx51/wy8n5E3CQ==
X-Received: by 2002:ac8:3072:: with SMTP id g47mr5590057qte.278.1585668442641;
        Tue, 31 Mar 2020 08:27:22 -0700 (PDT)
Received: from localhost ([2605:a601:a664:2e00:9c27:5ab0:8441:9150])
        by smtp.gmail.com with ESMTPSA id r29sm14079899qtj.76.2020.03.31.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:27:22 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date:   Tue, 31 Mar 2020 11:27:21 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for v5.7
Message-ID: <20200331152721.GA1719@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes and AMD NTB driver changes for v5.7.  Please consider pulling them.

Thanks,
Jon



The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.7

for you to fetch changes up to b350f0a3eb264962caefeb892af56c1b727ee03f:

  NTB: add pci shutdown handler for AMD NTB (2020-03-13 10:04:20 -0400)

----------------------------------------------------------------
Bug fixes for a few printing issues, link status detection bug on AMD
hardware, and a DMA address issue with ntb_perf.  Also, large series of
AMD NTB patches.

----------------------------------------------------------------
Alexander Fomichev (1):
      ntb_hw_switchtec: Fix ntb_mw_clear_trans error if size == 0

Arindam Nath (15):
      NTB: Fix access to link status and control register
      NTB: clear interrupt status register
      NTB: Enable link up and down event notification
      NTB: define a new function to get link status
      NTB: return the side info status from amd_poll_link
      NTB: set peer_sta within event handler itself
      NTB: remove handling of peer_sta from amd_link_is_up
      NTB: handle link down event correctly
      NTB: handle link up, D0 and D3 events correctly
      NTB: move ntb_ctrl handling to init and deinit
      NTB: add helper functions to set and clear sideinfo
      NTB: return link up status correctly for PRI and SEC
      NTB: remove redundant setting of DB valid mask
      NTB: send DB event when driver is loaded or un-loaded
      NTB: add pci shutdown handler for AMD NTB

Helge Deller (1):
      ntb_tool: Fix printk format

Jiasen Lin (2):
      NTB: Fix an error in get link status
      NTB: ntb_perf: Fix address err in perf_copy_chunk

Sanjay R Mehta (1):
      MAINTAINERS: update maintainer list for AMD NTB driver

Takashi Iwai (1):
      NTB: ntb_transport: Use scnprintf() for avoiding potential buffer overflow

 MAINTAINERS                            |   1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c        | 290 +++++++++++++++++++++++++++------
 drivers/ntb/hw/amd/ntb_hw_amd.h        |   8 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |   2 +-
 drivers/ntb/ntb_transport.c            |  58 +++----
 drivers/ntb/test/ntb_perf.c            |  57 +++++--
 drivers/ntb/test/ntb_tool.c            |  14 +-
 7 files changed, 332 insertions(+), 98 deletions(-)
