Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB4CC4CC71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305F9248E5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599242633;
	bh=gZm0FbvxyjoTKxH8aaKUuJUaShJJQPTYaECSWWMDM9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HoQxJsgPSJ/5KcoGDqx0Rmw3ud9s1t/EYFvNpb3ryTa6vetKoPel/Ws6aOdMx325Y
	 0rajkHI6M3wO8HhRKrCjNUiulYdS9EknF4i4+9oEHoTCYKBvxXIF+WvQ59bTUjpV4m
	 a8byE4FbirFiYXOMYewsw3B7zIUDWA/jpWMbEz6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgIDRL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 13:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgIDRL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 13:11:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC8C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 10:11:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e11so8843614ljn.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwSOZ3VxHk2DxOprDUCFltuLBh+Nnc13XxZ9vhv/VSM=;
        b=Ai5VYeCU8N0HEbW+IM5blqtlPgBAdGE7a3XFUEbRHQk5rk29NE1Y6tMiu2T/EMq17a
         oE42EL494zdqelcOJfkWDvC8gduDspSWRXtrBLodjT6PNtuIMZdw4lEZsKoERdT4+qfQ
         DzOZXMaeU+RmNmSqU9sHI/NrjQBcHXnvyzI6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwSOZ3VxHk2DxOprDUCFltuLBh+Nnc13XxZ9vhv/VSM=;
        b=Qb4v7A+8KoO7g0+GkGfw67IhLOzkWbZgXvrJRlf4V6Zg8lIZCi/ZGbS9NE/NoTrqso
         gKSjz66vklt0llCGP6YQ3wLUgjnl39Dr99O2vmQXgglHu2ZvEcEgsAg2TvUfQzLA05LQ
         AdCjGbrF+GdbHlASjnqCMO1cQ6BNiCFR0CoaruHgKD1xVSFfNm0ePL/9qIJfk0dzRiam
         8fK9KfHX4R2YkMA0PxwZa1ucDQgZUDLOnh8dXts43YQwfew+XCzwKybvmI4z2ZWf538B
         JVQR3dF701rkjJ94SkIGgI7RU3PztycbYZyoVTSmKTN94zFOoW/ITuQCVTVtuUB5M6ZT
         npdw==
X-Gm-Message-State: AOAM531NEBuDTxwwGwfkiXHitBbjBaSxSz9zRwn++A+3sh/i5hRLTFiI
        DfyplHEsY5MqHNdo3DaYVr+/3fwNiybv2g==
X-Google-Smtp-Source: ABdhPJy+LfFDnhB2nLi6blePpdS7U79a2JkZgd/mzOmUv4ottMvXO/eSPY47M2bkHirmdF8057DRpg==
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr4691383ljp.312.1599239485901;
        Fri, 04 Sep 2020 10:11:25 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id s4sm1360943lja.124.2020.09.04.10.11.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 10:11:22 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y11so4249396lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 10:11:22 -0700 (PDT)
X-Received: by 2002:a05:6512:50c:: with SMTP id o12mr4298936lfb.192.1599239481877;
 Fri, 04 Sep 2020 10:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com> <alpine.LRH.2.02.2009040402560.14993@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009040402560.14993@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Sep 2020 10:11:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmhDNm7+w0atqAj3X=izWxNut_4kQGTG8n=+HhtxEbRw@mail.gmail.com>
Message-ID: <CAHk-=wgmhDNm7+w0atqAj3X=izWxNut_4kQGTG8n=+HhtxEbRw@mail.gmail.com>
Subject: Re: a crash when running strace from persistent memory
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 1:08 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> I applied these four patches and strace works well. There is no longer any
> warning or crash.

Ok. I obviously approve of that series whole-heartedly, but I still
didn't want to apply it this way (and with this kind of "mid-rc"
timing).

I was hoping to just leave it for the next merge window, but there are
now two independent problems that that forced COW patch of mine
caused, and a plain revert isn't acceptable either, so I've just
applied that series to my tree despite the garbage timing.

Maybe I'm just making excuses and rationalizing because I wanted that
series anyway, and patches that remove lines in core code make me
happy, but I don't see other great alternatives.

              Linus
