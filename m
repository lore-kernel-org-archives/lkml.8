Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26DBC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B9D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585642532;
	bh=H+yiLdh34yDV0snTOSRn7pw55I9IsYIwvDJbXXO2NaA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=J8JNXjb0WbaQYorL2U6OPAKFTUhITLP4SgbaufsYLKQw5zE+pizlrJSV46TMWuFwV
	 No125V0OjDw6wnqqj30vHeO5aFaV5m4FYR6KXDIuIBTKeJAFc8r603lF+N+Yj9VxsB
	 tsRISffT6Vd9XR6RdN924oDbwfpCVUnHFj6PglLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgCaIPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:15:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33890 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:15:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id c195so498475wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0VDGph3ZfTcPVPTsRWUv3Of3uFjPtheMhjsRbIUw5e8=;
        b=IRGDAH1H8FCvBDaDWALqLvXSRjUV5W9IERa5XvFxW/kxLeQoXhEmU+71rHR3XzizZ+
         pQtpK/uNbKkC2kAoPrERiAInc6i5RbD+ufr8itBuC6KR213KDCdc8YDNRuP25Ve7g+BD
         CGveaH+8/KGsxyGsY2jqRxWUGSufecjKninEDce7JeST+WIKBXtiIG4+0oqFoybnskn3
         ufkGybbfmaaaBYqp4o+QPdTQp9zPZEzjx40IN5enhjZSa0u8zqECDifHNQLvtaLbVp79
         pfy7izC5zgVX3SnDcv0XZTA7qfQNwSFdenxnGhkKTVCz2PFCOJSVal+tmMHo64dGkWgg
         9ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0VDGph3ZfTcPVPTsRWUv3Of3uFjPtheMhjsRbIUw5e8=;
        b=shFk8dpLp/KAH0ziUvPMBPnml2kbfzts6aobjTPxDNEqKa433b7bnmIQiNGprJE5TN
         KcT8PzumNhDVlwjVaNYzwJ5qYw6s0ZjwB8beT3ZbwNhCn4gsPOl5LpPrOObUHYDF1Fwr
         ZtlzXEUcMNL/YZ9sc2B2hkbmvxjs3dBLXIJPjw0UDJbwNdkaQudb3qvluA3HDuWUNhXa
         OTni3WOiKZ3Pz7EZRbvdlN4NcWEmeup8G3I1ht2M2cpIbuPepGLSsyjmKlX4cwqmLdsf
         Kk/5OepaXomnbhW183W/Ilel97QqrryBflJf6bTgTXk6i2tRBmRrEuEXPN27Fyh9Diu7
         7Tvw==
X-Gm-Message-State: ANhLgQ0dOf8R8qH7DKgS7w4R6C+MKl4AhWq/JUV0/ds0ZVay9ExVbsBL
        uU2WsZIqLvlPK8+oLi3V20A=
X-Google-Smtp-Source: ADFU+vsx+bY/Zq2gVESNGg1Q3xgCsNLfknCo3RizUl4zvkVBmGpUx/b5QsuNX0XKYkJ6f90aYngHew==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr2286941wmr.25.1585642528055;
        Tue, 31 Mar 2020 01:15:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t16sm26588888wra.17.2020.03.31.01.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:15:27 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:15:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/fpu changes for v5.7
Message-ID: <20200331081525.GA40938@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-fpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

   # HEAD: 16171bffc829272d5e6014bad48f680cb50943d9 x86/pkeys: Add check for pkey "overflow"

Misc changes:

 - add a pkey sanity check

 - three commits to improve and future-proof xstate/xfeature handling some more

 Thanks,

	Ingo

------------------>
Dave Hansen (1):
      x86/pkeys: Add check for pkey "overflow"

Yu-cheng Yu (3):
      x86/fpu/xstate: Fix last_good_offset in setup_xstate_features()
      x86/fpu/xstate: Fix XSAVES offsets in setup_xstate_comp()
      x86/fpu/xstate: Warn when checking alignment of disabled xfeatures


 arch/x86/include/asm/pkeys.h |  5 +++
 arch/x86/kernel/fpu/xstate.c | 75 +++++++++++++++++++++++---------------------
 2 files changed, 44 insertions(+), 36 deletions(-)
