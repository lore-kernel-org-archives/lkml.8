Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D0C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 06:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D239520814
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 06:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591426098;
	bh=1ObBheOHe+xYMaiyZdJI009sxV6vKq8/5L3XtuBKZi4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mJ0JxRlClGuKY9bdE739s+vWnaEXl3Ln8c12wwsIIID1GcNDyNgLWLIQbkfAAUzFd
	 eu6T2Z1a8a486KDKAjQz9H+HLe63Rp3TtdMBGVwVOo0Jbkoy2sTXvk2CYcEM/YFPnr
	 g3Iwcz9zbO3DG94cDpQbuVkP9+qBjkRZTx+D3W6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgFFGsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 02:48:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40626 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFFGsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 02:48:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id s13so9463929otd.7;
        Fri, 05 Jun 2020 23:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aQLNzslwbNr61yynEZEbahvlkcr5toggFOf8ArYr9g=;
        b=nZqUn++F0zY91CAYdLJVCUedTAHNVxBByrpqhp/SySY38bQpdNhAV+1rm6XLbI0HFZ
         O8kQFjIeO3ouCGmgEDsiLYOrTDxKAc5XfxSJZsA+gjnMnhgJJ/CXWhwtrWPvdQrMxYJk
         gvvMJiof5pKjPwSalhx0ZmdM6JeA1iZzbnR9eqD0T+z8Iez5dkf+SVhp2Bt4H6o8qtSt
         bS2ZmeT0bLUkTF0SFd0W6x1FYzMvAgYkDrRzJFwfUu+yWwLmwCnUmoPJ93mBWscQPd2X
         D+S3meGDFWe1jnxGBZFAg8vZMVwscDWMd/OGZmqJzGiZUAshnWNDnvJmqvywnLhbGyOc
         A1AQ==
X-Gm-Message-State: AOAM531Clx5eYL+5n1oORPDyyAZl3sWVN7c3ErZ52FBQUXPzEF55M1Bw
        vIT/NWGXfcbytQX3QcGqxsFXYN+X5PYhlEOHXj0=
X-Google-Smtp-Source: ABdhPJz65WaazHUQLYExUKsLF9v8Y9URApAU8lJ65W8OCHHvRpRP6ZlEV0lHXZ2r87+tcUaFkFy8iWSi7GfxwLBgGXM=
X-Received: by 2002:a9d:5185:: with SMTP id y5mr9787455otg.118.1591426096725;
 Fri, 05 Jun 2020 23:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2643462.teTRrieJB7@kreacher> <CAHp75Ve8A373Cbw6RiKTtkhj9jsxZ9dBY8ELtntk0B=yXxOCUg@mail.gmail.com>
In-Reply-To: <CAHp75Ve8A373Cbw6RiKTtkhj9jsxZ9dBY8ELtntk0B=yXxOCUg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 6 Jun 2020 08:48:05 +0200
Message-ID: <CAJZ5v0hpwOJfy_4c3O-TWHh=cd=qiOcb3JCyRoq-igsW+12ZvA@mail.gmail.com>
Subject: Re: [RFT][PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 9:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jun 5, 2020 at 5:11 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> ...
>
> > +       if (!refcount) {
> > +               write_lock_irq(&acpi_ioremaps_list_lock);
> > +
> > +               list_del(&map->list);
> > +
> > +               write_unlock_irq(&acpi_ioremaps_list_lock);
> > +       }
> >         return refcount;
>
> It seems we can decrease indentation level at the same time:
>
>   if (refcount)
>     return refcount;
>
>  ...
>  return 0;

Right, but the patch will need to be dropped anyway I think.
