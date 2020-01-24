Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE5FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B71214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865718;
	bh=zHEa6RyqK3/AXhuI0UnHSIyB5967ALnXb+WEQ3VtwPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SVSWwV4IcTIJtZ9sTvktOHSaxXeh8kkTotDlzcUcDnQUgPcXhrwTViq1yzG6Uzvnt
	 0IlmAaIt0S/8mvMDI2PnEEVIV07O2FPl3hlP3NHr/xJn09AblkCicq2YCKUm726FwJ
	 z5DW7bu2VHWAjvYP+F60m94iz+mwB6ekgIC+KTJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404820AbgAXLfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404631AbgAXLfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:35:13 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F90214AF;
        Fri, 24 Jan 2020 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865713;
        bh=zHEa6RyqK3/AXhuI0UnHSIyB5967ALnXb+WEQ3VtwPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIphtptR2/4/+pkq8wNF2zV6dboyd6Y+ZiS48qvOzbO3Vqp0I8MzgeFfbKuugW0SR
         vRBtT4ynW8Goy/3/fEan71tmhNp/aKZlMjjqINvg48djVJHrXx839XHK6XTZscIz+8
         8aAeBYy688KfqU5ZwiYcQSV20QMTuXWT3rjBxsgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 605/639] vhost/test: stop device before reset
Date:   Fri, 24 Jan 2020 10:32:55 +0100
Message-Id: <20200124093205.226348560@linuxfoundation.org>
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

From: Michael S. Tsirkin <mst@redhat.com>

[ Upstream commit 245cdd9fbd396483d501db83047116e2530f245f ]

When device stop was moved out of reset, test device wasn't updated to
stop before reset, this resulted in a use after free.  Fix by invoking
stop appropriately.

Fixes: b211616d7125 ("vhost: move -net specific code out")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index a9be2d8e98df7..55090d9f9de0d 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -162,6 +162,7 @@ static int vhost_test_release(struct inode *inode, struct file *f)
 
 	vhost_test_stop(n, &private);
 	vhost_test_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_cleanup(&n->dev);
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
@@ -238,6 +239,7 @@ static long vhost_test_reset_owner(struct vhost_test *n)
 	}
 	vhost_test_stop(n, &priv);
 	vhost_test_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, umem);
 done:
 	mutex_unlock(&n->dev.mutex);
-- 
2.20.1



