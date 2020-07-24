Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8EAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F452073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595591094;
	bh=93E0dwGoEOrHiRcmoCNgvlnd+DX92f2I+5yj5XNaXuw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=L2OfeteLQsp7Ocv+BxD4C3hM5fVksyVa+ohr5mDIFq9ckWIw23FuOp8NNqd4Z5EOw
	 tud3MGxDbYs3/BgD1DZu3rC7HKK3gRAAPQL0L0TSpgEVs/MJ0a4tzuQmtwHxniAK9F
	 LVVsBWOyyFzFTJp75xJVsz+TqIO3Hi8Eg3fz3Gd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgGXLov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:44:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF65DC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:44:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id z17so6807118edr.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Va02mURe8LQqqq7tyc0PiH4hColVeiFSjGOYtRYZ6g=;
        b=mLZljBNfpvEJDoormwCHlHvK+jnPGF0NnAU99IUXCR7+bhAnzQWzlVXy284eVDxBv/
         XsHvri5NugJBCGUrkgseMZk7Ypm+bUF7mt3eQdNP3wnCQ2K5KyfLWIdNg0j0Kv1WHVur
         MKAdJwxPr8qC/+Rh10fdls8UXdctw385V4v/u0Rkpwglk4iOHBF8IM2EqtRbYQBCSjNQ
         LnuMUVNNAODrtlzl38AHCHNzUj//UGFujAnLAw51I+ktQz1vynBNy/ehIAjj07k8FWwb
         m3vbThrblFdJdVTm5hCTO7ChFip9mU2XqQTBgWnYX2FEX8eqqUJ9ZLpXJNaAkZP1szni
         g1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2Va02mURe8LQqqq7tyc0PiH4hColVeiFSjGOYtRYZ6g=;
        b=ScjiTMByyuHaEzXOOrC7w9gKITEwM3q4aqiMFHgs0qgTOm0FZn2OwpqV3IEVV1OWTd
         lGyogtCtCPJ5jlFeqwE8HKPnp2oZiY3KDkBq4/D1kCsTfNiYCPwudj7cJztZ1ryZtZe/
         A5x/kdwHVIkGSaZucO6/k8KBkvqiFECTlOYsIzrxPB4FnuFNuhdqRTAp1cSJhOc9FHzv
         89UnM5LJQuGNHiuFVYmHWFpYraC2UioqwVA0PYwqSGCb8m2Q0VLkz1ZMMTz2/YrBYA6H
         ZiCMG5jiMohgY+/Gfukyjbil0btvIf+S5QQI+MiE57Fgl1ZsyUM5k704gp1+jYPq2kvX
         E98A==
X-Gm-Message-State: AOAM530xX6IZjdhzTH5fKwVMvqbhuauCvL+Cn1fisbAPJCPpuPHqemuU
        /toihGVhfwLhv+D8xVa/kP7CbUNn
X-Google-Smtp-Source: ABdhPJyq5wNbCqdT8C1N4VONzEVBXFZtulnX6EQpq3SyP8dQD+7qPq8Hehbxy0GslsTaG5rPA6owrA==
X-Received: by 2002:aa7:d90f:: with SMTP id a15mr8262480edr.86.1595591089335;
        Fri, 24 Jul 2020 04:44:49 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r5sm580152edx.32.2020.07.24.04.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:44:48 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 0/3] x86 cleanups of leftover code
Date:   Fri, 24 Jul 2020 13:44:15 +0200
Message-Id: <20200724114418.629021-1-mingo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a couple of stray defines I noticed, with a bit of Git history
archeology to make sure they won't be used in the future either.

Ingo Molnar (3):
  x86/ioapic: Remove unused "IOAPIC_AUTO" define
  x86/tsc: Remove unused "US_SCALE" and "NS_SCALE" leftover macros
  x86/mm: Remove the unused mk_kernel_pgd() #define

 arch/x86/include/asm/io_apic.h    |  1 -
 arch/x86/include/asm/pgtable_64.h | 11 ++++-------
 arch/x86/include/asm/tsc.h        |  3 ---
 3 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.25.1

