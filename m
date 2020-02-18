Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301B6C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA5A24672
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055941;
	bh=QmdDR5zvXy6PIgNyuxthXmWql3YpnD4Coiu30lyUMZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M8zjh94kxNL6yg3wXZ+Vky7TonebFOZx11tXBrSr9mNX2bIv5rDSQSBK7ojKYmE0G
	 B55mTEOKaDKiEoYODXQ38WeqUlZQunFCnfX3nfIxJG6Xy+v2iaDq50dh5ReBFoLgP0
	 /zWWrcv53KwbFnjKE99p3NyDg2yeZ/UDUDDwwV7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgBRT67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgBRT64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:58:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D524320659;
        Tue, 18 Feb 2020 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055935;
        bh=QmdDR5zvXy6PIgNyuxthXmWql3YpnD4Coiu30lyUMZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzJHH1+ejCf+/Tc7XqRpp20l0Rd/jqov1XetEG6IhPqjyY9DazpPuklycpcsYOwtG
         CQCfrKMPBrBUYeGd5uoZMJTYVHoH7dJJyf5sexafXlpRPQ6d0sJ9S+576myuLJWqZg
         IwP1sPolQegwBIHYr0apSG1cVNHq4rA/+Ok+p/Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sujith Pandel <sujith_pandel@dell.com>,
        David Milburn <dmilburn@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 37/66] nvme: fix the parameter order for nvme_get_log in nvme_get_fw_slot_info
Date:   Tue, 18 Feb 2020 20:55:04 +0100
Message-Id: <20200218190431.468890354@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Zhang <yi.zhang@redhat.com>

commit f25372ffc3f6c2684b57fb718219137e6ee2b64c upstream.

nvme fw-activate operation will get bellow warning log,
fix it by update the parameter order

[  113.231513] nvme nvme0: Get FW SLOT INFO log error

Fixes: 0e98719b0e4b ("nvme: simplify the API for getting log pages")
Reported-by: Sujith Pandel <sujith_pandel@dell.com>
Reviewed-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3853,7 +3853,7 @@ static void nvme_get_fw_slot_info(struct
 	if (!log)
 		return;
 
-	if (nvme_get_log(ctrl, NVME_NSID_ALL, 0, NVME_LOG_FW_SLOT, log,
+	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, log,
 			sizeof(*log), 0))
 		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
 	kfree(log);


