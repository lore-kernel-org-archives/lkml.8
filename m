Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD9DC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0245120709
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599411739;
	bh=F5utO1Uo9rLljVuEGUdyP6/C57CRj/7DffK2bnMeqYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=isB8niRIDa1l/UuvpQfLcrf0F9OefuIcrh32ijlmO5FdZyFAE9lJpIOE1o1RVq64l
	 mMqDdPYLkHcPU1jJmEh58v5yQT4/rSAd0H2NJOzBwfh4SL8VF0GSKSGwp2nu0kKefC
	 yniSIdRSoQTW7wdj6lEA3aPF4/LrpRpEQGt9W3PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgIFRCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIFRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 13:02:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F58C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 10:02:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u21so3136394ljl.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBpy6uI3e4BtHg/8kxvDuOM32+PzqfR21jwNr3B73YQ=;
        b=MYzp6+RJ0qQcPfwGPVxP1evkhmzNr5bpNK7N37GvQtRp5Fdpt2GbeB+I2RiNE+gmkh
         bG6fZfHCgtbGGN3WT5WdW65upCG7HzFaPGI6gK9YWZ8jydXEei+P24Z6/svKcyNiPxgC
         6+2lMVRWm91PhCZlkaop+f6NdSWs4BMQHyPmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBpy6uI3e4BtHg/8kxvDuOM32+PzqfR21jwNr3B73YQ=;
        b=Pr2h1mYRKIRum0nryn/mNAbBKBV1Iq8pQ2vs1Zr47kB7++u2z8vdLwq4+PSRyAhWjD
         4JAqbu4e/TCv48poaOZQbKaTb8s0WvDIlIKVeQioPU4qPing9OhWK9vwuP1Mu5o+mglT
         rrmozUEmIJ5bmP1RqUEsdfW1tG1jtT25/np8DPyE0OtDM8nt3PlyJcXqAFRL9j0XtCLU
         +FLKGzh+6K6QCRb4UxSe5hqOxqZpjV2NLPLDgh19mpU8E0TW9HMCQloD89UvQJ+Se75g
         91OJ1/MZftnpWaBQI1EcaSJq10rrL7eK09Dn3uwqV/oeIYzzv/EpQFYr+0qOnFqdFMHv
         SfPg==
X-Gm-Message-State: AOAM530Q6cfiZB1sspVtmxokFHu2BI/6Sl2ZNXc0J0bEPL8TESP9jFiw
        hy/XeN4tJ1hp93jW5/zZyGr/2wxjIL9xGw==
X-Google-Smtp-Source: ABdhPJxb7oo/fWmYYDgLSeRkdm9VaocykJOUHURKNU4+fYnJ2lzOltbsJw9X/9/9JbYLU+2SP+byKg==
X-Received: by 2002:a2e:92cd:: with SMTP id k13mr7971593ljh.138.1599411731715;
        Sun, 06 Sep 2020 10:02:11 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id i12sm5036864lfi.48.2020.09.06.10.02.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 10:02:10 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a15so13459456ljk.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 10:02:10 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr7614310ljk.421.1599411729954;
 Sun, 06 Sep 2020 10:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200906044433.24820-1-jgross@suse.com>
In-Reply-To: <20200906044433.24820-1-jgross@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Sep 2020 10:01:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTZ3V-Jn5xmHTKafZ-vRw-E0n8EMz+PyHKz4CMRwmYxw@mail.gmail.com>
Message-ID: <CAHk-=wiTZ3V-Jn5xmHTKafZ-vRw-E0n8EMz+PyHKz4CMRwmYxw@mail.gmail.com>
Subject: Re: [GIT PULL] xen: branch for v5.9-rc4
To:     Juergen Gross <jgross@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 5, 2020 at 9:44 PM Juergen Gross <jgross@suse.com> wrote:
>
> It contains a small series for fixing a problem with Xen PVH guests
> when running as backends (e.g. as dom0). Mapping other guests' memory
> now is working via ZONE_DEVICE, thus not requiring to abuse the memory
> hotplug functionality for that purpose.

Tssk. This really isn't a bug-fix, it's clearly new development.

I'm going to let it slide since it seems so contained, but don't do this.

                  Linus
