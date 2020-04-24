Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F328C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5722320706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731011;
	bh=JEfPVeCIXS2ihp4wiKoaxqcfVeN9Aopia2uXZyuMbzs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G1nXpF7cmxWaSETgwhb4PSmwbLFLOUgHXqqkq3YGfALlgJqaOIg+e+QndFY4XzQfk
	 /sgFw7ATAGR9x/l10v04hfQ6XgfJ+qDXq+ScC66BwqizFvu/nskEZ0VWgRvr5uV5O8
	 at0BkRUxkQHgxhtfJnnw+dT9gvVNwLm7plpVpzAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgDXMXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgDXMX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:23:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E508A20776;
        Fri, 24 Apr 2020 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731005;
        bh=JEfPVeCIXS2ihp4wiKoaxqcfVeN9Aopia2uXZyuMbzs=;
        h=From:To:Cc:Subject:Date:From;
        b=1qHOqCMSq1ywoYVvbwMuKBB/Bc/buIYS9oC344cyI8+ZzwH8qFxgEeHq13GZijqw2
         VD2zfZjIChMjsMghVFiRAfh3B3LTPy1sxKSkRD5vlt++uOiHNN8hN2jywa47CkKCA5
         TMnzJLAtN6Zu8JBtyXNqNr/YMeQKYk3ynfO4KIfo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeremy Cline <jcline@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/26] libbpf: Initialize *nl_pid so gcc 10 is happy
Date:   Fri, 24 Apr 2020 08:22:58 -0400
Message-Id: <20200424122323.10194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jcline@redhat.com>

[ Upstream commit 4734b0fefbbf98f8c119eb8344efa19dac82cd2c ]

Builds of Fedora's kernel-tools package started to fail with "may be
used uninitialized" warnings for nl_pid in bpf_set_link_xdp_fd() and
bpf_get_link_xdp_info() on the s390 architecture.

Although libbpf_netlink_open() always returns a negative number when it
does not set *nl_pid, the compiler does not determine this and thus
believes the variable might be used uninitialized. Assuage gcc's fears
by explicitly initializing nl_pid.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1807781

Signed-off-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200404051430.698058-1-jcline@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index ce3ec81b71c01..88416be2bf994 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -137,7 +137,7 @@ int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags)
 		struct ifinfomsg ifinfo;
 		char             attrbuf[64];
 	} req;
-	__u32 nl_pid;
+	__u32 nl_pid = 0;
 
 	sock = libbpf_netlink_open(&nl_pid);
 	if (sock < 0)
@@ -254,7 +254,7 @@ int bpf_get_link_xdp_id(int ifindex, __u32 *prog_id, __u32 flags)
 {
 	struct xdp_id_md xdp_id = {};
 	int sock, ret;
-	__u32 nl_pid;
+	__u32 nl_pid = 0;
 	__u32 mask;
 
 	if (flags & ~XDP_FLAGS_MASK)
-- 
2.20.1

