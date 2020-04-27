Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B85C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655682072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbEiC9A+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgD0VQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726030AbgD0VQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:16:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C8C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:16:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so5890942pfx.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VjlmInaD+CunQni2gwfodUVCdw5wBkcVV++SAKGDNm8=;
        b=gbEiC9A+JIMCqUDTp3fQ8kV6QvUKLQsC82g692TcX9BzZJRf4B+XUpO8XJTH0bkhBr
         eDNs9WMm5ffWqg3KYfV6RaRhPeLAL9yZk7Vk74e907Vn/PE7L1t4O/DITeTY5a3fLaH+
         /fN6gDpQ1EGktQcR/GVqOC4QrXfC8s03Oyl7m87a9hlhEw0uikH19BoqFPRSuXA7aqCj
         GKJnnpX+TQ/RcEwpVfB4g3QxAdyY4sbD2btDFu6A40AZUriEbUke83mxGrD7Bmye7ScK
         RbVYzeRlOZmxMJEL+MSZa2+/+Er55hu2o0LZMtNxAsBHnT3o5AAi0Ny72aKR6tnTtOWg
         3lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VjlmInaD+CunQni2gwfodUVCdw5wBkcVV++SAKGDNm8=;
        b=fw4QI6/D20it9ifJp0P0m4f4pypI9J2VmgreS5rPj0RnSFCyCCGnOxNb1xb1OkJziV
         0BaxsEEzJoN/iXAly+3MLmiw5EcoKZh0PVlV0c+nho5Dlm2M0XuFVWtH9mR7zw6eZXLY
         oe5l0+yVcz0KB9sk01PjqeeYVfHGdWgzR9ULgoen9tFLixvRBNWJII3oV9cHHKkDCVRm
         1bs48WM64idH2xt56WL1ZvR/9dZHVkxS0bgRcrj1PZ0ewKicFfMwRONvLvpRsaP2hDg0
         JooKD6IJ4YWRNocxFVXj9slljiSznBSRRh3ATjsEu3/HaLbaXYwhHjTJbX/QP8jMb7TA
         VvTQ==
X-Gm-Message-State: AGi0PubNmX3zrdxsyzll3Bc19Qidj7FVvs9dAbC+bHvkig/HFQ7RW00V
        ci2G1oRmwAEZWmStv9m0qaI=
X-Google-Smtp-Source: APiQypIbLlcCEwoQTDklkjMMFsmBQihap2gJlKmUb1pvK2Lid6vvJ2UbKZCrUYtpb7acXXN61KEUOg==
X-Received: by 2002:aa7:8ad6:: with SMTP id b22mr451831pfd.251.1588022191150;
        Mon, 27 Apr 2020 14:16:31 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (c-69-181-90-243.hsd1.ca.comcast.net. [69.181.90.243])
        by smtp.gmail.com with ESMTPSA id w12sm13000910pfq.133.2020.04.27.14.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:16:30 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (localhost [IPv6:::1])
        by gnu-cfl-2.localdomain (Postfix) with ESMTP id 9C7CCC0117;
        Mon, 27 Apr 2020 14:16:28 -0700 (PDT)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Discard .rela* sections if CONFIG_RELOCATABLE is undefined
Date:   Mon, 27 Apr 2020 14:16:28 -0700
Message-Id: <20200427211628.4244-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/powerpc/kernel/vmlinux.lds.S has

        DISCARDS
        /DISCARD/ : {
                *(*.EMB.apuinfo)
                *(.glink .iplt .plt .rela* .comment)
                *(.gnu.version*)
                *(.gnu.attributes)
                *(.eh_frame)
        }

Since .rela* sections are needed when CONFIG_RELOCATABLE is defined,
change to discard .rela* sections if CONFIG_RELOCATABLE is undefined.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
---
 arch/powerpc/kernel/vmlinux.lds.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 31a0f201fb6f..4ba07734a210 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -366,9 +366,12 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		*(*.EMB.apuinfo)
-		*(.glink .iplt .plt .rela* .comment)
+		*(.glink .iplt .plt .comment)
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+#ifndef CONFIG_RELOCATABLE
+		*(.rela*)
+#endif
 	}
 }
-- 
2.25.4

