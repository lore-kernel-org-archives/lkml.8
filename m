Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340DBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9200207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4CC/yyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgETQQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:16:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20818 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbgETQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589991366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+MQD7bLAeWpGadatG4/J3oyu4QcEuGAp5bNd5T2B1Jw=;
        b=d4CC/yycOkwyy9Nsn3Nax0MsqvNXlOJJvhhHXmrX5/sVB2V+SFRfxwZO1S4w73eITfclWX
        +aF0GG8WncW4xYTrFasCKjjIsoOPS8WRzyHF1w23rghfh+nq36buiSJKDRr/xzq76NJSGi
        YGFwJf+OCU+RobcKNHYzECemOeFGh9A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-ayMapM5ZMs-hiuJmY0LrJg-1; Wed, 20 May 2020 12:16:04 -0400
X-MC-Unique: ayMapM5ZMs-hiuJmY0LrJg-1
Received: by mail-ej1-f71.google.com with SMTP id pj20so1561258ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+MQD7bLAeWpGadatG4/J3oyu4QcEuGAp5bNd5T2B1Jw=;
        b=p13LihAKc0Qt11EppfxGaUuoJAfu+hN/ErVBPuh5AYhwhW+gjPv56mcgSxdy8C9wy6
         cRiVbzcXg5BPHvMGmmhnFGK+IJSWpvnyruJWXWrDV/IoS8a+ZWgOVp9kV/Ol/n4ke0M2
         B5OaUq6RyArEPYjMR8mfrhaWPeMwE2s2J3Yw1p9+R/ebVaXmEt9omQjEWPiQ4O03QWkm
         dcRLquMy+tRrVWCYCMeqLMwnPxFFvwjOlMMWUNfAzbTiygmU2v5wRwQcNWugsVwjhrlv
         ir5W/dnXsuzNNN3fdFHUrWTVFvk9kqol9lND/rWKPn+3pmYY4txkluhtwO9jrlGhp5zd
         GgFw==
X-Gm-Message-State: AOAM530RDb8AsW1NMm5hdQLeIYHWk++K5GG4Cnzvt0fd5FUorjckyIqV
        /DjGQPAa59H/ofjKKgfxan544Z+ML2yB1GbOYCLwz584Kj15wDvwAoq1g/bhoIWa2EPfANPKn5m
        TIfoEeFgt+MWVhLXPwW7z1ZB+
X-Received: by 2002:a17:906:3943:: with SMTP id g3mr4316534eje.454.1589991363489;
        Wed, 20 May 2020 09:16:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2hnM4vetLABm37y0fKnboEQ3oCgaMK3/TvHOMdlFMHyR+fDIP2LFNfyoNCg7yrAhnQSRTuQ==
X-Received: by 2002:a17:906:3943:: with SMTP id g3mr4316513eje.454.1589991363274;
        Wed, 20 May 2020 09:16:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h12sm2186513ejj.40.2020.05.20.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:16:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] xen: move xen_setup_callback_vector() definition to include/xen/hvm.h
Date:   Wed, 20 May 2020 18:16:00 +0200
Message-Id: <20200520161600.361895-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild test robot reports the following problem on ARM:

>> drivers/xen/events/events_base.c:1664:6: warning: no previous prototype
  for 'xen_setup_callback_vector' [-Wmissing-prototypes]
1664 | void xen_setup_callback_vector(void) {}
|      ^~~~~~~~~~~~~~~~~~~~~~~~~
The problem is that xen_setup_callback_vector is a x86 only thing, its
definition is present in arch/x86/xen/xen-ops.h but not on ARM. In
events_base.c we have a stub for !CONFIG_XEN_PVHVM but it is not
declared as 'static'.

On x86 the situation is hardly better: drivers/xen/events/events_base.c
doesn't include 'xen-ops.h' from arch/x86/xen/, it includes its namesake
from include/xen/ so we also get the 'no previous prototype' warning.

Currently, xen_setup_callback_vector() has two call sites: one in
drivers/xen/events_base.c and another in arch/x86/xen/suspend_hvm.c. The
former is placed under #ifdef CONFIG_X86 and the later is only compiled
in when CONFIG_XEN_PVHVM.

Resolve the issue by moving xen_setup_callback_vector() declaration to
arch neutral 'include/xen/hvm.h' as the implementation lives in arch
neutral drivers/xen/events/events_base.c.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- The patch needs to be applied on top of 'x86/xen: Split HVM vector callback
 setup and interrupt gate allocation' ('tip/entry' branch currently). This
 patch doesn't introduce the issue (and that's why I don't add 'Fixes:' tag)
 but it renames xen_callback_vector() -> xen_setup_callback_vector().
---
 arch/x86/xen/suspend_hvm.c | 1 +
 arch/x86/xen/xen-ops.h     | 1 -
 include/xen/hvm.h          | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
index 5152afe16876..9d548b0c772f 100644
--- a/arch/x86/xen/suspend_hvm.c
+++ b/arch/x86/xen/suspend_hvm.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 
 #include <xen/xen.h>
+#include <xen/hvm.h>
 #include <xen/features.h>
 #include <xen/interface/features.h>
 
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 1cc1568bfe04..937a53e73ea5 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -55,7 +55,6 @@ void xen_enable_sysenter(void);
 void xen_enable_syscall(void);
 void xen_vcpu_restore(void);
 
-void xen_setup_callback_vector(void);
 void xen_hvm_init_shared_info(void);
 void xen_unplug_emulated_devices(void);
 
diff --git a/include/xen/hvm.h b/include/xen/hvm.h
index 0b15f8cb17fc..b7fd7fc9ad41 100644
--- a/include/xen/hvm.h
+++ b/include/xen/hvm.h
@@ -58,4 +58,6 @@ static inline int hvm_get_parameter(int idx, uint64_t *value)
 #define HVM_CALLBACK_VECTOR(x) (((uint64_t)HVM_CALLBACK_VIA_TYPE_VECTOR)<<\
 		HVM_CALLBACK_VIA_TYPE_SHIFT | (x))
 
+void xen_setup_callback_vector(void);
+
 #endif /* XEN_HVM_H__ */
-- 
2.25.4

