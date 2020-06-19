Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3F3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D5C20706
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581821;
	bh=tHgLy2WBJHYxlwWYiAqfHC5kG4VoDvhBZLkmec1G7tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZhcQOHXxib6HFo0yGkDYysAIXw6GzzgDK4H1YMBq6jGClFECCFDmTDjG50nb8d2BQ
	 8DAgcBpm+Z6ydjjXQ3+ak7mF7KgLjYl8fzgVCCBN/RAZDL+CNOlUK5QHEolq+TDbur
	 Cex10KF5bgZEEGmtr14YDpTFX5L2uSl0iuwqllYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392867AbgFSPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392881AbgFSPVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:21:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAD020706;
        Fri, 19 Jun 2020 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580101;
        bh=tHgLy2WBJHYxlwWYiAqfHC5kG4VoDvhBZLkmec1G7tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gucWA3cDeT1GVmvR18pIyh+C+pLId3YurzIGn4RFoft+B3qcl1+GC0NPdpfKqbvFK
         0cXjm9izDgYY2uOJdnb+PNt+btSCrMaXXrpGCBUE85j7tLGO9KHn8dp1JSHOCewFe0
         Lh2xioBm2SxTVwu5LNTF7eJ2CQLs0k7tktQ1KmIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 123/376] selftests/bpf: Fix memory leak in extract_build_id()
Date:   Fri, 19 Jun 2020 16:30:41 +0200
Message-Id: <20200619141716.159347958@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit 9f56bb531a809ecaa7f0ddca61d2cf3adc1cb81a ]

getline() allocates string, which has to be freed.

Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20200429012111.277390-7-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 86d0020c9eec..93970ec1c9e9 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -351,6 +351,7 @@ int extract_build_id(char *build_id, size_t size)
 		len = size;
 	memcpy(build_id, line, len);
 	build_id[len] = '\0';
+	free(line);
 	return 0;
 err:
 	fclose(fp);
-- 
2.25.1



