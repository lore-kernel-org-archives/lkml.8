Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03649C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C347C208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341163;
	bh=4ZvtdWXt8ILhmlZ1K0mOPyL+G3mcDfkBS6LGeAH6atY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oOwT4uNlBL0z/owrhDKaPXsbKxBaCrxLesqJyQBtt2pDeW+cVJ1Miw2+o0+UOsMH2
	 eQhOrg9ho15FoIq6UXDyZ4GotTx5xzyVNLB41A9qY6jFMFnXT1Fk75l2nypfSdEOur
	 hpzKu224n/mKTDZhH3iTKm+/rkCT7paWmhMi2R+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgBJN0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgBJMgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:50 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C93C924649;
        Mon, 10 Feb 2020 12:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338209;
        bh=4ZvtdWXt8ILhmlZ1K0mOPyL+G3mcDfkBS6LGeAH6atY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdy3Wq5B6EBNJp92jO7Vv40Si9BCnTSW8dM1G4lMSB3a40cuHZSjE019bf5Dp5HAl
         zV1BP2P57mqmLA4fhADjRcrtOHe1w7Er3e7SpTEHPbekufeMWaS5rO9dbqNJvyrK46
         W2uGGY6JTLPMT/zwEMpL8l1PJmZmLLX519t9Bb4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.4 032/309] nvmet: Fix error print message at nvmet_install_queue function
Date:   Mon, 10 Feb 2020 04:29:48 -0800
Message-Id: <20200210122409.159491617@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

commit 0b87a2b795d66be7b54779848ef0f3901c5e46fc upstream.

Place the arguments in the correct order.

Fixes: 1672ddb8d691 ("nvmet: Add install_queue callout")
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/target/fabrics-cmd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -132,7 +132,7 @@ static u16 nvmet_install_queue(struct nv
 
 		if (ret) {
 			pr_err("failed to install queue %d cntlid %d ret %x\n",
-				qid, ret, ctrl->cntlid);
+				qid, ctrl->cntlid, ret);
 			return ret;
 		}
 	}


