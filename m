Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D29C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 10:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F3C24897
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 10:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVBlgFQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgFUK0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 06:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbgFUK0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 06:26:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C28C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 03:26:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h22so6987172pjf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6tjEJqbjfc87lKS0nPB598OKO3b+lQp1eI3MWqxjWU4=;
        b=fVBlgFQkiYCs+4k/cI2AOfK6D45S6gTbKHoTlG7X3WRXIhx3xzNGagAn4q8Xeqwjce
         rhHBklL/12pS1wWmwHCdw7MnBXIPCvrUu8SbZbFDIoSLtdCUlJkdZY9NPiDfOpBmqfCD
         YpzK8tcjQpuCm5BI6Yewwk23yz4mqcXa0Kbp5V2Vvx/W70FJWjhtNlH+V/6pkzGmWuo0
         KfHy+NtgoJt0IyNMIUzrfaDrtIx407sMzqu+AyI9yQwfn+smicxr1z1YSOJWdooRkQu8
         zOBB5zbfeBfBbFg0sDYhnG5etGbMDLT/rEeuAQmr7tCvQrzGnHtkJLrjXt8vtsT8M2Ck
         adTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6tjEJqbjfc87lKS0nPB598OKO3b+lQp1eI3MWqxjWU4=;
        b=OwWElru/zyG/3kteKvElkUQYZ/IfEgTNTC9Tz6G6VtUR2wIYTMgNbHnI4rKfi+oecB
         hYP5uQRQo6SpZJRqnIIrWTxCgMl+hZIp6J2RaoFIPvf5auxtc6QZjsvJacVp1FC7kKug
         j3BL53KsmvoO9hhHTzhfUR3+hd/Of9tb81oy22mW6Mh5q94lGpnaOEJl7evcy2dnWawX
         bWMb57y3Vc2mItUvhpmhD9/YApTbLWSwLWCTKthWSDLLcmX/kugop0bi3ADp/SVz08Tc
         x2n1w2KB2tR6duGWEGO2OQyVG91bP2oASqL8iB7kJtKJ4ZymA0AHcZ4x3+OVkoCVoSdV
         MHFw==
X-Gm-Message-State: AOAM531/ijRZniw7K5VCPoODW/+6wKdROYR6ys97WRV5Bw0hdV0fYax3
        dgXtB2TTR+j8xZX1fDil0BI=
X-Google-Smtp-Source: ABdhPJyoMHhmlfpGi/XJhqwTpOiV8ReMJLLRTvOLXUJylZElKdG7gp77rqfj9eCyXf4C98xwIu1AMA==
X-Received: by 2002:a17:90b:706:: with SMTP id s6mr12932003pjz.11.1592735205556;
        Sun, 21 Jun 2020 03:26:45 -0700 (PDT)
Received: from debian.debian-2 ([154.223.71.34])
        by smtp.gmail.com with ESMTPSA id gq8sm10060300pjb.14.2020.06.21.03.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jun 2020 03:26:44 -0700 (PDT)
Date:   Sun, 21 Jun 2020 18:26:39 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        peterz@infradead.org, luto@kernel.org,
        alexandre.chartre@oracle.com, jannh@google.com,
        dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, tsu.yubo@gmail.com
Subject: [PATCH -next] arch/x86: Return value from notify_die should to be
 checked.
Message-ID: <20200621102634.n43ozcsiravdi2ie@debian.debian-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is detected by Coverity scan: #CID: 1464472(CHECKED_RETURN)

FIXES: c94082656dac7(x86: Use enum instead of literals for trap values)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 arch/x86/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index af75109485c2..bf014fb59017 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -401,7 +401,8 @@ DEFINE_IDTENTRY_DF(exc_double_fault)

 	nmi_enter();
 	instrumentation_begin();
-	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
+	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV))
+		return;

 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = X86_TRAP_DF;
--
2.11.0

