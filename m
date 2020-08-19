Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF8CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8E320738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkl0ezOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHSS04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHSS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:26:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39656C061757;
        Wed, 19 Aug 2020 11:26:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m71so12116090pfd.1;
        Wed, 19 Aug 2020 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cBkxFxMunD1RE1+FdokZbDBxjG0yTuRlO8eeJ4noZmM=;
        b=fkl0ezOXLadrqHZj5oyDkOqpQ7Gq904tYea1uLbWLhY1Auapmj5MrpxDE9tZK267Ma
         CE+I7RnacpVl2AXG1OYqsVMa2LroiCd5pA5CxhYDM7ZPUEHNstWpPt3qNHQni4SUzI8X
         /a/feZol7rOkuu9XsDyBlKvb1MYeFBgKwMncysfLNP4Tp0FoCm4EvcR2oM7Dj/P0ga7U
         ng+QM6sLEYWNJ47SDeosmGUBL5GYN6bHFV8SHoLVeBmJG6+D356JZpfv8n8JIZD/vE/L
         izpQ3G01gXgQ5jjXcWRgALCdaznpyZ/1C9zSRE4A3W4RDvH6mulmymWy5lClJxgXXIkL
         6qHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cBkxFxMunD1RE1+FdokZbDBxjG0yTuRlO8eeJ4noZmM=;
        b=j+cekedwjI5JkoqiTCLxUzNXwUMR+QVCHxxp+BVfqE0LdH3nmGV/KPSuK+4YzSFNsa
         FLYTkA3soaRk4odry3Pugvia8iZDvZhOooWqasEXRoftFv5OiIyAUdU0f4PtYEKGLua1
         FAcE3U0aMNePsY8A6ljEfKcCvEYU5/Bk8Crxspa0YuEkzSR1yCPxbD7UPKLG2ZIQt+7L
         m6KY88HFNMH7AvDhGLVEcpcpf2K0bB1mA7XvbPVTwGHU32WMx4jsZayFp6u8jXdHJLqo
         4R5FoVxy23R7qnVaWb/QA4BSdCnJ7ZYVaeBYiIicbyFAAihjRfNNRDJkyJ+DVruviq2n
         d8Qw==
X-Gm-Message-State: AOAM533WlBuGCV6yH8PqSCWJflKH8Kj0UFwplZcrLoxE0ZRT6NMnhy3X
        pz8tU8QJMfPIYh4oqbk1Cqc=
X-Google-Smtp-Source: ABdhPJw9wNC43c5aZEKH2N4cv5Egx8CQlDKnf4jFfV5cmLqK4rj2/307sgfcpLhJuTcu7K6rrGB4AA==
X-Received: by 2002:a63:3d02:: with SMTP id k2mr16350471pga.302.1597861610618;
        Wed, 19 Aug 2020 11:26:50 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l78sm29448483pfd.130.2020.08.19.11.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:26:49 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Liangliang Huang <huanglllzu@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM BMIPS MIPS
        ARCHITECTURE),
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH mips-fixes 0/2] MIPS: BMIPS: couple of fixes
Date:   Wed, 19 Aug 2020 11:26:43 -0700
Message-Id: <20200819182645.30132-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

These two patches are fixes for the BMIPS5000/5200 CPU cores which were
missing an inclusive physical cache setting from the cpuinfo structure
and we would not be calling CPU specific initialization for secondarey
cores on the second hardware thread.

Thanks!

Florian Fainelli (2):
  MIPS: mm: BMIPS5000 has inclusive physical caches
  MIPS: BMIPS: Also call bmips_cpu_setup() for secondary cores

 arch/mips/kernel/smp-bmips.c | 2 ++
 arch/mips/mm/c-r4k.c         | 4 ++++
 2 files changed, 6 insertions(+)

-- 
2.17.1

