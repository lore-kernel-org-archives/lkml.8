Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7375CC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A152076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255529;
	bh=R7xIYQrlJiXMsfv9y/AFv2LM+jP7ACZzBBhPtjMf1lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9sdAceaPXLwtL8tecXc4VL0D/6Et1Pv6ePy2wmGCHuriQ4+3qeddwBV3OPRpWMst
	 muOwbYIZnMPefw6TRL5IXgTMyHVf8HzufsHNYACNgL3pQnEmGw8hyHczpu4H+BL4zC
	 b/y1WLWvrpiJ9o53AKUnGvALhyyLQ46SK/7MEfZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgD3OF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgD3NxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:53:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0B7B208DB;
        Thu, 30 Apr 2020 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254780;
        bh=R7xIYQrlJiXMsfv9y/AFv2LM+jP7ACZzBBhPtjMf1lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KT6EplGNYJW4ddxLTBhjJ25TOkHlHmLEk3GbjVduMzzjih8ns6CtFFZGgAHa3Yryi
         eaPoBnnVQQ2PbSFEvJN3CCGeIrHq1yJ2YOCROS8bld1fSzINWTNDb76AdoiXrEVnYC
         e71lkpuxf4DES43UUSxZO3tzWqai8rKhMum7Mn78=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Xiumei Mu <xmu@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 37/57] cpumap: Avoid warning when CONFIG_DEBUG_PER_CPU_MAPS is enabled
Date:   Thu, 30 Apr 2020 09:51:58 -0400
Message-Id: <20200430135218.20372-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit bc23d0e3f717ced21fbfacab3ab887d55e5ba367 ]

When the kernel is built with CONFIG_DEBUG_PER_CPU_MAPS, the cpumap code
can trigger a spurious warning if CONFIG_CPUMASK_OFFSTACK is also set. This
happens because in this configuration, NR_CPUS can be larger than
nr_cpumask_bits, so the initial check in cpu_map_alloc() is not sufficient
to guard against hitting the warning in cpumask_check().

Fix this by explicitly checking the supplied key against the
nr_cpumask_bits variable before calling cpu_possible().

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Xiumei Mu <xmu@redhat.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20200416083120.453718-1-toke@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index ef49e17ae47cb..a367fc8503933 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -486,7 +486,7 @@ static int cpu_map_update_elem(struct bpf_map *map, void *key, void *value,
 		return -EOVERFLOW;
 
 	/* Make sure CPU is a valid possible cpu */
-	if (!cpu_possible(key_cpu))
+	if (key_cpu >= nr_cpumask_bits || !cpu_possible(key_cpu))
 		return -ENODEV;
 
 	if (qsize == 0) {
-- 
2.20.1

