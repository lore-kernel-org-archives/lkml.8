Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D535C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B8420663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFikycEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgEDWnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgEDWnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:43:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71235C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 15:43:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so71666wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lUmbEdvnWPeUk4t6giKyfyBVYwPjBnJKNQQQsbV/urQ=;
        b=GFikycEtJDisqtrSKLOaeTLwYYqS8iklzvNquIP5B5vdHasLq78Y4fBa8X8qpC5H7g
         gqqaMWqgrbsNgOTtvFu6oA/7VnR85SMwZ2fim/BfEHlT8rs69qrgGB7k6XcUJKwWOOzg
         xlmpHXkTXwyl8HepS+SN76+25+yos6OXavMhD+ICCX/5gMj+/USH8Yxgoes4aHVI81cU
         IPyvJuuT0K13qy7WHNjYagvNH1GdowW4IOevVQtCJvofInfMp96fDc76YD/4uBawPNvv
         JzYJh5KWrI9mFaLIyaFrkONd18yxbxFIaoXb//FHsT+lhEaEr3zmcgr/xWCbWWCcwyKz
         zRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lUmbEdvnWPeUk4t6giKyfyBVYwPjBnJKNQQQsbV/urQ=;
        b=RP/ktM+fLRFitQIn+FTaJeZznJOKFTDEegbtQoeOSLeAgVQwlTZNYekSKkM2y/iDB5
         OxkMYuGy03DxaKvn+WFjbpzrW9gCuvVYANrIANu7k/09aKO+c2IVXkIrVRNNRmxitHgO
         VPc1jzhvzI+kkXM7hj5lCM9Zmlkxx/4nOm7qiI7kVo3n6Qlg5GOZlJ22XL6laXDsoMVz
         AMFmVZHiujs+Gn5bmL80YBdTnJsd9hhS0OG1ZviwEc7DQ9RI7DoMSuyAp0gG8F55FMBR
         KkE9G5IC2kLdpwaKZ2j3QPQA6mx3411NbEVZFH/MzsX5k11N2hijSoe8AO8NXsum/d8b
         YMpw==
X-Gm-Message-State: AGi0PuYqBcSKiRK9jfmsIsRoe4VRZwc4/yBXkvLEUZ1UNxOB3BLqCVWw
        4sUeXQa7R1ZdjgTGPbHuWeyNQg==
X-Google-Smtp-Source: APiQypILeXJRTqVe0dXJOUkSfx8nfwQF9nbbhp5olaJiEfZQKtxHmC4CXqx0a2GkR9492iGwqFfm/Q==
X-Received: by 2002:a1c:7fc6:: with SMTP id a189mr16700521wmd.27.1588632195175;
        Mon, 04 May 2020 15:43:15 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a13sm13895888wrv.67.2020.05.04.15.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:43:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Peter.Chen@nxp.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 1/2] usb: chipidea: msm: Ensure proper controller reset using role switch API
Date:   Mon,  4 May 2020 23:43:45 +0100
Message-Id: <20200504224346.613377-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200504224346.613377-1-bryan.odonoghue@linaro.org>
References: <20200504224346.613377-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we check to make sure there is no error state on the extcon
handle for VBUS when writing to the HS_PHY_GENCONFIG_2 register. When using
the USB role-switch API we still need to write to this register absent an
extcon handle.

This patch makes the appropriate update to ensure the write happens if
role-switching is true.

Fixes: 05559f10ed79 ("usb: chipidea: add role switch class support")

Cc: Peter Chen <Peter.Chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index af648ba6544d..46105457e1ca 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -114,7 +114,7 @@ static int ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 			hw_write_id_reg(ci, HS_PHY_GENCONFIG_2,
 					HS_PHY_ULPI_TX_PKT_EN_CLR_FIX, 0);
 
-		if (!IS_ERR(ci->platdata->vbus_extcon.edev)) {
+		if (!IS_ERR(ci->platdata->vbus_extcon.edev) || ci->role_switch) {
 			hw_write_id_reg(ci, HS_PHY_GENCONFIG_2,
 					HS_PHY_SESS_VLD_CTRL_EN,
 					HS_PHY_SESS_VLD_CTRL_EN);
-- 
2.25.1

