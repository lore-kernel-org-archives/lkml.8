Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45938C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2576420746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RJAhmm/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgEEPpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbgEEPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:45:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC64C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:45:18 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z90so2296993qtd.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bt0DgufcsJz1OM314/hgbkHGYcvgPdBdV4cmsuzCfo8=;
        b=RJAhmm/6ZfA0Pv85fCutLvizN4MHEWomBWvpRgCdNOxJkw6PWqfMm/L0VETcCv0bHR
         l/CHj69jtIsoAuniuEftdDIWqB718+c8fPAZgW0QkSScoazLVbcqqj3EnX5YnXuQwjLa
         gmX6efvgMKAu4YbjaRqKQimTZopoE8aCysKffqVx3QypBo02ug98k93xUYnP9+19Fa7t
         aKVcguDGzV+oZLgYvIqG27CRJoE0cLv9kXkChH2WZ1f9fYmmxNTRnuUiMiDWJCSMUg7s
         dOKK8gNw9Dg5H7I9PvJMXMQQEHR8euaGzxn7HlDOObuA0Z6YfVFvYNpk8bgf1AO6Palu
         CB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bt0DgufcsJz1OM314/hgbkHGYcvgPdBdV4cmsuzCfo8=;
        b=D6pqYCec3pJJzdDOPrrABwCJ4h55IH3ZzhL0sAUNHxtMZorvrcGHHYZkG4QIT73uXx
         eLbCI/b8/sudSWcZWCS1rxeun0inlmrh0oQH7xuBjUnxv54gQZO7RebzjHQW5nTd7W2r
         PkgXrzne4pD7cDuQOfeFW8vYa3SXMA1rk3lA2quLMjFyrtC6ahPjkM1yaWVO5WFYZsWC
         NOgrsSEY5762QofIjEAWxoeEFQbRWn+XfIO4BYu1B6WXQFfKNORbbm8jUU07SSxs97ub
         NzVW5s3hLB6p8XbZZQqE7qgyOX55xRG6VKMnzI0wCB3tbwqRi5AMEZaJzN6cLd0wfkwO
         aXEA==
X-Gm-Message-State: AGi0PuaktDgBDgJQIdZBnXscPtsa8bPEy60x9+pl8bSuqcTKqteL1Wpn
        KZu8fVKD/pIO2M3OwcB43Q6KCQ==
X-Google-Smtp-Source: APiQypInzUzZm25lnnIJa3VDBbZfAVF/WMbk3CIHfW+4Am2P9f+bItqK6RFZF8ACGHVoydz0u8GzGA==
X-Received: by 2002:ac8:7b8b:: with SMTP id p11mr3305529qtu.131.1588693517243;
        Tue, 05 May 2020 08:45:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x7sm2122407qkx.36.2020.05.05.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:45:16 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] pstore/ram: in ramoops_platform_data convert dump_oops to max_reason
Date:   Tue,  5 May 2020 11:45:08 -0400
Message-Id: <20200505154510.93506-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200505154510.93506-1-pasha.tatashin@soleen.com>
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that pstore_register() can correctly pass max_reason to kmesg dump
facility, use it instead of dump_oops boolean.

Replace in ramoops_platform_data dump_oops with max_reason. When dump_oops
was enabled set max_reason to KMSG_DUMP_OOPS, otherwise set it to
KMSG_DUMP_PANIC.

Remove filtering logic from ramoops_pstore_write(), as that is not needed
anymore, only dmesges specified by max_reason are passed to
ramoops_pstore_write(). Also, because of this, we can remove
cxt->dump_oops.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/admin-guide/ramoops.rst     | 11 ++++++----
 drivers/platform/chrome/chromeos_pstore.c |  2 +-
 fs/pstore/ram.c                           | 26 +++++++----------------
 include/linux/pstore_ram.h                |  2 +-
 4 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index 6dbcc5481000..a296e1aa1617 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -32,11 +32,14 @@ memory to be mapped strongly ordered, and atomic operations on strongly ordered
 memory are implementation defined, and won't work on many ARMs such as omaps.
 
 The memory area is divided into ``record_size`` chunks (also rounded down to
-power of two) and each oops/panic writes a ``record_size`` chunk of
+power of two) and each kmesg dump writes a ``record_size`` chunk of
 information.
 
-Dumping both oopses and panics can be done by setting 1 in the ``dump_oops``
-variable while setting 0 in that variable dumps only the panics.
+Dumping reasons can be set via max_reason value, as defined in
+include/linux/kmsg_dump.h: kmsg_dump_reason. For example, to
+dump for both oopses and panics reasons, max_reason should be set to 2
+(KMSG_DUMP_OOPS), to dump panics only max_reason should be set to 1
+(KMSG_DUMP_PANIC).
 
 The module uses a counter to record multiple dumps but the counter gets reset
 on restart (i.e. new dumps after the restart will overwrite old ones).
