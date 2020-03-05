Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9554DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62708208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="wmSQpSAK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q57F6TBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgCEVQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:16:56 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41489 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgCEVQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:16:55 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 98BA822054;
        Thu,  5 Mar 2020 16:16:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 05 Mar 2020 16:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=u1MrauuLIEyJS
        luP5fVyT/O0peA1eklpye+z1PDwhEg=; b=wmSQpSAKu4LXaGJIsteSM53MQH+uy
        0RqMIl1VH7k0x2nZTSiVyT0//q+FWhYl43TkSoSbWU1zGocLkedCzJtkAqCQeRt8
        Xr2XwJ4NoQ6PueBwaENEjtPLwKX9DyemoXqCYlBdIIRI6WttOT39nIs3fMvtCADV
        19nn+1tbk+yycLq/ZWa54WYPcGCy8PlMntZZHtlICIYzMNAh3U7pRrE7FBtST4IR
        iDtgRgmdxPkiqJUSInrtr4mW7KjXiGm0Zj8LDg1lyYrZABuqbMd0zmIP5a5XeH/G
        Ha1wYDx7ytRpqMhIjVvV5LGW3etKvicUN0dgct24r14Dhs5NjdVXPcM5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=u1MrauuLIEyJSluP5fVyT/O0peA1eklpye+z1PDwhEg=; b=Q57F6TBF
        5OXG2c8fVkHuCZf5U9CiHd1pdmQWmlZx/raZCljiH/QkPtsECbIYcGvXfaO3fDaB
        dM+7Q0ktu1/ap74v9qxUCRKZImbEnl+PDN6qeb3uPtk8lQw8O8hvnqHlvCp0aHzi
        rYBZJCIy8hFGsz+EfBjUz8rtt65s6rfh2LNytHOkZtfnR4CICk2UN8LGND1vMFEp
        6B29Y6EQwvgL5nDGZOyAhVfRiJq9B1744omtu8zHlXafSLLdGz5MJ/hUZ3g1+vHr
        EDx5K63lc5ZITgrmdpzR0snuKZuruLkDTncLvTtjckTFYkTFroiQShsYGT3iyRfx
        6TZxWddRu8AUlQ==
X-ME-Sender: <xms:RmxhXtmrNP75STxbQ3Ig1Cl766QveIfqk8KgDwg9FK_RqQWZftnccw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddutddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrddunecuve
    hluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:RmxhXgQZsNrvu8l7nxTZ8PZ9KLQJGmHTHDWvGQba49dcRT5Vb9szew>
    <xmx:RmxhXhBHog92VNONzG8o7CpgdMZkDfUmobyGRRsJfC17tSM5Ae4GIw>
    <xmx:RmxhXnQle7-RtLtj-yIGHudNsqn6HyH7JHkISByUXGFQw5AJlhTFXw>
    <xmx:RmxhXnKtNOxejqYkVs5cqFx0pbCcjuCm94dlj26ee0yb0Ctj7skmVw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 834B93060BD1;
        Thu,  5 Mar 2020 16:16:53 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, shakeelb@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Subject: [PATCH v2 4/4] cgroupfs: Support user xattrs
Date:   Thu,  5 Mar 2020 13:16:32 -0800
Message-Id: <20200305211632.15369-5-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305211632.15369-1-dxu@dxuuu.xyz>
References: <20200305211632.15369-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch turns on xattr support for cgroupfs. This is useful for
letting non-root owners of delegated subtrees attach metadata to
cgroups.

One use case is for subtree owners to tell a userspace out of memory
killer to bias away from killing specific subtrees.

Tests:

    [/sys/fs/cgroup]# for i in $(seq 0 130); \
        do setfattr workload.slice -n user.name$i -v wow; done
    setfattr: workload.slice: No space left on device
    setfattr: workload.slice: No space left on device
    setfattr: workload.slice: No space left on device

    [/sys/fs/cgroup]# for i in $(seq 0 130); \
        do setfattr workload.slice --remove user.name$i; done
    setfattr: workload.slice: No such attribute
    setfattr: workload.slice: No such attribute
    setfattr: workload.slice: No such attribute

    [/sys/fs/cgroup]# for i in $(seq 0 130); \
        do setfattr workload.slice -n user.name$i -v wow; done
    setfattr: workload.slice: No space left on device
    setfattr: workload.slice: No space left on device
    setfattr: workload.slice: No space left on device

`seq 0 130` is inclusive, and 131 - 128 = 3, which is the number of
errors we expect to see.

    [/data]# cat testxattr.c
    #include <sys/types.h>
    #include <sys/xattr.h>
    #include <stdio.h>
    #include <stdlib.h>

    int main() {
      char name[256];
      char *buf = malloc(64 << 10);
      if (!buf) {
        perror("malloc");
        return 1;
      }

      for (int i = 0; i < 4; ++i) {
        snprintf(name, 256, "user.bigone%d", i);
        if (setxattr("/sys/fs/cgroup/system.slice", name, buf,
                     64 << 10, 0)) {
          printf("setxattr failed on iteration=%d\n", i);
          return 1;
        }
      }

      return 0;
    }

    [/data]# ./a.out
    setxattr failed on iteration=2

    [/data]# ./a.out
    setxattr failed on iteration=0

    [/sys/fs/cgroup]# setfattr -x user.bigone0 system.slice/
    [/sys/fs/cgroup]# setfattr -x user.bigone1 system.slice/

    [/data]# ./a.out
    setxattr failed on iteration=2

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/cgroup/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 75f687301bbf..21621b43a8ab 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1954,7 +1954,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 
 	root->kf_root = kernfs_create_root(kf_sops,
 					   KERNFS_ROOT_CREATE_DEACTIVATED |
-					   KERNFS_ROOT_SUPPORT_EXPORTOP,
+					   KERNFS_ROOT_SUPPORT_EXPORTOP |
+					   KERNFS_ROOT_SUPPORT_USER_XATTR,
 					   root_cgrp);
 	if (IS_ERR(root->kf_root)) {
 		ret = PTR_ERR(root->kf_root);
-- 
2.21.1

