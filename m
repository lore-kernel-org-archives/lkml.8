Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A45C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F2D20409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846056;
	bh=RMTGr3uER+/FS+YWZ/Knhm57es+YuOsOFMRZAznwVdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ugU+vQSU25YtlrxzmF84YICe1RZIOzbXl60yeDnFUf7JNoqXRCWC+xlVhv/IZoDk8
	 lgC3Iy6ypkLeG45cmzMQ0M+XHhnMCsrqQsTdm/d4P468g/Bv3CHFFQMN3xpUMTfYSE
	 LYNpbfocKjL8I4tfpsBOojcHPWUzwk6c6Kaa9C3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbgCJNOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbgCJNOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:14:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63DB24649;
        Tue, 10 Mar 2020 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583846052;
        bh=RMTGr3uER+/FS+YWZ/Knhm57es+YuOsOFMRZAznwVdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OA0kPCEmySJgPCti9tvOON7uCSoPZeWIJBrXc92M4JOzvMDnomcC88Wv5WtpHUJA
         yOis0wVa0uUucdLx78QUHDohNzcWww33/P2thNvRd+6NuA72ikxeYkyZRp286wkUB8
         BvCIKt0GkfYs40PIzD5GuF/UiU9HTwAsYK8e09dM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 28/86] nvme: Fix uninitialized-variable warning
Date:   Tue, 10 Mar 2020 13:44:52 +0100
Message-Id: <20200310124532.301680598@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 15755854d53b4bbb0bb37a0fce66f0156cfc8a17 ]

gcc may detect a false positive on nvme using an unintialized variable
if setting features fails. Since this is not a fast path, explicitly
initialize this variable to suppress the warning.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f41fd15b7b7c2..a8132e8d72bb4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1058,8 +1058,8 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 		      void *buffer, size_t buflen, u32 *result)
 {
+	union nvme_result res = { 0 };
 	struct nvme_command c;
-	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
-- 
2.20.1



