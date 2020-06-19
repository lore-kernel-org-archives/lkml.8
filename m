Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD04C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F340217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580292;
	bh=7qRrtypSSmzWLdDkp9783c/owwEwmGd/9SP07NiOk2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QHf5tTkzpw9q7CuDJFKDQcKjfr8gk39/VGB6TIGywhL2qiiEvVblj3sH2tblaFwK9
	 ZJ3WGiL9ApJNUFiGYKr/X0KiOrNfg2Upaz8NXemoQnGeYPO7DTPLX8E42BRuxcGZ/n
	 G7QIpf5zXC7ilzzuId3+Dy+J0fS0N0tYRVSox8Sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393333AbgFSPYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392918AbgFSPVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:21:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D62CD20B80;
        Fri, 19 Jun 2020 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580111;
        bh=7qRrtypSSmzWLdDkp9783c/owwEwmGd/9SP07NiOk2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgnfSlDsfS3ie+KQ0oYwGbTIb2+56AI8w9tQWHFRjXNjEZg7B4RETT+5UB853CqpQ
         WYtXap2FkAU22GQc7aqAY0y4NU+XYZBb4SsM9g3cqvbuZHS/TF8kLLnt5tHl52EOuv
         pKO+4lhZU9grg0IZO4eoiYnlXzMCkp1JH1b2ABBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 127/376] selftests/bpf: Add runqslower binary to .gitignore
Date:   Fri, 19 Jun 2020 16:30:45 +0200
Message-Id: <20200619141716.348158220@linuxfoundation.org>
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

[ Upstream commit e4e8f4d047fdcf7ac7d944e266e85d8041f16cd6 ]

With recent changes, runqslower is being copied into selftests/bpf root
directory. So add it into .gitignore.

Fixes: b26d1e2b6028 ("selftests/bpf: Copy runqslower to OUTPUT directory")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Veronika Kabatova <vkabatov@redhat.com>
Link: https://lore.kernel.org/bpf/20200429012111.277390-12-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index c30079c86998..35a577ca0226 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -39,4 +39,4 @@ test_cpp
 /no_alu32
 /bpf_gcc
 /tools
-
+/runqslower
-- 
2.25.1



