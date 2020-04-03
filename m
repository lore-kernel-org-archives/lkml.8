Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE16C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7090216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="H1af8Mks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbgDCNfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:35:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43726 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390789AbgDCNfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:35:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id a5so6356280qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id;
        bh=GM+mgvMT3k+2f0NvPMnXcDGKuT1g94LTYgvXqNFPVYE=;
        b=H1af8MksrT5ZFPuIsX2xupnO7pHRMGyM+pQAho9rKIwg1sSxzftjHpyLEx68M5Qbuv
         F8c5IyDN1EliC78hWqS6p0FeZ3WgvrZK1JF2n8wOEgDd/3bRZru23RGjQXYoB7L4b+ys
         +jucwhBUGOrBo1+FVlF5/ky/4C7rA2y9NOOFiDtKqhzEvjdc2iOdb273CqtQjyqYsD7V
         QYcwtMdazRQb+06xK26gPlR/hwnr5QfPlA2+I0dt8gZYC99oMwExOQzC4TkeXdBwvZZz
         IPffH6GoFamKx82Cc4pKM9w853A65B+qDiXOWI1AR7EOJbpcOOM69BAyWq2c2E9N5Qio
         rCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=GM+mgvMT3k+2f0NvPMnXcDGKuT1g94LTYgvXqNFPVYE=;
        b=UlMv72nLEOGbvt7ha0IhCl5l3/RSjV1lvFf7++4MMfID4KPXcyFdBIC+GIh1bVF3OF
         cZjD3vVP6QLbqoX1T4fIqo60LEfbB1eda3+RuXcGJeLieN1zU24IqyoM454F9JcaW2+2
         71ALZuqAy83O/51/0sShOfQzuyvU9zDJVz/5zbdbFX3iMTx5sjCyyTbZT3F+APaHHTLP
         xYhKlKJGNndxnK4KI7U61Aomqtk2NIUQvEcCtVKSTtkTpZhj1EYbwNNeN7nhT/fR8ytF
         MwA9zQFuFWhFHiqzvood5EudhTq2COxahXDDnjosjPPYhNWodMA1z6MzRsm6c7XW5Tjp
         vVnA==
X-Gm-Message-State: AGi0PuZjuJUspoVwgzDdyK9ugJzURpmLEQ6Y947nhfXIjcH1sXFjHl6P
        IvxfbiaSn4FFcx4rlU1DT1g5RmAT5Cc=
X-Google-Smtp-Source: APiQypLlxSvY6Z0s7lsXTYU9K4OgLGVsqav1UBTHSXgjs82eAsgAOzfEWpBnduwH48aHmBkBMB+tnA==
X-Received: by 2002:ac8:6f6f:: with SMTP id u15mr2317461qtv.292.1585920951858;
        Fri, 03 Apr 2020 06:35:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 17sm6210799qkm.105.2020.04.03.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:35:51 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org, vbabka@suse.cz
Subject: [PATCH v3 0/3] initialize deferred pages with interrupts enabled
Date:   Fri,  3 Apr 2020 09:35:46 -0400
Message-Id: <20200403133549.14338-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep interrupts enabled during deferred page initialization in order to
make code more modular and allow jiffies to update.

Original approach, and discussion can be found here:
https://lore.kernel.org/linux-mm/20200311123848.118638-1-shile.zhang@linux.alibaba.com

Changelog
v3:
- Splitted cond_resched() change into a separate patch as suggested by
  David Hildenbrand

v2:
- Addressed comments Daniel Jordan. Replaced touch_nmi_watchdog() to cond_resched().
  Added reviewed-by's and acked-by's.

v1:
https://lore.kernel.org/linux-mm/20200401193238.22544-1-pasha.tatashin@soleen.com

Daniel Jordan (1):
  mm: call touch_nmi_watchdog() on max order boundaries in deferred init

Pavel Tatashin (2):
  mm: initialize deferred pages with interrupts enabled
  mm: call cond_resched() from deferred_init_memmap()

 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 27 +++++++++++----------------
 2 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.17.1

