Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA472C54E4A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB7520575
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ReH1KmW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgEGUJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728564AbgEGUJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:09:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DD3C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:09:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l12so2972677pgr.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1XDP2s0snxdLkMZdyukbleJr+uJ2UqLD4Yvp7W+lko=;
        b=ReH1KmW6+/YuI4vEH69rEwtrRWO5C8B9NVFXhM9HjZxD7wtQrMTH9qKyhAIpVmoOsm
         pJWravX1nnZSvRVcjDXlPsYk8CGgbnSgs/U+QzZhCnbMIq77X8tjlApJvXfDgzPLnxpC
         dI+uHqhKsxVPzpFQqLvMF+bqXAiQAAz1PumIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1XDP2s0snxdLkMZdyukbleJr+uJ2UqLD4Yvp7W+lko=;
        b=GX34bspqWiZZgy931wQjtZf+dtKZdz3/Y2kJ/p2vXRYP58WtSEiPF9P63W6OehRn6V
         ri84dHfFa6NRP6fmY53nG2dlhNuHjQJL5NCHZKoEVZHGx7ZlfvEelq4qINg6bpwHBixr
         8S+39nfIFYqvjvwwgZzyfhmLCVONct5bHQfYx+lxHC9lBXdBETR8kcjs48cxfju2Kg3C
         1jmc2i8cTmtktMnQQCxKBq+FKJ7Y/YU0IuKumzFuj0YfdACftBVmTL3c3ocePpnutC/o
         XgwRBc+PQBqpZEP9Iy9r3hwWdPZ1NhJBuLN9C/9i18QWF+LvCxO/qka5YLY4PrtzVE+y
         glqg==
X-Gm-Message-State: AGi0PuahTAHCUGu8Oc+mqyzqah+OM9xrHFz3NhuwfO4+idZm4mvt2J5X
        k0WPMl1M1CchWd7KehLz7/J8cA==
X-Google-Smtp-Source: APiQypKgAbnAivOMtSnMHwbQ3TDXgQaQ6YOXhF935haHfa4/tcGU8O7//3m/KM1t6hWHwzOPWSjJqg==
X-Received: by 2002:a63:585c:: with SMTP id i28mr12849420pgm.363.1588882147971;
        Thu, 07 May 2020 13:09:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d203sm5547601pfd.79.2020.05.07.13.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:09:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/12] kgdb: Prevent infinite recursive entries to the debugger
Date:   Thu,  7 May 2020 13:08:44 -0700
Message-Id: <20200507130644.v4.6.I89de39f68736c9de610e6f241e68d8dbc44bc266@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200507200850.60646-1-dianders@chromium.org>
References: <20200507200850.60646-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we detect that we recursively entered the debugger we should hack
our I/O ops to NULL so that the panic() in the next line won't
actually cause another recursion into the debugger.  The first line of
kgdb_panic() will check this and return.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v4: None
Changes in v3:
- ("kgdb: Prevent infinite recursive entries to the debugger") new for v3.

Changes in v2: None

 kernel/debug/debug_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 503c1630ca76..faf5bd4c34ee 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -532,6 +532,7 @@ static int kgdb_reenter_check(struct kgdb_state *ks)
 
 	if (exception_level > 1) {
 		dump_stack();
+		kgdb_io_module_registered = false;
 		panic("Recursive entry to debugger");
 	}
 
-- 
2.26.2.645.ge9eca65c58-goog

