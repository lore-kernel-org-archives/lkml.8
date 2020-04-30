Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D453C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D201206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255785;
	bh=zO7R679Gr2AtMhtzxEms+JbhQBtZBn/rOHFwp6nT9xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OOXDuBUdi3d/dfBEafol6kHLOIOSS0FK6IuWIpBkBHmkh6BJsAuGBAszswqlyTWE0
	 T4+z7K5+xQFdg7b+LZU69Uh607CYwDQa46QMFPmtuzeOKH8RlsOi4cMR+ufPq7sDwb
	 V2Eamj+afEAxTzUZJ9pYB/1UcKvXtlnrC8KGIFmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgD3OJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgD3Nvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:51:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0266208DB;
        Thu, 30 Apr 2020 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254706;
        bh=zO7R679Gr2AtMhtzxEms+JbhQBtZBn/rOHFwp6nT9xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahcXR5SN75w+Uu5qJlIPaUVEtgP83DiXg+5sw04SnNcstAbhyAWBclP7YqnJhrEgT
         TKFxO4pFN1yl6LBxnX7EflD6L/bskFn7Xi1qkeggOYJYz2Oqc0uMVpYu66JjsYVUmK
         oQvy7oeuA86KmO0NI1NxjtjZscumKfM2G0MwT648=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Rorvick <chris@rorvick.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 55/79] iwlwifi: actually check allocated conf_tlv pointer
Date:   Thu, 30 Apr 2020 09:50:19 -0400
Message-Id: <20200430135043.19851-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Rorvick <chris@rorvick.com>

[ Upstream commit a176e114ace4cca7df0e34b4bd90c301cdc6d653 ]

Commit 71bc0334a637 ("iwlwifi: check allocated pointer when allocating
conf_tlvs") attempted to fix a typoe introduced by commit 17b809c9b22e
("iwlwifi: dbg: move debug data to a struct") but does not implement the
check correctly.

Fixes: 71bc0334a637 ("iwlwifi: check allocated pointer when allocating conf_tlvs")
Tweeted-by: @grsecurity
Signed-off-by: Chris Rorvick <chris@rorvick.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200417074558.12316-1-sedat.dilek@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 0481796f75bc4..c24350222133d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1467,7 +1467,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 				kmemdup(pieces->dbg_conf_tlv[i],
 					pieces->dbg_conf_tlv_len[i],
 					GFP_KERNEL);
-			if (!pieces->dbg_conf_tlv[i])
+			if (!drv->fw.dbg.conf_tlv[i])
 				goto out_free_fw;
 		}
 	}
-- 
2.20.1

