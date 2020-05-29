Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9382074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738078;
	bh=pc+oTicNo8Fmn7qyVGsYb0cfPq8Ry3hv2f7QIOfdoZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H7Z98G0MqPT5ArQuysJvgTtQyoMbiudgP/OfRpCmaPyQazIjE1uL8jGef1rZNqAbe
	 4NL9Kx2IdxA/n4CPsvSw+7NdVeRx31TWSpmWTEtFzqx6yghbkxowk1jWgu70LcjtBN
	 Imqz9kmTX3CLLNQDpfEbguG5Pk77YP2gd+g704do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgE2HlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:41:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37082 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgE2HlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id x10so770408plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztkbZyMAj8QAP+BJLtRR/lmTCR2M8J8E3LJknwjviqU=;
        b=DDowHB5pX8yO0+Sb0FvPNkWOBk3/+U/UODpc8K57nbsLj7MbgOUJ6VdkTrvKYqOlcC
         Gta/Q+6LlyHlkt/IWDDYWX/k3G2ZnDWr/5yfP8byUiGTlFkivvekKH1ShSftEV/ahz7R
         D/pK/M11wzv6Xn/dC/hlB3xW+EW2mDP9CbUqbMJOqe69B7bLLXs3I9sggIO/br1zPbkt
         cy/mkM5CYmcGP/BqsPs2hREp5jt4ntvqX35t/MPuFE+EejE/yeojygIIqMRKuqkUoRU2
         BZEbNJkfquodkfeHEXI0AxitqtGqV4NaJqhDMLEAvTj97UPVVIuXGXvuGL07vRXr7L82
         oSkA==
X-Gm-Message-State: AOAM530odPenlMJNvgbSBRC9sHUyr2yPumTnH+D4kgJP8mhZTtgmsJAh
        sFyNEPXJ9i0TzsnUfd7xeig=
X-Google-Smtp-Source: ABdhPJwef9VnxevTutof/OWjXxMen8nqP316VSHb8lndoYqWe0y1ALBADBIyXeEXdBPr/HgBfKduig==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21mr7959305pls.238.1590738074446;
        Fri, 29 May 2020 00:41:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e26sm6189878pgl.27.2020.05.29.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 10D65418C0; Fri, 29 May 2020 07:41:10 +0000 (UTC)
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
Subject: [PATCH 01/13] sysctl: add new register_sysctl_subdir() helper
Date:   Fri, 29 May 2020 07:40:56 +0000
Message-Id: <20200529074108.16928-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200529074108.16928-1-mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Often enough all we need to do is create a subdirectory so that
we can stuff sysctls underneath it. However, *if* that directory
was already created early on the boot sequence we really have no
need to use the full boiler plate code for it, we can just use
local variables to help us guide sysctl to place the new leaf files.

So use a helper to do precisely this.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/sysctl.h | 11 +++++++++++
 kernel/sysctl.c        | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ddaa06ddd852..58bc978d4f03 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -205,6 +205,9 @@ void unregister_sysctl_table(struct ctl_table_header * table);
 extern int sysctl_init(void);
 extern void register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name);
+extern struct ctl_table_header *register_sysctl_subdir(const char *base,
+						       const char *subdir,
+						       struct ctl_table *table);
 void do_sysctl_args(void);
 
 extern int pwrsw_enabled;
@@ -223,6 +226,14 @@ static inline struct ctl_table_header *register_sysctl_table(struct ctl_table *
 	return NULL;
 }
 
+static
+inline struct ctl_table_header *register_sysctl_subdir(const char *base,
+						       const char *subdir,
+						       struct ctl_table *table)
+{
+	return NULL;
+}
+
 static inline struct ctl_table_header *register_sysctl_paths(
 			const struct ctl_path *path, struct ctl_table *table)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 008ac0576ae5..04ff032f2863 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3195,6 +3195,43 @@ void __init register_sysctl_init(const char *path, struct ctl_table *table,
 	}
 	kmemleak_not_leak(hdr);
 }
+
+struct ctl_table_header *register_sysctl_subdir(const char *base,
+						const char *subdir,
+						struct ctl_table *table)
+{
+	struct ctl_table_header *hdr = NULL;
+	struct ctl_table subdir_table[] = {
+		{
+			.procname	= subdir,
+			.mode		= 0555,
+			.child		= table,
+		},
+		{ }
+	};
+	struct ctl_table base_table[] = {
+		{
+			.procname	= base,
+			.mode		= 0555,
+			.child		= subdir_table,
+		},
+		{ }
+	};
+
+	if (!table->procname)
+		goto out;
+
+	hdr = register_sysctl_table(base_table);
+	if (unlikely(!hdr)) {
+		pr_err("failed when creating subdirectory sysctl %s/%s/%s\n",
+		       base, subdir, table->procname);
+		goto out;
+	}
+	kmemleak_not_leak(hdr);
+out:
+	return hdr;
+}
+EXPORT_SYMBOL_GPL(register_sysctl_subdir);
 #endif /* CONFIG_SYSCTL */
 /*
  * No sense putting this after each symbol definition, twice,
-- 
2.26.2

