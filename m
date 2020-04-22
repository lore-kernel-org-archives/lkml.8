Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB22C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC2B2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551552;
	bh=dZQR01F+Ei5zynP19srK6FuPTYFnWmWcEDDiqfVKfGA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=p1wrEdZyV+mxEASmoQUbNdJCqdKglivoEzVzPgJiRnfB0Tz2m8TiJ6ip4HWz6exxv
	 jKCbcR3rYeDrMlanTO/HGieB/ISWgj9sByDEsxpgmg9oB/LnhoO33qcW7a6FbQiRLC
	 YrHd/vztY7epFuDjYrHbMHgNMeOl6nlZztsq+WZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgDVKca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgDVKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:32:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B26AC03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:32:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so1744870wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9qT5N0HlpnMDUnkbn37SG8bW5Viuyft6HaRlW5BeEgQ=;
        b=XmuiqSb9/cQF4/SANulGpjtbhrjbh8Q94FBkXpSdjw51E1WZM0VyVhxx4/mE2uMhRO
         vSVkEv+fZ6Lf19/JdPiC+/vvvpnTDpvD8XllVwot9XoYgOoQUJZ9jhmhNAVU5ZWJdWP+
         ZMupUuEp+Df3z7h0T7nbDXR0bEJgq9v55KJwQD0lPaxwP99Ry1wz89+nfGaGRhaIzS6C
         RlFjIYn3zfllw/zPUYEwZtU9devS17kQLL0Si12Jo1Hkc/YPSLnW/rRl4UMM/z3I3mhN
         EU1bYEDEL5oxpYuYjC12g8yA77yqvFzVE1KWIab1WnXyhw2Bp4Vp2IXogLMiix8rmeqc
         qUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9qT5N0HlpnMDUnkbn37SG8bW5Viuyft6HaRlW5BeEgQ=;
        b=H174Tkq3pfBAe6TwRwp8QI9dt/D8dNGzH/BbVhaXZH/pkBOZaVrv1IlEkMlVkjMYPj
         rCT80ln/c9EX1RyvEZdYE61khTktCm4TW0fPMbw/cwl2B83/BDN+SwezGCtci5ncz3Yj
         fEVLWf6vDHQQKlPBv1FNfjLSByCp1QmZcLh8gA2L+/0vwLt2qClCCjb+67Kv+F2dZ58u
         9TZqbRmQyk/G+NxKsvUS/gR1r0nJ6gYI0t4pNjxwSGsqqzgw7pjkKcjINIWTJLqcftWt
         vDa6DOlyMhYprJ2KpxQFfNxzXQtFzxPH0/QNcq8Fhjb2XTDn6RNWY8ogjSrLcMEGq6JO
         MM1w==
X-Gm-Message-State: AGi0Pubaqdmw3+v3iknJa0QmLRN+s9aDckYAWSmiBqE4mt37uugLYlOo
        lupGS3T/eX8zz8wncepCb/cuvRF/
X-Google-Smtp-Source: APiQypKUk8Qp68qCr4yHUuT4laYRQ7MNpDzqaq7wsmTZtHVCcndmp74Bao26jD12AARePKjR3Ndevw==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr9161286wmc.146.1587551541852;
        Wed, 22 Apr 2020 03:32:21 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s12sm6891603wmc.7.2020.04.22.03.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:32:21 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/3] objtool: Constify most of the instruction decoding loop
Date:   Wed, 22 Apr 2020 12:32:02 +0200
Message-Id: <20200422103205.61900-1-mingo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify some of the decoding primitives, to ascertain and enforce that
arch_decode_instructions() is a read-only consumer of the various ELF data
structures. (Which it is.)

This is in preparation to parallelize the most expensive parts of objtool,
but makes sense independently as well.

These bits can also be found at:

  git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/objtool

(Subject to rebasing.)

Thanks,

     Ingo

====
Ingo Molnar (3):
  objtool: Constify 'struct elf *' parameters
  objtool: Rename elf_read() to elf_open_read()
  objtool: Constify arch_decode_instruction()

 tools/objtool/arch.h            |  2 +-
 tools/objtool/arch/x86/decode.c |  6 +++---
 tools/objtool/check.c           |  2 +-
 tools/objtool/elf.c             | 12 ++++++------
 tools/objtool/elf.h             | 22 +++++++++++-----------
 5 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.20.1

