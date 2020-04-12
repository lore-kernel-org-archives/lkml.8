Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD2EC2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82B0206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZIaB3Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgDLJNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:13:02 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36193 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgDLJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:13:01 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so2634150pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=LfvvcUpq2FDP8LIShcAOisvw6VyejprD1pNSIk/3HfM=;
        b=OZIaB3Hp9mGYcRd9yIsPoQlX+8fyZAjTy4eW4wEY5bNHdn57ZS2Ls8C5H3GCr70Unt
         EtByddlnJRhDXHXrgMayn/azIoDAAAA+MbcyZ47VWClI9fbDFjcOP8OiKDAjzWRhpFmY
         7Pfy5gDiQKSYA3kWKzy/ErBOs73NrKDFBnkr6bsh3qBTGCMZyPoG5VHmamsr5ypQlw/2
         LdcG8EuUyX3McHTUHRuZfwbAMqAOAt0xsFjXVBHj/QvuUsek/0RqcNRVzZnDPLSpcr8c
         Ef3uEKLORRIRHyTTLlv+Ir5djdHK5ciOKEZqphPpJsu3pFghDREYaac68f9WiUl/0roN
         OqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=LfvvcUpq2FDP8LIShcAOisvw6VyejprD1pNSIk/3HfM=;
        b=Z/ikp0qZGX2gFKc2KXe9rQhR5OeBGaNNhHJGxLljWzicS3vVzyLA6FRJU2SYYOMhhy
         r+mo3xQLV+74zj8vK99XVYOTeN73F1vrhm5sjSVFXFuR7yI3VSUr6E5d26h/acuRPX2x
         +SuBZrwkK6v/eKIB4bfSt+Ldaax0+5gYAV951Syu1A73toRSJiyRDfGKDnXiBlhzpOQA
         OhA+V5p0N3bKvuEOknNqMLvGNKr7QzSmYDv9yLyriGOD2Qu40KbmiwVWwt9RKC6Vzmf1
         yBczegfJPY53wLeXR5PVJ35XV24AjDnhbv4NSZAAZou/nYhFDkCgVT/56O7H6HVkEntk
         g7oA==
X-Gm-Message-State: AGi0PuZp5lsh8pa6N1xb3fNIkTGhL9jiPIercOXmOeqxNFMntGluMq1s
        eoOQrXZk1Zu9Q6D0fJHBrsM=
X-Google-Smtp-Source: APiQypK2+SbPWYDwAaMikOSsmCED4pKg8K/I5TQ0zYj+iHsrwsi33Mv5xyj5Pqz9/a991qhcHGv0Cg==
X-Received: by 2002:a17:902:6b01:: with SMTP id o1mr12665327plk.100.1586682779821;
        Sun, 12 Apr 2020 02:12:59 -0700 (PDT)
Received: from open-light-1.localdomain ([66.98.113.28])
        by smtp.gmail.com with ESMTPSA id w192sm4621946pfc.126.2020.04.12.02.12.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 02:12:58 -0700 (PDT)
From:   liliangleo <liliang.opensource@gmail.com>
X-Google-Original-From: liliangleo <liliangleo@didiglobal.com>
Date:   Sun, 12 Apr 2020 05:07:32 -0400
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [RFC PATCH 0/4] mm: Add PG_zero support
Message-ID: <20200412090728.GA19572@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero out the page content usually happens when allocating pages,
this is a time consuming operation, it makes pin and mlock
operation very slowly, especially for a large batch of memory.

This patch introduce a new feature for zero out pages before page
allocation, it can help to speed up page allocation.

The idea is very simple, zero out free pages when the system is
not busy and mark the page with PG_zero, when allocating a page,
if the page need to be filled with zero, check the flag in the
struct page, if it's marked as PG_zero, zero out can be skipped,
it can save cpu time and speed up page allocation.

This serial is based on the feature 'free page reporting' which
introduced by Alexander Duyck 

We can benefit from this feature in the flowing case:
    1. User space mlock a large chunk of memory
    2. VFIO pin pages for DMA
    3. Allocating transparent huge page
    4. Speed up page fault process

My original intention for adding this feature is to shorten
VM creation time when VFIO device is attached, it works good 
and the VM creation time is reduced obviously. 

Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
=====================================================
QEMU use 4K pages, THP is off
                  round1      round2      round3
w/o this patch:    23.5s       24.7s       24.6s 
w/ this patch:     10.2s       10.3s       11.2s

QEMU use 4K pages, THP is on
                  round1      round2      round3
w/o this patch:    17.9s       14.8s       14.9s 
w/ this patch:     1.9s        1.8s        1.9s
=====================================================

Look forward to your feedbacks.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>  
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: liliangleo <liliangleo@didiglobal.com>

liliangleo (4):
  mm: reduce the impaction of page reporing worker
  mm: Add batch size for free page reporting
  mm: add sys fs configuration for page reporting
  mm: Add PG_zero support

 include/linux/highmem.h        |  31 ++++++-
 include/linux/page-flags.h     |  18 +++-
 include/trace/events/mmflags.h |   7 ++
 mm/Kconfig                     |  10 +++
 mm/Makefile                    |   1 +
 mm/huge_memory.c               |   3 +-
 mm/page_alloc.c                |   2 +
 mm/page_reporting.c            | 181 +++++++++++++++++++++++++++++++++++++++--
 mm/page_reporting.h            |  16 +++-
 mm/zero_page.c                 | 151 ++++++++++++++++++++++++++++++++++
 mm/zero_page.h                 |  13 +++
 11 files changed, 416 insertions(+), 17 deletions(-)
 create mode 100644 mm/zero_page.c
 create mode 100644 mm/zero_page.h

-- 
2.14.1

