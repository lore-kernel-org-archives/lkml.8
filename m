Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAA3C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4B32065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260443;
	bh=/Jj+U6siC94ko60rqolLaoqkcuyH+GqVj3Q8RrcO8fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+pTMWFJBAmH0lflcvKBUggs1SQApXBcI5ahx4x8H/dCOwxZWVd4WLJ7QYNarar2J
	 0VcQcKtI7XoqxzG1ZokzV8Q1eaTybLlZ6Ue1PeYKDbKOiK3LUrfOG8Ng9XE8TCzCXd
	 lAdzdNhCYXv7wuzhUfv80RLmAPuiMhfybjxfD3GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgGTPyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730946AbgGTPx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:53:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0599206E9;
        Mon, 20 Jul 2020 15:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260438;
        bh=/Jj+U6siC94ko60rqolLaoqkcuyH+GqVj3Q8RrcO8fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3cU2AV88jgN5XB/hV7GFqk95mFcj5Utrai7HlgpS7HC+45XA65UaSSj/OfNEDgSi
         zirAoI0SxJS93hh744no6CapTm/PnAwBWMUM6EIEav9iTnCs9y3un0zgK7VzGTPiPD
         mmaJZEf1aeReMqFRQ1ehELSfzpJNhWsdHxlg8dXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.19 071/133] soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes before flushing new data
Date:   Mon, 20 Jul 2020 17:36:58 +0200
Message-Id: <20200720152807.144144806@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maulik Shah <mkshah@codeaurora.org>

commit f5ac95f9ca2f439179a5baf48e1c0f22f83d936e upstream.

TCSes have previously programmed data when rpmh_flush() is called.
This can cause old data to trigger along with newly flushed.

Fix this by cleaning SLEEP and WAKE TCSes before new data is flushed.

With this there is no need to invoke rpmh_rsc_invalidate() call from
rpmh_invalidate().

Simplify rpmh_invalidate() by moving invalidate_batch() inside.

Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/1586703004-13674-4-git-send-email-mkshah@codeaurora.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/qcom/rpmh.c |   41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -318,19 +318,6 @@ static int flush_batch(struct rpmh_ctrlr
 	return ret;
 }
 
-static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
-{
-	struct batch_cache_req *req, *tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
-	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
-		kfree(req);
-	INIT_LIST_HEAD(&ctrlr->batch_cache);
-	ctrlr->dirty = true;
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
-}
-
 /**
  * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
  * batch to finish.
@@ -470,6 +457,13 @@ int rpmh_flush(const struct device *dev)
 		return 0;
 	}
 
+	/* Invalidate the TCSes first to avoid stale data */
+	do {
+		ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
+	} while (ret == -EAGAIN);
+	if (ret)
+		return ret;
+
 	/* First flush the cached batch requests */
 	ret = flush_batch(ctrlr);
 	if (ret)
@@ -501,24 +495,25 @@ int rpmh_flush(const struct device *dev)
 EXPORT_SYMBOL(rpmh_flush);
 
 /**
- * rpmh_invalidate: Invalidate all sleep and active sets
- * sets.
+ * rpmh_invalidate: Invalidate sleep and wake sets in batch_cache
  *
  * @dev: The device making the request
  *
- * Invalidate the sleep and active values in the TCS blocks.
+ * Invalidate the sleep and wake values in batch_cache.
  */
 int rpmh_invalidate(const struct device *dev)
 {
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
-	int ret;
-
-	invalidate_batch(ctrlr);
+	struct batch_cache_req *req, *tmp;
+	unsigned long flags;
 
-	do {
-		ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
-	} while (ret == -EAGAIN);
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
+		kfree(req);
+	INIT_LIST_HEAD(&ctrlr->batch_cache);
+	ctrlr->dirty = true;
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(rpmh_invalidate);


