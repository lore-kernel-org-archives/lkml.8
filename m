Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2254DC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08EC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646602;
	bh=P0enmRMPJSTzxpuKOpRs/bk9Xg8HJ5GL0+PLb+c5CKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w5EpHbSTiLspsv3MLSdEEFcDWF9c1G3saHrAo8T+bvv5X4ZDjBM7dW4Szq8UjHi0R
	 8cRBuvENQeVl2SWYE4duIk9bf2bcHYi/1R9USkEpe3aB26rzU75oyOfHTjWdNF5JjQ
	 xcw+kCXeNF4qwia8kYrLP2BTFEVuU+sdie6pA9pE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgCaJDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbgCaJD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:03:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D75212CC;
        Tue, 31 Mar 2020 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645406;
        bh=P0enmRMPJSTzxpuKOpRs/bk9Xg8HJ5GL0+PLb+c5CKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBTDNYrR6EYQuFko1vz9uiGtCMu6z628ANYAwILrT3FikaKuYkp8qaionLstIUa7T
         LkQAAmCrZMr68teTz8We1z7Ej/EmVbA6fwWBac5PbJCEnTTgtB0FleLNePmJxrEPqZ
         JFhq1G31U2JCKCgkTYwxD9w9e8iVNz2Mfaejo9ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 044/170] bnxt_en: Return error if bnxt_alloc_ctx_mem() fails.
Date:   Tue, 31 Mar 2020 10:57:38 +0200
Message-Id: <20200331085429.152377971@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 0b5b561cea32d5bb1e0a82d65b755a3cb5212141 ]

The current code ignores the return value from
bnxt_hwrm_func_backing_store_cfg(), causing the driver to proceed in
the init path even when this vital firmware call has failed.  Fix it
by propagating the error code to the caller.

Fixes: 1b9394e5a2ad ("bnxt_en: Configure context memory on new devices.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6880,12 +6880,12 @@ skip_rdma:
 	}
 	ena |= FUNC_BACKING_STORE_CFG_REQ_DFLT_ENABLES;
 	rc = bnxt_hwrm_func_backing_store_cfg(bp, ena);
-	if (rc)
+	if (rc) {
 		netdev_err(bp->dev, "Failed configuring context mem, rc = %d.\n",
 			   rc);
-	else
-		ctx->flags |= BNXT_CTX_FLAG_INITED;
-
+		return rc;
+	}
+	ctx->flags |= BNXT_CTX_FLAG_INITED;
 	return 0;
 }
 


