Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB89C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96FE2065C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMExMwmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHEVHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:07:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A2C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:07:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so26201457ply.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XjPMge3KfxxLUFGF6krRbz5lxz5gIyPgeCzTjsMTkRY=;
        b=LMExMwmkOQ+yWr/ZnrykNf+jrL5XbVkPC8tXC7ob1BiPacIs5t8FHZEB6NrHZGsbsZ
         IReHdgOJGQILHeiU6iybOKhILw7PJcSwtKFTV0KjL2QmwfhI9jSTeFVr+XAG2c67Iw9Z
         lFdOskP9jQ31Z00i8iRgG1wCepszYnE6VZMFCkBEsuWsCUihDLCthJPFQCJqIukXRaQt
         gg0IS6HjPdpy6Aj0r+/5/Q1sFdw3Xlww5Lbq4/eLoCultdQIjYgFRwEJYdD35v1SQ2Qi
         C3Imwh9vscQZ/SgBvKunR9hVJ57rcqe5gj1O3NFtM2GgNWgFLRHcuB0VWcFSWcs0EVUI
         fTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjPMge3KfxxLUFGF6krRbz5lxz5gIyPgeCzTjsMTkRY=;
        b=sTNsDOQXi8hok7gFZEff9DGJVmeQM5eg3c+9FBmWWt53e9y3UK3vw6lqaasSvH+PCz
         xopLO1mbOc7vSUckBWjBCLgDSPDtyGkiBWQgRQwiyk6H0VJxFFOx4dhXvCidMVtnpFOp
         enh3tQlgwvl26FVx6gzADHS8F7I75B0Q0XzSAY9UOCzZCGIgVsaZfzzCr1GIHZP/Ney2
         Yjy1a8vPcsVXRwP909AtUYHKo6N3LL3megE0t/RmszudPCdiaL9IkRQdJzX2iQaakiih
         NCMGlppCebBXNtkyub0lVQTQzmOrh8fFcqbgf+rxyEBwn9IIqgxwuo1sv5B10K8lgSoT
         LiSw==
X-Gm-Message-State: AOAM530e6oOKt72XLFNB0aHs87R7t8H0Nn6C9GSN26jyk0zerPGzYoJp
        /MnsdpAkBMn8NVwlRKePoPuYcNwt
X-Google-Smtp-Source: ABdhPJxPzy+bLTldQVIy9ICqiTeYseZwe652Giet/dPObxGS/yKMb8Kfupsdc1XoNt6kI2YuObUsVQ==
X-Received: by 2002:a17:90a:4e8f:: with SMTP id o15mr4745779pjh.220.1596661662968;
        Wed, 05 Aug 2020 14:07:42 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id r15sm5064463pfq.189.2020.08.05.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:07:42 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 1/6] openrisc: io: Fixup defines and move include to the end
Date:   Thu,  6 Aug 2020 06:07:20 +0900
Message-Id: <20200805210725.310301-2-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805210725.310301-1-shorne@gmail.com>
References: <20200805210725.310301-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This didn't seem to cause any issues, but while working on fixing up
sparse annotations for OpenRISC I noticed this.  This patch moves the
include of asm-generic/io.h to the end of the file.  Also, we add
defines of ioremap and iounmap, that way we don't get duplicate
definitions from asm-generic/io.h.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v1:
 - Add linux/types.h include following report from kbuild

 arch/openrisc/include/asm/io.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index db02fb2077d9..7d6b4a77b379 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -14,6 +14,8 @@
 #ifndef __ASM_OPENRISC_IO_H
 #define __ASM_OPENRISC_IO_H
 
+#include <linux/types.h>
+
 /*
  * PCI: can we really do 0 here if we have no port IO?
  */
@@ -25,9 +27,12 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#include <asm-generic/io.h>
-
+#define ioremap ioremap
 void __iomem *ioremap(phys_addr_t offset, unsigned long size);
+
+#define iounmap iounmap
 extern void iounmap(void *addr);
 
+#include <asm-generic/io.h>
+
 #endif
-- 
2.26.2

