Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2789C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17D120773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260994;
	bh=PORYz7Wbze4EhD0RcXJzdnktzYcKspJ3cuEg6I8qGx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1kB+kxEXkFEdeDUkldnEw3gXWlzaTCQqOau5ZN9AZ/tEIIxeA3PVRO+5K1mWCHpaT
	 7nRDIFyYmLUL7KPu3kHiOQIgt4w9cL0rI+Z63M/Rra0jKBEYlQxjw89d4vY48yA4SP
	 5hi4z6uWpHFqRWHqFZbV9Rms9PwFKcDjClsAuoDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgGTQDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732723AbgGTQDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:03:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13F1E20773;
        Mon, 20 Jul 2020 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260990;
        bh=PORYz7Wbze4EhD0RcXJzdnktzYcKspJ3cuEg6I8qGx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ev5ItmaKSCogo9Bm9Qvva6ZOoJpAByMW9ueMGBjgqDOmF7a6O5ApbFfxzFgyDq5s/
         FlmjaLfaG7RYPk8FGnyudnXwdWsTZlO+Bo9/AgQm3uN7/Dtvu1dwvbcyagxLOAfmZf
         7T5eGN6nC9iB2ZlkkUKV/he2Kh92E9JOV05WDh9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.4 129/215] soc: qcom: rpmh-rsc: Allow using free WAKE TCS for active request
Date:   Mon, 20 Jul 2020 17:36:51 +0200
Message-Id: <20200720152826.341474622@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maulik Shah <mkshah@codeaurora.org>

commit 38427e5a47bf83299da930bd474c6cb2632ad810 upstream.

When there are more than one WAKE TCS available and there is no dedicated
ACTIVE TCS available, invalidating all WAKE TCSes and waiting for current
transfer to complete in first WAKE TCS blocks using another free WAKE TCS
to complete current request.

Remove rpmh_rsc_invalidate() to happen from tcs_write() when WAKE TCSes
is re-purposed to be used for Active mode. Clear only currently used
WAKE TCS's register configuration.

Fixes: 2de4b8d33eab (drivers: qcom: rpmh-rsc: allow active requests from wake TCS)
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/1586703004-13674-7-git-send-email-mkshah@codeaurora.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/qcom/rpmh-rsc.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -148,7 +148,7 @@ int rpmh_rsc_invalidate(struct rsc_drv *
 static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					 const struct tcs_request *msg)
 {
-	int type, ret;
+	int type;
 	struct tcs_group *tcs;
 
 	switch (msg->state) {
@@ -169,19 +169,10 @@ static struct tcs_group *get_tcs_for_msg
 	 * If we are making an active request on a RSC that does not have a
 	 * dedicated TCS for active state use, then re-purpose a wake TCS to
 	 * send active votes.
-	 * NOTE: The driver must be aware that this RSC does not have a
-	 * dedicated AMC, and therefore would invalidate the sleep and wake
-	 * TCSes before making an active state request.
 	 */
 	tcs = get_tcs_of_type(drv, type);
-	if (msg->state == RPMH_ACTIVE_ONLY_STATE && !tcs->num_tcs) {
+	if (msg->state == RPMH_ACTIVE_ONLY_STATE && !tcs->num_tcs)
 		tcs = get_tcs_of_type(drv, WAKE_TCS);
-		if (tcs->num_tcs) {
-			ret = rpmh_rsc_invalidate(drv);
-			if (ret)
-				return ERR_PTR(ret);
-		}
-	}
 
 	return tcs;
 }
@@ -406,8 +397,16 @@ static int tcs_write(struct rsc_drv *drv
 
 	tcs->req[tcs_id - tcs->offset] = msg;
 	set_bit(tcs_id, drv->tcs_in_use);
-	if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type != ACTIVE_TCS)
+	if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type != ACTIVE_TCS) {
+		/*
+		 * Clear previously programmed WAKE commands in selected
+		 * repurposed TCS to avoid triggering them. tcs->slots will be
+		 * cleaned from rpmh_flush() by invoking rpmh_rsc_invalidate()
+		 */
+		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, tcs_id, 0);
+		write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, 0);
 		enable_tcs_irq(drv, tcs_id, true);
+	}
 	spin_unlock(&drv->lock);
 
 	__tcs_buffer_write(drv, tcs_id, 0, msg);


