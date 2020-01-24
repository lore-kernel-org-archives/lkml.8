Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20198C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD602071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864487;
	bh=yUnP4b5xsN2GvGjsgbWn1YfSxhpUOWL2OnMJ06bYffs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CM8WtX4K3kav98TSTBbszJvizlkrmnRBIY+fYRcwzNkv/HiTbaELpIW2doT3QPLMd
	 M0fmTY7F7L/rAJweQc8Ktx0k1t4TCoFjX+rH984GIMLNvBN7KIfUge+I8E0CtiHMy4
	 bo0T8VS66yIxMXpAkZ9TNcbUmlOeh/e0V3qOi6DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390145AbgAXLOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390243AbgAXLOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:14:42 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A452820663;
        Fri, 24 Jan 2020 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864482;
        bh=yUnP4b5xsN2GvGjsgbWn1YfSxhpUOWL2OnMJ06bYffs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnZrR7fLJb+Pez3Hs/2xc/1BdtXO/CqSNNzgxFYLw46Y4X3s6qnBlLK3Re5+tqqyR
         /ipuA0bdlpX5wpnXI6qNuXVxJkHi5OzhJ/BXpDyIRRGrtVDKUxuv/BmeTubxGUgLpx
         vfsBbMjNET0BKJco4Lvz7Uhp715bYu4ZUflfLYFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 264/639] media: ivtv: update *pos correctly in ivtv_read_pos()
Date:   Fri, 24 Jan 2020 10:27:14 +0100
Message-Id: <20200124093119.801755359@linuxfoundation.org>
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

[ Upstream commit f8e579f3ca0973daef263f513da5edff520a6c0d ]

We had intended to update *pos, but the current code is a no-op.

Fixes: 1a0adaf37c30 ("V4L/DVB (5345): ivtv driver for Conexant cx23416/cx23415 MPEG encoder/decoder")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ivtv/ivtv-fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ivtv/ivtv-fileops.c b/drivers/media/pci/ivtv/ivtv-fileops.c
index 6196daae4b3e0..043ac0ae9ed07 100644
--- a/drivers/media/pci/ivtv/ivtv-fileops.c
+++ b/drivers/media/pci/ivtv/ivtv-fileops.c
@@ -420,7 +420,7 @@ static ssize_t ivtv_read_pos(struct ivtv_stream *s, char __user *ubuf, size_t co
 
 	IVTV_DEBUG_HI_FILE("read %zd from %s, got %zd\n", count, s->name, rc);
 	if (rc > 0)
-		pos += rc;
+		*pos += rc;
 	return rc;
 }
 
-- 
2.20.1



