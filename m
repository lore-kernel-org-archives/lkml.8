Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C7BC352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A851720848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zJGAaqSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgBMC2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:28:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34547 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbgBMC2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:28:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so4137949otl.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 18:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hAsIRHvvpbi9rt/0W0BIpJsAiPhpdF9DzTF7MWukEo=;
        b=zJGAaqSk9K45xDEtrZiv/eOt/Ret00uN1fgyVdZproL1adSyD3VrZY3pR4XpqymNJW
         ApzlQ7myJviaJFmW3r7/Rllj9Ed0UUxk9+C/DmXXheJZiTXT59ftF8p36g6LzIjRvBqc
         ZZj8JVPNGEWHyHxZgOBNL4iiF2vOzApFiqufTlM2/EZ0C4uNM7S6XcLqNDt34xO3N+G7
         KuDK8VjJO/tRGg66BRphEyinEj+iy3Ly1mTDvflzMjfNHldnPcKlZkIAlfIIRFGatD/D
         7ccyMkJKacDSLOnpGVgbb/n2hoaVk/ayop78E+SWsmesilm15DqWiamjefiCPjDYyvmz
         ivPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hAsIRHvvpbi9rt/0W0BIpJsAiPhpdF9DzTF7MWukEo=;
        b=Uy5UXV3hRud4PGGSmtzozAzoUjaXvDohsuqSNUouqrSA2v66yBEb4EFtmn/cb9vzC1
         snCeUy5clFdRjGpKdilQziG7qBYvLYjSR1QpyEpiYR4JLlHmxKqwjxGCDsjEqvTi+e+r
         YT8ABUUwILOlyrqWz1tsIBIjpAZaBofm4nX44gQ3TGmAMiYVBhflghBrEMXmft7Jmibe
         xOxAiedqYfeK8eG2XkK6034lcIK/8mYkTE9wOGyf2bFZzgUMeNNUsfuBHoc7OcdeFOdh
         Wwqn6ZGSSgGwJE+aYHi0Jp+M9ie65bAgES67woz7dFpmiOU2YqOhHWxjy7yl/tJJT218
         hygg==
X-Gm-Message-State: APjAAAVwy/nAFZ+iGNwUAoYHek+Ct8gPvXHZqHk7iZ6w25ck3Hgy0bMs
        5dKRzUCa5QTPUaWM38nTrQAv+U617mx+kFWi4LgMeA==
X-Google-Smtp-Source: APXvYqyB1g28ziokD8TaCIEowARkDkHag634xZ0PYBC6lk0WvB8JgTYQ6kgB8A/dwCYa7XBhGmjNCjcVRl0Q06TnwKU=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr11611078otq.126.1581560903990;
 Wed, 12 Feb 2020 18:28:23 -0800 (PST)
MIME-Version: 1.0
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Feb 2020 18:28:12 -0800
Message-ID: <CAPcyv4j8ouOpaAEXELzKdr1m6cPWw=XOeRg4FqXPAgV3ZqUJoA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Memory Hierarchy: Enable target node lookups for
 reserved memory
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 7:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Changes since v3 [1]:
> - Cleanup numa_map_to_online_node() to remove redundant "if
>   (!node_online(node))" (Aneesh)
>
> [1]: http://lore.kernel.org/r/157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com
>
> ---
>
> Merge notes:
>
> x86 folks: This has an ack from Rafael for ACPI, and Michael for Power.
> With an x86 ack I plan to take this through the libnvdimm tree provided
> the x86 touches look ok to you.

Ping x86 folks. There's no additional changes identified for this
series. Can I request an ack to take it through libnvdimm.git? Do you
need a resend?

    x86/mm: Introduce CONFIG_KEEP_NUMA
    x86/numa: Provide a range-to-target_node lookup facility


>
> ---
>
> Cover:
>
> Arrange for platform numa info to be preserved for determining
> 'target_node' data. Where a 'target_node' is the node a reserved memory
> range will become when it is onlined.
>
> This new infrastructure is expected to be more valuable over time for
> Memory Tiers / Hierarchy management as more platforms (via the ACPI HMAT
> and EFI Specific Purpose Memory) publish reserved or "soft-reserved"
> ranges to Linux. Linux system administrators will expect to be able to
> interact with those ranges with a unique numa node number when/if that
> memory is onlined via the dax_kmem driver [2].
>
> One configuration that currently fails to properly convey the target
> node for the resulting memory hotplug operation is persistent memory
> defined by the memmap=nn!ss parameter. For example, today if node1 is a
> memory only node, and all the memory from node1 is specified to
> memmap=nn!ss and subsequently onlined, it will end up being onlined as
> node0 memory. As it stands, memory_add_physaddr_to_nid() can only
> identify online nodes and since node1 in this example has no online cpus
> / memory the target node is initialized node0.
>
> The fix is to preserve rather than discard the numa_meminfo entries that
> are relevant for reserved memory ranges, and to uplevel the node
> distance helper for determining the "local" (closest) node relative to
> an initiator node.
>
> [2]: https://pmem.io/ndctl/daxctl-reconfigure-device.html
>
> ---
>
> Dan Williams (6):
>       ACPI: NUMA: Up-level "map to online node" functionality
>       mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
>       powerpc/papr_scm: Switch to numa_map_to_online_node()
>       x86/mm: Introduce CONFIG_KEEP_NUMA
>       x86/numa: Provide a range-to-target_node lookup facility
>       libnvdimm/e820: Retrieve and populate correct 'target_node' info
>
>
>  arch/powerpc/platforms/pseries/papr_scm.c |   21 --------
>  arch/x86/Kconfig                          |    1
>  arch/x86/mm/numa.c                        |   74 +++++++++++++++++++++++------
>  drivers/acpi/numa/srat.c                  |   41 ----------------
>  drivers/nvdimm/e820.c                     |   18 ++-----
>  include/linux/acpi.h                      |   23 +++++++++
>  include/linux/numa.h                      |   23 +++++++++
>  mm/Kconfig                                |    5 ++
>  mm/mempolicy.c                            |   31 ++++++++++++
>  9 files changed, 145 insertions(+), 92 deletions(-)
