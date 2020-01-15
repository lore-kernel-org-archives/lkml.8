Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF9C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD152187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Osp9npf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAOGhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:37:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44833 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOGhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:37:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id 62so1382384pfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 22:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZL5+wtQV8L4I+t/B21mqCEwpOPwMzNG/NjS3uxYK18=;
        b=Osp9npf9DMbWRL/vufgokGg2WptMrjKk3OPeCm/0ik25WiMSpPAb4kujwVnvH7fOil
         oU+ORo+jZAMiq5H28oyIZLUvOcanWtdUkJ1mlpumXIg2C+EfGVsiU2cpuQimXlNAFfD2
         CVNZ4fDwlbPddmZWH/mpOH9zJsOU7fOaymLRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZL5+wtQV8L4I+t/B21mqCEwpOPwMzNG/NjS3uxYK18=;
        b=oiurZYesTIUwgf1/k1sn+3EUUj69Hcih3bM1wx7zHy3YxpZnvOu7bAkA44bYdKfmnY
         JSb6oNQPyRATP8+uwVgQSS/6go5ktVquwkjLRDhmiQAavN3avznzO9Fm25BGo0Gel63o
         Y0DlX5a1ef0SrZkmHieXHm3H20Tl0o/pKyNzZAhpi8Np4fskniCdIjxu/rVthcpXeTPc
         dI8EHqqlIgSczKsxlo0Xh9O774ZcmN5ybhgsbIZ/ipTgmdy9F180VgWcZAzNcki1U/ij
         1OGzqW/VJb9syEsihuc9uYxNV2X9vAQ6Dj0xg02W3VMYSIOVpdGWHVygMfah+2QYc1of
         63Rg==
X-Gm-Message-State: APjAAAX+ee0p1/lud4fXI4X7RyGAM2EW+rs9RqvBuuGb0isDVtGAZqil
        tsNvFFDBUIzinLmgH6n13sy0ekQ1Msc=
X-Google-Smtp-Source: APXvYqz6twM/JSD4CFgc2SQAuWMMi7JwPofxcZnEA5RSwS0BHmT29NIEpqvWOQK7nIn36loT9ArrVg==
X-Received: by 2002:a63:2949:: with SMTP id p70mr31822201pgp.191.1579070251356;
        Tue, 14 Jan 2020 22:37:31 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-8d73-bc9d-5592-cfd7.static.ipv6.internode.on.net. [2001:44b8:1113:6700:8d73:bc9d:5592:cfd7])
        by smtp.gmail.com with ESMTPSA id k12sm18720866pgm.65.2020.01.14.22.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:37:30 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH 0/2] Fix some incompatibilites between KASAN and FORTIFY_SOURCE
Date:   Wed, 15 Jan 2020 17:37:08 +1100
Message-Id: <20200115063710.15796-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
memchr, memcmp and strlen. I have observed this on x86 and powerpc.

When FORTIFY_SOURCE is on, a number of functions are replaced with
fortified versions, which attempt to check the sizes of the
operands. However, these functions often directly invoke __builtin_foo()
once they have performed the fortify check.

This breaks things in 2 ways:

 - the three function calls are technically dead code, and can be
   eliminated. When __builtin_ versions are used, the compiler can detect
   this.

 - Using __builtins may bypass KASAN checks if the compiler decides to
   inline it's own implementation as sequence of instructions, rather than
   emit a function call that goes out to a KASAN-instrumented
   implementation.

The patches address each reason in turn.

As a result, we're also able to remove a snippet of code copy-pasted
between every KASAN implementation that tries (largely unsuccessfully) to
disable FORTIFY_SOURCE under KASAN.

Daniel Axtens (2):
  kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
  string.h: fix incompatibility between FORTIFY_SOURCE and KASAN

 arch/arm64/include/asm/string.h   |  4 ---
 arch/powerpc/include/asm/string.h |  4 ---
 arch/s390/include/asm/string.h    |  4 ---
 arch/x86/include/asm/string_64.h  |  4 ---
 arch/xtensa/include/asm/string.h  |  3 --
 include/linux/string.h            | 49 +++++++++++++++++++++++--------
 lib/test_kasan.c                  | 30 ++++++++++++-------
 7 files changed, 56 insertions(+), 42 deletions(-)

-- 
2.20.1

