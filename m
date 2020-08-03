Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62424C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FD820678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgHCKQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:16:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:37680 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgHCKQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:16:14 -0400
Received: from [192.168.15.50] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2XVW-0002NB-Ii; Mon, 03 Aug 2020 13:15:50 +0300
Subject: [PATCH 0/8] namespaces: Introduce generic refcount
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Mon, 03 Aug 2020 13:16:10 +0300
Message-ID: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every namespace type has its own counter. Some of them are
of refcount_t, some of them are of kref.

This patchset introduces generic ns_common::count for any
type of namespaces instead of them.

---

Kirill Tkhai (8):
      ns: Add common refcount into ns_common add use it as counter for net_ns
      uts: Use generic ns_common::count
      ipc: Use generic ns_common::count
      pid: Use generic ns_common::count
      user: Use generic ns_common::count
      mnt: Use generic ns_common::count
      cgroup: Use generic ns_common::count
      time: Use generic ns_common::count


 fs/mount.h                     |    3 +--
 fs/namespace.c                 |    4 ++--
 include/linux/cgroup.h         |    5 ++---
 include/linux/ipc_namespace.h  |    3 +--
 include/linux/ns_common.h      |    3 +++
 include/linux/pid_namespace.h  |    4 +---
 include/linux/time_namespace.h |    9 ++++-----
 include/linux/user_namespace.h |    5 ++---
 include/linux/utsname.h        |    9 ++++-----
 include/net/net_namespace.h    |   11 ++++-------
 init/version.c                 |    2 +-
 ipc/msgutil.c                  |    2 +-
 ipc/namespace.c                |    4 ++--
 kernel/cgroup/cgroup.c         |    2 +-
 kernel/cgroup/namespace.c      |    2 +-
 kernel/pid.c                   |    2 +-
 kernel/pid_namespace.c         |   13 +++----------
 kernel/time/namespace.c        |    9 +++------
 kernel/user.c                  |    2 +-
 kernel/user_namespace.c        |    4 ++--
 kernel/utsname.c               |    7 ++-----
 net/core/net-sysfs.c           |    6 +++---
 net/core/net_namespace.c       |    6 +++---
 net/ipv4/inet_timewait_sock.c  |    4 ++--
 net/ipv4/tcp_metrics.c         |    2 +-
 25 files changed, 51 insertions(+), 72 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