@@ -90,7 +93,7 @@ Setting the ramoops parameters can be done in several different manners:
         .mem_address            = <...>,
         .mem_type               = <...>,
         .record_size            = <...>,
-        .dump_oops              = <...>,
+        .max_reason             = <...>,
         .ecc                    = <...>,
   };
 
diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index d13770785fb5..fa51153688b4 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -57,7 +57,7 @@ static struct ramoops_platform_data chromeos_ramoops_data = {
 	.record_size	= 0x40000,
 	.console_size	= 0x20000,
 	.ftrace_size	= 0x20000,
-	.dump_oops	= 1,
+	.max_reason	= KMSG_DUMP_OOPS,
 };
 
 static struct platform_device chromeos_ramoops = {
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 795622190c01..223581aeea96 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -81,7 +81,6 @@ struct ramoops_context {
 	size_t console_size;
 	size_t ftrace_size;
 	size_t pmsg_size;
-	int dump_oops;
 	u32 flags;
 	struct persistent_ram_ecc_info ecc_info;
 	unsigned int max_dump_cnt;
@@ -381,18 +380,6 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
 	if (record->type != PSTORE_TYPE_DMESG)
 		return -EINVAL;
 
-	/*
-	 * Out of the various dmesg dump types, ramoops is currently designed
-	 * to only store crash logs, rather than storing general kernel logs.
-	 */
-	if (record->reason != KMSG_DUMP_OOPS &&
-	    record->reason != KMSG_DUMP_PANIC)
-		return -EINVAL;
-
-	/* Skip Oopes when configured to do so. */
-	if (record->reason == KMSG_DUMP_OOPS && !cxt->dump_oops)
-		return -EINVAL;
-
 	/*
 	 * Explicitly only take the first part of any new crash.
 	 * If our buffer is larger than kmsg_bytes, this can never happen,
@@ -687,7 +674,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	pdata->mem_size = resource_size(res);
 	pdata->mem_address = res->start;
 	pdata->mem_type = of_property_read_bool(of_node, "unbuffered");
-	pdata->dump_oops = !of_property_read_bool(of_node, "no-dump-oops");
+	dump_oops = !of_property_read_bool(of_node, "no-dump-oops");
 
 #define parse_size(name, field) {					\
 		ret = ramoops_parse_dt_size(pdev, name, &value);	\
@@ -785,7 +772,6 @@ static int ramoops_probe(struct platform_device *pdev)
 	cxt->console_size = pdata->console_size;
 	cxt->ftrace_size = pdata->ftrace_size;
 	cxt->pmsg_size = pdata->pmsg_size;
-	cxt->dump_oops = pdata->dump_oops;
 	cxt->flags = pdata->flags;
 	cxt->ecc_info = pdata->ecc_info;
 
@@ -828,8 +814,14 @@ static int ramoops_probe(struct platform_device *pdev)
 	 * the single region size is how to check.
 	 */
 	cxt->pstore.flags = 0;
-	if (cxt->max_dump_cnt)
+	if (cxt->max_dump_cnt) {
 		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
+		if (pdata->max_reason <= 0) {
+			pdata->max_reason = dump_oops ? KMSG_DUMP_OOPS :
+							KMSG_DUMP_PANIC;
+		}
+		cxt->pstore.max_reason = pdata->max_reason;
+	}
 	if (cxt->console_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
 	if (cxt->max_ftrace_cnt)
@@ -865,7 +857,6 @@ static int ramoops_probe(struct platform_device *pdev)
 	mem_size = pdata->mem_size;
 	mem_address = pdata->mem_address;
 	record_size = pdata->record_size;
-	dump_oops = pdata->dump_oops;
 	ramoops_console_size = pdata->console_size;
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
@@ -948,7 +939,6 @@ static void __init ramoops_register_dummy(void)
 	pdata.console_size = ramoops_console_size;
 	pdata.ftrace_size = ramoops_ftrace_size;
 	pdata.pmsg_size = ramoops_pmsg_size;
-	pdata.dump_oops = dump_oops;
 	pdata.flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
 
 	/*
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9cb9b9067298..9f16afec7290 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -133,7 +133,7 @@ struct ramoops_platform_data {
 	unsigned long	console_size;
 	unsigned long	ftrace_size;
 	unsigned long	pmsg_size;
-	int		dump_oops;
+	int		max_reason;
 	u32		flags;
 	struct persistent_ram_ecc_info ecc_info;
 };
-- 
2.25.1

