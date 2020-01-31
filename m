Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC389C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BF4205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgAaNUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:20:03 -0500
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:21495
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728579AbgAaNUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:20:03 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AlAACzKDRe/zXSMGcNWBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBe4F9gRiBMYQUj1kBAQEBAQEGgRIliW+RSQk?=
 =?us-ascii?q?BAQEBAQEBAQErDAEBhEACglQ4EwIQAQEBBAEBAQEBBQMBhVhMhXIBAQEBAgE?=
 =?us-ascii?q?jFUEFCwsNCwICJgICVwYBDAYCAQGDIgGCVgUvrCh1gTIahBsBgRSDOIE4BoE?=
 =?us-ascii?q?OKoFlilV5gQeBOAyCYD6HWYJeBI1diVqYKQiCPYdFhUeJLSGCSIgNhDUDi3i?=
 =?us-ascii?q?OYIhnlEKBejMaCCgIgycTPY9pAQiHV4VRYgIBjkYBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AlAACzKDRe/zXSMGcNWBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBe4F9gRiBMYQUj1kBAQEBAQEGgRIliW+RSQkBAQEBAQEBAQErD?=
 =?us-ascii?q?AEBhEACglQ4EwIQAQEBBAEBAQEBBQMBhVhMhXIBAQEBAgEjFUEFCwsNCwICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGDIgGCVgUvrCh1gTIahBsBgRSDOIE4BoEOKoFlilV5gQeBO?=
 =?us-ascii?q?AyCYD6HWYJeBI1diVqYKQiCPYdFhUeJLSGCSIgNhDUDi3iOYIhnlEKBejMaC?=
 =?us-ascii?q?CgIgycTPY9pAQiHV4VRYgIBjkYBAQ?=
X-IronPort-AV: E=Sophos;i="5.70,385,1574092800"; 
   d="scan'208";a="280751624"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 31 Jan 2020 21:19:59 +0800
Subject: Re: [PATCH -v2 00/10] Rewrite Motorola MMU page-table layout
To:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>
References: <20200131124531.623136425@infradead.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <9fe6925a-52e5-7104-dae6-3ad97c4bbecc@linux-m68k.org>
Date:   Fri, 31 Jan 2020 23:19:58 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131124531.623136425@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 31/1/20 10:45 pm, Peter Zijlstra wrote:
> In order to faciliate Will's READ_ONCE() patches:
> 
>    https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
> 
> we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
> are tested using ARAnyM/68040.
> 
> Michael tested the previous version on his Atari Falcon/68030.
> 
> Build tested for sun3/coldfire.

Thanks for the quick turn around. Build looks good for me too with
this new series. I will test on real hardware on Monday.

Regards
Greg


> Please consider!
> 
> Changes since -v1:
>   - fixed sun3/coldfire build issues
>   - unified motorola mmu page setup
>   - added enum to table allocator
>   - moved pointer table allocator to motorola.c
>   - converted coldfire pgtable_t
>   - fixed coldfire pgd_alloc
>   - fixed coldfire nocache
> 
> ---
>   arch/m68k/include/asm/mcf_pgalloc.h      |  31 ++---
>   arch/m68k/include/asm/motorola_pgalloc.h |  74 ++++------
>   arch/m68k/include/asm/motorola_pgtable.h |  36 +++--
>   arch/m68k/include/asm/page.h             |  16 ++-
>   arch/m68k/include/asm/pgtable_mm.h       |  10 +-
>   arch/m68k/mm/init.c                      |  34 +++--
>   arch/m68k/mm/kmap.c                      |  36 +++--
>   arch/m68k/mm/memory.c                    | 103 --------------
>   arch/m68k/mm/motorola.c                  | 228 +++++++++++++++++++++++++------
>   9 files changed, 302 insertions(+), 266 deletions(-)
> 
> 
