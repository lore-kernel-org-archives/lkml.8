Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8047C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB2A21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yCf8eijx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgATOVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:21:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40176 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgATOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:21:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id i23so24193934lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXShFQ0oblTBfvPtqqTvc94TmQn0BCw/PupNhNwEy2g=;
        b=yCf8eijxwY8WwDB2/Xb0a5xkddKP7t+aYeipLHveuhL3muN/Xss5zfR1qKSEIs3Qpo
         HADp0UzQj1i5pfw/c6o41NSrOGJ56UcXRSR4M5niAv6hNU+e3pt7ZnoOfL2L4KF2Uof8
         myQaNJ16F/2FqV4s0es47Wqy6khsUCKjK6UokmpMYJvXcqN/VDSp/JEeAFuJJJ4Fem5f
         Bckb4EpS+8Ie5mB3xCW7mFQckXmrxAtapkcKdd+yS2u/BjxFfi1qWs9YDCg+Xq/4ZQrU
         aD3ZFFSIM3vj4iro/AjcUB5BEU3YqYI2sCPT+UkwbQhbaVR+cLQ0ZFjcZNYrvCTPeVW1
         1FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXShFQ0oblTBfvPtqqTvc94TmQn0BCw/PupNhNwEy2g=;
        b=FUKaYiCbzUzIqBPz45bTHy/l7kjQ1a2pL1NXAd7HM5rrFWs9LoAj4DXUFHivxxWd8l
         8gHf21v8TtHJW5jAec7UxvW7R71UlRteticduQCtp6TErWVqiVhGQRcEaJBllMPxj8o+
         hUWV8bftm2ZcMaIG63pvugWVbCYSf+Kn4cen7T8/uOyJjfPloQ55B7prhlFIHYVw4JoJ
         DZuj69483pJM2tdg4+pqw1O2mR9hc4i+V6Vdp3ALsUl60uVmlztHeweLG/N3yPpbLCrk
         avCBAMs24jic0WchFIkKOL2MDCYhsZpxdMzLJy6yt92Oba1/iVbVEvVhuGDC8wjfTB36
         NJ4w==
X-Gm-Message-State: APjAAAVKUImcl8NyJ3mpf7BTIBe9oR7Lp9DY81jlVBNB5R17I428omeh
        8jnkpVVUgqX7tVu3wwVtLjfaig==
X-Google-Smtp-Source: APXvYqw85OfgCXSwLFzcIjd4qIUW/Jrpb1WW0f9nf0Yms9qWwNXycwAOoHvOilI4y/sT5u6cX4I/gQ==
X-Received: by 2002:ac2:4884:: with SMTP id x4mr13867121lfc.92.1579530091868;
        Mon, 20 Jan 2020 06:21:31 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z13sm16924732ljh.21.2020.01.20.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:21:31 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2607210013E; Mon, 20 Jan 2020 17:21:32 +0300 (+03)
Date:   Mon, 20 Jan 2020 17:21:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200120142132.srf4igph4zmecu7b@box>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <f57fb198-4070-d3b4-b6bd-43b29ff40a2c@virtuozzo.com>
 <20200120112722.GY18451@dhcp22.suse.cz>
 <20200120123935.onlls7enjtzenbvt@box>
 <20200120132405.GF18451@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120132405.GF18451@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 02:24:05PM +0100, Michal Hocko wrote:
> On Mon 20-01-20 15:39:35, Kirill A. Shutemov wrote:
> > On Mon, Jan 20, 2020 at 12:27:22PM +0100, Michal Hocko wrote:
> > > On Mon 20-01-20 13:24:35, Kirill Tkhai wrote:
> [...]
> > > > Even two threads on common memory need a synchronization
> > > > to manage mappings in a sane way. Managing memory from two processes
> > > > is the same in principle, and the only difference is that another level
> > > > of synchronization is required.
> > > 
> > > Well, not really. The operation might simply attempt to perform an
> > > operation on a specific memory area and get a failure if it doesn't
> > > reference the same object anymore. What I think we need is some form of
> > > a handle to operate on. In the past we have discussed several
> > > directions. I was proposing /proc/self/map_anon/ (analogous to
> > > map_files) where you could inspect anonymous memory and get a file
> > > handle for it. madvise would then operate on the fd and then there
> > > shouldn't be a real problem to revalidate that the object is still
> > > valid. But there was no general enthusiasm about that approach. There
> > > are likely some land mines on the way.
> > 
> > Converting anon memory to file-backed is bad idea and going to backfire.
> 
> I didn't mean to convert. I meant to expose that information via proc
> the same way we do for file backed mappings. That shouldn't really
> require to re-design the way how anonymous vma work IMO. But I haven't
> tried that so there might be many gotchas there.
> 
> There are obvious things to think about though. Such fd cannot be sent
> to other processes (SCM stuff), mmap of the file would have to be
> disallowed and many others I am not aware of. I am not even pushing this
> direction because I am not convinced about how viable it is myself. But
> it would sound like a nice extension of the existing mechanism we have
> and a file based madvise sounds attractive to me as well because we
> already have that.

If the fd cannot be passed around or mmaped what does it represent?
And how is it different from plain address?

-- 
 Kirill A. Shutemov
