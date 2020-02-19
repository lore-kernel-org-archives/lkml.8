Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A5FC18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B9524671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IRi5B/1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBSUNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:13:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36238 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:13:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so25138768oic.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltezjsG9cSeHNkUm3cauVbVZTwpvmoNXDjvuDFet2sM=;
        b=IRi5B/1JkjrG8O+hgNdmDfNuMqa+TLAAJAPTdn6sDCzd28nD/4BBjrY0jpwcB69pnA
         amzDXtf4MgDL9f34kLbb+Nzl57smWOCOTQ670TdWKaYV42bTviKJf0Xj6GJC4PD6pkQF
         Bd1ktnFHc/nM5S1iG8rVM9lTxtRzh5o9Ji0ol9iexX5IDZRpYX8hJUnZkT70JtGtOtIO
         eQoiVJQMJHa26koYZa8tN/oygTuDjKGSsyWe2Mio+Th+yKTOMg35CIVZPg5SD8jAp40P
         2AopbEDYMWC4cj6a3QpDnxLMv1wVEy2IevIoxT0MeICHbu2fhR4o/9sqYf1A1JgXX7Gw
         ef+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltezjsG9cSeHNkUm3cauVbVZTwpvmoNXDjvuDFet2sM=;
        b=GqN6mIuyDzcrDqxm4d6DycIphVXtIbvIH2RuEFMHqOquREMZ2eOjN9blpecg51gdzQ
         CmbyRFdyq01455AzhaqC4M/EqkQMTRJdY6dukSp1oHbB3BIErp7lfpZSole3ugRxd5/o
         QLcm2GbH0YMx+L4bLnKwlLUufOaKPRj9HIkr/Kqyeqz+6kmzJeaz2QmPLjtUfCa7uFPd
         oFtIdyemNhUmdRnuOwMWiY4LoqxYLepZ1nh3/3kR+koIL4/RWW9MqYgPAoej+fhwaUZS
         eS7fUg7xGxUcxLs/Sngpt0JBuGmr4b8PmMsgi7Icm/h4cWgfQtnGqIen3p/KpmcYQ9gU
         ryFA==
X-Gm-Message-State: APjAAAWsmQ3/KOz/ot+DzMQGQEdiWOHIm/yhTO8/3TDIV+ui7OS/zjGh
        mMcxMLoGRmMbrl0i0r7k5rLsvS2o9SaVwSMnB6fBkA==
X-Google-Smtp-Source: APXvYqz4NhWRoo1EICJU8OdpnN9pDE7X7qZnDKtFmnO6vC/1zk0OTCtrIIArbc3e3Go1vVD3JLgrDRR4zg7rIkxKLmc=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr6146041oij.0.1582143224013;
 Wed, 19 Feb 2020 12:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20200219030454.4844-1-bhe@redhat.com> <20200219115042.e8738272455292d3a6a6e498@linux-foundation.org>
In-Reply-To: <20200219115042.e8738272455292d3a6a6e498@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Feb 2020 12:13:33 -0800
Message-ID: <CAPcyv4hzkK6Me27_eK0bCkUrD7wBG4OfbofZzx40R--S0fxrvA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:50 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 19 Feb 2020 11:04:54 +0800 Baoquan He <bhe@redhat.com> wrote:
>
> > From: Wei Yang <richardw.yang@linux.intel.com>
> >
> > When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
> > doesn't work before sparse_init_one_section() is called. This leads to a
> > crash when hotplug memory:
> >
> > [   41.839170] BUG: unable to handle page fault for address: 0000000006400000
> > [   41.840663] #PF: supervisor write access in kernel mode
> > [   41.841822] #PF: error_code(0x0002) - not-present page
> > [   41.842970] PGD 0 P4D 0
> > [   41.843538] Oops: 0002 [#1] SMP PTI
> > [   41.844125] CPU: 3 PID: 221 Comm: kworker/u16:1 Tainted: G        W         5.5.0-next-20200205+ #343
> > [   41.845659] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> > [   41.846977] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> > [   41.847904] RIP: 0010:__memset+0x24/0x30
> > [   41.848660] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
> > [   41.851836] RSP: 0018:ffffb43ac0373c80 EFLAGS: 00010a87
> > [   41.852686] RAX: ffffffffffffffff RBX: ffff8a1518800000 RCX: 0000000000050000
> > [   41.853824] RDX: 0000000000000000 RSI: 00000000000000ff RDI: 0000000006400000
> > [   41.854967] RBP: 0000000000140000 R08: 0000000000100000 R09: 0000000006400000
> > [   41.856107] R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
> > [   41.857255] R13: 0000000000000028 R14: 0000000000000000 R15: ffff8a153ffd9280
> > [   41.858414] FS:  0000000000000000(0000) GS:ffff8a153ab00000(0000) knlGS:0000000000000000
> > [   41.859703] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   41.860627] CR2: 0000000006400000 CR3: 0000000136fca000 CR4: 00000000000006e0
> > [   41.861716] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   41.862680] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   41.863628] Call Trace:
> > [   41.863983]  sparse_add_section+0x1c9/0x26a
> > [   41.864570]  __add_pages+0xbf/0x150
> > [   41.865057]  add_pages+0x12/0x60
> > [   41.865489]  add_memory_resource+0xc8/0x210
> > [   41.866017]  ? wake_up_q+0xa0/0xa0
> > [   41.866416]  __add_memory+0x62/0xb0
> > [   41.866825]  acpi_memory_device_add+0x13f/0x300
> > [   41.867410]  acpi_bus_attach+0xf6/0x200
> > [   41.867890]  acpi_bus_scan+0x43/0x90
> > [   41.868448]  acpi_device_hotplug+0x275/0x3d0
> > [   41.868972]  acpi_hotplug_work_fn+0x1a/0x30
> > [   41.869473]  process_one_work+0x1a7/0x370
> > [   41.869953]  worker_thread+0x30/0x380
> > [   41.870396]  ? flush_rcu_work+0x30/0x30
> > [   41.870846]  kthread+0x112/0x130
> > [   41.871236]  ? kthread_create_on_node+0x60/0x60
> > [   41.871770]  ret_from_fork+0x35/0x40
> >
> > We should use memmap as it did.
> >
> > Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > CC: Dan Williams <dan.j.williams@intel.com>
>
> This should have included your signed-off-by, as you were on the patch
> delivery path.  I have made that change to my copy of the patch - is
> that OK?
>
> I also added a cc:stable.  Do we agree this is appropriate?

I see no harm.

> I added Dan's "On x86 the impact is limited to x86_32 builds, or x86_64
> configurations that override the default setting for
> SPARSEMEM_VMEMMAP." to the changelog.

Can also add with Mike's sleuthing. "Other memory hotplug archs
(arm64, ia64, and ppc) also default to SPARSEMEM_VMEMMAP=y."
