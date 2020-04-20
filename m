Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4DFC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1902145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDTKRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:17:05 -0400
Received: from foss.arm.com ([217.140.110.172]:46116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTKRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:17:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B8BD30E;
        Mon, 20 Apr 2020 03:17:04 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FC0E3F73D;
        Mon, 20 Apr 2020 03:17:03 -0700 (PDT)
Date:   Mon, 20 Apr 2020 11:16:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] arm64: entry: remove unneeded semicolon in
 el1_sync_handler()
Message-ID: <20200420101657.GA69441@C02TD0UTHF1T.local>
References: <20200418081909.41471-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418081909.41471-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 04:19:09PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> arch/arm64/kernel/entry-common.c:97:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/entry-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index c839b5bf1904..bed09a866c2f 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -94,7 +94,7 @@ asmlinkage void notrace el1_sync_handler(struct pt_regs *regs)
>  		break;
>  	default:
>  		el1_inv(regs, esr);
> -	};
> +	}
>  }
>  NOKPROBE_SYMBOL(el1_sync_handler);
>  
> -- 
> 2.21.1
> 
