Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57977C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219952072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217602;
	bh=SZxaZFJ7NM5F+JBcsLK0Ldt06QMXpR+LSdlaT2v1Gc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kS9IUEtHwaUgHH9jCUp9bAWSyrPX3g2+bAq5Lx8r7TZhXS/n2rmcSyCSMkQ8+7ioC
	 TAwXWqt5KboFqnqNDLv58esZuz/dGX/7dviQgq9CHBTT+6zdKYcj5+goKZIg0gGocE
	 Qsxbxu2K0vABhZMPx5Hu7IYZ0xraa8IEKwT5u5gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404331AbgAPXdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:33:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404315AbgAPXdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:33:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A5612072B;
        Thu, 16 Jan 2020 23:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217595;
        bh=SZxaZFJ7NM5F+JBcsLK0Ldt06QMXpR+LSdlaT2v1Gc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOqCPj0kNfigZlwHK6fim62Awmc+dQ0e6JJ49/a/vr3F/zpBdFGZdqCL3n+YDXBxV
         y8c/OIbKhu0UZx4n8itWxpwKQFwvi9V216BUwgTcEWpLwkdGEXj798tBIYEMNgemE3
         QyrsHsOe1gOS5GgeOQ05UDe7G58bxgFFIDSaWtyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 63/71] scsi: libcxgbi: fix NULL pointer dereference in cxgbi_device_destroy()
Date:   Fri, 17 Jan 2020 00:19:01 +0100
Message-Id: <20200116231718.159085218@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 71482fde704efdd8c3abe0faf34d922c61e8d76b ]

If cxgb4i_ddp_init() fails then cdev->cdev2ppm will be NULL, so add a check
for NULL pointer before dereferencing it.

Link: https://lore.kernel.org/r/1576676731-3068-1-git-send-email-varun@chelsio.com
Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/cxgbi/libcxgbi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index 902f5e03ec94..0d45658f163a 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -121,7 +121,8 @@ static inline void cxgbi_device_destroy(struct cxgbi_device *cdev)
 		"cdev 0x%p, p# %u.\n", cdev, cdev->nports);
 	cxgbi_hbas_remove(cdev);
 	cxgbi_device_portmap_cleanup(cdev);
-	cxgbi_ppm_release(cdev->cdev2ppm(cdev));
+	if (cdev->cdev2ppm)
+		cxgbi_ppm_release(cdev->cdev2ppm(cdev));
 	if (cdev->pmap.max_connect)
 		cxgbi_free_big_mem(cdev->pmap.port_csk);
 	kfree(cdev);
-- 
2.20.1



