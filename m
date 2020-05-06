Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA36AC54E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0452076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S/mEnu3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgEFVPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729874AbgEFVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:15:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E36C03C1AC
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 14:15:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so1768071pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=chFldJtd9FZjzbEOKxRp4afLji7Q0KWB7xH1iew90NQ=;
        b=S/mEnu3JzGQtRBXs6n9QXncOVmnbQq5t6M+sR4E32zK1XQYrOvego5aed1mRWjWncD
         2tz1H1BntWuhAGtE8PEzDVxsKZM8F+q25AZZvc/5qRzX9brUtk0LKP5YKdTqsHcD225t
         2I8vdCiNeAzvK/vHZdIP//OSwMWXpu7JLGw6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=chFldJtd9FZjzbEOKxRp4afLji7Q0KWB7xH1iew90NQ=;
        b=tbqdBuVxEyJjk67vLNf5B5TzHDoxBYoAG7zxjcUiOFLb2m59bHy5u6OJXV/N/B9Nwb
         eVQb2QCb8tbr2IEa3RPa4/U9ttgoJivjd7Y9Z5CQmuJQpLCutlNLD3Em4bMlQnl3sL5H
         iQ4KWZuEQmYSbeL+kQfyNLmaeAEEIlQ9KZDvlA/ZcDggmI9ehb6EDFVBptCiAXkFOgCG
         17vHtijgS3sS+IpNwgtLumDwKSsQAKf7uODIqVO6YSvIQrziOIKix47QFH9k76D3+4N1
         k10AOZtopyVPVwxOzX17LTcnfNjpTJTO5G9887CuODvGP/ozsWiWHSkXJ+Vss0brj/Ar
         Kglw==
X-Gm-Message-State: AGi0PuavjvrhVEvqGuTvCRzv6Rge7d5ci7aE2EgNaOItkbrCcUM4ypfE
        cPIFdT48ZuZN01RVpDrujELrwOu/j6c=
X-Google-Smtp-Source: APiQypL79U0P8ow991LVqZap9gP1MBGKTzXY+mx8OTkdpEaV+3APK2IHBhp+sM3C67hWTQ9LY7fOoQ==
X-Received: by 2002:aa7:94a3:: with SMTP id a3mr10431378pfl.101.1588799735085;
        Wed, 06 May 2020 14:15:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y25sm2367440pgc.63.2020.05.06.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 14:15:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, jmorris@namei.org,
        sashal@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 6/6] pstore/ram: Adjust module param permissions to reflect reality
Date:   Wed,  6 May 2020 14:15:23 -0700
Message-Id: <20200506211523.15077-7-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506211523.15077-1-keescook@chromium.org>
References: <20200506211523.15077-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple module parameters had 0600 permissions, but changing them would
have no impact on ramoops, so switch these to 0400 to reflect reality.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b8dac1d04e96..1de9d68d5c24 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -53,7 +53,7 @@ MODULE_PARM_DESC(mem_size,
 		"size of reserved RAM used to store oops/panic logs");
 
 static unsigned int mem_type;
-module_param(mem_type, uint, 0600);
+module_param(mem_type, uint, 0400);
 MODULE_PARM_DESC(mem_type,
 		"set to 1 to try to use unbuffered memory (default 0)");
 
@@ -68,7 +68,7 @@ MODULE_PARM_DESC(max_reason,
 		 "maximum reason for kmsg dump (default 2: Oops and Panic) ");
 
 static int ramoops_ecc;
-module_param_named(ecc, ramoops_ecc, int, 0600);
+module_param_named(ecc, ramoops_ecc, int, 0400);
 MODULE_PARM_DESC(ramoops_ecc,
 		"if non-zero, the option enables ECC support and specifies "
 		"ECC buffer size in bytes (1 is a special value, means 16 "
-- 
2.20.1

