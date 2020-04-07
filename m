Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3983C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9481420731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDpjtwbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgDGMQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:16:33 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37720 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGMQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:16:33 -0400
Received: by mail-pj1-f65.google.com with SMTP id k3so699242pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1WqirDYwLo94Wc4sxZtJg3i9WYW0Oz0X084NUnMMCRs=;
        b=KDpjtwbIHVmYqWEu82aR5iIWPNorzGB5GHPagUhMgH423PH1n351g0e2qjUmagji6b
         c5sMZV1HzSY0Cnp0n2S0I1QlwYA6vgjcDGvuvUTUXyRX7Rxmvry0p6wHiJLHdQhz0UrT
         b68uvrptGu5fP2tKo0aZpD/A8taX/TPuIY9H1xiGAXgAFsm59O4wa5pgXH7zLK0t+bxY
         xQ1QiOSA7uE+JaW0kSfpuQT7GNChYLsqDGNifRTbs0xKpdO0RIIBXiFuhTXGvWdFBMJ3
         iiX6U/vVGB75LEbyWTE9i9S8Sk+bD1ayLrHbc87C2n/4ASKHt07dNYSBYLO8v2E740l9
         LXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1WqirDYwLo94Wc4sxZtJg3i9WYW0Oz0X084NUnMMCRs=;
        b=Nyj2hC98chQ8sFKpLQEuau0ilhHHPnA1d4E/81Cwgv91bmHmMqEVuqljVvXa/pEd6y
         uQl5Tc6M3/nRHpJpqcGyKnOveLWVFkcsw+insSXl6gDDyQPhBu+yHKf6iAm9/wR1pSpN
         X0wTD62B/Isu2Xakb6w5eRGF1Y0JinGVJhTP+LSI+xBCMbWVan9sGD+pw8QqTmjJEWmN
         4eyBQgVco6J5Um3FLRSgBX2cgP82nvFM/uEmB1U13cK2HRNnEeRs2N1ibdvkPOtRSb/s
         W05rixKsO8rmXVOv/0oMSM+vl2jmwpwFhgfRpTadlK5if0Q2iOMK0P3/h/CvN0cSWyP6
         Q45A==
X-Gm-Message-State: AGi0Pub7WNHTOhKDjUoRQPu9v6I+1WZCYDx+8JKv9/iZB8rRHugtwSm6
        b6noSJNUQ3CAurD/hn3ZaZmoRu5H
X-Google-Smtp-Source: APiQypKBRRAUfzgAqy/QuXoSSuJbdovo8/J5FmU1+moBUCW3bjwTMqGAq9HJANpg9Tt4pNz49L5+UA==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr2501211pjb.101.1586261791768;
        Tue, 07 Apr 2020 05:16:31 -0700 (PDT)
Received: from localhost (g54.222-224-167.ppp.wakwak.ne.jp. [222.224.167.54])
        by smtp.gmail.com with ESMTPSA id e187sm13517135pfe.143.2020.04.07.05.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 05:16:30 -0700 (PDT)
Date:   Tue, 7 Apr 2020 21:16:28 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: [GIT PULL] OpenRISC updates for v5.6
Message-ID: <20200407121628.GP7926@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling...

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 9737e2c5f0bc768b58416ec070bd96c91c52a153:

  openrisc: Remove obsolete show_trace_task function (2020-03-18 22:10:44 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.6

A few cleanups all over the place, things of note:
 - Enable the clone3 syscall
 - Remove CONFIG_CROSS_COMPILE from Krzysztof Kozlowski
 - Update to use mmgrab from Julia Lawall

----------------------------------------------------------------
Julia Lawall (1):
      openrisc: use mmgrab

Krzysztof Kozlowski (1):
      openrisc: configs: Cleanup CONFIG_CROSS_COMPILE

Stafford Horne (4):
      openrisc: Convert copy_thread to copy_thread_tls
      openrisc: Enable the clone3 syscall
      openrisc: Cleanup copy_thread_tls docs and comments
      openrisc: Remove obsolete show_trace_task function

 Documentation/openrisc/openrisc_port.rst   |  4 ++--
 arch/openrisc/Kconfig                      |  1 +
 arch/openrisc/configs/or1ksim_defconfig    |  1 -
 arch/openrisc/configs/simple_smp_defconfig |  1 -
 arch/openrisc/include/uapi/asm/unistd.h    |  1 +
 arch/openrisc/kernel/process.c             | 18 ++++++------------
 arch/openrisc/kernel/smp.c                 |  3 ++-
 arch/openrisc/kernel/traps.c               |  7 -------
 8 files changed, 12 insertions(+), 24 deletions(-)
