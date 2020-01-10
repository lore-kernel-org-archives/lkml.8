Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F6CC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4774C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgAJPey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:34:54 -0500
Received: from foss.arm.com ([217.140.110.172]:46888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgAJPey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:34:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5ACC30E;
        Fri, 10 Jan 2020 07:34:53 -0800 (PST)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB7993F6C4;
        Fri, 10 Jan 2020 07:34:52 -0800 (PST)
Date:   Fri, 10 Jan 2020 15:34:48 +0000
From:   Steven Price <steven.price@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH -next] arm64/mm/dump: fix a compilation error
Message-ID: <20200110153447.GA30104@arm.com>
References: <20200110145112.7959-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110145112.7959-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 02:51:12PM +0000, Qian Cai wrote:
> The linux-next commit "x86: mm: avoid allocating struct mm_struct on the
> stack" [1] introduced a compilation error with "arm64: mm: convert
> mm/dump.c to use walk_page_range()" [2]. Fixed it by using the new API.
> 
> arch/arm64/mm/dump.c:326:38: error: too few arguments to function call,
> expected 3, have 2
>         ptdump_walk_pgd(&st.ptdump, info->mm);
>         ~~~~~~~~~~~~~~~                     ^
> ./include/linux/ptdump.h:20:1: note: 'ptdump_walk_pgd' declared here
> void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm,
> pgd_t *pgd);
> ^
> arch/arm64/mm/dump.c:364:38: error: too few arguments to function call,
> expected 3, have 2
>         ptdump_walk_pgd(&st.ptdump, &init_mm);
>         ~~~~~~~~~~~~~~~                     ^
> ./include/linux/ptdump.h:20:1: note: 'ptdump_walk_pgd' declared here
> void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm,
> pgd_t *pgd);
> ^
> 2 errors generated.
> 
> [1] http://lkml.kernel.org/r/20200108145710.34314-1-steven.price@arm.com

Actually this was in the patch I originally posted - somehow it got
lost when Andrew picked it up.

> [2] http://lkml.kernel.org/r/20191218162402.45610-22-steven.price@arm.com
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Since this matches what I originally wrote... ;)

Reviewed-by: Steven Price <steven.price@arm.com>

Steve

> ---
>  arch/arm64/mm/dump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index ef4b3ca1e058..860c00ec8bd3 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -323,7 +323,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>  		}
>  	};
>  
> -	ptdump_walk_pgd(&st.ptdump, info->mm);
> +	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
>  }
>  
>  static void ptdump_initialize(void)
> @@ -361,7 +361,7 @@ void ptdump_check_wx(void)
>  		}
>  	};
>  
> -	ptdump_walk_pgd(&st.ptdump, &init_mm);
> +	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
>  
>  	if (st.wx_pages || st.uxn_pages)
>  		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",
> -- 
> 2.21.0 (Apple Git-122.2)
> 
