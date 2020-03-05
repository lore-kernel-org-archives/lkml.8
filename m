Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC9BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B4E207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="1DIq3i5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0OTpwfoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgCEVQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:16:54 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42779 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgCEVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:16:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C24221F30;
        Thu,  5 Mar 2020 16:16:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 05 Mar 2020 16:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=XdQ+RswJL5NMl40GJb5WlNSbRs
        qA/OCEL8OeWLu2sac=; b=1DIq3i5Mt+pRb3sS1NWiHTIjIc5XjG+qFV/shkSg7t
        5ImiieuJc4T4WVs/zoYa7Opp1+m7pH9G1ywxke1GdTvSA0D6G96Ypqyn224PyUdS
        Dt0umj6zdkKMZ2YGrmwIAWok2NXr9Tku7MZZtrV7BF9vat0KOt2ivalobkI+wEso
        /LLMrwm9UlLUAeBQBqRUIcfQ6o83Sh+jJT+f7KkmmIRKgglgu3duqYD56XcrfG68
        wv9M2S9gYjpsDSJC90uC2Yog1ruukVZKUc4ItroCh99rAi4mD/I9mMc8Ly+b4GYP
        1wErySk6oWNXkoObGVZnuPKyPUbfTkgGwPotTBU0tczw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XdQ+RswJL5NMl40GJ
        b5WlNSbRsqA/OCEL8OeWLu2sac=; b=0OTpwfocD7+OQI1L/9PVGL6W/rkk4lJ5y
        v1IhvdOz0k7PzDsjzl/lDBL7ZRH4VLbYmc7cy7u3SGOEvXfKEiP63tOzyLWPu270
        bbgUhagy20rsMqAc962xRxJWU5KjqJn6TPwNSh7KvCeu/EvMU5wgzXiZDMzGnapu
        286DLXK2xBiqxQAlitIsFKACqGingzdu0HEuZkA43ztVr7xD2U6ALuvefGASqIhr
        9J1fdZOLlmJacgqwjZdHv9qXxFBF5qbEZzkpRvAozkJhetGr6MWhbHXbztqnQWiq
        zbkIILNl6BCnf/PEXKGRjRSOE7gqQUHkQsl/Q7mh7y677UxS1AF0A==
X-ME-Sender: <xms:QWxhXvufCl5LLvh4p7IDvwtoIPvWOGRcX32ZjEkKiKVoMPgy2yPpfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddutddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrddunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:QWxhXlBrp9PbfGlIhWaCtCW88XfMO5wBCM-Mgd6c5LcJ5XbC6Q_Kag>
    <xmx:QWxhXoMUI_ZlbcZ1RRIZg8CuoqW5UVWuHAr2wY4JY-h4AhbXcXkyKA>
    <xmx:QWxhXg3WDzctGthjck1v_tjKYQirNQyaJWH6Lk2_yzml0Cay8k6vcg>
    <xmx:Q2xhXkz98o39WExgDbaqENUSLugCyw4Kg8daYR6N_Rc8GOQki4txqw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id E630B30612AF;
        Thu,  5 Mar 2020 16:16:48 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, shakeelb@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Subject: [PATCH v2 0/4] Support user xattrs in cgroupfs
Date:   Thu,  5 Mar 2020 13:16:28 -0800
Message-Id: <20200305211632.15369-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User extended attributes are useful as metadata storage for kernfs
consumers like cgroups. Especially in the case of cgroups, it is useful
to have a central metadata store that multiple processes/services can
use to coordinate actions.

A concrete example is for userspace out of memory killers. We want to
let delegated cgroup subtree owners (running as non-root) to be able to
say "please avoid killing this cgroup". This is especially important for
desktop linux as delegated subtrees owners are less likely to run as
root.

The first two commits set up some stuff for the third commit which
intro introduce a new flag, KERNFS_ROOT_SUPPORT_USER_XATTR,
that lets kernfs consumers enable user xattr support. The final commit
turns on user xattr support for cgroupfs.

Changes from v1:
- use kvmalloc for xattr values
- modify simple_xattr_set to return removed size
- add accounting for total user xattr size per cgroup

Daniel Xu (4):
  kernfs: kvmalloc xattr value instead of kmalloc
  kernfs: Add removed_size out param for simple_xattr_set
  kernfs: Add option to enable user xattrs
  cgroupfs: Support user xattrs

 fs/kernfs/inode.c           | 91 ++++++++++++++++++++++++++++++++++++-
 fs/kernfs/kernfs-internal.h |  2 +
 fs/xattr.c                  | 17 +++++--
 include/linux/kernfs.h      | 11 ++++-
 include/linux/xattr.h       |  3 +-
 kernel/cgroup/cgroup.c      |  3 +-
 mm/shmem.c                  |  2 +-
 7 files changed, 119 insertions(+), 10 deletions(-)

-- 
2.21.1

