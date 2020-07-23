Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD53BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45A5206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTICzKj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgGWQg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:36:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92088C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:36:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x5so4985115wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bQZoXIFqfGEwjMaiaB7VWns9AxgAgz8MsvENSHF3qY=;
        b=cTICzKj0aMs/8vGqHK/g2hIbInMQECfRZuUvt4UmcNWYRqk4xjATkzw4Md7VTesbK9
         0kXACOaYojQvUMt8hJJT+8DqTHfA17ryD0glQDk8JH2nVSP0Q4uBUYu/BAlzRAHmYA8o
         y0kYtGciTUeol5L1fqlgNU5tvMXEEVhxrZ8JxZwzJ/f3M2PfP0/hJYt23ZKfrBJ0Cy3g
         sf+5xxkkh9aFDlpfsJCo9y7d7Rci8zdg8zDIDIEXRlzdECbjUvgZWo5brVCHoGxKlSkt
         ATq44f9IehaGrRpVQdy6xcH9zPONKCfD5Jiro1QmN0+EwIVSmPKq9p/ixYDoRczjnuBV
         o65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+bQZoXIFqfGEwjMaiaB7VWns9AxgAgz8MsvENSHF3qY=;
        b=iBkm5cH4G+1nhDovJR1dOpXULQijVXswAbTGhMRnOOl2x7nMJO58u2bd760WPEFvnR
         n5/2mmSDe688HDgSUdCuKT7uUK+GS9Ps91GNAuwKUdmvTKp5sf43fsungcllt6rSq4P6
         /IROoz5T52KTHJkUSF3nSGvUs2ZlmI9y3kjnBAKw5M4WWNNaFwSmfImfsVY9YCM519lc
         Gm8NbMevourDZm43U4FXIcPpRdaEJ7L2rO4IyKW3k/5EntQIArQnzpK9d0R8StMZG/Km
         MMtPkhNnxXF1dHHFssERFLm2nYL9qkDhbQMGazRbN8Y7GQQa6vntFeqT046YUjIJ/30o
         E3LA==
X-Gm-Message-State: AOAM53255bksMrrDLCSvkvbRPulsoByDPAVpWtkg2cKeYo6cAA2Ez8N1
        5pr5DHcIBNE4EYBViOhLQ/4=
X-Google-Smtp-Source: ABdhPJxO2ZsaLoOuyAebtlU69uOv3Tan2WxXsMV5Hevfj+jGM2uqH8o0ZrvtBxYO0qK/WRelOHHOvQ==
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr4810194wmh.130.1595522215302;
        Thu, 23 Jul 2020 09:36:55 -0700 (PDT)
Received: from localhost.localdomain ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id f9sm4274342wru.47.2020.07.23.09.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 09:36:54 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Grab text_mutex before patching jump-labels
Date:   Thu, 23 Jul 2020 18:36:28 +0200
Message-Id: <20200723163628.82794-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other arch's we use patch_text_nosync or equivalent
to patch the jump-labels, but also like other arch's we
need to hold the text_mutex before calling that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---

Fixes: b6e0878a4ec8 ("riscv: Add jump-label implementation")
..that is already in riscv/for-next.

Palmer: Sorry, I didn't notice this before. Feel free to
squash this into the commit above if you like.
---
 arch/riscv/kernel/jump_label.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index 1bab1abc1aa5..20e09056d141 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -4,8 +4,10 @@
  *
  * Based on arch/arm64/kernel/jump_label.c
  */
-#include <linux/kernel.h>
 #include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/memory.h>
+#include <linux/mutex.h>
 #include <asm/bug.h>
 #include <asm/patch.h>
 
@@ -33,7 +35,9 @@ void arch_jump_label_transform(struct jump_entry *entry,
 		insn = RISCV_INSN_NOP;
 	}
 
+	mutex_lock(&text_mutex);
 	patch_text_nosync(addr, &insn, sizeof(insn));
+	mutex_unlock(&text_mutex);
 }
 
 void arch_jump_label_transform_static(struct jump_entry *entry,
-- 
2.27.0

