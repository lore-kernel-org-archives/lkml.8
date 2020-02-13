Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F4BC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56A420873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SmXDDB05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgBMWnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:43:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35736 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMWnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:43:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so7305661otd.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 14:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hY6CV+ND7e1YGXWSjo+0nHc7akywE0TMpMRwKM18M98=;
        b=SmXDDB05FgkSDjl82jr0vRzKFNDC3TzgJv9zwXei/I8lhH2nzhediAtWrWFbK9wXps
         wqfiVO9vLKiQJNvx+mp9CQFnigfPh8wsRpGBXWaHzSNrFsKci0RSWKoq+fG8mOU1ja3K
         /NCtdPzVJL3iA8WlfgAGnEM6bun1wPKuHZEjQxtkZChKXjNflJXcfsnvL1rclMTMlK6x
         gJQBCVPju+i+TEYEemIW2T1wXWG0kEK3aCPIDm7r9cls3Ljs7SmIhsmz4tCY7Narvkw4
         zbytoCGOxRXBfvQLCi0bOqRXCJxEiRUBxiMN+CtG/8LyrUCmJy9Hbtn4FVG7+NX2yDTj
         lGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hY6CV+ND7e1YGXWSjo+0nHc7akywE0TMpMRwKM18M98=;
        b=uhHChxGQtgi+deBFcUfy2zg/7Ufy5dnude3dWtwj/pSoxFMq1mNebLE1oVEYcvnDo1
         6RnYHyz952k87JE1slxpQl+sxt6Kin/X+kkxVthT7ezGZ+tI5cajxh7N2FaKb6xLD6F5
         Jo59j/adir1+H6ZzgIK25m3j504Y8UiedyxCIHOwRD3zciPb52vZr1ZWSjMrltZ6Z1SL
         1QXs7qYWX7ZO70c0Fp/q2ngjRO/DRUsiLXbyuJuM6woAJ54MFTu96t4m0rUFyuH08cU2
         oSH9bZeDJ77dKFNeKBIhXtHUEHDFqFcKI0Tq8ONSEiGf3f5PI37t0OqOjvoXRrhH+0Bz
         nw9Q==
X-Gm-Message-State: APjAAAXeSlCEg9Lde854etLLuFhtgMlgDtP9rCQLrE8Hc80TfsJml1HW
        o5EnuOGmSKQ+lHODPDb4v/BQ+Iqo72TRcCkEMCSu+Q==
X-Google-Smtp-Source: APXvYqwh0QpibBwkg8wqD1qCgWrU0VARu4V8rflQRY8+mOYx9YxokcdwDNt0F3KAuE2fZ50H4DcCVvTlaEy10NTp/PU=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr15692065otk.363.1581633819941;
 Thu, 13 Feb 2020 14:43:39 -0800 (PST)
MIME-Version: 1.0
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158155490897.3343782.14216276134794923581.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49k14q5ezs.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49k14q5ezs.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Feb 2020 14:43:28 -0800
Message-ID: <CAPcyv4hQouRNBcJ4uZ2mysr_aKstLhvUf66gRQ_3QoQNyOy72g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] libnvdimm/namespace: Enforce memremap_compat_align()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 1:55 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The pmem driver on PowerPC crashes with the following signature when
> > instantiating misaligned namespaces that map their capacity via
> > memremap_pages().
> >
> >     BUG: Unable to handle kernel data access at 0xc001000406000000
> >     Faulting instruction address: 0xc000000000090790
> >     NIP [c000000000090790] arch_add_memory+0xc0/0x130
> >     LR [c000000000090744] arch_add_memory+0x74/0x130
> >     Call Trace:
> >      arch_add_memory+0x74/0x130 (unreliable)
> >      memremap_pages+0x74c/0xa30
> >      devm_memremap_pages+0x3c/0xa0
> >      pmem_attach_disk+0x188/0x770
> >      nvdimm_bus_probe+0xd8/0x470
> >
> > With the assumption that only memremap_pages() has alignment
> > constraints, enforce memremap_compat_align() for
> > pmem_should_map_pages(), nd_pfn, or nd_dax cases.
> >
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Cc: Jeff Moyer <jmoyer@redhat.com>
> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Link: https://lore.kernel.org/r/158041477336.3889308.4581652885008605170.stgit@dwillia2-desk3.amr.corp.intel.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/nvdimm/namespace_devs.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> > index 032dc61725ff..aff1f32fdb4f 100644
> > --- a/drivers/nvdimm/namespace_devs.c
> > +++ b/drivers/nvdimm/namespace_devs.c
> > @@ -1739,6 +1739,16 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
> >               return ERR_PTR(-ENODEV);
> >       }
> >
> > +     if (pmem_should_map_pages(dev) || nd_pfn || nd_dax) {
> > +             struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
> > +             resource_size_t start = nsio->res.start;
> > +
> > +             if (!IS_ALIGNED(start | size, memremap_compat_align())) {
> > +                     dev_dbg(&ndns->dev, "misaligned, unable to map\n");
> > +                     return ERR_PTR(-EOPNOTSUPP);
> > +             }
> > +     }
> > +
> >       if (is_namespace_pmem(&ndns->dev)) {
> >               struct nd_namespace_pmem *nspm;
> >
>
> Actually, I take back my ack.  :) This prevents a previously working
> namespace from being successfully probed/setup.

Do you have a test case handy? I can see a potential gap with a
namespace that used internal padding to fix up the alignment. The goal
of this check is to catch cases that are just going to fail
devm_memremap_pages(), and the expectation is that it could not have
worked before unless it was ported from another platform, or someone
flipped the page-size switch on PowerPC.

> I thought we were only
> going to enforce the alignment for a newly created namespace?  This should
> only check whether the alignment works for the current platform.

The model is a new default 16MB alignment is enforced at creation
time, but if you need to support previously created namespaces then
you can manually trim that alignment requirement to no less than
memremap_compat_align() because that's the point at which
devm_memremap_pages() will start failing or crashing.
