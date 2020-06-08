Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DD4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F992074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaSeTrlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgFHLSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbgFHLSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:18:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64437C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 04:18:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b16so8386647pfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bLGHAPpBMCAk0XEijfEImk2BbxF7rnJc2dl2Taiz1TQ=;
        b=TaSeTrlVy0Eb/aruMNajP24/DLeWRd9UFdtv6Dj3gjkKh/9LLrMOB2uP/JbEbb9+a0
         /eecysEbxfYfxZaAI4VpkTG/+hIJpU2+HYkSU7YWBauOPir/dzTWnUU76V1HHw+Mc3La
         JKb9NDNzINJjPg6Ji9GUO5U0GUd+RYQ6kbkmaXOBc5xsXNIa3VgPPmxTzCFvibeFrNYr
         kxukMwwf7TpfibkoNfeTHbv1jWbpAk8Gw5IX+F8x1wfdJ7kB3WwKckYPQDZ6ESVJQMzG
         yy4dpGQIfkVMzththSiR2XHutN/3S8l/tws+7BDwAESu37w3DayBWbC28jRVaGR8Psb+
         Jyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLGHAPpBMCAk0XEijfEImk2BbxF7rnJc2dl2Taiz1TQ=;
        b=K/E9JOXTG5NogKmyza4rT6L+ZZqmMOqMJz+vCp3A1Lk0OhtycYg1m4B7oQWPvKWRvJ
         d/yJV2b1AzeL9bwCXtRSrI+3gbPQOXJ8oeRiToMjOnam32yWnyJ7jh5mYhsKYISvESHo
         SpSw+BpyhjwZhWeeaZ3rulC7mN9BFfAvmJePQwsstqVuofS37cLlUezM2Hj/y2leTbJU
         g/+IWwiTYPfHpKq3po4RbiL4ITQhNEm2fK7kxTrf60Y8L/V2aYjdhNdhzDgSYOs3NOSS
         z7/jZy/O1+mHGY8MUxw66dy87efg1RAflokJ4xyheUPC6czZl/Npx6MtHuitxQuwd1sQ
         84GA==
X-Gm-Message-State: AOAM533jAuN0dr/bQQ5fAvgfofmMLK/OPAhZ284TTJbPy4ipyoXnrOng
        968IyssUY1qxZcixTfnsFUI=
X-Google-Smtp-Source: ABdhPJxWAsknwr6X6weG46CCyPiDJ6zxhw57RFAOpXcc9g4MLuJgL2JQ5nD2XZVJyYDryEQq8k1y9g==
X-Received: by 2002:a63:5d62:: with SMTP id o34mr19595022pgm.420.1591615117630;
        Mon, 08 Jun 2020 04:18:37 -0700 (PDT)
Received: from localhost ([49.207.55.212])
        by smtp.gmail.com with ESMTPSA id d4sm15396959pjm.55.2020.06.08.04.18.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jun 2020 04:18:36 -0700 (PDT)
Date:   Mon, 8 Jun 2020 16:48:34 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: vmsplit 4g/4g
Message-ID: <20200608111834.GB5736@afzalpc>
References: <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
 <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc>
 <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc>
 <CAK8P3a2=o6RkONUoHTaR-2jpXg-wa-YnCYi0a4gAknYmvu8X7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2=o6RkONUoHTaR-2jpXg-wa-YnCYi0a4gAknYmvu8X7Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 07, 2020 at 09:26:26PM +0200, Arnd Bergmann wrote:

> I think you have to use get_user_pages() though instead of
> get_user_pages_fast(),
> in order to be able to check the permission bits to prevent doing a
> copy_to_user()
> into read-only mappings.

i was not aware of this, is it documented somewhere ?, afaiu,
difference b/n get_user_pages_fast() & get_user_pages() is that fast
version will try to pin pages w/o acquiring mmap_sem if possible.

> Do you want me to review the uaccess patch to look for any missing
> corner cases, or do you want to do the whole set of user access helpers
> first?

i will cleanup and probably post RFC initially for the changes
handling copy_{from,to}_user() to get feedback.

Regards
afzal
