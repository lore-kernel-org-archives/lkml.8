Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B23FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7184B20772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgGBLA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgGBLA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:00:26 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2465020656;
        Thu,  2 Jul 2020 11:00:23 +0000 (UTC)
Date:   Thu, 2 Jul 2020 12:00:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH v6 1/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS'
 to vmcoreinfo
Message-ID: <20200702110003.GC22241@gaia>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-2-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589395957-24628-2-git-send-email-bhsharma@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 12:22:36AM +0530, Bhupesh Sharma wrote:
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 9f1557b98468..18175687133a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -413,6 +413,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>  	VMCOREINFO_STRUCT_SIZE(mem_section);
>  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>  #endif
>  	VMCOREINFO_STRUCT_SIZE(page);
>  	VMCOREINFO_STRUCT_SIZE(pglist_data);

I can queue this patch via the arm64 tree (together with the second one)
but I'd like an ack from the kernel/crash_core.c maintainers. They don't
seem to have been cc'ed either (only the kexec list).

Thanks.

-- 
Catalin
