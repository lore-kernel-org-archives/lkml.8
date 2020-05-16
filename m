Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A253C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 05:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBCB206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 05:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVKlP/qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgEPFWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 01:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgEPFWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 01:22:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7654C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 22:22:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z80so4962048qka.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGai4hOvcQ9X3rtvTu3xZbDmHCYKbPB2sPDJuutDN9E=;
        b=OVKlP/qqpZdmsf2tmTqEGRjDtoIzlzp7QDEAlSZJozB+bfjOEpv2EZPc3iSRlE4eFx
         BP0ajzFElW7XkBk+fLUuMj1p3nG4JmNugl+oNFgMuMZP+LqBNl+J8j0+dvhd+EcRuenv
         B9YgNDoRY/mLNlhBn32GouMCwFWokD2ahgaarRmnZMKqZkvqz5pRdkuF4Wk7eGzgQJ46
         cb+f7/mqxuobpmyl3yoik2ji4SH65u1D6wigyqNngMPq6buJunXhJOD10O5rVTmeiQg/
         h90TqTsrSIp9zmMET66Cmp+L3ZzZH4iqNv8US8oaP75AJB2DBQP3pU/bMimx5yEAqyC8
         7ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGai4hOvcQ9X3rtvTu3xZbDmHCYKbPB2sPDJuutDN9E=;
        b=hcE8Mu4Acsc+AIwYwtjT75epcLCuuUJh54IVR2NKsqOMuLsmtFDECSxJnWhdDL4+a2
         g9yCapEjVI3JnKcGiwBSg+OfNuMCItfrGDcKFPSdmDISvynrCkRbEL8dpWdUvD1xX70i
         00Mp5xavFiWOSjnDRtVPUIBe8XfkImNpFtmYo7GIcKVhzaZH+2fjVo+Knw59cpL3cRKK
         y9IdMGC0Z0QCGtn/vupvqu8Uhjy6LzlglIqbrU3do2+iMOsIPmLrpv7G1Z9aoxwdAhhh
         U/TpJnbzfXaZxXhnVHVQnvz1+9imxzBed189mGIKiyPqGfzM8XSPqPQ5EuklZ7eRDPPN
         NndA==
X-Gm-Message-State: AOAM530z3NZDCyVTO0Hqdw9utA6ZWRb4jisobCzpwajZzvNz2zFxDhmi
        MsH0QBedxKpv3iws6fQyoqU=
X-Google-Smtp-Source: ABdhPJyyPFsAmnSIf30NB7b8EAHziLzGnBKxyPDTj9U1kLHfm2i97HvSHeIU3NSBesChQIvVmdQ9fw==
X-Received: by 2002:a37:4fd8:: with SMTP id d207mr6259763qkb.345.1589606541964;
        Fri, 15 May 2020 22:22:21 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id u20sm3866721qtj.97.2020.05.15.22.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 22:22:21 -0700 (PDT)
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
Subject: [PATCH v5 0/2] Implement reentrant rtas call
Date:   Sat, 16 May 2020 02:21:35 -0300
Message-Id: <20200516052137.175881-1-leobras.c@gmail.com>
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

---
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

