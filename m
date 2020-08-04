Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C7DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465262177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHDXsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:48:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39018 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgHDXsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:48:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id l6so40135091qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 16:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUdum2YodPA2E66u4yOYUdwWKZvo61HusyJjK2vEce0=;
        b=MkA6skdvUJJXqCDfMMXtuqhYmnzF3psppqVNbnQF0l8UIAyuZLJr83VVPAj85QZCP+
         7931mwPelBJ+DPmvzC58Tlm2afDFyO2lyVBocgmKsICGZu9JOgsAcVKn/1ZFBOpuZjHM
         w1TN/3JtAgiLIYRHl2+EyjbWBpjPGRjmjk9pBi2ePCYTm/mnLeFQglarsob4+L5zm6p4
         SgzhiKTDTi2IlomDqka9GmAMRGicTiNa2T5i7b8TrqMVJD9aEQHcjJiPDj+2VgIO82s3
         poWfBOibXVIfUblb/Cbm0DhXDujtMCA8kvKu6xAERUB6/Lvpmok3lxE/niUlsFnMxcv+
         dchg==
X-Gm-Message-State: AOAM530kwxtRMdhC7T2OYbefIoXgJ8n3RglXRY9Vc/pjdJLtt4N+lnr/
        2TmonLOEi+E7FI59FtIEOT7MDQv1
X-Google-Smtp-Source: ABdhPJyhufJRGt/mPWhWUcc0ybo2nnYVvOGq1q9rjUNptfkS1Fy3nIT8Sut2y5QyMH07GrK0shCFEQ==
X-Received: by 2002:a37:a906:: with SMTP id s6mr731354qke.320.1596584898488;
        Tue, 04 Aug 2020 16:48:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e61sm526475qtd.20.2020.08.04.16.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 16:48:17 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Terrell <nickrterrell@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <xiang@kernel.org>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>
Subject: [PATCH 0/1] x86/boot/compressed: Use builtin mem functions for decompressor
Date:   Tue,  4 Aug 2020 19:48:16 -0400
Message-Id: <20200804234817.3922187-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <9753118F-84DD-44C4-8B8C-F45B8EE0FC14@fb.com>
References: <9753118F-84DD-44C4-8B8C-F45B8EE0FC14@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch drops a couple of lines that prevent the decompressor code
from using __builtin_memcpy (and __builtin_memset).

Note that Nick Terrell's patch [0] will apply similar changes directly
in the decompressor code (in-kernel and upstream) for LZ4, and the ZSTD
code already is partially optimized to use __builtin_memcpy for hot
memcpy's, but still improves a little bit more with this patch.

[0] https://lore.kernel.org/lkml/20200803194022.2966806-1-nickrterrell@gmail.com/

Arvind Sankar (1):
  x86/boot/compressed: Use builtin mem functions for decompressor

 arch/x86/boot/compressed/misc.c | 7 ++-----
 arch/x86/boot/string.h          | 5 +----
 2 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.26.2

