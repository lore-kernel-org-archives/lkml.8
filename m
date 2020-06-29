Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86598C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628AE20702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459436;
	bh=ZZSgkydV06Ik95Z0cVMy9NkC0+TqZBUWfjbdZ9lmL6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=akMMYc8+S9GmJhImQfJiTFhEKxxCniXEktTLRM4shV3Feduj4xsVQw4fpPS3bM91i
	 gxzsKxNUT8J01g5lZNTjgZfI0HQS743ua2D9j/8WuiDbPGZiW+fdjSQ8pXsEYCcsYF
	 Bj0nz7k+lIrN5vktaf4YZQIhC+Yb6F+wkJqNc7x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbgF2ThP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732814AbgF2Tae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5B525259;
        Mon, 29 Jun 2020 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444968;
        bh=ZZSgkydV06Ik95Z0cVMy9NkC0+TqZBUWfjbdZ9lmL6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLznFrPnPEUGZ3c8PIzrbGSId2WeCAs9s6/QaLWLIy/qNqaBwWQGGoQkM/awqYuhz
         E322teYcl+W4yM/VfYwsH1/X3nL0krgPKP9i45rIPtdp6weuHRE+AvVnEMQ+dt20L5
         VL0EzwFK/ol6kzcjUbIIaDE3LPAfo4voKWSaQc6o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 067/131] x86/resctrl: Fix a NULL vs IS_ERR() static checker warning in rdt_cdp_peer_get()
Date:   Mon, 29 Jun 2020 11:33:58 -0400
Message-Id: <20200629153502.2494656-68-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit cc5277fe66cf3ad68f41f1c539b2ef0d5e432974 ]

The callers don't expect *d_cdp to be set to an error pointer, they only
check for NULL.  This leads to a static checker warning:

  arch/x86/kernel/cpu/resctrl/rdtgroup.c:2648 __init_one_rdt_domain()
  warn: 'd_cdp' could be an error pointer

This would not trigger a bug in this specific case because
__init_one_rdt_domain() calls it with a valid domain that would not have
a negative id and thus not trigger the return of the ERR_PTR(). If this
was a negative domain id then the call to rdt_find_domain() in
domain_add_cpu() would have returned the ERR_PTR() much earlier and the
creation of the domain with an invalid id would have been prevented.

Even though a bug is not triggered currently the right and safe thing to
do is to set the pointer to NULL because that is what can be checked for
when the caller is handling the CDP and non-CDP cases.

Fixes: 52eb74339a62 ("x86/resctrl: Fix rdt_find_domain() return value and checks")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lkml.kernel.org/r/20200602193611.GA190851@mwanda
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index cea7e01a346d3..e62e416dd1162 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1035,6 +1035,7 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
 	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
 		_r_cdp = NULL;
+		_d_cdp = NULL;
 		ret = -EINVAL;
 	}
 
-- 
2.25.1

