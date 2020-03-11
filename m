Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B2C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B0B2074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LguTebpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgCKXOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:14:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38299 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbgCKXOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:14:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so2216267pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWBjFQXkSBNRsjQ6miPhHt5bde1mFApW8A9hXCEPvFI=;
        b=LguTebpOgMY1OHVxiVcNye4AXrA527VpjMXtXNfeo1dOVyA4+iLfLEzY8FsMnsBAsc
         E6BeIn78I+gQO162VXEyatPZ5hSVUz1sCr0Q9juzHnJPv97xSLNAMDMGN/fK/sWmkyW1
         hKK+VbVYaIOIcGVe1tHh1Avo40fMjblj7/SZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWBjFQXkSBNRsjQ6miPhHt5bde1mFApW8A9hXCEPvFI=;
        b=EOkYBIuc0cn37+uqoO4LvkJYRJEcpkQr1Ztn8lW280gEafMsqeuI9iJVqpRUhCjYxR
         YM8ou6TyOSE51fdJFkCppznby4Q/lIiqUouRDrivYwmE/oq0kYgTSilQU9PpsSf/VyAh
         AwNZqdw7PFuFtJiJzuQMi/jkfwSP/UEF7rULZkm0/x2vM8405APhIcJjKiok3p8Nr2d3
         NOHTDbncIHibtvYnpNOxCOmBhnKE1nNm5FPfMAqzdIKgn8r2GcUtaxqhAE1DLFuyhtuN
         VwvUUoohsfIAb6K9+2WNSUjp1/okTz/OGCw8kwQ1SgGmDwXUKyRGHkTpfLOv4c1Sz/ur
         zwsA==
X-Gm-Message-State: ANhLgQ04gAuWc82C5QgZOlTdBP0lkm2ETDgMtrcAVWqvj+y7wOje0dQM
        t24s87EhpWIOq12nSxUKGsARaQ==
X-Google-Smtp-Source: ADFU+vv6X0UnzkEj2YlvXDq+eSZJYrQxXPKGUCKJLjK8g3CuKDN5rYk+n8oeLbdWPp3hb9WK391FZg==
X-Received: by 2002:a65:43cb:: with SMTP id n11mr4796908pgp.65.1583968456977;
        Wed, 11 Mar 2020 16:14:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g75sm2606334pje.37.2020.03.11.16.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:14:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 04/10] drivers: qcom: rpmh-rsc: Remove get_tcs_of_type() abstraction
Date:   Wed, 11 Mar 2020 16:13:42 -0700
Message-Id: <20200311161104.RFT.v2.4.Ia348ade7c6ed1d0d952ff2245bc854e5834c8d9a@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200311231348.129254-1-dianders@chromium.org>
References: <20200311231348.129254-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_tcs_of_type() function doesn't provide any value.  It's not
conceptually difficult to access a value in an array, even if that
value is in a structure and we want a pointer to the value.  Having
the function in there makes me feel like it's doing something fancier
like looping or searching.  Remove it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
---

Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 799847b08038..c9f29cbd5ee5 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -170,17 +170,10 @@ static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
 }
 
-static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
-{
-	return &drv->tcs[type];
-}
-
 static int tcs_invalidate(struct rsc_drv *drv, int type)
 {
 	int m;
-	struct tcs_group *tcs;
-
-	tcs = get_tcs_of_type(drv, type);
+	struct tcs_group *tcs = &drv->tcs[type];
 
 	spin_lock(&tcs->lock);
 	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
@@ -246,9 +239,9 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 	 * dedicated AMC, and therefore would invalidate the sleep and wake
 	 * TCSes before making an active state request.
 	 */
-	tcs = get_tcs_of_type(drv, type);
+	tcs = &drv->tcs[type];
 	if (msg->state == RPMH_ACTIVE_ONLY_STATE && !tcs->num_tcs) {
-		tcs = get_tcs_of_type(drv, WAKE_TCS);
+		tcs = &drv->tcs[WAKE_TCS];
 		if (tcs->num_tcs) {
 			ret = rpmh_rsc_invalidate(drv);
 			if (ret)
-- 
2.25.1.481.gfbce0eb801-goog

