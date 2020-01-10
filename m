Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A5C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B4220842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NjJNvotb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgAJRjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:39:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42653 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAJRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:39:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id 18so2530473oin.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Q1GBS2pY7ztdnXlxR3cAwmNzA2VCbkxidjpkZWDyrg=;
        b=NjJNvotbDqOEkfMWJSRvy4vwUYI02ZW1vOSpc2cHl5/mvinqgRmosIgnU9GAnW7jfZ
         v9Vlcqf//c1HxTEGAMSoZCLpIf7OE3Teox/n23PC6nclz3FTEGTEHizc0gQrIDAvsx1Y
         z2auqAILAT2p3aJc/R68vhuZw3zZjJkER2JgIND3oe962/kDbQ1yOS3VDme/pzfRXFPh
         lJK61eqLfeVM6f+PohuKoP5pcrgpSmWSfvGFwSh/GXRr/35//kLdmgKLKui3a3P5XyoS
         7o6za661JWFcr9eLDUbZUMVUQMLMHVoXInq4fTFQGyx1Imnt4LS/VFXOLos7XaVFBpLW
         76oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Q1GBS2pY7ztdnXlxR3cAwmNzA2VCbkxidjpkZWDyrg=;
        b=QrPM7W9YFuDQGy+xQD1VnNmwfmXwmSRCcFW9RBWHJV8FoGQF6T9pGg2ns4bRQwwX0H
         JrxeWsG/DPBXnx1VWc3cgmQoWDP4OwqmbaCQunPNr00CFaPKIy6e2qQvkPK2zkJCG0wb
         /gmT6HO/M1a0mdc2Mt5lrfHfjgZUol39feGrWrVY45V3AijcOgP9+kEBWUcoLe3jEpcI
         6kWcMXl1pgNK3MmrlTwcfvhVNiCJLNuEdRe2SwaHcElxsZskY2QLDyvsJWRWbYAUJOya
         0FyBQGkNf1+7wgPfQrSvHv4KC2cVkOPBIgmNc4VokoLTiPLryUp30N1f5LR7SL6f2cbL
         n8Mw==
X-Gm-Message-State: APjAAAXiu0Dscwrt5HRJQRDpNB1VcG2F8zF8SZDsos5ZLTpzYzVf7QPA
        jG790hGa/BRtSqPS5WarK8Zr8o08zB4Y2fLgTe1bow==
X-Google-Smtp-Source: APXvYqxARCQe9P9OLwQdhXf4V41HnnrUs1BdyjYA2CaZfxWAt/5GhiRBCgVf4q02kq9VN+CH7UUrqyW8cIun9nTI8Yc=
X-Received: by 2002:aca:1103:: with SMTP id 3mr2970929oir.70.1578677961220;
 Fri, 10 Jan 2020 09:39:21 -0800 (PST)
MIME-Version: 1.0
References: <157863061737.2230556.3959730620803366776.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e60e64f9-894b-4121-d97b-fb61459cbbe5@redhat.com> <CAPcyv4jm=fmP=-5vbo2jxzMe2qXqZP=zDYF8G_rs3X6_Om0wPg@mail.gmail.com>
 <4d0334e2-c4e7-6d3f-99ba-2ca0495e1549@redhat.com> <CAPcyv4jixmv8fJ5FiYE=97Jud3Mc+6QzRX1txceSYU+WY_0rQA@mail.gmail.com>
 <fc0cfb97-5a60-7e73-4f85-d8e6947c5e28@redhat.com> <CAPcyv4jVpN26RGQLRn4BewYtzHDoQfvh37DEdEBq1dd4-BP0kw@mail.gmail.com>
 <64902066-51dd-9693-53fc-4a5975c58409@redhat.com>
In-Reply-To: <64902066-51dd-9693-53fc-4a5975c58409@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jan 2020 09:39:10 -0800
Message-ID: <CAPcyv4hcDNeQO3CfnqTRou+6R5gZwyi4pVUMxp1DadAOp7kJGQ@mail.gmail.com>
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

On Fri, Jan 10, 2020 at 9:36 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 10.01.20 18:33, Dan Williams wrote:
> > On Fri, Jan 10, 2020 at 9:29 AM David Hildenbrand <david@redhat.com> wrote:
> > [..]
> >>> So then the comment is actively misleading for that case. I would
> >>> expect an explicit _unlocked path for that case with a comment about
> >>> why it's special. Is there already a comment to that effect somewhere?
> >>>
> >>
> >> __add_memory() - the locked variant - is called from the same ACPI location
> >> either locked or unlocked. I added a comment back then after a longe
> >> discussion with Michal:
> >>
> >> drivers/acpi/scan.c:
> >>         /*
> >>          * Although we call __add_memory() that is documented to require the
> >>          * device_hotplug_lock, it is not necessary here because this is an
> >>          * early code when userspace or any other code path cannot trigger
> >>          * hotplug/hotunplug operations.
> >>          */
> >>
> >>
> >> It really is a special case, though.
> >
> > That's a large comment block when we could have just taken the lock.
> > There's probably many other code paths in the kernel where some locks
> > are not necessary before userspace is up, but the code takes the lock
> > anyway to minimize the code maintenance burden. Is there really a
> > compelling reason to be clever here?
>
> It was a lengthy discussion back then and I was sharing your opinion. I
> even had a patch ready to enforce that we are holding the lock (that's
> how I identified that specific case in the first place).

Ok, apologies I missed that opportunity to back you up. Michal, is
this still worth it?
