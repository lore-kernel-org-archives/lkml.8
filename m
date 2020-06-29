Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE2AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4678B2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c9p9Gar7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbgF2Tnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbgF2Tmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C413CC03140F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:15:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so17314028wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdmyDXtA8EIM1jxYalqYHcGVicYKfXEl1rpwhzYY7yY=;
        b=c9p9Gar7D2nXzpz2YR/ib39Abgv4y6hEa91cr786gH8hhBcc2XHPgejdMauKVSCXyw
         EgAsOWswu0yM60MBbUpqEjXeok6FXbZK3cY12YvSpijtvD0BGihf4HyPCLh9I970OF+w
         78MwbI9PqGOns9VkUov0ZQ9RbuCV+fwXeAcEtPspxUT9Uk7UyYJvZDXRhVlIPAhOgy1r
         0ebCtAluvcdaAZtdvp/iG7aZAmwyeaGzf8o6royVXgBp6bmZYTZ+EEf7K6vitzPvHvWn
         wVU1xmaE5kyGW65gr+wCRjIx7La2Aae9t0Re8V+Heu0ZC4EarsLzwXx5hOPENYGaf8DM
         nFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdmyDXtA8EIM1jxYalqYHcGVicYKfXEl1rpwhzYY7yY=;
        b=PrGPzt9o5OGEqMKcEQT4O6DvCaufkq6Nhn5vLtGywb0g4oJMqS56T4IUcJNb5sENhm
         QqVk68ohR6yL4lMsbFnWKD/DpwktTe0Z5Om7DKcI4Mrg0l+6OiXcF313tpG9GjuKnp/i
         hGcrC4aDovDaqeCTXeO07NhJA47CWpzNgtpf2lXVSOsSEbx0CpVX2gSpVdzfd2LGjc9P
         E8vkwFAJN09sL6Ek+P9KY4N5Zfd5dQUaw9dEf2GHDPyKmj3DOcc9G9ErIsia8wNcdy/P
         T62YNYzW1nQNfNNQ315EBH8YZncnBWgZZJ2VVux5v/aTuXlHLOh/TfP2rw8va+Ou07aW
         O92Q==
X-Gm-Message-State: AOAM533Cph6rDZCDgz+vgN/kXn1X1oomALLT5FZ/5z75mbMWigtppnKR
        xjtJFe0aKyilqufWOsgtz72NFA==
X-Google-Smtp-Source: ABdhPJzs30159xRqcvLpbN8z4ChYHhI0ngFXg57huo/LOl0+OMOWqLHYtRb1FBzKVGwD5ZJ8obYgyw==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr7472015wrw.244.1593450943526;
        Mon, 29 Jun 2020 10:15:43 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g195sm517482wme.38.2020.06.29.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:15:42 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>, pmladek@suse.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH] kgdb: Resolve races during kgdb_io_register/unregister_module
Date:   Mon, 29 Jun 2020 18:15:29 +0100
Message-Id: <20200629171529.558003-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kgdb_register_callbacks() and kgdb_unregister_callbacks()
are called outside the scope of the kgdb_registration_lock. This
allows them to race with each other. This could do all sorts of crazy
things up to and including dbg_io_ops becoming NULL partway through the
execution of the kgdb trap handler (which isn't allowed and would be
fatal).

Fix this by bringing the trap handler setup and teardown into the scope
of the registration lock.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/debug_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 9e5934780f41..9799f2c6dc94 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1117,9 +1117,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)

 	dbg_io_ops = new_dbg_io_ops;

-	spin_unlock(&kgdb_registration_lock);
-
 	if (old_dbg_io_ops) {
+		spin_unlock(&kgdb_registration_lock);
 		old_dbg_io_ops->deinit();
 		return 0;
 	}
@@ -1129,6 +1128,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
 	/* Arm KGDB now. */
 	kgdb_register_callbacks();

+	spin_unlock(&kgdb_registration_lock);
+
 	if (kgdb_break_asap &&
 	    (!dbg_is_early || IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG)))
 		kgdb_initial_breakpoint();
@@ -1147,13 +1148,14 @@ void kgdb_unregister_io_module(struct kgdb_io *old_dbg_io_ops)
 {
 	BUG_ON(kgdb_connected);

+	spin_lock(&kgdb_registration_lock);
+
 	/*
 	 * KGDB is no longer able to communicate out, so
 	 * unregister our callbacks and reset state.
 	 */
 	kgdb_unregister_callbacks();

-	spin_lock(&kgdb_registration_lock);

 	WARN_ON_ONCE(dbg_io_ops != old_dbg_io_ops);
 	dbg_io_ops = NULL;

base-commit: 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
--
2.25.4

