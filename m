Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B5AC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0EE206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="r7ELJ2cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgGMQJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMQJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:09:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76E2C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:09:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so14133695edr.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPX1344KqFXDG152MSs7m1f71nuvQxMI0VbbfK01bWI=;
        b=r7ELJ2cBdTaQzo9pqUPojaVz6tHhKqoH2KZY2zuAlJN0hbnOqbT4c12Oy38pcBR/Nj
         utOjvomkH01KnV48ustA657XHya8dxhiC4zKoTXDfmRE5M9q3CaTL/2f1Ttg6runvIq7
         RWnzutbQaMQZuQkbRYM6KLs9dYVs2pWP8m2YSi7TYPnwA2kYkHbV3zTVnZD3+aGspwQv
         visTBbIeQ8KXGdQAzK/GZmGnfQOSTPpyx1Y/65IykomzQzj2jp7TFsb05AzbD0WDujBa
         O7/7Q4OI36y4JCe9b58Hkm5W/23aJBSWmta1Co+BkMqTd+7t5uECfERRweordez+CtHr
         OHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPX1344KqFXDG152MSs7m1f71nuvQxMI0VbbfK01bWI=;
        b=Lq/nubIDlsu8eq6qE3Yb9GtFSyb3mXfvQDS9v3oW9fU1GDvm2LFjN79+vqUcqlxow7
         NSihBPQmy7b53cxNm2LuMZAH8Qr8IOLS8c99weZdfrUfySdtOWARNnZKxtZVqzmfWNvE
         vha8ZKs+Tocub80Srnu6MhGNTMLhGWGIJuHGNTvn+fK2BHQXVj1gZl1VifCRFNY+OWRp
         ArlbMir9+UlMlnCPqr2d8BsadrrcreC0q09iNfkhwSOhzmyoAmwU1iFWxU2N9OAXOFmM
         OjlA66PvtFJDYLigyIMINcCEYq+86jTts6EYwWte9HvRpQaXWL4o0Yw3lOVJVwmYv/jN
         sEaA==
X-Gm-Message-State: AOAM530EGfYJFHFh4WCYlRWiROBwJ12PJ6rmlXdacBiyPHyU5UeMlg3k
        2SvqxZygC5rltwc3LyB76RLeWaUCfWAC66Yb0XSRcg==
X-Google-Smtp-Source: ABdhPJzkfFp48TgN6o9u+tichXDgD3w2nI1pgUIrildgifHznsxd6AynKdQoAl6SqJnCRUpI/mZg24+ERLg8WLos9MU=
X-Received: by 2002:a50:ee8a:: with SMTP id f10mr95726edr.383.1594656569387;
 Mon, 13 Jul 2020 09:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200712170945.GA194499@kroah.com> <CAPcyv4h=7oB+PHEUa6otkoXYx+r_8GFbmuF-j_kOmHjpGB-=eg@mail.gmail.com>
 <20200713155222.GB267581@kroah.com>
In-Reply-To: <20200713155222.GB267581@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 09:09:18 -0700
Message-ID: <CAPcyv4ijb3nS3WuO38Yn3epBec8uQqw+UfimqFByqRT9QXCpLw@mail.gmail.com>
Subject: Re: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 8:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 13, 2020 at 08:39:43AM -0700, Dan Williams wrote:
> > On Sun, Jul 12, 2020 at 10:09 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jul 12, 2020 at 09:27:37AM -0700, Dan Williams wrote:
> > > > Use sysfs_streq() in device_find_child_by_name() to allow it to use a
> > > > sysfs input string that might contain a trailing newline.
> > > >
> > > > The other "device by name" interfaces,
> > > > {bus,driver,class}_find_device_by_name(), already account for sysfs
> > > > strings.
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  drivers/base/core.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 67d39a90b45c..5d31b962c898 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
> > > >
> > > >       klist_iter_init(&parent->p->klist_children, &i);
> > > >       while ((child = next_device(&i)))
> > > > -             if (!strcmp(dev_name(child), name) && get_device(child))
> > > > +             if (sysfs_streq(dev_name(child), name) && get_device(child))
> > >
> > > Who wants to call this function with a name passed from userspace?
> > >
> > > Not objecting to it, just curious...
> > >
> >
> > The series that incorporates this patch adds a partitioning mechanism
> > to "device-dax region" devices with an:
> >     "echo 1 > regionX/create" to create a new partition / sub-instance
> > of a region, and...
> >     "echo $devname > regionX/delete" to delete. Where $devname is
> > searched in the child devices of regionX to trigger device_del().
>
> Shouldn't that be done in configfs, not sysfs?

I see configfs as an awkward fit for this situation. configfs wants to
software define kernel objects whereas this facility wants to augment
existing kernel enumerated device objects. The region device is
created by firmware policy and is optionally partitioned, configfs
objects don't exist at all until created. So for this I see sysfs +
'scheme to trigger child device creation' as just enough mechanism
that does not warrant full blown configfs.

I believe it was debates like this [1] that have led me to the camp of
sysfs being capable of some device creation dynamism and leave
configfs for purely software constructed objects.

[1]: https://lore.kernel.org/lkml/17377.42813.479466.690408@cse.unsw.edu.au/

> > This arrangement avoids one of the design mistakes of libnvdimm which
> > uses a sysfs attribute of the device to delete itself. Parent-device
> > triggered deletion rather than self-deletion avoids those locking
> > entanglements.
>
> Ugh, yeah, getting rid of that would be great, it's a mess.  I think
> scsi still does that :(

Yeah, both nvdimm and scsi both end up need to delay device deletion
to its own thread, and it has led to bugs in the nvdimm case.
