Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96C8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5C62074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgDGMh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:37:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:48834 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:37:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 93DF36094C4B;
        Tue,  7 Apr 2020 14:37:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 21QNlY7B4jTl; Tue,  7 Apr 2020 14:37:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 07A6061A702F;
        Tue,  7 Apr 2020 14:37:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wQQN5T5b7pal; Tue,  7 Apr 2020 14:37:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id DC0C96089348;
        Tue,  7 Apr 2020 14:37:54 +0200 (CEST)
Date:   Tue, 7 Apr 2020 14:37:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1397520880.91813.1586263074756.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v5.7-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: yMW6DVf/Myb6Ix/xFJbxllyqgiGnhg==
Thread-Topic: UML changes for v5.7-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.7-rc1

for you to fetch changes up to 4a7c46247f9c620c0390a15cb00b6ef9576b9c23:

  um: Remove some unnecessary NULL checks in vector_user.c (2020-03-29 23:56:47 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- New mode for time travel, external via virtio
- Fixes for ubd to make sure no requests can get lost
- Fixes for vector networking
- Allow CONFIG_STATIC_LINK only when possible
- Minor cleanups and fixes

----------------------------------------------------------------
Alan Maguire (1):
      um: falloc.h needs to be directly included for older libc

Alex Dewar (1):
      um: Remove some unnecessary NULL checks in vector_user.c

Andy Shevchenko (2):
      um: Don't use console_drivers directly
      hostfs: Use kasprintf() instead of fixed buffer formatting

Brendan Higgins (1):
      um: Make CONFIG_STATIC_LINK actually static

David Gow (1):
      um: Fix overlapping ELF segments when statically linked

Gabriel Krisman Bertazi (2):
      um: ubd: Prevent buffer overrun on command completion
      um: ubd: Retry buffer read on any kind of error

Johannes Berg (6):
      um: Move timer-internal.h to non-shared
      um: time-travel: Rewrite as an event scheduler
      um: virtio: Implement VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS
      um: Implement time-travel=ext
      um: Implement ndelay/udelay in time-travel mode
      um: Implement cpu_relax() as ndelay(1) for time-travel

Krzysztof Kozlowski (1):
      um: Cleanup CONFIG_IOSCHED_CFQ

Leon Romanovsky (2):
      um: Don't overwrite ethtool driver version
      um: Delete never executed timer

Sjoerd Simons (1):
      um: vector: Avoid NULL ptr deference if transport is unset

Wen Yang (1):
      um: Fix len of file in create_pid_file

 arch/um/Kconfig                         |   9 +-
 arch/um/configs/i386_defconfig          |   2 +-
 arch/um/configs/x86_64_defconfig        |   2 +-
 arch/um/drivers/Kconfig                 |   3 +
 arch/um/drivers/net_kern.c              |  13 -
 arch/um/drivers/ubd_kern.c              |  12 +-
 arch/um/drivers/vector_kern.c           |   5 +-
 arch/um/drivers/vector_user.c           |  15 +-
 arch/um/drivers/vhost_user.h            |  12 +-
 arch/um/drivers/virtio_uml.c            | 153 +++++++--
 arch/um/include/asm/Kbuild              |   1 -
 arch/um/include/asm/delay.h             |  30 ++
 arch/um/include/linux/time-internal.h   |  84 +++++
 arch/um/include/shared/os.h             |   1 +
 arch/um/include/shared/timer-internal.h |  76 -----
 arch/um/kernel/kmsg_dump.c              |   9 +-
 arch/um/kernel/process.c                |  39 +--
 arch/um/kernel/skas/syscall.c           |   5 +-
 arch/um/kernel/time.c                   | 538 ++++++++++++++++++++++++++++++--
 arch/um/kernel/uml.lds.S                |   2 +-
 arch/um/os-Linux/file.c                 |  31 ++
 arch/um/os-Linux/time.c                 |   1 -
 arch/um/os-Linux/umid.c                 |   5 +-
 arch/x86/um/asm/processor.h             |  12 +-
 fs/hostfs/hostfs_kern.c                 |  12 +-
 include/uapi/linux/um_timetravel.h      | 128 ++++++++
 26 files changed, 986 insertions(+), 214 deletions(-)
 create mode 100644 arch/um/include/asm/delay.h
 create mode 100644 arch/um/include/linux/time-internal.h
 delete mode 100644 arch/um/include/shared/timer-internal.h
 create mode 100644 include/uapi/linux/um_timetravel.h
