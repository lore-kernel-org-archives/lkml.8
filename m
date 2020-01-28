Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9071C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FC921739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580231538;
	bh=8fi8CuXiVSIdVlNYc63flD+LlgmI1W+BEFTgwt9OwzQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=092x1PW96epdybiRRJIIVXX0Xd/EEya/+YKWSlBILIUDbcWG1BGGl3OIKQAER2WUQ
	 SNB8aMRBnRgS5liYSDMaC8DQwmtt4mWGFnM+PP59LoK8UiwII7XSobxcHOs5WNqXnQ
	 lOTd8BoWWmCxq+o9rMn53VExeCAFFYZ9ke8a2zDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgA1RMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:12:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33271 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1RMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:12:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so2244596wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OpFpDHEEzFBbVqCQ2nWR48p+ClrIW0LlTER2mk+tLXQ=;
        b=U5ld/rn+aaCRhEYaEXdNKeRNfZhHq1LA6xqOx7WoaW+lDjm7mRGhnkfcDGXLhRPC0X
         Pa7sdbsvzVgwDYJtia3b8jjqJ2a2TdOSwTjC9PakVLlzXp6Mia/aMHpG9YjTdBffg3DV
         +SvdDirjS7sKyXZCnP51uXZmhNP6GdbN7HMkpm0hTyJELdtqro39Rd4iZyYtn2fN/BIH
         CNOBIXAO4ipGNBivEjvdlay6AZlVYRezqrz/cOkTwpeNiwZfgiJfqNLWESEmBD8CY76x
         NHhmRFfvho18A0gHWaeu/IgbB7jm4UiZCPr/aHKObxzE9XBSPvi0OGCHdqiTJCZYPK3L
         7X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OpFpDHEEzFBbVqCQ2nWR48p+ClrIW0LlTER2mk+tLXQ=;
        b=GMMYrDaQ6eIRIdh2NyeCenSnRt3UR3rdp/CaSST1mk9fyOH6bTJEhytIjmCytCJviM
         uWMLu6cRcmaFeqmpruCuMaXqWSK0J37yu2iIcrh8drpHsAk5gFXxtUvBYS7tHWYVnANC
         OXoL/sqDVgfoNHcddWQomGjGeMv4KV/AVOnIRs1uydK5+Z/lg2nZJB2kyPmLSwGO5GnT
         sWZdr9nMaEsO7LjB5VYJHURx08m82IyXr6MnPfMXSPHQKY1UZoSBgmtA+DnROLg0CSdO
         wkJjgVx4GmuncSWDQSlP9XUVI06QU6a9nvMbBG9H+G1emp9cNoB10KFMNPSVL6BL5MRL
         NM2w==
X-Gm-Message-State: APjAAAXFYh2welc8nXNrKjGX51km1mpzj7kv/9FQL9atBtvWokvEY8Xp
        V4lvIA0gRvLn6PKSryTqaBwVGHxx
X-Google-Smtp-Source: APXvYqwO4ugZRg4dPrpsIblKFMRfD9mPmyGpGkA7qGLT0ElRbs9+Imh+9eEwzOa2kx+J21xNqOgVPw==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr5951429wme.37.1580231535368;
        Tue, 28 Jan 2020 09:12:15 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z133sm3990450wmb.7.2020.01.28.09.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:12:14 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:12:13 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot changes for v5.6
Message-ID: <20200128171213.GA11313@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-boot-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

   # HEAD: dacc9092336be20b01642afe1a51720b31f60369 x86/sysfb: Fix check for bad VRAM size

Two minor changes: fix an atypical binutils combination build bug, and 
also fix a VRAM size check for simplefb.

 Thanks,

	Ingo

------------------>
Arvind Sankar (1):
      x86/sysfb: Fix check for bad VRAM size

Ilie Halip (1):
      x86/boot: Discard .eh_frame sections


 arch/x86/boot/setup.ld           | 5 ++++-
 arch/x86/kernel/sysfb_simplefb.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

