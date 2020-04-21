Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EE7C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F03F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bdyu02Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDUR3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUR3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:29:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7BFC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:29:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p25so6881670pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVYI5ICB5urRwCiEKEsrZsgSBdOAp7Q1BybFEwxk1MY=;
        b=Bdyu02TzxklPP0TB3BoF1quh0CtPMseNtuAFqVjUylSjchszA4OBQjBI98FdBY3/EG
         Abe0ohLTbZPTPfHdGUq1+raoQkpl5VOUXHuoQbxrVYIQ7m3N4Cv+bxv6jYDVL8xvA2e/
         dMLsHPT3mpCTc2rovDugTKtszAGZXWKvpOWsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVYI5ICB5urRwCiEKEsrZsgSBdOAp7Q1BybFEwxk1MY=;
        b=ZBFZGRyWn9xksr0Wtqh8HFrEKuSB2Bl4q3t9GzrBFiz3mvYu8X9QD6S9GrAP8EAKvT
         uA49E2HEa7ufshzENucuFW5qTNC/7bUwcaq7t7CodYuF6Bi6rmvd+rhVSC4bw7ZPW5AA
         lZ8/4csV3YmZDmjDqSKEfzenz5NsWxUqZ7nL9JkyeH4iDr/rbnCPqIO5B7zdHVZ/ukPK
         8F5dfwdPbQK2g6PVxW8SlGqoQL5IlrtvUGWZhDhXQ/o44tvlvujmBHpHpDagodsnljYO
         iaxVoZgdKJEXRsWOsdvI7MnXnX60I6ACX3Wo5wd9AJU5N98P/VnZ+aPaMyMsigExro/h
         7FAA==
X-Gm-Message-State: AGi0PuZZiZp8VDdNFmS3OUXglEyp+jWvS1YTlDGF5sJ+5TRtjTlPQAuH
        /wGv95AIsRU11L8LUbydKsaE6w==
X-Google-Smtp-Source: APiQypIHW6s1M++qzJu4cJDKej0+9qMzOjkBYCdRxRmcpV3ApRwCqt5n4TxNr28xFSRAouniWQot3w==
X-Received: by 2002:a63:1759:: with SMTP id 25mr12356368pgx.417.1587490187855;
        Tue, 21 Apr 2020 10:29:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v127sm2874816pfv.77.2020.04.21.10.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 10:29:47 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mkshah@codeaurora.org, swboyd@chromium.org, mka@chromium.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] kernel/cpu_pm: Fix uninitted local in cpu_pm
Date:   Tue, 21 Apr 2020 10:29:06 -0700
Message-Id: <20200421102745.v3.1.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_pm_notify() is basically a wrapper of notifier_call_chain().
notifier_call_chain() doesn't initialize *nr_calls to 0 before it
starts incrementing it--presumably it's up to the callers to do this.

Unfortunately the callers of cpu_pm_notify() don't init *nr_calls.
This potentially means you could get too many or two few calls to
CPU_PM_ENTER_FAILED or CPU_CLUSTER_PM_ENTER_FAILED depending on the
luck of the stack.

Let's fix this.

Fixes: ab10023e0088 ("cpu_pm: Add cpu power management notifiers")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3: None
Changes in v2:
- ("Fix uninitted local in cpu_pm") new for v2.

 kernel/cpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index cbca6879ab7d..44a259338e33 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -80,7 +80,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
  */
 int cpu_pm_enter(void)
 {
-	int nr_calls;
+	int nr_calls = 0;
 	int ret = 0;
 
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
@@ -131,7 +131,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_exit);
  */
 int cpu_cluster_pm_enter(void)
 {
-	int nr_calls;
+	int nr_calls = 0;
 	int ret = 0;
 
 	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
-- 
2.26.1.301.g55bc3eb7cb9-goog

