Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BEEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD3D20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC+KjSOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgENXwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgENXwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:52:09 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B72C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:52:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o19so454687qtr.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4nK4KUAsD0wRkYUyKiXcsXD7Jp5wBIQEZCx0CLP6xs=;
        b=gC+KjSOE2V2bGo9FIYegkLi2wPawgfKLZB0LZXLmVHH2cSOsvojzjuK2YGQ7LGkcmd
         8rSQlqEMgnBIcHNvx5CjwDpkf7mIw4GGJXrA65ciPLFKVguzt1cAO8dKhgqzA6UCtiC7
         szoLGdDNVQuFyWsM7HbaHteGFcpBhM+WWfSQqEEl9ubxTOG/JHJjUzzTirOrozIN9FdU
         1459vAEVqx0m9QEnGFAKbEBjotXISrxQMa/1wpY3waW7x+IZ3lC5ttWaAU8QK223Vko+
         ECtXyL+n30nP02bu/TOdlgaFKIgsRsHzXXP1NphQ1WQruProz9wLtaZCLxv6/EjdsFwR
         4GCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4nK4KUAsD0wRkYUyKiXcsXD7Jp5wBIQEZCx0CLP6xs=;
        b=KRVjohY6X1IuF8e4tp3+YhyIv1FK+U47Page0RU4rwyy8JOOh5B4zHAkRlTC1s8d0u
         2oK24F/u0fgHY2g/bVfPMft9BWuSx5OhwA8tEwXkDg/+WCNews/4tyH098knFqMnn9z/
         E3mK4dYGwVn9pox6ljDU0u1PBHUYONSPyv/4i0uvNbPyER5y857WpzfF48SyM3YUUrKY
         aauWWRhw/09kSD9BNR2saqY8ZkBCEijfKPKvlzVJrrAjyoHEPU+dfgOua14de2gWiAhw
         6Z2BI++Gwj1NqO0AQFy39DLJhjd2079dwUw627zCBIMQ1vW26v7KAqUd2D+Z+F+Itt3Y
         BdXw==
X-Gm-Message-State: AOAM532yC5YnDJDvljE6YczqfHtozB6y6RPZzOJVuBECka06QYXzuYqH
        2Nu+xIa7Xnl2Yt4hcbWBTxI=
X-Google-Smtp-Source: ABdhPJwk0pBxzOZMo7/7/3Lp3zPsMKGYo5qmEj55Lbtm2VG8xkdKlMm5M2h+/bd47lgXM2XIKzB0yw==
X-Received: by 2002:ac8:27ed:: with SMTP id x42mr757219qtx.231.1589500328982;
        Thu, 14 May 2020 16:52:08 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id j45sm644279qtk.14.2020.05.14.16.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 16:52:08 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Implement reentrant rtas call
Date:   Thu, 14 May 2020 20:51:36 -0300
Message-Id: <20200514235138.150722-1-leobras.c@gmail.com>
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

