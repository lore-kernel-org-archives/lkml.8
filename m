Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA36FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1625208A7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwiDftbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFATBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgFAR4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B324C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:56:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so233107pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4k72LVztQ+3OPIVfCjk5AKi+kBj/xA40V3ZRlBXiosE=;
        b=lwiDftbDn6zhaZZ4Jh4yVwIWU/cWgoePKS3jSUwjCl3Jfy2BfO7OzD3lXgOxCKSE6s
         EA0t9HA794QQuONUBIuG6b5LxDfH+Aw1c+/aneuoX/JjlzTQlbrAkDwwctTvo0RFXXVf
         RMe4teHr2HjquWdvA65du0gNHxLxbazkjPjxQf6BnGcoYzV/msXJjc/06OjrdozJyw1c
         MN/0xmcmq0yupcEbzeFr13DCoRnR+yqLYo28OOzIYC3ltUP0POk4iLxhxtzWu1RUbcCh
         lvSpreUDi/2CEOjllgx6Q10FBpzJf658wf9utALJLpgORudxuGyl21DkX+T8FE0cVT51
         y1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4k72LVztQ+3OPIVfCjk5AKi+kBj/xA40V3ZRlBXiosE=;
        b=QifjHpAhv9VJcZ5DQZ/klG0KaZdrhjuLas1h6BRqlhtGskl6iRjUssPnrSXwsmwgS3
         guWTIjPkg3IFu2CUNZHLFg+K5KxYKeIqrCoOreKMearULlClWveO7/Um4U1cvoPoTKMv
         cpesgzhRPKL11ZMos8KVzi8ByW5fOJO7j6ZuaPM6tYLte3ObROWjvcHW0zB8AUt2bXUp
         rzkbw4FeGbKNRE0ccZpezMs0CCuIEqXcoq7EsS3h/z3061FhjxT/Y1BUCsF1Z8EtOhoB
         i40NUF+5c1LQ9rQltBiyB91QASWqvSS9S5VappMm66DWa9V3ukMTV5/Il70b9VFuZQ83
         +6xA==
X-Gm-Message-State: AOAM531+2H4+wF14E0S0SXzmq5qL0K4rPd3uT7vtMnxlcl1e2gkUUUT5
        HVGQvNkamNmNl8rUkzsb4uBwrw==
X-Google-Smtp-Source: ABdhPJysMznlN/ClmaL8ZQBX6gr9202gWa/xTGIljnYs+zC6HL/jwJa9bKBC2cihfsJrdqTHVAfzzg==
X-Received: by 2002:a17:90b:8b:: with SMTP id bb11mr561940pjb.219.1591034163607;
        Mon, 01 Jun 2020 10:56:03 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:56:03 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 07/11] remoteproc: Make function rproc_resource_cleanup() public
Date:   Mon,  1 Jun 2020 11:55:48 -0600
Message-Id: <20200601175552.22286-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175552.22286-1-mathieu.poirier@linaro.org>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make function rproc_resource_cleanup() public so that it can be
used by platform drivers when allocating resources to be used by
a detached remote processor.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 3 ++-
 include/linux/remoteproc.h           | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a8adc712e7f6..6b0ded714beb 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1272,7 +1272,7 @@ static void rproc_coredump_cleanup(struct rproc *rproc)
  * This function will free all resources acquired for @rproc, and it
  * is called whenever @rproc either shuts down or fails to boot.
  */
-static void rproc_resource_cleanup(struct rproc *rproc)
+void rproc_resource_cleanup(struct rproc *rproc)
 {
 	struct rproc_mem_entry *entry, *tmp;
 	struct rproc_debug_trace *trace, *ttmp;
@@ -1316,6 +1316,7 @@ static void rproc_resource_cleanup(struct rproc *rproc)
 
 	rproc_coredump_cleanup(rproc);
 }
+EXPORT_SYMBOL(rproc_resource_cleanup);
 
 static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index cf5e31556780..7c0567029f7c 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -610,6 +610,7 @@ void rproc_put(struct rproc *rproc);
 int rproc_add(struct rproc *rproc);
 int rproc_del(struct rproc *rproc);
 void rproc_free(struct rproc *rproc);
+void rproc_resource_cleanup(struct rproc *rproc);
 
 struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
 			       const struct rproc_ops *ops,
-- 
2.20.1

