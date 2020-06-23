Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924E7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F88D20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948062;
	bh=SaQqvQFMNTh+YxDu89iw6n8Oqci79i/uH0NDjdrZvCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QNXgG4AvS+4i6q5JT9HYzoY/qGznD71yBkeKrjSojzDG4Pcdkd4NJR8UZlr89/KJw
	 RUbuYkfUGbE7NnHd5HWR5vI5BGsEdnr+O/YQfJE2AIDKjTxohRZep3MUUqtnGSn4mK
	 W03CLohboHvTYxXGxV3HYCQEmPMTZfiCjAP/kOjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393725AbgFWVeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388374AbgFWULB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:11:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED2A20707;
        Tue, 23 Jun 2020 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943061;
        bh=SaQqvQFMNTh+YxDu89iw6n8Oqci79i/uH0NDjdrZvCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+X7svdXPSwPRP+i6eIEuYxi9iM0WYYXsL1IImrhPOUWEc88W/viIDR8NtwRKTVYq
         Fppw2MxHKASPfgnJIgLMazbeg+3Ut4L0HTesCvXLu3Xva1hjYW+5yOHjt29DYY5zv3
         Ndzwzyk0ZxMxZWi8wiA0g6kl6pKtRdoyRvZ9m6Hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 245/477] powerpc/powernv: add NULL check after kzalloc
Date:   Tue, 23 Jun 2020 21:54:02 +0200
Message-Id: <20200623195419.151216738@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

[ Upstream commit ceffa63acce7165c442395b7d64a11ab8b5c5dca ]

Fixes coccicheck warning:

./arch/powerpc/platforms/powernv/opal.c:813:1-5:
	alloc with no test, possible model on line 814

Add NULL check after kzalloc.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200509020838.121660-1-chenzhou10@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/opal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b3dfd0b6cdd8..d95954ad4c0af 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -811,6 +811,10 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
 		goto out;
 
 	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr) {
+		rc = -ENOMEM;
+		goto out;
+	}
 	name = kstrdup(export_name, GFP_KERNEL);
 	if (!name) {
 		rc = -ENOMEM;
-- 
2.25.1



