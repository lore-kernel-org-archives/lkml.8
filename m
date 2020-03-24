Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3C3C54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448CA20774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6dCbIM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCXOfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:35:37 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36473 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCXOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:35:35 -0400
Received: by mail-qv1-f68.google.com with SMTP id z13so9309400qvw.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMN0urVMLPtZbtsflPFbMuOG7G97DEryqB11mnFTGMQ=;
        b=I6dCbIM3yXeW03+pJ5ljJGWsrOm6oCK/3pXO/KkpXXRzeutF+45hhRc2mRVbqfJv/O
         ULyhJnAb4ON0QrdtC9y5BdUROTOF3UlgjcRZMoFT7/SHPfY7IucH+DHCZ8y9TjbX7wvn
         7rucO+zMmTelk7XzaCrIJiLXmX1dw54NFVvs3PMeZN9w3elcb+dF7NZgQpP4sTWPoPmv
         obqUV1oTlnUH+dOBIvcEKtJzFou5nyMaOcsXS+MliqcV+LkY7UA9WQZyjdRlVsD9LqRh
         QgrQqz7lbAN02OPfwKIgojdCxGwMvTXUjhIdWXybRN0zm1XYDBQG8fE4E/F/z9SqDBif
         04Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMN0urVMLPtZbtsflPFbMuOG7G97DEryqB11mnFTGMQ=;
        b=dKh8NC687uSiNNYv6h3a0xbgzI64YdA5G2Bn6/Ot5CSSDctSm4GaP6awVG1CgWsGHq
         CLhrF6tc1yQNI3RVSjNFbCJbARou77ZTZOGsw/HeQeA44eYBWxtklfA1oajOQqZZiGaB
         ApOd+zTngavvj5M7JpcKu9cWpthJdJDKh0XL1kNO9VExxB3fhqS6T43bo+D+uOD7ezR7
         3b1ox44qMwAGcNLjT0HkKppGE9g/dz43bqEBlUj47cMQfgDOHbYccsjW50FsNt/pOJJH
         eoqOUBr51miD/LFnlcelG6D1wew4/+LuFWnrJGqitVgG0phof1s74VmYfmzNGg31jGXg
         DTOw==
X-Gm-Message-State: ANhLgQ1dm8/DYvnxtDUipBwN4D2nSL+TWOhuWabdOqyIiC+zyP+VxVke
        op9mOHKNMrCisC57cV3FzvtnBS8=
X-Google-Smtp-Source: ADFU+vtm7QJgAzdFn3jnJlSceh7Xq7qYOJV9P+Jcg1UdA5qADOvt5vo/FZ2I48p9L1ihC3aODbWAVw==
X-Received: by 2002:a05:6214:421:: with SMTP id a1mr26119355qvy.185.1585060534878;
        Tue, 24 Mar 2020 07:35:34 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id r40sm14982189qtc.39.2020.03.24.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:35:32 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/entry: Fix build error x86 with !CONFIG_POSIX_TIMERS
Date:   Tue, 24 Mar 2020 10:35:20 -0400
Message-Id: <20200324143520.898733-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing semicolon.

Fixes: a74d187c2df3 ("x86/entry: Refactor SYS_NI macros")
Reported-By: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e10efa1454bc..a84333adeef2 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -86,7 +86,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	}
 
 #define __SYS_NI(abi, name)						\
-	SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers)
+	SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers);
 
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(name)						\
-- 
2.25.1

