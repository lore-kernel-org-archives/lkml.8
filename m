Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA4C55197
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FCB2074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587805489;
	bh=2kRYFuESsAW8Hfdc6hCT2Hr7mEIyMimGQVDQxZXW+AI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SDVWIi+i29gEwXWrFnsQrhKTl8TzuTVUIdTlHWbJ5FNWAxWOJXmkvzIxCpGOIHOGo
	 vc45qcqwzk8P+0pWyXKVdfQrsYqttWRG7v4lywa+88p3zS6aAoQvu+KaiQUOBiiVDs
	 l9gPMkBxDwH5HQvK82K4U+huqqlCXUrGFSeW0MeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDYJEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:04:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26EC09B04A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:04:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so14335186wrs.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3rg9MHa/vizuq71suUnkh0Km+AwnJhqBvLwKJWaVX2E=;
        b=Uni9kHuhLrw2qc9a0graKB9EjGQlKECie8GA3mcy/GcXDY5d8QzdN9rkb47Lp65Kji
         vELg7ahZJrt8lPeT8iihqZDQUeQ2ZJE66EpJd04ZCiFk3QtLyPkIJbIYgL95HMYcc9gp
         E+dU4Gu5F6VDIuFh49ZbV4a5bVQCrQJlYYra9qWaPI6ylIy46EHfq08jw6nhxqYlcFkk
         SMDUsiZzaPmbOkasPKi+Hz4epPkoEMry7MiyNQFaPSQo1+K9CIkxY6olSE7VeKkAwqUf
         JeG+a/Mfeu8HEB9FoqV6wHpoNPSdJtZHB4+UiQ9lZO9XiLUsUbSywDpmY55LMW741rEm
         aXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3rg9MHa/vizuq71suUnkh0Km+AwnJhqBvLwKJWaVX2E=;
        b=oj2iPSJfhepl2lOAoVje/NnUv/jumJ8/BVXzYp8ttjIfiibEyp1BtjosPAoUxXvJ7U
         pjgdxwVQw3VMb4RtYzC710RkG7vg4Ba74wDrarc/wP/V58l74mAq6ZCROPk6OWMAp1VT
         xeb5dRpTXd4/KThHRwfnMu53ECo7pKC1j0RsVHdhXfuxnmJ4ukw8oo4kAia4ZQApY3wN
         2c4AKcXseZDas1ulALi3aO1F/fZXmoz3mpLOpOCFf0bls2g38EFuPkED3LKGidlJFqlD
         ifkFTXPzlkk1gJHDg87jmX2ykk4cSI39bfDcV3UJJ4tdwsXJQewg1KHFh1u4JzNvojo7
         ZhDA==
X-Gm-Message-State: AGi0PuZmwjGfMZuD/AKoBMwfiZJ01OtA7X9zjHvks4juVFmPYXPS4i4f
        OAxZxdn5cRhOpjHBSHhcIj1pEqJV
X-Google-Smtp-Source: APiQypLRSrPFhlSX9x25rG61/ZhiPWpFspEugSahq9ZejfayJxenk1XAM5lGDju5gLU9FeXbfWUe/A==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr15558862wrc.43.1587805483166;
        Sat, 25 Apr 2020 02:04:43 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o3sm11784337wru.68.2020.04.25.02.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 02:04:42 -0700 (PDT)
Date:   Sat, 25 Apr 2020 11:04:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool fixes
Message-ID: <20200425090440.GA108057@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2020-04-25

   # HEAD: 7f9b34f36cf6b2099f19e679a9e8315c955ef2ee objtool: Fix off-by-one in symbol_by_offset()

Two fixes: fix an off-by-one bug, and fix 32-bit builds on 64-bit systems.

 Thanks,

	Ingo

------------------>
Julien Thierry (1):
      objtool: Fix off-by-one in symbol_by_offset()

Peter Zijlstra (1):
      objtool: Fix 32bit cross builds


 tools/objtool/elf.c | 2 +-
 tools/objtool/elf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 09ddc8f1def3..c4857fa3f1d1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -105,7 +105,7 @@ static int symbol_by_offset(const void *key, const struct rb_node *node)
 
 	if (*o < s->offset)
 		return -1;
-	if (*o > s->offset + s->len)
+	if (*o >= s->offset + s->len)
 		return 1;
 
 	return 0;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index ebbb10c61e24..0b79c2353a21 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -99,7 +99,7 @@ static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
 	offset &= OFFSET_STRIDE_MASK;
 
 	ol = offset;
-	oh = offset >> 32;
+	oh = (offset >> 16) >> 16;
 
 	__jhash_mix(ol, oh, idx);
 
