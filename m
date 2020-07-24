Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7228C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC58C20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tj7tx6/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGXRU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgGXRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:20:28 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC92C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:20:28 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id z1so1056753qkg.23
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HNrBuo2EMN/xS+1Z8hxEE35aMqk1WeTu10gcXmwIBvo=;
        b=Tj7tx6/21Sjulp1orZHEiQcF+uS/wUAbrFLP+/aJO2iZCZa/NCyLfzaqTBv/HyrVVN
         +DWjpCClYWLYJjDT6Psx4G4ad20Zl9jQkYPTtnIwUsTSaV52mgxoffbxBySemvUDl3qA
         NYkz2KFvGkJTi2Ony5brKrozQqvyZYL+v6iDXuw8+cin7Cjy5ueDAca57TKhxQTr1ity
         xfX6TcmwJAi0S7xrEjbS0atfhM22Eb+b0JJf2NaCK1eFyc1Rrc7qFhMfjBUbcrM8eC85
         Are47u/+5XBZeQSQWqjZjg/UQ2maETUBPPFZ21c1r+1dTFm2Gn0LWnNrlqMiWHjGsUCD
         6S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HNrBuo2EMN/xS+1Z8hxEE35aMqk1WeTu10gcXmwIBvo=;
        b=CV2tJWA2ZPuh6SpJ3Q+pjcAXMS+gf+RRltKj8iNjQr1JnmUhVvLWMXRNq/WnF/jXCa
         usoRXbORjG695E/h2V+7VbA2yU+hU2YQTuc4Dj63+wtrDQKPWiOEGahCyztGKjPMbvuD
         pd95RQhA20/danxYAl50hvPYS5ICxoKCGfxh5Lo1G5fENTHJwjsyX7Iax2HorJ/98tbA
         6pJb5VODbbqFs8dyoCBstxs4OCIQmFvXiT+Aswy2P6ChNodjUIfJ2E7ZOjsfh8xOujhD
         Vw/L62EVChowunA3RxT39RZDTTeutXjgIkxU0M+FuNu5qr+c1NgnUSwq1gCCNQkUc8Bg
         0bHQ==
X-Gm-Message-State: AOAM532bjMuynL/4/oYmGmxZ9JPku6wqSuS31Cxjk6wrRZ9v82cAxHrP
        PbLByymFaA+rI54W5ug9Ufl5zqEvjZ8vIMQ=
X-Google-Smtp-Source: ABdhPJxnJRCvMFOxTRn8f0uG0TAW3nI8AqOVSkyMw9u32JNVm7tazfuk+rDu4xgtQigoXhr1iXCi3F2uUb82gM0=
X-Received: by 2002:a0c:f788:: with SMTP id s8mr10391772qvn.169.1595611227229;
 Fri, 24 Jul 2020 10:20:27 -0700 (PDT)
Date:   Fri, 24 Jul 2020 13:20:15 -0400
Message-Id: <20200724172016.608742-1-ckennelly@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 0/1] Selecting Load Addresses According to p_align
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ELF loading mechancism provides page-aligned mappings.  This
can lead to the program being loaded in a way unsuitable for
file-backed, transparent huge pages when handling PIE executables.

While specifying -z,max-page-size=0x200000 to the linker will generate
suitably aligned segments for huge pages on x86_64, the executable needs
to be loaded at a suitably aligned address as well.  This alignment
requires the binary's cooperation, as distinct segments need to be
appropriately paddded to be eligible for THP.

For binaries built with increased alignment, this limits the number of
bits usable for ASLR, but provides some randomization over using fixed
load addresses/non-PIE binaries.

Chris Kennelly (1):
  fs/binfmt_elf: Use PT_LOAD p_align values for suitable start address.

 fs/binfmt_elf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

