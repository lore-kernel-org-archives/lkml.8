Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073CEC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4902068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZeZv+Jdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgGUOPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgGUOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:15:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7DFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:15:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 6so16234790qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b6DsrydUx/QbWN78Y98wqygG+UFPG4/2noyfDIXaO1Q=;
        b=ZeZv+Jdtru6aShCxXC4eqO2mhQMefh/NCT5gkoNuHTTZwabuZDWwtppyuS6d25xekJ
         sHztR8j1lD58bJRXUNNGbqX040tfash+UO3yAkZacwVAlQmKqA0BXNxXQzXFvG2kSxxs
         MOgPzq1gZwSNKNYQhRW0CiybWUYUcunJo0fgn51nvq3HfhldSs8EPHVnA8n0QerBMuVh
         KUM6i68yf62YhirYLafdiJMqlQBtnWS+b9pkUEX8ae9+8qpXoHoaXbWAMbLko7hjeLwT
         K580ksu8g6TcNb7oF2sTrRV6NvWYkwrKdTW9LLXufvWhwa8D0oLUWQHpsKfF0JSZhDit
         sFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b6DsrydUx/QbWN78Y98wqygG+UFPG4/2noyfDIXaO1Q=;
        b=eCZtTkcU38rMokbaq64XuRBt7aDRpwjHYeX0vnHBh7cPW9bpodkMxmweb9BlPY22iv
         3vsKDqG2SAPbxDeyBcvdZdIHoXkr4roR+/LlKzzpM9xeYe8+I5kxegGkMtETL44+2ncA
         xgR3ZPiuHId0fyHnOUB1OPI44e+k5E3PhX22Zb9cdKatVL71mvN3eYaDIBk+NQsPI+0C
         ckhT74w3ermiHR9f2wQwrSfj2zfruaCa4Q61gEgVASweu4A52MYQFSd4cDG/8RvFGJ8A
         4JZSqMU//qBNh0G+OfYHsh+ybyOywHA5KQdM4t17rzb5f5DpQPAAp3CsBMQu2uhfuvhC
         93Ww==
X-Gm-Message-State: AOAM533gTKO7pp0f0ObzKhnDIXpdx6F2CEeX2E7k9OtmWapzcV5wtxfs
        yIJdD/9Fn2zqID1RUnHkRuNSWQ==
X-Google-Smtp-Source: ABdhPJx7S5d1VBeKEJHQ6vaT8SnM6raxpHV2XUYvogmQFey8vBqS1FxxuiElEiqVQxkOoNQmPUn6eA==
X-Received: by 2002:ac8:4c88:: with SMTP id j8mr28146774qtv.57.1595340946182;
        Tue, 21 Jul 2020 07:15:46 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h185sm2531667qkf.85.2020.07.21.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:15:45 -0700 (PDT)
Date:   Tue, 21 Jul 2020 10:15:39 -0400
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200721141539.GA3696@lca.pw>
References: <20200721112529.GJ4061@dhcp22.suse.cz>
 <664A07B6-DBCD-4520-84F1-241A4E7A339F@lca.pw>
 <20200721121752.GK4061@dhcp22.suse.cz>
 <20200721132343.GA4261@lca.pw>
 <20200721133835.GL4061@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721133835.GL4061@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 03:38:35PM +0200, Michal Hocko wrote:
> On Tue 21-07-20 09:23:44, Qian Cai wrote:
> > On Tue, Jul 21, 2020 at 02:17:52PM +0200, Michal Hocko wrote:
> > > On Tue 21-07-20 07:44:07, Qian Cai wrote:
> > > > 
> > > > 
> > > > > On Jul 21, 2020, at 7:25 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > > > 
> > > > > Are these really important? I believe I can dig that out from the bug
> > > > > report but I didn't really consider that important enough.
> > > > 
> > > > Please dig them out. We have also been running those things on
> > > > “large” powerpc as well and never saw such soft-lockups. Those
> > > > details may give us some clues about the actual problem.
> > > 
> > > I strongly suspect this is not really relevant but just FYI this is
> > > 16Node, 11.9TB with 1536CPUs system.
> > 
> > Okay, we are now talking about the HPC special case. Just brain-storming some
> > ideas here.
> > 
> > 
> > 1) What about increase the soft-lockup threshold early at boot and restore
> > afterwards? As far as I can tell, those soft-lockups are just a few bursts of
> > things and then cure itself after the booting.
> 
> Is this really better option than silencing soft lockup from the code
> itself? What if the same access pattern happens later on?

It is better because it does not require a code change? Did your customers see
the similar soft-lockups after booting was done?
