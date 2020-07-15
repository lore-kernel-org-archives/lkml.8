Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7552CC433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2D820657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXIpCOcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgGOI06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgGOI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E076C08C5DE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so4495639wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDE1zUX/1JKQBQmQqlPliyHfkazrkQ232Ej5nXmiXwM=;
        b=zXIpCOcYgYHp1oI/hNnk7zY9h2vzxnyGom+gI1qtkY9gm2GpNzrjfPEFEUBPJH5UV6
         B6KQaI1nRCVuI+yN6eORsPiXeZ1pz3BSHbCy72HLtafEThX0+RoPRLneZigsJABeab59
         zdzPVLTA85+sxS8iafLaTVvgxWdhYc/5554JhGgByGNiv1rSVi/h1HH0DjGavC9IpM/N
         xhOMe26zXLdwfZOhKkZEvOA9PdP5EnV5oe8Ib/cVIjRGbWpg9829J9rA3vpuOfklOYV8
         spprCi/ti3c2ZogtRgF35Z0LCQrJWosGr7Xz/eHYISvhYS+lP1v8pf+RlvdSSzpCWpaI
         jjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDE1zUX/1JKQBQmQqlPliyHfkazrkQ232Ej5nXmiXwM=;
        b=V1pXrI29qle6WNnqT5ru9JLKjdi5/NWY/A8vZGD9Q+rmQnFPC7fS8+CW1m4EdTlaiq
         x0Sl7kioQIclXkeK4GZqTfpIVuU2AAcHofxk+Q5VkMH2+XvYytvkDzpCb8BzFBLXwdpg
         +Y0ChY3ZmZDXpr5UEVBIbMXwOJmHlQ4RDMHQ1uNtWfFt5YHschsX5RXafGfGzNIUeCUZ
         /5zsG1Um0XrfxeTt1JeQNw5edDmv+KYXAzLloi4rfxgIjHhmu3rKitNzQwa5a6Way8AT
         HeuLaAleJF+i12jB6fQnA+J/a3D61T6/e47MlZ61GzQq/YNF774Wloi1/FZ67N6unwx8
         ZYSw==
X-Gm-Message-State: AOAM530oszG1PJUSSYiV5mS9jIyIl1Ood4cxm1ZC24DrWxF7cjf3X2wf
        rwJqHumC11ZJF5AIgh1veHotaw==
X-Google-Smtp-Source: ABdhPJwYJSMFUV5PpASoPDrjaYIuPcrg9uZDlscqgtu4rQfld8dFTZRklyYJDtiqeHbOc4WUtFqVFg==
X-Received: by 2002:a1c:18b:: with SMTP id 133mr7513947wmb.178.1594801613334;
        Wed, 15 Jul 2020 01:26:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 12/13] cpufreq: intel_pstate: Supply struct attribute description for get_aperf_mperf_shift()
Date:   Wed, 15 Jul 2020 09:26:33 +0100
Message-Id: <20200715082634.3024816-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/intel_pstate.c:293: warning: Function parameter or member 'get_aperf_mperf_shift' not described in 'pstate_funcs'

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>
Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 44c7b4677675d..3960f971fdfb3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -275,6 +275,8 @@ static struct cpudata **all_cpu_data;
  * @get_min:		Callback to get minimum P state
  * @get_turbo:		Callback to get turbo P state
  * @get_scaling:	Callback to get frequency scaling factor
+ * @get_aperf_mperf_shift: Callback to get the APERF vs MPERF frequency
+ *			   difference
  * @get_val:		Callback to convert P state to actual MSR write value
  * @get_vid:		Callback to get VID data for Atom platforms
  *
-- 
2.25.1

