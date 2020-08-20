Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237FCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C0A2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f53NuOrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHTJPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgHTJOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:14:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA87C061343
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:14:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so708553pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKNU74NJdZK5cyzQFbM7uQHSgaBwB5CboR+e0oglByo=;
        b=f53NuOrsS3mDzLLgHf/lVcMv2rI0XJgW2xMiLctDDBFzrksxOqhcTxm1XIVQnBQkE5
         +kMAMDdXzLKtSit04ro2JszrQPyd+kMW6DQyX3Fqi5F4PZDe779pikdz44FcUDrjmvQc
         jjFTXmzw429GB5mNaBH2Jij5WbpAtdFvjw+D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKNU74NJdZK5cyzQFbM7uQHSgaBwB5CboR+e0oglByo=;
        b=h3STQDsZxd9yoh9nO7iE/KqpHysdsbAT43hxMXXVI8n2KrhfAuvuFbpVeWarAxJ5Ai
         G7OnI6fBhjUze8M3z+oQUjSwAh3BbtpqVtSyjAPu7GMHcdlTZ2ZN8ol5vGN4Q+MY5p6L
         JhqPgmOFQguRwjE0YdsB/v4LuN3Qo937XDCvNCGC6LkE451W1sYkaucLG43W7rXsjOUh
         aiolyzPiRT6ckpJ32X70qr8ALMsfzgulp23MnRm5fvYmzFrA9JpIHQ3LCc5BujrnMN4+
         xMKGp7BgJEAwW3yD2N2W3zRW9KXY3v/lSJtxsdb74Cpq8FkbEiLtr6mN1hLn++gmTy7H
         8Wkg==
X-Gm-Message-State: AOAM532+t0SmuCXPZCxJlRnWRMgGnuUm8+e2epTBhOg6vSSGmJQorrT5
        Sf5DQco/OtxR/l+aA2NTSaQ9zA==
X-Google-Smtp-Source: ABdhPJxP50eTeBITIcRQC6yWdtCxNMHAvn0Wises0b5yFF9JV14XlN/Ry4qvDKlv1dBi9YhOxSAgjA==
X-Received: by 2002:a62:7bcf:: with SMTP id w198mr1569326pfc.90.1597914866996;
        Thu, 20 Aug 2020 02:14:26 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id o15sm1954448pfu.167.2020.08.20.02.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 02:14:26 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v4 3/3] media: atomisp: Only use trace_printk if allowed
Date:   Thu, 20 Aug 2020 17:14:12 +0800
Message-Id: <20200820170951.v4.3.I066d89f39023956c47fb0a42edf196b3950ffbf7@changeid>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200820170951.v4.1.Ia54fe801f246a0b0aee36fb1f3bfb0922a8842b0@changeid>
References: <20200820170951.v4.1.Ia54fe801f246a0b0aee36fb1f3bfb0922a8842b0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We added a config option CONFIG_TRACING_ALLOW_PRINTK to make sure
that no extra trace_printk gets added to the kernel, let's use
that in this driver to guard the trace_printk call.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Technically, we could only initialize the trace_printk buffers
when the print env is switched, to avoid the build error and
unconditional boot-time warning, but I assume this printing
framework will eventually get removed when the driver moves out
of staging?

 drivers/staging/media/atomisp/pci/atomisp_compat_css20.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index 1b2b2c68025b4cc..020519dca1324ab 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -165,11 +165,13 @@ static int atomisp_css2_dbg_print(const char *fmt, va_list args)
 	return 0;
 }
 
+#ifdef CONFIG_TRACING_ALLOW_PRINTK
 static int atomisp_css2_dbg_ftrace_print(const char *fmt, va_list args)
 {
 	ftrace_vprintk(fmt, args);
 	return 0;
 }
+#endif
 
 static int atomisp_css2_err_print(const char *fmt, va_list args)
 {
@@ -865,9 +867,11 @@ static inline int __set_css_print_env(struct atomisp_device *isp, int opt)
 
 	if (opt == 0)
 		isp->css_env.isp_css_env.print_env.debug_print = NULL;
+#ifdef CONFIG_TRACING_ALLOW_PRINTK
 	else if (opt == 1)
 		isp->css_env.isp_css_env.print_env.debug_print =
 		    atomisp_css2_dbg_ftrace_print;
+#endif
 	else if (opt == 2)
 		isp->css_env.isp_css_env.print_env.debug_print =
 		    atomisp_css2_dbg_print;
-- 
2.28.0.220.ged08abb693-goog

