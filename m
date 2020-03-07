Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3AAC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26582070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/Ump+m7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCGJjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 04:39:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgCGJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:39:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so2274016pgs.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 01:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQrEvZ13F8kEvhfqqpGuqFY2wEN2DIfUxspJmPRPnIo=;
        b=S/Ump+m7pX1/2CQ88Se755gIiG6OFrXK2l/vah7aFG/d2RAfEoB7TE8hjfGUTil34U
         yOaTgDLAAka5xml/5Pud4/O/GJ4N43tPXekh3oTC0Ip5ViOMJHy5GwRKliFKleSrNjt5
         CntuBDxL66X6Tt4URFw7EACYFPbil8BU9wlYdCaH/uXNYaDvqi624jOc9Un1jcgUEi3p
         MNa45X3SwRRzhlZoAhG5vXImE/Yy7RrqiZw18wVv0XwDZ17L+OjYm4JBQmXEmeD2mfXp
         CcoGiIiEnVw6N4a3/flDIX+mJwATmetu4O3tOBszVqf/yyvFawLFMIaIn+CEIlN8y7V+
         ugXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQrEvZ13F8kEvhfqqpGuqFY2wEN2DIfUxspJmPRPnIo=;
        b=KTXmHMjl7t0dZBKpYZRDp/Di45HQhV/osG11vyKE0y0Qk0PKqQwA4/RDzD5polyYdl
         c7y1ttSMtZimX6W5bqE9b+N5gDXVZa9pOEG6zPZPz09FCXtOPHU0qJfAmvlJJhSrkt8E
         TMelJmbWXN4noYuq9BA5V/Mcr1bOm34resflf+N2eHT9p6FrIu1xha70KcpZMmltE2Ax
         7R+M4ZmNH+IPv1C5kzoqTv/egLkk7fEOS7Xwu2k/iS6YbL3T+UG3y6u3zEh0buWvODTj
         mHzw+98AAMosWzd2Jc9OrH68Hr9tk/NHK6AuGB6Ca6C0MQvqIlmAZF0HsP1cLYzcRZ86
         rWLg==
X-Gm-Message-State: ANhLgQ1YbO4cbjhsfH0qbba8dKnUDQ2CRcF6Bd2M98gCmmuAV3NRb1zr
        KM7ATIKVLw28cQqrcSBWmiw=
X-Google-Smtp-Source: ADFU+vsMj19AZ1LMNkk/TpNkNt56C7jYnDIJMIFA0yMpCIVVFSYlfPbfxqUpAEoPlL07hhQWMJ5ofg==
X-Received: by 2002:a63:348b:: with SMTP id b133mr7346984pga.372.1583573980485;
        Sat, 07 Mar 2020 01:39:40 -0800 (PST)
Received: from debian.net.fpt ([2405:4800:58f7:2133:c967:474d:b56a:15e9])
        by smtp.gmail.com with ESMTPSA id q13sm37932689pgh.30.2020.03.07.01.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 01:39:39 -0800 (PST)
From:   Phong Tran <tranmanphong@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org, alexios.zavras@intel.com,
        tglx@linutronix.de, akpm@linux-foundation.org,
        steven.price@arm.com, steve.capper@arm.com, mark.rutland@arm.com,
        broonie@kernel.org, keescook@chromium.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] arm64: add check_wx_pages debugfs for CHECK_WX
Date:   Sat,  7 Mar 2020 16:39:26 +0700
Message-Id: <20200307093926.27145-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow the suggestion from
https://github.com/KSPP/linux/issues/35

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm64/Kconfig.debug        |  3 ++-
 arch/arm64/include/asm/ptdump.h |  2 ++
 arch/arm64/mm/dump.c            |  1 +
 arch/arm64/mm/ptdump_debugfs.c  | 18 ++++++++++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 1c906d932d6b..be552fa351e2 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -48,7 +48,8 @@ config DEBUG_WX
 	  of other unfixed kernel bugs easier.
 
 	  There is no runtime or memory usage effect of this option
-	  once the kernel has booted up - it's a one time check.
+	  once the kernel has booted up - it's a one time check and
+	  can be checked by echo "1" to "check_wx_pages" debugfs in runtime.
 
 	  If in doubt, say "Y".
 
diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 38187f74e089..b80d6b4fc508 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -24,9 +24,11 @@ struct ptdump_info {
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_PTDUMP_DEBUGFS
 void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
+int ptdump_check_wx_init(void);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
+static inline int ptdump_check_wx_init(void) { return 0; }
 #endif
 void ptdump_check_wx(void);
 #endif /* CONFIG_PTDUMP_CORE */
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 860c00ec8bd3..60c99a047763 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -378,6 +378,7 @@ static int ptdump_init(void)
 #endif
 	ptdump_initialize();
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+	ptdump_check_wx_init();
 	return 0;
 }
 device_initcall(ptdump_init);
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 1f2eae3e988b..73cddc12c3c2 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -16,3 +16,21 @@ void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
 	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
 }
+
+static int check_wx_debugfs_set(void *data, u64 val)
+{
+	if (val != 1ULL)
+		return -EINVAL;
+
+	ptdump_check_wx();
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(check_wx_fops, NULL, check_wx_debugfs_set, "%llu\n");
+
+int ptdump_check_wx_init(void)
+{
+	return debugfs_create_file("check_wx_pages", 0200, NULL,
+				   NULL, &check_wx_fops) ? 0 : -ENOMEM;
+}
-- 
2.20.1

