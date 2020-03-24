Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFD7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F53F2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgCXSol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgCXSok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:44:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B969B2074D;
        Tue, 24 Mar 2020 18:44:37 +0000 (UTC)
Date:   Tue, 24 Mar 2020 14:44:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     <will@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <peterz@infradead.org>, <arnd@arndb.de>, <maz@kernel.org>,
        <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
Subject: Re: [RFC PATCH v4 4/6] mm: Add page table level flags to vm_flags
Message-ID: <20200324144436.043659c2@gandalf.local.home>
In-Reply-To: <20200324134534.1570-5-yezhenyu2@huawei.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
        <20200324134534.1570-5-yezhenyu2@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 21:45:32 +0800
Zhenyu Ye <yezhenyu2@huawei.com> wrote:

> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -130,6 +130,16 @@ IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
>  #define IF_HAVE_VM_SOFTDIRTY(flag,name)
>  #endif
>  
> +#ifdef CONFIG_64BIT
> +#define IF_HAVE_VM_LEVEL_PUD(flag,name)	{flag, name}
> +#define IF_HAVE_VM_LEVEL_PMD(flag,name)	{flag, name}
> +#define IF_HAVE_VM_LEVEL_PTE(flag,name)	{flag, name}
> +#else
> +#define IF_HAVE_VM_LEVEL_PUD(flag,name)
> +#define IF_HAVE_VM_LEVEL_PMD(flag,name)
> +#define IF_HAVE_VM_LEVEL_PTE(flag,name)
> +#endif
> +
>  #define __def_vmaflag_names						\
>  	{VM_READ,			"read"		},		\
>  	{VM_WRITE,			"write"		},		\
> @@ -161,7 +171,10 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
>  	{VM_MIXEDMAP,			"mixedmap"	},		\
>  	{VM_HUGEPAGE,			"hugepage"	},		\
>  	{VM_NOHUGEPAGE,			"nohugepage"	},		\
> -	{VM_MERGEABLE,			"mergeable"	}		\
> +	{VM_MERGEABLE,			"mergeable"	},		\
> +IF_HAVE_VM_LEVEL_PUD(VM_LEVEL_PUD,	"pud-level"	),		\
> +IF_HAVE_VM_LEVEL_PMD(VM_LEVEL_PMD,	"pmd-level"	),		\
> +IF_HAVE_VM_LEVEL_PTE(VM_LEVEL_PTE,	"pte-level"	)		\
>  

Have you tested this on 32bit? It looks like you'll get empty commas there.
Perhaps the defines need to be:

#ifdef CONFIG_64BIT
#define IF_HAVE_VM_LEVEL_PUD(flag,name)	{flag, name},
#define IF_HAVE_VM_LEVEL_PMD(flag,name)	{flag, name},
#define IF_HAVE_VM_LEVEL_PTE(flag,name)	{flag, name}
#else
#define IF_HAVE_VM_LEVEL_PUD(flag,name)
#define IF_HAVE_VM_LEVEL_PMD(flag,name)
#define IF_HAVE_VM_LEVEL_PTE(flag,name)
#endif

And leave out the commas in the list.

-- Steve
