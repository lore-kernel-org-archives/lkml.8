Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6448CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDCE205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6lWwHVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgENBNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgENBNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:13:37 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0836C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:13:37 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j2so1536029qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJ+UkeznHslDwbeNLir1XZYmQ/0y7hByJcBrFbnYXW4=;
        b=o6lWwHVvKWLLPT7TEcuduO3YEEsc+lC/rZyYhJaHfVLFfMvHyOhX7N65rKnsxIloP7
         6rX4IXEdoPcyUvJqcwsBTGKiqqXZewnlGfD8nqhdYd0BrIXVExU6L1cElhuJQKhTEWnh
         J0u5M7EGH1QOhJjfnUCQoF9urNo6ZdmmN+Hp8NwsKzCqewLsH+Nh/3Qp2/fjJxz9CTe4
         760QALIU5mkk8yLsu6PbBEOX4qGNsdYtcip5Yz/j7b0myP1IEtBjYtCgZTDJzPz9uccI
         drGOYqL6Wc9QtyjeVCoJHTwFZvSBcYGDWrraB8J3Rjp2ddsbP/ZZpqNTqsKwDU6M7JKl
         HrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJ+UkeznHslDwbeNLir1XZYmQ/0y7hByJcBrFbnYXW4=;
        b=XtXeUcnXjgKkopfckr8JS5PJjPcXneBMJRyAxtxQWi+0K4NS34SdHyyQO3TBPCKMxE
         NiNj55bgPm5t8AXZ8bMeBlGx8bc5QsIuN9hWOaNwJs+RwreI2tQDtuoDBRllc7/QYVJB
         UM+n7z5rt6mDACF4KfOYgguJsUjLBONDhFFUx6fDTgWRzw6S3iTI10QDgoAVLsbVAfoD
         +FheK6W8x4cmqUt189G6ss4hCQr4EBDrA4WyOKJ7DkZG+6eyqmWQ89hCuYZSY85CLFej
         oeqJY4jd/QHLmv9S1aq7q8mfKzB6BdovInpWBZZbs6ienhxNnf7SYnTjkJOlkL4Ab7F4
         0LTg==
X-Gm-Message-State: AOAM532ffXZ0v2XLyWSG09epMvbl3UMw4s/68EnxY0XBxFDZ2/cYO6AF
        iJzhJHJXzIM3MmWrY4rexOMzg93m
X-Google-Smtp-Source: ABdhPJxQEwtFG+28xOW3LWQtXRD1PCQfChKK6arCzdVJfZ7rBg8XyKCa3dyAhOMM51nPcdhl65BTXQ==
X-Received: by 2002:ac8:688c:: with SMTP id m12mr1972781qtq.238.1589418816846;
        Wed, 13 May 2020 18:13:36 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id j11sm1308314qkk.33.2020.05.13.18.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 18:13:36 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Implement reentrant rtas call
Date:   Wed, 13 May 2020 22:12:43 -0300
Message-Id: <20200514011245.127174-1-leobras.c@gmail.com>
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

