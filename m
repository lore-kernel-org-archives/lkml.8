Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3AFC2D0F0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272362073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g9mIfMvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgC0LdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:33:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41913 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgC0LdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:33:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so10616580edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 04:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HBDIdNbauUzWWpYygi2C8elHABQwqvtXozjKK9jHI8=;
        b=g9mIfMvDXBJf9IKXU+ep7HNuIrcACmkCAlfPqrOeebATZu/zp+1kFgDcYwIlwtarnT
         uGHcciMeUHiOiCf9zVFQo8SK+++7ueQJZcS0YbeFeq49y5a+IbMjk7Bhnm8v5+wj16ow
         nSVG6bfxiVbsBcMTQ9hRdH+zTtM7PL50EsVYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HBDIdNbauUzWWpYygi2C8elHABQwqvtXozjKK9jHI8=;
        b=nbzu9fSlrRoUS4PdHJVA3IVd/uQ2z+NoQFc215HU5xxEJtH6dC2wULfT/SoxoewOo2
         s0bGIikpG5nIHDVwsYFnBcmn+TFKqTyhbjmA0qXXSfKJIeAnT1T439EAF0UARt9ErpvA
         bmRSQG4VBM3AvZFYEBdf7LaA/9XHP/zHPlMQDcvTsBMuIBdMq0Z0bFu59XApndQqysdU
         lb00UXxDZp7lSVNcQlKw1xnUb02QUKrc8iPTKVF3kLTBcT9e19SEwsKvj9GmxLiRODG6
         PQDWxkzkOtaPcDyhUGAa7aUaYOBBnBAVyCWXPz2ZcIUns1aEg6kgFsHoQo8sU4ynZfpX
         nM8Q==
X-Gm-Message-State: ANhLgQ0CXq0nLvP0rFWBblOw+79NbYpT4Q6uy6mWo/B+m46BZhzQNrUJ
        9NLFR2yQsVc7P0yauvYIr88W+JUeuUQL4w==
X-Google-Smtp-Source: ADFU+vumC+r1yhC0U6kcNoWOR9UE8dBCKrg2HproLtVnNU+tXcXZourTcSgoqKUswjZchHiZTsHRiw==
X-Received: by 2002:a17:906:69d1:: with SMTP id g17mr6053769ejs.32.1585308785803;
        Fri, 27 Mar 2020 04:33:05 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id lu24sm699617ejb.35.2020.03.27.04.33.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 04:33:05 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id p10so10990129wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 04:33:05 -0700 (PDT)
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr14731096wro.415.1585308473751;
 Fri, 27 Mar 2020 04:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-5-senozhatsky@chromium.org> <6e4fc7f9-0068-92ff-77d7-9c77c047f3db@collabora.com>
 <20200324023909.GA201720@google.com> <1187a3f660b092d8a9d5437445155edfc0744a4f.camel@collabora.com>
 <20200325023248.GA241329@google.com>
In-Reply-To: <20200325023248.GA241329@google.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 27 Mar 2020 12:27:41 +0100
X-Gmail-Original-Message-ID: <CAAFQd5BhDLcKHR1aO2U5Lf6EBhoqtBJbg6LzWDQd7XkDJ1YUaw@mail.gmail.com>
Message-ID: <CAAFQd5BhDLcKHR1aO2U5Lf6EBhoqtBJbg6LzWDQd7XkDJ1YUaw@mail.gmail.com>
Subject: Re: [PATCHv4 04/11] videobuf2: add queue memory consistency parameter
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        nicolas.dufresne@collabora.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 3:32 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (20/03/24 07:17), Ezequiel Garcia wrote:
> [..]
> > > > > +static void set_queue_consistency(struct vb2_queue *q, bool consistent_mem)
> > > > > +{
> > > > > +       if (!vb2_queue_allows_cache_hints(q))
> > > > > +               return;
> > > > > +
> > > > > +       if (consistent_mem)
> > > > > +               q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
> > > > > +       else
> > > > > +               q->dma_attrs |= DMA_ATTR_NON_CONSISTENT;
> > > > > +}
> > > > > +
> > > > >   int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
> > > > > -               unsigned int *count)
> > > > > +               bool consistent_mem, unsigned int *count)
> > > > You extended the vb2_core_reqbufs accepting a new boolean that
> > > > is decided according to the setting of the V4L2_FLAG_MEMORY_NON_CONSISTENT
> > > > but in the future some other flags might be added, and so I think it
> > > > is better to replace the boolean with a u32 consisting of all the flags.
> > >
> > > Don't have any objections. Can change the `bool' to `u32'.
> > >
> >
> > or maybe an enum instead? That would help get a cleaner
> > interface.
>
> Hmm, interesting.
>
> The flags in question can be from different, unrelated groups
> (types), controlling various parts of the stack. Not necessarily
> all of them are memory_consistency related. We can, for instance,
> pass some additional flags to underlying memory allocators (contig,
> sg), etc.
>
> E.g.
>
>         enum MEMORY_ATTR {
>                 MEM_NON_CONSISTENT,
>                 ...
>         };
>
>         enum VMALLOC_ALLOCATOR_ATTR {
>                 DO_A_BARREL_ROLL,
>                 ...
>         };
>
>         enum DMA_SG_ALLOCATOR_ATTR {
>                 WRITEBACK_TO_TAPE_DEVICE,
>                 ...
>         };
>
>         enum DMA_CONTIG_ALLOCATOR_ATTR {
>                 PREFER_HTTPS,
>                 ...
>         };
>
> and so on. We maybe can keep all of those in one enum (umm, what should
> be the name?), and then either make sure that all of them are proper powers
> of two
>
>         enum AUX_FLAGS {
>                 MEM_NON_CONSISTENT              = (1 << 0),
>                 DO_A_BARREL_ROLL                = (1 << 1),
>                 WRITEBACK_TO_TAPE_DEVICE        = (1 << 2),
>                 PREFER_HTTPS                    = (1 << 3),
>         };
>
> or
>         enum AUX_FLAGS {
>                 MEM_NON_CONSISTENT              = 0,
>                 DO_A_BARREL_ROLL,
>                 WRITEBACK_TO_TAPE_DEVICE,
>                 PREFER_HTTPS,
>         };
>
> and make sure that those are not flags, but bits.
> IOW, if (flags & BIT(MEM_NON_CONSISTENT)).
>
>
> What do others think?

My feeling is that there it's a bit of an abuse of the language
construct. Enum is expected to be an enumeration type, where the value
is always one and only one of the defined values at the same time.
Making a bitwise OR of several values makes the resulting value
outside of the enum specification.

AFAICT, the typical approach in the kernel is to just have a block of
#define statements to define the flags and have the flag names
prefixed with some consistent prefix, e.g. VB2_QUEUE_FLAG_. The flags
itself would be defined using BIT() so they can be used directly in
the bitwise arithmetics.

Best regards,
Tomasz
