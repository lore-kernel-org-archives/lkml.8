Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1852C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65AF2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261775;
	bh=yJdQ9x0NnxcJSbyMWotm4xSTdoYpqFfOHOchrswNJ7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YuymfuMC4G1CLInXcQlBfNk6rnLjgqzc4r+/1t0OkiCK1ym+JC1nYQblaSuoohbiK
	 F6Fqxbms58MguCw9h99epqUHYEqLtTsA48edtUmy25Bs0Xotm21iVYaJ2ZNVD/cILO
	 ZusinXpfTEgux4U2NHndquPtc/uxa2qYrOegTRVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbgGTQQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388508AbgGTQQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:16:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D671E2176B;
        Mon, 20 Jul 2020 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261769;
        bh=yJdQ9x0NnxcJSbyMWotm4xSTdoYpqFfOHOchrswNJ7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdt+9FEhxqo9L6o73JIVjMKXd4/MB9fedHuOF8xzKqd5hlJLcGARcuA8ofkZgHIBU
         BJRZpWcSXCRgJuQPTL7IBseC/3OiXtu+AMAbIkzCDfuvqv83xe2WSmHUVMA0Hql0qm
         s25mpTfxe94WsUozxZhRPwc3Nkol3tbedSujEyIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Gong <yibin.gong@nxp.com>,
        Angelo Dureghello <angelo@sysam.it>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.7 208/244] dmaengine: fsl-edma-common: correct DSIZE_32BYTE
Date:   Mon, 20 Jul 2020 17:37:59 +0200
Message-Id: <20200720152835.743666337@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

commit e142087b15960a4e1e5932942e5abae1f49d2318 upstream.

Correct EDMA_TCD_ATTR_DSIZE_32BYTE define since it's broken by the below:
'0x0005 --> BIT(3) | BIT(0))'

Fixes: 4d6d3a90e4ac ("dmaengine: fsl-edma: fix macros")
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Tested-by: Angelo Dureghello <angelo@sysam.it>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1593449998-32091-1-git-send-email-yibin.gong@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/fsl-edma-common.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -33,7 +33,7 @@
 #define EDMA_TCD_ATTR_DSIZE_16BIT	BIT(0)
 #define EDMA_TCD_ATTR_DSIZE_32BIT	BIT(1)
 #define EDMA_TCD_ATTR_DSIZE_64BIT	(BIT(0) | BIT(1))
-#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(3) | BIT(0))
+#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(2) | BIT(0))
 #define EDMA_TCD_ATTR_SSIZE_8BIT	0
 #define EDMA_TCD_ATTR_SSIZE_16BIT	(EDMA_TCD_ATTR_DSIZE_16BIT << 8)
 #define EDMA_TCD_ATTR_SSIZE_32BIT	(EDMA_TCD_ATTR_DSIZE_32BIT << 8)


