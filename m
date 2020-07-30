Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A1CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169602074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096936;
	bh=8/u2v9f1AS4A+vYFzNeZgTlwKWH2MAHgTKw+YPnZWRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=soQhHXB9zVeyj5dISapTInRmHvQIuZANcY2KCmXckKQeTSi63T8HErYWd0dyRvjyl
	 Bw2FDBy6S/1M6+bqHa8XjyIbM4gI9bkHKbaJ1crPK7TQiYZBj+yzxr5lyyEAU0tvHB
	 adaR/3MquB8019zHjU/+VZmZ37LDPMY+uOBItoUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgG3IPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbgG3ILu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:11:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D20E2074B;
        Thu, 30 Jul 2020 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096709;
        bh=8/u2v9f1AS4A+vYFzNeZgTlwKWH2MAHgTKw+YPnZWRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzaoed/rARdHghknLEVUYdgNg3XPGejipZs2dGUNttvWhTEhc+adw56w8LTG8otIf
         KtxzfpTIKE+WFg7WrNudzoL6IL2PNU2rt7jlys28cc13CeXZjYtVLP7rncHPgr/QBq
         bBvcOfp8EwWD3o0LEkChNV69smrHpZZ2bqcgLld0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Tom Rix <trix@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 03/54] scsi: scsi_transport_spi: Fix function pointer check
Date:   Thu, 30 Jul 2020 10:04:42 +0200
Message-Id: <20200730074421.378665680@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074421.203879987@linuxfoundation.org>
References: <20200730074421.203879987@linuxfoundation.org>
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
index 319868f3f6743..083cd11ce7d7d 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -353,7 +353,7 @@ store_spi_transport_##field(struct device *dev, 			\
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



