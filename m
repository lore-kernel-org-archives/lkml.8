Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CCC20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHDE9VxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHXWKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXWKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:10:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56A9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:10:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y8so407937wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKIAqnSpzo+UVokQnr5oiZSy5S5wN2srKiBJQKhCS70=;
        b=JHDE9VxSuQ8s80V6rH9hA2LdpRvhR7X4vsgl8Mw9qJSSfJdDFJBEybOFU8GASiitCz
         tc6Z+rvDG4PFrl76Lvabx9JThMrycvBjlSPt5Q+yaaA03AID3ozJh/Hvwx7r6+kDokzD
         SJNAIM1fcp3aVGCQ1um/W2VjMuEKi2XoabKF/zEoc4lVE3ajBek9Z7+Zvb066Qrq5BAT
         D+4I6aIra8+I8ieae3OC5M/IXKUnumBdnziLPqaMoocnnxwkqxKpPQPmT9TEqHXJyNtX
         vW0U4sUPbW4MYK5TrQ+0PzQMF7G21rn+PY3F3zcIx5D6G6EiiMG2wmrV1k8pdnr2uWwG
         NGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKIAqnSpzo+UVokQnr5oiZSy5S5wN2srKiBJQKhCS70=;
        b=tRUJ4iZ/oSnxZtUyMaGcPF+X8dedZJueuX/ZAcw6s6bDvl4nEplZVhTVtDXUPpJ/wW
         9T+COpZ4QgSRAM3zQJ42Ipsl7TcIybPT4Qf2WYeWsEeRNnFlRbm86NKGP7XJKiV78eVh
         IF4VkUSaobplbbhM5EgtIYOzfleOFni+qht4tdm/D0dyxxXwhBSomfDB+M9lsEmwtLsE
         07ARFgb26e5YWwXnvbgYoS5a+6XRYwFxIY1CKUul74y03qC2hRyamS0/9FxXrO2BjzFy
         vPnqj0+1plwuaOW5PBON0vgofS8bUG4rmVwo2GUQL4emy9jOw9GlGD5IBaVMG9064Dz1
         c+Gg==
X-Gm-Message-State: AOAM532fB61VlZZW5LlQ68ri9NNECqIGxYM9e4VEptsj/U63eLEROYHu
        oP4TXOIKZvuVbtTO7XVCTSw=
X-Google-Smtp-Source: ABdhPJzFWz7lf0v1zLz4EI/W+JB25OgULHaG9e5pzJPGWNScynSV16r7YdENviCh+s3uBXml/qvMyg==
X-Received: by 2002:a1c:a5ca:: with SMTP id o193mr1228547wme.106.1598307037328;
        Mon, 24 Aug 2020 15:10:37 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id v16sm1727175wmj.14.2020.08.24.15.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:10:36 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/cpu.c: don't use snprintf() for sysfs attrs
Date:   Mon, 24 Aug 2020 23:10:29 +0100
Message-Id: <20200824221030.20103-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the documentation (Documentation/filesystems/sysfs.rst),
snprintf() should not be used for formatting values returned by sysfs.

In these two instances, we know that the string will be <PAGE_SIZE in
length, so just use sprintf().

Issue identified by Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17d..31694e02df958 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2334,7 +2334,7 @@ show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	const char *state = smt_states[cpu_smt_control];
 
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+	return sprintf(buf, "%s\n", state);
 }
 
 static ssize_t
@@ -2348,7 +2348,7 @@ static DEVICE_ATTR(control, 0644, show_smt_control, store_smt_control);
 static ssize_t
 show_smt_active(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
+	return sprintf(buf, "%d\n", sched_smt_active());
 }
 static DEVICE_ATTR(active, 0444, show_smt_active, NULL);
 
-- 
2.28.0

