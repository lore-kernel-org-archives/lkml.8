Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA2BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F81E222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599833256;
	bh=WtLDphGkBiYmdc6BhAHcqBRHKaHreheENgkhJb+8c5k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CiNoHE/TjmTF7Tv5P9n/EM34u6k5gF1XSDDeDPHcUZsI81obfiC6L+fMWz7vqKVjp
	 w25GKEVC5PDF2onB5CfXczLG1cgHL2JVSWvmeueQAcqU2CaZ8txzCmNipNQ0O4nQCB
	 imzWQ5dF2qL2AWErY2pSrG1ST0XxuR9Vdn5o1j1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgIKOGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgIKN3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:29:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D246B2220D;
        Fri, 11 Sep 2020 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599829210;
        bh=WtLDphGkBiYmdc6BhAHcqBRHKaHreheENgkhJb+8c5k=;
        h=From:To:Cc:Subject:Date:From;
        b=xI+pkjmzFNex8nlX/z6/sow4RrduFhZo7Wd0G+2OWxeooxU4r2XCZyYg6e0MhTiIP
         BJe2tFp/Mn0i0CdULWZZM8vgmFgJsD9G3jxdOZPliHOZPY/rgpxjRYJ+sUQjcUKkrC
         MEzlHmamXTN3pOvb8oEQ51z6WnfPNODKpT6qxcRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 5.8 00/16] 5.8.9-rc1 review
Date:   Fri, 11 Sep 2020 14:47:17 +0200
Message-Id: <20200911122459.585735377@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.8.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.8.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.8.9-rc1
X-KernelTest-Deadline: 2020-09-13T12:25+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.8.9 release.
There are 16 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 13 Sep 2020 12:24:42 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.8.9-rc1

Florian Westphal <fw@strlen.de>
    mptcp: free acked data before waiting for more memory

Jakub Kicinski <kuba@kernel.org>
    net: disable netpoll on fresh napis

Tuong Lien <tuong.t.lien@dektech.com.au>
    tipc: fix using smp_processor_id() in preemptible

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tipc: fix shutdown() of connectionless socket

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    taprio: Fix using wrong queues in gate mask

Xin Long <lucien.xin@gmail.com>
    sctp: not disable bh in the whole sctp_get_port_local()

Kamil Lorenc <kamil@re-ws.pl>
    net: usb: dm9601: Add USB ID of Keenetic Plus DSL

Paul Moore <paul@paul-moore.com>
    netlabel: fix problems with mapping removal

Ido Schimmel <idosch@nvidia.com>
    ipv6: Fix sysctl max for fib_multipath_hash_policy

Ido Schimmel <idosch@nvidia.com>
    ipv4: Silence suspicious RCU usage warning

Jason Gunthorpe <jgg@nvidia.com>
    RDMA/cma: Execute rdma_cm destruction from a handler properly

Jason Gunthorpe <jgg@nvidia.com>
    RDMA/cma: Remove unneeded locking for req paths

Jason Gunthorpe <jgg@nvidia.com>
    RDMA/cma: Using the standard locking pattern when delivering the removal event

Jason Gunthorpe <jgg@nvidia.com>
    RDMA/cma: Simplify DEVICE_REMOVAL for internal_id

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix linked deferred ->files cancellation

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix cancel of deferred reqs with ->files


-------------

Diffstat:

 Makefile                           |   4 +-
 drivers/infiniband/core/cma.c      | 257 ++++++++++++++++++-------------------
 drivers/net/usb/dm9601.c           |   4 +
 fs/io_uring.c                      |  47 +++++++
 net/core/dev.c                     |   3 +-
 net/core/netpoll.c                 |   2 +-
 net/ipv4/fib_trie.c                |   3 +-
 net/ipv6/sysctl_net_ipv6.c         |   3 +-
 net/mptcp/protocol.c               |   3 +-
 net/netlabel/netlabel_domainhash.c |  59 ++++-----
 net/sched/sch_taprio.c             |  30 ++++-
 net/sctp/socket.c                  |  16 +--
 net/tipc/crypto.c                  |  12 +-
 net/tipc/socket.c                  |   9 +-
 14 files changed, 259 insertions(+), 193 deletions(-)


