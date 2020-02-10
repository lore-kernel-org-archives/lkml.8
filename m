Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4924C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CDC2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340013;
	bh=5ffel+uqaGLmRjLQorijdcIDxRctM3kqvSQoBkq/7sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqC6KNykLfk+xlte2+SzBJFmz5ezfr0/bjjRu4j1+pYRPmMnnvQAqsdhdQrzFDSez
	 b7lxQxYxI60yoWPkc7YDKwKP+hJGfPVrJZ9GiOculAdx87bRWlURMMTKmQJMkl97zF
	 W1h52YgIM/vPyCmmgMvnJ99y5qFtcPlrLcqfMzWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgBJMjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgBJMh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:56 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 335E424680;
        Mon, 10 Feb 2020 12:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338276;
        bh=5ffel+uqaGLmRjLQorijdcIDxRctM3kqvSQoBkq/7sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0KzJ87B7bG1LbZa45guejEHfBSQa9Grv7DFntTrrgfxXI8ld1FAg80EhiwGfbY+5
         CKQYyKkom0NqiCzQJzNRqhwcqudEHpXhmciWcoUz+v2Uw/VQ3mSqwodSWXfDV8kuCL
         FRcgg4GE+3rocD0wrzrwg+HJyurY7Ca3b7bcOKoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 162/309] crypto: picoxcell - adjust the position of tasklet_init and fix missed tasklet_kill
Date:   Mon, 10 Feb 2020 04:31:58 -0800
Message-Id: <20200210122421.777359103@linuxfoundation.org>
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
@@ -1613,6 +1613,11 @@ static const struct of_device_id spacc_o
 MODULE_DEVICE_TABLE(of, spacc_of_id_table);
 #endif /* CONFIG_OF */
 
+static void spacc_tasklet_kill(void *data)
+{
+	tasklet_kill(data);
+}
+
 static int spacc_probe(struct platform_device *pdev)
 {
 	int i, err, ret;
@@ -1655,6 +1660,14 @@ static int spacc_probe(struct platform_d
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
@@ -1712,8 +1725,6 @@ static int spacc_probe(struct platform_d
 	INIT_LIST_HEAD(&engine->completed);
 	INIT_LIST_HEAD(&engine->in_progress);
 	engine->in_flight = 0;
-	tasklet_init(&engine->complete, spacc_spacc_complete,
-		     (unsigned long)engine);
 
 	platform_set_drvdata(pdev, engine);
 


