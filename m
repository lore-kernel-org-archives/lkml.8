Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D74C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 05:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5686F20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 05:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xqhYbXKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgBFFvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 00:51:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35766 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgBFFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 00:51:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so4422598otd.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 21:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5g0ucY/9ZUFtix2XnQy2cuPMuPVQiShNOwSgn0I8OBU=;
        b=xqhYbXKDufyJWDOQlr2Ba/YbuGJTDJ2ziwxMsioPHK8lJUB4/CAxrEL+moRSD8vyrb
         P8EqSdqAMegqk31UKFdftPK5/+cmDLrCM6ly22OIyg6gsdd2R7ZLPjw9pcUJ/q5RR0G5
         fLmVfaMcawk1UE/23D6St4s/a6I9mTLo3F5jajstpw7oCE/fYrfhTRbXrLuPqW2SHJPy
         AJ5z5DEgvFpoMlwxgzPfG0OUuAZs64RZ1jdy1x38BTGcFFSZZlvzqoHwnS5WYlKlxHrT
         S4P0VJvg0zJv7zvW0pAdwx8kw9JZ9LQMIqF1abVjF4Dd0TKDl4DBYq5Lc7iYYQ8GUTiR
         SyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5g0ucY/9ZUFtix2XnQy2cuPMuPVQiShNOwSgn0I8OBU=;
        b=Vc+BeWU2M3lyecKdxL9q35GS6zRE6hvHVKs7szVLJ1wut3QiQtmj42szBaa55GDbP7
         RezydhkzA+go1AB/1Ef+VZDy3qzkgAgnNscmzCQ2GhaA1aZlisx+fTqtSR0MBrQdRgwf
         S7mxMRDCSNm/yHa5LzdNMbDREmCP5SZp9mjyIYLYrK9BSCCzVEoLwr/vNrO2/ViYXyuN
         XMK6Q/BOfyatKB7RgTs8NrVZKm9ArE2fp4uhKcrK9BZEhgTYPLo5zTpCxG8D8ieAQDV/
         bONctGFWggNBQgn2v6PenzDtyYicjJji8320tikD1uFyqAYBEHlIZ5mwAOdsg/+PFrDq
         sfuA==
X-Gm-Message-State: APjAAAXuhloAzZlYEM6un+Pa5S8VMlSaIcjNNTg/CCvSOD/GbbrOFkJq
        JD3X1wX+8NEk9NcOzncoAazDHUU3JCzqy0UDpq+sBZynjcI=
X-Google-Smtp-Source: APXvYqypAdFCvnslXe/NRqIbZavieNDLc3RQJ1uJD67YGnwibNCmUiqPR2pnxgssN+GhWMlzNTosjpJpU37+bWuZVfs=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr27237824otl.71.1580968298443;
 Wed, 05 Feb 2020 21:51:38 -0800 (PST)
MIME-Version: 1.0
References: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158041476763.3889308.13149849631980018039.stgit@dwillia2-desk3.amr.corp.intel.com>
 <875zgl3fa9.fsf@mpe.ellerman.id.au>
In-Reply-To: <875zgl3fa9.fsf@mpe.ellerman.id.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Feb 2020 21:51:27 -0800
Message-ID: <CAPcyv4jVHnJbPYp1gqDnuwtEgt1NNHDt72vby7hK5dP43C+s8Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/memremap_pages: Introduce memremap_compat_align()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 7:05 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > The "sub-section memory hotplug" facility allows memremap_pages() users
> > like libnvdimm to compensate for hardware platforms like x86 that have a
> > section size larger than their hardware memory mapping granularity.  The
> > compensation that sub-section support affords is being tolerant of
> > physical memory resources shifting by units smaller (64MiB on x86) than
> > the memory-hotplug section size (128 MiB). Where the platform
> > physical-memory mapping granularity is limited by the number and
> > capability of address-decode-registers in the memory controller.
> >
> > While the sub-section support allows memremap_pages() to operate on
> > sub-section (2MiB) granularity, the Power architecture may still
> > require 16MiB alignment on "!radix_enabled()" platforms.
> >
> > In order for libnvdimm to be able to detect and manage this per-arch
> > limitation, introduce memremap_compat_align() as a common minimum
> > alignment across all driver-facing memory-mapping interfaces, and let
> > Power override it to 16MiB in the "!radix_enabled()" case.
> >
> > The assumption / requirement for 16MiB to be a viable
> > memremap_compat_align() value is that Power does not have platforms
> > where its equivalent of address-decode-registers never hardware remaps a
> > persistent memory resource on smaller than 16MiB boundaries.
> >
> > Based on an initial patch by Aneesh.
> >
> > Link: http://lore.kernel.org/r/CAPcyv4gBGNP95APYaBcsocEa50tQj9b5h__83vgngjq3ouGX_Q@mail.gmail.com
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/powerpc/include/asm/io.h |   10 ++++++++++
> >  drivers/nvdimm/pfn_devs.c     |    2 +-
> >  include/linux/io.h            |   23 +++++++++++++++++++++++
> >  include/linux/mmzone.h        |    1 +
> >  4 files changed, 35 insertions(+), 1 deletion(-)
>
> The powerpc change here looks fine to me.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks Michael, unfortunately the kbuild robot just woke up and said
that mips does not like including mmzone.h from io.h. The
entanglements look intractable.

Is there a file I can stash a strong definition of
memremap_compat_align(), maybe arch/powerpc/mm/mem.c? Then I can put a
generic __weak definition in mm/memremap.c rather than play header
file include games.
