Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B3BC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3934C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBQIXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:23:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58892 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBQIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:23:08 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j3bg9-0005ux-16; Mon, 17 Feb 2020 09:22:57 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 91A8C100617; Mon, 17 Feb 2020 09:22:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        kbuild test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>, vishal.l.verma@intel.com,
        hch@lst.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 5/6] x86/NUMA: Provide a range-to-target_node lookup facility
In-Reply-To: <158188326978.894464.217282995221175417.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158188324272.894464.5941332130956525504.stgit@dwillia2-desk3.amr.corp.intel.com> <158188326978.894464.217282995221175417.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Mon, 17 Feb 2020 09:22:56 +0100
Message-ID: <87y2t1pqqn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> The DEV_DAX_KMEM facility is a generic mechanism to allow device-dax
> instances, fronting performance-differentiated-memory like pmem, to be
> added to the System RAM pool. The NUMA node for that hot-added memory is
> derived from the device-dax instance's 'target_node' attribute.
>
> Recall that the 'target_node' is the ACPI-PXM-to-node translation for
> memory when it comes online whereas the 'numa_node' attribute of the
> device represents the closest online cpu node.
>
> Presently useful target_node information from the ACPI SRAT is discarded
> with the expectation that "Reserved" memory will never be onlined. Now,
> DEV_DAX_KMEM violates that assumption, there is a need to retain the
> translation. Move, rather than discard, numa_memblk data to a secondary
> array that memory_add_physaddr_to_target_node() may consider at a later
> point in time.
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
