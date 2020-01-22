Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E25C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C112467F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KTTat97k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAVUvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:51:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43302 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:51:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so613654oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIoRmzHYTdpp+dqkgtOBAN7ncVHrjk3h+URxl69sPsU=;
        b=KTTat97kNuZvEUjvtDsTDzjPFUlG4KFZhZl+L6EC2PUatXH7uO7Fwgd4s6J58cZhN5
         gFfWgSMR9b8GP4PDwfSvlZvOzvYU7a8/5bet4UUOtnOoJDkm3Z2dEBjnwzrocD017Rf4
         Fi2e7cyAJ7RFuyunUhht5zqTEOrcAgKo8OuGKuibOv6MaxPQI6yH2gj1cQL4WVe9JLVb
         9suPZhEO9ZuVE+dk4q7RjQzz3bYS71BwsbbExkx8V/pfSsmMhU+Bm7J8DfdFJ7XNpM1K
         jE32TDYypZKfW0hhy389pFV0hc9k9hp2LMRDf2xco+fNCjphLs7c5CjBg9cy3okaphV1
         T2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIoRmzHYTdpp+dqkgtOBAN7ncVHrjk3h+URxl69sPsU=;
        b=EQiXqXM/XfEbVYXj5lbVR6hWJ3ycTkHSgdpGEuT7PQ3UyoPigJeeJUkYaa/No3hFap
         2687wDe8ou3wSoZp2DcLI4sHnMjsjVyhmPv9r/Z3FVMvbmPa9dPFq/B9uGTz7Qj6pcCC
         oXZ1Ow81hPNpfF3cP15ovq4pR9FxKipb+vrNAxdTDG8cXKJ/WvtDiV4UlCzVopS3k+/1
         mYx7a9sLgNVDUpAIENFQlHEBbE5sBlI49hWmNiS2yvkE/u1DMnyvR0VeEkEeLEMwSqrb
         pZcpxXBz+8TMkUvVHOf2aJLxG2RXNzGTzsSVJxOT4zEkd00K8r1hUCCfM9E17QdFSP/1
         h+Ng==
X-Gm-Message-State: APjAAAVx57ICEfFewoK+VW2sZ60cqONMya0NpPcf1hEbehUIfw+NdsUp
        /RHojQaRVBdqV2j779tXaunpLknHHHGMA7jXr2/RIA==
X-Google-Smtp-Source: APXvYqw6v4/RiaBhyLB4WHjODSz1dAkLJtJwJGKbGaMd/yQZSfCSqgwxWgXkA77oncy7GPixkDTN6S48x5VwRtTkUVA=
X-Received: by 2002:a05:6830:4d9:: with SMTP id s25mr8907122otd.171.1579726300916;
 Wed, 22 Jan 2020 12:51:40 -0800 (PST)
MIME-Version: 1.0
References: <a5f0bd8d-de5e-9f27-5c94-7746a3d20a95@redhat.com>
 <20200121120714.GJ29276@dhcp22.suse.cz> <a29b49b9-28ad-44fa-6c0b-90cd43902f29@redhat.com>
 <20200122104230.GU29276@dhcp22.suse.cz> <98b6c208-b4dd-9052-43f6-543068c649cc@redhat.com>
 <816ddd66-c90b-76f1-f4a0-72fe41263edd@redhat.com> <20200122164618.GY29276@dhcp22.suse.cz>
 <626d344e-8243-c161-cd07-ed1276eba73d@redhat.com> <20200122183809.GB29276@dhcp22.suse.cz>
 <f35cbe9e-b8bf-127e-698f-d08972d30614@redhat.com> <20200122190903.GD29276@dhcp22.suse.cz>
In-Reply-To: <20200122190903.GD29276@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 22 Jan 2020 12:51:28 -0800
Message-ID: <CAPcyv4hrEKHFnPQwzU+NCNhC2Hfqxd440XbsxsHf4f6RhquJFQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        lantianyu1986@gmail.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:09 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 22-01-20 19:46:15, David Hildenbrand wrote:
> > On 22.01.20 19:38, Michal Hocko wrote:
> [...]
> > > How exactly is check + offline more optimal then offline which makes
> > > check as its first step? I will get to your later points after this is
> > > clarified.
> >
> > Scanning (almost) lockless is more efficient than bouncing back and
> > forth with the device_hotplug_lock, mem_hotplug_lock, cpu_hotplug_lock
> > and zone locks - as far as I understand.
>
> All but the zone lock shouldn't be really contended and as such
> shouldn't cause any troubles. zone->lock really depends on the page
> allocator usage of course. But as soon as we have a contention then it
> is just more likely that the result is less reliable.
>
> I would be also really curious about how much actual time could be saved
> by this - some real numbers - because hotplug operations shouldn't
> happen so often that this would stand out. At least that is my
> understanding.
>
> > And as far as I understood, that was the whole reason of the original
> > commit.
>
> Well, I have my doubts but it might be just me and I might be wrong. My
> experience from a large part of the memory hotplug functionality is that
> it was driven by a good intention but without a due diligence to think
> behind the most obvious usecase. Having a removable flag on the memblock
> sounds like a neat idea of course. But an inherently racy flag is just
> borderline useful.
>
> Anyway, I will stop at this moment and wait for real usecases.

...that and practical numbers showing that optimizing an interface
that can at best give rough estimate answers is worth the code change.
