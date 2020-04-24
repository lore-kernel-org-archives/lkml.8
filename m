Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F8C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE5820728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QsUZIst0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgDXQrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6774AC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:47:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d17so4897304pgo.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LMkNBqXB+CeQceWfD+1N1s9IOWokLMqWssX/DZezGQ=;
        b=QsUZIst0n7NitTwTbPskwHB/A9M3npMfgM+TRceAN2YLnBjo7TiuFLgIDIAlNhloZQ
         Hhw57EsdqXMyumDsh1p+qtH9Zn5ICKQGQ58SLXj71jnWAYQwMA/6Pufm5DvprHi4Cef4
         rH4sHfsgJYbQ0P7x2TuhVvmMmpEyWPlY6KftQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LMkNBqXB+CeQceWfD+1N1s9IOWokLMqWssX/DZezGQ=;
        b=kn+S/KMJ2ILZdCOQR+MEYYhfaSOK/tjvewuecDEqk4NQLJGoWVsux2WX9e7YbdbU5U
         a6I6v0HOrvSwS5q6alOzopxLwD8Et/jux1rZf6ZPYaGh2UMtk4u2szLOnvWPzS7UZHk2
         sut6Hby0SwgaKTSlRFK0pKvsv4jrWYWCI5ou5X/dYQwyHT5fAA9ityeguUfg50nfop0q
         jOkCT590hHxrIOrERHzwtroQlMnIfEGyhhsfZof1geoC/whV9PotBY3liRL4XA2zWSUi
         2Biqx8bqXgON/4tj+p/5d2C9DQnE2zYuI7k5w0cMqHM0S/Ct/A9PF62vOdskuNg/gRbL
         AYyw==
X-Gm-Message-State: AGi0PuZC3DGAKeYFSKXfxdYDPHy2Je0qFK8yZqAD6lPPVOdcYCYaDVTk
        EHNvadUjvI6Gi2V1cIjjHPEJkj0FUHrbVg==
X-Google-Smtp-Source: APiQypJWdVuaFCmqhM/KqVMwq1a10HxnD754ZLgp0ghuRAORQk+vl0gQ1jCPIlxmNdNeTKvaSlm4aw==
X-Received: by 2002:a63:f30a:: with SMTP id l10mr10233893pgh.372.1587746838702;
        Fri, 24 Apr 2020 09:47:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r28sm6319205pfg.186.2020.04.24.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:47:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     evgreen@chromium.org, mka@chromium.org, mkshah@codeaurora.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] soc: qcom: rpmh-rsc: Correctly ignore CPU_CLUSTER_PM notifications
Date:   Fri, 24 Apr 2020 09:46:53 -0700
Message-Id: <20200424094610.v5.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our switch statement doesn't have entries for CPU_CLUSTER_PM_ENTER,
CPU_CLUSTER_PM_ENTER_FAILED, and CPU_CLUSTER_PM_EXIT and doesn't have
a default.  This means that we'll try to do a flush in those cases but
we won't necessarily be the last CPU down.  That's not so ideal since
our (lack of) locking assumes we're on the last CPU.

Luckily this isn't as big a problem as you'd think since (at least on
the SoC I tested) we don't get these notifications except on full
system suspend.  ...and on full system suspend we get them on the last
CPU down.  That means that the worst problem we hit is flushing twice.
Still, it's good to make it correct.

Fixes: 985427f997b6 ("soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches")
Reported-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5:
- Corrently => Correctly

Changes in v4:
- ("...Corrently ignore CPU_CLUSTER_PM notifications") split out for v4.

Changes in v3: None
Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index a9e15699f55f..3571a99fc839 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -806,6 +806,8 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
 	case CPU_PM_EXIT:
 		cpumask_clear_cpu(smp_processor_id(), &drv->cpus_entered_pm);
 		goto exit;
+	default:
+		return NOTIFY_DONE;
 	}
 
 	ret = rpmh_rsc_ctrlr_is_busy(drv);
-- 
2.26.2.303.gf8c07b1a785-goog

