Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F05CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB73B20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363349;
	bh=yIahxyLVvpeHsIvh5nZrGyfivLAhdGiTimNYRD4HgwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0v9ZO1hNklAjAJ32yBRmm/73PZPkEPk5HuZPZRaYFJYJA10n3F5AQSmSFB7rx9nz7
	 qk4MM/roW8zfWHBvxU4jYJKuv46YXcuAlNzR/ACscv3TZV4waI5678gFxMXHDxUneq
	 MXT1jcHwamM6rTIeFSpnNNtvp98IcYtjIswClUzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbgEMJtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733167AbgEMJtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:49:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9580220575;
        Wed, 13 May 2020 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363343;
        bh=yIahxyLVvpeHsIvh5nZrGyfivLAhdGiTimNYRD4HgwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8U4txmnXgCxFUhAF6KuDZrJwm6j5OvxgUrmYsLQswJoGEk/4i6njFZeAUMVTJ6gC
         gPFV13ssYayPfEFs7i0oUQNPaYztz/k9OJA/gGSSPt+AaPZgW7CuL0nSnelKEHlPI5
         xYFl5El7/xv1AYAmXN4xY0UG6ZMbzcKufTTo6ujk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 34/90] bnxt_en: Return error when allocating zero size context memory.
Date:   Wed, 13 May 2020 11:44:30 +0200
Message-Id: <20200513094412.131286092@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
References: <20200513094408.810028856@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit bbf211b1ecb891c7e0cc7888834504183fc8b534 ]

bnxt_alloc_ctx_pg_tbls() should return error when the memory size of the
context memory to set up is zero.  By returning success (0), the caller
may proceed normally and may crash later when it tries to set up the
memory.

Fixes: 08fe9d181606 ("bnxt_en: Add Level 2 context memory paging support.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6649,7 +6649,7 @@ static int bnxt_alloc_ctx_pg_tbls(struct
 	int rc;
 
 	if (!mem_size)
-		return 0;
+		return -EINVAL;
 
 	ctx_pg->nr_pages = DIV_ROUND_UP(mem_size, BNXT_PAGE_SIZE);
 	if (ctx_pg->nr_pages > MAX_CTX_TOTAL_PAGES) {


