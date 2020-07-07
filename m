Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C41C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0142075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IE5epYPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgGGVbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbgGGVb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:31:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09762C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:31:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so20626259pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJEcAvXCkMubZ5CvQAwW4/233WmH+zu/CCD6+/Cfr60=;
        b=IE5epYPw1RKLJGcDCbEzvXqg/wzIPCWzzN5MF6MfqI9d6CQG5XFJfTcsGCoYnO5zor
         NlARFp0Hv7XGJIFLWDcqOl9OywPlN3WnMHXoaQ5VxZprr2okYGkcu+k0H04R5MX4oOxg
         NsV5m8lBFwZ2URIidMlNWX5GhkIlPnuVMB0Ky5FoKFHSDZVq1WnqoBVY1S65x6IReMVb
         ahpQc0LDTA9QmW3dmoQMLqWffbFzmuL7b9Cok+0Xi0y+l3kwb3A4HD5mYFXCd2lLKSly
         iCapvghsBYMN77c9lcOBiDhFr5vvYBEBuHFADT3RvDeGvWp7YtUDQBW4K7Tw51DAZElE
         DazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJEcAvXCkMubZ5CvQAwW4/233WmH+zu/CCD6+/Cfr60=;
        b=lEL+RghSgEBhfew+u6acgSqMtJ7U1jKHHLz+PFo2T/9Gh9cr0zOpb0MB7F5t9EvBoX
         VHmRAdTdyAzZsQpN+7KObrm6LHZAQ5hRUvcK3NiIVPhz0dgbHIQcJDs3sXJwQE8wcc+V
         U9T1V5y6vgSzU0h5Rd+6b+gCQWd99m0EgoKOORRs2Gy9yJJhnDNjMktEcU/gcHGimAIU
         hQCHaW4q8vobIYcrOhWrBXFb0Au+4vwEgLNcem24YVURUJTiLivKVfjHohNXBGM0lfH7
         /PHWwFwPUzdaOOOn8QfNYG0gLvAOrFQmb5zhHpJcG1ZWSQPadEOCvd8vC9rFL0FTH1GE
         Knpw==
X-Gm-Message-State: AOAM532o79iLcKkeYXrQncx7ZTbA/BsDljYIIHjb+ECtxiRygAoJtPDy
        E6J/ePOchC2erODqYqbKLHueGQ==
X-Google-Smtp-Source: ABdhPJyfGJ+vJd9xYmAfFuTKVM4A+h+OYVeHtTcdBy6UX/Eo2auv4jd0+FrywfGIrrOD4bTAWKK3Eg==
X-Received: by 2002:a62:fcca:: with SMTP id e193mr41781795pfh.307.1594157486584;
        Tue, 07 Jul 2020 14:31:26 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o128sm23560832pfg.127.2020.07.07.14.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:31:26 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 10/11] remoteproc: stm32: Introduce new attach() operation
Date:   Tue,  7 Jul 2020 15:31:11 -0600
Message-Id: <20200707213112.928383-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707213112.928383-1-mathieu.poirier@linaro.org>
References: <20200707213112.928383-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new attach function to be used when attaching to a
remote processor.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 882229f3b1c9..7145cd49616e 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -460,6 +460,13 @@ static int stm32_rproc_start(struct rproc *rproc)
 	return stm32_rproc_set_hold_boot(rproc, true);
 }
 
+static int stm32_rproc_attach(struct rproc *rproc)
+{
+	stm32_rproc_add_coredump_trace(rproc);
+
+	return stm32_rproc_set_hold_boot(rproc, true);
+}
+
 static int stm32_rproc_stop(struct rproc *rproc)
 {
 	struct stm32_rproc *ddata = rproc->priv;
@@ -525,6 +532,7 @@ static void stm32_rproc_kick(struct rproc *rproc, int vqid)
 static struct rproc_ops st_rproc_ops = {
 	.start		= stm32_rproc_start,
 	.stop		= stm32_rproc_stop,
+	.attach		= stm32_rproc_attach,
 	.kick		= stm32_rproc_kick,
 	.load		= rproc_elf_load_segments,
 	.parse_fw	= stm32_rproc_parse_fw,
-- 
2.25.1

