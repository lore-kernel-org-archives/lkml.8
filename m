Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F532076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TI0Z47Xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgFVSiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbgFVSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:38:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6968C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:38:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t9so1307742lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dM8INJn6kRGq2FEawAeL2GhPksub34NKJRoXVLKVcE=;
        b=TI0Z47XkczX0wnBr4G2VO1hZyAajnpy917+FTnllD/eg5x9bdReWu3f2dbUHjKRtOL
         CLpUGhQ4o4SL2lGrdV4YIZOWOsXJemDaDV3bGmDaPmnimpWBF3GQlVuk+XIuisvmmY7u
         O9Hwy4lBfKEIlZagoRrIe9lGCNVXvUron3eByWqcIAmvKK5fr55pZbiNJyuLnmQ4js0E
         rQ/cDhmT3Dun3WYknZ3xU5HIL2PmfDAICdFUTdzur3UfmknTVqyPZzRp4dXjn6fb0+AK
         hkMR1q2AjYEp8t7rv2VoraMRvYOzYB4HwzCVqHopzhW0YTGv9Xxbp2drPlUiq+Iv6IvD
         Vw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dM8INJn6kRGq2FEawAeL2GhPksub34NKJRoXVLKVcE=;
        b=S2stQY7YoCy+7B7A96+DfP96sWyywUcl/Tr0lc9GS6kL2gDnqQjdi4zzNBg2gmxQt/
         +BcYNo/pw+thqq4jP2Kwv74F1gkRwT4GPr9NPfaDIYjQrh7MyUGh/ssK2whlNsribQyQ
         3q6GmRanZ9ipRf+yLjG/frxY1wfNePGwwG5J4RGhxoQ+dyrSIfHFu6i08KycC4hxZWWK
         GUuXWcbl11zXlIniVqQA0sCRnjXi1qzaCfmV0rLj1iP7JA6L8rTqFEebEcn95Am/JQPB
         t7HdmqH70ecm86UvHOtDODlSdvaPnvRgpc7dRJTxJ1naNkCT5SJv85a47iawsIsKVubc
         1W9g==
X-Gm-Message-State: AOAM5336bBFFZnel2CSDv036HTiYnPE40kMkv1ctVULwZnOxWxTQRePs
        1hEWp2y50UQXeoIISv93pmfPW10LsmdvZJ+Jzgbjnw==
X-Google-Smtp-Source: ABdhPJypw3V0u/eqAgrjFZ6CIZRmsTyCXAesLLFO7EQnnEnPC3jLn8U/EPc0mIxiDToaCSGXRmky4Slziv/WFp+a9iw=
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr10414987lfq.3.1592851100965;
 Mon, 22 Jun 2020 11:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-11-guro@fb.com>
 <CALvZod4Bfx3j+=spRSct5_cBL4U+XFF228iZt3EdkGqf4kokrQ@mail.gmail.com>
 <20200622180153.GB301338@carbon.dhcp.thefacebook.com> <CALvZod6A3ibpurMsuj+8F3DXYh7sb3L8eNmHf_NUTpvQCiDDmw@mail.gmail.com>
 <20200622182545.GC301338@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200622182545.GC301338@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 11:38:09 -0700
Message-ID: <CALvZod4AeRb9fhw68tNzBCRrcnU4PifjRYn51ioxa-C1RMLGHw@mail.gmail.com>
Subject: Re: [PATCH v6 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:25 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Jun 22, 2020 at 11:09:47AM -0700, Shakeel Butt wrote:
> > On Mon, Jun 22, 2020 at 11:02 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Mon, Jun 22, 2020 at 10:12:46AM -0700, Shakeel Butt wrote:
> > > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > Deprecate memory.kmem.slabinfo.
> > > > >
> > > > > An empty file will be presented if corresponding config options are
> > > > > enabled.
> > > > >
> > > > > The interface is implementation dependent, isn't present in cgroup v2,
> > > > > and is generally useful only for core mm debugging purposes. In other
> > > > > words, it doesn't provide any value for the absolute majority of users.
> > > > >
> > > > > A drgn-based replacement can be found in tools/cgroup/slabinfo.py .
> > > > > It does support cgroup v1 and v2, mimics memory.kmem.slabinfo output
> > > > > and also allows to get any additional information without a need
> > > > > to recompile the kernel.
> > > > >
> > > > > If a drgn-based solution is too slow for a task, a bpf-based tracing
> > > > > tool can be used, which can easily keep track of all slab allocations
> > > > > belonging to a memory cgroup.
> > > > >
> > > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > >
> > > > Hi Roman,
> > > >
> > > > I am not against removing the memory.kmem.slabinfo interface but I
> > > > would like to have an alternative solution more accessible than
> > > > tools/cgroup/slabinfo.py.
> > > >
> > > > In our case, we don't have ssh access and if we need something for
> > > > debugging, it is much more preferable to provide a file to read to
> > > > SREs. After the review, that file will be added to a whitelist and
> > > > then we can directly read that file through automated tools without
> > > > approval for each request.
> > > >
> > > > I am just wondering if a file interface can be provided for whatever
> > > > tools/cgroup/slabinfo.py is providing.
> > > >
> > > > Shakeel
> > >
> > > Hello, Shakeel!
> > >
> > > I understand your point, but Idk how much we wanna make this code a part
> > > of the kernel and the cgroup interface.
> >
> > No need for the cgroup interface. I was thinking of a new interface
> > like /proc/slabinfo_full which tells active objects for each
> > kmem_cache and memcg pair.
>
> To me it's a perfect example where tools like drgn and bpf shine.
> They are more flexible and do not blow the kernel up with
> the debug-only code.
>
> >
> > > The problem is that reading
> > > from it will be really slow in comparison to all other cgroup interface
> > > files. Idk if Google's version of SLAB has a list of all slab pages,
> > > but if not (as in generic SLUB case), it requires scanning of the whole RAM.
> >
> > That's a bummer. Does drgn-based script scan the whole RAM?
>
> To be precise, not over all RAM, but over all struct pages.
> Unfortunately, there is no better option with SLUB, as there is no
> comprehensive list of slab pages available. So the only option is to scan
> over all pages with PageSlab flag set.
>

So, SLUB does not have any field available in the struct page to
support the list of slab pages?

Anyways, that's a separate discussion.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
