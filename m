Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D630C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767AB21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lMzLpPm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDVVz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgDVVz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:55:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43195C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:55:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so1829971pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfuhF99BRaSEh0bfmWqr7aSzcTnP1RLVseb4QVvFXi8=;
        b=lMzLpPm6h+VTQ1aXb2wCKeBILA8eBpvnCjaMmppBWioTLLm56Fars7TegBE981Y4qa
         UOdGk+wGv/kTK/aZzPeroP9IgG2TaeCkUoP1xJdMwgQA8t3RJcynzQndzKK/IT/4kFLc
         GPomLauJym/7f+mCx5tyPC+qCW8zVmC1mK/kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfuhF99BRaSEh0bfmWqr7aSzcTnP1RLVseb4QVvFXi8=;
        b=Fbi9yNiFSMajr5HOFIThNI8eRvGbaGv3jpLXMamrsrSJh/LsiAhIY837LIhWQhC+UM
         wd4ue58CYFWSN9aUsfXqSRdub2HPfHkD0v3JETBvR8AfYvAbqQZwysbXNBY1yAp76aYE
         5/RjPKJo/WOEDEaWyCXTxqhK1nOXs0c/woFdoqhTjH5/lOiDQY1MqVc2p1rO9Eb12xSl
         1/KuyJLeSLO5f2FBxrz6hqzYTENkgBDC2nZ+6/bb0rpE0she5kAzx9E7dn8RfBr3CRSd
         I1zYXYJ/nzonIcbCalK8qTUbIWygkaKxK46Woj5XhkXz7iftEw1Husjs8xzVYkPnws+6
         cdOQ==
X-Gm-Message-State: AGi0PubbyyV/6KnbrIM+jeEuzSeGTRzzPVC3ZMlMOZQLBSXg4mROYPE4
        Mjev48RGzmtUn6IdxO/G/CjLRg==
X-Google-Smtp-Source: APiQypIMZx29EYw/LuKiakgkcK5iD2peotdc67FckTndEWYZzYUjvYUqWxgImzq3lAvbHw2Tfn3gYw==
X-Received: by 2002:a63:df42:: with SMTP id h2mr1118598pgj.216.1587592525841;
        Wed, 22 Apr 2020 14:55:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r4sm211072pgi.6.2020.04.22.14.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 14:55:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, swboyd@chromium.org, mkshah@codeaurora.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] soc: qcom: rpmh-rsc: We aren't notified of our own failure w/ NOTIFY_BAD
Date:   Wed, 22 Apr 2020 14:55:00 -0700
Message-Id: <20200422145408.v4.2.I1927d1bca2569a27b2d04986baf285027f0818a2@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
References: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a PM Notifier returns NOTIFY_BAD it doesn't get called with
CPU_PM_ENTER_FAILED.  It only get called for CPU_PM_ENTER_FAILED if
someone else (further down the notifier chain) returns NOTIFY_BAD.

Handle this case by taking our CPU out of the list of ones that have
entered PM.  Without this it's possible we could detect that the last
CPU went down (and we would flush) even if some CPU was alive.  That's
not good since our flushing routines currently assume they're running
on the last CPU for mutual exclusion.

Fixes: 985427f997b6 ("soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("...We aren't notified of our own failure...") split out for v4.

Changes in v3: None
Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 3571a99fc839..e540e49fd61c 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -823,6 +823,10 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
 		ret = NOTIFY_OK;
 
 exit:
+	if (ret == NOTIFY_BAD)
+		/* We won't be called w/ CPU_PM_ENTER_FAILED */
+		cpumask_clear_cpu(smp_processor_id(), &drv->cpus_entered_pm);
+
 	spin_unlock(&drv->pm_lock);
 	return ret;
 }
-- 
2.26.1.301.g55bc3eb7cb9-goog

