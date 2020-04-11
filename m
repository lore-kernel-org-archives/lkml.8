Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF317C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765B12051A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b34uiPk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDKWEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 18:04:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36375 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDKWEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:04:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id a201so5852852wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QMdbDycZrI66Fi6FRwlCFSGbMp0sxstyHyqa3xK8LHE=;
        b=b34uiPk8DspIRoaI9c9aiomfii/cLTu7bX5PVltOE8SOJ5d5Es3i5PYKW+sWtc0b5L
         bDRvSPOYP9q6DRCOtHZODpDMbzEgKQvlAyW3GPOLawRWvbHDZSMtMNKVu+1ghxstAQN2
         AcKDFSFTv5+tH7QbyhgkqF7Zuh/iYttF+Ga+9WKDPq4cHo0S9Hos3iSWcQez2yJO7/e1
         trBvvZMQDr4iO+mHO2JZ0mD1GP5IoG+gMmhmfNdtmuX9r5aH6K/LUTzM4Z8fs3QcirMp
         x7ljeF/2xJk/mEN2G+mj953+sNd4jwfqqnR+AA698bGUyCkbHugqPJVeXKebnNy/FXMI
         lFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QMdbDycZrI66Fi6FRwlCFSGbMp0sxstyHyqa3xK8LHE=;
        b=K7ntOZ5LVVWxOWkyMCwfmBgSqiPIsyTQyhhVZBsMeGfq9mqdPspXznfLVeK5GL0WTd
         r3+/7dhcMSCfaGTK30j4Bk1IKKtVvgtuwkSnLmYIOrgbYiznYoSSO40KhCC9g9CI5v6S
         mAjg4jEfh8VmTjrk3h1DqpdfzHvAy0gQCZfftD9+AqnVladCHMokWVB/slilh8VACXdE
         1bWpNtwZvuzz1828UJvaHDHBpaOEV2F4e29k5bHsn6z3KMyegSx59p90yuoCVDGok8qO
         60PvRjV48xxdqenoq8OYZqPfFs95uc33IUJ3qq/u3OEcdtzPYkNpN/oYSysmCe8d561G
         Jdww==
X-Gm-Message-State: AGi0PuawnY7BAYIF77qe1F0PFNG9j87EAVJ1Vt4xblYCAEyNz3ApS9+h
        dOWFCyFhwVf106k7KVOwY5o=
X-Google-Smtp-Source: APiQypJ82oh4/G08ff48aHX9dGZ3bYQ8b8lp5rlV0inaqsaWiN27iHoABuUrsxN6SWGuH/lBn9Q++A==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr12052738wmb.4.1586642663437;
        Sat, 11 Apr 2020 15:04:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g74sm8338160wme.44.2020.04.11.15.04.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 15:04:22 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, anshuman.khandual@arm.com, david@redhat.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3 0/5] mm/page_alloc.c: cleanup on check page
Date:   Sat, 11 Apr 2020 22:03:52 +0000
Message-Id: <20200411220357.9636-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set does some cleanup related to check page.

1. Remove unnecessary bad_reason assignment
2. Remove bad_flags to bad_page()
3. Rename function for naming convention
4. Extract common part to check page

Thanks suggestions from David Rientjes and Anshuman Khandual.

Wei Yang (5):
  mm/page_alloc.c: bad_[reason|flags] is not necessary when PageHWPoison
  mm/page_alloc.c: bad_flags is not necessary for bad_page()
  mm/page_alloc.c: rename free_pages_check_bad() to
    check_free_page_bad()
  mm/page_alloc.c: rename free_pages_check() to check_free_page()
  mm/page_alloc.c: extract check_[new|free]_page_bad() common part to
    page_bad_reason()

 mm/page_alloc.c | 74 +++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

-- 
2.23.0

