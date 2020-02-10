Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE4AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6520E20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340165;
	bh=7HPMvC0G+h+cLekSpbyao7NihQ6z97UC6mY8TuWj5gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NkEBmc2U9XzpmDoT25fFJUo2uFxwOnnipS0Ie0Yi8/Er51s7fz0+e82RNLxYVxPst
	 haVob1on35jm12rWxNAvDmVpEdr7Ygy87qiN4508zT/J1lc/VTdYm3htco4vxD1wJ7
	 0vefGJpskBUHIv9VbJHYxziMy0KvxSdDcgiFu/qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgBJNJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbgBJMjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:20 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C89320661;
        Mon, 10 Feb 2020 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338360;
        bh=7HPMvC0G+h+cLekSpbyao7NihQ6z97UC6mY8TuWj5gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/R2vRIKykI04FSL7sZ9A+aCbZTP83JW7Ei3ge0wTN3NfbPPjRiD6r5gX/7Tw52wk
         WvnZ1BGfCHfBZsZhBLxRJ0aqDkT/kte6njAOFcCFjoktth0zK3sLBHhQ+BsHfOPmwu
         Bc0Xq3frwmsw/YMFqhu1D5nKhTsryOiqskjijI9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.5 020/367] bnxt_en: Refactor logic to re-enable SRIOV after firmware reset detected.
Date:   Mon, 10 Feb 2020 04:28:53 -0800
Message-Id: <20200210122425.735899905@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit c16d4ee0e397163fe7ceac281eaa952e63fadec7 ]

Put the current logic in bnxt_open() to re-enable SRIOV after detecting
firmware reset into a new function bnxt_reenable_sriov().  This call
needs to be invoked in the firmware reset path also in the next patch.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9240,6 +9240,17 @@ void bnxt_half_close_nic(struct bnxt *bp
 	bnxt_free_mem(bp, false);
 }
 
+static void bnxt_reenable_sriov(struct bnxt *bp)
+{
+	if (BNXT_PF(bp)) {
+		struct bnxt_pf_info *pf = &bp->pf;
+		int n = pf->active_vfs;
+
+		if (n)
+			bnxt_cfg_hw_sriov(bp, &n, true);
+	}
+}
+
 static int bnxt_open(struct net_device *dev)
 {
 	struct bnxt *bp = netdev_priv(dev);
@@ -9258,13 +9269,7 @@ static int bnxt_open(struct net_device *
 		bnxt_hwrm_if_change(bp, false);
 	} else {
 		if (test_and_clear_bit(BNXT_STATE_FW_RESET_DET, &bp->state)) {
-			if (BNXT_PF(bp)) {
-				struct bnxt_pf_info *pf = &bp->pf;
-				int n = pf->active_vfs;
-
-				if (n)
-					bnxt_cfg_hw_sriov(bp, &n, true);
-			}
+			bnxt_reenable_sriov(bp);
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 				bnxt_ulp_start(bp, 0);
 		}


