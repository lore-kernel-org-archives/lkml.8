Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DCFC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E932076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCRJaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:30:46 -0400
Received: from foss.arm.com ([217.140.110.172]:47240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgCRJaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:30:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B99D31B;
        Wed, 18 Mar 2020 02:30:45 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F30B33F52E;
        Wed, 18 Mar 2020 02:30:43 -0700 (PDT)
Date:   Wed, 18 Mar 2020 09:30:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     =?utf-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Cc:     Zheng Wei <wei.zheng@vivo.com>, Hanjun Guo <guohanjun@huawei.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com, Will Deacon <will@kernel.org>
Subject: Re: Re: [PATCH] arm64: add blank after 'if'
Message-ID: <20200318093041.GR3005@mbp>
References: <20200317222823.GG20788@willie-the-truck>
 <AG*ACQC2CEOOiVKFwxZXw4qM.3.1584509548085.Hmail.wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AG*ACQC2CEOOiVKFwxZXw4qM.3.1584509548085.Hmail.wenhu.wang@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 01:32:28PM +0800, 王文虎 wrote:
> From: Will Deacon <will@kernel.org>
> Date: 2020-03-18 06:28:24
> To:  Zheng Wei <wei.zheng@vivo.com>
> Cc:  Catalin Marinas <catalin.marinas@arm.com>,Hanjun Guo <guohanjun@huawei.com>,Enrico Weigelt <info@metux.net>,Allison Randal <allison@lohutok.net>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,Thomas Gleixner <tglx@linutronix.de>,Yunfeng Ye <yeyunfeng@huawei.com>,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,kernel@vivo.com,wenhu.wang@vivo.com
> Subject: Re: [PATCH] arm64: add blank after 'if'>On Fri, Mar 13, 2020 at 10:54:02PM +0800, Zheng Wei wrote:
> >> add blank after 'if' for armv8_deprecated_init()
> >> to make it comply with kernel coding style.
> >> 
> >> Signed-off-by: Zheng Wei <wei.zheng@vivo.com>
> >> ---
> >>  arch/arm64/kernel/armv8_deprecated.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> >> index 7832b3216370..4cc581af2d96 100644
> >> --- a/arch/arm64/kernel/armv8_deprecated.c
> >> +++ b/arch/arm64/kernel/armv8_deprecated.c
> >> @@ -630,7 +630,7 @@ static int __init armv8_deprecated_init(void)
> >>  		register_insn_emulation(&cp15_barrier_ops);
> >>  
> >>  	if (IS_ENABLED(CONFIG_SETEND_EMULATION)) {
> >> -		if(system_supports_mixed_endian_el0())
> >> +		if (system_supports_mixed_endian_el0())
> >>  			register_insn_emulation(&setend_ops);
> >>  		else
> >>  			pr_info("setend instruction emulation is not supported on this system\n");
> >
> >(Catalin: I'm just acking these trivial typo/style fixes to get them out
> >of my inbox; do whatever you like with them ;)
> >
> >Acked-by: Will Deacon <will@kernel.org>
> >
> >Will
> 
> Shouldn't you have Cc trivial<trivial@kernel.org>?
> Asked-by: Wang Wenhu <wenhu.wang@vivo.com>

I queued them already, they are in arm64 for-next/core. In the future,
it they could as well go in via trivial@kernel.org (as long as there are
no serious conflicts).

-- 
Catalin
