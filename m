Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3EDC55194
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FBA20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731116;
	bh=ySL282Fl7aUcXPkzqQzibkmlNVMn1FzT4+uJENDy+Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N0LtF5dUX+lhrJlcLimIPSQZ+QtZTrvtc1j8F4iVzyXgxk8HXlduf9eYoSVbIQzkv
	 waFYKhMvTIXkmmyqvhvLF4EUFZPwKMjOK8jnmlY3sYrh6i6mb+dDwCchyGdFI+RO/J
	 w3CBilGeTynEfFL+hHKsmMDG5XW3fmKs8uVRWI9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgDXMZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbgDXMZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:25:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0064821BE5;
        Fri, 24 Apr 2020 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731108;
        bh=ySL282Fl7aUcXPkzqQzibkmlNVMn1FzT4+uJENDy+Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3Q+EHUZxIH32dqdILcjtVHovwmQ54ikSWcLhwHouhOnee3NK3coDcyHo/1HiKD5N
         JSzapU9bBWLg1mrsDjTJMhi3+JGHhPfrVyyClNzfps/mWlKWZzm1Wy3poslfjuKps3
         i10GniK8cUBpzqbfphDt/DOQNyRx2zlZhLaA/Puw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Bin <huawei.libin@huawei.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 4/8] scsi: sg: add sg_remove_request in sg_common_write
Date:   Fri, 24 Apr 2020 08:24:59 -0400
Message-Id: <20200424122503.11046-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122503.11046-1-sashal@kernel.org>
References: <20200424122503.11046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Bin <huawei.libin@huawei.com>

[ Upstream commit 849f8583e955dbe3a1806e03ecacd5e71cce0a08 ]

If the dxfer_len is greater than 256M then the request is invalid and we
need to call sg_remove_request in sg_common_write.

Link: https://lore.kernel.org/r/1586777361-17339-1-git-send-email-huawei.libin@huawei.com
Fixes: f930c7043663 ("scsi: sg: only check for dxfer_len greater than 256M")
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Li Bin <huawei.libin@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index e1639e80db536..63e21ca538f19 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -820,8 +820,10 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 			"sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
 
-	if (hp->dxfer_len >= SZ_256M)
+	if (hp->dxfer_len >= SZ_256M) {
+		sg_remove_request(sfp, srp);
 		return -EINVAL;
+	}
 
 	k = sg_start_req(srp, cmnd);
 	if (k) {
-- 
2.20.1

