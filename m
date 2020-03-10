Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F19EC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A85A20674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844441;
	bh=xVHPfJwgpy+80zOCWhcXFojkR2XjvT3blf7cFg0/OCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l1DFjgAJMPPyW+6Dv8hVWPU4R5OJdj+5oPNMrq0rXqx4NriKFZXCf53K2M/NakaVZ
	 UEHgROaq/+CswK5OtCWqSJ0kwbJMYjeNQot3eFmezptqtb46eRvcdtPXGjLuQSruz9
	 4l/kbQGH+22r3Lahfk2iz0Mr7EiwNDbVfl6AVEdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgCJMrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgCJMrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:47:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6429320674;
        Tue, 10 Mar 2020 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844436;
        bh=xVHPfJwgpy+80zOCWhcXFojkR2XjvT3blf7cFg0/OCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=datS4WqDTjhcMPYs1VCBXJTAXN1JV4lqJqgQQxrbuwtDkyRCYhK/83EoqriYti6q7
         HEpSQYmCMg7gI0LzwUJQvgbroSUM1voMnOGWpQjwnLWBR2NUZk+ZGBuCb+zTJ8bYRF
         tZzDfz8SlcTNwoT6uucr9TGo09APR3TGKZv2oR3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 82/88] RMDA/cm: Fix missing ib_cm_destroy_id() in ib_cm_insert_listen()
Date:   Tue, 10 Mar 2020 13:39:30 +0100
Message-Id: <20200310123624.696596703@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

commit c14dfddbd869bf0c2bafb7ef260c41d9cebbcfec upstream.

The algorithm pre-allocates a cm_id since allocation cannot be done while
holding the cm.lock spinlock, however it doesn't free it on one error
path, leading to a memory leak.

Fixes: 067b171b8679 ("IB/cm: Share listening CM IDs")
Link: https://lore.kernel.org/r/20200221152023.GA8680@ziepe.ca
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/cm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1073,6 +1073,7 @@ struct ib_cm_id *ib_cm_insert_listen(str
 			/* Sharing an ib_cm_id with different handlers is not
 			 * supported */
 			spin_unlock_irqrestore(&cm.lock, flags);
+			ib_destroy_cm_id(cm_id);
 			return ERR_PTR(-EINVAL);
 		}
 		atomic_inc(&cm_id_priv->refcount);


