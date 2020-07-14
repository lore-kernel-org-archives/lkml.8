Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162C1C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF46022B51
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNSwVeB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgGNTum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGNTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:50:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ADFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n5so667554pgf.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QuxJqBKRxLtj9joa7Fr05cH1nky6BP1NPkwydOl8hTU=;
        b=vNSwVeB9BGDWeBmn0zAOC1RJPtkDWODCQ2dc09UEnMBV9Us0uuWyuXliTjXG71Z26N
         dByrIDO/0wSu46SGAeypd2TDqRxKpAHdINXuMTE7hmGcjPujI90fLsd5oK6tQndskxCd
         /Z4VBzjqAfPWGlmz4LLwOqVh3U1/yW7C/Hmp3nyC1BiyqBuT0r2hLEJPz7khuqc66vOP
         Jlvw0JbqK4ywp1aqHxI6feIBh74xVuFQsDCpNB/CG1YyWBEAccEwaEno51gc7XXHIpIL
         KyjsWABr6j0+koAmbqsNtvdo8dKdYp3e/VYsV0sSn+bMdMuQmIxNzNJsRrfSO/R6aAr8
         eM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuxJqBKRxLtj9joa7Fr05cH1nky6BP1NPkwydOl8hTU=;
        b=AFu0H+pCdggaBM+gDv3kA7SlFkB8Wsh2mIbeZWZwsCCt/iuNJhtxn0Tr90f3yGHmtR
         GRhuwyPyp6RD1mlwzOPMnqGmj5XLtg+yWb2Cn9SyyegNAJstngP9KN1gKMzCzr+Tgmah
         2t9YhAbfoFSS2QxFFNRJ/g+ebMUovnO63XRgD3+ov6eiVBYFN3W3dteYO9C+8ZKNZG+P
         YXYBiMzwfkoZoagEbxGMOMe1IhP91WYK9v86+nICo4U0tyP4O+pFB0VZqs9GgM7T0g7P
         DhH/MA/gD3VHGX/SRf+CHIrOdCPTovNPMnt79s1VmQfUHUtaLoE5PpGtg+KzOOKxk/lv
         dYdg==
X-Gm-Message-State: AOAM533hhcoNLKkMfNIDm+YyxJ0Yijs7p9Z3mNmNqv5EufsKAnTmq1xU
        udk9HJ2iRLrBnN47+T5f0NYFJw==
X-Google-Smtp-Source: ABdhPJwhgswbKovs42U/OOB3jrsphvWgiWeGGx/Ndgg+PiZwOxz9VRZzNcHr7attqnGpMmMwTpFNaQ==
X-Received: by 2002:aa7:9736:: with SMTP id k22mr5465615pfg.62.1594756238551;
        Tue, 14 Jul 2020 12:50:38 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g8sm16736689pgr.70.2020.07.14.12.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:50:38 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/9] remoteproc: Add new RPROC_DETACHED state
Date:   Tue, 14 Jul 2020 13:50:27 -0600
Message-Id: <20200714195035.1426873-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
References: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new RPROC_DETACHED state to take into account scenarios
where the remoteproc core needs to attach to a remote processor
that is booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 include/linux/remoteproc.h            | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 52b871327b55..264759713934 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -72,6 +72,7 @@ static const char * const rproc_state_string[] = {
 	[RPROC_RUNNING]		= "running",
 	[RPROC_CRASHED]		= "crashed",
 	[RPROC_DELETED]		= "deleted",
+	[RPROC_DETACHED]	= "detached",
 	[RPROC_LAST]		= "invalid",
 };
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e7b7bab8b235..21182ad2d059 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -400,6 +400,8 @@ struct rproc_ops {
  * @RPROC_RUNNING:	device is up and running
  * @RPROC_CRASHED:	device has crashed; need to start recovery
  * @RPROC_DELETED:	device is deleted
+ * @RPROC_DETACHED:	device has been booted by another entity and waiting
+ *			for the core to attach to it
  * @RPROC_LAST:		just keep this one at the end
  *
  * Please note that the values of these states are used as indices
@@ -414,7 +416,8 @@ enum rproc_state {
 	RPROC_RUNNING	= 2,
 	RPROC_CRASHED	= 3,
 	RPROC_DELETED	= 4,
-	RPROC_LAST	= 5,
+	RPROC_DETACHED	= 5,
+	RPROC_LAST	= 6,
 };
 
 /**
-- 
2.25.1

