Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A2AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DDFD20838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859253;
	bh=Yl21JdGd0aDIm44jfQ3dqKB33jyFSYMfu+vyS93JraU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P9IADJeurT6AXn2KLf/M6SEsMeFqI3tOab3qB7bLQoR/eAC+lyyDNb9OF1M907Ij8
	 Z+6BEPbCk0Cskm5GcoJffSwu7/x76b02ul0nA5I5HUp7fbhEbHacZZGIffZKUEuFvf
	 00qqOKvMPwh9d7zthORSLzYU1jTe3sebLv9xvePw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgG0OOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730475AbgG0OOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:14:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D50521775;
        Mon, 27 Jul 2020 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859245;
        bh=Yl21JdGd0aDIm44jfQ3dqKB33jyFSYMfu+vyS93JraU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppIWVKdtYW6iF/jXNpXM9EzvXFDLfFT/kCASRWWIfaBciV0x0PRBWsxXaLBEH7yS5
         UOLvQaNAYz1qwuih3tl7ky8CFaMiFQKNTExETFafawuWjyW6EmYHSiLQLQCxv5tEYV
         k43xc2Xgzbid3AG2wAZx9u4aNPSv9Ni65FdKNJGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Tom Rix <trix@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 006/138] scsi: scsi_transport_spi: Fix function pointer check
Date:   Mon, 27 Jul 2020 16:03:21 +0200
Message-Id: <20200727134925.560479721@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

[ Upstream commit 5aee52c44d9170591df65fafa1cd408acc1225ce ]

clang static analysis flags several null function pointer problems.

drivers/scsi/scsi_transport_spi.c:374:1: warning: Called function pointer is null (null dereference) [core.CallAndMessage]
spi_transport_max_attr(offset, "%d\n");
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reviewing the store_spi_store_max macro

	if (i->f->set_##field)
		return -EINVAL;

should be

	if (!i->f->set_##field)
		return -EINVAL;

Link: https://lore.kernel.org/r/20200627133242.21618-1-trix@redhat.com
Reviewed-by: James Bottomley <jejb@linux.ibm.com>
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_transport_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index f8661062ef954..f3d5b1bbd5aa7 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -339,7 +339,7 @@ store_spi_transport_##field(struct device *dev, 			\
 	struct spi_transport_attrs *tp					\
 		= (struct spi_transport_attrs *)&starget->starget_data;	\
 									\
-	if (i->f->set_##field)						\
+	if (!i->f->set_##field)						\
 		return -EINVAL;						\
 	val = simple_strtoul(buf, NULL, 0);				\
 	if (val > tp->max_##field)					\
-- 
2.25.1



