Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75A5C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84CC20842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341828;
	bh=Afi39Ezz4cCJYHNt/Z/SU5kCcz10+KEkk/WfmbdU3rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1rBQHU1QoED4Tq+s0Btgud5mxDOzw63fYGYOpGHvRBkcYFIkVn1ox15h4hRQCZJR2
	 WLAp+ka6B6zSKwAjIoU0WAPGTa/H55fQexh4yGhEjC0m0MIXfzMsKtO08onAdn7dWU
	 vfzyZylajn08hJnEeDNJBSHFzofoH/0+Osat/jlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgBJMfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgBJMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:02 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867A421739;
        Mon, 10 Feb 2020 12:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338100;
        bh=Afi39Ezz4cCJYHNt/Z/SU5kCcz10+KEkk/WfmbdU3rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0kwCx+rGzg4V7wMKgoWHJZErcJqjnaF8ServdzRFYAyRvKujgNTiTpJwxH5IJQSD
         KlOGHtSmZo2xNPAGzqaf180KLyEjzdzSz+OFumwu5pJTIqGPMJzkeUDTQ1ruRmqfY6
         iWYLlHkXoW5yPXTk9c7/NMWY76vTTxTy5fyasEMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 017/195] bnxt_en: Fix TC queue mapping.
Date:   Mon, 10 Feb 2020 04:31:15 -0800
Message-Id: <20200210122307.467637576@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 18e4960c18f484ac288f41b43d0e6c4c88e6ea78 ]

The driver currently only calls netdev_set_tc_queue when the number of
TCs is greater than 1.  Instead, the comparison should be greater than
or equal to 1.  Even with 1 TC, we need to set the queue mapping.

This bug can cause warnings when the number of TCs is changed back to 1.

Fixes: 7809592d3e2e ("bnxt_en: Enable MSIX early in bnxt_init_one().")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5861,7 +5861,7 @@ static void bnxt_setup_msix(struct bnxt
 	int tcs, i;
 
 	tcs = netdev_get_num_tc(dev);
-	if (tcs > 1) {
+	if (tcs) {
 		int i, off, count;
 
 		for (i = 0; i < tcs; i++) {


