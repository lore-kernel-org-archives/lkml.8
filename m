Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40C9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C64208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToyxyR6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbgDBI4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:56:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39713 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBI4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:56:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so3184468wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h09wq+dScd3G1lPfYna5Eel+LXgpSjdYtjatbyrFm9Y=;
        b=ToyxyR6+tOkJxOTHMZv3d5Qb5+mQdfAOof0Vp8dfanGw8N76L7Huem7/hA7fdphMPS
         HGqdvYzXRv86MFBimMv05fkMfaEKTugmYcDLdWlUw/ny+vDi+SqxVhym19IXMfGC+wcB
         TcmKMFniB0pqLJU6VUzLedGpy2W60Yxs+WtTK+Nqgp06K+D4N+K4nBh0dpeJopANlCc+
         cqa7qv4GNoIBODZxs5gDqwapCqnkxHbibY+wj+1BpnkzK815iAJJLbXh+ESDxSmnYhor
         sTfW8+l07QY2T5l0WzSg6sMhyJU2SSyITsE46M+fpv2JdLH6YxhJ2VJZjKQT2tBQNDPN
         BJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h09wq+dScd3G1lPfYna5Eel+LXgpSjdYtjatbyrFm9Y=;
        b=KJtD3cYSTMTBkgt9Lv5Z5+MLX2g/TZBkE0nkYXyAJ6zIdh4bVkb3CR5ZemkGw2UduP
         3m7kwOwGhlb8tK4AROp0MZ3W9IznGeMryBEA9qWIk7OisRyWU3xcKEX+9XXjqdJOiUla
         FeFtPRRh8NJ31/SUrzpnrvV9zaAXpBhbDrdpusgLP7sdY6la4XSnC8sN40l1lPmUo88M
         0OER5s6VeMs6u1DTLEjPp7/LNoGxxp/XTQ8yo9AJcOn0EQwYs5lMRHyKDa6gRHXrJJRO
         NLwJ+rOtg1u+7DO8FMkfZ9JlbxwB8UbyHcWeGvJH2rR2AOKaccDmXRFPWxxoKznfEPCg
         vI2A==
X-Gm-Message-State: AGi0PubJrmTa6plBBd49M/Xix6DkU9HqbjuxD//YweuB65iWz5D5pQLW
        VIJM1L7CLFamF/EaW3OjjlQ=
X-Google-Smtp-Source: APiQypKl86CrZn5pUtD9lMTnWvTthMdnWBaQefQSi+3SzDQqpRPQowm6dU88P08O/2Oe9p1b5nQkTQ==
X-Received: by 2002:a5d:6b8b:: with SMTP id n11mr2259268wrx.379.1585817768538;
        Thu, 02 Apr 2020 01:56:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a58:8532:8700:29b9:31c4:8247:2806])
        by smtp.gmail.com with ESMTPSA id a13sm6584160wrh.80.2020.04.02.01.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 01:56:07 -0700 (PDT)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mao Han <han_mao@c-sky.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] riscv: fix vdso build with lld
Date:   Thu,  2 Apr 2020 11:55:58 +0300
Message-Id: <20200402085559.24865-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with the LLVM linker this error occurrs:
    LD      arch/riscv/kernel/vdso/vdso-syms.o
  ld.lld: error: no input files

This happens because the lld treats -R as an alias to -rpath, as opposed
to ld where -R means --just-symbols.

Use the long option name for compatibility between the two.

Link: https://github.com/ClangBuiltLinux/linux/issues/805
Reported-by: Dmitry Golovin <dima@golovin.in>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
---
 arch/riscv/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 33b16f4212f7..19f7b9ea10ab 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -41,7 +41,8 @@ SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
 $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
 	$(call if_changed,vdsold)
 
-LDFLAGS_vdso-syms.o := -r -R
+# lld aliases -R to -rpath; use the longer option name
+LDFLAGS_vdso-syms.o := -r --just-symbols
 $(obj)/vdso-syms.o: $(obj)/vdso-dummy.o FORCE
 	$(call if_changed,ld)
 
-- 
2.17.1

