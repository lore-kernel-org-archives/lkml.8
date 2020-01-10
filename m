Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ACBC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373122082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vdr15sBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgAJV1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:27:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39538 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgAJV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:27:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so3152453oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dc7C9t8nS5kMbHGnuaUU5Fa2JKAfraVFXFnxYmWF9bM=;
        b=vdr15sBSjoi3j4oUEH5jIDurHcvUNEyEW57q0WyAtFekwNzRnrjVwYvA8hPQQXbIqE
         DIxI19JZ1HDadWeoreEH4fXrqQS6trIV7O3FllR4i+G+aEL6ola42rSNyRj+JKzuBQJg
         poxz2gLWMzx9yD4J50Q4EZbvfDmuFpTP+6TJMWgk5k1kAmgqgjVnyCzbihiEAa/YyXWD
         w+GHu+xvWtvJrZ8/PaY4qmaoEuBqjMoLpFt9DmoSAuQDTXmo/T46CPcZDt8AtupbXqvd
         1VA3Obwi7t67dWTJ2rJsjPNBNgBk9Bn+dFa6CMsRBhLfEOYfgzH8j9iz/ydo0XmyN5RN
         7vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dc7C9t8nS5kMbHGnuaUU5Fa2JKAfraVFXFnxYmWF9bM=;
        b=WjBfNBhGhUdDW1HDjogTsYb0ocOJ2gToudbR/DxuXN61Ma4EMDwauAcCHPWeZBf764
         BnBsLAfqK4L75TYHYg2Ho+jZ8Ll83/K89efAWPQJAOOu+w+8IdcGM41lOIHL1Nlp0Qk3
         WFtJiCpJUqfOe5kYpj1mA4f2AWw6pVF1F7pP0oW48J12VlAOjDPGKCFpl012kpDrAChJ
         EXNWJ5au5DMjho3NWOpg91TvCuhS0J9ewuxOr8HLIeE3EbsKHJNNXknHpAoWeIVCccZ/
         F0rmpThGYWeoJdgN2bYWjtg+eFKYTcPgS/icUJMdPkx1WXTNfsvBoy2rCCN7kXK5fzJf
         DIfw==
X-Gm-Message-State: APjAAAX1+9b8nVGibDLmvJoJfNMMFqZu1nlNnOO5XmFXIMcXiskJoe2w
        fD4/GrzaOAr0l43qIYi2+Bx9RdCjrksCq4zypS+yCA==
X-Google-Smtp-Source: APXvYqxNQu1g9Swlj4ItY7HDQzDpLpZJ3izCmtZ6N6CCpd39vuCJadEa4YSBiWIqE+WMu6DZXNyq9S4tBDEBiKXq8Uo=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr4108696oie.105.1578691654771;
 Fri, 10 Jan 2020 13:27:34 -0800 (PST)
MIME-Version: 1.0
References: <157863061737.2230556.3959730620803366776.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e60e64f9-894b-4121-d97b-fb61459cbbe5@redhat.com> <CAPcyv4jm=fmP=-5vbo2jxzMe2qXqZP=zDYF8G_rs3X6_Om0wPg@mail.gmail.com>
 <4d0334e2-c4e7-6d3f-99ba-2ca0495e1549@redhat.com> <CAPcyv4jixmv8fJ5FiYE=97Jud3Mc+6QzRX1txceSYU+WY_0rQA@mail.gmail.com>
 <fc0cfb97-5a60-7e73-4f85-d8e6947c5e28@redhat.com> <CAPcyv4jVpN26RGQLRn4BewYtzHDoQfvh37DEdEBq1dd4-BP0kw@mail.gmail.com>
 <64902066-51dd-9693-53fc-4a5975c58409@redhat.com> <CAPcyv4hcDNeQO3CfnqTRou+6R5gZwyi4pVUMxp1DadAOp7kJGQ@mail.gmail.com>
 <516aa930-9b64-b377-557c-5413ed9fe336@redhat.com>
In-Reply-To: <516aa930-9b64-b377-557c-5413ed9fe336@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jan 2020 13:27:24 -0800
Message-ID: <CAPcyv4iiYtN6iGt=rVuNR=O=H9YcY1b1yWp+5TuDhu0QoVqT_A@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: Fix remove_memory() lockdep splat
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 9:42 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 10.01.20 18:39, Dan Williams wrote:
> > On Fri, Jan 10, 2020 at 9:36 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 10.01.20 18:33, Dan Williams wrote:
> >>> On Fri, Jan 10, 2020 at 9:29 AM David Hildenbrand <david@redhat.com> wrote:
> >>> [..]
> >>>>> So then the comment is actively misleading for that case. I would
> >>>>> expect an explicit _unlocked path for that case with a comment about
> >>>>> why it's special. Is there already a comment to that effect somewhere?
> >>>>>
> >>>>
> >>>> __add_memory() - the locked variant - is called from the same ACPI location
> >>>> either locked or unlocked. I added a comment back then after a longe
> >>>> discussion with Michal:
> >>>>
> >>>> drivers/acpi/scan.c:
> >>>>         /*
> >>>>          * Although we call __add_memory() that is documented to require the
> >>>>          * device_hotplug_lock, it is not necessary here because this is an
> >>>>          * early code when userspace or any other code path cannot trigger
> >>>>          * hotplug/hotunplug operations.
> >>>>          */
> >>>>
> >>>>
> >>>> It really is a special case, though.
> >>>
> >>> That's a large comment block when we could have just taken the lock.
> >>> There's probably many other code paths in the kernel where some locks
> >>> are not necessary before userspace is up, but the code takes the lock
> >>> anyway to minimize the code maintenance burden. Is there really a
> >>> compelling reason to be clever here?
> >>
> >> It was a lengthy discussion back then and I was sharing your opinion. I
> >> even had a patch ready to enforce that we are holding the lock (that's
> >> how I identified that specific case in the first place).
> >
> > Ok, apologies I missed that opportunity to back you up. Michal, is
> > this still worth it?
> >
>
> For your reference (roughly 5 months ago, so not that old)
>
> https://lkml.kernel.org/r/20190724143017.12841-1-david@redhat.com

Oh, now I see the problem. You need to add that lock so far away from
the __add_memory() to avoid lock inversion problems with the
acpi_scan_lock. The organization I was envisioning would not work
without deeper refactoring.
