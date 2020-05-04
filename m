Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30D9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C670206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNBXhgt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgEDMI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728547AbgEDMI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:08:59 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3DCC061A0E;
        Mon,  4 May 2020 05:08:58 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h26so6517874lfg.6;
        Mon, 04 May 2020 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzbFMK0GtKekycBtSo8VJeOSOQ0RJvtYJRWaPeEpP3c=;
        b=TNBXhgt6Cn8nSRpRhR1u+5kO+M8SiVQ70L7owxHviP4rKIzWYmdw0fMILtKSMjboWk
         SsbgNcUhUvDaOi6gi0H99o9zl0XDjx7Jqf2jC+savmqbelPlfY2OLeeG6oO90+dSaII6
         aFelV1LHLnkkamnbva7UOXPIxuPntVlJItefvEIh1dIpIo2mNrK3Z8Qt7cQxYF2RJWqx
         LxZCJE15438qy33LATDLFso5D0yJwV2qQXUecjnck/HBVNw3DzAOeK2CwTjQh3sPidfJ
         QVD01g4ph2nOiPeV73tUnQ/nNCjXQqguIHu1jlIHdCD7N4zxoJe12MUZxdEqC8rH7tpo
         yyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzbFMK0GtKekycBtSo8VJeOSOQ0RJvtYJRWaPeEpP3c=;
        b=eq/u3hz4YBcfQ+pFwpzR9fxSX1cUg2yTMKRkYJT0cPka094T0x61jqU1u2OFZMuqoW
         3Aw44AqIkCu8hdQopBluGRnUwy5JXDS1oWr61hqqPiEg3hm3d+dUayAZA95ZSxvuba7O
         CJkhatsFtASvfFnRGHW2PRMCk8TBS/NB1zGzbmDMHJ71OxoT16VFt8e5hOBK9nqNISJk
         Q6hagNfHo494sZtPeHZZV53bW5NR90Xw17YUTB1uB6/5RwXDCZMZJHZoFi28hH2A20hc
         ISLOXHfhz0ehNeHDFKmoVBMVPTXWnykdfvUyHtyCU0rqrrvH5X2K0oOeyPms/MHkzimY
         KBOg==
X-Gm-Message-State: AGi0PuYEpGcbwlRSmGOWcwT2zELLtVqldvSvqzL/nEPstZ0qMrlYPVnS
        3mzM2uxeZKQX94f2YLGvQtD+o9KT0jPht82gaa0=
X-Google-Smtp-Source: APiQypKt6GKV/iz8ojnW3UVKvprughzUaS7j4Bcwfic4aqNadL+zRXwkxmdi2a7BMaej3iC18m5Q0QUd1MCrJFIv8wM=
X-Received: by 2002:ac2:47ee:: with SMTP id b14mr7357462lfp.91.1588594137445;
 Mon, 04 May 2020 05:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191216103522.32215-1-gonsolo@gmail.com> <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
 <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
 <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
 <CANL0fFSNdzM-e=u+w0BTUqg5sQP_DuVBuJe9m0JDQnVTOPDMNQ@mail.gmail.com>
 <20191223164220.GA14394@codeblueprint.co.uk> <29b721c1-b5a7-6fc1-4471-f42109d509ed@infradead.org>
 <CANL0fFTCVj7c-EQTs1kRuOn8e++vgFw1fUTJfya12csWkJdGqA@mail.gmail.com>
In-Reply-To: <CANL0fFTCVj7c-EQTs1kRuOn8e++vgFw1fUTJfya12csWkJdGqA@mail.gmail.com>
From:   Gonsolo <gonsolo@gmail.com>
Date:   Mon, 4 May 2020 14:08:46 +0200
Message-ID: <CANL0fFQrO+kApsQd0N1+=_rPX_REBzpGf15J7Dmizb3WG1Xctw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Matt Fleming <matt@codeblueprint.co.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yes, it fixes the arch/sh/ build errors in my testing.
> I don't have a failing ppc64 .config file to test.

As of v5.7-rc4 this patch doesn't seem to have been applied and the
build is still failing:
http://kisskb.ellerman.id.au/kisskb/buildresult/14067948/

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ec1e595b1d4..bf20e5883026 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1281,7 +1281,6 @@ static int                      sched_domains_curr_level;
int                          sched_max_numa_distance;
static int                   *sched_domains_numa_distance;
static struct cpumask                ***sched_domains_numa_masks;
-int __read_mostly            node_reclaim_distance = RECLAIM_DISTANCE;
#endif

/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4785a8a2040e..733890d913ea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3523,6 +3523,7 @@ bool zone_watermark_ok_safe(struct zone *z,
unsigned int order,
}

#ifdef CONFIG_NUMA
+int __read_mostly            node_reclaim_distance = RECLAIM_DISTANCE;
static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
{
    return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <=

-- 
g
