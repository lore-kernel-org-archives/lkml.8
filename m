Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A33C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF52B208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JV8k0PXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGSAaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:30:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9BFC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=M0l2hBDFukSqCv8q5NT108+HdFbnxpRdX59lGGfPlZs=; b=JV8k0PXqFiv0RK+984K4I6Qdw4
        i/DE+B3BARukAELW2VNeI2+4nrfqLvfhO5W4F0En1nIa4j4qvY6J5FZVmUSYxZAlNKZi40aEu2M/u
        UlAr60zCjGORg4dc1ha+8nElk+J7FwWh5PfMN3+Gggpd8JkdeO63GYrB0Jf4pVLNhjVvsLoAYc8Zk
        g2GUtdmeMmwKkY/gInWlXB5SxuRb9nHWbP6K5ieXLyk7H86Z5L73iIkbeBQ0e5oZ5zXo6XWfQ4yrV
        LZdHkXwfH0MlcNsrx3W71eeLRav98S3JKqBHdDHDZNGB0OHfbuTue1fYOKkIVAkF/HxEjNIl4HL4L
        y5qkDTmQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxDf-0002na-Bt; Sun, 19 Jul 2020 00:30:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme-fc: nvme-fc-driver.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:30:15 -0700
Message-Id: <20200719003015.20745-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "a" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/linux/nvme-fc-driver.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/nvme-fc-driver.h
+++ linux-next-20200717/include/linux/nvme-fc-driver.h
@@ -672,7 +672,7 @@ enum {
  * Values set by the LLDD indicating completion status of the FCP operation.
  * Must be set prior to calling the done() callback.
  * @transferred_length: amount of DATA_OUT payload data received by a
- *            a WRITEDATA operation. If not a WRITEDATA operation, value must
+ *            WRITEDATA operation. If not a WRITEDATA operation, value must
  *            be set to 0. Should equal transfer_length on success.
  * @fcp_error: status of the FCP operation. Must be 0 on success; on failure
  *            must be a NVME_SC_FC_xxxx value.
