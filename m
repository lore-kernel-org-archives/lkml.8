Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A6EC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3521F246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607361;
	bh=xIU6Nwqa904aEcK0t4PQtkloNsGxD+863Oj+mHYhQY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=coE8tZtctFvqdQ4y0BxpEuMiLGZocBeZcKSndqNGHBJ78fCGcGSKi2USHiUA1zEt6
	 DktFpmtAML9yL8oDzZJfNoM1qsS3wJJzZiFBF7d3WoGqKNGNTNzg+DKeWT8rcIlABb
	 FRqtEyrUzrfeTX3WWhCGLgluEGtLCVOWmMEq7how=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgBMPWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgBMPWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:31 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 078D62469A;
        Thu, 13 Feb 2020 15:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607350;
        bh=xIU6Nwqa904aEcK0t4PQtkloNsGxD+863Oj+mHYhQY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btO8/4xXs7ersuBXMujp3cUPHNx2Cdjttgr0Wpx7Hf/+UNrOYIlw/rZfn27IYHJPp
         G4bApOG63Qy91GDqNogQsnRWvJobC8c/WsEE4DhCsaa2E8GP0Dghtdsi4dlhSV0HGX
         noq7CzJo/LFaK5l5h78J2C9CK8iOPlpmvZgYb9kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 30/91] crypto: picoxcell - adjust the position of tasklet_init and fix missed tasklet_kill
Date:   Thu, 13 Feb 2020 07:19:47 -0800
Message-Id: <20200213151833.166396815@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit 7f8c36fe9be46862c4f3c5302f769378028a34fa upstream.

Since tasklet is needed to be initialized before registering IRQ
handler, adjust the position of tasklet_init to fix the wrong order.

Besides, to fix the missed tasklet_kill, this patch adds a helper
function and uses devm_add_action to kill the tasklet automatically.

Fixes: ce92136843cb ("crypto: picoxcell - add support for the picoxcell crypto engines")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/picoxcell_crypto.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1610,6 +1610,11 @@ static bool spacc_is_compatible(struct p
 	return false;
 }
 
+static void spacc_tasklet_kill(void *data)
+{
+	tasklet_kill(data);
+}
+
 static int spacc_probe(struct platform_device *pdev)
 {
 	int i, err, ret = -EINVAL;
@@ -1652,6 +1657,14 @@ static int spacc_probe(struct platform_d
 		return -ENXIO;
 	}
 
+	tasklet_init(&engine->complete, spacc_spacc_complete,
+		     (unsigned long)engine);
+
+	ret = devm_add_action(&pdev->dev, spacc_tasklet_kill,
+			      &engine->complete);
+	if (ret)
+		return ret;
+
 	if (devm_request_irq(&pdev->dev, irq->start, spacc_spacc_irq, 0,
 			     engine->name, engine)) {
 		dev_err(engine->dev, "failed to request IRQ\n");
@@ -1714,8 +1727,6 @@ static int spacc_probe(struct platform_d
 	INIT_LIST_HEAD(&engine->completed);
 	INIT_LIST_HEAD(&engine->in_progress);
 	engine->in_flight = 0;
-	tasklet_init(&engine->complete, spacc_spacc_complete,
-		     (unsigned long)engine);
 
 	platform_set_drvdata(pdev, engine);
 


