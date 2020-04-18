Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC85C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE41206D6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221769;
	bh=WwMQnnlr9UFxuKnVYip2MbxhHSDl070mII4XwC96BvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZNdD8y3dAJIMMr/vp3pI5v5/YHwf1xXM9tuywBw6k8GYrUhHSRlU8PlafE2DkFYfX
	 49FoWPShJIt7SGXAA6uPKF6Zu75jj38jz6oJ2O0+HM81JueGSb2nWG2+t73y9oZGJx
	 Bb3rc8R9Csp4+yBKNBXZ+e4x962MhEYOHrLB87XU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgDROkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDROkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:40:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154F1221F4;
        Sat, 18 Apr 2020 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220850;
        bh=WwMQnnlr9UFxuKnVYip2MbxhHSDl070mII4XwC96BvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Vviwj5T4TctrLGU1yZC03N2m4txI8yJXAGxosGdCZXxazio8iYhZJ9uhN/I8tlFE
         /hTgOIuO2E4KgNPrf7hS1M0tmXgvUPyw4NtrsGZ6cZ8UqKo/Qg2ahoid5cSRxmQsN/
         bmQ5Xijw+UfIcTz/KX0YAkgK49QG3Mjs0ZbVa6zY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 5.4 02/78] tools/testing/nvdimm: Fix compilation failure without CONFIG_DEV_DAX_PMEM_COMPAT
Date:   Sat, 18 Apr 2020 10:39:31 -0400
Message-Id: <20200418144047.9013-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit c0e71d602053e4e7637e4bc7d0bc9603ea77a33f ]

When a kernel is configured without CONFIG_DEV_DAX_PMEM_COMPAT, the
compilation of tools/testing/nvdimm fails with:

  Building modules, stage 2.
  MODPOST 11 modules
ERROR: "dax_pmem_compat_test" [tools/testing/nvdimm/test/nfit_test.ko] undefined!

Fix the problem by calling dax_pmem_compat_test() only if the kernel has
the required functionality.

Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20200123154720.12097-1-jack@suse.cz
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/nvdimm/test/nfit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index bf6422a6af7ff..a8ee5c4d41ebb 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -3164,7 +3164,9 @@ static __init int nfit_test_init(void)
 	mcsafe_test();
 	dax_pmem_test();
 	dax_pmem_core_test();
+#ifdef CONFIG_DEV_DAX_PMEM_COMPAT
 	dax_pmem_compat_test();
+#endif
 
 	nfit_test_setup(nfit_test_lookup, nfit_test_evaluate_dsm);
 
-- 
2.20.1

