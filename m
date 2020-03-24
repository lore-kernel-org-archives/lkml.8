Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F3C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D802051A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S13aR4qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCXJfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:35:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51438 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgCXJfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:35:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id c187so2400793wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Q6O4NDT/2jSNxv8wTDNHBRmghCW+QBEdHsbQoGWcHos=;
        b=S13aR4qAwIp0D7xm0U5Q68vNOq2eHTfb38YtC0PADuUyTp/tp7K7F2GueIZ7fW1sbf
         wq0bCCh3WdSkA+cOG6EEMikECXLb0X3KFCgk/qlTpWkomAsRGFt/LiFhTeWXSzJSNzGZ
         upM9wh+/FA/DoRM2+vTnzofaKUelnPWywlDGhCnQhadSF70SORpKT6hWfV3O/blkoPxk
         PXqvRfdOF5r580g9g6ZeT7EiDIGGOtpPiRB2jjxSt3tj6exH8OQPvbV5G3r/rvYDFsc8
         TTAolYGibVgsz211DCbdEKetlxL6UeZbzYQditnoDdbqrNEJ7p6tJgEfLFKWHCmRLu0O
         CnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q6O4NDT/2jSNxv8wTDNHBRmghCW+QBEdHsbQoGWcHos=;
        b=dMeNu/o9xZreD9hsqcdqXRrp0tDJd3Nr4UcyD7Zqo/jrkCZJDe1jjhSEM7Tzn1plFB
         33T2h25qLnAoOi23WELnPDbzrcqOAqmSleYBr6kef9LHjK1eu/au/ZpXBKnhaXAXmHX/
         kdL6GfAZ8Wxgk/NxUejkdg2n4eqWnsZxiGBOIeBpZYSDPJoAz4Eezb3U8nR4wtaQonPG
         fFCcm6rq3iNjU7Hn5qHXYdo1lzhMghIaYsSa6Z1+7VytMUM21LIsrucL9YDvR7lVd1pZ
         qb50neYBW6sOEb2tEsouEBHmCYum38fe3mxbNkiGcaRqRk8rj4rV8KJdoPY7+72fNG+s
         R0rA==
X-Gm-Message-State: ANhLgQ0YBUO+mi8ZWuV/ycj29cO8U13zZNXYW/H0nzSjyaq3FV8+InJx
        lntzFy17g4vdQm3tPgRuaiu6pUcj
X-Google-Smtp-Source: ADFU+vsFdPJmPvM+trCC43o/Pd05TzqadXvetSpUYCH8uqcHA4kv2ZI3zEl40aAvfnCHmj1Dt9zdjQ==
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr4674411wmf.151.1585042504589;
        Tue, 24 Mar 2020 02:35:04 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id t124sm3571402wmg.13.2020.03.24.02.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 02:35:02 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:35:01 +0200
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.7
Message-ID: <20200324093501.GA27782@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request for habanalabs driver for kernel 5.7.

It mainly contains improvements to MMU, hwmon sensors and a new debugfs
interface to improve debug speed when reading large internal memories.

Please see the tag message for more details on what this pull request
contains.

Thanks,
Oded

The following changes since commit bbde5709ee4f60a43b7372545454947044655728:

  nvmem: mxs-ocotp: Use devm_add_action_or_reset() for cleanup (2020-03-23 20:05:23 +0100)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-03-24

for you to fetch changes up to 1184550155013f2672198c4c68f3a6961fccab09:

  habanalabs: fix pm manual->auto in GOYA (2020-03-24 10:54:17 +0200)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.7:

- MMU code improvements that includes:
  - Flush MMU TLB cache only once, at the end of mapping/unmapping
    function, instead of flushing after mapping of every page.
  - Add future ASIC support by splitting properties of ASIC capabilities
    regarding mapping of host memory to regular and huge pages.

- Add debugfs interface to write and read 64-bit values from the device's
  memory/registers. Previously the driver provided interface for 32-bit
  values and this will allow the user to debug much more quickly. We saw it
  gives a boost of around 1.5 - 1.7 when reading internal memories.

- Support temperature offset via sysfs as defined in
  https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface

- Display historical maximum of various sensors.

- Print to kernel log when clock throttling occurs to due breach of power
  or thermal envelope. Also prints when clock throttling is finished
  (clock is back to optimal).

- Fix bug when moving from manual to auto power-management mode.

- Print a message ("unsupported device") to kernel log in case a GAUDI device
  is recognized.

- Small bug fixes and minor improvements to code.

----------------------------------------------------------------
Christine Gharzuzi (1):
      habanalabs: provide historical maximum of various sensors

Jules Irenge (2):
      habanalabs: Add missing annotation for goya_hw_queues_lock()
      habanalabs: Add missing annotation for goya_hw_queues_unlock()

Moti Haimovski (3):
      habanalabs: add debugfs write64/read64
      habanalabs: support temperature offset via sysfs
      habanalabs: modify the return values of hl_read/write routines

Oded Gabbay (5):
      habanalabs: removing extra ;
      habanalabs: ratelimit error prints of IRQs
      habanalabs: update goya firmware register map
      habanalabs: show unsupported message for GAUDI
      habanalabs: fix pm manual->auto in GOYA

Omer Shpigelman (4):
      habanalabs: use the user CB size as a default job size
      habanalabs: split the host MMU properties
      habanalabs: fix DDR bar address setting
      habanalabs: add print upon clock change

Pawel Piskorski (1):
      habanalabs: flush only at the end of the map/unmap

Tomer Tayar (3):
      habanalabs: Modify CS jobs counter to u16
      habanalabs: Avoid running restore chunks if no execute chunks
      habanalabs: Remove unused parse_cnt variable

 .../ABI/testing/debugfs-driver-habanalabs          |  14 ++
 drivers/misc/habanalabs/command_submission.c       |  51 +++--
 drivers/misc/habanalabs/debugfs.c                  |  92 ++++++++-
 drivers/misc/habanalabs/device.c                   |   2 +-
 drivers/misc/habanalabs/goya/goya.c                | 204 ++++++++++++++++---
 drivers/misc/habanalabs/goya/goya_coresight.c      |   4 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |   2 +-
 drivers/misc/habanalabs/habanalabs.h               |  62 +++---
 drivers/misc/habanalabs/habanalabs_drv.c           |  11 +-
 drivers/misc/habanalabs/hwmon.c                    | 106 +++++++---
 drivers/misc/habanalabs/include/armcp_if.h         |  20 +-
 .../habanalabs/include/goya/goya_async_events.h    |   4 +
 .../misc/habanalabs/include/goya/goya_reg_map.h    |  39 ++--
 drivers/misc/habanalabs/include/hl_boot_if.h       |  39 ++--
 drivers/misc/habanalabs/memory.c                   | 222 ++++++++++++++-------
 drivers/misc/habanalabs/mmu.c                      | 110 ++++++----
 16 files changed, 709 insertions(+), 273 deletions(-)
