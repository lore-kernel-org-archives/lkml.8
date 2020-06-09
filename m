Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BC2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D542067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591727143;
	bh=ebFJS0H4UA3YbY9afzAkHwLOVKFy+tp8IZKLeR6Z8UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LpSFt1Ek9Quix5pomGxE4rjGWyGTz9F+BFxO9/HIyl5oqu91pQSflLCf7mmiHHjsl
	 4DbE6zDdVjd99SmDxf09afgbesn+3TtQvGaUinJsWrGmwgZan4hI3dmHjmKG1/6av3
	 Yc+YRU7SB1EB3oyd92M9nSQvr5waISHJ7mIagbKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbgFISZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731916AbgFIRqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:46:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B042C20823;
        Tue,  9 Jun 2020 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724780;
        bh=ebFJS0H4UA3YbY9afzAkHwLOVKFy+tp8IZKLeR6Z8UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVtOBABiMB0CjjsriMv724hMvZtwJ0HIAz5KA+XKpAP1Srzzw2xJ3h3ffBivDvfOC
         k599L7uPBRkhC//Yf8il7qWX9r87hQJ+bUMuztsjRzQ9uwFle6o29Np5OamEaSGhXM
         jKuRpEgv8q7w7zN+/ddgIRZqiENru6oSxY4rr+u4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 05/36] IB/mlx4: Fix an error handling path in mlx4_ib_rereg_user_mr()
Date:   Tue,  9 Jun 2020 19:44:05 +0200
Message-Id: <20200609173933.596507899@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609173933.288044334@linuxfoundation.org>
References: <20200609173933.288044334@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

commit 3dc7c7badb7502ec3e3aa817a8bdd9e53aa54c52 upstream.

Before returning -EPERM we should release some resources, as already done
in the other error handling path of the function.

Fixes: d8f9cc328c88 ("IB/mlx4: Mark user MR as writable if actual virtual memory is writable")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx4/mr.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -246,8 +246,11 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *
 	}
 
 	if (flags & IB_MR_REREG_ACCESS) {
-		if (ib_access_writable(mr_access_flags) && !mmr->umem->writable)
-			return -EPERM;
+		if (ib_access_writable(mr_access_flags) &&
+		    !mmr->umem->writable) {
+			err = -EPERM;
+			goto release_mpt_entry;
+		}
 
 		err = mlx4_mr_hw_change_access(dev->dev, *pmpt_entry,
 					       convert_access(mr_access_flags));


