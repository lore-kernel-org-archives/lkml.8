Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3145BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F27E20720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Jh3wspYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgGGWKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgGGWKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:10:35 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9FFC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 15:10:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so43906869eje.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBcJfpgDgiWvp70CuwEdpKyzck2zYub7uFOUpyKCkM4=;
        b=Jh3wspYXTE7ZYRuNOwvWQorpJTftbYNJqBLUKdQIqpcI2eREUlbHWwZSeozLxt0mZK
         Ixbw6a9E0H1GWJTpBxBKZo/novwLgoBl3Qllh07hodbmjaap4SvK/tOn9U84kC0B1IpN
         CjECFkQ793lI6uBmu/t6a91wG+JQNLmfVUDGCq39duN8Y1UTgZxzNzWIr5IV1dBc+fC6
         JHNx9kvC6qthEr81Rqp/U53VtwS4iMp2ZejJy5hoZ+7qBmMmhF4O8ts4XrNS6A9DWqc8
         zlH31p9WJ7qwfNQj4NKfx+Qz6FAE+i1/uXkAB1sCIZTqi453fFIxkipaOIGf7Yd5PS36
         XKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBcJfpgDgiWvp70CuwEdpKyzck2zYub7uFOUpyKCkM4=;
        b=SsadXHJ9Uq+IULO/njJfnOT6/TOJQAJ3R99Vqu8YW4oP64pnIxiBBGMdOwktof+ySi
         3J0ALcTzq/PqQOxe25i3kLNlfexzhMZa29EmIeJ7lU1wyCEIw7gmWpdxZlNhEH/jjC16
         3PTJdv4oQS4J3QDUBAwbC7crVUA4PhGTurSFHsdNZHd12b8WzHqhOF95afAhaQ0I3AJ4
         tl5s7MiNa/bRUQpXoeDjHJdAzqiF+I4r/Iklc4Rux8lADjINoimco4flpkya37zYEoyr
         RcmSZ5cdE0VrmbVbO29BBTsMQTBlXxP9mA/VIsijVcV+R22FbdtAkNkdjmbrTKlQSAAH
         W5CA==
X-Gm-Message-State: AOAM532ohWM6FejuuNL6gokOwDRdcJbc9+efUuX8sCT4yQ1seCFIRdaX
        lR8OPjfRZr+UI/OewlO9CkFqj4F1kihMHvgtz5R7SQ==
X-Google-Smtp-Source: ABdhPJzLtJxDRTcMSFchyABLauV8q4dPkKqfUWNolgasMSmhXzspz37EpBiZTg6Tc2uAbgdOewLspH9Pqq5vD6jQDQw=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr48741223ejb.124.1594159833654;
 Tue, 07 Jul 2020 15:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200706011947.184166-1-justin.he@arm.com> <20200706011947.184166-4-justin.he@arm.com>
 <0b015717-b5e1-451d-9fc3-ad665ed1054a@redhat.com>
In-Reply-To: <0b015717-b5e1-451d-9fc3-ad665ed1054a@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jul 2020 15:10:22 -0700
Message-ID: <CAPcyv4gYq=jHDniKGvg2zMGqojw4bR6X90DfXKS6fZzLRzZWJA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/memory_hotplug: fix unpaired mem_hotplug_begin/done
To:     David Hildenbrand <david@redhat.com>
Cc:     Jia He <justin.he@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Kaly Xin <Kaly.Xin@arm.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 12:50 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.07.20 03:19, Jia He wrote:
> > When check_memblock_offlined_cb() returns failed rc(e.g. the memblock is
> > online at that time), mem_hotplug_begin/done is unpaired in such case.
> >
> > Therefore a warning:
> >  Call Trace:
> >   percpu_up_write+0x33/0x40
> >   try_remove_memory+0x66/0x120
> >   ? _cond_resched+0x19/0x30
> >   remove_memory+0x2b/0x40
> >   dev_dax_kmem_remove+0x36/0x72 [kmem]
> >   device_release_driver_internal+0xf0/0x1c0
> >   device_release_driver+0x12/0x20
> >   bus_remove_device+0xe1/0x150
> >   device_del+0x17b/0x3e0
> >   unregister_dev_dax+0x29/0x60
> >   devm_action_release+0x15/0x20
> >   release_nodes+0x19a/0x1e0
> >   devres_release_all+0x3f/0x50
> >   device_release_driver_internal+0x100/0x1c0
> >   driver_detach+0x4c/0x8f
> >   bus_remove_driver+0x5c/0xd0
> >   driver_unregister+0x31/0x50
> >   dax_pmem_exit+0x10/0xfe0 [dax_pmem]
> >
> > This fixes it by moving mem_hotplug_done ahead of "done"
> >
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  mm/memory_hotplug.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index e1e290577b45..86b36714342b 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1769,8 +1769,8 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
> >
> >       try_offline_node(nid);
> >
> > -done:
> >       mem_hotplug_done();
> > +done:
> >       return rc;
> >  }
> >
> >
>
> Just drop the "done" label, use "return rc;" directly instead of the
> goto, and "return 0;" at the end.
>
> Also, please add
>
> Fixes: f1037ec0cc8a ("mm/memory_hotplug: fix remove_memory() lockdep splat")
>
> and
>
> Cc: stable@vger.kernel.org # v5.6+
>
> Thanks!

Yes, thanks, you can also add:

Acked-by: Dan Williams <dan.j.williams@intel.com>
