Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A80C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B3A2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGWXPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:15:48 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:40982 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgGWXPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:15:47 -0400
Received: by mail-qk1-f175.google.com with SMTP id l64so293797qkb.8;
        Thu, 23 Jul 2020 16:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCK5IhOfeHrsKWvFWWJWPxRK1T7/lPw/Gt6N/NVxpu0=;
        b=PgmIm9Svm2BYGOnCuvYaWzp/R/JXQKQIUR5/dvI/GLsT/0iQgHylozKaY7i0klgdjC
         9coawWyhd0qnjZV/UBH37yZ/FH8X1YlA6eTqvDOafpn+o5DUFl1dD3WURQUC1ZslR6EE
         i9j00+zhEYdC0cVt7gRpLcrS6zSuQiOZ8/g+S0qvExE81dNhF7rxayWXePx8zfpEbbP1
         E36PHZvLvOGRuI/24BGfTyZwH4RJ1MfOK90JRc8Pkji4DNbNdH2l+S3Ap9HetaahCEtx
         yUwmVe59/8pBeLsXIjGviQihUlLfyfCnrI/Ou9IV3fiDbKLSjxy1XsIFfQa1fmJ1pPY2
         famQ==
X-Gm-Message-State: AOAM5301icxmh5cNnrOInGjTN/urlYqxLRnit9QT/eQJC7zTy9f9O3ns
        w3mwK9JRsojwXi8yIOrYXDKYnVIy
X-Google-Smtp-Source: ABdhPJxGjhsHQ6lCTM9N6P84KeI8k5panpNx/IPPwLe6F0Umvuiw61o3taxh3m4DMff3eT2Ts8Npuw==
X-Received: by 2002:a37:4289:: with SMTP id p131mr7802401qka.28.1595546146808;
        Thu, 23 Jul 2020 16:15:46 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u58sm4196610qth.77.2020.07.23.16.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:15:46 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Drop unused MAX_PHYSADDR_BITS
Date:   Thu, 23 Jul 2020 19:15:41 -0400
Message-Id: <20200723231544.17274-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This #define is not used anywhere, and has the wrong value on x86_64.

I tried digging into the history a bit, but it seems to have been unused
even in the initial merge of sparsemem in v2.6.13, when it was first
defined.

Arvind Sankar (3):
  x86/mm: Drop unused MAX_PHYSADDR_BITS
  sh/mm: Drop unused MAX_PHYSADDR_BITS
  sparc: Drop unused MAX_PHYSADDR_BITS

 arch/sh/include/asm/sparsemem.h    | 4 +---
 arch/sparc/include/asm/sparsemem.h | 1 -
 arch/x86/include/asm/sparsemem.h   | 6 +-----
 3 files changed, 2 insertions(+), 9 deletions(-)

-- 
2.26.2

