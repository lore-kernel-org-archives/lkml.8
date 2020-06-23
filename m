Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB8DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8974920E65
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943287;
	bh=v/vu0Mt0t8AGEPAQQro23PRx3LUfvzfkNaHAULRUE+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UyoZnU0/cF/5csS3QTEJeu+k5yMf4IG7dY66amTyFkVNpVdNsya7DJ6dyGQWvKaqi
	 qnqMETsE1pnWnvCAhS50fgtRGVjiJpd4sbXQ2hlfw7Y7QT7B3gQ03VNsZcEk5R0/74
	 bY6LAWvBe9M1UWUFc+GbXrbrZinmrBLvtnh3MwxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbgFWUOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389217AbgFWUOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:14:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C6E121473;
        Tue, 23 Jun 2020 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943280;
        bh=v/vu0Mt0t8AGEPAQQro23PRx3LUfvzfkNaHAULRUE+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JeURaZPnWlV5BrvlDmm1BMZN6rSY+iydPBbWocDIsR6HYJnW7ZyGg3yyrdCL3FHur
         5Nw80iCVQ4xjYESXj1cYrU/qxFYEvfaZhhcqX0OIDTPl3kl/5Swex0zq5NdVUgW4Ha
         0H+41QD2gFU+iAT/g9GOEHDC+xIGXvmm9LVSN3eU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 303/477] mailbox: imx: Fix return in imx_mu_scu_xlate()
Date:   Tue, 23 Jun 2020 21:55:00 +0200
Message-Id: <20200623195421.869765709@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 1b3a347b7d56aa637157da1b7df225071af1421f ]

This called from mbox_request_channel().  The caller is  expecting error
pointers and not NULL so this "return NULL;" will lead to an Oops.

Fixes: 0a67003b1985 ("mailbox: imx: add SCU MU support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/imx-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 7906624a731c1..9d6f0217077b2 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -374,7 +374,7 @@ static struct mbox_chan *imx_mu_scu_xlate(struct mbox_controller *mbox,
 		break;
 	default:
 		dev_err(mbox->dev, "Invalid chan type: %d\n", type);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (chan >= mbox->num_chans) {
-- 
2.25.1



