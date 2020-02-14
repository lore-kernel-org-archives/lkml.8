Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E95AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0B206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700516;
	bh=S3Nc5wzGIiH5GB3g7PUxAN4EYIumqeMsxMMOXpWjoMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ANCztDHMnzTqkSVISaTOvh9ZbhjpZs8SmA86F9uZ1f4Dg0CWOsLyDjwrCfyjgv8hf
	 i3U+y80N0o7K2CfLiMynBE7ATk693SQopZ0laHRwrjHLHUCGOw17rI1PjoAdSoeYS3
	 4u5pACmfPjSElSvm4vGBaFRRZuzQvMhHxs1X+kVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391964AbgBNQMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:12:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391723AbgBNQLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929A02467C;
        Fri, 14 Feb 2020 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696670;
        bh=S3Nc5wzGIiH5GB3g7PUxAN4EYIumqeMsxMMOXpWjoMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAwrrMpqrc6jP5YHUKfR3Css2C72YM/yU64w7p0TWZwo4bM6sZ+Kg2azuohrOvGwG
         bbNpNFShjYxaCsPDmpTOyYi3Vi0bfxCmgDp+tvPLLojIt/KEPykYEuzGP5CkAWntd0
         WknEX3XRV9vby7DENQdm7ik1gj4JjiNZ1M/X3FJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Amol Grover <frextrite@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 440/459] nvmet: Pass lockdep expression to RCU lists
Date:   Fri, 14 Feb 2020 11:01:30 -0500
Message-Id: <20200214160149.11681-440-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>

[ Upstream commit 4ac76436a6d07dec1c3c766f234aa787a16e8f65 ]

ctrl->subsys->namespaces and subsys->namespaces are traversed with
list_for_each_entry_rcu outside an RCU read-side critical section but
under the protection of ctrl->subsys->lock and subsys->lock respectively.

Hence, add the corresponding lockdep expression to the list traversal
primitive to silence false-positive lockdep warnings, and harden RCU
lists.

Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3a67e244e5685..57a4062cbb59e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -555,7 +555,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	} else {
 		struct nvmet_ns *old;
 
-		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
+		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
+					lockdep_is_held(&subsys->lock)) {
 			BUG_ON(ns->nsid == old->nsid);
 			if (ns->nsid < old->nsid)
 				break;
@@ -1174,7 +1175,8 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
 
 	ctrl->p2p_client = get_device(req->p2p_client);
 
-	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link)
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link,
+				lockdep_is_held(&ctrl->subsys->lock))
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
 }
 
-- 
2.20.1

