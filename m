Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAE8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413422073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199859;
	bh=PAz7ZqudbFdxvDWTEGwpjpQR1rAd4t4vy1yzy9d5A40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lO6SW/VxSTqB1VgVOk7CJiDFc0pQl1SySm9UBGQBGpqJpu1IworTGFZNl4PSpcKl0
	 0lfSXdpzZkB5RysW+6uZQqS/papUTVmw+49pafYnjWH56hmx4OwdOLrkntxyNhY2Ce
	 b8E7ov0qjK35VCz6fPja2k206CUZNvKzPMDL0uGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405079AbgAPShi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390566AbgAPRMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:12:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72BB20684;
        Thu, 16 Jan 2020 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194767;
        bh=PAz7ZqudbFdxvDWTEGwpjpQR1rAd4t4vy1yzy9d5A40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUo1qm1s0PREpKIxvHFoN7rzAMcJxTujMkfBJqmhfhdGmCmdmvaVv6s4WyYM9FOO6
         11s5uGh8MyjyjBA/NHlpNNY9vuHxc+kpTBwSm60zxYbM+LzqnPb6LKxrlsQdgBklrU
         Aeh5PnpKPYVv9QwWqzy9cTBcxpo6kqOhoXMNUK3M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 587/671] s390/qeth: Fix initialization of vnicc cmd masks during set online
Date:   Thu, 16 Jan 2020 12:03:45 -0500
Message-Id: <20200116170509.12787-324-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit be40a86c319706f90caca144343c64743c32b953 ]

Without this patch, a command bit in the supported commands mask is only
ever set to unsupported during set online. If a command is ever marked as
unsupported (e.g. because of error during qeth_l2_vnicc_query_cmds),
subsequent successful initialization (offline/online) would not bring it
back.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index cf3b15ebcf75..f86465da2422 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2359,11 +2359,15 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 			sup_cmds = 0;
 			error = true;
 		}
-		if (!(sup_cmds & IPA_VNICC_SET_TIMEOUT) ||
-		    !(sup_cmds & IPA_VNICC_GET_TIMEOUT))
+		if ((sup_cmds & IPA_VNICC_SET_TIMEOUT) &&
+		    (sup_cmds & IPA_VNICC_GET_TIMEOUT))
+			card->options.vnicc.getset_timeout_sup |= vnicc;
+		else
 			card->options.vnicc.getset_timeout_sup &= ~vnicc;
-		if (!(sup_cmds & IPA_VNICC_ENABLE) ||
-		    !(sup_cmds & IPA_VNICC_DISABLE))
+		if ((sup_cmds & IPA_VNICC_ENABLE) &&
+		    (sup_cmds & IPA_VNICC_DISABLE))
+			card->options.vnicc.set_char_sup |= vnicc;
+		else
 			card->options.vnicc.set_char_sup &= ~vnicc;
 	}
 	/* enforce assumed default values and recover settings, if changed  */
-- 
2.20.1

