Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B3C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B6021775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583342121;
	bh=3BAHdKYvFUM9UEqzWB1w6eTNvmMDduAiQlJNWOZUhrg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=puzobezoX8jCSpc05JRGfM6hbDW/5qmrDz9cvN9uHCP2ip+xKCIK+jsqeE113KAKd
	 fCjsOwsB5UnfIJ0nTu3rDCA+YMPzMm/JdRPBxiZqs4K8HbpB61fPyG/f1haSPaKxfR
	 37Njr8R6lVhlgky4ndX9lwshUSo11O+90EWVck1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgCDRPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgCDRPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:15:20 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9A320717;
        Wed,  4 Mar 2020 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583342120;
        bh=3BAHdKYvFUM9UEqzWB1w6eTNvmMDduAiQlJNWOZUhrg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xDxCJ2bvz9ngIAnJEzGGFDzMeRHLaK/8Wk1QHvIdXFQ5gMB5BvSsK0jKZXB8SKnKN
         +Wj2bBbdeBdpnNZ1A6y26qH9XDeopwM1vqdBovhTnDan3Cu44z53zO+T0ChRG+uLAg
         CxQ8FlEs4lrAe3twYt9ksVy8rAPhcwkTbZ7Dv6ak=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D9A4F3522731; Wed,  4 Mar 2020 09:15:19 -0800 (PST)
Date:   Wed, 4 Mar 2020 09:15:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/3] kcsan: Fix a typo in a comment
Message-ID: <20200304171519.GB2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200304162541.46663-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304162541.46663-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 05:25:39PM +0100, Marco Elver wrote:
> From: Qiujun Huang <hqjagain@gmail.com>
> 
> s/slots slots/slots/
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> [elver: commit message]
> Signed-off-by: Marco Elver <elver@google.com>

Applied for review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/kcsan/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index eb30ecdc8c009..ee8200835b607 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -45,7 +45,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
>  };
>  
>  /*
> - * Helper macros to index into adjacent slots slots, starting from address slot
> + * Helper macros to index into adjacent slots, starting from address slot
>   * itself, followed by the right and left slots.
>   *
>   * The purpose is 2-fold:
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
