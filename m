Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B832081A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i4OC8A2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgF3WPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgF3WPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:15:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA39DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:15:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so10034451pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NWmBv3YltHW/EEoBJLmtefyvNy5kBfRz96ALBdjJByA=;
        b=i4OC8A2NnoQYYhFSBzKGQhfcsUxIuhlLxYzhbhO1E47sANv4esb7YPdypZ78GCnRgJ
         R4jzgAYwWSLgPK+foOo5vg1fcGZCwmz6IxEXUqhm9Jmyp/DoO3nT+pFzaRt2dlwd/l2V
         Q6aloZ1x4QX4sslsEvkqFnwJgDRrYP2orzxqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NWmBv3YltHW/EEoBJLmtefyvNy5kBfRz96ALBdjJByA=;
        b=LyIU4t3ZtQlGyrNEOndTPfUY+ieJcOY631FAKACvmVMOFqjjJF1MlBz6CE1JZg9yQy
         cc8L8MeJmJ8m7xz4WKotkj3x1xkS4ZoZQqqP3D04NhQYLHJi3bxUp56QaIsc3CGUY4Ux
         E8QfLxRYD/Rd4LQsG2ZhqOkpm+MqXBVqTNprCeLTu1dRk0DG/l+oviydPGKEzb7Zt0BS
         LXTDXOmdzeshSRw5jAincM1znGTOhjUNAQrClXNf/MUSt2SgAzG/QLlp487+1VRqAt4F
         LeZnyDla83ftaf42LFygO6e20t7SZEN2mMoXyjUOei9DahgpiQbnTcv9a5UOsmuBwxXO
         3DNw==
X-Gm-Message-State: AOAM532RgYunz6uMGDJBRYv4632TMRrMoyj9Uaoax2fk9UVW/wbH3L8Y
        oFv9m/CcQ3buscbXTXnbAnBgFZYf19g=
X-Google-Smtp-Source: ABdhPJyKHa6qXWttCDJwtRhEezmQHkbESqhRkjZuyuXJBFKcn94rvb/rNTut0m0nWQjac2Zjcwk1fA==
X-Received: by 2002:aa7:8ac3:: with SMTP id b3mr22179202pfd.45.1593555305183;
        Tue, 30 Jun 2020 15:15:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id n12sm3611295pgr.88.2020.06.30.15.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 15:15:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kgdb: Make "kgdbcon" work properly with "kgdb_earlycon"
Date:   Tue, 30 Jun 2020 15:14:38 -0700
Message-Id: <20200630151422.1.I4aa062751ff5e281f5116655c976dff545c09a46@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my system the kernel processes the "kgdb_earlycon" parameter before
the "kgdbcon" parameter.  When we setup "kgdb_earlycon" we'll end up
in kgdb_register_callbacks() and "kgdb_use_con" won't have been set
yet so we'll never get around to starting "kgdbcon".  Let's remedy
this by detecting that the IO module was already registered when
setting "kgdb_use_con" and registering the console then.

As part of this, to avoid pre-declaring things, move the handling of
the "kgdbcon" further down in the file.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/debug_core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 9e5934780f41..03d5b17347da 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -94,14 +94,6 @@ int dbg_switch_cpu;
 /* Use kdb or gdbserver mode */
 int dbg_kdb_mode = 1;
 
-static int __init opt_kgdb_con(char *str)
-{
-	kgdb_use_con = 1;
-	return 0;
-}
-
-early_param("kgdbcon", opt_kgdb_con);
-
 module_param(kgdb_use_con, int, 0644);
 module_param(kgdbreboot, int, 0644);
 
@@ -920,6 +912,20 @@ static struct console kgdbcons = {
 	.index		= -1,
 };
 
+static int __init opt_kgdb_con(char *str)
+{
+	kgdb_use_con = 1;
+
+	if (kgdb_io_module_registered && !kgdb_con_registered) {
+		register_console(&kgdbcons);
+		kgdb_con_registered = 1;
+	}
+
+	return 0;
+}
+
+early_param("kgdbcon", opt_kgdb_con);
+
 #ifdef CONFIG_MAGIC_SYSRQ
 static void sysrq_handle_dbg(int key)
 {
-- 
2.27.0.212.ge8ba1cc988-goog

