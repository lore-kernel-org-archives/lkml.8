Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB781C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED637207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596481440;
	bh=OPk0T9kG0Gol3cqvhXjCqqC9Mxo3fC0Q9xIl/G8Wx74=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uFoF9OvsSnsnMOlg42fS2RGlzN6/lSyr4P6myJOKkF/xwZ830raFnPRTajKb7IW2t
	 5zDDA2DU77oG2XNk/wVxLNVPDFMVIu6j7MJBZRPOeQeGoWpOdEwvcEsVO6uTHYxc6v
	 ho7yaBU8Ej5sBd0B/VycAaoJqKB2sbuJCqCJF810=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHCTD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHCTD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:03:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC35C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:03:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so19281692ejx.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=q1Bmecf3m8916gSeMnpXUHhv5RsH1HZnBk2G3HbWWR0=;
        b=NCJJYg/l7RVcsAvMXnUJjOAx4Exz5UISHkqez0V6/+Dg33lGyQWcCbfJyzTkqLc9XP
         Nc/HcresPMCd8dcKpEJvjfxte6qfNTkFnJXZDuoNZN12BHO5+8wke5HVhuNGZ7lrDZb+
         L1HHghD7lu+eFrQspIUWKZzLcsP0S0ivZdvqL3LbJ4WlpFsgB93d5S7cUKbF+52bN+73
         cow9fsOxxx6RyW+Pn0gBKkg9OOftkNtkwaXd7kCYl5MGPerxmSn9ksT3eXWeb4m7WJFY
         mjZ58h4etmVPsVFIOznNG3XFVZO/XvB8kvxuDLGeOGY4e0ASUgmVxNXMf/YhaKSokwFn
         sRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=q1Bmecf3m8916gSeMnpXUHhv5RsH1HZnBk2G3HbWWR0=;
        b=YlmJZH5ObUO7wQve/qsyepwA3y3okjAyJa4cDPGf+596UK7BzQMB44Q+hLzVs1+tpp
         BElAYQK2tLBwRKtifF8xVPS5f7c2Rs9I1ZN+r9cz8wQ6489ZchMn5m0uEbORo1vxy+UF
         SHDyPXlC1vSY32k5MMlUll877/M5Pt4bH0gNqTmdFfbeTdAda2liESuqFaQk4qHH0JNX
         rJRE5wHYnSx9y7AyLn8e3et9rVLhmqCHE+vpYY7GBu/ul8D7cpbEWZ8YFpgdf+Xc3i8Y
         HMqcebfZyFGNY3IdCuyJVrcDw3XI7Vir94t9Tdqigi5VVTtnqTMjwqdQzBxpsHlPc2SO
         xb6g==
X-Gm-Message-State: AOAM532wvflpQgvpYGETwe8UQU3TEVsKCchJrTXAtThX2GU1qI/RlKqD
        XFEslLQjJkkMAf1lix5UDBw=
X-Google-Smtp-Source: ABdhPJxfbt2STf5YY7T8GUxrXNfJIEaAojNY62BsqINh5mnRQcftqupz4+rzGSeGL9v/Igx/vb9NHA==
X-Received: by 2002:a17:906:15d8:: with SMTP id l24mr17540840ejd.297.1596481436858;
        Mon, 03 Aug 2020 12:03:56 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id by3sm16788860ejb.9.2020.08.03.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:03:56 -0700 (PDT)
Date:   Mon, 3 Aug 2020 21:03:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200803190354.GA1293087@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-08-03

   # HEAD: 2b32ab031e82a109e2c5b0d30ce563db0fe286b4 x86/mm/64: Make sync_global_pgds() static

The biggest change is to not sync the vmalloc and ioremap ranges for x86-64 anymore.

 Thanks,

	Ingo

------------------>
Joerg Roedel (3):
      x86/mm: Pre-allocate P4D/PUD pages for vmalloc area
      x86/mm/64: Do not sync vmalloc/ioremap mappings
      x86/mm/64: Make sync_global_pgds() static


 arch/x86/include/asm/pgtable_64.h       |  2 --
 arch/x86/include/asm/pgtable_64_types.h |  2 --
 arch/x86/mm/init_64.c                   | 59 +++++++++++++++++++++++++++++----
 3 files changed, 53 insertions(+), 10 deletions(-)
