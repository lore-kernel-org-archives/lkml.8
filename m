Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F596C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696132077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864490;
	bh=1MGsX48bvwxErSdQZ8UfW8rtCVM8uLtWATXdH0A0TFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UB+Y9kCTY1nI78s8n+4v0K6Ccqnd/nppnjLJHXum4SzlnvSZBAvjxgPvfkoA4Pd57
	 tceHo+qeiQ2OWuJ7AhDC4pfiBorPXVc668MVemXQNRCzvkt/yFGxEbTttzGdiRxpJo
	 KVFs/bPwCY1S7sSx1jYmk+E5V/EowNGIgfTZUNj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbgAXLOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389143AbgAXLOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:14:46 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F0B2075D;
        Fri, 24 Jan 2020 11:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864486;
        bh=1MGsX48bvwxErSdQZ8UfW8rtCVM8uLtWATXdH0A0TFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mudInjXbtqtAC2DG8uLSlf635b8Fe8D9WIB94V46XPa675T/HDiUWNOlD1AUdzGGW
         3GgRsvxTE/xNVxpt+KbfyekK4/sptBHHknBQXO5Y46Xt7vM+78D+RUcMVuwxGQbkp5
         LwRYMYHQ2ZA317wXqbbJLw7mmHoMRZVNiWZ5flPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 265/639] media: cx18: update *pos correctly in cx18_read_pos()
Date:   Fri, 24 Jan 2020 10:27:15 +0100
Message-Id: <20200124093119.920321001@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7afb0df554292dca7568446f619965fb8153085d ]

We should be updating *pos.  The current code is a no-op.

Fixes: 1c1e45d17b66 ("V4L/DVB (7786): cx18: new driver for the Conexant CX23418 MPEG encoder chip")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx18/cx18-fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-fileops.c b/drivers/media/pci/cx18/cx18-fileops.c
index a3f44e30f8219..88c2f3bea2b61 100644
--- a/drivers/media/pci/cx18/cx18-fileops.c
+++ b/drivers/media/pci/cx18/cx18-fileops.c
@@ -484,7 +484,7 @@ static ssize_t cx18_read_pos(struct cx18_stream *s, char __user *ubuf,
 
 	CX18_DEBUG_HI_FILE("read %zd from %s, got %zd\n", count, s->name, rc);
 	if (rc > 0)
-		pos += rc;
+		*pos += rc;
 	return rc;
 }
 
-- 
2.20.1



