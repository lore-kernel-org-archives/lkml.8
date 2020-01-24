Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7849FC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4629A2465B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865967;
	bh=y2dLlM8guqKpltZjCUwHNqmlcjAi5k+ZqR+8aA9UrbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X8ygUHEiLzuHpvXiofD/xkaXZ/81gGsadv7SGCPAPPnyrJZdFeDhjadFJmWo2rqQB
	 A1D4C0RCGo80RhRqb8L4QItyLhHxMjJKSpe1eildmXZnUCEqQpuaaHybUodyBAzb7i
	 ruIg4qX+7+38NfsmeyDDtaJi67urrgrmAsu4j1VA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403896AbgAXLZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403866AbgAXLZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:25:54 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D8220704;
        Fri, 24 Jan 2020 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865153;
        bh=y2dLlM8guqKpltZjCUwHNqmlcjAi5k+ZqR+8aA9UrbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J362XDmZY4ClZZsmFH2WGXc+Ajfo8Qq8iQm/8XdNQWlclm0iD0asNJ7lXn94HuKXu
         rvGsobnSMlrfIm3TcUWh0358Hh2a9vTq0e2W5m7o1RuRlgfYn3I0RLyYcBARdm9ZGn
         uapehhEBFaGsFI54+CZpy+e623DgKJDmJWY3ba/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 452/639] tools: bpftool: use correct argument in cgroup errors
Date:   Fri, 24 Jan 2020 10:30:22 +0100
Message-Id: <20200124093143.634353310@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 6c6874f401e5a0caab3b6a0663169e1fb5e930bb ]

cgroup code tries to use argv[0] as the cgroup path,
but if it fails uses argv[1] to report errors.

Fixes: 5ccda64d38cc ("bpftool: implement cgroup bpf operations")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index ee7a9765c6b32..adbcd84818f74 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -164,7 +164,7 @@ static int do_show(int argc, char **argv)
 
 	cgroup_fd = open(argv[0], O_RDONLY);
 	if (cgroup_fd < 0) {
-		p_err("can't open cgroup %s", argv[1]);
+		p_err("can't open cgroup %s", argv[0]);
 		goto exit;
 	}
 
@@ -345,7 +345,7 @@ static int do_attach(int argc, char **argv)
 
 	cgroup_fd = open(argv[0], O_RDONLY);
 	if (cgroup_fd < 0) {
-		p_err("can't open cgroup %s", argv[1]);
+		p_err("can't open cgroup %s", argv[0]);
 		goto exit;
 	}
 
@@ -403,7 +403,7 @@ static int do_detach(int argc, char **argv)
 
 	cgroup_fd = open(argv[0], O_RDONLY);
 	if (cgroup_fd < 0) {
-		p_err("can't open cgroup %s", argv[1]);
+		p_err("can't open cgroup %s", argv[0]);
 		goto exit;
 	}
 
-- 
2.20.1



