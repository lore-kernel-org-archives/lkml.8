Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD288C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8729C20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738090;
	bh=ooBWoW2ScNo0Dpwiny40521JXsTI824BvytHz1VpIuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j7JAGqXO24QYYi0F6voYQRXAvSBbny9u9UAFDjp1qQlEnH/jChsESq+V9V9oa0+jo
	 WWUR3rfQFbsgXTnnaM+hZ6W8E7mE58l87Uwc5CYgP76zi6w+6RURqoQbLXcXLUDxVe
	 Ofq8xyyfhp83pKakAN1raQ8bMviUbhws+1tdoXow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgE2Hla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:41:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39013 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgE2Hl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id x18so766672pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDbHuQyYpIA+NrKXcOMmKPCGJcWzsoGwYaKrbY/Qlik=;
        b=TjG28oUEWGZjL/eIFQ4rfhWLei+vI/evW6M6yXTSd53RcNvVwHkMrKfNBxj51JDXje
         oqtk9lY5wnYW45eGe26L+thCvxJsAg2mLyCrx6SffX9WMLHsOgozhW3re4EERMHF8uqZ
         oEEEc5gb/pZhx7AFlwzTg6UAQYvEqxf06FtXF1yvjKUFIImc8bJBo8bdOzyMjpegBOG9
         +6raROiRIQZ6aRu54joMWXr0TZBlHMZkQlwuksbkDD1AmzA/KWpW5Ngal0rRd1EL4/92
         /9EfJ73vi71PiLTfkeysX51DQqmu4H66oeFX/D9BN5HaoeqjbhjI3CkYORDgmYwQY4Hn
         uD2g==
X-Gm-Message-State: AOAM533ePAFt+w/WDyY9xti2pBCCrxWm2pKOZZgApA1CWNIkA54aXA5Y
        PmO+c0dLfi5GBpjMw0PVhrI=
X-Google-Smtp-Source: ABdhPJwGzuqDcH6Vkxqbl1C5ZMUAQstwFZ+JipZBre8wnuBfBUsU2v0rs/LBQURtmvm2RkRrx2hGlQ==
X-Received: by 2002:a17:90a:fe0c:: with SMTP id ck12mr973724pjb.209.1590738085315;
        Fri, 29 May 2020 00:41:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t201sm3703652pfc.104.2020.05.29.00.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 08CEC42394; Fri, 29 May 2020 07:41:11 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        benh@kernel.crashing.org, rdna@fb.com, viro@zeniv.linux.org.uk,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        vbabka@suse.cz, sfr@canb.auug.org.au, jack@suse.cz,
        amir73il@gmail.com, rafael@kernel.org, tytso@mit.edu
Cc:     julia.lawall@lip6.fr, akpm@linux-foundation.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 12/13] sysctl: add helper to register empty subdir
Date:   Fri, 29 May 2020 07:41:07 +0000
Message-Id: <20200529074108.16928-13-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200529074108.16928-1-mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way to create a subdirectory from the base set of directories
is a bit obscure, so provide a helper which makes this clear, and
also helps remove boiler plate code required to do this work.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/sysctl.h |  7 +++++++
 kernel/sysctl.c        | 16 +++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 33a471b56345..89c92390e6de 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -208,6 +208,8 @@ extern void register_sysctl_init(const char *path, struct ctl_table *table,
 extern struct ctl_table_header *register_sysctl_subdir(const char *base,
 						       const char *subdir,
 						       struct ctl_table *table);
+extern void register_sysctl_empty_subdir(const char *base, const char *subdir);
+
 void do_sysctl_args(void);
 
 extern int pwrsw_enabled;
@@ -231,6 +233,11 @@ inline struct ctl_table_header *register_sysctl_subdir(const char *base,
 	return NULL;
 }
 
+static inline void register_sysctl_empty_subdir(const char *base,
+						const char *subdir)
+{
+}
+
 static inline struct ctl_table_header *register_sysctl_paths(
 			const struct ctl_path *path, struct ctl_table *table)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f9a35325d5d5..460532cd5ac8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3188,13 +3188,17 @@ struct ctl_table_header *register_sysctl_subdir(const char *base,
 		{ }
 	};
 
-	if (!table->procname)
+	if (table != sysctl_mount_point && !table->procname)
 		goto out;
 
 	hdr = register_sysctl_table(base_table);
 	if (unlikely(!hdr)) {
-		pr_err("failed when creating subdirectory sysctl %s/%s/%s\n",
-		       base, subdir, table->procname);
+		if (table != sysctl_mount_point)
+			pr_err("failed when creating subdirectory sysctl %s/%s/%s\n",
+			       base, subdir, table->procname);
+		else
+			pr_err("failed when creating empty subddirectory %s/%s\n",
+			       base, subdir);
 		goto out;
 	}
 	kmemleak_not_leak(hdr);
@@ -3202,6 +3206,12 @@ struct ctl_table_header *register_sysctl_subdir(const char *base,
 	return hdr;
 }
 EXPORT_SYMBOL_GPL(register_sysctl_subdir);
+
+void register_sysctl_empty_subdir(const char *base,
+				  const char *subdir)
+{
+	register_sysctl_subdir(base, subdir, sysctl_mount_point);
+}
 #endif /* CONFIG_SYSCTL */
 /*
  * No sense putting this after each symbol definition, twice,
-- 
2.26.2

