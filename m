Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D79BC43459
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A23208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737843;
	bh=07Y0K6B/jas/WfqhlgWNpkqqZf+TC6BP68ukDb77Of0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=doJkZKZ4+fi+kB+50dv0pl3AF4VfgNnOVKWxCNnQJxFIEmhaTLxB6qG11Vtsae7eb
	 poEi3QhZi28S0UfE/I3EcF/sc59UcEkcEFBQbXahCtgyMwJasweR+R7B/qyz0Z2naw
	 RZPOjTiuMN0Swh+teKBIPszw4bWfglYB7ErtZHK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgGNOoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbgGNOjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:39:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2CC72253A;
        Tue, 14 Jul 2020 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737564;
        bh=07Y0K6B/jas/WfqhlgWNpkqqZf+TC6BP68ukDb77Of0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTcnCQ/Y6FUsggKh0wKoRrx7/3EIpKyff1dcX7Zlgh4xUVfU21Ixaa2YJJtDcdI+r
         rdbz63TxD7bmQRX5MjWzhMw0sYIythr7FJp0hBrK/6vPmKjmNN6X7lkcDvl29SkKoF
         /6PdeoK3oL/tc1LIK5h6bzXDD11076kJHCEeSMRg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 5.4 08/18] xtensa: update *pos in cpuinfo_op.next
Date:   Tue, 14 Jul 2020 10:39:04 -0400
Message-Id: <20200714143914.4035489-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714143914.4035489-1-sashal@kernel.org>
References: <20200714143914.4035489-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 0d5ab144429e8bd80889b856a44d56ab4a5cd59b ]

Increment *pos in the cpuinfo_op.next to fix the following warning
triggered by cat /proc/cpuinfo:

  seq_file: buggy .next function c_next did not update position index

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index e0e1e1892b86b..d08172138369b 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -716,7 +716,8 @@ c_start(struct seq_file *f, loff_t *pos)
 static void *
 c_next(struct seq_file *f, void *v, loff_t *pos)
 {
-	return NULL;
+	++*pos;
+	return c_start(f, pos);
 }
 
 static void
-- 
2.25.1

