Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFDEC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E74724654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="b+UsIt9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgBSQhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:37:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45859 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBSQhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:37:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so694270otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSsfOBW1rnJ26Vr6Y/Sa9MI6os2MsKzLmHRcdZqPPC0=;
        b=b+UsIt9fkyZ8iGryZtZyohqg6R/VATs/6iMW6i+XQK4N741jwE+n2AxK3dUsh/6+K5
         eIXmCJbSkd+LUj3iTJWRNAoUVUC5Tu1X4c4Ki8zsO9y3sMxr7U/9dSxyh3C1p5sNHi0N
         SYGQvadeUGkkREFLoJJmmXVn8Og9pU/vFCDSai+QYtX1CoxYoZ4J2oefAAAI2jDnmp4f
         ofBrFqRdVSYxa4nW8Hfr8WaXxsxpK4+hlQU8YmsHgAjjYASEkKJyyo2KarfXQjGSf5Ot
         vOAVan65Ipr039hQ7zjiwohZ65MislEBrHxR4J12En4Gvncpct4/+pVgSqAuWrPJX47O
         likg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSsfOBW1rnJ26Vr6Y/Sa9MI6os2MsKzLmHRcdZqPPC0=;
        b=UiJ2P3zAZdgCvMfQI9b+kz35td+iIIz89ac4NIX4yIlOUfiOoP+CtCjqNcqJQaDnZt
         hGJfNg2JeEvP1HAdXPhxX6rk3/LmpNGFPdwl1mrVDWh+uD88Sd/5WhxZmYVyDdO1TV6f
         cVV5PAbv552Zw1AC8w3b5AjIDTHx/nodH/DMMUG5EABYpaqGTYEP5EzWN2dHlugzvAG1
         1oKDovxAOaSX0MxouVC7SBkmN3WG3rZyzX6OiNJ4WtX+4kqDcNSZ2LsyPFtAM5wwuE0R
         SgMCHGhgzhbrWm80n6HmE9t2KYG2qCgNq+g5ZSh6XmqtHPReEvFLrqad3anbkBF3kHjS
         uOXQ==
X-Gm-Message-State: APjAAAWABR7Fk27XVMrpzZTF/7KT4WScncTbvCr8JufqpQDr61b082vX
        wF6xw35klzEfgTi31RRQlVHhquplo/sXqYI7Ot+YnQ==
X-Google-Smtp-Source: APXvYqwlpfAoafRtm4MF7B/l/TtM6lSjeomq1oF/grFfaR6O1EaCjOchOyx7IWgEAjiqs1obxb+eI0nE9T+m5Tre94c=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr20935125otk.363.1582130256442;
 Wed, 19 Feb 2020 08:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20200219030454.4844-1-bhe@redhat.com> <CAPcyv4iZCnSpypshYpXCL35yT4KZfgXqDqS8cFDGpXC-A72Utg@mail.gmail.com>
 <20200219085700.GB32242@linux.ibm.com>
In-Reply-To: <20200219085700.GB32242@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Feb 2020 08:37:25 -0800
Message-ID: <CAPcyv4isoKSo2TtP3_VzdPQwdfc2O=KAv44LkqSSTccP7Cnh7A@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:57 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Feb 18, 2020 at 07:25:15PM -0800, Dan Williams wrote:
> > On Tue, Feb 18, 2020 at 7:05 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > From: Wei Yang <richardw.yang@linux.intel.com>
> > >
> > > When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
> > > doesn't work before sparse_init_one_section() is called. This leads to a
> > > crash when hotplug memory:
> >
> > I'd also add:
> >
> > "On x86 the impact is limited to x86_32 builds, or x86_64
> > configurations that override the default setting for
> > SPARSEMEM_VMEMMAP".
>
> Do we also want to check how it affects, say, arm64, ia64 and ppc? ;-)

Sure, I just did not take the time to look up their respective default
stances on SPARSEMEM_VMEMMAP. For a distro looking to backport this
commit I think it's helpful for them to understand if they are exposed
or not.
