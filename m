Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B2BC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A782168B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JG4Xp5iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgDVVz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVVzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:55:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD7C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:55:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so1817784pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcN3ZrHWXlIPIuh298G1lUnACYhPjzKzp7jscayIaS4=;
        b=JG4Xp5iAXo+CrWZdn/y4r+OZsOjzrMLbL1ltQWdthqarbD2q+yMDBjC/j/8ONTKO67
         izd7bl01J9AylLWiyA8vjPLcbySNq6/vcVFp/ymDArLe3+jWLxvoIZvbXLOiQsHhbcg5
         pGgNdAykwkPFFmQVqht88gJI6UEnach0gbPYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcN3ZrHWXlIPIuh298G1lUnACYhPjzKzp7jscayIaS4=;
        b=OSja9xEr4cyPg66zYApYkC9ZpqUwcHXzlzruIrtNDrYcnf0G3oQcXyWXQxY8GyYK6o
         /n8gpSfqBRcWIDZRDq34Morn4ZXUdxj5cD1vxwHdfptzlhZWCTm/Xpqs6GBhv15pWOOL
         39CjNMugmJQXs2V4CtPhxcW4TI2a/0SpO0F3inuBFti2MhwaRomz003V+aqnZnm+URbS
         E2shiAFRM09J5p4/COogIlLkeY/dwjhzV8cp4G265+FYnMWEISJ+j17UaakEKGnl2CMJ
         aZSlKKhm5jAiWjkEu4DiK5rDXNkF57RpH7rphW8OKKveSkNTFb4kXz3nyOX3hRhj613L
         HmmQ==
X-Gm-Message-State: AGi0PuY2oSBxhGV/vzWgAga3SlCOVTPi3jmChzETGARMGOg1ydTKN73+
        yj2DHi7IpMz11/Ccp51uPcsHUw==
X-Google-Smtp-Source: APiQypIPMIRi0bHMPdu9jfpd4s1/+Acupprv6NYFFFx0FXOFJvQM+mh4MegAtGry2e5FVLcca2uxgw==
X-Received: by 2002:a62:8202:: with SMTP id w2mr594501pfd.117.1587592524740;
        Wed, 22 Apr 2020 14:55:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r4sm211072pgi.6.2020.04.22.14.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 14:55:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, swboyd@chromium.org, mkshah@codeaurora.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] soc: qcom: rpmh-rsc: Corrently ignore CPU_CLUSTER_PM notifications
Date:   Wed, 22 Apr 2020 14:54:59 -0700
Message-Id: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
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
---

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
2.26.1.301.g55bc3eb7cb9-goog

