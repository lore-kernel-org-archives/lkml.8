Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E86C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543EF2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458567;
	bh=C8PD6oRY0Isp66vleS6E1szTsB0xCyrvx6x4AqQUzOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kKHD5/vJVVEXVLVn1ijtbafgSoiYFJTr55MRpbO5pPihsvSfmQlrL8PRK/O22FdSO
	 ufrBJOnPaoYY5xA1Km+sQeoFJ94+mxaQWmYtap4aIrA9B5u3WiZG1M30YYLimlg15J
	 W/KVQgB+KGZODKrxIpKIpwo5//AHiRlN8pQypulQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgHCMmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbgHCMbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:31:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FEB2076B;
        Mon,  3 Aug 2020 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457860;
        bh=C8PD6oRY0Isp66vleS6E1szTsB0xCyrvx6x4AqQUzOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTyP+dJvcLHvfHis2NYLcKnxMtXjOdgZFm9AKlmgF1QShiAsVHYf7cWzwR8mrwZ/u
         1mAxP6EnYPL5D+PO7XlnSWOd+bjzBRgjai6wD2dSqreicYzamzk7lEpiNH3ej26s4E
         NMtDSGYUIyfPVq0HALJ5J0oWPjPKt4ccHt99/ASw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 01/56] crypto: ccp - Release all allocated memory if sha type is invalid
Date:   Mon,  3 Aug 2020 14:19:16 +0200
Message-Id: <20200803121850.381405558@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121850.306734207@linuxfoundation.org>
References: <20200803121850.306734207@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 128c66429247add5128c03dc1e144ca56f05a4e2 ]

Release all allocated memory if sha type is invalid:
In ccp_run_sha_cmd, if the type of sha is invalid, the allocated
hmac_buf should be released.

v2: fix the goto.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Acked-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/ccp-ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index 330853a2702f0..43b74cf0787e1 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -1783,8 +1783,9 @@ ccp_run_sha_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 			       LSB_ITEM_SIZE);
 			break;
 		default:
+			kfree(hmac_buf);
 			ret = -EINVAL;
-			goto e_ctx;
+			goto e_data;
 		}
 
 		memset(&hmac_cmd, 0, sizeof(hmac_cmd));
-- 
2.25.1



