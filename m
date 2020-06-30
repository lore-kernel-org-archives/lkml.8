Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF51C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645B6206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuGM2xep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbgF3Nw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388433AbgF3Nve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC82C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so20291842wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHtif/VrKAdzD8tANDBuK+rW4l81OqvLbxPsir5m1XU=;
        b=BuGM2xep6RhwyJLaKYzA1LY0lnzmDeGISBQyDgjvCCdB4uSlbOdhNjGAIySKO9kXcw
         EH5QjQGaJnt54u7lAG8VzxejktsK+98Wo5238OHW0RywWUP5rBq2uyhK/qSQHmIwsBg2
         jrEMTHQ5+VsIcWGiCUsmbojJN34+WqZ9qjPytbo4FwL2egqnP/No/6NFT6lmqv0+yiwS
         Qpv4gaucJzpQNMNKa/p+tsrpe8i84+0GV1LqzrHqVpfwVDLzCjesyVU7P8PECRQpmdM3
         UkLtQ42eRaVhx+y7ydAuqsU/5zQa3TrZiLpMyY3/0iiOwVnw8XocpSuHG5POF1wpRtJ2
         rxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHtif/VrKAdzD8tANDBuK+rW4l81OqvLbxPsir5m1XU=;
        b=kaBF7bpiQ+zcPIU1X8BuG1WiBfFLfkCps9cbY99AYmBAxbqiQCU2X2gEUYVI5yzWwV
         BRVaHi6WFKLJR+8kGxf3dvNEyYNuP0whM5Unh0SMGRrRH++k57f/rSP87CM/H3IR9jpm
         /tH4gHUJn635M9dUG2SbZ70HiCimqXv/niUMzO/gWq9IdWCCVYNRpf3L+Bn1MRkiiB8g
         se1aKqc/jMj6e17AsfZu3j2Yi0NEkCjyaJtBkp2f6eWD2lPs+Fe6NoSvYsJeTloiGjdY
         tqYuMfS85KoaFJu0n2lwXgd1AtzwvmlaiOlWigggxcY2KkM0XDQw/3orNwTimWfPySrO
         zOCA==
X-Gm-Message-State: AOAM531mFpvpeo8zBWoPS2quKnjl7eeio2JsmfygRa1qi1Y4FpUHTK7c
        EKKpAFFSr6xXCUSZ3HAai+PjLQ==
X-Google-Smtp-Source: ABdhPJwW+1Hk4BGrbmmXevBy2713hmUjyPmxt1lmCevbhbcXJYipCFBTuWS3WioQoS/mcYj09qQiXw==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr21150324wrw.194.1593525092319;
        Tue, 30 Jun 2020 06:51:32 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 17/30] misc: mic: cosm: cosm_debugfs: Demote function headers from kerneldoc
Date:   Tue, 30 Jun 2020 14:50:57 +0100
Message-Id: <20200630135110.2236389-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/mic/cosm/cosm_debugfs.c:25: warning: Function parameter or member 's' not described in 'log_buf_show'
 drivers/misc/mic/cosm/cosm_debugfs.c:25: warning: Function parameter or member 'unused' not described in 'log_buf_show'
 drivers/misc/mic/cosm/cosm_debugfs.c:78: warning: Function parameter or member 's' not described in 'force_reset_show'
 drivers/misc/mic/cosm/cosm_debugfs.c:78: warning: Function parameter or member 'pos' not described in 'force_reset_show'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/cosm/cosm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/cosm/cosm_debugfs.c b/drivers/misc/mic/cosm/cosm_debugfs.c
index 68a731fd86dee..cb55653cf1f92 100644
--- a/drivers/misc/mic/cosm/cosm_debugfs.c
+++ b/drivers/misc/mic/cosm/cosm_debugfs.c
@@ -15,7 +15,7 @@
 /* Debugfs parent dir */
 static struct dentry *cosm_dbg;
 
-/**
+/*
  * log_buf_show - Display MIC kernel log buffer
  *
  * log_buf addr/len is read from System.map by user space
@@ -68,7 +68,7 @@ static int log_buf_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(log_buf);
 
-/**
+/*
  * force_reset_show - Force MIC reset
  *
  * Invokes the force_reset COSM bus op instead of the standard reset
-- 
2.25.1

