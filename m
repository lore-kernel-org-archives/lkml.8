Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2561C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7FF2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kFD/V16e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgEOSon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgEOSol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:44:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF040C05BD0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:44:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so1291538pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ma8a3IEAfy5hkhHsO5eKEOmN1t9cPUU6UBCxHjpj29E=;
        b=kFD/V16eJ50vNYvQlv772jPHRykPYjlwl1Um5D+Hle7uWzCtgZBfQwS/KwK/nZTCfr
         j7KkvjVgSES0XLwXjE9WlI7wIu/Nf8fUAlNzwExUrzHOkC2R1ilVSTKU/mq7IEzMjFjU
         4aduh2ic/Jzv/txp6IEmmoGgNg+5FXR5uWH8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ma8a3IEAfy5hkhHsO5eKEOmN1t9cPUU6UBCxHjpj29E=;
        b=eaac0SvN9p7DjGSHY4FXQn2HL3smkoOTOIpnbUsLA9UoiLiQboOp6+RXEo3PKIGF/V
         +5jnUJx9IisrZHofeYt6wiQWvccjArQlI/mc7YJcOiwGUiJF1ZazUs8vy3/Dd13qsCws
         bCR0IiyakVtoZSIPXF65BFKy7iDAh1LjUVX6svAUT6m1xrqReH5x89lmPKy7DFlelxM8
         5hubWU7C2xh6YHm5p/505XArcAERwKT7VHGWnN/VC1ODrwetIoHukT+fUKvcl9CeU/bq
         DMMRrXtGpStYFC17i/Kh/j0ZOGZp1OFapDANsk93DzlTb7N3/8wT/MXh0fsYyXn+LMCN
         wKXg==
X-Gm-Message-State: AOAM53136ecuH1GTmC+AR+E2BhxwNYbng5mFxw+d4B+QMLyzMY1PQm6p
        JYWGIJLcd/PMt92b8Ys5tI+o5Q==
X-Google-Smtp-Source: ABdhPJxrmBmEg335hMMKhTsZxipJMSKlq5GwMgh5rKfEUwuGPTZ3/FFaBx7j/3lkOTeALmalHA9y/g==
X-Received: by 2002:a17:90b:41d5:: with SMTP id jm21mr4562657pjb.96.1589568280507;
        Fri, 15 May 2020 11:44:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t20sm2075905pjo.13.2020.05.15.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:44:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 4/6] pstore/platform: Pass max_reason to kmesg dump
Date:   Fri, 15 May 2020 11:44:32 -0700
Message-Id: <20200515184434.8470-5-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515184434.8470-1-keescook@chromium.org>
References: <20200515184434.8470-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@soleen.com>

Add a new member to struct pstore_info for passing information about
kmesg dump maximum reason. This allows a finer control of what kmesg
dumps are sent to pstore storage backends.

Those backends that do not explicitly set this field (keeping it equal to
0), get the default behavior: store only Oopses and Panics, or everything
if the printk.always_kmsg_dump boot param is set.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Link: https://lore.kernel.org/lkml/20200506211523.15077-3-keescook@chromium.org/
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c   | 4 +++-
 include/linux/pstore.h | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 5e6c6022deb9..a9e297eefdff 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -595,8 +595,10 @@ int pstore_register(struct pstore_info *psi)
 
 	pstore_get_records(0);
 
-	if (psi->flags & PSTORE_FLAGS_DMESG)
+	if (psi->flags & PSTORE_FLAGS_DMESG) {
+		pstore_dumper.max_reason = psinfo->max_reason;
 		pstore_register_kmsg();
+	}
 	if (psi->flags & PSTORE_FLAGS_CONSOLE)
 		pstore_register_console();
 	if (psi->flags & PSTORE_FLAGS_FTRACE)
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index f6f22b13e04f..eb93a54cff31 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -96,6 +96,12 @@ struct pstore_record {
  *
  * @read_mutex:	serializes @open, @read, @close, and @erase callbacks
  * @flags:	bitfield of frontends the backend can accept writes for
+ * @max_reason:	Used when PSTORE_FLAGS_DMESG is set. Contains the
+ *		kmsg_dump_reason enum value. KMSG_DUMP_UNDEF means
+ *		"use existing kmsg_dump() filtering, based on the
+ *		printk.always_kmsg_dump boot param" (which is either
+ *		KMSG_DUMP_OOPS when false, or KMSG_DUMP_MAX when
+ *		true); see printk.always_kmsg_dump for more details.
  * @data:	backend-private pointer passed back during callbacks
  *
  * Callbacks:
@@ -179,6 +185,7 @@ struct pstore_info {
 	struct mutex	read_mutex;
 
 	int		flags;
+	int		max_reason;
 	void		*data;
 
 	int		(*open)(struct pstore_info *psi);
-- 
2.20.1

