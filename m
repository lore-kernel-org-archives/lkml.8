Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93939C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB332082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747973;
	bh=SMyj2CcF88KstmoVim6uw5UJ4dXjbyHNpwCpd3EhL6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zniNkmB9J+WfJ01Jz+h5lp2ZyIXHgU29rp4M0iZKVlXn2/CAcxrJM9muPxjPgv/Li
	 sbVOT55GiRwOG6hSu0NnqLJvZZfCNyI5s5SGTuK1Ai2wS21QIQJDrf5VxZO0qRe5pv
	 ya3Kacg2ueqvghHrQ8kRCiME0x0binlbVwbhlEAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbgBCQhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:37:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730879AbgBCQhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:37:25 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068802082E;
        Mon,  3 Feb 2020 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747844;
        bh=SMyj2CcF88KstmoVim6uw5UJ4dXjbyHNpwCpd3EhL6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8ttEERQNfK3aemambYqkQ2jccMcTreuZaVmjZDXidqh8H9iSm4vy2qVAkk36K4UG
         qguq0akA4WlbDJiYHezgj24lUYu+wTch6LELuIgqFGEXnC8hkHw4JdvF3+u4OEJsNa
         n8563jFeVSpizcZ/FiC4XaAHn59lzsOwAVBJnV+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 63/90] iwlwifi: dbg: force stop the debug monitor HW
Date:   Mon,  3 Feb 2020 16:20:06 +0000
Message-Id: <20200203161925.257127968@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

[ Upstream commit 990aba28f5001f6e90fdd84e13612b560a75deda ]

The driver is required to stop the debug monitor HW recording regardless
of the debug configuration since the driver is responsible to halt the
FW DBGC.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 87421807e040b..386ca67ec7b4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2490,12 +2490,7 @@ int iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 {
 	int ret = 0;
 
-	/* if the FW crashed or not debug monitor cfg was given, there is
-	 * no point in changing the recording state
-	 */
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status) ||
-	    (!fwrt->trans->dbg.dest_tlv &&
-	     fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
+	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
 		return 0;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
-- 
2.20.1



