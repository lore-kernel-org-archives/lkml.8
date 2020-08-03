Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD1FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39AF22B45
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596476933;
	bh=0P7YrL99roXQZ+zlHecPwjRgjaA9nI0uXUTCJQbnzio=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CoDbTz7iUPcYYStoqVd7mt34TfgMma+EFwaok4bsuWDojpRCA8vkXEOM2J3vJH9IZ
	 feR4jRGoRZomIJ+EUkc+WU8cW3v00fLVi+K9nOZNv0+B32zeTbg88OJLFmrtiJJH1m
	 cdjyzRWzASbGfMB3NBNlC0jTheJUQpoRwxFRMyQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHCRsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHCRsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:48:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 10:48:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so13754017ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uNI68Qv2zBai/+YhOyAflsS1IJR/W7fluZFyK8+xazE=;
        b=HN4FgxB3LZs9xC/PJ+ungckFjQ1tzfcNFKVpLAmR2kz9lWvXJrp1oPgyFeJD4SlOFe
         uVRCTumlDhKYlFSOOETHOvawRfjAwyIlQsk12wimZ3IAaPbVtyzNl1CpmJy+XPa8YhhC
         KAVqPiLdYOmuF7oamefMdIlyCVx/womxOnSNpSafcKzgr06SjqGPkZ4hMsTtpGfh0Vgh
         lLlGjWXLTP6PE15Xq2NaMJDoSUQh7jq040sUKgcXSrjBAwXvjUZiocsjajmh8w7P7Fyu
         IpaUdsXU3e96Cp3o1j52jJaP+6SRMF2ZanXbzPHjQ8jvOv3lt9OWWJTMqhKbf/RIsXt/
         Uzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=uNI68Qv2zBai/+YhOyAflsS1IJR/W7fluZFyK8+xazE=;
        b=eOvwmFE/aNfGlOyktawxfE2sFObRAmBKrf4zwXdK4zUyg0EQZmovSlwAYFsC2Z9r/0
         OUUaarFwYgyYd0T2KpVs8Cls8v/1DVUadqQB48aRc8dTlAbyJd7YwzmScN7wF7H0TmMK
         WmJf9phtOM8M7R7AUMVi4ABO9qpA4UU0BM54QpHPnEGxul0SiRWQVE43379M8MJmSemI
         YlnlRNI0bfqM7h/ybU8DXG9zH7h7m/fwYrZ+t2yBjfD+5MAsUadmB6xvRnAwBryUC5Sz
         ptRKmGyp7wIYbfq1hMQLJnNRqPs+ep5CwAXtJv23x8XgVSknxF1qIXGsGzt3eTAO8LtB
         oE5w==
X-Gm-Message-State: AOAM531vQhOaIGZ+GZQkNb7k3buYt+Gxu+m0GHzdYawEK8LuuOx+Ba1l
        KTzC3oTybgpAb35NiQYmFvA=
X-Google-Smtp-Source: ABdhPJzbCr9YrIV08yQ6v7hAjErLOIe8gn/HXcFB9UjuTrHSNOH437+ow4eiHWXql1wq5vv7SKyBbQ==
X-Received: by 2002:a17:906:7c4f:: with SMTP id g15mr7249541ejp.82.1596476931400;
        Mon, 03 Aug 2020 10:48:51 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v5sm4893424ede.13.2020.08.03.10.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:48:50 -0700 (PDT)
Date:   Mon, 3 Aug 2020 19:48:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/core changes for v5.9
Message-ID: <20200803174848.GA1041119@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2020-08-03

   # HEAD: ef2ff0f5d6008d325c9a068e20981c0d0acc4d6b x86/dumpstack: Show registers dump with trace's log level

Improve x86 debuggability: print registers with the same log level as the backtrace.

 Thanks,

	Ingo

------------------>
Dmitry Safonov (3):
      x86/dumpstack: Add log_lvl to show_iret_regs()
      x86/dumpstack: Add log_lvl to __show_regs()
      x86/dumpstack: Show registers dump with trace's log level


 arch/x86/include/asm/kdebug.h |  5 +++--
 arch/x86/kernel/dumpstack.c   | 23 ++++++++++---------
 arch/x86/kernel/process_32.c  | 29 ++++++++++++------------
 arch/x86/kernel/process_64.c  | 51 ++++++++++++++++++++++---------------------
 4 files changed, 57 insertions(+), 51 deletions(-)
