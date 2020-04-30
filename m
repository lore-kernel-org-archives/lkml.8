Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98EBC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41B72076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgD3LTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:19:44 -0400
Received: from foss.arm.com ([217.140.110.172]:52802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgD3LTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:19:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C34AE31B;
        Thu, 30 Apr 2020 04:19:43 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.22.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBCE63F305;
        Thu, 30 Apr 2020 04:19:41 -0700 (PDT)
Date:   Thu, 30 Apr 2020 12:19:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH] arm64: kexec_file: print appropriate variable
Message-ID: <20200430111923.GB40114@C02TD0UTHF1T.local>
References: <CGME20200430105048eucas1p129975fe3fd84c4fd2b14117e3474b203@eucas1p1.samsung.com>
 <20200430105034.17513-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430105034.17513-1-l.stelmach@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:50:34PM +0200, Łukasz Stelmach wrote:
> Fixes: 4312057681929 ("arm64: kexec_file: load initrd and device-tree")

This commit ID is bogus (doesn't exist in mainline or the arm64 tree).

The upstream commit ID seems to be: 52b2a8af7436044cfcb27e4b0f72c2ce1f3890da

As will said, this needs a commit message. Please explain what you think
is wrong here.

Also, when sending a fix, *please* Cc the author of the original patch.

I've added parties relevant to the original patch (Takahiro and James).

> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index b40c3b0def92..2776bdaa83a5 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -332,7 +332,7 @@ int load_other_segments(struct kimage *image,
>  	image->arch.dtb_mem = kbuf.mem;
>  
>  	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> -			kbuf.mem, dtb_len, dtb_len);
> +			kbuf.mem, dtb_len, kbuf.memsz);

It's worth noting that we follow the same pattern repeatedly in this
file, so if you think this instance is wrong you should consider whether
the others are correct.

Earlier in this file we have:

|	pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
|		 image->arch.elf_headers_mem, headers_sz, headers_sz)

|	pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
|		 initrd_load_addr, initrd_len, initrd_len);

... and it looks like x86 does similar in kexec-bzimage64.c, for some
sort of consistency with the old kexec logging.

If <foo>_len and kbuf.memsz can differ, we should log that in all cases.
If not, we should remove the redundant logging.

Thanks,
Mark.
