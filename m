Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D045C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7511B2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+yPPzat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgG1CdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:33:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21939 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbgG1CdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595903580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2Dgok5d4kIn9F8q0n3JSRWupAQ4Bqg6yV879GUqY3s=;
        b=U+yPPzat2nnoFPkxRwAeN/jmpad9WrPGxs5nrMxPiJ2VlhBZ3sPLvZsmgeIEZGlQzBSwnQ
        6Hd/XniV87pI4dkwH/8bRsyvdX8riyBn5uxzzHcpx0x10F2K+iuH0HLKSaMCpt+SNN4RIm
        TpZpbaI8p4n3PS/y8f5nX1+b6vPlAnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-9BMR-vUtOkSbC6hRJHCq1Q-1; Mon, 27 Jul 2020 22:32:58 -0400
X-MC-Unique: 9BMR-vUtOkSbC6hRJHCq1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FA4D800688;
        Tue, 28 Jul 2020 02:32:56 +0000 (UTC)
Received: from [10.72.8.32] (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC21A5F1EA;
        Tue, 28 Jul 2020 02:32:45 +0000 (UTC)
Subject: Re: [RESEND PATCH v5 00/11] ppc64: enable kdump support for
 kexec_file_load syscall
To:     Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
Cc:     kernel test robot <lkp@intel.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
From:   piliu <piliu@redhat.com>
Message-ID: <23911b9d-7534-031c-6f98-80f90439c834@redhat.com>
Date:   Tue, 28 Jul 2020 10:32:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <159579157320.5790.6748078824637688685.stgit@hbathini>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/27/2020 03:36 AM, Hari Bathini wrote:
> Sorry! There was a gateway issue on my system while posting v5, due to
> which some patches did not make it through. Resending...
> 
> This patch series enables kdump support for kexec_file_load system
> call (kexec -s -p) on PPC64. The changes are inspired from kexec-tools
> code but heavily modified for kernel consumption.
> 
> The first patch adds a weak arch_kexec_locate_mem_hole() function to
> override locate memory hole logic suiting arch needs. There are some
> special regions in ppc64 which should be avoided while loading buffer
> & there are multiple callers to kexec_add_buffer making it complicated
> to maintain range sanity and using generic lookup at the same time.
> 
> The second patch marks ppc64 specific code within arch/powerpc/kexec
> and arch/powerpc/purgatory to make the subsequent code changes easy
> to understand.
> 
> The next patch adds helper function to setup different memory ranges
> needed for loading kdump kernel, booting into it and exporting the
> crashing kernel's elfcore.
> 
> The fourth patch overrides arch_kexec_locate_mem_hole() function to
> locate memory hole for kdump segments by accounting for the special
> memory regions, referred to as excluded memory ranges, and sets
> kbuf->mem when a suitable memory region is found.
> 
> The fifth patch moves walk_drmem_lmbs() out of .init section with
> a few changes to reuse it for setting up kdump kernel's usable memory
> ranges. The next patch uses walk_drmem_lmbs() to look up the LMBs
> and set linux,drconf-usable-memory & linux,usable-memory properties
> in order to restrict kdump kernel's memory usage.
> 
> The seventh patch updates purgatory to setup r8 & r9 with opal base
> and opal entry addresses respectively to aid kernels built with
> CONFIG_PPC_EARLY_DEBUG_OPAL enabled. The next patch setups up backup
> region as a kexec segment while loading kdump kernel and teaches
> purgatory to copy data from source to destination.
> 
> Patch 09 builds the elfcore header for the running kernel & passes
> the info to kdump kernel via "elfcorehdr=" parameter to export as
> /proc/vmcore file. The next patch sets up the memory reserve map
> for the kexec kernel and also claims kdump support for kdump as
> all the necessary changes are added.
> 
> The last patch fixes a lookup issue for `kexec -l -s` case when
> memory is reserved for crashkernel.
> 
> Tested the changes successfully on P8, P9 lpars, couple of OpenPOWER
> boxes, one with secureboot enabled, KVM guest and a simulator.
> 
> v4 -> v5:
> * Dropped patches 07/12 & 08/12 and updated purgatory to do everything
>   in assembly.
I guess you achieve this by carefully selecting instruction to avoid
relocation issue, right?

Thanks,
Pingfan

