Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EEFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF53206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkI7qDJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgFAR4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgFARz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:55:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F534C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:55:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so3851388pgn.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ly/+lULxncE0Hv/XKPdsdbKvQX3A5UmakKCmLALYjq0=;
        b=dkI7qDJyx89vpnpMR9RvXRcPeeBf1zFWx/8GgGMnZHyTtL5pipzTvNVHo3FGncZVYp
         Q7Y9OGgwFDlGDkHj7dXap5cwa0mPWzPieIeTTIoUzGl+fW7h3aF95HXddQjs0fsROJrA
         P528DEuQDIA7QACQVabOPNA0v632XS/lQMgR4b1qXKrkSqaKCYcMKk5J05O3srOpFIXY
         dUrHzjzEx2EkUO7RCMrWu181kDtXBfkA0iO0u59DOUweyH/+HKER5DQSaT4lrzGdRhMa
         gyt9sn5ZugY43f4OnB3ZlAL/eKeILEk7u/Tb+l7MBh0tkjdiYM99wXTLXsnK0qC4sIJM
         qzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ly/+lULxncE0Hv/XKPdsdbKvQX3A5UmakKCmLALYjq0=;
        b=Hpp+mbATIHHytgYsJXZEw0w0fIBiZyuz6IY4QEDDIAUurq24Di7dbEjpt7tuSXfIbB
         tNfRBjHF+jHtE45jlLL/R8Gmtml3i65l2sEZMdhjXeqXrtEkHU7wx0kH+pS4w2Y7Gi0d
         pxZAMi0ORAl/KjtURp++nnGruBgY9VYY9hVkri6DS1PPyiIirh9YjdL9mkEKhh+9l7uz
         UNAVIKeWiXgGLbp5jzG0+7Mi7adzuRpXSNEuRehf7s+6h4qPw0z2EEDFrEf9KliScX7r
         iDkFnrU3v3YlVvLfocfxKVMTB+ca81BNC8CotUKaH1tM2Luvadu6EnRosynQmHO3cKbu
         4ZGQ==
X-Gm-Message-State: AOAM530hl1/yzflVz+PDuTQXrI7/SIfFV+hjiugHw1EwkWY/94YwdFeE
        KqKX6INmHcepzexNbIzI8sgwVg==
X-Google-Smtp-Source: ABdhPJyfHXNxc1V3Yc+P6I77d41jXD45DyYRGH8UfzswQ1/Fjb0Q/j2fYXA57kZwWD2pF4ngIEehYg==
X-Received: by 2002:a05:6a00:148c:: with SMTP id v12mr21200684pfu.171.1591034156896;
        Mon, 01 Jun 2020 10:55:56 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:55:56 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 02/11] remoteproc: stm32: Request IRQ with platform device
Date:   Mon,  1 Jun 2020 11:55:43 -0600
Message-Id: <20200601175552.22286-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175552.22286-1-mathieu.poirier@linaro.org>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request IRQ with platform device rather than remote proc in order to
call stm32_rproc_parse_dt() before rproc_alloc().  That way we can
know whether we need to synchronise with the MCU or not.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index a80733fb08e7..94fd687fb5b2 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -261,7 +261,8 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 
 static irqreturn_t stm32_rproc_wdg(int irq, void *data)
 {
-	struct rproc *rproc = data;
+	struct platform_device *pdev = data;
+	struct rproc *rproc = platform_get_drvdata(pdev);
 
 	rproc_report_crash(rproc, RPROC_WATCHDOG);
 
@@ -553,7 +554,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 
 	if (irq > 0) {
 		err = devm_request_irq(dev, irq, stm32_rproc_wdg, 0,
-				       dev_name(dev), rproc);
+				       dev_name(dev), pdev);
 		if (err) {
 			dev_err(dev, "failed to request wdg irq\n");
 			return err;
-- 
2.20.1

