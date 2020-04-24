Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D9EC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC5120776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgDXKLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:11:41 -0400
Received: from foss.arm.com ([217.140.110.172]:58994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgDXKLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:11:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E9151FB;
        Fri, 24 Apr 2020 03:11:40 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41323F73D;
        Fri, 24 Apr 2020 03:11:38 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:11:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] arm64/mm: Reject invalid NUMA option
Message-ID: <20200424101132.GC1167@C02TD0UTHF1T.local>
References: <20200424045314.16017-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424045314.16017-1-gshan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Steve, who added str_has_prefix()]

On Fri, Apr 24, 2020 at 02:53:14PM +1000, Gavin Shan wrote:
> The NUMA option is parsed by str_has_prefix() and the invalid option
> like "numa=o" can be regarded as "numa=off" wrongly.

Are you certain that can pass? If that can happen, str_has_prefix() is
misnamed and does not seem to do what its kerneldoc says it does, as
"off" is not a prefix of "o".

> This fixes the issue with sysfs_streq(), which have more sanity checks,
> to avoid accepting the invalid options.

That doesn't sound immediately right, since this is an early parameter,
which has nothing to do with sysfs. Perhaps that's just a misleading
name?

Thanks,
Mark.

> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/mm/numa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 4decf1659700..bd458b28616a 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -29,7 +29,8 @@ static __init int numa_parse_early_param(char *opt)
>  {
>  	if (!opt)
>  		return -EINVAL;
> -	if (str_has_prefix(opt, "off"))
> +
> +	if (sysfs_streq(opt, "off"))
>  		numa_off = true;
>  
>  	return 0;
> -- 
> 2.23.0
> 
