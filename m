Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89509C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60310207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCUbSwtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgERXn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:43:26 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD19C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:43:25 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i14so12444361qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/BUTFWn5tjRK73c5c6DPEmUZHTVf4XstVliLRILe5w=;
        b=ZCUbSwtPCuF4NIgCIGuEqn70DPQqUz32xVhcv4TDzPsN/k3+ij3z61pgBvxWGkJ9fB
         ntR1/FjZyAeOL04hWOzK6/cxhIPOhwjlHEVxZDHqPblGHkP8szZuHk1kIKXI6R4qsOFY
         BNOLuJvxUHv05n05OBIenTnitjMrwZhXn3r04JXXGSgm/bP05n6dvfT3pOvU3jNoYLrE
         1O4KwyBo/N2xD8c2tCWr/aMMiTsT5HHbaqig/SqC20NBtDJsIucaOP9SU0yDHsIcK7K6
         iaMEBtUlnHbwejUnbu4EPiAfv8lI6fRx4/ow/8L5xPlaUFbLEK695m4GgkxwQoXg5ryy
         PkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/BUTFWn5tjRK73c5c6DPEmUZHTVf4XstVliLRILe5w=;
        b=UNRHwrgiDsGxbA4NeKmSiFftk1x13EEv0vyCbCTnjdc8kKh8J/saLi6nlP+1SZ8d3m
         NmbGzPMVsTBuf9GePtnwlb+/ue1POKT9OqeLvVWITXdijDeoSLw7npK3ArV7uIVyLlhP
         9VxbrVhiTZE/rYGQI3xaakUQMT5rPtxqz5dmRx4eo21WPTt9p04aTbRqXPiDwhYK+6L0
         jRI9F4wUbawVGW+5JVZloBCTuZXUMrQbQ1Mxxio7JrA/jur6/W/x4pl73UUFLGgDPxFf
         eObivy7QErcnrWTh9OEghB1oHJZsKfvIAe0fimgDHSDnbIb3sCWcWi0JIlazX4+yXI6c
         H4jw==
X-Gm-Message-State: AOAM531NsilXM57fh4BVi9gCwAmr9L+lY95gts/aoHCgNLsraBOF6wKx
        dikxeqgrvjqsGuopLYLaXoA=
X-Google-Smtp-Source: ABdhPJyT8AKxWIpnr+Aac7V1r5WQmrYgwAqTbmGOqqa0qW7AR0PzEgVaFSLZiKr6BStMnrw33p02oQ==
X-Received: by 2002:a37:7904:: with SMTP id u4mr18362247qkc.297.1589845404813;
        Mon, 18 May 2020 16:43:24 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com (177-131-65-239.dynamic.desktop.com.br. [177.131.65.239])
        by smtp.gmail.com with ESMTPSA id 145sm9135772qkm.110.2020.05.18.16.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 16:43:24 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nadav Amit <namit@vmware.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] Implement reentrant rtas call
Date:   Mon, 18 May 2020 20:42:43 -0300
Message-Id: <20200518234245.200672-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 implement rtas_call_reentrant() for reentrant rtas-calls:
"ibm,int-on", "ibm,int-off",ibm,get-xive" and  "ibm,set-xive",
according to LoPAPR Version 1.1 (March 24, 2016).

For that, it's necessary that every call uses a different
rtas buffer (rtas_args). Paul Mackerras suggested using the PACA
structure for creating a per-cpu buffer for these calls.

Patch 1 was necessary to make PACA have a 'struct rtas_args' member.

Reentrant rtas calls can be useful to avoid deadlocks in crashing,
where rtas-calls are needed, but some other thread crashed holding
the rtas.lock.

This is a backtrace of a deadlock from a kdump testing environment:

  #0 arch_spin_lock
  #1  lock_rtas () 
  #2  rtas_call (token=8204, nargs=1, nret=1, outputs=0x0)
  #3  ics_rtas_mask_real_irq (hw_irq=4100) 
  #4  machine_kexec_mask_interrupts
  #5  default_machine_crash_shutdown
  #6  machine_crash_shutdown 
  #7  __crash_kexec
  #8  crash_kexec
  #9  oops_end

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>

Special thanks to Nick Piggin, who have been helping me a lot with
this series!

---
Changes since v5:
- Renames new paca member from reentrant_args to rtas_args_reentrant
- Compile out rtas_args_reentrant if CONFIG_PPC_RTAS=n
- new_rtas_args() is skipped (returns NULL) if CPU_FTR_HVMODE

Changes since v4:
- Insted of having the full buffer on PACA, adds only a pointer and
  allocate it during allocate_paca(), making sure it's in a memory
  range available for RTAS (32-bit). (Thanks Nick Piggin!)

Changes since v3:
- Adds protection from preemption and interruption

Changes since v2:
- Fixed build failure from ppc64e, by including spinlock_types.h on 
  rtas-types.h
- Improved commit messages

Changes since v1:
- Moved buffer from stack to PACA (as suggested by Paul Mackerras)
- Added missing output bits
- Improve documentation following kernel-doc format (as suggested by
  Nathan Lynch)


Leonardo Bras (2):
  powerpc/rtas: Move type/struct definitions from rtas.h into
    rtas-types.h
  powerpc/rtas: Implement reentrant rtas call

 arch/powerpc/include/asm/paca.h       |   2 +
 arch/powerpc/include/asm/rtas-types.h | 126 ++++++++++++++++++++++++++
 arch/powerpc/include/asm/rtas.h       | 119 +-----------------------
 arch/powerpc/kernel/rtas.c            |  42 +++++++++
 arch/powerpc/sysdev/xics/ics-rtas.c   |  22 ++---
 5 files changed, 183 insertions(+), 128 deletions(-)
 create mode 100644 arch/powerpc/include/asm/rtas-types.h

-- 
2.25.4

