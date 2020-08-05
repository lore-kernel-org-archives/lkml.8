Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CCBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CA822CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596651746;
	bh=I1zJy9HVZE3kXlTdCz3NimHrXDTg3aZ0bE9Ft0Nok8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uHSaIElBOOYkf5XTloOnhldD2iLhr9owOM7mNtywdiW+RfjuRuViYFDW5Zs9kjMKT
	 3W9ZyhIsZ+NZeeaVgUsykvlB/t5CYp0egtUhfIrLDBxH6v6nUy21w6b/veTrbT7CT6
	 v7b4PRneoEPVNmnbEhXtXRZQkrwcifnyJQkBvbho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgHESWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbgHESLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:11:50 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D0EC061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 11:11:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i19so24738415lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHPd0ivHK9bW5amsgeLfepexH6gYrZPkMtMTrC1KpJc=;
        b=G6m8qZi+rIjXCmBgPmBj7032K/nQAr3NLRmvf8lYANY8VpHEqkoOUIMmt+d3pIfFAy
         8S/32NBJn8RJ/n/l2yPIG3zMcmrEYdd6pmDQs2lDLxgnOVDIQ+3AIoH5XEELjwY5dNjh
         HhXyJvJT3gL+HQyS6+b1R9X52DRdebGwo1/5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHPd0ivHK9bW5amsgeLfepexH6gYrZPkMtMTrC1KpJc=;
        b=UvWyUl4yuBOMOtiwI4MaGfhKUPadMfr6yUy4pbwfwSMk4ffrMf3qDdXcAn3Fn2p//N
         geT5nPf4Opjk/w5QHRc8k/PRlfTyDZ519QQWu0t+esAiBMOh3IH4uJL89RUpPDh41Mux
         DayfoAglCTeLTzdj6ypnRJMtm9k0Bt1mguIFk0wtioGCOuhbMqNAO+P17OmKk2qv1xD6
         KEpITbk7OGNwDMMvYbHtw66pfBx3ed1Zy6liu6sjBsD6Uwm1avfNpcrUQjoh+Cf/4U8I
         cifOSEclvY+T/63naaYguGMLghRo8rkxqU2PO/YjRhEWcB2SDSRmnBsuA4zE4EGiZmiE
         EEeQ==
X-Gm-Message-State: AOAM533i3XdvgYtWdnM1YednZlXZl9hykWWw/s3WZpnr623pFoeOZu05
        VZ5p0CczEua0kez7gJCOhNTnRFnH7QU=
X-Google-Smtp-Source: ABdhPJzLUWqmZRtU4lgbzg3GXbajzJM0wVcH6H91xI30kqsXDWnOfnMEHK9ZSJPdHHh6vHz1oXN5bQ==
X-Received: by 2002:ac2:530e:: with SMTP id c14mr2108964lfh.127.1596651106396;
        Wed, 05 Aug 2020 11:11:46 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 29sm1276673ljv.72.2020.08.05.11.11.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 11:11:45 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v9so14283437ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:11:45 -0700 (PDT)
X-Received: by 2002:a2e:9252:: with SMTP id v18mr1882996ljg.70.1596651104717;
 Wed, 05 Aug 2020 11:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <E1k3KUx-0000da-In@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1k3KUx-0000da-In@rmk-PC.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 11:11:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbLwN9GEVVt=7eYhPYk0t0Wh1xeuNEDD+xmQxBFjAQJA@mail.gmail.com>
Message-ID: <CAHk-=whbLwN9GEVVt=7eYhPYk0t0Wh1xeuNEDD+xmQxBFjAQJA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update phylink/sfp keyword matching
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 7:34 AM Russell King <rmk+kernel@armlinux.org.uk> wrote:
>
> Is this something you're willing to merge directly please?

Done.

That said:

> -K:     phylink
> +K:     phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)

That's a very awkward pattern. I wonder if there could be better ways
to express this (ie "only apply this pattern to these files" kind of
thing)

Isn't the 'F' pattern already complete enough that maybe the K pattern
isn't even worth it?

Just a thought, no biggie.

           Linus
