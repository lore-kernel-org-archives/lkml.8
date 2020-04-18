Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AC2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1547D21D79
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587218955;
	bh=WwMQnnlr9UFxuKnVYip2MbxhHSDl070mII4XwC96BvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AIWxDrFRx3REpd2R+Uyf7iJ19ISaLCiUNFNlI3CKTzUmW7pLXaOYOSj77DJZj+8D0
	 6SLAfqu+3KCVWMCVfg/SIZqKvNVsnsoeYnZJGAPZiRfAUwcxiW0rPqf15bMjb0fqyA
	 WwnoQ5expio//Kqs6aY2EcERkseYKofza1UF0cCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDROJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgDROJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFB221D79;
        Sat, 18 Apr 2020 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218953;
        bh=WwMQnnlr9UFxuKnVYip2MbxhHSDl070mII4XwC96BvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KioimVxkDf9q8ezG/fMIl9EZgYImY2MHrO9U0zmzMWAtQbavpupFUKU7fxpvqwR9l
         GGooRMvvUlAMAfHL8V2Db418c2IE8lGGHoLGQak+eZttYcR84iyNGmSFw9p5kBFPzr
         5GVbRGvy7T+A7oKsBmgfarIbRNfXPm+4WXROsHkE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 5.5 02/75] tools/testing/nvdimm: Fix compilation failure without CONFIG_DEV_DAX_PMEM_COMPAT
Date:   Sat, 18 Apr 2020 10:07:57 -0400
Message-Id: <20200418140910.8280-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
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

